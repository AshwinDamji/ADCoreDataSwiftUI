//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Ashwinkumar Damji on 24/05/25.
//

import SwiftUI
import CoreData

struct PersonListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: PersonListViewModel
    
    @State private var selectedPerson: Person?
    @State private var isShowingEdit = false
    
    private var editPersonView: some View {
        let editVM = EditPersonViewModel(person: selectedPerson, context: viewContext)
        editVM.delegate = viewModel
        return EditPersonView(viewModel: editVM)
    }
    
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: PersonListViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.people, id: \.objectID) { person in
                    VStack(alignment: .leading) {
                        Text(person.name ?? "No Name").font(.headline)
                        Text("Age: \(person.age)").font(.subheadline)
                    }.onTapGesture {
                        selectedPerson = person
                        isShowingEdit = true
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.people[$0] }.forEach(viewModel.delete)
                }
            }
            .toolbar {
                Button {
                    selectedPerson = nil
                    isShowingEdit = true
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
            .navigationTitle("People")
            .navigationDestination(isPresented: $isShowingEdit) {
                editPersonView
            }
        }
    }
}
