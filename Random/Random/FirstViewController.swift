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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func initialSetup() {
        userName.delegate = self
        nameErrorMessage.isHidden = true
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        takeMeToNextScreen()
    }
    
    func isNameValid() -> Bool {
        guard let _ = userName.text else { return false }
        return true
    }
    
    func takeMeToNextScreen() {
        if(!isNameValid()) { return }
        
    }
    
}

extension NameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        takeMeToNextScreen()
        return true
    }
}

