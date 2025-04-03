# Pinterest-Style Image Gallery App

A SwiftUI application that displays a gallery of images in a Pinterest-style grid layout, built using the MVVM architectural pattern.

## Features

- Fetches random images from [Lorem Picsum](https://picsum.photos/)
- Displays images in a customizable grid layout
- Loads images concurrently on background threads
- Uses DispatchGroup to synchronize image loading
- Displays image loading states and error states
- Allows viewing image details
- Pull-to-refresh functionality
- Layout customization options (2 or 3 columns)
- Loads additional images when requested

## Architecture

This app is built using the MVVM (Model-View-ViewModel) architectural pattern:

### Models
- `ImageModel`: Represents image data including URL, loaded image, and loading states

### ViewModels
- `ImageGalleryViewModel`: Manages the business logic for fetching and storing images

### Views
- `ContentView`: Main screen showing the image grid and controls
- `ImageItemView`: Individual image component with loading/error states
- `GridLayout`: Pinterest-style grid layout component

### Services
- `ImageService`: Handles image downloading using URLSession and Grand Central Dispatch

## Technical Implementation

### Concurrency
- Uses Grand Central Dispatch (GCD) for concurrent image downloads
- Implements DispatchGroup to synchronize multiple downloads
- Properly manages background and main thread operations

### SwiftUI Features
- Declarative UI with SwiftUI components
- Reactive UI updates using SwiftUI's state management
- Sheet presentation for image detail view
- Pull-to-refresh using built-in SwiftUI functionality

## Project Structure

```
GalleryApp/
├── Models/
│   └── ImageModel.swift
│
├── Views/
│   ├── Components/
│   │   ├── ImageItemView.swift
│   │   └── GridLayout.swift
│   │
│   └── ContentView.swift
│
├── ViewModels/
│   └── ImageGalleryViewModel.swift
│
└── Services/
    └── ImageService.swift
```

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Future Improvements

- Add image caching to improve performance
- Implement infinite scrolling
- Add ability to save images to photo library
- Add search functionality
- Improve UI with animations and transitions
