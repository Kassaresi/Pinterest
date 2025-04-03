//
//  ImageService.swift
//  Pinterest
//
//  Created by Alikhan Kassiman on 2025.04.04.
//

import Foundation
import UIKit

protocol ImageServiceProtocol {
    func fetchRandomImages(count: Int, width: Int, completion: @escaping ([ImageModel]) -> Void)
}

class ImageService: ImageServiceProtocol {
    func fetchRandomImages(count: Int, width: Int, completion: @escaping ([ImageModel]) -> Void) {
        var pendingImages: [ImageModel] = []
        let dispatchGroup = DispatchGroup()
        
        for _ in 0..<count {
            let height = Int.random(in: 300...600)
            let imageUrlString = "https://picsum.photos/\(width)/\(height)"
            
            if let imageUrl = URL(string: imageUrlString) {
                var imageModel = ImageModel(url: imageUrl)
                imageModel.isLoading = true
                
                pendingImages.append(imageModel)
                print("Created image model with URL: \(imageUrlString)")
            }
        }
        
        for i in 0..<pendingImages.count {
            let imageUrl = pendingImages[i].url
            
            dispatchGroup.enter()
            
            DispatchQueue.global(qos: .userInitiated).async {
                print("Starting download for image at URL: \(imageUrl)")
                
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    defer {
                        dispatchGroup.leave()
                        print("Finished download for image at URL: \(imageUrl)")
                    }
                    
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                        pendingImages[i].loadFailed = true
                        pendingImages[i].isLoading = false
                        return
                    }
                    
                    guard let data = data, !data.isEmpty else {
                        print("No data received from server")
                        pendingImages[i].loadFailed = true
                        pendingImages[i].isLoading = false
                        return
                    }
                    
                    if let image = UIImage(data: data) {
                        print("Successfully downloaded image with size: \(image.size)")
                        pendingImages[i].image = image
                        pendingImages[i].isLoading = false
                    } else {
                        print("Failed to create image from data")
                        pendingImages[i].loadFailed = true
                        pendingImages[i].isLoading = false
                    }
                }.resume()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(pendingImages)
            print("All image downloads completed - added \(pendingImages.count) images")
        }
    }
}
