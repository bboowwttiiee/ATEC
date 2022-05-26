//
//  Components.swift
//  ATEC
//
//  Created by bowtie on 19.05.2022.
//

import SwiftUI

func calculateAge(fromDate: Date) -> Int {
    let now = Date()
    let calendar = Calendar.current
    let ageComponents = calendar.dateComponents([.year], from: fromDate, to: now)
    let age = ageComponents.year!
    
    return age
}

extension Date {
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}

func randomAvatarTemp() -> String {
    let randNum = Int.random(in: 1..<5)
    let avatarTempName = "avatarTemp" + "\(randNum)"
    return avatarTempName
}
