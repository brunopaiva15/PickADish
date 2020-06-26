//
//  detailsViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 12.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit
import SafariServices
import SPAlert

class detailsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var foodText: UILabel!
    @IBOutlet weak var openWebButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Appliquer les styles aux objets
        foodText.text = ActualFood.getFoodName()
        
        // Changer les couleurs
        changeColors()
        
        // Si l'objet est déjà dans les favoris, remplir l'étoile des favoris, sinon non
        let favourites = UserDefaults.standard.object(forKey: "PAD_FAVOURITES") as? [String]
        if favourites?.contains(foodText.text!) == true {
            if #available(iOS 13.0, *) {
                favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }
        else
        {
            if #available(iOS 13.0, *) {
                favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    // Fonction qui détecte le changement du mode sombre au mode clair et inversement
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)

           guard UIApplication.shared.applicationState == .inactive else {
               return
           }

           changeColors()
       }
    
    // Fonction qui détecte si le bouton pour ouvrir le lien a été cliqué
    @IBAction func openWebTapped(_ sender: Any) {
        // Ouvrir le lien
        showSafariVC(for: ActualFood.getFoodUrl())
    }
    
    // Fonction qui détecte si le bouton pour partager le lien a été cliqué
    @IBAction func shareTapped(_ sender: Any) {
        // Ouvrir la share sheet
        openShareSheet(ActualFood.getFoodUrl())
    }
    
    // Fonction qui permet d'ouvrir un lien
    func showSafariVC(for url: String) {
        // Si le réglage pour ouvrir les liens dans l'application est activé, ouvrir le lien dans l'application
        if UserDefaults.standard.bool(forKey: "PAD_OPENINAPP") == true {
            guard let url = URL(string: url) else {
                return
            }
            
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        }
        // Sino, ouvrir le lien dans l'application Safari
        else {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    // Fonction simplifiée de changement de couleurs quand celles-ci ne sont pas activées
    func changeColors() {
        // Si l'appareil iOS est sous iOS 13, obtenir la couleur du thème clair ou sombre, sinon mettre le fond en blanc
        if #available(iOS 13.0, *) {
            let color1 = UIColor.systemBackground
            self.view.backgroundColor = color1
        }
        else
        {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    // Fonction qui permet d'ouvrir la share sheet
    func openShareSheet(_ text: String) {
        
        // Préparer l'activité du ViewController
        let textToShare = [ "Découvre ce plat trouvé sur PickADish ! " + text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // Afficher le ViewController
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // Déterminer quand le bouton favori a été cliqué
    @IBAction func favouriteTapped(_ sender: Any) {
        // Placer le tableau des favoris dans une constante
        let favourites = UserDefaults.standard.object(forKey: "PAD_FAVOURITES") as? [String]
        // Si le nom du plat est déjà dans les favoris, avertir l'utilisateur
        if favourites?.contains(foodText.text!) == true {
            SPAlert.present(title: "Déjà ajouté aux favoris", preset: .error)
        }
        // Sinon, ajouter le plat dans les favoris
        else
        {
            SettingsBundleHelper.AddDishToFavourites(dish: foodText.text!)
            SPAlert.present(title: "Ajouté aux favoris", preset: .done)
            if #available(iOS 13.0, *) {
                // Mettre à jour l'image des favoris avec une étoile remplie
                favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }
    }
    

}
