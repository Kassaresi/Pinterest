//
//  ContentView.swift
//  Pinterest
//
//  Created by Alikhan Kassiman on 2025.04.04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageGalleryViewModel()
    @State private var columnCount = 2
    @State private var selectedImage: ImageModel?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    // Header space
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 1)
                    
                    // Main content
                    if viewModel.images.isEmpty {
                        VStack {
                            Spacer()
                            ContentUnavailableView(
                                "No Images",
                                systemImage: "photo.on.rectangle",
                                description: Text("Tap the button below to load some images")
                            )
                            Spacer()
                        }
                    } else {
                        GridLayout(
                            items: viewModel.images,
                            columns: columnCount,
                            spacing: 10
                        ) { imageModel in
                            Button {
                                selectedImage = imageModel
                            } label: {
                                ImageItemView(imageModel: imageModel)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.vertical)
                    }
                }
                
                // Loading indicator
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack {
                                ProgressView()
                                Text("Loading images...")
                                    .padding(.top, 8)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                
                // Load more button
                VStack {
                    Spacer()
                    Button {
                        viewModel.fetchRandomImages()
                    } label: {
                        Text("Load More Images")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.isLoading)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Image Gallery")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("2 Columns") { columnCount = 2 }
                        Button("3 Columns") { columnCount = 3 }
                    } label: {
                        Label("Layout", systemImage: "square.grid.2x2")
                    }
                }
            }
            .refreshable {
                viewModel.fetchRandomImages()
            }
            .sheet(item: $selectedImage) { imageModel in
                imageDetailView(for: imageModel)
            }
        }
        .onAppear {
            if viewModel.images.isEmpty {
                viewModel.fetchRandomImages()
            }
        }
    }
    
    private func imageDetailView(for imageModel: ImageModel) -> some View {
        NavigationView {
            VStack {
                if let image = imageModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    ProgressView()
                }
                
                Text("Image ID: \(imageModel.id)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Image Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
