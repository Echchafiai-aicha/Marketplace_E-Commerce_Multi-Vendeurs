CREATE OR REPLACE TRIGGER trg_log_paiement
AFTER UPDATE OF statut_paiement ON paiement
FOR EACH ROW
WHEN (NEW.statut_paiement = 'Validated')   -- On agit seulement après validation du paiement
DECLARE
BEGIN
    -- Mise à jour du statut de la commande
    UPDATE commande
    SET statut_commande = 'Paid'
    WHERE commande_id = :NEW.commande_id;

    -- Inscription dans le journal LOG_ACTIONS
    INSERT INTO log_actions (log_id, action_type, details, date_action, utilisateur)
    VALUES (
        seq_log.NEXTVAL,
        'PAIEMENT_VALIDE',
        'Paiement validé pour commande ID = ' || :NEW.commande_id,
        SYSDATE,
        'SYSTEM_TRIGGER'
    );
END;
/