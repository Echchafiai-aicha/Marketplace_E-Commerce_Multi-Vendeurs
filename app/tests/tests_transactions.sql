--------------------------------------------------------
-- TEST VALIDATION DE COMMANDE AVEC TRANSACTION
--------------------------------------------------------

-- 1) Vérifier état initial
SELECT * FROM COMMANDE WHERE commande_id = 2;

-- 2) Exécuter la transaction complète
EXEC proc_valider_commande(2);

-- 3) Vérifier commande → Paid
SELECT commande_id, statut_commande, montant_total FROM COMMANDE WHERE commande_id = 2;

-- 4) Vérifier paiement validé automatiquement
SELECT * FROM PAIEMENT WHERE commande_id = 2;

-- 5) Vérifier journal LOG_ACTIONS
SELECT * FROM LOG_ACTIONS ORDER BY date_action DESC;

--------------------------------------------------------
-- TEST ROLLBACK (déclencher une erreur volontaire)
--------------------------------------------------------

-- Ajouter une ligne avec stock insuffisant = échec volontaire
INSERT INTO LIGNE_COMMANDE 
VALUES (seq_ligne_comm.NEXTVAL, 3, 1, 99999, 10);

-- Puis essayer de valider
EXEC proc_valider_commande(3);
-- Attendu : ROLLBACK + erreur -20199
