 -- SEQUENCES (générateurs d'ID)
-- =========================
CREATE SEQUENCE seq_vendeur START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_categorie START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_produit START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_client START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_commande START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_ligne_comm START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_coupon START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_paiement START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_expedition START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_avis START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_log START WITH 1 INCREMENT BY 1 NOCACHE;

-- =========================
-- TABLES (dans le bon ordre pour respecter les dépendances)
-- =========================

-- Tables indépendantes
CREATE TABLE VENDEUR (
  vendeur_id       NUMBER PRIMARY KEY,
  nom_vendeur      VARCHAR2(100) NOT NULL,
  mail_vendeur     VARCHAR2(100) UNIQUE NOT NULL,
  tel_vendeur      VARCHAR2(20),
  nom_boutique     VARCHAR2(150),
  date_inscription DATE DEFAULT SYSDATE
);

CREATE TABLE CATEGORIE (
  categorie_id   NUMBER PRIMARY KEY,
  nom_categorie  VARCHAR2(80) NOT NULL UNIQUE
);

CREATE TABLE CLIENT (
  client_id       NUMBER PRIMARY KEY,
  nom_client      VARCHAR2(120) NOT NULL,
  mail_client     VARCHAR2(150) UNIQUE NOT NULL,
  tel_client      VARCHAR2(20),
  date_inscription DATE DEFAULT SYSDATE
);

CREATE TABLE COUPON (
  coupon_id      NUMBER PRIMARY KEY,
  code_coupon    VARCHAR2(20) UNIQUE NOT NULL,
  taux_coupon    NUMBER(5,2) NOT NULL CHECK (taux_coupon > 0 AND taux_coupon <= 100),
  date_validite  DATE,
  validite       NUMBER(1) DEFAULT 1 CHECK (validite IN (0,1))
);

-- Tables dépendantes de VENDEUR et CATEGORIE
CREATE TABLE PRODUIT (
  produit_id      NUMBER PRIMARY KEY,
  nom_produit     VARCHAR2(200) NOT NULL,
  description     CLOB,
  prix            NUMBER(12,2) NOT NULL CHECK (prix >= 0),
  quantite_stock  NUMBER(10) NOT NULL CHECK (quantite_stock >= 0),
  vendeur_id      NUMBER NOT NULL,
  categorie_id    NUMBER NOT NULL,
  CONSTRAINT fk_produit_vendeur FOREIGN KEY (vendeur_id) REFERENCES VENDEUR(vendeur_id),
  CONSTRAINT fk_produit_categorie FOREIGN KEY (categorie_id) REFERENCES CATEGORIE(categorie_id)
);

-- Tables dépendantes de CLIENT et COUPON
CREATE TABLE COMMANDE (
  commande_id     NUMBER PRIMARY KEY,
  statut_commande VARCHAR2(40) DEFAULT 'Pending' CHECK (statut_commande IN ('Pending','Paid','Shipped','Cancelled')),
  adresse_livraison VARCHAR2(500),
  nb_piece     NUMBER(10) DEFAULT 0 CHECK (nb_piece >= 0),
  client_id       NUMBER NOT NULL,
  coupon_id       NUMBER,
  montant_total   NUMBER(12,2) DEFAULT 0 CHECK (montant_total >= 0),
  date_commande   DATE DEFAULT SYSDATE,
  CONSTRAINT fk_commande_client FOREIGN KEY (client_id) REFERENCES CLIENT(client_id),
  CONSTRAINT fk_commande_coupon FOREIGN KEY (coupon_id) REFERENCES COUPON(coupon_id)
);

-- Tables dépendantes de COMMANDE et PRODUIT
CREATE TABLE LIGNE_COMMANDE (
  ligne_comm_id   NUMBER PRIMARY KEY,
  commande_id     NUMBER NOT NULL,
  produit_id      NUMBER NOT NULL,
  quantite        NUMBER(10) NOT NULL CHECK (quantite > 0),
  prix_unitaire   NUMBER(12,2) NOT NULL CHECK (prix_unitaire >= 0),
  CONSTRAINT fk_ligne_commande_commande FOREIGN KEY (commande_id) REFERENCES COMMANDE(commande_id) ON DELETE CASCADE,
  CONSTRAINT fk_ligne_commande_produit FOREIGN KEY (produit_id) REFERENCES PRODUIT(produit_id)
);

CREATE TABLE PAIEMENT (
  paiement_id      NUMBER PRIMARY KEY,
  methode          VARCHAR2(50) NOT NULL,
  statut_paiement  VARCHAR2(100) DEFAULT 'Pending' CHECK (statut_paiement IN ('Pending','Validated','Failed','Refunded')),
  date_paiement    DATE,
  montant_paye     NUMBER(12,2) DEFAULT 0 CHECK (montant_paye >= 0),
  commande_id      NUMBER NOT NULL,
  CONSTRAINT fk_paiement_commande FOREIGN KEY (commande_id) REFERENCES COMMANDE(commande_id)
);

CREATE TABLE EXPEDITION (
  expedition_id    NUMBER PRIMARY KEY,
  transporteur     VARCHAR2(200),
  statut_avancement VARCHAR2(20) DEFAULT 'en attente' CHECK (statut_avancement IN ('en attente','en cours','livrée')),
  date_expedition  DATE,
  commande_id      NUMBER NOT NULL,
  CONSTRAINT fk_expedition_commande FOREIGN KEY (commande_id) REFERENCES COMMANDE(commande_id)
);

-- Tables dépendantes de PRODUIT et CLIENT
CREATE TABLE AVIS (
  avis_id         NUMBER PRIMARY KEY,
  note            NUMBER(2) CHECK (note >= 0 AND note <= 5),
  commentaire     CLOB,
  date_avis       DATE DEFAULT SYSDATE,
  produit_id      NUMBER NOT NULL,
  CONSTRAINT fk_avis_produit FOREIGN KEY (produit_id) REFERENCES PRODUIT(produit_id)
);

CREATE TABLE LAISSER (
  avis_id   NUMBER NOT NULL,
  client_id NUMBER NOT NULL,
  PRIMARY KEY (avis_id, client_id),
  CONSTRAINT fk_laisser_avis FOREIGN KEY (avis_id) REFERENCES AVIS(avis_id),
  CONSTRAINT fk_laisser_client FOREIGN KEY (client_id) REFERENCES CLIENT(client_id)
);

-- Table de log indépendante
CREATE TABLE LOG_ACTIONS (
  log_id      NUMBER PRIMARY KEY,
  action_type VARCHAR2(100) NOT NULL,
  details     CLOB,
  date_action DATE DEFAULT SYSDATE,
  utilisateur VARCHAR2(150)
);