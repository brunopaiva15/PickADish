//
//  DishData.swift
//  PickADish
//
//  Contains all the dish data for the application
//

import Foundation

/// Static data containing all available dishes organized by category
enum DishData {

    // MARK: - Entrées

    static let entrees: [String] = [
        "Foie gras", "Huîtres", "Escargots au beurre persillé", "Steak tartare",
        "Soufflé au fromage", "Soupe à l'oignon", "Velouté de potiron et carottes",
        "Salade de concombre au chèvre et olives", "Oeufs mimosa", "Caviar d'aubergines",
        "Soupe aux légumes", "Cake au thon", "Quiche aux poireaux", "Flan de courgettes",
        "Cake aux olives", "Soupe d'endives", "Fougasse aux herbes", "Quiche sans oeufs",
        "Salade composée au thon", "Salade césar", "Space cake", "Quiche multicolore",
        "Oeufs cuits", "Chausson aux épinards", "Fougasse aux oignons",
        "Soupe d'endives à la bière", "Terrine de jambon aux courgettes", "Soupe d'orties",
        "Poireaux à la vinaigrette", "Terrine de foie gras", "Salade de pâtes",
        "Salade allemande aux pommes de terre", "Quiche à la tomate", "Gaspacho",
        "Velouté d'endives à la crème", "Salade de pâtes au crabe",
        "Salade exotique au pamplemousse", "Salade de céleri", "Salade de haricots blancs",
        "Feuilleté", "Rouleaux de printemps", "Tartare de thon", "Salade de pâtes au basilic",
        "Soupe de betteraves rouges", "Tortilla au thon", "Salade d'endives",
        "Potage à la courge", "Minestrone d'automne", "Salade tomates-mozzarella",
        "Salade de carottes", "Salade de concombres", "Coleslaw", "Salade grecque",
        "Salade niçoise", "Taboulé", "Salade de saucisse", "Oeufs au plat",
        "Oeufs brouillés aux herbes", "Oeufs Bénédicte", "Salade de légumes", "Rösti",
        "Quiche au fromage", "Salade d'avocat", "Oeufs à la russe", "Salade alsacienne",
        "Gaspacho aux crevettes", "Salade chinoise au crabe", "Quiche aux poivrons",
        "Melon en salade", "Quiche aux lardons", "Oeuf cocotte au bacon",
        "Salade de pâtes d'été", "Tartines à l'italienne", "Oeuf cocotte en fromage",
        "Macarons de champignons", "Bowl d'hiver", "Soupe de cresson",
        "Quiche au saumon fumé", "Poires au roquefort", "Foie gras mi-cuit",
        "Salade d'asperges aux pignons", "Soupe au choux", "Soupe de champignons",
        "Soupe de pois cassés", "Soupe glacée au concombre", "Carpaccio d'aubergines",
        "Soupe aux 7 légumes", "Feuillantine", "Soupe au chou vert",
        "Soupe chinoise au poulet", "Carpaccio de saumon fumé", "Sashimi de saumon",
        "Sashimi de thon", "Salade Thaï", "Carpaccio de boeuf", "Tartare de saumon"
    ]

    // MARK: - Plats

    static let plats: [String] = [
        "Huîtres", "Cassoulet", "Poulet basquaise", "Mouclade charentaise",
        "Galettes bretonnes", "Carbonnade flamande", "Raclette", "Fondue savoyarde",
        "Gratin dauphinois", "Tartiflette", "Ratatouille", "Boeuf bourguignon",
        "Blanquette de veau", "Pot-au-feu", "Coq-au-vin", "Hachis parmentier",
        "Steak tartare", "Choucroute", "Cuisses de grenouille", "Sushis",
        "California rolls", "Pizza", "Empanadas", "Raviolis chinois", "Katsu",
        "Bulgogi", "Tarte au thon", "Pissaladière", "Tacos mexicains",
        "Tarte à l'ail des ours", "Samoussa au boeuf",
        "Saumon en papillote aux petits légumes", "Gratin de courgettes",
        "Asperges rôties au parmesan", "Spaghettis à la bolognaise",
        "Poulet aux écrevisses", "Poulet thaïlandais au curry rouge et curry vert",
        "Pizza aux poires", "Purée d'aubergines", "Curry de crevettes",
        "Poisson en papillote", "Boulettes de viande farcies",
        "Boulettes de viande suédoises", "Gratin de légumes", "Lasagne",
        "Blanquette de dinde", "Tajine de poulet au citron", "Nouilles chinoises",
        "Poulet fumé", "Légumes au barbecue", "Nouilles sautées aux légumes",
        "Boulettes de viande à la marocaine", "Croquettes de boeuf", "Daube de sanglier",
        "Magret de canard", "Pommes de terre sautées", "Macaronis aux trois fromages",
        "Brochettes de poulet au miel", "Risotto aux petits pois",
        "Filet mignon aux morilles", "Tomates provençales", "Blanc de poulet aux endives",
        "Paupiette de poisson au chou", "Cannellonis aux légumes", "Escalope de volaille",
        "Brandade de morue", "Tarte au saumon et aux épinards",
        "Rillettes aux deux saumons", "Tartare de thon", "Agneau en sauce épicée",
        "Gambas au citron", "Risotto de courgettes aux tomates", "Noix de Saint-Jacques",
        "Vermicelles chinoises", "Pigeonneaux rôtis aux épices",
        "Ragoût de lentilles au boeuf", "Soupe asiatique aux nouilles et au tofu",
        "Salade tiède de lentilles", "Omelette", "Purée de pomme de terre",
        "Galettes de pomme de terre", "Rösti", "Gnocchi", "Spaghetti carbonara",
        "Hachis aux cornettes", "Gratin de cornettes", "Spätzlis", "Riz Casimir",
        "Pilaf d'agneau à l'orientale", "Riz cantonais", "Paella aux fruits de mer",
        "Risotto aux fines herbes", "Polenta au fromage", "Couscous", "Salimbocca",
        "Paupiettes", "Escalope et sauce aux herbes", "Cordon-bleu",
        "Vol-au-vent aux quenelles", "Foie de veau aux oignons",
        "Galettes de viande hachée", "Chili con carne",
        "Ragoût de veau et pommes de terre écrasées", "Poulet au citron", "Rôti",
        "Truite aux herbes", "Brochettes de crevettes grillées", "Bar en croûte de sel",
        "Filets de cabillaud", "Prussiens au jambon cru", "Tartiflette aux amandes",
        "Langue de mouton à la bordelaise", "Riz à la mexicaine", "Mousse de cabillaud",
        "Cannellonis aux fruits de mer", "Poisson pané", "Gratin de poisson forestier",
        "Gratin de moules", "Casserole de légumes aux lentilles",
        "Crumble de ratatouille au poulet", "Papillotes de poisson", "Ragoût de porc",
        "Feuilletés au saumon", "Truite au four", "Nouilles sautées aux crevettes",
        "Salade tunisienne cuite", "Boeuf Tex Mex", "Tarte au chèvre", "Pain au saumon",
        "Filet de poisson et crème à l'ail", "Risotto aux moules",
        "Bouchées de lentilles", "Tarte paysanne aux champignons",
        "Tajine façon couscous", "Limandes panées sans gluten", "Tarte aux légumes frais",
        "Osso bucco", "Porc aigre doux", "Curry végétarien", "Viande à l'indienne",
        "Pizza campagnarde", "Carottes à l'orientale", "Cailles farcies",
        "Faisan farci aux fruits", "Soupe de bouillon thaï", "Canja au poulet",
        "Poulet au curry", "Poulet au piri-piri", "Penne à la vodka", "Flan de tomates",
        "Falafels", "Gratin de raviolis", "Rôti de porc", "Courgettes rondes farcies",
        "Rösti de pomme de terre crues", "Gratin de potiron",
        "Huîtres chaudes au champagne", "Gigot ou épaule d'agneau au miel et thym",
        "Endives au jambon", "Nems (frits)", "Canard à l'orange", "Hamburger au barbecue",
        "Tresse tartiflette", "Roulé de jambon aux haricots verts", "Carottes rôties",
        "Nuggets de poulet", "Civet de sanglier", "Gratin de chou-fleur", "Pizza roulée",
        "Samoussa au thon", "Camembert frit", "Feta grillée au sésame et au miel",
        "Foie gras poêlé à la mangue", "Oeufs à la tomate et chorizo", "Wrap à l'italienne",
        "Asperges feuilletées au bacon", "Amour de saumon en papillote", "Croque-pizza",
        "Riz sauté à l'ananas", "Gnocchi à l'italienne", "Homard grillé aux épices fines",
        "Pizza façon chinois", "Bar au four", "Fajitas au poulet", "Coq au vin maison",
        "Rôti de veau au four", "Rosbeef au four à l'ail", "Crevettes à l'ail",
        "Filet de boeuf en croûte", "Lapin à la moutarde", "Gratin de potimarron",
        "Croquemonsieur au chou-fleur", "Saltimbocca de veau", "Rôti de lotte au lard",
        "Tian aux légumes", "Lasagnes au saumon", "Risotto aux trois champignons",
        "Cannellonis de viande", "Endives surprise", "Dinde farcie aux marrons",
        "Cuisses de poulet en papillote", "Truite saumonée en croûte",
        "Gratin d'aubergines", "Croque madame", "Bagel mexicain", "Pizza au saumon",
        "Purée de carottes au bouillon de poule", "Hot Dog", "Gâteau de pommes de terre",
        "Risotto à la crème de poivrons", "Croque monsieur d'aubergines",
        "Saucisses aux lentilles", "Pizza à l'ananas", "Petit salé aux lentilles",
        "Saumon en papillote avec fondue de poireaux", "Galettes de blé noir",
        "Soupe chinoise au poulet", "Frittata aux courgettes", "Curry de pois chiches",
        "Vol-au-vent aux blancs de poulet", "Pintade aux pêches blanches",
        "Chapon poché et rôti", "Boeuf braisé aux carottes", "Confit de canard",
        "Boeuf aux oignions", "Fish & Chips", "Nems au poulet", "Nems au porc",
        "Nems à la crevette", "Gyoza", "Bouchées vapeur", "Steak de requin",
        "Saumon grillé au four", "Sashimi de saumon", "Sashimi de thon",
        "Brochettes boeuf cheese", "Porc au caramel", "Travers de porc caramélisé",
        "Crevettes à la sauce piquante", "Raviolis frits", "Crevettes tempura",
        "Beignets de Saint Jacques", "Beignets de calamar", "Pinces de crabe frits",
        "Beignets de crevette", "Kebab d'agneau", "Tartare de saumon", "Riz pilaf",
        "Poulet à la citronnelle"
    ]

    // MARK: - Desserts

    static let desserts: [String] = [
        "Croissants", "Fondant au chocolat", "Tarte Tatin", "Macarons", "Crème brûlée",
        "Île flottante", "Profiteroles", "Cookies", "Tarte aux pralines",
        "Tiramisu aux spéculoos", "Panna cotta aux fraises", "Crêpes",
        "Gâteaux aux carottes", "Petits milanais", "Biscuits sablés vegan",
        "Crumble aux pommes", "Gâteau aux noix", "Perles du japon au chocolat",
        "Clémentines à la russe", "Gâteau au chocolat", "Pasteis de nata",
        "Gâteau suisse à la rhubarbe", "Omelette sucrée", "Omelette norvégienne", "Flan",
        "Brioche", "Tresse briochée", "Panna cotta au carambar", "Pancakes",
        "Crème de citron", "Cigarettes russes", "Crème de bananes", "Chocolat chaud",
        "Yaourt maison", "Donuts", "Cookies aux pralines caramélisées",
        "Sorbet à la fraise", "Clafoutis aux cerises", "Cheesecake", "Cake aux pruneaux",
        "Salade d'oranges", "Crêpes à l'ananas et à l'orange", "Moelleux aux noix",
        "Bolo Rei", "Tarte au Nutella", "Riz au lait", "Charlotte au chocolat",
        "Muffins aux myrtilles", "Forêt noire", "Meringues", "Flan à la semoule",
        "Porridge à la banane", "Mug cake", "Streusel aux poires", "Gâteau au citron",
        "Tresse russe", "Strudel aux pommes", "Beignets aux pommes",
        "Biscuit roulé à la fraise", "Éclairs à la fraise", "Éclairs au chocolat",
        "Tarte aux abricots", "Gaufres", "Bruns", "Sablés fruités à la confiture",
        "Étoiles à la cannelle", "Demi-lunes à l'orange",
        "Bâtonnets au chocolat et au caramel", "Sablés aux pistaches", "Flan au caramel",
        "Pudding au chocolat", "Sabayon", "Crème à la vanille", "Crème au caramel",
        "Sorbet aux fraises", "Parfait à la vanille", "Tartelette aux vermicelles",
        "Gelée de raisins", "Confiture de fraises", "Compote de pommes",
        "Poires confites", "Pommes aux épices", "Salade de fruits", "Tarte aux poires",
        "Gâteau moelleux à la pomme", "Poires au miel", "Gâteau aux groseilles",
        "Mousse au chocolat et chantilly", "Mille feuille au chocolat",
        "Financiers à la noix de coco", "Gâteau breton à la confiture",
        "Cupcakes à la vanille", "Oeufs au lait", "Charlotte tropicale",
        "Orange sanguine meringuée", "Salade de grenades aux abricots",
        "Cookies américains", "Cake à l'orange", "Charlotte aux fraises",
        "Tarte à la banane", "Tresse jurassienne", "Gâteau à la confiture",
        "Gros gâteau aux OREO", "Pain d'épices", "Gratin de raisins",
        "Cake aux fruits confis", "Crumble aux mûres", "Brownies aux fruits rouges",
        "Bûche au mascarpone", "Brick de pommes au caramel salé",
        "Poires pochées au chocolat", "Tiramisu aux fraises",
        "Crumble aux pommes et aux coings", "Gâteau au yaourt au citron",
        "Tiramisu en cheesecake", "Frites de cookie", "Gâteau aux figues et aux noix",
        "Brownies", "Cônes sapin au chocolat", "Crème renversée au caramel",
        "Gâteau moelleux à la crème de marron", "Madeleines au coeur de Nutella",
        "Confiture à la mûre", "Perles de coco", "Crêpes à la bière",
        "Sphère au chocolat garnie", "Carrés au citron", "Soupe de framboise",
        "Mendiants", "Duchesses", "Beurre de cacahuète", "Moelleux au praliné",
        "Crème de caramel au beurre salé", "Coulis de framboises", "Choux à la crème",
        "Financiers au thé vert", "Tarte aux prunes", "Kiwis au gingembre",
        "Coulant tiède au chocolat", "Cappuccino de fraises en verrines",
        "Cake au chocolat en bocal", "Gâteaux aux noisettes", "Tarte au citron",
        "Carrés aux dattes moelleux", "Clafoutis aux abricots",
        "Bavarois aux fraises sur génoise", "Gâteau au yaourt et caramel beurre salé",
        "Cigarettes feuilletées au chocolat", "Flan aux oeufs", "Brownies fantômes",
        "Beignets de banane", "Bananasplit", "Cake aux pommes", "Cupcakes natures",
        "Timbale de framboises", "Mousse aux marrons", "Cheesecake café et amaretti",
        "Chaussons de prunes", "Pommes au four", "Langues de chat",
        "Popcorn caramélisé", "Mousse au chocolat onctueuse", "Frangipane",
        "Crêpes (sans lait)", "Galette des rois", "Flan aux pommes et aux pruneaux",
        "Gaufres liégeoises", "Compote épicée", "Châtaignes au four",
        "Granité aux fraises", "Pain au lait", "Poke cake", "Biscuit façon crème brûlée",
        "Knödels aux prunes", "Oranais aux abricots", "Sorbet à la figue",
        "Nougat glacé", "Dalmatien roulé", "Pim's géant", "Biscuits sablés au beurre",
        "Cake aux raisins secs et au rhum", "Verrine de fraises aux spéculoos",
        "Gateau au Daim", "Crème anglaise", "Gingembre confit", "Glace au café"
    ]

    // MARK: - Boissons

    static let boissons: [String] = [
        "Mojito cubain", "Vin chaud", "Vodka à l'orange", "Vin de rhubarbe", "Sangria",
        "Liqueur aux plantes", "Mojito", "Sirop de citron", "Cocktail au limoncello",
        "Smoothie au lait de coco", "Smoothie glacé", "Thé à la menthe marocain",
        "Cappuccino glacé au melon", "Milkshake aux cookies", "Sirop de menthe",
        "Pina Colada", "Sex on the Beach", "Caipirinha", "Sirop de cassis",
        "Smoothie aux fraises", "Milkshake à la fraise", "Milkshake à la banane",
        "Granita aux framboises", "Chocolat chaud", "Américano", "Blue Lagon",
        "Jus de pomme", "Café glacé", "Frapuccino", "Jus de persil", "Sikko",
        "Smoothie à la cerise", "Vin de noix", "Punch exotique", "Smoothie aux myrtilles",
        "Liqueur de chocolat", "Thé glacé à la pêche", "Bubble tea", "Kir royal",
        "Ayran", "Lait d'amandes", "Jus de citron", "Cosmopolitan", "Citronnade",
        "Café Mocha", "Jus vitaminé", "Thé marocain", "Jus de gingembre",
        "Vin de cerises", "Citronnade givrée", "Smoothie au cassis", "Smoothie japonais",
        "Tonic au café", "Sirop au citron", "Punch aux fruits", "Jus de Bouye",
        "Smoothie à la rhubarbe", "Limonade brésilienne", "Smoothie aux poires",
        "Maï-Taï", "Chocolat viennois", "Jus de pommes aux épices", "Lait de riz",
        "Orangeade", "Jus d'agrumes", "Vin de citrons", "Lait frappé à la noisette",
        "Eau pétillante au melon et à la fraise"
    ]

    // MARK: - Helper Methods

    /// Returns all dishes for a given category
    static func dishes(for category: Category) -> [Dish] {
        let names: [String]
        switch category {
        case .entrees: names = entrees
        case .plats: names = plats
        case .desserts: names = desserts
        case .boissons: names = boissons
        }
        return Dish.dishes(from: names, category: category)
    }

    /// Returns a random dish for the given category
    static func randomDish(for category: Category) -> Dish? {
        dishes(for: category).randomElement()
    }

    /// Total count of all dishes
    static var totalCount: Int {
        entrees.count + plats.count + desserts.count + boissons.count
    }
}
