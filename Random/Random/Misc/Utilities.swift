//
//  Utilities.swift
//  Random
//
//  Created by T800 on 8/30/20.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func flipImageVertically() -> UIImage {
        var flipimageorientation = (self.imageOrientation.rawValue + 4)%8
        flipimageorientation = flipimageorientation + flipimageorientation%2==0 ? 1:-1
        let flippedImage = UIImage (cgImage:self.cgImage!,scale:self.scale,orientation:UIImage.Orientation.downMirrored)
        return flippedImage
    }
}
