//
//  ViewController.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 08.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit
import SafariServices
import Intents

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var foodText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet var swipeToRightRecognizer: UISwipeGestureRecognizer!
    @IBOutlet var swipeToLeftRecognizer: UISwipeGestureRecognizer!
    
    let entrees = ["Foie gras", "Huîtres", "Escargots au beurre persillé", "Steak tartare", "Soufflé au fromage", "Soupe à l'oignon", "Velouté de potiron et carottes", "Salade de concombre au chèvre et olives", "Oeufs mimosa", "Caviar d'aubergines", "Soupe aux légumes", "Cake au thon", "Soupe à l'oignon", "Quiche aux poireaux", "Flan de courgettes", "Cake aux olives", "Soupe d'endives", "Fougasse aux herbes", "Quiche sans oeufs", "Salade composée au thon", "Salade césar", "Space cake", "Quiche multicolore", "Oeufs cuits", "Chausson aux épinards", "Fougasse aux oignons", "Soupe d'endives à la bière", "Terrine de jambon aux courgettes", "Soupe d'orties", "Poireaux à la vinaigrette", "Terrine de foie gras", "Salade de pâtes", "Salade allemande aux pommes de terre", "Quiche à la tomate", "Gaspacho", "Velouté d'endives à la crème", "Salade de pâtes au crabe", "Salade exotique au pamplemousse", "Salade de céleri", "Salade de haricots blancs", "Feuilleté", "Rouleaux de printemps", "Tartare de thon", "Salade de pâtes au basilic", "Soupe de betteraves rouges", "Tortilla au thon", "Salade d'endives", "Potage à la courge", "Minestrone d'automne", "Salade tomates-mozzarella", "Salade de carottes", "Salade de concombres", "Coleslaw", "Salade grecque", "Salade niçoise", "Taboulé", "Salade de saucisse", "Oeufs au plat", "Oeufs brouillés aux herbes", "Oeufs Bénédicte", "Salade de légumes", "Rösti", "Quiche au fromage", "Salade d'avocat", "Oeufs à la russe", "Salade alsacienne", "Gaspacho aux crevettes", "Salade chinoise au crabe", "Quiche aux poivrons", "Melon en salade", "Quiche aux lardons", "Oeuf cocotte au bacon", "Salade de pâtes d'été", "Tartines à l'italienne", "Oeuf cocotte en fromage", "Macarons de champignons", "Bowl d'hiver", "Soupe de cresson", "Quiche au saumon fumé", "Poires au roquefort", "Foie gras mi-cuit", "Salade d'asperges aux pignons", "Soupe au choux", "Soupe de champignons", "Soupe de pois cassés", "Soupe glacée au concombre", "Carpaccio d'aubergines", "Soupe aux 7 légumes", "Feuillantine", "Soupe au chou vert", "Soupe chinoise au poulet", "Carpaccio de saumon fumé", "Sashimi de saumon", "Sashimi de thon", "Salade Thaï", "Carpaccio de boeuf", "Tartare de saumon"]

    let plats = ["Huîtres", "Cassoulet", "Poulet basquaise", "Mouclade charentaise", "Galettes bretonnes", "Carbonnade flamande", "Raclette", "Fondue savoyarde", "Gratin dauphinois", "Tartiflette", "Ratatouille", "Boeuf bourguignon", "Blanquette de veau", "Pot-au-feu", "Coq-au-vin", "Hachis parmentier", "Steak tartare", "Choucroute", "Cuisses de grenouille", "Sushis", "California rolls", "Pizza" , "Empanadas", "Raviolis chinois", "Katsu" , "Bulgogi", "Tarte au thon", "Pissaladière", "Tacos mexicains", "Tarte à l'ail des ours", "Samoussa au boeuf", "Saumon en papillote aux petits légumes", "Gratin de courgettes", "Asperges rôties au parmesan", "Spaghettis à la bolognaise", "Poulet aux écrevisses", "Poulet thaïlandais au curry rouge et curry vert", "Pizza aux poires", "Purée d'aubergines", "Curry de crevettes", "Poisson en papillote", "Boulettes de viande farcies", "Boulettes de viande suédoises", "Gratin de légumes", "Lasagne", "Blanquette de dinde", "Tajine de poulet au citron", "Nouilles chinoises", "Poulet fumé", "Légumes au barbecue", "Nouilles sautées aux légumes", "Boulettes de viande à la marocaine", "Croquettes de boeuf", "Daube de sanglier", "Magret de canard", "Pommes de terre sautées", "Macaronis aux trois fromages", "Brochettes de poulet au miel", "Risotto aux petits pois", "Filet mignon aux morilles", "Tomates provençales", "Blanc de poulet aux endives", "Paupiette de poisson au chou", "Cannellonis aux légumes", "Blanquette de dinde", "Escalope de volaille", "Brandade de morue", "Tarte au saumon et aux épinards", "Rillettes aux deux saumons", "Tartare de thon", "Agneau en sauce épicée", "Gambas au citron", "Risotto de courgettes aux tomates", "Noix de Saint-Jacques", "Vermicelles chinoises", "Pigeonneaux rôtis aux épices", "Ragoût de lentilles au boeuf", "Soupe asiatique aux nouilles et au tofu", "Salade tiède de lentilles", "Omelette", "Purée de pomme de terre", "Galettes de pomme de terre", "Rösti", "Gnocchi", "Spaghetti carbonara", "Hachis aux cornettes", "Gratin de cornettes", "Spätzlis", "Riz Casimir", "Pilaf d'agneau à l'orientale", "Riz cantonais", "Paella aux fruits de mer", "Risotto aux fines herbes", "Polenta au fromage", "Couscous", "Salimbocca", "Paupiettes", "Escalope et sauce aux herbes", "Cordon-bleu", "Vol-au-vent aux quenelles", "Foie de veau aux oignons", "Galettes de viande hachée", "Chili con carne", "Ragoût de veau et pommes de terre écrasées", "Poulet au citron", "Rôti", "Truite aux herbes", "Brochettes de crevettes grillées", "Bar en croûte de sel", "Filets de cabillaud", "Prussiens au jambon cru", "Tartiflette aux amandes", "Langue de mouton à la bordelaise", "Riz à la mexicaine", "Curry de crevettes", "Mousse de cabillaud", "Cannellonis aux fruits de mer", "Poisson pané", "Gratin de poisson forestier", "Gratin de moules", "Casserole de légumes aux lentilles", "Crumble de ratatouille au poulet", "Papillotes de poisson", "Ragoût de porc", "Feuilletés au saumon", "Truite au four", "Nouilles sautées aux crevettes", "Salade tunisienne cuite", "Boeuf Tex Mex", "Tarte au chèvre", "Pain au saumon", "Filet de poisson et crème à l'ail", "Risotto aux moules", "Bouchées de lentilles", "Tarte paysanne aux champignons", "Tajine façon couscous", "Limandes panées sans gluten", "Tarte aux légumes frais", "Osso bucco", "Porc aigre doux", "Curry végétarien", "Viande à l'indienne", "Pizza campagnarde", "Carottes à l'orientale", "Cailles farcies", "Faisan farci aux fruits", "Soupe de bouillon thaï", "Canja au poulet", "Poulet au curry", "Poulet au piri-piri", "Penne à la vodka", "Flan de tomates", "Falafels", "Gratin de raviolis", "Rôti de porc", "Courgettes rondes farcies", "Rösti de pomme de terre crues", "Gratin de potiron", "Huîtres chaudes au champagne", "Gigot ou épaule d'agneau au miel et thym", "Endives au jambon", "Nems (frits)", "Canard à l'orange", "Hamburger au barbecue", "Tresse tartiflette", "Roulé de jambon aux haricots verts", "Carottes rôties", "Nuggets de poulet", "Civet de sanglier", "Gratin de chou-fleur", "Pizza roulée", "Samoussa au thon", "Camembert frit", "Feta grillée au sésame et au miel", "Foie gras poêlé à la mangue", "Oeufs à la tomate et chorizo", "Wrap à l'italienne", "Asperges feuilletées au bacon", "Amour de saumon en papillote", "Croque-pizza", "Riz sauté à l'ananas", "Gnocchi à l'italienne", "Homard grillé aux épices fines", "Pizza façon chinois", "Bar au four", "Fajitas au poulet", "Coq au vin maison", "Rôti de veau au four", "Rosbeef au four à l'ail", "Crevettes à l'ail", "Filet de boeuf en croûte", "Lapin à la moutarde", "Gratin de potimarron", "Croquemonsieur au chou-fleur", "Saltimbocca de veau", "Rôti de lotte au lard", "Tian aux légumes", "Lasagnes au saumon", "Risotto aux trois champignons", "Cannellonis de viande", "Endives surprise", "Dinde farcie aux marrons", "Cuisses de poulet en papillote", "Truite saumonée en croûte", "Gratin d'aubergines", "Croque madame", "Bagel mexicain", "Pizza au saumon", "Purée de carottes au bouillon de poule", "Hot Dog", "Gâteau de pommes de terre", "Risotto à la crème de poivrons", "Croque monsieur d'aubergines", "Saucisses aux lentilles", "Pizza à l'ananas (beurk)", "Petit salé aux lentilles", "Saumon en papillote avec fondue de poireaux", "Galettes de blé noir", "Soupe chinoise au poulet", "Frittata aux courgettes", "Curry de pois chiches", "Vol-au-vent aux blancs de poulet", "Pintade aux pêches blanches", "Chapon poché et rôti", "Boeuf braisé aux carottes", "Confit de canard", "Boeuf aux oignions", "Fish & Chips", "Nems au poulet", "Nems au porc", "Nems à la crevette", "Gyoza", "Bouchées vapeur", "Steak de requin", "Saumon grillé au four", "Sashimi de saumon", "Sashimi de thon", "Brochettes boeuf cheese", "Porc au caramel", "Travers de porc caramélisé", "Crevettes à la sauce piquante", "Raviolis frits", "Crevettes tempura", "Beignets de Saint Jacques", "Beignets de calamar", "Pinces de crabe frits", "Beignets de crevette", "Soupe phô", "Kebab d’agneau", "Tartare de saumon", "Riz pilaf", "Poulet à la citronnelle"]

    let desserts = ["Croissants", "Fondant au chocolat", "Tarte Tatin", "Macarons", "Crème brûlée", "Île flottante", "Profiteroles", "Cookies", "Tarte aux pralines", "Tiramisu aux spéculoos", "Panna cotta aux fraises", "Crêpes", "Gâteaux aux carottes", "Petits milanais", "Biscuits sablés vegan", "Crumble aux pommes", "Gâteau aux noix", "Perles du japon au chocolat", "Clémentines à la russe", "Gâteau au chocolat", "Pasteis de nata", "Gâteau suisse à la rhubarbe", "Omelette sucrée", "Omelette norvégienne", "Flan", "Brioche", "Tresse briochée", "Panna cotta au carambar", "Pancakes", "Crème de citron", "Cigarettes russes", "Crème de bananes", "Chocolat chaud", "Yaourt maison", "Donuts", "Cookies aux pralines caramélisées", "Sorbet à la fraise", "Clafoutis aux cerises", "Cheesecake", "Cake aux pruneaux", "Salade d'oranges", "Crêpes à l'ananas et à l'orange", "Moelleux aux noix", "Bolo Rei", "Tarte au Nutella", "Riz au lait", "Charlotte au chocolat", "Muffins aux myrtilles", "Forêt noire", "Meringues", "Flan à la semoule", "Porridge à la banane", "Mug cake", "Streusel aux poires", "Gâteau au citron", "Tresse russe", "Strudel aux pommes", "Beignets aux pommes", "Biscuit roulé à la fraise", "Éclairs à la fraise", "Éclairs au chocolat", "Tarte aux abricots", "Gaufres", "Bruns", "Sablés fruités à la confiture", "Étoiles à la cannelle", "Demi-lunes à l'orange", "Bâtonnets au chocolat et au caramel", "Sablés aux pistaches", "Flan au caramel", "Pudding au chocolat", "Sabayon", "Crème à la vanille", "Crème au caramel", "Sorbet aux fraises", "Parfait à la vanille", "Tartelette aux vermicelles", "Gelée de raisins", "Confiture de fraises", "Compote de pommes", "Poires confites", "Pommes aux épices", "Salade de fruits", "Tarte aux poires", "Gâteau moelleux à la pomme", "Poires au miel", "Gâteau aux groseilles", "Mousse au chocolat et chantilly", "Mille feuille au chocolat", "Financiers à la noix de coco", "Gâteau breton à la confiture", "Cupcakes à la vanille", "Oeufs au lait", "Charlotte tropicale", "Orange sanguine meringuée", "Salade de grenades aux abricots", "Cookies américains", "Cake à l'orange", "Charlotte aux fraises", "Tarte à la banane", "Tresse jurassienne", "Gâteau à la confiture", "Gros gâteau aux OREO", "Pain d'épices", "Gratin de raisins", "Cake aux fruits confis", "Crumble aux mûres", "Brownies aux fruits rouges", "Bûche au mascarpone", "Tarte aux abricots", "Brick de pommes au caramel salé", "Poires pochées au chocolat", "Tiramisu aux fraises", "Crumble aux pommes et aux coings", "Gâteau au yaourt au citron", "Poires pochées au chocolat", "Tiramisu en cheesecake", "Frites de cookie", "Gâteau aux figues et aux noix", "Brownies", "Cônes sapin au chocolat", "Crème renversée au caramel", "Gâteau moelleux à la crème de marron", "Madeleines au coeur de Nutella", "Confiture à la mûre", "Perles de coco", "Crêpes à la bière", "Sphère au chocolat garnie ", "Carrés au citron", "Soupe de framboise", "Mendiants", "Duchesses", "Beurre de cacahuète", "Moelleux au praliné", "Crème de caramel au beurre salé", "Coulis de framboises", "Choux à la crème", "Financiers au thé vert", "Tarte aux prunes", "Kiwis au gingembre", "Coulant tiède au chocolat", "Cappuccino de fraises en verrines", "Cake au chocolat en bocal", "Gâteaux aux noisettes", "Tarte au citron", "Carrés aux dattes moelleux", "Clafoutis aux abricots", "Bavarois aux fraises sur génoise", "Gâteau au yaourt et caramel beurre salé", "Cigarettes feuilletées au chocolat", "Flan aux oeufs", "Brownies fantômes", "Beignets de banane", "Bananasplit", "Cake aux pommes", "Cupcakes natures", "Timbale de framboises", "Mousse aux marrons", "Cheesecake café et amaretti", "Chaussons de prunes", "Pommes au four", "Langues de chat", "Popcorn caramélisé", "Mousse au chocolat onctueuse", "Frangipane", "Crêpes (sans lait)", "Galette des rois", "Flan aux pommes et aux pruneaux", "Gaufres liégeoises", "Compote épicée", "Châtaignes au four", "Granité aux fraises", "Pain au lait", "Poke cake", "Cake au citron", "Biscuit façon crème brûlée", "Knödels aux prunes", "Oranais aux abricots", "Sorbet à la figue", "Nougat glacé", "Dalmatien roulé", "Pim's géant", "Biscuits sablés au beurre", "Cake aux raisins secs et au rhum ", "Verrine de fraises aux spéculoos", "Gateau au Daim", "Crème anglaise", "Gingembre confit", "Glace au café"]

    let boissons = ["Mojito cubain", "Vin chaud", "Vodka à l'orange", "Vin de rhubarbe", "Sangria", "Liqueur aux plantes", "Mojito", "Sirop de citron", "Cocktail au limoncello", "Smoothie au lait de coco", "Smoothie glacé", "Thé à la menthe marocain", "Cappuccino glacé au melon", "Milkshake aux cookies", "Sirop de menthe", "Cappuccino glacé au melon", "Pina Colada", "Sex on the Beach", "Caipirinha", "Sirop de cassis", "Smoothie aux fraises", "Milkshake à la fraise", "Milkshake à la banane", "Granita aux framboises", "Chocolat chaud", "Américano", "Blue Lagon", "Jus de pomme", "Café glacé", "Frapuccino", "Jus de persil", "Sikko", "Smoothie à la cerise", "Vin de noix", "Punch exotique", "Smoothie aux myrtilles", "Liqueur de chocolat", "Thé glacé à la pêche", "Bubble tea", "Kir royal", "Ayran", "Lait d'amandes", "Jus de citron", "Cosmopolitan", "Citronnade", "Café Mocha", "Jus vitaminé", "Thé marocain", "Jus de gingembre", "Vin de cerises", "Citronnade givrée", "Smoothie au cassis", "Smoothie japonais", "Tonic au café", "Sirop au citron", "Punch aux fruits", "Citronnade givrée", "Jus de Bouye", "Smoothie à la rhubarbe", "Limonade brésilienne", "Smoothie aux poires", "Maï-Taï", "Chocolat viennois", "Jus de pommes aux épices", "Lait de riz", "Orangeade", "Sirop de menthe", "Jus d'agrumes", "Vin de citrons", "Lait frappé à la noisette", "Eau pétillante au melon et à la fraise", ""]
    
    // Tableau qui enregistre les plats déjà vus durant la session, pour pouvoir les revoir par la suite
    var foodback: Array<String> = []
    // Variable qui contient l'URL du plat
    var urlFormatPublic: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Appliquer les styles aux objets
        generateButton.layer.cornerRadius = 22
        backButton.layer.cornerRadius = 15
        generateButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // Déterminer quel est le type du plat et ajuster le titre du ViewController
        switch UserDefaults.standard.string(forKey: "PAD_TYPE") {
            case "Entrées":
                generateButton.setTitle("Je veux une entrée !", for: .normal)
                self.title = "Entrées"
                generateButton.titleLabel?.font = UIFont(name: "SF Pro Rounded", size: 24)
            case "Plats":
                generateButton.setTitle("Je veux un plat !", for: .normal)
                self.title = "Plats"
            case "Desserts":
                generateButton.setTitle(" Je veux un dessert ! ", for: .normal)
                generateButton.titleLabel?.font = UIFont(name: "SF Pro Rounded", size: 24)
                self.title = "Desserts"
            case "Boissons":
                generateButton.setTitle(" Je veux une boisson ! ", for: .normal)
                generateButton.titleLabel?.font = UIFont(name: "SF Pro Rounded", size: 22)
                self.title = "Boissons"
            default:
                generateButton.setTitle("Je veux un plat !", for: .normal)
                self.title = "Plats"
        }
        
        // Si les vibrations ont été activées, générer une vibration
        if UserDefaults.standard.bool(forKey: "PAD_TAPTIC") == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        
        // Déterminer si le plat actuel est déjà enregistré, pour garder le plat qui était choisi par l'utilisateur avant qu'il revienne à l'accueil
        if ActualFood.foodType == self.title {
            foodText.text = ActualFood.foodName
            if UserDefaults.standard.bool(forKey: "PAD_COLORS") == true {
                changeColorsWithColors()
            }
            else {
                changeColors()
            }
        }
        
        // Si le texte est égal à l'émoji, juste changer les couleurs
        if foodText.text == "👇" {
            if UserDefaults.standard.bool(forKey: "PAD_COLORS") == true {
                changeColorsWithColors()
            }
            else {
                changeColors()
            }
        }
        
        // Afficher le nombre de plats dans la console
        print("NB ENTREES : " + String(entrees.count))
        print("NB PLATS : " + String(plats.count))
        print("NB DESSERTS : " + String(desserts.count))
        print("NB BOISSONS : " + String(boissons.count))
        print("NB TOTAL : " + String(entrees.count + plats.count + desserts.count + boissons.count))
        
        // Afficher la pop-up de départ si l'utilisateur n'a jamais ouvert l'app
        if UserDefaults.standard.bool(forKey: "PAD_SHOW_POPUP_FIRST_TIME") == true {
            let alert = UIAlertController(title: "Bienvenue !", message: "Bienvenue sur PickADish. Pour afficher la recette ou pour partager le plat avec vos amis, cliquez simplement sur celui-ci. Amusez-vous bien sur PickADish !", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "J'ai compris, merci.", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            // Ne plus afficher la pop-up les prochaines fois
            SettingsBundleHelper.SetShowPopupFirstTime(yesorno: false)
        }

    }
    
    // Lorsque la vue apparaît, configurer la fonction de détection de clic sur le label
    override func viewDidAppear(_ animated: Bool) {
        self.setupLabelTap()
    }
    
    // Lorsque la vue disparaît, enregistrer les détails du plat (nom, url et type) afin de les sauvegarder pour les réafficher lorsque l'utilisateur retourne sur le même type de plat
    override func viewDidDisappear(_ animated: Bool) {
        ActualFood.setFoodName(foodName: foodText.text!)
        urlFormatPublic = generateUrlForDish(foodName: foodText.text!)
        ActualFood.setFoodUrl(foodUrl: generateUrlForDish(foodName: foodText.text!))
        ActualFood.setFoodType(foodType: self.title!)
    }
    
    // Fonction qui prépare le terrain afin que l'application puisse reconnaître lorsque l'on clique sur le label
    func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.foodText.isUserInteractionEnabled = true
        self.foodText.addGestureRecognizer(labelTap)
    }
    
    // Fonction qui se lance lorsque le label du nom du plat est cliqué
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        // Générer l'URL pour le plat et l'enregistrer dans la classe ActualFood
        urlFormatPublic = generateUrlForDish(foodName: foodText.text!)
        ActualFood.setFoodUrl(foodUrl: urlFormatPublic)
    }
    
    // Ouvrir la page des détails
    func loadDetails() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "detailsVC") as! detailsViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    // Lorsque le bouton "Générer un plat" est cliqué, générer un nouveau plat
    @IBAction func whenGenerateTapped(_ sender: Any) {
        generateNewDish()
    }
    
    // Lorsque le bouton retour est cliqué, revenir en arrière
    @IBAction func backTapped(_ sender: Any) {
        goToBack()
    }
    
    // Fonction motrice de l'application, celle qui gère la génération des plats
    func generateNewDish() {
        // Si le nombre de plats est supérieur ou égal à 1
        if foodback.count >= 1 {
            // Si le bouton de retour est caché, ne pas mettre à jour celui-ci
            if backButton.isHidden == true {
                updateBack(false)
            }
        }
        
        // Si les vibrations ont été activées, générer une vibration
        if UserDefaults.standard.bool(forKey: "PAD_TAPTIC") == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        
        // Si les couleurs ont été activées, activer les couleurs, sinon, les désactiver (noir et blanc)
        if UserDefaults.standard.bool(forKey: "PAD_COLORS") == true {
            changeColorsWithColors()
        }
        else {
            changeColors()
        }
        
        // Ajuster la taille de la police des plats à sa largeur
        foodText.adjustsFontSizeToFitWidth = true
        
        // Déterminer le type de plat choisi et générer le plat avec ce type
        switch UserDefaults.standard.string(forKey: "PAD_TYPE") {
            case "Entrées":
                foodText.text = entrees.randomElement()
            case "Plats":
                foodText.text = plats.randomElement()
            case "Desserts":
                foodText.text = desserts.randomElement()
            case "Boissons":
                foodText.text = boissons.randomElement()
            default:
                foodText.text = plats.randomElement()
        }
        
        // Mettre à jour les informations du plat dans la classe ActualFood
        ActualFood.setFoodName(foodName: foodText.text!)
        ActualFood.setFoodType(foodType: self.title!)
        urlFormatPublic = generateUrlForDish(foodName: foodText.text!)
        ActualFood.setFoodUrl(foodUrl: generateUrlForDish(foodName: foodText.text!))
        
        // Ajouter le plat dans le tableau qui sert au bouton retour de revenir en arrière
        self.foodback.append(foodText.text!)
    }
    
    // Fonction qui gère le retour en arrière
    func goToBack() {
        // Mettre à jour les couleurs et les vibrations
        if UserDefaults.standard.bool(forKey: "PAD_COLORS") == true {
            changeColorsWithColors()
        }
        if UserDefaults.standard.bool(forKey: "PAD_TAPTIC") == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        // Si le nombre de plats dans le tableau qui se remplit lorsqu'un nouveau plat est généré est supérieur ou égal à 1, supprimer le dernier plat du tableau, actualiser le nom du plat, l'URL et son type, sinon, cacher le bouton
        if foodback.count >= 1 {
            let removed = foodback.removeLast()
            foodText.text = removed
            ActualFood.setFoodName(foodName: foodText.text!)
            urlFormatPublic = generateUrlForDish(foodName: foodText.text!)
            ActualFood.setFoodUrl(foodUrl: urlFormatPublic)
            
            // Si le nom du dernier plat correspond au plat déjà affiché à l'écran
            if removed == foodText.text {
                //Si le nombre de plats dans le tableau qui se remplit lorsqu'un nouveau plat est généré est supérieur ou égal à 1, supprimer le dernier plat du tableau, actualiser le nom du plat, l'URL et son type, sinon, cacher le bouton
                if foodback.count >= 1 {
                    let removed = foodback.removeLast()
                    foodText.text = removed
                    ActualFood.setFoodName(foodName: foodText.text!)
                    urlFormatPublic = generateUrlForDish(foodName: foodText.text!)
                    ActualFood.setFoodUrl(foodUrl: urlFormatPublic)
                    
                    // Si la nombre de plats dans le tableau foodback est inférieur à 1, cacher le bouton
                    if foodback.count < 1 {
                        updateBack(true)
                    }
                }
                else
                {
                    updateBack(true)
                }
            }
        }
        else
        {
            updateBack(true)
        }
    }
    
    // Fonction qui cache ou pas le bouton de retour, utilisé par la fonction goToBack()
    func updateBack(_ activeoupas: Bool) {
        UIView.transition(with: backButton, duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
            self.backButton.isHidden = activeoupas
        })
    }
    
    // Fonction de génération des URL
    func generateUrlForDish (foodName: String) -> String {
        var urlPrefix: String
        
        // Déterminer la source des plats choisie et générer le lien en conséquence
        switch UserDefaults.standard.string(forKey: "PAD_SOURCE") {
        case "Marmiton":
            urlPrefix = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt="
        case "750g":
            urlPrefix = "https://www.750g.com/recherche.htm?search="
        case "Cuisine AZ":
            urlPrefix = "https://www.cuisineaz.com/recettes/recherche_terme.aspx?recherche="
        case "Journal des femmes":
            urlPrefix = "https://cuisine.journaldesfemmes.fr/s/?f_libelle="
        default:
            urlPrefix = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt="
        }
        
        // Ajouter le préfixe de la source + le nom du plat
        var url = urlPrefix + foodName
            
        // Si le nom du plat est "Space cake", ouvrir une page Google spécifique
        if foodText.text == "Space cake" {
            url = "http://google.com/search?q=Pas%20tr%C3%A8s%20catholique..."
        }
        
        // Marmiton possède des attributs spéciaux pour sa recherche. Les espaces sont des "-"
        if UserDefaults.standard.string(forKey: "PAD_SOURCE") == "Marmiton" {
            let urlFormat = url.replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: "é", with: "e").replacingOccurrences(of: "É", with: "E").replacingOccurrences(of: "à", with: "a").replacingOccurrences(of: "è", with: "e").replacingOccurrences(of: "â", with: "a").replacingOccurrences(of: "ï", with: "i").replacingOccurrences(of: "ê", with: "e").replacingOccurrences(of: "ô", with: "o").replacingOccurrences(of: "ç", with: "c").replacingOccurrences(of: "ö", with: "o").replacingOccurrences(of: "û", with: "")
            
            return urlFormat
        }
        // Pour toutes les autres sources, les espaces sont des %20. Aussi, enlever tous les accents
        else {
            let urlFormat = url.replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: "é", with: "e").replacingOccurrences(of: "É", with: "E").replacingOccurrences(of: "à", with: "a").replacingOccurrences(of: "è", with: "e").replacingOccurrences(of: "â", with: "a").replacingOccurrences(of: "ï", with: "i").replacingOccurrences(of: "ê", with: "e").replacingOccurrences(of: "ô", with: "o").replacingOccurrences(of: "ç", with: "c").replacingOccurrences(of: "ö", with: "o").replacingOccurrences(of: "û", with: "")
            
            return urlFormat
        }
    }
    
    // Fonction qui gère le swipe vers la droite et génère un plat si le réglage est activé
    @IBAction func swipedToRight(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "PAD_SLIDE") == true {
            generateNewDish()
        }
    }

    // Fonction qui gère le swipe vers la gauche et revient en arrière si le réglage est activé
    @IBAction func swipedToLeft(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "PAD_SLIDE") == true {
            goToBack()
        }
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
        
        // Mettre la couleur inversée pour les boutons, le label des plats et les titres de la navigation
        foodText.textColor = color2
        generateButton.backgroundColor = color2
        backButton.tintColor = color2
        settingsButton.tintColor = color2
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
        navigationController?.navigationBar.tintColor = color2
        
        // Pour tout le reste, mettre la couleur principale
        generateButton.setTitleColor(color1, for: .normal)
        navigationController?.navigationBar.barTintColor = color1
        self.view.backgroundColor = color1
    }
    
    // Fonction qui génère le changement de couleur lorsque celles-ci sont activées
    func changeColorsWithColors () {
        var color1: UIColor
        var color2: UIColor
        var contrastRatio: Double
        
        // Si les couleurs pâles sont activées, générer une couleur pâle et déterminer l'inverse de celle-ci
        if UserDefaults.standard.bool(forKey: "PAD_LIGHTER_COLORS") == true {
            color1 = generateRandomPastelColor()
            
            // Obtenir l'inverse de la couleur principale
            let ciColor = CIColor(color: color1)
            
            let compRed: CGFloat = 1.0 - ciColor.red
            let compGreen: CGFloat = 1.0 - ciColor.green
            let compBlue: CGFloat = 1.0 - ciColor.blue
            
            color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
        }
        // Sinon, générer une couleur aléatoire et déterminer l'inverse de celle-ci
        else {
            repeat {
                // Générer une couleur aléatoire
                color1 = UIColor.random()
                
                let ciColor = CIColor(color: color1)
            
                let compRed: CGFloat = 1.0 - ciColor.red
                let compGreen: CGFloat = 1.0 - ciColor.green
                let compBlue: CGFloat = 1.0 - ciColor.blue
            
                color2 = UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
                
                // Déterminer le contraste
                contrastRatio = Double(UIColor.contrastRatio(between: color1, and: color2))
                    
            } while contrastRatio < 2.2 // Tant que le contraste n'est pas lisible confortablement pour l'être humain, générer une autre couleur
        }
        
        // Animer la transition des couleurs
        UIView.animate(withDuration: 0.1, animations: {
            // Mettre la couleur inversée pour les boutons, le label des plats et les titres de la navigation
            self.foodText.textColor = color2
            self.generateButton.backgroundColor = color2
            self.backButton.tintColor = color2
            self.settingsButton.tintColor = color2
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : color2]
            self.navigationController?.navigationBar.tintColor = color2
            
            // Pour tout le reste, mettre la couleur principale
            self.generateButton.setTitleColor(color1, for: .normal)
            self.navigationController?.navigationBar.barTintColor = color1
            self.view.backgroundColor = color1
        })
        
    }
    
    // Fonction qui détecte le changement du mode sombre au mode clair et inversement
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        
        if UserDefaults.standard.bool(forKey: "PAD_COLORS") == false {
            changeColors()
        }
    }
    
    // Générer une couleur pastel aléatoire
    func generateRandomPastelColor() -> UIColor {
        let number = Int.random(in: 0 ... 21)
        switch number {
        case 1:
            return UIColor(rgb: 0xFF9AA2)
        case 2:
            return UIColor(rgb: 0xFFB7B2)
        case 3:
            return UIColor(rgb: 0xFFDAC1)
        case 4:
            return UIColor(rgb: 0xE2F0CB)
        case 5:
            return UIColor(rgb: 0xB5EAD7)
        case 6:
            return UIColor(rgb: 0xC7CEEa)
        case 7:
            return UIColor(rgb: 0xBDD0C4)
        case 8:
            return UIColor(rgb: 0x9AB7D3)
        case 9:
            return UIColor(rgb: 0xF5D2D3)
        case 10:
            return UIColor(rgb: 0xF7E1D3)
        case 11:
            return UIColor(rgb: 0xDFCCF1)
        case 12:
            return UIColor(rgb: 0xF0DBB0)
        case 13:
            return UIColor(rgb: 0x89D1DC)
        case 14:
            return UIColor(rgb: 0xF0D689)
        case 15:
            return UIColor(rgb: 0xFFCCF9)
        case 16:
            return UIColor(rgb: 0xECD4FF)
        case 17:
            return UIColor(rgb: 0xD8FFD6)
        case 18:
            return UIColor(rgb: 0xCCFFEE)
        case 19:
            return UIColor(rgb: 0xCCDDFF)
        case 20:
            return UIColor(rgb: 0xFFEEDD)
        case 21:
            return UIColor(rgb: 0xCCCCEE)
        default:
            return UIColor(rgb: 0xFF9AA2)
        }
    }
}

// Extensions de CGFloat et UICOlor qui permettent de générer une couleur aléatoire
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

// Extensions de UIColor qui permettent de déterminer le contraste
extension UIColor {
    static func contrastRatio(between color1: UIColor, and color2: UIColor) -> CGFloat {

        let luminance1 = color1.luminance()
        let luminance2 = color2.luminance()

        let luminanceDarker = min(luminance1, luminance2)
        let luminanceLighter = max(luminance1, luminance2)

        return (luminanceLighter + 0.05) / (luminanceDarker + 0.05)
    }

    func contrastRatio(with color: UIColor) -> CGFloat {
        return UIColor.contrastRatio(between: self, and: color)
    }

    func luminance() -> CGFloat {
        // https://www.w3.org/TR/WCAG20-TECHS/G18.html#G18-tests

        let ciColor = CIColor(color: self)

        func adjust(colorComponent: CGFloat) -> CGFloat {
            return (colorComponent < 0.04045) ? (colorComponent / 12.92) : pow((colorComponent + 0.055) / 1.055, 2.4)
        }

        return 0.2126 * adjust(colorComponent: ciColor.red) + 0.7152 * adjust(colorComponent: ciColor.green) + 0.0722 * adjust(colorComponent: ciColor.blue)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
