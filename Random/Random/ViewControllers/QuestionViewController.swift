//
//  QuestionViewController.swift
//  Random
//
//  Created by GeekyEntity on 8/23/20.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var questionErrorMessage: UILabel!
    @IBOutlet weak var question: UITextField!
    let userNameTextToPrependWith = "Hello, "
    let segue = "questionToTarotDisplayStoryboard"
    var nameEnteredByUser:String?
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            initialSetup()
        }
        
        func initialSetup() {
            question.delegate = self
            questionErrorMessage.isHidden = true
            userName.text = "\(userNameTextToPrependWith)\(nameEnteredByUser!)"
        }

        @IBAction func nextButtonTapped(_ sender: Any) {
            takeMeToNextScreen()
        }
    
        func isQuestionValid() -> Bool {
            var isValid:Bool = true
            guard let name = question.text else {
                isValid = false
                questionErrorMessage.isHidden = true
                return isValid
            }
            if name.count <= 0 {
                isValid = false
            }
            questionErrorMessage.isHidden = isValid
            return isValid
        }
        
        func takeMeToNextScreen() {
            if(!isQuestionValid()) { return }
            performSegue(withIdentifier: segue, sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tarotDisplayerViewConteroller = segue.destination as? TarotDisplayerViewController {
            tarotDisplayerViewConteroller.nameEnteredByUser = nameEnteredByUser
        }
    }
    
}

extension QuestionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        takeMeToNextScreen()
        return true
    }
}
