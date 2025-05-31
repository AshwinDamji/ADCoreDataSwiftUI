//
//  PersonListViewModel.swift
//  CoreDataSwiftUI
//
//  Created by Ashwinkumar Damji on 26/05/25.
//

import Foundation
import CoreData
class PersonListViewModel: ObservableObject, PersonEditDelegate {
    @Published var people: [Person] = []
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchPeople()
    }
    
    func fetchPeople() {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Person.name, ascending: true)]
        do {
            people = try context.fetch(request)
        } catch {
            print("Fetch People Error: \(error)")
        }
    }
    
    func delete(_ person: Person) {
        context.delete(person)
        save()
    }
    
    func save() {
        do {
            try context.save()
            fetchPeople()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func didSavePerson() {
        fetchPeople()
    }
}
