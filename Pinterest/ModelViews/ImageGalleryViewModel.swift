//
//  ImageGalleryViewModel.swift
//  Pinterest
//
//  Created by Alikhan Kassiman on 2025.04.04.
//

import SwiftUI
import Combine

class ImageGalleryViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var isLoading = false
    
    private let imageService: ImageServiceProtocol
    private let imageWidth = 400
    
    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
    }
    
    func fetchRandomImages() {
        guard !isLoading else { return }
        
        isLoading = true
        print("Starting to fetch images")
        
        imageService.fetchRandomImages(count: 5, width: imageWidth) { [weak self] fetchedImages in
            guard let self = self else { return }
            
            self.images.append(contentsOf: fetchedImages)
            self.isLoading = false
            
            print("All image downloads completed - added \(fetchedImages.count) images to main array")
        }
    }
}
