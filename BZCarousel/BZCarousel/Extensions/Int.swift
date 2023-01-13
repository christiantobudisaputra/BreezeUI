//
//  Int.swift
//  BZCarousel
//
//  Created by Christianto Budisaputra on 1/13/23.
//

import Foundation

extension Int {
    mutating func increment(within range: ClosedRange<Int>) {
        self = (self + 1) % (range.upperBound - range.lowerBound) + range.lowerBound
    }

    mutating func decrement(within range: ClosedRange<Int>) {
        let upperBound: Int = (range.upperBound - range.lowerBound)
        self = (self - 1 + upperBound) % upperBound + range.lowerBound
    }
}
