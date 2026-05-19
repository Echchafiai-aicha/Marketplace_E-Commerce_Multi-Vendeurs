--------------------------------------------------------
-- TESTS DES TRIGGERS DE STOCK + STATUT + MONTANT_TOTAL
--------------------------------------------------------

-- 1) Test d’ajout d’une ligne de commande avec stock suffisant
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire)
VALUES (seq_ligne_comm.NEXTVAL, 1, 1, 1, 899.99);
-- Attendu : OK → stock décrémenté, montant_total augmenté

-- 2) Test insertion avec stock insuffisant
INSERT INTO LIGNE_COMMANDE (ligne_comm_id, commande_id, produit_id, quantite, prix_unitaire)
VALUES (seq_ligne_comm.NEXTVAL, 1, 1, 9999, 899.99);
-- Attendu : ERREUR -20030

-- 3) Test suppression ligne → restock automatique
DELETE FROM LIGNE_COMMANDE WHERE commande_id = 1 AND produit_id = 1;
-- Attendu : quantité_stock réincrementée automatiquement + log

-- 4) Vérifier recalcul montant_total
SELECT commande_id, montant_total FROM COMMANDE WHERE commande_id = 1;

-- 5) Vérifier les logs
SELECT * FROM LOG_ACTIONS ORDER BY date_action DESC;
