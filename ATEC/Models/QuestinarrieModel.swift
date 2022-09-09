//
//  QuestionnaireModel.swift
//  ATEC
//
//  Created by bowtie on 07.07.2022.
//

import SwiftUI

// MARK: - Answer
struct Answer: Identifiable, Codable {
    var id = UUID()
    var isYes: Bool
}

// MARK: - Questionnaire
struct Questionnaire: Codable {
    let groups: [Group]
}

// MARK: - Group
struct Group: Codable {
    let name: String
    let scores: [String: String]
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let id, label: String
    var answers: [Answer] {
        let yesAnswer = [Answer(isYes: true)]
        let noAnswer = [Answer(isYes: false)]
        let allAnswers = yesAnswer + noAnswer
        
        return allAnswers
    }
}
