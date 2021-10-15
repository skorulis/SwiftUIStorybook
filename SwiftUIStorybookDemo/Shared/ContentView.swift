//
//  ContentView.swift
//  Shared
//
//  Created by Alexander Skorulis on 15/10/21.
//

import SwiftUI
import SwiftUIStorybook

struct ContentView: View {
    var body: some View {
        StorybookList(elements: vms)
    }
    
    var vms: [StorybookElementViewModel] {
        return [
            StorybookElementViewModel(ExampleElement.self, initializer: ExampleElement.init),
            StorybookElementViewModel(ExampleBindingView.self, initializer: ExampleBindingView.init(binding:))
            
        ]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
