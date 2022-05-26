//
//  SettingsView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct AddPersonPageView: View {
    //MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var birthdate: Date = Date()
    @State private var avatar: UIImage = UIImage(named: randomAvatarTemp())!
    @State private var isShowingImagePicker: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    private func savePerson() {
        do {
            let person = Person(context: viewContext)
            person.name = name
            person.birthdate = birthdate
            person.avatar = avatar.jpegData(compressionQuality: 0.2)
            person.dateCreated = Date()
            
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 24) {
                    ZStack {
                        Image(uiImage: avatar)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .clipped()
                            .onTapGesture {
                                isShowingImagePicker = true
                        }
                        
                        ZStack {
                            Circle()
                                .fill(.brown)
                            .frame(width: 40, height: 40)
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    }
                    .frame(width: 110, height: 110)
                    
                    TextField("Write a name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    DatePicker("Pick a date of birth", selection: $birthdate, displayedComponents: .date)
                    
                    Button("Save") {
                        let yearAgo = Date().addingTimeInterval(-((3600 * 24) * 365))
                        if name != "" && !birthdate.isBetween(yearAgo, and: Date()) {
                            savePerson()
                            presentationMode.wrappedValue.dismiss()
                        }
                    } //: SAVE BUTTON
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(9)
                    .padding(.top)
                    
                } //: VSTACK
                .padding()
                
                Spacer()
            } //: VSTACK
            .navigationTitle("Add a Person")
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        } //: NAVIGATION
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(avatarImage: $avatar)
        }
    }
}

//MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        
        AddPersonPageView()
            .environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
