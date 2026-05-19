CREATE OR REPLACE PROCEDURE proc_valider_commande (
    p_commande_id IN NUMBER
)
IS
    v_total NUMBER;
BEGIN
    SAVEPOINT avant_validation;

    -- 1) Calcul du montant final via fonction PL/SQL
    v_total := calc_montant_total(p_commande_id);

    -- 2) Mise à jour commande → Paid
    UPDATE COMMANDE
    SET montant_total = v_total,
        statut_commande = 'Paid'
    WHERE commande_id = p_commande_id;

    -- 3) Validation du paiement lié
    UPDATE PAIEMENT
    SET statut_paiement = 'Validated',
        montant_paye = v_total,
        date_paiement = SYSDATE
    WHERE commande_id = p_commande_id;

    -- journalisation automatique → grâce au trigger trg_log_paiement

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO avant_validation;
        RAISE_APPLICATION_ERROR(-20199,
           'Échec validation commande '||p_commande_id||' → rollback : '||SQLERRM);
END;
/