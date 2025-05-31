//
//  EditPersonViewModel.swift
//  CoreDataSwiftUI
//
//  Created by Ashwinkumar Damji on 26/05/25.
//

import Foundation
import CoreData

protocol PersonEditDelegate: AnyObject {
    func didSavePerson()
}

class EditPersonViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var age: String = ""
    
    var person: Person?
    private let context: NSManagedObjectContext
    
    weak var delegate: PersonEditDelegate?
    
    init(person: Person?, context: NSManagedObjectContext) {
        self.context = context
        self.person = person
        if let person = person {
            self.name = person.name ?? ""
            self.age = String(person.age)
        }
    }
    
    func save() {
        let target = person ?? Person(context: context)
        target.name = name
        target.age = Int16(age) ?? 0
        
        do {
            try context.save()
            delegate?.didSavePerson()
        } catch {
            print("Error: \(error)")
        }
    }
}
