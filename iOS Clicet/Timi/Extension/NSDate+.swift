//
//  NSDate+.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

extension Date{
    static func intervalToChinaCalander(_ interval:TimeInterval) ->String{
        let date = Date(timeIntervalSince1970: interval)
        let cal = Calendar.current
        let calCom = (cal as NSCalendar).components([.year, .month, .day], from: date)
        let currentDate = "\(calCom.year)年\(calCom.month)月\(calCom.day)日"
        return currentDate
    }
    static func intervalToDateComponent(_ interval:TimeInterval) -> DateComponents {
        let date = Date(timeIntervalSince1970: interval)
        return dateToDateComponent(date)
    }
    static func dateToDateComponent(_ date:Date) -> DateComponents{
        let cal = Calendar.current
        let calCom = (cal as NSCalendar).components([.year, .month, .day], from: date)
        return calCom
    }
    
    static func numberOfDaysInMonthWithDate(_ date:Date)->Int{
        let comp = (Calendar.current as NSCalendar).range(of: .day, in: .month, for: date)
        return comp.length
    }
    static func numberOfDaysInMonthWithInterval(_ interval:TimeInterval)->Int{
        let date = Date(timeIntervalSince1970: interval)
        return numberOfDaysInMonthWithDate(date)
    }
    static func getFirstDayOfMonthWithDate(_ date:Date)->Date?{
        let cal = Calendar.current
        var comp = (cal as NSCalendar).components([.year, .month, .day], from: date)
        comp.day = 1
        return cal.date(from: comp)
    }
}

