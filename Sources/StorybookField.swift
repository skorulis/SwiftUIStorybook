//
//  StorybookField.swift
//  
//
//  Created by Alexander Skorulis on 16/10/21.
//

import Combine
import Foundation
import SwiftUI

public protocol PStorybookField {
    
    var editor: AnyView { get }
    var valueWillChangePublisher: PassthroughSubject<Void, Never> { get }
    var value: Any { get }
    
    func copy(isBinding: Bool) -> PStorybookField
    
    var isBinding: Bool { get }
}

public final class StorybookField<ValueType, Editor: View>: ObservableObject, PStorybookField {
    
    @Published private var innerValue: ValueType
    public let isBinding: Bool
    private let editorFunction: ((Binding<ValueType>) -> Editor)!
    
    public var valueWillChangePublisher = PassthroughSubject<Void, Never>()
    
    private var subscribers: Set<AnyCancellable> = []
    
    
    public init(value: ValueType,
                editor: @escaping (Binding<ValueType>) -> Editor,
                isBinding: Bool = false
    ) {
        self.innerValue = value
        self.isBinding = isBinding
        self.editorFunction = editor
        
        self.objectWillChange
            .sink { [unowned self] in
                self.valueWillChangePublisher.send()
            }
            .store(in: &subscribers)
    }
    
    var binding: Binding<ValueType> {
        return Binding<ValueType> { [unowned self] in
            return self.innerValue
        } set: { [unowned self] newValue in
            self.innerValue = newValue
        }
    }
    
    public func copy(isBinding: Bool) -> PStorybookField {
        return StorybookField(value: innerValue, editor: editorFunction, isBinding: isBinding)
    }
    
    public var editor: AnyView {
        return AnyView( editorFunction(binding))
    }
    
    public var value: Any {
        if isBinding {
            return binding
        } else {
            return innerValue
        }
    }
    
}
