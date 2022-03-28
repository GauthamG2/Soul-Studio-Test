//
//  Extension.swift
//  SoulStudio
//
//  Created by Gautham Sritharan on 2022-03-28.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    func setImageWithUrl(_ urlString: String, placeholderImage: UIImage = UIImage()) {
        if let url = URL(string: urlString) {
            self.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
    
    // If you need to find the size of an aspect fit image inside its image view
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

// MARK: - UIView
extension UIView {
    
    func addLayerEffects(with borderColor: UIColor? = nil, borderWidth: CGFloat = 0.0, cornerRadius: CGFloat = 0.0) {
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func circularView() {
        self.layer.cornerRadius = self.layer.bounds.width / 2
        self.clipsToBounds = true
    }
    
    func customTextField() {
        self.layer.borderColor = #colorLiteral(red: 0.7214964032, green: 0.721619308, blue: 0.72148031, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7
    }
    
    func customButton() {
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.8)
    }
    
    func customView() {
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.8)
    }
    
    func customButtonTwo() {
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.7992371818)
    }
    
    func addShadow(offSet: CGFloat = 2.0, color: UIColor = .black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offSet, height: offSet)
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = false
        self.layer.masksToBounds = false
    }
    
    func addViewShadow(offSet: CGFloat = 2.0, color: UIColor = .black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offSet, height: offSet)
        self.layer.shadowOpacity = 0.5
        self.layer.shouldRasterize = false
        self.layer.masksToBounds = false
    }
    
    func addShadowAllSide(radius: CGFloat = 4.0, color: UIColor = .lightGray) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = false
        self.layer.masksToBounds = false
    }
    
    func addBottomShadow(shadowHeight: CGFloat = 5) {
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0 , height:1)
//        self.layer.shadowOpacity = 1
//        self.layer.shadowRadius = 1
//        self.layer.masksToBounds = false
//
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = 1
//        self.layer.shadowOpacity = 1
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0 , height:1)
        
        
        let shadowPath = UIBezierPath()
        
        shadowPath.move(to: CGPoint(x: 0, y: layer.bounds.height))
            shadowPath.addLine(to: CGPoint(x: layer.bounds.width, y: layer.bounds.height))
            shadowPath.addLine(to: CGPoint(x: layer.bounds.width, y: layer.bounds.height + shadowHeight))
            shadowPath.addLine(to: CGPoint(x: 0, y: layer.bounds.height + shadowHeight))
            shadowPath.close()
        
//        shadowPath.move(to: CGPoint(x: layer.bounds.origin.x, y: layer.frame.size.height))
//        shadowPath.addLine(to: CGPoint(x: someView.bounds.width / 2, y: someView.bounds.height + 7.0))
//        shadowPath.addLine(to: CGPoint(x: layer.bounds.width, y: layer.bounds.height))
//        shadowPath.close()

        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowRadius = 5
    }
    
    func addTopShadow(shadowColor : UIColor, offset: CGFloat = 2.0){
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOffset = CGSize(width: offset, height: offset)
        self.layer.shadowOpacity = 1
            self.layer.shadowRadius = 5
            self.clipsToBounds = false
        }
    
    func convertToImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImageFromMyView!
    }
    
    func applyGradient(isTopBottom: Bool, colorArray: [UIColor]) {
        if let sublayers = layer.sublayers {
            let _ = sublayers.filter({ $0 is CAGradientLayer }).map({ $0.removeFromSuperlayer() })
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isTopBottom {
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //leftRight
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = self.bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, colorThree: UIColor, colorFour: UIColor, colorFive: UIColor, colorSix: UIColor, colorSevemn: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor, colorFour.cgColor ]
        //gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func addShadowButton(offSet: CGFloat = 1.0, color: UIColor = .black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offSet, height: offSet)
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
    }
    
    func addDashedBorder(with color: UIColor, lineWidth: CGFloat, cornerRadius: CGFloat, patern: [NSNumber]) {
        
        let color = color.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = patern
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }
    
    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
}
