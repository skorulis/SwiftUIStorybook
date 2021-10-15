//
//  FieldResolverTests.swift
//  
//
//  Created by Alexander Skorulis on 16/10/21.
//

import XCTest
import SwiftUI
@testable import SwiftUIStorybook

final class FieldResolverTests: XCTestCase {
    
    let sut = FieldResolver()
    
    func test_resolveRegularFields() {
        let stringField = sut.resolve(type: String.self)
        XCTAssertEqual(stringField.value as? String, "Lorem ipsum dolor sit amet")
        
        let intField = sut.resolve(type: Int.self)
        XCTAssertEqual(intField.value as? Int, 1)
    }
    
    func test_resolveBindingFields() {
        let stringField = sut.resolve(type: Binding<String>.self)
        let value = stringField.value as! Binding<String>
        XCTAssertEqual(value.wrappedValue, "Lorem ipsum dolor sit amet")
    }
    
    func test_keyID() {
        let sanitised = FieldResolver.Key.sanitiseName(typeName: "Binding<String>")
        XCTAssertEqual(sanitised, "String")
    }
    
    func test_key() {
        let key1 = FieldResolver.Key(type: String.self)
        XCTAssertEqual(key1.id, "String")
        XCTAssertFalse(key1.isBinding)
        
        let key2 = FieldResolver.Key(type: Binding<String>.self)
        XCTAssertEqual(key2.id, "String")
        XCTAssertTrue(key2.isBinding)
    }
    
}
