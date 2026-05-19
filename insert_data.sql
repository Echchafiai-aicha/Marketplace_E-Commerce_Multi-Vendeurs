-- =========================
-- INSERTION DES DONNÉES
-- =========================

-- VENDEURS
INSERT INTO VENDEUR (vendeur_id, nom_vendeur, mail_vendeur, tel_vendeur, nom_boutique, date_inscription) VALUES
(seq_vendeur.NEXTVAL, 'Pierre Martin', 'pierre.martin@boutique.com', '01 23 45 67 89', 'TechStore', TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO VENDEUR (vendeur_id, nom_vendeur, mail_vendeur, tel_vendeur, nom_boutique, date_inscription) VALUES
(seq_vendeur.NEXTVAL, 'Marie Lambert', 'marie.lambert@mode.com', '01 34 56 78 90', 'FashionStyle', TO_DATE('2023-02-20', 'YYYY-MM-DD'));
INSERT INTO VENDEUR (vendeur_id, nom_vendeur, mail_vendeur, tel_vendeur, nom_boutique, date_inscription) VALUES
(seq_vendeur.NEXTVAL, 'Jean Dubois', 'jean.dubois@sport.com', '01 45 67 89 01', 'SportPro', TO_DATE('2023-03-10', 'YYYY-MM-DD'));
INSERT INTO VENDEUR (vendeur_id, nom_vendeur, mail_vendeur, tel_vendeur, nom_boutique, date_inscription) VALUES
(seq_vendeur.NEXTVAL, 'Sophie Bernard', 'sophie.bernard@maison.com', '01 56 78 90 12', 'HomeDecor', TO_DATE('2023-04-05', 'YYYY-MM-DD'));

-- CATEGORIES
INSERT INTO CATEGORIE (categorie_id, nom_categorie) VALUES (seq_categorie.NEXTVAL, 'Électronique');
INSERT INTO CATEGORIE (categorie_id, nom_categorie) VALUES (seq_categorie.NEXTVAL, 'Vêtements');
INSERT INTO CATEGORIE (categorie_id, nom_categorie) VALUES (seq_categorie.NEXTVAL, 'Sport');
INSERT INTO CATEGORIE (categorie_id, nom_categorie) VALUES (seq_categorie.NEXTVAL, 'Maison');
INSERT INTO CATEGORIE (categorie_id, nom_categorie) VALUES (seq_categorie.NEXTVAL, 'Livres');

-- PRODUITS
INSERT INTO PRODUIT (produit_id, nom_produit, description, prix, quantite_stock, vendeur_id, categorie_id) VALUES
(seq_produit.NEXTVAL, 'Smartphone Galaxy X', 'Smartphone haut de gamme avec écran 6.7" et triple caméra', 899.99, 50, 1, 1);
INSERT INTO PRODUIT (produit_id, nom_produit, description, prix, quantite_stock, vendeur_id, categorie_id) VALUES
(seq_produit.NEXTVAL, 'Casque Audio Pro', 'Casque sans fil avec réduction de bruit active', 249.99, 100, 1, 1);
INSERT INTO PRODUIT (produit_id, nom_produit, description, prix, quantite_stock, vendeur_id, categorie_id) VALUES
(seq_produit.NEXTVAL, 'Robe Élégante', 'Robe longue en soie pour occasions spéciales', 129.99, 30, 2, 2);
INSERT INTO PRODUIT (produit_id, nom_produit, description, prix, quantite_stock, vendeur_id, categorie_id) VALUES
(seq_produit.NEXTVAL, 'Veste de Sport', 'Veste imperméable pour activités extérieures', 79.99, 75, 3, 3);
INSERT INTO PRODUIT (produit_id, nom_produit, description, prix, quantite_stock, vendeur_id, categorie_id) VALUES
(seq_produit.NEXTVAL, 'Lampadaire Design', 'Lampadaire moderne avec lumière LED réglable', 159.99, 25, 4, 4);
INSERT INTO PRODUIT (produit_id, nom_produit, description, prix, quantite_stock, vendeur_id, categorie_id) VALUES
(seq_produit.NEXTVAL, 'Roman Best-Seller', 'Dernier roman à succès de cet été', 19.99, 200, 4, 5);

-- CLIENTS
INSERT INTO CLIENT (client_id, nom_client, mail_client, tel_client, date_inscription) VALUES
(seq_client.NEXTVAL, 'Alice Dupont', 'alice.dupont@email.com', '06 12 34 56 78', TO_DATE('2023-05-01', 'YYYY-MM-DD'));
INSERT INTO CLIENT (client_id, nom_client, mail_client, tel_client, date_inscription) VALUES
(seq_client.NEXTVAL, 'Thomas Leroy', 'thomas.leroy@email.com', '06 23 45 67 89', TO_DATE('2023-05-15', 'YYYY-MM-DD'));
INSERT INTO CLIENT (client_id, nom_client, mail_client, tel_client, date_inscription) VALUES
(seq_client.NEXTVAL, 'Camille Petit', 'camille.petit@email.com', '06 34 56 78 90', TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO CLIENT (client_id, nom_client, mail_client, tel_client, date_inscription) VALUES
(seq_client.NEXTVAL, 'Lucas Moreau', 'lucas.moreau@email.com', '06 45 67 89 01', TO_DATE('2023-06-20', 'YYYY-MM-DD'));

-- COUPONS
INSERT INTO COUPON (coupon_id, code_coupon, taux_coupon, date_validite, validite) VALUES
(seq_coupon.NEXTVAL, 'ETE2024', 15.00, TO_DATE('2024-08-31', 'YYYY-MM-DD'), 1);
INSERT INTO COUPON (coupon_id, code_coupon, taux_coupon, date_validite, validite) VALUES
(seq_coupon.NEXTVAL, 'BIENVENUE10', 10.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 1);
INSERT INTO COUPON (coupon_id, code_coupon, taux_coupon, date_validite, validite) VALUES
(seq_coupon.NEXTVAL, 'SOLDE25', 25.00, TO_DATE('2023-12-31', 'YYYY-MM-DD'), 0);

-- COMMANDES
INSERT INTO COMMANDE (commande_id, statut_commande, adresse_livraison, nb_piece, client_id, coupon_id, montant_total, date_commande) VALUES
(seq_commande.NEXTVAL, 'Paid', '15 Rue de la Paix, 75001 Paris', 2, 1, 1, 764.99, TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO COMMANDE (commande_id, statut_commande, adresse_livraison, nb_piece, client_id, montant_total, date_commande) VALUES
(seq_commande.NEXTVAL, 'Shipped', '22 Avenue des Champs, 69002 Lyon', 1, 2, 129.99, TO_DATE('2024-01-12', 'YYYY-MM-DD'));
INSERT INTO COMMANDE (commande_id, statut_commande, adresse_livraison, nb_piece, client_id, coupon_id, montant_total, date_commande) VALUES
(seq_commande.NEXTVAL, 'Pending', '8 Boulevard Maritime, 13008 Marseille', 3, 3, 2, 215.98, TO_DATE('2024-01-15', 'YYYY-MM-DD'));
INSERT INTO COMMANDE (commande_id, statut_commande, adresse_livraison, nb_piece, client_id, montant_total, date_commande) VALUES
(seq_commande.NEXTVAL, 'Cancelled', '5 Place Centrale, 31000 Toulouse', 1, 4, 19.99, TO_DATE('2024-01-18', 'YYYY-MM-DD'));

-- LIGNES DE COMMANDE
-- Commande 1
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire) VALUES
(seq_ligne_comm.NEXTVAL, 1, 1, 1, 899.99);
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire) VALUES
(seq_ligne_comm.NEXTVAL, 1, 2, 1, 249.99);

-- Commande 2
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire) VALUES
(seq_ligne_comm.NEXTVAL, 2, 3, 1, 129.99);

-- Commande 3
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire) VALUES
(seq_ligne_comm.NEXTVAL, 3, 4, 1, 79.99);
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire) VALUES
(seq_ligne_comm.NEXTVAL, 3, 5, 1, 159.99);

-- Commande 4
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire) VALUES
(seq_ligne_comm.NEXTVAL, 4, 6, 1, 19.99);

-- PAIEMENTS
INSERT INTO PAIEMENT (paiement_id, methode, statut_paiement, date_paiement, montant_paye, commande_id) VALUES
(seq_paiement.NEXTVAL, 'Carte Bancaire', 'Validated', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 764.99, 1);
INSERT INTO PAIEMENT (paiement_id, methode, statut_paiement, date_paiement, montant_paye, commande_id) VALUES
(seq_paiement.NEXTVAL, 'PayPal', 'Validated', TO_DATE('2024-01-12', 'YYYY-MM-DD'), 129.99, 2);
INSERT INTO PAIEMENT (paiement_id, methode, statut_paiement, date_paiement, montant_paye, commande_id) VALUES
(seq_paiement.NEXTVAL, 'Carte Bancaire', 'Pending', NULL, 215.98, 3);

-- EXPEDITIONS
INSERT INTO EXPEDITION (expedition_id, transporteur, statut_avancement, date_expedition, commande_id) VALUES
(seq_expedition.NEXTVAL, 'Chronopost', 'livrée', TO_DATE('2024-01-11', 'YYYY-MM-DD'), 1);
INSERT INTO EXPEDITION (expedition_id, transporteur, statut_avancement, date_expedition, commande_id) VALUES
(seq_expedition.NEXTVAL, 'Colissimo', 'en cours', TO_DATE('2024-01-13', 'YYYY-MM-DD'), 2);

-- AVIS
INSERT INTO AVIS (avis_id, note, commentaire, date_avis, produit_id) VALUES
(seq_avis.NEXTVAL, 5, 'Excellent smartphone, je recommande !', TO_DATE('2024-01-13', 'YYYY-MM-DD'), 1);
INSERT INTO AVIS (avis_id, note, commentaire, date_avis, produit_id) VALUES
(seq_avis.NEXTVAL, 4, 'Très belle robe, taille un peu petite', TO_DATE('2024-01-14', 'YYYY-MM-DD'), 3);
INSERT INTO AVIS (avis_id, note, commentaire, date_avis, produit_id) VALUES
(seq_avis.NEXTVAL, 5, 'Casque de très bonne qualité, confortable', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 2);

-- ASSOCIATION AVIS-CLIENTS (LAISSER)
INSERT INTO LAISSER (avis_id, client_id) VALUES (1, 1);
INSERT INTO LAISSER (avis_id, client_id) VALUES (2, 2);
INSERT INTO LAISSER (avis_id, client_id) VALUES (3, 1);

-- LOGS D'ACTIONS
INSERT INTO LOG_ACTIONS (log_id, action_type, details, date_action, utilisateur) VALUES
(seq_log.NEXTVAL, 'CREATION_COMMANDE', 'Nouvelle commande créée avec ID: 1', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'alice.dupont@email.com');
INSERT INTO LOG_ACTIONS (log_id, action_type, details, date_action, utilisateur) VALUES
(seq_log.NEXTVAL, 'PAIEMENT_VALIDE', 'Paiement validé pour commande ID: 1', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'system');
INSERT INTO LOG_ACTIONS (log_id, action_type, details, date_action, utilisateur) VALUES
(seq_log.NEXTVAL, 'EXPEDITION_COMMANDE', 'Commande expédiée ID: 1', TO_DATE('2024-01-11', 'YYYY-MM-DD'), 'pierre.martin@boutique.com');

-- VALIDATION DES INSERTIONS
COMMIT;