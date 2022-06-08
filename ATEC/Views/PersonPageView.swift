//
//  PersonPageView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct PersonPageView: View {
    // MARK: - PROPERTIES
    var photo: UIImage
    var name: String
    var age: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - BODY
    var body: some View {
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
                    
                    Text(age + " years old")
                        .font(.body)
                        .foregroundColor(Color.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } //: HSTACK
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    Text("Some personal information...")
                        .font(.title2.italic())
                        .rotationEffect(Angle(degrees: -45))
                        .opacity(0.4)
                }
                .padding(.bottom)
            
        } //: VSTACK
        .navigationTitle("Person details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct PersonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PersonPageView(photo: UIImage(named: "lightAvatarTemp1")!, name: "Jack", age: "13")
    }
}
