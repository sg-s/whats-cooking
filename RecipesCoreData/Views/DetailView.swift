//
//  DetailView.swift
//  RecipesCoreData
//
//  Created by srinivas on 4/11/20.
//  Copyright © 2020 srinivas.gs. All rights reserved.
//


import SwiftUI

struct DetailView: View {
  @Environment(\.managedObjectContext) var context
  @Environment(\.presentationMode) var presentationMode

  @State var itemName: String = ""
  @State var lastCooked: Date = Date()
  @ObservedObject var recipe: Recipe

  @State var justCooked: Bool = false

  var body: some View {
    
    NavigationView {
      VStack {
          
        TextField("Item Name", text: $itemName)
                .font(.title)


        
        Spacer()
        
        Button(action: {
            self.justCooked = true
            // self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Just cooked!")
        }
        
        
        Spacer()
          
      } // VStack
      .onAppear(perform: {
          self.itemName = self.recipe.name
      })
      .onDisappear(perform: {
          
          self.recipe.name = self.itemName
        
          if self.justCooked {
              self.recipe.lastCooked = self.lastCooked
          }
          
          do {
              try self.context.save()
          } catch {
              print(error)
          }
      })
    } // NavigationView
    .navigationBarTitle(self.itemName)
  } // body
}

