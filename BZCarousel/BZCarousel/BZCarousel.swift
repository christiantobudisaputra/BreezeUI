//
//  BZCarousel.swift
//  BCarousel
//
//  Created by Christianto Budisaputra on 1/12/23.
//

import Combine
import SDWebImageSwiftUI
import SwiftUI

class BZCarouselEvent: ObservableObject {
    @Published var swipeEvent = PassthroughSubject<Void, Never>()
}

struct BZCarousel<Content: View>: View {
    @StateObject var events: BZCarouselEvent = .init()

    @State var contentIndex: Int = 1
    @State var currentIndex: Int = 0
    @State var contentSize: CGSize = CGSize(width: 0, height: 0)
    @State var xContentOffset: CGFloat = 0
    @State var xScrollViewOffset: CGFloat = 0
    @State var contents: [Content]
    let numberOfPages: Int

    init(contents: [Content]) {
        self.contents = contents
        numberOfPages = contents.count
    }

    init(contentUrls: [String]) {
        let contents: [Content] = contentUrls.compactMap { urlString -> Content? in
            guard let url: URL = URL(string: urlString)
            else {
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
                .onAppear {
                    guard !contents.isEmpty,
                          let firstContent: Content = contents.first,
                          let lastContent: Content = contents.last
                    else {
                        return
                    }
                    contents.insert(lastContent, at: 0)
                    contents.append(firstContent)
                }
                .onChange(of: currentIndex) { [currentIndex] newValue in
//                    if currentIndex == numberOfPages - 1, newValue == 0 {
//                        contentIndex += 1
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                            contentIndex = 0
//                            xContentOffset = -CGFloat(contentIndex) * contentSize.width
//                        }
//                    }
//                    else {
//                        contentIndex += newValue - currentIndex
//                    }
//                    withAnimation(.spring()) {
//                        xContentOffset = -CGFloat(contentIndex) * contentSize.width
//                    }
                }
        }
    }

    private var content: some View {
        ZStack {
            Color.clear
                .background(
                    activeContent()
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
            DragGesture()
                .onChanged { distance in
                    xScrollViewOffset = distance.translation.width
                }
                .onEnded { distance in
                    withAnimation(.spring()) {
                        xScrollViewOffset = 0
                    }
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
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        contentSize = proxy.size
                    }
            }
        )
    }

    @ViewBuilder
    private func activeContent() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(contents.indices, id: \.self) { index in
                    contents[index]
                        .frame(width: contentSize.width, height: contentSize.height)
                }
            }
//            .offset(x: xContentOffset + xScrollViewOffset)
        }
        .disabled(false)
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
