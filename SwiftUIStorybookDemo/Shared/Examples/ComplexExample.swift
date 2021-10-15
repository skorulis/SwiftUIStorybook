//
//  ComplexExample.swift
//  SwiftUIStorybookDemo
//
//  Created by Alexander Skorulis on 17/10/21.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ComplexExample {
    
    let text: Binding<String>
    let int: Int
    
}

// MARK: - Rendering

extension ComplexExample: View {
    
    var body: some View {
        Text("Complex \(text.wrappedValue) \(int)")
    }
}
