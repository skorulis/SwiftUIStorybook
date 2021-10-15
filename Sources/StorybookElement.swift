//
//  StoryBookElement.swift
//  
//
//  Created by Alexander Skorulis on 15/10/21.
//

import Foundation
import SwiftUI

public struct StorybookElement {
    
    private var content: () -> AnyView = { AnyView(EmptyView()) }
    
    @StateObject private var viewModel: StorybookElementViewModel
    
    public init(viewModel: StorybookElementViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
}

// MARK: - Rendering


extension StorybookElement: View {
 
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                viewModel.build()
                
                Spacer()
                    .frame(height: 40)
                
                Divider()
                Text("Controls")
                    .bold()
                Divider()
                
                ForEach(Array(viewModel.fields.indices), id: \.self) { index in
                    viewModel.field(at: index).editor
                }
                Divider()
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(viewModel.name)
    }
    
}
