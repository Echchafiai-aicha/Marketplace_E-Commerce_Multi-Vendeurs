CREATE OR REPLACE TRIGGER trg_decrement_stock
AFTER INSERT ON LIGNE_COMMANDE
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    -- 1) Récupérer le stock actuel du produit et verrouiller la ligne
    SELECT quantite_stock
    INTO v_stock
    FROM PRODUIT
    WHERE produit_id = :NEW.produit_id
    FOR UPDATE;

    -- 2) Vérifier que le nouveau stock ne deviendra pas négatif
    IF (v_stock - :NEW.quantite) < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20031,--une erreur personnalisée pour empêcher l’insertion.
            'Impossible de décrémenter le stock : quantité demandée = ' 
            || :NEW.quantite || ', stock disponible = ' || v_stock
        );
    END IF;

    -- 3) Décrémenter réellement le stock
    UPDATE PRODUIT --Il met à jour la table PRODUIT en diminuant le stock du produit concerné
    SET quantite_stock = quantite_stock - :NEW.quantite
    WHERE produit_id = :NEW.produit_id;

END;
/
