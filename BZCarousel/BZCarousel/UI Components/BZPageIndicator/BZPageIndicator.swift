//
//  BZPageIndicator.swift
//  BCarousel
//
//  Created by Christianto Budisaputra on 1/12/23.
//

import Combine
import SwiftUI

struct BZPageIndicator: View {
    @EnvironmentObject private var carouselEvents: BZCarouselEvent

    private let configurations: Configurations
    private let numberOfPages: Int

    @Binding private var currentIndex: Int
    @State private var timer: AnyCancellable?
    @State private var anyCancellable: AnyCancellable?

    init(numberOfPages: Int, currentIndex: Binding<Int>, configurations: Configurations) {
        _currentIndex = currentIndex

        if numberOfPages < 2 {
            configurations.makeIdle()
        }

        self.numberOfPages = numberOfPages
        self.configurations = configurations
    }

    var body: some View {
        HStack {
            ForEach(0 ..< numberOfPages, id: \.self) { index in
                indicatorShape()
                    .foregroundColor(
                        currentIndex == index
                            ? configurations.activeIndicatorColor
                            : configurations.inactiveIndicatorColor
                    )
                    .animation(.default)
            }
        }
        .onAppear {
            runAutoSlideIfNeeded()

            anyCancellable = carouselEvents.swipeEvent
                .print("swipe: ")
                .sink {
                    timer?.cancel()
                    runAutoSlideIfNeeded()
                }
        }
    }

    @ViewBuilder
    private func indicatorShape() -> some View {
        switch configurations.indicatorShape {
        case .circle(let indicatorSize):
            Circle()
                .frame(
                    width: indicatorSize.rawValue,
                    height: indicatorSize.rawValue
                )
        case .line(let indicatorSize):
            Rectangle()
                .frame(width: indicatorSize.rawValue * 1.5, height: 1.5)
        case .roundedLine(let indicatorSize):
            RoundedRectangle(cornerRadius: indicatorSize.rawValue / 2)
                .frame(width: indicatorSize.rawValue * 1.5, height: indicatorSize.rawValue / 2)
        }
    }

    private func runAutoSlideIfNeeded() {
        if case .autoSlide(let timeInterval) = configurations.presentation {
            timer = Timer
                .publish(every: timeInterval, on: .main, in: .default)
                .autoconnect()
                .print("timer: ")
                .sink { _ in
                    currentIndex.increment(within: 0 ... numberOfPages)
                }
        }
    }
}

struct PageIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        Container()
    }

    struct Container: View {
        @State private var currentIndex: Int = 0

        private let configurations: BZPageIndicator.Configurations = {
            let configurations = BZPageIndicator.Configurations(
                indicatorShape: .roundedLine(size: .normal),
                activeIndicatorColor: .yellow,
                presentation: .autoSlide(timeInterval: 2.0)
            )
            return configurations
        }()

        var body: some View {
            BZPageIndicator(
                numberOfPages: 5,
                currentIndex: $currentIndex,
                configurations: configurations
            )
        }
    }
}
