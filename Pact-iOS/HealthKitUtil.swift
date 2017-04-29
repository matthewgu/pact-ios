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
    static var sharedInstance = HealthKitUtil()
    private init() {} // Singleton
    
    lazy var healthStore = HKHealthStore()
    
    internal func getStep(completion: @escaping (_ success: Bool, _ totalSteps: Int) -> Void)
    {
        // Define the step quantity Type
        guard let qualityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(false, 0)
            return
        }
        
        // Set end date (=now)
        let toDt = Date()
        
        // Get start date
        guard let fromDt = self.getFromDate(toDate: toDt) else { return }
        
        // Set the Predicates & Interval
        let predicate = HKQuery.predicateForSamples(withStart: fromDt, end: toDt, options: .strictStartDate)
        
        // Interval
        let interval = self.getDateComponent(fromDate: fromDt, toDate: toDt)
        
        // Perform the Query
        let query = HKStatisticsCollectionQuery(quantityType: qualityType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: fromDt, intervalComponents: interval)
        
        // Result handler
        query.initialResultsHandler = { query, results, error in
            
            if error != nil {
                completion(false, 0)
                return
            }
            
            // Count up step
            var steps = 0 as Double
            if let rst = results {
                rst.enumerateStatistics(from: fromDt, to: toDt) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity()
                    {
                        // Add steps
                        steps += quantity.doubleValue(for: HKUnit.count())
                        print("⭐️\(steps) pts, From \(statistics.startDate) to \(statistics.endDate).")
                    }
                }
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
    
    private func getFromDate(toDate: Date) -> Date?
    {
        // If the last fetched Data was not set in the userDefault
        if UserAccount.sharedInstance.fromDate == 0.0
        {
            // Set start date(=3 days ago)
            guard let dt = Calendar.current.date(byAdding: .day, value: -3, to: toDate) else {
                return nil
            }
            
            // Save fromDate
            UserAccount.sharedInstance.fromDate = dt.timeIntervalSince1970
            
            return dt
        }
        else
        {
            // Get last fetched date as double since we are saved date as timeStamp
            let lastFetchedDataTypeDouble = UserAccount.sharedInstance.fromDate
            
            // Convert double(timestamp) to Date
            let fromData = Date(timeIntervalSince1970: lastFetchedDataTypeDouble)
            
            // Set start date(=Last fetched date)
            return fromData
        }
    }
}
