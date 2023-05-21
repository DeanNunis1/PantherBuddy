//
//  AddToDoView.swift
//  TabViewApp
//
//

import SwiftUI

struct AddTodoView: View {
    @State private var showAddTodoView = false
    var body: some View {
        Button("Done"){
                    self.showAddTodoView = false
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
