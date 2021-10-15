//
//  ExampleElement.swift
//  SwiftUIStorybookDemo
//
//  Created by Alexander Skorulis on 15/10/21.
//

import Foundation
import SwiftUI

struct ExampleElement {
    
    var value: String
    
}

// MARK: - Rendering

extension ExampleElement: View {
    
    var body: some View {
        Text(value)
            .padding()
            .border(Color.black)
    }
}
