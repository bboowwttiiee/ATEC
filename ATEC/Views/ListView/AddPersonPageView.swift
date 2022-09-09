//
//  AddPersonPageView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct AddPersonPageView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var avatar: UIImage = UIImage(named: "avatarTemp\(Int.random(in: 1..<10))")!
    @State private var name: String = ""
    @State private var birthdate: Date = Date()
    @State private var isMale: Bool = false
    @State private var offset: Float = 0
    
    @State private var isShowingImagePicker: Bool = false
    @State private var saveAlert = false
    
    struct GenderToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                configuration.label
                Spacer()
                Text(configuration.isOn ? "Female" : "Male")
                    .fontWeight(.bold)
                    .foregroundColor(configuration.isOn ? .pink : .blue)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(configuration.isOn ? .pink : .blue)
                    .frame(width: 51, height: 31, alignment: .center)
                    .overlay(
                        Circle()
                            .foregroundColor(.white)
                            .padding(3)
                            .frame(width: 33, height: 33)
                            .overlay(
                                Image(configuration.isOn ? "female" : "male")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .foregroundColor(configuration.isOn ? .pink : .blue)
                                
                            )
                            .offset(x: configuration.isOn ? 10 : -10)
                    )
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.15)) {
                            configuration.isOn.toggle()
                        }
                    }
            }
        }
    }
    
    private func savePerson() {
        do {
            let person = Person(context: viewContext)
            person.avatar = avatar.jpegData(compressionQuality: 0.2)
            person.name = name
            person.birthdate = birthdate
            person.gender = isMale
            person.dateCreated = Date()
            
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    Image(uiImage: avatar)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .clipped()
                        .frame(width: 120, height: 120)
                        .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                    
                    // MARK: - AVATAR SCROLL
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            VStack {
                                Circle()
                                    .fill(Color(UIColor.secondarySystemFill))
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.blue.opacity(0.8))
                                            .frame(width: 26, height: 26)
                                    }
                            }
                            .overlay {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)
                                    .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                                    .overlay {
                                        Image(systemName: "plus")
                                            .foregroundColor(.blue.opacity(0.8))
                                            .font(.caption.bold())
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            }
                            .onTapGesture { isShowingImagePicker = true }
                            
                            ForEach(1..<10) { imageNum in
                                Image(uiImage: UIImage(named: "avatarTemp" + "\(imageNum)")!)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .clipped()
                                    .frame(width: 60, height: 60)
                                    .onTapGesture {
                                        avatar = UIImage(named: "avatarTemp" + "\(imageNum)")!
                                    }
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(UIColor.secondarySystemBackground))
                            .frame(height: 92)
                    )
                    .padding(.top, 12)
                    
                    // MARK: - NAME
                    HStack(spacing: 12) {
                        Image(systemName: "person.text.rectangle")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        TextField("Name", text: $name)
                    } //: HSTACK
                    .padding(.horizontal)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    
                    // MARK: - BIRTH DATE
                    HStack(spacing: 12) {
                        Image(systemName: "calendar")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        DatePicker(
                            "Birth date",
                            selection: $birthdate,
                            in: ...Date(),
                            displayedComponents: .date
                        )
                        .accentColor(.black)
                        
                    } //: HSTACK
                    .padding(.horizontal)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    
                    // MARK: - GENDER
                    HStack(spacing: 12) {
                        Image(systemName: "person.and.arrow.left.and.arrow.right")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        Toggle(isOn: $isMale, label: {
                            Text("Gender")
                        })
                        .toggleStyle(GenderToggleStyle())
                    } //: HSTACK
                    .padding(.horizontal)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
                    
                    Spacer()
                    
                    // MARK: - SAVE BUTTON
                    Button {
                        saveAlert = true
                    } label: {
                        PrimaryButton(text: "Save")
                    } //: BUTTON
                    .alert("Save person?", isPresented: $saveAlert) {
                        Button("Save", role: .destructive) {
                            if name != "" {
                                savePerson()
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        Button("Edit", role: .cancel) {}
                    } message: {
                        Text("It will be impossible to change user data later. Make sure that you have entered a name, date of birth and gender correctly.")
                    }
                    
                    Spacer()
                } //: VSTACK
                .padding()
                .navigationTitle("Add a Person")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                } //: TOOLBAR
            } //: SCROLL
        } //: NAVIGATION
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(avatarImage: $avatar)
        }
    }
}

// MARK: - PREVIEW
struct AddPersonPageView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        
        AddPersonPageView()
            .environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
