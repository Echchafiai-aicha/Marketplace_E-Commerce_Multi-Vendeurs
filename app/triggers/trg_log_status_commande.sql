CREATE OR REPLACE TRIGGER trg_log_status_commande
AFTER UPDATE OF statut_avancement ON expedition
FOR EACH ROW
WHEN (NEW.statut_avancement = 'livrée')
DECLARE
BEGIN
    -- Mise à jour du statut de la commande
    UPDATE commande
    SET statut_commande = 'Shipped'
    WHERE commande_id = :NEW.commande_id;

    -- Journalisation de l'évènement dans LOG_ACTIONS (Syntaxe compactée)
    INSERT INTO log_actions (log_id, action_type, details, date_action, utilisateur)
    VALUES (
        seq_log.NEXTVAL,
        'EXPEDITION_LIVREE',
        'Commande ID = ' || :NEW.commande_id || ' a été expédiée et livrée',
        SYSDATE,
        'SYSTEM_TRIGGER'
    );
END;
/