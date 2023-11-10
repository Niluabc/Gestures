//
//  ContentView.swift
//  Gestures
//
//  Created by Nilam Shah on 09/11/23.
//

import SwiftUI

struct ContentView: View {
    // MARK : PROPERTY
    @State private var isAnimatingView: Bool = false
    @State private var imageScale: CGFloat = 1
    
    // MARK : FUNCTION
    
    // MARK : CONTENT
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK : PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .gray.opacity(0.5), radius: 12, x: 10, y: 10)
                    .opacity(isAnimatingView ? 1 : 0)
                    .scaleEffect(imageScale)
                
                // 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            imageScale = 1
                        }
                    })
                
                // 2. DRAG GESTURE
                
            }
            .navigationTitle("Pinch & Zoom")
            .toolbarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: {
            withAnimation(.linear(duration: 1)) {
                isAnimatingView = true
            }
        })
    }
}

#Preview {
    ContentView()
}
