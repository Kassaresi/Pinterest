//
//  GridLayout.swift
//  Pinterest
//
//  Created by Alikhan Kassiman on 2025.04.04.
//

import SwiftUI

struct GridLayout<Content: View, Item: Identifiable>: View {
    let items: [Item]
    let columns: Int
    let spacing: CGFloat
    let content: (Item) -> Content
    
    init(
        items: [Item],
        columns: Int,
        spacing: CGFloat = 8,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.columns = max(1, columns)
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        let columnsArray = createColumnArrays()
        
        ScrollView {
            HStack(alignment: .top, spacing: spacing) {
                ForEach(0..<columns, id: \.self) { columnIndex in
                    if columnIndex < columnsArray.count {
                        LazyVStack(spacing: spacing) {
                            ForEach(columnsArray[columnIndex]) { item in
                                content(item)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func createColumnArrays() -> [[Item]] {
        var columnsArray: [[Item]] = Array(repeating: [], count: columns)
        
        for (index, item) in items.enumerated() {
            let columnIndex = index % columns
            columnsArray[columnIndex].append(item)
        }
        
        return columnsArray
    }
}


