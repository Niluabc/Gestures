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
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false
    
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
    // MARK : FUNCTION
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func currentPage() -> String {
        if pageIndex > 0 {
            return pages[pageIndex - 1].imageName
        } else {
            return pages[0].imageName
        }
    }
    
    // MARK : CONTENT
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                
                // MARK : PAGE IMAGE
                Image(currentPage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .gray.opacity(0.5), radius: 12, x: 2, y: 2)
                    .opacity(isAnimatingView ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                
                // 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    })
                
                // 2. DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1.0)) {
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
                
                // 3. MAGNIFYING GESTURE
                    .gesture(
                        MagnificationGesture()
                        .onChanged{ value in
                            withAnimation(.linear(duration: 1.0)) {
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = value
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                            .onEnded{ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
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
        // MARK : Info Panel
        .overlay (
            InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal, 8)
                .padding(.top, 30),
            alignment: .top
        )
        // MARK : CONTROLS
        .overlay (
            Group {
                HStack(alignment: .center, spacing: 10) {
                    // Scale Down
                    Button {
                        withAnimation(.easeOut(duration: 1.0)) {
                            if imageScale > 1 {
                                imageScale -= 1
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        }
                    } label: {
                        ControlImageView(iconName: "minus.magnifyingglass", iconSize: 36)
                    }

                    // Reset
                    Button {
                        withAnimation(.easeOut(duration: 1.0)) {
                            resetImageState()
                        }
                    } label: {
                        ControlImageView(iconName: "arrow.down.right.and.arrow.up.left.circle", iconSize: 36)
                    }

                    // Scale up
                    Button {
                        withAnimation(.easeOut(duration: 1.0)) {
                            if imageScale < 5 {
                                imageScale += 1
                                
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                    } label: {
                        ControlImageView(iconName: "plus.magnifyingglass", iconSize: 36)
                    }
                }
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .opacity(isAnimatingView ? 1 : 0)
            }
                .padding(.bottom, 30)
            ,
            alignment: .bottom
        )
        
        // MARK: DRAWER
        .overlay(
            HStack(spacing: 12) {
                // MARK: DRAWER HANDLE
                Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(8)
                    .foregroundStyle(.secondary)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isDrawerOpen.toggle()
                        }
                    }
                
                // MARK: THUMBNAILS
                ForEach(pages) { page in
                    Image(page.thumbnailName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .opacity(isDrawerOpen ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                        .onTapGesture {
                            isAnimatingView = true
                            pageIndex = page.id
                        }
                }
                
                Spacer()
            }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .opacity(isAnimatingView ? 1 : 0)
                .frame(width: 260)
                .padding(.top, UIScreen.main.bounds.height / 12)
                .offset(x: isDrawerOpen ? 20 : 215)
            ,
            alignment: .topTrailing
        )
    }
}

#Preview {
    ContentView()
}
