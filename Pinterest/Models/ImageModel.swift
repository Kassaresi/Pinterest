//
//  ImageModel.swift
//  Pinterest
//
//  Created by Alikhan Kassiman on 2025.04.04.
//

import UIKit

struct ImageModel: Identifiable, Hashable {
    let id = UUID()
    let url: URL
    var image: UIImage?
    var isLoading: Bool = false
    var loadFailed: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ImageModel, rhs: ImageModel) -> Bool {
        return lhs.id == rhs.id
    }
}
