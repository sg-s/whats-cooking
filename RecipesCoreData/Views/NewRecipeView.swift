
import SwiftUI

struct NewRecipeView: View {
    
    @Environment(\.managedObjectContext) var context 
    
    
    // \. is a keypath
    @Environment(\.presentationMode) var presentationMode
    
    @State private var text: String = ""
    
    var body: some View {
        Form {
           TextField("Recipe Name", text: $text)
            Button("Add") {
                self.addRecipe()
                self.presentationMode.wrappedValue.dismiss()
            }.disabled(text.isEmpty)
        }
       
    }
    
    
    func addRecipe() {
        let newRecipe = Recipe(context: context)
        newRecipe.id = UUID()
        newRecipe.name = text
        newRecipe.lastCooked = Date()
        // this is magically saved to disk
    }
}

//struct NewRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRecipeView()
//    }
//}
