//
//  TarotDescriptionViewController.swift
//  Random
//
//  Created by T800 on 8/30/20.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class TarotDescriptionViewController: UIViewController {
    @IBOutlet weak var tarotImage: UIImageView!
    @IBOutlet weak var tarotName: UILabel!
    @IBOutlet weak var tarotDescription: UILabel!
    
    var imageToSet: UIImage?
    var dataModel: TarotDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
    }
    
    func initalSetup() {
        tarotImage.image = imageToSet ?? UIImage()
        tarotName.text = dataModel?.name
        tarotDescription.text = dataModel?.description
    }
    
    @IBAction func onTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
