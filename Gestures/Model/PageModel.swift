//
//  PageModel.swift
//  Gestures
//
//  Created by Nilam Shah on 17/11/23.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
