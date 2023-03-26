Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D25F6C9466
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjCZNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjCZNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 09:02:50 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0BD7AA3;
        Sun, 26 Mar 2023 06:02:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 8B4D718E6;
        Sun, 26 Mar 2023 15:02:43 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1679835759; x=1681650160;
         bh=pYcs00zRlO3Cm743+mZalxdYRkYFWJqR61AMSIUbjzQ=; b=2dOO9nSfkBGg
        34UScBskfYmkYa9zSsAhNJW3/4vyE0SK5gTm7Wia7sgXnZffQiYXsS/PZ0jPiJbt
        tSQucMEHTaQiAsmSg1798hN6eEI64Uwm7cPG4xpyeAa6tAN7YbitiShFBan6ekAP
        HFXD477sxIpDZVcDGrl17yLcSZX6rUSNwxJh+WaeYxO0Q8o5gWR/hBGDElFTAka+
        l3FPWsORU0iuKX6NbhiF8vTQL7le4E1vw+GWPRT+eWhXvbF9MyqKeCwMvnN5Sn5U
        Th0wCyCHUXLOlVAglQjBbkk4aNqCzaDNwuw8QCiG4wU/Kj9dsO7qSkHrVcW80QqN
        VQ6k8F3CkjVopHVTgB+5tOEHQU+EBvDtO7Mq2k4Ygjk8JxZGGG4o8W96m1tlLyAG
        MiR8drN7US/tUjlu39JC4il3eUF5FPhx1UOyQXUIvUu0aUWLywGRQiQPTq3S6Ad5
        HbCCNOiVnt3A41dwrf/QiBdd+hrM1K7li2VrRz9Rot1+myoMKRznZ4E8KRpPaHf+
        LZH26Z10ERzN3eVWfAe6W869pyCM2yB73Hn9d6MWOnYSUYBcRJGkhz85f7Mhz2oi
        pMmDzqfmjoEE5rz3jIuN73IEn+PbLNrDNIbk/E+4XPL6DIM7rCZ2yvTD3n6/iI7C
        Bz6yfwlAkgHgqlt/SxPteRPTK92FvAU=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AALPJep_BXfE; Sun, 26 Mar 2023 15:02:39 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 228A218E4;
        Sun, 26 Mar 2023 15:02:38 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 79B6E35F9;
        Sun, 26 Mar 2023 15:02:38 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: translation alignment
Date:   Sun, 26 Mar 2023 15:02:13 +0200
Message-Id: <20230326130213.28755-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Italian translation updated following these changes:

commit 901578a45950 ("docs: recommend using Link: whenever using Reported-by:")"
commit 775a445d9a63 ("coding-style: fix title of Greg K-H's talk")
commit 1d2ed9234c85 ("Documentation: process: Document suitability of Proton Mail for kernel development")
commit 9d0f5cd16744 ("docs: promote the title of process/index.rst")
commit d4563201f33a ("Documentation: simplify and clarify DCO contribution example language")
commit e7b4311ebcac ("Replace HTTP links with HTTPS ones: Documentation/process")
commit 0b02076f9953 ("docs: programming-language: add Rust programming language section")
commit 38484a1d0c50 ("docs: programming-language: remove mention of the Intel compiler")
commit b8885e2615f4 ("Documentation: front page: use recommended heading adornments")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/core-api/symbol-namespaces.rst      |  3 +-
 .../it_IT/doc-guide/parse-headers.rst         |  5 +-
 Documentation/translations/it_IT/index.rst    | 47 +++++++++----------
 .../translations/it_IT/process/5.Posting.rst  |  7 +--
 .../it_IT/process/clang-format.rst            |  2 +-
 .../it_IT/process/coding-style.rst            |  6 +--
 .../it_IT/process/email-clients.rst           | 25 ++++++++++
 .../translations/it_IT/process/index.rst      |  1 +
 .../it_IT/process/maintainer-pgp-guide.rst    |  2 +-
 .../it_IT/process/programming-language.rst    | 25 ++++++++--
 .../it_IT/process/submitting-patches.rst      |  4 +-
 .../process/volatile-considered-harmful.rst   |  4 +-
 12 files changed, 84 insertions(+), 47 deletions(-)

diff --git a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
index 0f6898860d6d..17abc25ee4c1 100644
--- a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
+++ b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
@@ -1,7 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :doc:`../../../core-api/symbol-namespaces`
-:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+:Original: Documentation/core-api/symbol-namespaces.rst
 
 ===========================
 Spazio dei nomi dei simboli
diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
index 993d549ee2b8..c7076a21667a 100644
--- a/Documentation/translations/it_IT/doc-guide/parse-headers.rst
+++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
@@ -1,7 +1,6 @@
 .. include:: ../disclaimer-ita.rst
 
-.. note:: Per leggere la documentazione originale in inglese:
-	  :ref:`Documentation/doc-guide/index.rst <doc_guide>`
+:Original: Documentation/doc-guide/index.rst
 
 =========================================
 Includere gli i file di intestazione uAPI
@@ -190,7 +189,7 @@ COPYRIGHT
 
 Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
 
-Licenza GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
+Licenza GPLv2: GNU GPL version 2 <https://gnu.org/licenses/gpl.html>.
 
 Questo è software libero: siete liberi di cambiarlo e ridistribuirlo.
 Non c'è alcuna garanzia, nei limiti permessi dalla legge.
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index fc5f39814e83..b95dfa1ded04 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -2,9 +2,9 @@
 
 .. _it_linux_doc:
 
-===================
-Traduzione italiana
-===================
+==================================
+La documentazione del kernel Linux
+==================================
 
 .. raw:: latex
 
@@ -12,6 +12,18 @@ Traduzione italiana
 
 :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
 
+Questo è il livello principale della documentazione del kernel in
+lingua italiana. La traduzione è incompleta, noterete degli avvisi
+che vi segnaleranno la mancanza di una traduzione o di un gruppo di
+traduzioni.
+
+Più in generale, la documentazione, come il kernel stesso, sono in
+costante sviluppo; particolarmente vero in quanto stiamo lavorando
+alla riorganizzazione della documentazione in modo più coerente.
+I miglioramenti alla documentazione sono sempre i benvenuti; per cui,
+se vuoi aiutare, iscriviti alla lista di discussione linux-doc presso
+vger.kernel.org.
+
 .. _it_disclaimer:
 
 Avvertenze
@@ -54,23 +66,8 @@ Se avete bisogno d'aiuto per comunicare con la comunità Linux ma non vi sentite
 a vostro agio nello scrivere in inglese, potete chiedere aiuto al manutentore
 della traduzione.
 
-La documentazione del kernel Linux
-==================================
-
-Questo è il livello principale della documentazione del kernel in
-lingua italiana. La traduzione è incompleta, noterete degli avvisi
-che vi segnaleranno la mancanza di una traduzione o di un gruppo di
-traduzioni.
-
-Più in generale, la documentazione, come il kernel stesso, sono in
-costante sviluppo; particolarmente vero in quanto stiamo lavorando
-alla riorganizzazione della documentazione in modo più coerente.
-I miglioramenti alla documentazione sono sempre i benvenuti; per cui,
-se vuoi aiutare, iscriviti alla lista di discussione linux-doc presso
-vger.kernel.org.
-
 Lavorare con la comunità di sviluppo
-------------------------------------
+====================================
 
 Le guide fondamentali per l'interazione con la comunità di sviluppo del kernel e
 su come vedere il proprio lavoro integrato.
@@ -85,7 +82,7 @@ su come vedere il proprio lavoro integrato.
 
 
 Manuali sull'API interna
-------------------------
+========================
 
 Di seguito una serie di manuali per gli sviluppatori che hanno bisogno di
 interfacciarsi con il resto del kernel.
@@ -96,7 +93,7 @@ interfacciarsi con il resto del kernel.
    core-api/index
 
 Strumenti e processi per lo sviluppo
-------------------------------------
+====================================
 
 Di seguito una serie di manuali contenenti informazioni utili a tutti gli
 sviluppatori del kernel.
@@ -109,7 +106,7 @@ sviluppatori del kernel.
    kernel-hacking/index
 
 Documentazione per gli utenti
------------------------------
+=============================
 
 Di seguito una serie di manuali per gli *utenti* del kernel - ovvero coloro che
 stanno cercando di farlo funzionare al meglio per un dato sistema, ma anche
@@ -120,16 +117,16 @@ Consultate anche `Linux man pages <https://www.kernel.org/doc/man-pages/>`_, che
 vengono mantenuti separatamente dalla documentazione del kernel Linux
 
 Documentazione relativa ai firmware
------------------------------------
+===================================
 Di seguito informazioni sulle aspettative del kernel circa i firmware.
 
 
 Documentazione specifica per architettura
------------------------------------------
+=========================================
 
 
 Documentazione varia
---------------------
+====================
 
 Ci sono documenti che sono difficili da inserire nell'attuale organizzazione
 della documentazione; altri hanno bisogno di essere migliorati e/o convertiti
diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
index f61059c8ac8d..a7e2a3238415 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -265,9 +265,10 @@ Le etichette in uso più comuni sono:
    :ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`
 
  - Reported-by: menziona l'utente che ha riportato il problema corretto da
-   questa patch; quest'etichetta viene usata per dare credito alle persone
-   che hanno verificato il codice e ci hanno fatto sapere quando le cose non
-   funzionavano correttamente.
+   questa patch; quest'etichetta viene usata per dare credito alle persone che
+   hanno verificato il codice e ci hanno fatto sapere quando le cose non
+   funzionavano correttamente. Se esiste un rapporto disponibile sul web, allora
+   L'etichetta dovrebbe essere seguita da un collegamento al suddetto rapporto.
 
  - Cc: la persona menzionata ha ricevuto una copia della patch ed ha avuto
    l'opportunità di commentarla.
diff --git a/Documentation/translations/it_IT/process/clang-format.rst b/Documentation/translations/it_IT/process/clang-format.rst
index 77eac809a639..29f83c198025 100644
--- a/Documentation/translations/it_IT/process/clang-format.rst
+++ b/Documentation/translations/it_IT/process/clang-format.rst
@@ -40,7 +40,7 @@ Linux più popolari. Cercate ``clang-format`` nel vostro repositorio.
 Altrimenti, potete scaricare una versione pre-generata dei binari di LLVM/clang
 oppure generarlo dai codici sorgenti:
 
-    http://releases.llvm.org/download.html
+    https://releases.llvm.org/download.html
 
 Troverete più informazioni ai seguenti indirizzi:
 
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index a393ee4182af..5f244e16f511 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -1204,10 +1204,10 @@ ISBN 0-201-61586-X.
 
 Manuali GNU - nei casi in cui sono compatibili con K&R e questo documento -
 per indent, cpp, gcc e i suoi dettagli interni, tutto disponibile qui
-http://www.gnu.org/manual/
+https://www.gnu.org/manual/
 
 WG14 è il gruppo internazionale di standardizzazione per il linguaggio C,
-URL: http://www.open-std.org/JTC1/SC22/WG14/
+URL: https://www.open-std.org/JTC1/SC22/WG14/
 
-Kernel process/coding-style.rst, by greg@kroah.com at OLS 2002:
+Kernel CodingStyle, by greg@kroah.com at OLS 2002:
 http://www.kroah.com/linux/talks/ols_2002_kernel_codingstyle_talk/html/
diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index 970671cd91af..76ca3226c8cd 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -364,3 +364,28 @@ un editor esterno.
 
 Un altro problema è che Gmail usa la codifica base64 per tutti quei messaggi
 che contengono caratteri non ASCII. Questo include cose tipo i nomi europei.
+
+Proton Mail
+***********
+
+Il servizio Proton Mail ha una funzionalità che cripta tutti i messaggi verso
+ogni destinatario per cui è possibile trovare una chiave usando il *Web Key
+Directory* (WKD). Il servizio kernel.org pubblica il WKD per ogni sviluppatore
+in possesso di un conto kernel.org. Di conseguenza, tutti i messaggi inviati
+usando Proton Mail verso indirizzi kernel.org verranno criptati.
+
+Proton Mail non fornisce alcun meccanismo per disabilitare questa funzionalità
+perché verrebbe considerato un problema per la riservatezza. Questa funzionalità
+è attiva anche quando si inviano messaggi usando il Proton Mail Bridge. Dunque
+tutta la posta in uscita verrà criptata, incluse le patch inviate con ``git
+send-email``.
+
+I messaggi criptati sono una fonte di problemi; altri sviluppatori potrebbero
+non aver configurato i loro programmi, o strumenti, per gestire messaggi
+criptati; inoltre, alcuni programmi di posta elettronica potrebbero criptare le
+risposte a messaggi criptati per tutti i partecipanti alla discussione, inclusa
+la lista di discussione stessa.
+
+A meno che non venga introdotta una maniera per disabilitare questa
+funzionalità, non è consigliato usare Proton Mail per contribuire allo sviluppo
+del kernel.
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index 25602c1a97d1..cd7977905fb8 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -10,6 +10,7 @@
 
 .. _it_process_index:
 
+===============================================
 Lavorare con la comunità di sviluppo del kernel
 ===============================================
 
diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index e5c2a3a4d364..cdc43c4a9b0b 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -440,7 +440,7 @@ sulla scelta fra dispositivi aperti e proprietari.
 .. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
 .. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3
 .. _`Yubikey 5`: https://www.yubico.com/product/yubikey-5-overview/
-.. _Gnuk: http://www.fsij.org/doc-gnuk/
+.. _Gnuk: https://www.fsij.org/doc-gnuk/
 .. _`potrete avere gratuitamente una Nitrokey Start`: https://www.kernel.org/nitrokey-digital-tokens-for-kernel-developers.html
 
 Configurare il vostro dispositivo smartcard
diff --git a/Documentation/translations/it_IT/process/programming-language.rst b/Documentation/translations/it_IT/process/programming-language.rst
index c1a9b481a6f9..5bc5b9d42f31 100644
--- a/Documentation/translations/it_IT/process/programming-language.rst
+++ b/Documentation/translations/it_IT/process/programming-language.rst
@@ -18,10 +18,6 @@ Linux supporta anche ``clang`` [it-clang]_, leggete la documentazione
 Questo dialetto contiene diverse estensioni al linguaggio [it-gnu-extensions]_,
 e molte di queste vengono usate sistematicamente dal kernel.
 
-Il kernel offre un certo livello di supporto per la compilazione con
-``icc`` [it-icc]_ su diverse architetture, tuttavia in questo momento
-il supporto non è completo e richiede delle patch aggiuntive.
-
 Attributi
 ---------
 
@@ -43,11 +39,30 @@ possono usare e/o per accorciare il codice.
 Per maggiori informazioni consultate il file d'intestazione
 ``include/linux/compiler_attributes.h``.
 
+Rust
+----
+
+Il kernel supporta sperimentalmente il linguaggio di programmazione Rust
+[it-rust-language]_ abilitando l'opzione di configurazione ``CONFIG_RUST``. Il
+codice verrà compilato usando ``rustc`` [it-rustc]_ con l'opzione
+``--edition=2021`` [it-rust-editions]_. Le edizioni Rust sono un modo per
+introdurre piccole modifiche senza compatibilità all'indietro._
+
+In aggiunta, nel kernel vengono utilizzate alcune funzionalità considerate
+instabili [it-rust-unstable-features]_. Queste funzionalità potrebbero cambiare
+in futuro, dunque è un'obiettivo importante è quello di far uso solo di
+funzionalità stabili.
+
+Per maggiori informazioni fate riferimento a Documentation/rust/index.rst .
+
 .. [it-c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
 .. [it-gcc] https://gcc.gnu.org
 .. [it-clang] https://clang.llvm.org
-.. [it-icc] https://software.intel.com/en-us/c-compilers
 .. [it-gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
 .. [it-gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
 .. [it-gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
 .. [it-n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+.. [it-rust-language] https://www.rust-lang.org
+.. [it-rustc] https://doc.rust-lang.org/rustc/
+.. [it-rust-editions] https://doc.rust-lang.org/edition-guide/editions/
+.. [it-rust-unstable-features] https://github.com/Rust-for-Linux/linux/issues/2
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index c2cfa0948b2b..5131a3963e7e 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -429,7 +429,7 @@ poi dovete solo aggiungere una riga che dice::
 
 	Signed-off-by: Random J Developer <random@developer.example.org>
 
-usando il vostro vero nome (spiacenti, non si accettano pseudonimi o
+usando il vostro vero nome (spiacenti, non si accettano
 contributi anonimi). Questo verrà fatto automaticamente se usate
 ``git commit -s``. Anche il ripristino di uno stato precedente dovrebbe
 includere "Signed-off-by", se usate ``git revert -s`` questo verrà
@@ -785,7 +785,7 @@ Riferimenti
 -----------
 
 Andrew Morton, "La patch perfetta" (tpp).
-  <http://www.ozlabs.org/~akpm/stuff/tpp.txt>
+  <https://www.ozlabs.org/~akpm/stuff/tpp.txt>
 
 Jeff Garzik, "Formato per la sottomissione di patch per il kernel Linux"
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
diff --git a/Documentation/translations/it_IT/process/volatile-considered-harmful.rst b/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
index efc640cac596..4fff9a59b548 100644
--- a/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
@@ -119,9 +119,9 @@ concorrenza siano stati opportunamente considerati.
 Riferimenti
 ===========
 
-[1] http://lwn.net/Articles/233481/
+[1] https://lwn.net/Articles/233481/
 
-[2] http://lwn.net/Articles/233482/
+[2] https://lwn.net/Articles/233482/
 
 Crediti
 =======
-- 
2.30.2

