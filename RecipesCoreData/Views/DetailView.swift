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

  // image capture
  @State var image: Image? = nil
  @State var showCaptureImageView: Bool = false

  
  var body: some View {
    
      VStack {
        
        
        TextField("Item Name", text: $itemName)
          .font(.largeTitle)
        
        
        GeometryReader { geo in
          self.image?
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width)
        }
    
        
        Button(action: {
            withAnimation {
                self.showCaptureImageView.toggle()
            }
        }) {
            Image(systemName: "photo")
                .font(.headline)
            Text("Choose picture").font(.headline)
        }.foregroundColor(.gray)
      
      
        
        Spacer()
        
        Button(action: {
            self.justCooked = true
        }) {
            Text("Just cooked!")
        }
        
        
        Spacer()

        
        
        .sheet(isPresented: $showCaptureImageView) {
            CaptureImageView(isShown: self.$showCaptureImageView, image: self.$image)
        }
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
    
  } // body
}


struct CaptureImageView {
  
  /// MARK: - Properties
  @Binding var isShown: Bool
  @Binding var image: Image?
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    //picker.sourceType = .camera
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<CaptureImageView>) {
    
  }
}


