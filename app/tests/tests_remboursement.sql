--------------------------------------------------------
-- TEST REMBOURSEMENT
--------------------------------------------------------

-- 1) Vérifier état avant remboursement
SELECT * FROM COMMANDE WHERE commande_id = 1;

-- 2) Remboursement total
EXEC proc_remboursement(1);

-- 3) Vérifier statut commande
SELECT commande_id, statut_commande FROM COMMANDE WHERE commande_id = 1;

-- 4) Vérifier retour du stock pour chaque produit de la commande
SELECT produit_id, quantite_stock FROM PRODUIT;

-- 5) Vérifier paiement mis à jour
SELECT * FROM PAIEMENT WHERE commande_id = 1;

-- 6) Vérifier log remboursement
SELECT * FROM LOG_ACTIONS ORDER BY date_action DESC;
