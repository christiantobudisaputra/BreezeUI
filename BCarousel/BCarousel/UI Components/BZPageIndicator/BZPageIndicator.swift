//
//  BZPageIndicator.swift
//  BCarousel
//
//  Created by Christianto Budisaputra on 1/12/23.
//

import Combine
import SwiftUI

struct BZPageIndicator: View {
    private let configurations: Configurations

    @Binding var numberOfPages: Int
    @State var currentIndex = 0 {
        didSet {
            if currentIndex == numberOfPages {
                currentIndex = 0
            }
        }
    }

    @State private var timer: AnyCancellable?

    init(numberOfPages: Binding<Int>, configurations: Configurations) {
        _numberOfPages = numberOfPages
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
        .onAppear(perform: runAutoSlideIfNeeded)
    }

    func slide() {
        currentIndex += 1
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
        if numberOfPages < 2 {
            configurations.makeIdle()
        }
        if case .autoSlide(let timeInterval) = configurations.presentation {
            timer = Timer
                .publish(every: timeInterval, on: .main, in: .default)
                .autoconnect()
                .sink { _ in
                    slide()
                }
        }
    }
}

struct PageIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        let configurations: BZPageIndicator.Configurations = {
            let configurations = BZPageIndicator.Configurations(
                indicatorShape: .roundedLine(size: .normal),
                activeIndicatorColor: .yellow,
                presentation: .autoSlide(timeInterval: 3.0)
            )
            return configurations
        }()
        BZPageIndicator(numberOfPages: .constant(4), configurations: configurations)
    }
}
