//
//  PersonRowView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct PersonRowView: View {
    // MARK: - PROPERTIES
    var photo: UIImage
    var name: String
    var age: String
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 12) {
            Image(uiImage: photo)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .clipped()
                .shadow(color: .black.opacity(0.08), radius: 5, x: 5, y: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Text("\(age) years old")
                    .font(.body)
                    .foregroundColor(Color.secondary)
            } //: VSTACK
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .fill(.yellow)
                .frame(width: 30, height: 30)
                .overlay {
                    Text("10")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        } //: HSTACK
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground))
        )
    }
}

// MARK: - PREVIEW
struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PersonRowView(photo: UIImage(named: "lightAvatarTemp1")!, name: "Jack", age: "13")
    }
}
