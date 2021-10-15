//
//  StorybookList.swift
//  
//
//  Created by Alexander Skorulis on 18/10/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct StorybookList {
    
    var elements: [StorybookElementViewModel]
    
    public init(elements: [StorybookElementViewModel]) {
        self.elements = elements
    }
    
}

// MARK: - Rendering

extension StorybookList: View {
    
    public var body: some View {
        NavigationView {
            content
                .navigationTitle("Storybook")
        }
    }
    
    private var content: some View {
        ScrollView {
            VStack {
                ForEach(elements) { vm in
                    NavigationLink(vm.name) {
                        StorybookElement(viewModel: vm)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Previews

struct StorybookList_Previews: PreviewProvider {
    
    static var previews: some View {
        StorybookList(elements: [])
    }
}

