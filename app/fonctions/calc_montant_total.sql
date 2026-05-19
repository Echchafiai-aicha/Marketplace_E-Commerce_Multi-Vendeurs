CREATE OR REPLACE FUNCTION calc_montant_total(
    p_commande_id IN NUMBER
) RETURN NUMBER IS
    v_total       NUMBER := 0;
    v_coupon_id   NUMBER;
    v_taux        NUMBER := 0;
BEGIN
    -- 1) Calcul du total brut (lignes de commande)
    SELECT SUM(quantite * prix_unitaire)
    INTO v_total
    FROM LIGNE_COMMANDE
    WHERE commande_id = p_commande_id;

    IF v_total IS NULL THEN
        v_total := 0;
    END IF;

    -- 2) Vérifier si la commande a un coupon
    SELECT coupon_id INTO v_coupon_id
    FROM COMMANDE
    WHERE commande_id = p_commande_id;

    -- Si coupon présent : vérifier validité + appliquer
    IF v_coupon_id IS NOT NULL THEN
        SELECT taux_coupon
        INTO v_taux
        FROM COUPON
        WHERE coupon_id = v_coupon_id
          AND validite = 1
          AND (date_validite IS NULL OR date_validite >= SYSDATE);

        -- 3) Application de la réduction
        v_total := v_total - (v_total * (v_taux / 100));
    END IF;

    RETURN ROUND(v_total, 2);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Si coupon inexistant ou invalide : total brut
        RETURN ROUND(v_total, 2);
END;
/





