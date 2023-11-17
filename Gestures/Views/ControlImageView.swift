//
//  ControlImageView.swift
//  Gestures
//
//  Created by Nilam Shah on 10/11/23.
//

import SwiftUI

struct ControlImageView: View {
    var iconName: String
    var iconSize: Double
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: iconSize))
    }
}

#Preview {
    ControlImageView(iconName: "arrow.up.left.and.arrow.down.right", iconSize: 20)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
