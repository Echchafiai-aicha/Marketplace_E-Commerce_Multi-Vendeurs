CREATE OR REPLACE PROCEDURE proc_remboursement (
    p_commande_id IN NUMBER,
    p_montant_rembourse IN NUMBER DEFAULT NULL   -- IN (read-only)
)
IS
    v_total NUMBER;
    -- Variable locale pour gérer le montant réel à rembourser
    v_montant_a_rembourser NUMBER; 
BEGIN
    SAVEPOINT before_refund;

    -- 1) Obtenir montant total de commande
    SELECT montant_total INTO v_total FROM commande WHERE commande_id = p_commande_id;
    
    -- On initialise la variable locale avec le paramètre IN
    v_montant_a_rembourser := p_montant_rembourse; 

    -- 2) Si aucun montant précisé → remboursement total
    IF v_montant_a_rembourser IS NULL THEN
        -- On affecte la valeur à la variable locale, ce qui est permis
        v_montant_a_rembourser := v_total; 
    END IF;

    -- 5) Mise à jour paiement : Utilisation de la variable locale
    UPDATE paiement
    SET statut_paiement = 'Refunded',
        montant_paye = montant_paye - v_montant_a_rembourser
    WHERE commande_id = p_commande_id;

    -- 6) Log automatique manuel : Utilisation de la variable locale
    INSERT INTO log_actions VALUES (
        seq_log.NEXTVAL,
        'REMBOURSEMENT',
        'Commande ' || p_commande_id || ' remboursée de ' || v_montant_a_rembourser, 
        SYSDATE,
        'SYSTEM_PROC'
    );

    COMMIT;

EXCEPTION WHEN OTHERS THEN
    ROLLBACK TO before_refund;
    RAISE_APPLICATION_ERROR(-20150, 'Échec remboursement : ' || SQLERRM);
END;
/