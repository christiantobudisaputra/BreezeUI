//
//  BZCarousel.swift
//  BCarousel
//
//  Created by Christianto Budisaputra on 1/12/23.
//

import SwiftUI

struct BZCarousel: View {
    @State private var numberOfPages: Int = 5
    @State private var currentIndex: Int = 0

    var body: some View {
        ZStack {
            Color.yellow
            VStack {
                Spacer()
                BZPageIndicator(
                    numberOfPages: $numberOfPages,
                    currentIndex: $currentIndex,
                    configurations: .init(
                        activeIndicatorColor: .gray,
                        presentation: .autoSlide(timeInterval: 1.0)
                    )
                )
            }
            .padding(24)
        }
        .gesture(
            DragGesture(minimumDistance: 32)
                .onEnded { distance in
                    let range: ClosedRange = 0 ... numberOfPages
                    if distance.translation.width > 0 {
                        currentIndex.decrement(within: range)
                    }
                    else if distance.translation.width < 0 {
                        currentIndex.increment(within: range)
                    }
                }
        )
    }
}

struct BCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        BZCarousel()
            .frame(height: 240)
    }
}
