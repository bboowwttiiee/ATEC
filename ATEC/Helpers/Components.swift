//
//  Components.swift
//  ATEC
//
//  Created by bowtie on 19.05.2022.
//

import SwiftUI
import CoreData

func calculateAge(fromDate: Date) -> Int {
    let now = Date()
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year], from: fromDate, to: now)
    let age = ageComponents.year!
    
    return age
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

extension Person {
    static var ownFetchRequest: NSFetchRequest<Person> {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        
        return request
    }
}
