//
//  ImageItemView.swift
//  Pinterest
//
//  Created by Alikhan Kassiman on 2025.04.04.
//

import SwiftUI

struct ImageItemView: View {
    let imageModel: ImageModel
    
    var body: some View {
        VStack(spacing: 4) {
            // Image or loading state
            if imageModel.isLoading {
                loadingView
            } else if let image = imageModel.image {
                imageView(uiImage: image)
            } else if imageModel.loadFailed {
                errorView
            }
        }
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 2)
    }
    
    private var loadingView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .aspectRatio(CGFloat.random(in: 0.6...1.5), contentMode: .fit)
            .overlay {
                ProgressView()
            }
    }
    
    private func imageView(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private var errorView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.1))
            .aspectRatio(1.0, contentMode: .fit)
            .overlay {
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.orange)
                    Text("Failed to load")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
    }
}
