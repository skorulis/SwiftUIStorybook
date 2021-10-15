//
//  FieldResolver.swift
//  
//
//  Created by Alexander Skorulis on 16/10/21.
//

import Foundation
import SwiftUI

struct FieldResolver {
    
    private var fields: [String: PStorybookField] = [:]
    
    init() {
        register(type: String.self, field: Self.stringField)
        register(type: Int.self, field: Self.intField)
    }
    
    mutating func register<ValueType>(type: ValueType.Type, field: PStorybookField) {
        let key = Key(type: type)
        assert(!key.isBinding, "Fields cannot be registered with binding values. Use a regular value and the binding will resolve automatically")
        self.fields[key.id] = field
    }
    
    static var stringField: PStorybookField {
        return StorybookField(value: "Lorem ipsum dolor sit amet") { value in
            TextField("String", text: value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    static var intField: PStorybookField {
        return StorybookField(value: 1) { value in
            Stepper("Int", value: value)
        }
    }
    
    func resolve<ValueType>(type: ValueType.Type) -> PStorybookField {
        let key = Key(type: type)
        guard let field = fields[key.id] else {
            fatalError("Could not find field to satisfy \(key)")
        }
        
        return field.copy(isBinding: key.isBinding)
    }
    
    func resolve<ValueType>(type: Binding<ValueType>.Type) -> PStorybookField {
        let key = Key(type: ValueType.self)
        guard let field = fields[key.id] else {
            fatalError("Could not find field to satisfy \(key)")
        }
        
        return field.copy(isBinding: true)
    }
    
}


// MARK: - Inner types

extension FieldResolver {
    
    struct Key: Identifiable, Hashable {
        
        let id: String
        var isBinding: Bool = false
        
        init<ValueType>(type: ValueType.Type) {
            let typeName = String(describing: type)
            id = Self.sanitiseName(typeName: typeName)
            isBinding = typeName.starts(with: "Binding<")
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func sanitiseName(typeName: String) -> String {
            let regex = try! NSRegularExpression(pattern: "^Binding<(.*)>$", options: [])
            let nameRange = NSRange(typeName.startIndex..<typeName.endIndex, in: typeName)

            let matches = regex.matches(in: typeName, options: [], range: nameRange)
            if matches.count == 1 {
                let range = Range(matches[0].range(at: 1), in: typeName)!
                return String(typeName[range])
            }
            
            return typeName
        }
    }
}
