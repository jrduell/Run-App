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
