CREATE OR REPLACE PROCEDURE proc_process_payment (
    p_commande_id IN NUMBER
) 
IS
    v_total  NUMBER;
    v_statut VARCHAR2(20);
    v_count  NUMBER;
BEGIN
    SAVEPOINT before_payment;

    -- 1 Vérifier que la commande n’est pas déjà payée
    SELECT statut_commande 
    INTO v_statut
    FROM commande
    WHERE commande_id = p_commande_id;

    IF v_statut = 'Paid' THEN
        RAISE_APPLICATION_ERROR(-20101,
            'Commande déjà payée : paiement impossible.');
    END IF;

    -- 2 Vérifier qu'il n'existe pas déjà un paiement VALIDATED
    SELECT COUNT(*) 
    INTO v_count
    FROM paiement
    WHERE commande_id = p_commande_id
      AND statut_paiement = 'Validated';

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20102,
            'Paiement déjà validé pour cette commande.');
    END IF;
    
    -- 3 Calcul du montant total (avec coupon)
    v_total := calc_montant_total(p_commande_id);

    ---------------------------------------------------
    -- (4) Mise à jour de la commande
    ---------------------------------------------------
    UPDATE commande
    SET montant_total = v_total,
        statut_commande = 'Paid'
    WHERE commande_id = p_commande_id;

    -- 5 Mise à jour de l’enregistrement de paiement
    UPDATE paiement
    SET statut_paiement = 'Validated',
        date_paiement   = SYSDATE,
        montant_paye    = v_total
    WHERE commande_id = p_commande_id;

    -- TRIGGER trg_log_paiement s’occupera du LOG
    COMMIT;

EXCEPTION 
    WHEN OTHERS THEN
        ROLLBACK TO before_payment;
        RAISE_APPLICATION_ERROR(-20100,
            'Échec du paiement : ' || SQLERRM);
END;
/
