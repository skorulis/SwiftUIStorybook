//
//  StorybookElementViewModel.swift
//  
//
//  Created by Alexander Skorulis on 16/10/21.
//

import Combine
import Foundation
import SwiftUI

public final class StorybookElementViewModel: ObservableObject, Identifiable {
    
    @Published var fields: [PStorybookField] = []
    
    var build: () -> AnyView = { AnyView(EmptyView()) }
    public var id: UUID = UUID()
    
    private var subscribers: Set<AnyCancellable> = []
    
    public var name: String
    
    public init<ElementType: View, A>(_ service: ElementType.Type, initializer: @escaping (A) -> ElementType) {
        let resolver = FieldResolver()
        self.name = String(describing: service)
        fields.append(resolver.resolve(type: A.self))
         
        let mirror = Mirror(reflecting: initializer)
        print("M1: \(mirror)")
        
        for child in mirror.children {
            print("M: \(child)")
        }
        
        build = { [unowned self] in
            return AnyView(
                initializer(value(at: 0))
            )
        }
        
        
        
        registerObservers()
    }
    
    public init<ElementType: View, A, B>(_ service: ElementType.Type, initializer: @escaping (A, B) -> ElementType) {
        let resolver = FieldResolver()
        self.name = String(describing: service)
        fields.append(resolver.resolve(type: A.self))
        fields.append(resolver.resolve(type: B.self))
        
        let mirror = Mirror(reflecting: initializer)
        print("M1: \(mirror)")
        
        build = { [unowned self] in
            return AnyView(
                initializer(
                    value(at: 0),
                    value(at: 1)
                )
            )
        }
        
        registerObservers()
    }
    
    private func registerObservers() {
        fields.forEach { f in
            f.valueWillChangePublisher
                .sink { _ in
                    self.objectWillChange.send()
                }
                .store(in: &subscribers)
        }
    }
    
    func field(at index: Int) -> PStorybookField {
        return fields[index]
    }
    
    func value<T>(at index: Int) -> T {
        return fields[index].value as! T
    }
    
    
}
