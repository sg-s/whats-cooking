//
//  DetailView.swift
//  RecipesCoreData
//
//  Created by srinivas on 4/11/20.
//  Copyright © 2020 srinivas.gs. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var recipe: Recipe
    
    var body: some View {
        Text(recipe.name!)
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
