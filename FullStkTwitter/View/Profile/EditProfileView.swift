//
//  EditProfileView.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/21.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    @State private var profileImage: Image?
    @State private var selectedImage: UIImage?
    @State private var imagePickerPresented = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }

                    Button {
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                HStack {
                    Spacer()
                    Text("Edit Profile")
                        .fontWeight(.heavy)
                    Spacer()
                }
            }
            
            Image("banner")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRect().width, height: 180, alignment: .center)
                .cornerRadius(0)
            
            if profileImage == nil {
                Button {
                    self.imagePickerPresented.toggle()
                } label: {
                    KFImage(URL(string: "http://localhost:3000/users/id/avatar"))  // id: placeholder for now
                        .resizable()
                        .placeholder {
                            Image("blankpp")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(y: -20)
                        .padding(.leading, 12)
                }
                .sheet(isPresented: $imagePickerPresented) {
                    loadImage()
                } content: {
                    ImagePicker(image: $selectedImage)
                }
            }
            else if let image = profileImage {
                VStack {
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            .offset(y: -20)
                    }
                    .padding()
                }
                .padding(.leading, 12)
            }
            Spacer()
        }
    }
}

extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

//struct EditProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
