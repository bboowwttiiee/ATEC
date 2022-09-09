//
//  QuestionnaireManager.swift
//  ATEC
//
//  Created by bowtie on 07.07.2022.
//

import SwiftUI

class QuestionnaireManager: ObservableObject {
    private(set) var questionnaire: [Question] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: String = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var score = 0
    
    init() {
        fetchQuestionnaire(forGroup: 0)
    }
    
    func fetchQuestionnaire(forGroup: Int) {
        guard let path = Bundle.main.url(forResource: "atec", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: path) else { fatalError("Error while fetching data") }
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Questionnaire.self, from: data)
            
            DispatchQueue.main.async {
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false
                
                self.questionnaire = decodedData.groups[forGroup].questions
                self.length = self.questionnaire.count
                self.setQuestion()
            }
        } catch {
            print("Error trying parse JSON: \(error)")
        }
    }
    
    func goToNextQuestion() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        withAnimation {
            progress = CGFloat(Double(index + 1) / Double(length) * (UIScreen.main.bounds.width - 30))
        }
        
        if index < length {
            let currentQuestion = questionnaire[index]
            question = currentQuestion.label
            answerChoices = currentQuestion.answers
        }
    }
    
    func selectAnswer(answer: String) {
        answerSelected = true
        if answer == "Yes" {
            score += 1
        }
    }
}
