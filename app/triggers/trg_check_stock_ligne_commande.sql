CREATE OR REPLACE TRIGGER trg_check_stock_ligne_commande
BEFORE INSERT ON LIGNE_COMMANDE
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    -- 1) Vérifier le stock du produit sélectionné
    SELECT quantite_stock
    INTO v_stock
    FROM PRODUIT
    WHERE produit_id = :NEW.produit_id
    FOR UPDATE;--FOR UPDATE verrouille la ligne du produit pour éviter qu’un autre utilisateur la modifie en même temps
    

    -- 2) Empêcher insertion si le stock est insuffisant
    IF v_stock < :NEW.quantite THEN
        RAISE_APPLICATION_ERROR(
            -20030,--une erreur personnalisée pour empêcher l’insertion.
            'Stock insuffisant pour le produit ' || :NEW.produit_id ||
            ' (stock disponible = ' || v_stock || ', demandé = ' || :NEW.quantite || ')'
        );
    END IF;
END;
/
