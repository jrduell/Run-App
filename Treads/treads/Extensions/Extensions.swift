//
//  Extensions.swift
//  treads
//
//  Created by Jacob Duell on 12/30/20.
//

import Foundation

extension Double {
    func metersToMiles(decimalAccuracy: Int) -> Double {
        let divisor = pow(10.0, Double(decimalAccuracy))
        return ((self / 1609.34) * divisor).rounded() / divisor
    }
}

extension Int {
    func stringTimeFormatHHMMSS() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = (self % 3600) % 60
        
        if durationSeconds < 0 {
            return "00:00:00"
        } else {
            if durationHours == 0 {
                return String(format: "%02d:%02d", durationMinutes, durationSeconds)
            } else {
                return String(format: "%02d:%02d:%02d", durationHours, durationMinutes, durationSeconds)
            }
        }
    }
}
