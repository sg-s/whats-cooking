//
//  RowView.swift
//  RecipesCoreData
//
//  Created by srinivas on 4/10/20.
//  Copyright © 2020 srinivas.gs. All rights reserved.
//

import SwiftUI
import UIKit

struct RowView: View {
    
    // RowView recieves this recipe from ContentView
    var recipe: FetchedResults<Recipe>.Element
    
    
    // simple date formatter
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        //dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    
    }
    


    func getRandomColor() -> UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    var body: some View {
    
        HStack {
            
            Image(systemName: "camera")
                .frame(width: 50, height: 50)
            
            VStack{
               Text(recipe.name ?? "No name given")
                   .font(.largeTitle)
                   .fontWeight(.bold)
                   .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(self.getRandomColor()))
               
               Text("Last cooked on \(formatDate(date: recipe.lastCooked!))")
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .foregroundColor(.gray)
           } // VStack
        } // HStack
    

        
    } // body: View
} // struct RowView

//struct RowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RowView(recipe: Recipe())
//    }
//}
