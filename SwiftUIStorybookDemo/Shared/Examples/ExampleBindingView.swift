//
//  ExampleBindingView.swift
//  SwiftUIStorybookDemo
//
//  Created by Alexander Skorulis on 16/10/21.
//

import Foundation

import SwiftUI

// MARK: - Memory footprint

struct ExampleBindingView {
    
    let binding: Binding<String>
}

// MARK: - Rendering

extension ExampleBindingView: View {
    
    var body: some View {
        TextField("Test", text: binding)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

