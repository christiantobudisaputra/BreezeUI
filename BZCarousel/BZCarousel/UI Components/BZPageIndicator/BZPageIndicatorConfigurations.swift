//
//  BZPageIndicatorConfigurations.swift
//  BCarousel
//
//  Created by Christianto Budisaputra on 1/13/23.
//

import SwiftUI

extension BZPageIndicator {
    class Configurations {
        enum Presentation {
            case autoSlide(timeInterval: TimeInterval)
            case idle
        }

        enum IndicatorShape {
            case circle(size: IndicatorSize)
            case line(size: IndicatorSize)
            case roundedLine(size: IndicatorSize)
        }

        enum IndicatorSize: CGFloat {
            case small = 6
            case normal = 8
            case large = 12
        }

        var indicatorShape: IndicatorShape
        var activeIndicatorColor: Color
        var inactiveIndicatorColor: Color
        var presentation: Presentation

        init(
            indicatorShape: IndicatorShape = .circle(size: .normal),
            activeIndicatorColor: Color,
            inactiveIndicatorColor: Color = .secondary.opacity(0.25),
            presentation: Presentation
        ) {
            self.indicatorShape = indicatorShape
            self.activeIndicatorColor = activeIndicatorColor
            self.inactiveIndicatorColor = inactiveIndicatorColor
            self.presentation = presentation
        }

        func makeIdle() {
            presentation = .idle
        }
    }
}
