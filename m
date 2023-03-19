Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3D6C0224
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCSNqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSNqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:46:49 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5581F5F9;
        Sun, 19 Mar 2023 06:46:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 9953C1E9C;
        Sun, 19 Mar 2023 14:46:40 +0100 (CET)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1679233597; x=1681047998;
         bh=+ZIgmGE/D2T5FWuLp7AB3aaPwq39dKzqTojxmTeieVQ=; b=P2fya+1R6+t3
        odATf11Mjwq7KfRdZn4IkiY2TY5MPpa5ka4O0DzTRqwyMVpc+HzsiBNQOp/+J57G
        F2R1vyv687sqQlxUUuQhV2uMb9/I2PHSmiidQpxLS367TaD7g6W5nIQRDqpws1Eh
        dRyyLfdUHHAvMQi+YPeittGiEmrFZQIRMWsidfZkGBTVSMDOHSWfmD6/2qYB/EQ9
        yETQds8lYCrVLo9MNvY9Stfyh8/dbvp+1z+mJ9e63eCLP0TaifhAxcR2QQDtQYnk
        2JBTagB02vgnV5C3m3K386L3LlpkiZ2UvT1voKiMlFVz0eFUo/GkYdHd2qTNTVge
        U2ueUGbfWoPjHN7mMFwampN8iMVBEOtF+y0RE0GJoGphIv0Ap4vOjV1q8TeWPEHB
        93NWDrBD0JE0Z2dHujvbFjgBDj3Zw7nkEymEyrHFriQK61S3j6OMc60TDq8pk0y0
        5U13M+K6HXSpHkcbPnjWNVCvnKpJURU2Lre4311CSEcUoVJgRCC7Mmg/ULbVXHht
        Pek3jzXq2YXJqiJ7fov0Cx0Rq2wgwaNSItsn8yGnBMgyJpWHUSCJgBYK/XNitfLp
        aS7pkoHq76v8brQzdcTPHP8kdsthezeqXmck/ceiN1mnTbGy/iAhNJvZFLdlIYCq
        KUTNP90WXx7ltfF9ZJZ1kS6kRRjDlao=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5pBl4XEnKVFc; Sun, 19 Mar 2023 14:46:37 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 2C9521E42;
        Sun, 19 Mar 2023 14:46:36 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 2B84F123F;
        Sun, 19 Mar 2023 14:46:36 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: translation alignment
Date:   Sun, 19 Mar 2023 14:46:24 +0100
Message-Id: <20230319134624.21327-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Major update for maintainer-pgp-guide

commit e4412739472b ("Documentation: raise minimum supported version of binutils to 2.25")
commit 67fe6792a7fb ("Documentation: stable: Document alternative for referring upstream commit hash")
commit 8763a30bc15b ("docs: deprecated.rst: Add note about DECLARE_FLEX_ARRAY() usage
commit 2f993509a97e ("docs: process/5.Posting.rst: clarify use of Reported-by: tag")
commit a31323bef2b6 ("timers: Update the documentation to reflect on the new timer_shutdown() API")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/kernel-hacking/locking.rst          |   5 +
 .../translations/it_IT/process/5.Posting.rst  |   6 +-
 .../translations/it_IT/process/changes.rst    |   4 +-
 .../translations/it_IT/process/deprecated.rst |  29 +-
 .../it_IT/process/maintainer-pgp-guide.rst    | 346 +++++++++---------
 .../it_IT/process/stable-kernel-rules.rst     |   6 +
 6 files changed, 214 insertions(+), 182 deletions(-)

diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 05d362b16bf0..a9e781d2e323 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1029,6 +1029,11 @@ Dato che questo è un problema abbastanza comune con una propensione
 alle corse critiche, dovreste usare timer_delete_sync()
 (``include/linux/timer.h``) per gestire questo caso.
 
+Prima di rilasciare un temporizzatore dovreste chiamare la funzione
+timer_shutdown() o timer_shutdown_sync() di modo che non venga più ricarmato.
+Ogni successivo tentativo di riarmare il temporizzatore verrà silenziosamente
+ignorato.
+
 Velocità della sincronizzazione
 ===============================
 
diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
index cf92a16ed7e5..f61059c8ac8d 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -272,8 +272,10 @@ Le etichette in uso più comuni sono:
  - Cc: la persona menzionata ha ricevuto una copia della patch ed ha avuto
    l'opportunità di commentarla.
 
-State attenti ad aggiungere queste etichette alla vostra patch: solo
-"Cc:" può essere aggiunta senza il permesso esplicito della persona menzionata.
+State attenti ad aggiungere queste etichette alla vostra patch: solo "Cc:" può
+essere aggiunta senza il permesso esplicito della persona menzionata. Il più
+delle volte anche Reported-by: va bene, ma è sempre meglio chiedere specialmente
+se il baco è stato riportato in una comunicazione privata.
 
 Inviare la modifica
 -------------------
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 473ec2cc558e..f37c53f8b524 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -36,7 +36,7 @@ GNU C                  5.1                gcc --version
 Clang/LLVM (optional)  11.0.0             clang --version
 GNU make               3.81               make --version
 bash                   4.2                bash --version
-binutils               2.23               ld -v
+binutils               2.25               ld -v
 flex                   2.5.35             flex --version
 bison                  2.0                bison --version
 pahole                 1.16               pahole --version
@@ -97,7 +97,7 @@ Questo richiede bash 4.2 o successivo.
 Binutils
 --------
 
-Per generare il kernel è necessario avere Binutils 2.23 o superiore.
+Per generare il kernel è necessario avere Binutils 2.25 o superiore.
 
 pkg-config
 ----------
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index febf83897783..57b501f0dfa4 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -332,7 +332,7 @@ zero come risultato::
 
 Il valore di ``size`` nell'ultima riga sarà ``zero``, quando uno
 invece si aspetterebbe che il suo valore sia la dimensione totale in
-byte dell'allocazione dynamica che abbiamo appena fatto per l'array
+byte dell'allocazione dinamica che abbiamo appena fatto per l'array
 ``items``. Qui un paio di esempi reali del problema: `collegamento 1
 <https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539>`_,
 `collegamento 2
@@ -381,4 +381,29 @@ combinazione con struct_size() e flex_array_size()::
         instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
         instance->count = count;
 
-	memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
+        memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
+
+Ci sono due casi speciali dove è necessario usare la macro DECLARE_FLEX_ARRAY()
+(da notare che la stessa macro è chiamata __DECLARE_FLEX_ARRAY() nei file di
+intestazione UAPI). Uno è quando l'array flessibile è l'unico elemento di una
+struttura, e l'altro è quando è parti un unione. Per motivi non tecnici, entrambi
+i casi d'uso non sono permessi dalla specifica C99. Per esempio, per
+convertire il seguente codice::
+
+    struct something {
+        ...
+        union {
+            struct type1 one[0];
+            struct type2 two[0];
+        };
+    };
+
+La macro di supporto dev'essere usata::
+
+    struct something {
+        ...
+        union {
+            DECLARE_FLEX_ARRAY(struct type1, one);
+            DECLARE_FLEX_ARRAY(struct type2, two);
+        };
+    };
diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index 5526bcabeb0a..e5c2a3a4d364 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -68,42 +68,24 @@ stesso.
 Strumenti PGP
 =============
 
-Usare GnuPG v2
---------------
+Usare GnuPG 2.2 o successivo
+----------------------------
 
 La vostra distribuzione potrebbe avere già installato GnuPG, dovete solo
-verificare che stia utilizzando la versione 2.x e non la serie 1.4 --
-molte distribuzioni forniscono entrambe, di base il comando ''gpg''
-invoca GnuPG v.1. Per controllate usate::
+verificare che stia utilizzando la versione abbastanza recente. Per controllate
+usate::
 
     $ gpg --version | head -n1
 
-Se visualizzate ``gpg (GnuPG) 1.4.x``, allora state usando GnuPG v.1.
-Provate il comando ``gpg2`` (se non lo avete, potreste aver bisogno
-di installare il pacchetto gnupg2)::
-
-    $ gpg2 --version | head -n1
-
-Se visualizzate  ``gpg (GnuPG) 2.x.x``, allora siete pronti a partire.
-Questa guida assume che abbiate la versione 2.2.(o successiva) di GnuPG.
-Se state usando la versione 2.0, alcuni dei comandi indicati qui non
-funzioneranno, in questo caso considerate un aggiornamento all'ultima versione,
-la 2.2. Versioni di gnupg-2.1.11 e successive dovrebbero essere compatibili
-per gli obiettivi di questa guida.
-
-Se avete entrambi i comandi: ``gpg`` e ``gpg2``, assicuratevi di utilizzare
-sempre la versione V2, e non quella vecchia. Per evitare errori potreste creare
-un alias::
-
-    $ alias gpg=gpg2
-
-Potete mettere questa opzione nel vostro  ``.bashrc`` in modo da essere sicuri.
+Se state utilizzando la version 2.2 o successiva, allora siete pronti a partire.
+Se invece state usando una versione precedente, allora alcuni comandi elencati
+in questa guida potrebbero non funzionare.
 
 Configurare le opzioni di gpg-agent
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 L'agente GnuPG è uno strumento di aiuto che partirà automaticamente ogni volta
-che userete il comando ``gpg`` e funzionerà in background con l'obiettivo di
+che userete il comando ``gpg`` e funzionerà in *background* con l'obiettivo di
 individuare la passphrase. Ci sono due opzioni che dovreste conoscere
 per personalizzare la scadenza della passphrase nella cache:
 
@@ -131,19 +113,7 @@ valori::
     riguarda vecchie le versioni di GnuPG, poiché potrebbero non svolgere più
     bene il loro compito.
 
-Impostare un *refresh* con cronjob
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Potreste aver bisogno di rinfrescare regolarmente il vostro portachiavi in
-modo aggiornare le chiavi pubbliche di altre persone, lavoro che è svolto
-al meglio con un cronjob giornaliero::
-
-    @daily /usr/bin/gpg2 --refresh >/dev/null 2>&1
-
-Controllate il percorso assoluto del vostro comando ``gpg`` o ``gpg2`` e usate
-il comando ``gpg2`` se per voi ``gpg`` corrisponde alla versione GnuPG v.1.
-
-.. _it_master_key:
+.. _it_protect_your_key:
 
 Proteggere la vostra chiave PGP primaria
 ========================================
@@ -155,55 +125,62 @@ al documento "`Protecting Code Integrity`_" che abbiamo menzionato prima.
 Dovreste inoltre creare una nuova chiave se quella attuale è inferiore a 2048
 bit (RSA).
 
-Chiave principale o sottochiavi
--------------------------------
-
-Le sottochiavi sono chiavi PGP totalmente indipendenti, e sono collegate alla
-chiave principale attraverso firme certificate. È quindi importante
-comprendere i seguenti punti:
-
-1. Non ci sono differenze tecniche tra la chiave principale e la sottochiave.
-2. In fase di creazione, assegniamo limitazioni funzionali ad ogni chiave
-   assegnando capacità specifiche.
-3. Una chiave PGP può avere 4 capacità:
+Le sottochiavi PGP
+------------------
 
-   - **[S]** può essere usata per firmare
-   - **[E]** può essere usata per criptare
-   - **[A]** può essere usata per autenticare
-   - **[C]** può essere usata per certificare altre chiavi
+Raramente le chiavi PGP sono composte da una singola coppia -- solitamente, sono
+una collezione di sottochiavi indipendenti usate per diversi scopi in funzione
+delle capacità assegnate al momento della creazione. Una chiave PGP può avere
+quattro capacità:
+
+- **[S]** può essere usata per firmare
+- **[E]** può essere usata per criptare
+- **[A]** può essere usata per autenticare
+- **[C]** può essere usata per certificare altre chiavi
+
+La chiave con la capacità **[C]** viene spesso chiamata chiave "passepartout"
+(*master key*), ma è una terminologia fuorviante perché lascia intendere che la
+chiave di certificato possa essere usate in sostituzione delle altre (proprio
+come le vere chiavi passpartout in grado di aprire diverse serrature). Dato che
+questo non è il caso, per evitare fraintendimenti, in questa guida ci riferiremo
+a questa chiave chiamandola "La chiave di certificazione".
+
+I seguenti punti sono molto importanti:
+
+1. Tutte le sottochiavi sono indipendenti. Se perdete una sottochiave privata
+   non potrete recuperarla usando le altre.
+2. Ad eccezione della chiave di certificazione, ci possono essere più
+   sottochiavi con le stesse capacità (per esempio, potete avere 2 sottochiavi
+   per criptare, 3 per firmare, ma solo una per una sola per certificare). Tutte
+   le sottochiavi sono indipendenti -- un messaggio criptato usando una chiave
+   **[E]** non può essere decriptato usano altre sottochiavi **[E]**.
+3. Una sottochiave può avere più capacità (per esempio, la chiave **[C]** può
+   anche essere una chiave **[S]**).
+
+La chiave con capacità **[C]** (certificazione) è la sola che può essere usata
+per indicare relazioni fra chiavi. Solo la chiave **[C]** può essere usata per:
+
+- aggiungere o revocare altre chiavi (sottochiavi) che hanno capacità S/E/A;
+- aggiungere, modificare o eliminare le identità (unids) associate alla chiave;
+- aggiungere o modificare la propria data di scadenza o delle sottochiavi;
+- firmare le chiavi di altre persone a scopo di creare una rete di fiducia.
 
-4. Una singola chiave può avere più capacità
-5. Una sottochiave è completamente indipendente dalla chiave principale.
-   Un messaggio criptato con la sottochiave non può essere decrittato con
-   quella principale. Se perdete la vostra sottochiave privata, non può
-   essere rigenerata in nessun modo da quella principale.
+Di base, alla creazione di nuove chiavi, GnuPG genera quanto segue:
 
-La chiave con capacità **[C]** (certify) è identificata come la chiave
-principale perché è l'unica che può essere usata per indicare la relazione
-con altre chiavi. Solo la chiave **[C]** può essere usata per:
+- Una chiave la capacità di certificazione che quella di firma (**[SC]**)
+- Una sottochiave separata con capacità di criptare (**[E]**)
 
-- Aggiungere o revocare altre chiavi (sottochiavi) che hanno capacità S/E/A
-- Aggiungere, modificare o eliminare le identità (unids) associate alla chiave
-- Aggiungere o modificare la data di termine di sé stessa o di ogni sottochiave
-- Firmare le chiavi di altre persone a scopo di creare una rete di fiducia
 
-Di base, alla creazione di nuove chiavi, GnuPG genera quanto segue:
 
-- Una chiave madre che porta sia la capacità di certificazione che quella
-  di firma (**[SC]**)
-- Una sottochiave separata con capacità di criptaggio (**[E]**)
 
-Se avete usato i parametri di base per generare la vostra chiave, quello
+Se avete usato i parametri predefiniti per generare la vostra chiave, quello
 sarà il risultato. Potete verificarlo utilizzando ``gpg --list-secret-keys``,
 per esempio::
 
-    sec   rsa2048 2018-01-23 [SC] [expires: 2020-01-23]
+    sec   ed25519 2022-12-20 [SC] [expires: 2024-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    ssb   rsa2048 2018-01-23 [E] [expires: 2020-01-23]
-
-Qualsiasi chiave che abbia la capacità **[C]** è la vostra chiave madre,
-indipendentemente da quali altre capacità potreste averle assegnato.
+    ssb   cv25519 2022-12-20 [E] [expires: 2024-12-19]
 
 La lunga riga sotto la voce ``sec`` è la vostra impronta digitale --
 negli esempi che seguono, quando vedere ``[fpr]`` ci si riferisce a questa
@@ -238,20 +215,10 @@ possano ricevere la vostra nuova sottochiave::
     $ gpg --send-key [fpr]
 
 .. note:: Supporto ECC in GnuPG
-    GnuPG 2.1 e successivi supportano pienamente *Elliptic Curve Cryptography*,
-    con la possibilità di combinare sottochiavi ECC con le tradizionali chiavi
-    primarie RSA. Il principale vantaggio della crittografia ECC è che è molto
-    più veloce da calcolare e crea firme più piccole se confrontate byte per
-    byte con le chiavi RSA a più di 2048 bit. A meno che non pensiate di
-    utilizzare un dispositivo smartcard che non supporta le operazioni ECC, vi
-    raccomandiamo ti creare sottochiavi di firma ECC per il vostro lavoro col
-    kernel.
-
-    Se per qualche ragione preferite rimanere con sottochiavi RSA, nel comando
-    precedente, sostituite "ed25519" con "rsa2048". In aggiunta, se avete
-    intenzione di usare un dispositivo hardware che non supporta le chiavi
-    ED25519 ECC, come la Nitrokey Pro o la Yubikey, allora dovreste usare
-    "nistp256" al posto di "ed25519".
+
+   Tenete presente che se avete intenzione di usare un dispositivo che non
+   supporta chiavi ED25519 ECC, allora dovreste usare "nistp256" al posto di
+   "ed25519". Più avanti ci sono alcune raccomandazioni per i dispositivi.
 
 Copia di riserva della chiave primaria per gestire il recupero da disastro
 --------------------------------------------------------------------------
@@ -360,13 +327,13 @@ Per prima cosa, identificate il keygrip della vostra chiave primaria::
 
 L'output assomiglierà a questo::
 
-    pub   rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
+    pub   ed25519 2022-12-20 [SC] [expires: 2022-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
           Keygrip = 1111000000000000000000000000000000000000
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    sub   rsa2048 2018-01-24 [E] [expires: 2020-01-24]
+    sub   cv25519 2022-12-20 [E] [expires: 2022-12-19]
           Keygrip = 2222000000000000000000000000000000000000
-    sub   ed25519 2018-01-24 [S]
+    sub   ed25519 2022-12-20 [S]
           Keygrip = 3333000000000000000000000000000000000000
 
 Trovate la voce keygrid che si trova sotto alla riga ``pub`` (appena sotto
@@ -389,11 +356,11 @@ Ora, se eseguite il comando ``--list-secret-keys``, vedrete che la chiave
 primaria non compare più (il simbolo ``#`` indica che non è disponibile)::
 
     $ gpg --list-secret-keys
-    sec#  rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
+    sec#  ed25519 2022-12-20 [SC] [expires: 2024-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    ssb   rsa2048 2018-01-24 [E] [expires: 2020-01-24]
-    ssb   ed25519 2018-01-24 [S]
+    ssb   cv25519 2022-12-20 [E] [expires: 2024-12-19]
+    ssb   ed25519 2022-12-20 [S]
 
 Dovreste rimuovere anche i file ``secring.gpg`` che si trovano nella cartella
 ``~/.gnupg``, in quanto rimasugli delle versioni precedenti di GnuPG.
@@ -461,18 +428,20 @@ soluzioni disponibili:
   computer portatili più recenti. In aggiunta, offre altre funzionalità di
   sicurezza come FIDO, U2F, e ora supporta anche le chiavi ECC (NISTP)
 
-`Su LWN c'è una buona recensione`_ dei modelli elencati qui sopra e altri.
-La scelta dipenderà dal costo, dalla disponibilità nella vostra area
-geografica e vostre considerazioni sull'hardware aperto/proprietario.
+La vostra scelta dipenderà dal costo, la disponibilità nella vostra regione, e
+sulla scelta fra dispositivi aperti e proprietari.
 
-Se volete usare chiavi ECC, la vostra migliore scelta sul mercato è la
-Nitrokey Start.
+.. note::
+
+    Se siete nella lista MAINTAINERS o avete un profilo su kernel.org, allora
+    `potrete avere gratuitamente una Nitrokey Start`_ grazie alla fondazione
+    Linux.
 
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
 .. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
 .. _`Yubikey 5`: https://www.yubico.com/product/yubikey-5-overview/
 .. _Gnuk: http://www.fsij.org/doc-gnuk/
-.. _`Su LWN c'è una buona recensione`: https://lwn.net/Articles/736231/
+.. _`potrete avere gratuitamente una Nitrokey Start`: https://www.kernel.org/nitrokey-digital-tokens-for-kernel-developers.html
 
 Configurare il vostro dispositivo smartcard
 -------------------------------------------
@@ -513,6 +482,12 @@ altre informazioni sulla carta che potrebbero trapelare in caso di smarrimento.
     A dispetto del nome "PIN", né il PIN utente né quello dell'amministratore
     devono essere esclusivamente numerici.
 
+.. warning::
+
+    Alcuni dispositivi richiedono la presenza delle sottochiavi nel dispositivo
+    stesso prima che possiate cambiare la passphare. Verificate la
+    documentazione del produttore.
+
 Spostare le sottochiavi sulla smartcard
 ---------------------------------------
 
@@ -525,11 +500,11 @@ dell'amministratore::
 
     Secret subkeys are available.
 
-    pub  rsa2048/AAAABBBBCCCCDDDD
-         created: 2018-01-23  expires: 2020-01-23  usage: SC
+    pub  ed25519/AAAABBBBCCCCDDDD
+         created: 2022-12-20  expires: 2024-12-19  usage: SC
          trust: ultimate      validity: ultimate
-    ssb  rsa2048/1111222233334444
-         created: 2018-01-23  expires: never       usage: E
+    ssb  cv25519/1111222233334444
+         created: 2022-12-20  expires: never       usage: E
     ssb  ed25519/5555666677778888
          created: 2017-12-07  expires: never       usage: S
     [ultimate] (1). Alice Dev <adev@kernel.org>
@@ -594,11 +569,11 @@ Ora, se doveste usare l'opzione ``--list-secret-keys``, vedrete una
 sottile differenza nell'output::
 
     $ gpg --list-secret-keys
-    sec#  rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
+    sec#  ed25519 2022-12-20 [SC] [expires: 2024-12-19]
           000000000000000000000000AAAABBBBCCCCDDDD
     uid           [ultimate] Alice Dev <adev@kernel.org>
-    ssb>  rsa2048 2018-01-24 [E] [expires: 2020-01-24]
-    ssb>  ed25519 2018-01-24 [S]
+    ssb>  cv25519 2022-12-20 [E] [expires: 2024-12-19]
+    ssb>  ed25519 2022-12-20 [S]
 
 Il simbolo ``>`` in ``ssb>`` indica che la sottochiave è disponibile solo
 nella smartcard. Se tornate nella vostra cartella delle chiavi segrete e
@@ -661,7 +636,7 @@ eseguite::
 Se per voi è più facile da memorizzare, potete anche utilizzare una data
 specifica (per esempio, il vostro compleanno o capodanno)::
 
-    $ gpg --quick-set-expire [fpr] 2020-07-01
+    $ gpg --quick-set-expire [fpr] 2025-07-01
 
 Ricordatevi di inviare l'aggiornamento ai keyserver::
 
@@ -676,6 +651,21 @@ dovreste importarle nella vostra cartella di lavoro abituale::
     $ gpg --export | gpg --homedir ~/.gnupg --import
     $ unset GNUPGHOME
 
+Usare gpg-agent con ssh
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Se dovete firmare tag o commit su un sistema remoto, potete ridirezionare il
+vostro gpg-agent attraverso ssh. Consultate le istruzioni disponibili nella wiki
+GnuPG:
+
+- `Agent Forwarding over SSH`_
+
+Funziona senza troppi intoppi se avete la possibilità di modificare le
+impostazioni di sshd sul sistema remoto.
+
+.. _`Agent Forwarding over SSH`: https://wiki.gnupg.org/AgentForwarding
+
+.. _it_pgp_with_git:
 
 Usare PGP con Git
 =================
@@ -709,11 +699,6 @@ avere più chiavi segrete, potete dire a git quale dovrebbe usare (``[fpg]``
 
     $ git config --global user.signingKey [fpr]
 
-**IMPORTANTE**: se avete una comando dedicato per ``gpg2``, allora dovreste
-dire a git di usare sempre quello piuttosto che il vecchio comando ``gpg``::
-
-    $ git config --global gpg.program gpg2
-
 Come firmare i tag
 ------------------
 
@@ -812,6 +797,61 @@ Potete dire a git di firmare sempre i commit::
 
 .. _it_verify_identities:
 
+Come lavorare con patch firmate
+-------------------------------
+
+Esiste la possibilità di usare la vostra chiave PGP per firmare le patch che
+invierete alla liste di discussione del kernel. I meccanismi esistenti per la
+firma delle email (PGP-Mime o PGP-inline) tendono a causare problemi
+nell'attività di revisione del codice. Si suggerisce, invece, di utilizare lo
+strumento sviluppato da kernel.org che mette nell'intestazione del messaggio
+un'attestazione delle firme crittografiche (tipo DKIM):
+
+- `Patatt Patch Attestation`_
+
+.. _`Patatt Patch Attestation`: https://pypi.org/project/patatt/
+
+Installare e configurate patatt
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Lo strumento patatt è disponibile per diverse distribuzioni, dunque cercatelo
+prima lì. Oppure potete installarlo usano pypi "``pip install patatt``"
+
+Se avete già configurato git con la vostra chiave PGP (usando
+``user.signingKey``), allora patatt non ha bisogno di alcuna configurazione
+aggiuntiva. Potete iniziare a firmare le vostre patch aggiungendo un aggancio a
+git-send-email nel vostro repositorio::
+
+    patatt install-hook
+
+Ora, qualsiasi patch che invierete con ``git send-email`` verrà automaticamente
+firmata usando la vostra firma crittografica.
+
+Verificare le firme di patatt
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Se usate ``b4`` per verificare ed applicare le patch, allora tenterà
+automaticamente di verificare tutte le firme DKIM e patatt disponibili. Per
+esempio::
+
+    $ b4 am 20220720205013.890942-1-broonie@kernel.org
+    [...]
+    Checking attestation on all messages, may take a moment...
+    ---
+      ✓ [PATCH v1 1/3] kselftest/arm64: Correct buffer allocation for SVE Z registers
+      ✓ [PATCH v1 2/3] arm64/sve: Document our actual ABI for clearing registers on syscall
+      ✓ [PATCH v1 3/3] kselftest/arm64: Enforce actual ABI for SVE syscalls
+      ---
+      ✓ Signed: openpgp/broonie@kernel.org
+      ✓ Signed: DKIM/kernel.org
+
+.. note::
+
+   Lo sviluppo di patatt e b4 è piuttosto attivo. Si consiglia di verificare la
+   documentazione più recente.
+
+.. _it_kernel_identities:
+
 Come verificare l'identità degli sviluppatori del kernel
 ========================================================
 
@@ -884,64 +924,18 @@ di base di GnuPG v2). Per farlo, aggiungete (o modificate) l'impostazione
 
     trust-model tofu+pgp
 
-Come usare i keyserver in sicurezza
------------------------------------
-Se ottenete l'errore "No public key" quando cercate di validate il tag di
-qualcuno, allora dovreste cercare quella chiave usando un keyserver. È
-importante tenere bene a mente che non c'è alcuna garanzia che la chiave
-che avete recuperato da un keyserver PGP appartenga davvero alla persona
-reale -- è progettato così. Dovreste usare il Web of Trust per assicurarvi
-che la chiave sia valida.
-
-Come mantenere il Web of Trust va oltre gli scopi di questo documento,
-semplicemente perché farlo come si deve richiede sia sforzi che perseveranza
-che tendono ad andare oltre al livello di interesse della maggior parte degli
-esseri umani. Qui di seguito alcuni rapidi suggerimenti per aiutarvi a ridurre
-il rischio di importare chiavi maligne.
-
-Primo, diciamo che avete provato ad eseguire ``git verify-tag`` ma restituisce
-un errore dicendo che la chiave non è stata trovata::
-
-    $ git verify-tag sunxi-fixes-for-4.15-2
-    gpg: Signature made Sun 07 Jan 2018 10:51:55 PM EST
-    gpg:                using RSA key DA73759BF8619E484E5A3B47389A54219C0F2430
-    gpg:                issuer "wens@...org"
-    gpg: Can't check signature: No public key
-
-Cerchiamo nel keyserver per maggiori informazioni sull'impronta digitale
-della chiave (l'impronta digitale, probabilmente, appartiene ad una
-sottochiave, dunque non possiamo usarla direttamente senza trovare prima
-l'ID della chiave primaria associata ad essa)::
-
-    $ gpg --search DA73759BF8619E484E5A3B47389A54219C0F2430
-    gpg: data source: hkp://keys.gnupg.net
-    (1) Chen-Yu Tsai <wens@...org>
-          4096 bit RSA key C94035C21B4F2AEB, created: 2017-03-14, expires: 2019-03-15
-    Keys 1-1 of 1 for "DA73759BF8619E484E5A3B47389A54219C0F2430".  Enter number(s), N)ext, or Q)uit > q
-
-Localizzate l'ID della chiave primaria, nel nostro esempio
-``C94035C21B4F2AEB``. Ora visualizzate le chiavi di Linus Torvalds
-che avete nel vostro portachiavi::
-
-    $ gpg --list-key torvalds@kernel.org
-    pub   rsa2048 2011-09-20 [SC]
-          ABAF11C65A2970B130ABE3C479BE3E4300411886
-    uid           [ unknown] Linus Torvalds <torvalds@kernel.org>
-    sub   rsa2048 2011-09-20 [E]
-
-Poi, cercate un percorso affidabile da Linux Torvalds alla chiave che avete
-trovato con ``gpg --search`` usando la chiave sconosciuta.Per farlo potete usare
-diversi strumenti come https://github.com/mricon/wotmate,
-https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/graphs, e
-https://the.earth.li/~noodles/pathfind.html.
-
-Se trovate un paio di percorsi affidabili è un buon segno circa la validità
-della chiave. Ora, potete aggiungerla al vostro portachiavi dal keyserver::
-
-    $ gpg --recv-key C94035C21B4F2AEB
-
-Questa procedura non è perfetta, e ovviamente state riponendo la vostra
-fiducia nell'amministratore del servizio *PGP Pathfinder* sperando che non
-sia malintenzionato (infatti, questo va contro :ref:`it_devs_not_infra`).
-Tuttavia, se mantenete con cura la vostra rete di fiducia sarà un deciso
-miglioramento rispetto alla cieca fiducia nei keyserver.
+Usare il repositorio kernel.org per il web of trust
+---------------------------------------------------
+
+Il progetto kernel.org mantiene un repositorio git con le chiavi pubbliche degli sviluppatori in alternativa alla replica dei server di chiavi che negli ultimi anni sono spariti. La documentazione completa su come impostare il repositorio come vostra sorgente di chiavi pubbliche può essere trovato qui:
+
+- `Kernel developer PGP Keyring`_
+
+Se siete uno sviluppatore del kernel, per favore valutate l'idea di inviare la
+vostra chiave per l'inclusione in quel portachiavi.
+
+
+If you are a kernel developer, please consider submitting your key for
+inclusion into that keyring.
+
+.. _`Kernel developer PGP Keyring`: https://korg.docs.kernel.org/pgpkeys.html
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index 0be675b03199..248bf1e4b171 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -106,6 +106,12 @@ al messaggio della patch, così:
 
     commit <sha1> upstream.
 
+o in alternativa:
+
+.. code-block:: none
+
+    [ Upstream commit <sha1>  ]
+
 In aggiunta, alcune patch inviate attraverso l':ref:`it_option_1` potrebbero
 dipendere da altre che devo essere incluse. Questa situazione può essere
 indicata nel seguente modo nell'area dedicata alle firme:
-- 
2.30.2

