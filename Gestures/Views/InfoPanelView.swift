//
//  InfoPanelView.swift
//  Gestures
//
//  Created by Nilam Shah on 10/11/23.
//

import SwiftUI

struct InfoPanelView: View {
    var scale: CGFloat
    var offset: CGSize
    @State private var isInfoPanelVisible: Bool = false
    
    var body: some View {
        HStack {
            // MARK: HOTPOT
            Image(systemName: "circle.circle")
                .resizable()
                .scaledToFit()
                .symbolRenderingMode(.hierarchical)
                .frame(width: 30, height: 30)
            // MARK : 1. Long Press Gesture
                .onLongPressGesture(minimumDuration: 1.0) {
                    withAnimation(.easeOut) {
                        isInfoPanelVisible.toggle()
                    }
                }
            
            Spacer()
            
            // MARK : INFO PANEL
            HStack(spacing: 2) {
                ControlImageView(iconName: "arrow.up.left.and.arrow.down.right", iconSize: 20)
                Text("\(scale)")
                
                Spacer()
                
                ControlImageView(iconName: "arrow.left.and.right", iconSize: 20)
                Text("\(offset.width)")
                
                Spacer()
                
                ControlImageView(iconName: "arrow.up.and.down", iconSize: 20)
                Text("\(offset.height)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            
            Spacer()
        }
    }
}

#Preview {
    InfoPanelView(scale: 1, offset: .zero)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
