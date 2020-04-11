//
//  DetailView.swift
//  RecipesCoreData
//
//  Created by srinivas on 4/11/20.
//  Copyright © 2020 srinivas.gs. All rights reserved.
//

import SwiftUI
import CoreData


struct DetailView: View {

    
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    
    var recipe: Recipe
    
    @State private var text: String = ""
    
    var body: some View {
        
        VStack{
            Image(systemName: "camera")
                .frame(height: 300)
                .edgesIgnoringSafeArea(.top)
            
            TextField(self.recipe.name!, text: $text)
                .font(.title)
            
        
            Spacer()
            
            Button (action: {
                // self.presentationMode.wrappedValue.dismiss()
                self.updateLastCooked(recipe: self.recipe)
                
                }) {
                    Text("Just cooked!")
                }
            Spacer()
            
        } // VStack
        .navigationBarTitle(Text(recipe.name!), displayMode: .inline)
    
    } // body
    
    func updateLastCooked(recipe: Recipe) {
        recipe.lastCooked = Date()
    } // func
    

} // DetailView

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
