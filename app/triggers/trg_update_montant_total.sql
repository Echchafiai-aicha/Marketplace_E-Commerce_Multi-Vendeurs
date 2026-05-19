CREATE OR REPLACE TRIGGER trg_update_montant_total
FOR INSERT OR UPDATE OR DELETE ON LIGNE_COMMANDE
COMPOUND TRIGGER

  -- 1. Déclaration de table associative pour stocker les IDs de commande uniques
  TYPE t_commande_id_list IS TABLE OF COMMANDE.commande_id%TYPE INDEX BY PLS_INTEGER;
  g_commande_ids t_commande_id_list;
  
  -- Fonction utilitaire pour déterminer l'ID de commande
  FUNCTION get_commande_id
    RETURN NUMBER
  IS
  BEGIN
    IF INSERTING OR UPDATING THEN
      RETURN :NEW.commande_id;
    ELSIF DELETING THEN
      RETURN :OLD.commande_id;
    END IF;
    RETURN NULL; -- Ne devrait jamais arriver
  END;

  -- 2. Phase de Collecte (AFTER EACH ROW) : Stocker les IDs
  AFTER EACH ROW IS
    v_commande_id NUMBER := get_commande_id();
    v_index       PLS_INTEGER;
  BEGIN
    -- Utiliser l'ID de commande comme clé d'index pour garantir l'unicité
    g_commande_ids(v_commande_id) := v_commande_id;
  END AFTER EACH ROW;

  -- 3. Phase de Mise à Jour (AFTER STATEMENT) : Recalculer et mettre à jour
  AFTER STATEMENT IS
    v_total NUMBER;
  BEGIN
    -- Itérer sur la liste des IDs collectés
    FOR idx IN g_commande_ids.FIRST .. g_commande_ids.LAST LOOP
      
      -- Recalcul du montant total (LIGNE_COMMANDE n'est PLUS en mutation ici)
      v_total := calc_montant_total(g_commande_ids(idx));

      -- Mise à jour dans la table COMMANDE
      UPDATE COMMANDE
      SET montant_total = v_total
      WHERE commande_id = g_commande_ids(idx);
    
    END LOOP;
  END AFTER STATEMENT;

END trg_update_montant_total;
/