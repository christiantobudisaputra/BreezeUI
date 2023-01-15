//
//  BZCarousel.swift
//  BCarousel
//
//  Created by Christianto Budisaputra on 1/12/23.
//

import Combine
import SDWebImageSwiftUI
import SwiftUI

// @EnvironmentObject var myEvent: MyEvent

class BZCarouselEvent: ObservableObject {
    @Published var swipeEvent = PassthroughSubject<Void, Never>()
}

struct BZCarousel<Content: View>: View {
    @StateObject var events: BZCarouselEvent = .init()
    
    @State private var currentIndex: Int = 0

    private let contents: [Content]
    private var numberOfPages: Int {
        contents.count
    }
    
    init(contents: [Content]) {
        self.contents = contents
    }

    init(contentUrls: [String]) {
        let contents: [Content] = contentUrls.compactMap { urlString -> Content? in
            guard let url: URL = URL(string: urlString) else {
                return nil
            }
            return AnyView(
                WebImage(url: url)
                    .resizable()
                    .indicator(.activity(style: .large))
                    .scaledToFill()
            ) as? Content
        }
        self.init(contents: contents)
    }
    
    var body: some View {
        if contents.isEmpty {
            EmptyView()
        }
        else {
            content
                .environmentObject(events)
        }
    }

    private var content: some View {
        ZStack {
            Color.clear
                .background (
                    activeContent()
                        .animation(.default)
                )

            VStack {
                Spacer()
                BZPageIndicator(
                    numberOfPages: numberOfPages,
                    currentIndex: $currentIndex,
                    configurations: .init(
                        activeIndicatorColor: .white,
                        presentation: .autoSlide(timeInterval: 5.0)
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
                        events.swipeEvent.send()
                    }
                    else if distance.translation.width < 0 {
                        currentIndex.increment(within: range)
                        events.swipeEvent.send()
                    }
                }
        )
    }

    @ViewBuilder
    private func activeContent() -> some View {
        contents[currentIndex]
    }
}

struct BCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        let imageUrls: [String] = [
            "https://images.unsplash.com/photo-1661956601030-fdfb9c7e9e2f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1342&q=80",
            "https://images.unsplash.com/photo-1673546804014-1b0306317155?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60",
            "https://images.unsplash.com/photo-1673725437510-fe7bc808c306?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60"
        ]
        BZCarousel<AnyView>(contentUrls: imageUrls)
            .frame(height: 240)
            .cornerRadius(16)
            .clipped()
            .padding()
    }
}
