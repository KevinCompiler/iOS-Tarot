//
//  TarotDisplayerViewController.swift
//  Random
//
//  Created by GeekyEntity on 8/23/20.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit
import Foundation

class TarotDisplayerViewController: UIViewController {
    @IBOutlet weak var loadOverlay: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var cardPickingText: UILabel!
    @IBOutlet weak var loadingProgressView: UIProgressView!
    
    @IBOutlet weak var pastTarotImageView: UIImageView!
    @IBOutlet weak var presentTarotImageView: UIImageView!
    @IBOutlet weak var futureTarotImageView: UIImageView!
    
    @IBOutlet weak var pastTarotCardNameLabel: UILabel!
    @IBOutlet weak var presentTarotCardNameLabel: UILabel!
    @IBOutlet weak var futureTarotCardNameLabel: UILabel!
    
    let pastTarot = Int.random(in: 1...44)
    let presentTarot = Int.random(in: 1...44)
    let futureTarot = Int.random(in: 1...44)
    
    let prependNameWith = "Hello, "
    let cardPickingArray = ["Picking Your Cards.", "Picking Your Cards..", "Picking Your Cards..."]
    let indicatorIncreasingStep: Float = 3/(100)
    
    var currentCardPickingTextIndex = 0
    var nameEnteredByUser: String?
    var currentProgressPercentage: Float = 0.0
    
    let segue = "segueToDescriptionViewController"
    
    var cardPickingTimer: Timer?
    var progressUpdater: Timer?
    
    var dispatchGroup: DispatchGroup!
    
    var dataModel: [TarotDetails]?
    
    var selectedIndex: Int?
    var selectecdImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
        dispatchGroup.notify(queue: .main, execute: { [weak self] in
            self?.setLabels()
        })
    }
    
    func initialSetup() {
        dispatchGroup = DispatchGroup()
        getDataFromJson()
        debugPrint(pastTarot)
        debugPrint(presentTarot)
        debugPrint(futureTarot)
        setName()
        setTarotCardImages()
        cardPickingTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(TarotDisplayerViewController.startCardPickingTimer), userInfo: nil, repeats: true)
        progressUpdater = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TarotDisplayerViewController.updateProgressStatus), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.hideLoadingOverlay()
            self?.stopTimers()
        })
        loadingProgressView.setProgress(currentProgressPercentage, animated: true)
        setAlphaValueForImageAndLabel(alpha: 0)
    }
    
    func setAlphaValueForImageAndLabel(alpha:CGFloat) {
        pastTarotImageView.alpha = alpha
        presentTarotImageView.alpha = alpha
        futureTarotImageView.alpha = alpha
        
        pastTarotCardNameLabel.alpha = alpha
        presentTarotCardNameLabel.alpha = alpha
        futureTarotCardNameLabel.alpha = alpha
    }
    
    func setLabels() {
        pastTarotCardNameLabel.text = dataModel?[pastTarot-1].name ?? ""
        presentTarotCardNameLabel.text = dataModel?[presentTarot-1].name ?? ""
        futureTarotCardNameLabel.text = dataModel?[futureTarot-1].name ?? ""
    }
    
    func getDataFromJson() {
        let fileName = "AngelTarot"
        let fileExtension = "json"
        let file = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        dispatchGroup.enter()
        JsonDeserializer.getJsonArrayFromFile(fromFile: file!) { [weak self] (tarotData:TarotDataModel) in
            self?.dataModel = tarotData.tarots
            self?.dispatchGroup.leave()
        }
    }
    
    func setName() {
        userName.text = "\(prependNameWith)\(nameEnteredByUser!)"
    }
    
    func stopTimers() {
        cardPickingTimer?.invalidate()
        progressUpdater?.invalidate()
    }
    
    @objc func startCardPickingTimer() {
        cardPickingText.text = cardPickingArray[currentCardPickingTextIndex]
        currentCardPickingTextIndex = currentCardPickingTextIndex + 1
        if currentCardPickingTextIndex > 2 {
            currentCardPickingTextIndex = 0
        }
    }
    
    @objc func updateProgressStatus() {
        currentProgressPercentage = currentProgressPercentage + indicatorIncreasingStep
        loadingProgressView.setProgress(currentProgressPercentage, animated: true)
    }
    
    func hideLoadingOverlay() {
        loadingProgressView.setProgress(1, animated: true)
        UIView.animate(withDuration: 0.75, animations: { [weak self] in
            self?.loadOverlay.alpha = 0
        }) { [weak self] (true) in
            self?.loadOverlay.isHidden = true
            UIView.animate(withDuration: 0.75) {
                self?.setAlphaValueForImageAndLabel(alpha: 1)
            }
        }
    }
    
    func setTarotCardImages() {
        pastTarotImageView.image = getImageWithId(id: pastTarot)
        presentTarotImageView.image = getImageWithId(id: presentTarot)
        futureTarotImageView.image = getImageWithId(id: futureTarot)
    }
    
    func getImageWithId(id:Int) -> UIImage? {
        let tarot = "tarot-"
        if(id > 22) {
            let reverseId = id - 22
            let image = UIImage(named: "\(tarot)\(reverseId)") ?? UIImage()
            return image.flipImageVertically()
        }
        return UIImage(named: "\(tarot)\(id)")
    }
    
    @IBAction func onTapPastTarotCard(_ sender: Any) {
        onButtonTap(id: pastTarot, image: pastTarotImageView.image ?? UIImage())
    }
    
    @IBAction func onTapPresentTarotCard(_ sender: Any) {
        onButtonTap(id: presentTarot, image: presentTarotImageView.image ?? UIImage())
    }
    
    @IBAction func onTapFutureTarotCard(_ sender: Any) {
        onButtonTap(id: futureTarot, image: futureTarotImageView.image ?? UIImage())
    }
    
    func onButtonTap(id:Int, image:UIImage) {
        selectedIndex = id-1
        selectecdImage = image
        performSegue(withIdentifier: segue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TarotDescriptionViewController {
            destination.dataModel = dataModel?[selectedIndex ?? 0]
            destination.imageToSet = selectecdImage ?? UIImage()
        }
    }
}
