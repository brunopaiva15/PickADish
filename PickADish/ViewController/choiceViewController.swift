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
        
        // Appliquer les styles aux objets
        btnEntrees.layer.cornerRadius = 22
        btnPlats.layer.cornerRadius = 22
        btnDesserts.layer.cornerRadius = 22
        btnBoissons.layer.cornerRadius = 22
        
        // Changer les couleurs
        changeColors()
        
    }
    
    // Fonction qui détecte quand la vue apparaît
    override func viewDidAppear(_ animated: Bool) {
        // Changer les couleurs
        changeColors()
    }
    
    // Fonction qui détecte quand la vue va apparaître
    override func viewWillAppear(_ animated: Bool) {
        // Changer les couleurs
        changeColors()
    }
    
    // Fonction qui détecte quand les paramètres sont cliqués et génère une vibration si celles-ci sont activées
    @IBAction func settingsTapped(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "PAD_TAPTIC") == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    // Fonction qui détecte quand les favoris sont cliqués et génère une vibration si celles-ci sont activées
    @IBAction func favouritesTapped(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "PAD_TAPTIC") == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
    }
    
    // Fonction qui ouvrent le plat demandé
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
    
    // Fonction qui génère le changement de couleur lorsque celles-ci ne sont pas activées
    func changeColors() {
        var color1: UIColor
        var color2: UIColor
        
        // Si l'appareil iOS est sous iOS 13, obtenir la couleur du thème clair ou sombre, sinon mettre le fond en blanc
        if #available(iOS 13.0, *) {
           color1 = UIColor.systemBackground
        }
        else
        {
            color1 = UIColor.white
        }
        
        // Obtenir l'inverse de la couleur principale
        let ciColor = CIColor(color: color1)
    
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        
        color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        
        // Mettre la couleur inversée pour les boutons et les titres de la navigation
        btnEntrees.backgroundColor = color2
        btnPlats.backgroundColor = color2
        btnDesserts.backgroundColor = color2
        btnBoissons.backgroundColor = color2
        btnSettings.tintColor = color2
        btnFavourites.tintColor = color2
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
        navigationController?.navigationBar.tintColor = color2
        
        // Pour tout le reste, mettre la couleur principale
        btnEntrees.setTitleColor(color1, for: .normal)
        btnPlats.setTitleColor(color1, for: .normal)
        btnDesserts.setTitleColor(color1, for: .normal)
        btnBoissons.setTitleColor(color1, for: .normal)
        navigationController?.navigationBar.barTintColor = color1
        self.view.backgroundColor = color1
    }
    
    // Fonction qui détecte le changement du mode sombre au mode clair et inversement
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        changeColors()
    }
}
