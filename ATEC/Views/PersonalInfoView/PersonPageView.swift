//
//  PersonPageView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct PersonPageView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingEditPersonPage: Bool = false
    @State private var deleteAlert = false
    
    var photo: UIImage
    var name: String
    var isFemale: Bool
    var age: String
    var person: Person
    
    private func deletePerson(_ person: Person) {
        viewContext.delete(person)
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView {
            VStack {
                HStack(spacing: 20) {
                    Image(uiImage: photo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 72)
                        .clipShape(Circle())
                        .clipped()
                        .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text((isFemale ? "Female" : "Male") + ", " + age + " years old")
                            .font(.body)
                            .foregroundColor(Color.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } //: HSTACK
                .padding(.vertical)
                
                VStack {
                    ChartView()
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                        .padding()
                }
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        Text("Some personal information...")
                            .font(.title3.italic())
                            .rotationEffect(Angle(degrees: -45))
                            .opacity(0.4)
                    }
                    .frame(height: 300)
                
            } //: VSTACK
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        deleteAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                    .alert("Delete person", isPresented: $deleteAlert) {
                        Button("OK", role: .destructive) {
                            withAnimation {
                                deletePerson(person)
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text("You're going to delete this person and all personal information.")
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingEditPersonPage = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
//                    .sheet(isPresented: $isShowingEditPersonPage) {
//                        EditPersonalInfoView(avatar: UIImage(named: "avatarTemp1")!, name: "Jack", birthdate: Date(), isMale: true)
//                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct PersonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PersonPageView(photo: UIImage(named: "avatarTemp1")!, name: "Jack", isFemale: true, age: "13", person: Person.init())
    }
}
