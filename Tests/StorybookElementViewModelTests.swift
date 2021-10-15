//
//  StorybookElementViewModelTests.swift
//  
//
//  Created by Alexander Skorulis on 16/10/21.
//

import XCTest
import SwiftUI
@testable import SwiftUIStorybook

final class StorybookElementViewModelTests: XCTestCase {
  
    func test_resolving() {
        let vm = StorybookElementViewModel(BindingView.self, initializer: BindingView.init)
        XCTAssertEqual(vm.fields.count, 1)
        
        XCTAssertTrue(vm.fields[0].isBinding)
    }
    
    
    
}

private extension StorybookElementViewModelTests {
    
    struct BindingView: View {
        
        let argument: Binding<String>
        
        var body: some View {
            EmptyView()
        }
    }
    
}

