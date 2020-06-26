//
//  choiceViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 14.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit

class choiceViewController: UIViewController {
    
    @IBOutlet weak var btnEntrees: UIButton!
    @IBOutlet weak var btnPlats: UIButton!
    @IBOutlet weak var btnDesserts: UIButton!
    @IBOutlet weak var btnBoissons: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var btnFavourites: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnEntrees.layer.cornerRadius = 22
        btnPlats.layer.cornerRadius = 22
        btnDesserts.layer.cornerRadius = 22
        btnBoissons.layer.cornerRadius = 22
        
        changeColors()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeColors()
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "PAD_TAPTIC") == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    @IBAction func entreesTapped(_ sender: Any) {
        SettingsBundleHelper.SetType(type: "Entrées")
    }
    
    @IBAction func platsTapped(_ sender: Any) {
        SettingsBundleHelper.SetType(type: "Plats")
    }
    
    @IBAction func dessertsTapped(_ sender: Any) {
        SettingsBundleHelper.SetType(type: "Desserts")
    }
    
    @IBAction func boissonsTapped(_ sender: Any) {
        SettingsBundleHelper.SetType(type: "Boissons")
    }
    
    func changeColors() {
        var color1: UIColor
        var color2: UIColor
        
        if #available(iOS 13.0, *) {
           color1 = UIColor.systemBackground
        }
        else
        {
            color1 = UIColor.white
        }
        
        let ciColor = CIColor(color: color1)
    
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        
        btnEntrees.backgroundColor = color2
        btnPlats.backgroundColor = color2
        btnDesserts.backgroundColor = color2
        btnBoissons.backgroundColor = color2
        
        if #available(iOS 13.0, *) {
           btnSettings.tintColor = color2
           btnFavourites.tintColor = color2
        }
        
        btnEntrees.setTitleColor(color1, for: .normal)
        btnPlats.setTitleColor(color1, for: .normal)
        btnDesserts.setTitleColor(color1, for: .normal)
        btnBoissons.setTitleColor(color1, for: .normal)
        
        navigationController?.navigationBar.barTintColor = color1
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
        navigationController?.navigationBar.tintColor = color2
        self.view.backgroundColor = color1
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeColors()
    }
    
    func changeColorsWithColors () {
        var color1: UIColor
        var color2: UIColor
        var contrastRatio: Double
        
        if #available(iOS 13.0, *) {
           color1 = UIColor.systemBackground
        }
        else
        {
            color1 = UIColor.white
        }
                
        repeat {
            color1 = generateRandomPastelColor(withMixedColor: UIColor.random())
            
            let ciColor = CIColor(color: color1)
        
            let compRed: CGFloat = 1.0 - ciColor.red
            let compGreen: CGFloat = 1.0 - ciColor.green
            let compBlue: CGFloat = 1.0 - ciColor.blue
        
            color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        
            contrastRatio = Double(UIColor.contrastRatio(between: color1, and: color2))
            
        } while contrastRatio < 2.5
        
        btnEntrees.backgroundColor = color2
        btnPlats.backgroundColor = color2
        btnDesserts.backgroundColor = color2
        btnBoissons.backgroundColor = color2
        
        btnSettings.tintColor = color2
        btnFavourites.tintColor = color2
        
        btnEntrees.setTitleColor(color1, for: .normal)
        btnPlats.setTitleColor(color1, for: .normal)
        btnDesserts.setTitleColor(color1, for: .normal)
        btnBoissons.setTitleColor(color1, for: .normal)
        
        self.view.backgroundColor = color1
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        changeColors()
    }
    
    func generateRandomPastelColor(withMixedColor mixColor: UIColor?) -> UIColor {
        // Randomly generate number in closure
        let randomColorGenerator = { ()-> CGFloat in
            CGFloat(arc4random() % 256 ) / 256
        }
            
        var red: CGFloat = randomColorGenerator()
        var green: CGFloat = randomColorGenerator()
        var blue: CGFloat = randomColorGenerator()
            
        // Mix the color
        if let mixColor = mixColor {
            var mixRed: CGFloat = 0, mixGreen: CGFloat = 0, mixBlue: CGFloat = 0;
            mixColor.getRed(&mixRed, green: &mixGreen, blue: &mixBlue, alpha: nil)
            
            red = (red + mixRed) / 2;
            green = (green + mixGreen) / 2;
            blue = (blue + mixBlue) / 2;
        }
            
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }

    var iteration = 0
    func darkModeChange() {
        iteration = iteration == Int.max ? 0 : (iteration + 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if UserDefaults.standard.bool(forKey: "PAD_COLORS") == false {
                    self.changeColors()
                }
                else
                {
                    self.changeColorsWithColors()
                }
                self.darkModeChange()
            })

        }
    }
