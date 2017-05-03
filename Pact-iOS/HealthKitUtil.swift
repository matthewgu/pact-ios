//
//  HealthKitUtil.swift
//  Pact-iOS
//
//  Created by matt on 2017-04-28.
//  Copyright © 2017 matt. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitUtil
{
    static var shared = HealthKitUtil()
    private init() {} // Singleton
    
    lazy var healthStore = HKHealthStore()
    
    internal func getStep(completion: @escaping (_ success: Bool, _ newSteps: Int) -> Void)
    {
        
        // Define the step quantity Type
        guard let qualityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(false, 0)
            return
        }
        
        
        // Get from date
        guard let fromDt = self.getFromDate() else { return }
        
        // Set to date (=now)
        let toDt = self.convertToStepValidDate(date: Date())
        
        // Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: fromDt, end: toDt, options: .strictEndDate)
        
        // Interval
        let interval = self.getDateComponent(fromDate: fromDt, toDate: toDt)
        
        // Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: qualityType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: toDt, intervalComponents: interval)
        
        // Result handler
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                completion(false, 0)
                return
            }
            
            // Count up step
            print("🌟Specified data range")
            print("    <From> \(fromDt) \n    <To> \(toDt).")
            var steps = 0 as Double
            if let rst = results {
                rst.enumerateStatistics(from: fromDt, to: toDt) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity()
                    {
                        // If previous fetch date match with current fetch date
                        if UserAccount.shared.previousToDate > 0.0 &&
                            UserAccount.shared.previousStatisticsEndDate == statistics.endDate.timeIntervalSince1970
                        {
                            // Remove previous fetched steps
                            UserAccount.shared.totalSteps -= UserAccount.shared.previousSteps
                        }
                        
                        // Save the fetched result
                        UserAccount.shared.previousSteps = Int(quantity.doubleValue(for: HKUnit.count()))
                        UserAccount.shared.previousFromDate = fromDt.timeIntervalSince1970
                        UserAccount.shared.previousToDate = toDt.timeIntervalSince1970
                        UserAccount.shared.previousStatisticsEndDate = statistics.endDate.timeIntervalSince1970
                        
                        // Add steps
                        steps += quantity.doubleValue(for: HKUnit.count())
                        print("🌟Fetched data range")
                        print("    <Statistics From> \(statistics.startDate) \n    <Statistics To> \(statistics.endDate).")
                        print("    <new steps>: " + "\(steps)")
                        print("    <past steps>: " + "\(UserAccount.shared.totalSteps)")
                    }
                }
                print("+++++++++++++++++++++++++++++++++++")
            }
            
            completion(true, Int(steps))
        }
        
        healthStore.execute(query)
    }
    
    
    // MARK: - Suppport
    private func getDateComponent(fromDate: Date, toDate: Date) -> DateComponents
    {
        let diff: DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fromDate, to: toDate)
        
        var interval = DateComponents()
        interval.second = 1
        if diff.year ?? 0 >= 1 {
            interval.year = (diff.year ?? 1) == 0 ? 1 : (diff.year ?? 1)
        }
        if diff.month ?? 0 >= 1 {
            interval.month = (diff.month ?? 1) == 0 ? 1 : (diff.month ?? 1)
        }
        if diff.day ?? 0 >= 1 {
            interval.day = (diff.day ?? 1) == 0 ? 1 : (diff.day ?? 1)
        }
        if diff.hour ?? 0 >= 1 {
            interval.hour = (diff.hour ?? 1) == 0 ? 1 : (diff.hour ?? 1)
        }
        if diff.minute ?? 0 >= 1 {
            interval.minute = (diff.minute ?? 1) == 0 ? 1 : (diff.minute ?? 1)
        }
        if diff.second ?? 0 < 60 {
            interval.second = (diff.second ?? 1) == 0 ? 1 : (diff.second ?? 1)
        }
        
        return interval
    }
    
    internal func checkAuthorization(completion: @escaping (_ anthorized: Bool) -> Void)
    {
        // Check if healthKit is available
        if HKHealthStore.isHealthDataAvailable()
        {
            // Get quality type
            guard let qualityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                completion(false)
                return
            }
            
            // Check authorization
            healthStore.requestAuthorization(toShare: nil, read: [qualityType]) { (success, error) -> Void in
                if error != nil {
                    completion(false)
                    return
                }
                
                if !success {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
        else
        {
            completion(false)
        }
    }
    
    private func getFromDate() -> Date?
    {
        // If the last fetched Data was not set in the userDefault
        if UserAccount.shared.previousToDate == 0.0
        {
            // Convert to appropriate from date (eg. 00:00:01 ~ 00:01:00 => convert to "00:00:00")
            let nowDt = Date()
            let fromDt = self.convertToStepValidDate(date: nowDt)
            
            // Set start date(=3 days ago)
            return Calendar.current.date(byAdding: .day, value: -3, to: fromDt) ?? nowDt
        }
        
        // Get last fetched date as double since we are saved date as timeStamp
        let lastFetchedDataTypeDouble = UserAccount.shared.previousToDate
        
        // Convert double(timestamp) to Date
        let fromData = Date(timeIntervalSince1970: lastFetchedDataTypeDouble)
        
        return self.convertToStepValidDate(date: fromData)
    }
    
    private func convertToStepValidDate(date: Date) -> Date
    {
        // Convert to appropriate from date (eg. 00:00:00 ~ 00:00:59 => convert to "00:00:01")
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        components.second = 1
        return Calendar.current.date(from: components) ?? date
    }
}
