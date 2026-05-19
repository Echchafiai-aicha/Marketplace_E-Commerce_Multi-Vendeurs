CREATE OR REPLACE TRIGGER trg_restock_apres_delete_ligne
AFTER DELETE ON LIGNE_COMMANDE
FOR EACH ROW
BEGIN
    -- Réinjection automatique du stock
    UPDATE PRODUIT
    SET quantite_stock = quantite_stock + :OLD.quantite
    WHERE produit_id = :OLD.produit_id;

    -- Journalisation
    INSERT INTO LOG_ACTIONS VALUES(
        seq_log.NEXTVAL,
        'RESTOCK',
        'Suppression ligne → + ' || :OLD.quantite || ' unités retournées pour produit ID = ' || :OLD.produit_id,
        SYSDATE,
        'SYSTEM_TRIGGER'
    );
END;
/
