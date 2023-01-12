//
//  BZCarousel.swift
//  BCarousel
//
//  Created by Christianto Budisaputra on 1/12/23.
//

import SwiftUI

struct BZCarousel: View {
    var body: some View {
        BZPageIndicator(
            numberOfPages: .constant(5),
            configurations: .init(
                activeIndicatorColor: .orange,
                presentation: .autoSlide(timeInterval: 5.0)
            )
        )
    }
}

struct BCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        BZCarousel()
    }
}
