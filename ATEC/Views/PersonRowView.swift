//
//  PersonRowView.swift
//  ATEC
//
//  Created by bowtie on 17.05.2022.
//

import SwiftUI

struct PersonRowView: View {
    //MARK: - PROPERTIES
    var photo: UIImage
    var name: String
    var age: String
    
    //MARK: - BODY
    var body: some View {
        HStack(spacing: 12) {
            Image(uiImage: photo)
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 54, height: 54)
                .clipShape(Circle())
                .clipped()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(age)
                    .font(.body)
                    .foregroundColor(Color.secondary)
            } //: VSTACK
            
            Spacer()
            Text("10")
                .fontWeight(.semibold)
                .background(Circle()
                    .fill(.yellow)
                    .frame(width: 30, height: 30))
        } //: HSTACK
        .padding(.trailing, 8)
        .padding(.vertical, 8)
    }
}

//MARK: - PREVIEW
struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PersonRowView(photo: UIImage(named: "avatarTemp1")!, name: "Jack", age: "13")
    }
}
