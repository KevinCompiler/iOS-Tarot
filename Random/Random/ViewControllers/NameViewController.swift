//
//  ViewController.swift
//  Random
//
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var nameErrorMessage: UILabel!
    @IBOutlet weak var userName: UITextField!
    let segue = "nameToQuestionViewControllerSegue"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    func initialSetup() {
        userName.delegate = self
        nameErrorMessage.isHidden = true
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        takeMeToNextScreen()
    }
    
    func isNameValid() -> Bool {
        var isValid:Bool = true
        guard let name = userName.text else {
            isValid = false
            nameErrorMessage.isHidden = true
            return isValid
        }
        if name.count <= 0 {
            isValid = false
        }
        nameErrorMessage.isHidden = isValid
        return isValid
    }
    
    func takeMeToNextScreen() {
        if(!isNameValid()) { return }
        performSegue(withIdentifier: segue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController {
            questionViewController.nameEnteredByUser = userName.text
        }
    }
}

extension NameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        takeMeToNextScreen()
        return true
    }
}

