//
//  EditPersonView.swift
//  CoreDataSwiftUI
//
//  Created by Ashwinkumar Damji on 25/05/25.
//

import SwiftUI
import CoreData

struct EditPersonView: View {
    @ObservedObject var viewModel: EditPersonViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Name", text: $viewModel.name)
            
            TextField("Age", text: $viewModel.age)
                .keyboardType(.numberPad)
            
            Button("Save") {
                viewModel.save()
                dismiss()
            }
        }
        .navigationTitle(viewModel.person == nil ? "Add Person" : "Edit Person")
    }
}
