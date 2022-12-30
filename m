Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7808D659B00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiL3Rbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiL3Rbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:31:49 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB01A46A;
        Fri, 30 Dec 2022 09:31:46 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id B5E941466;
        Fri, 30 Dec 2022 18:31:44 +0100 (CET)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1672421500; x=1674235901;
         bh=ToeT1FwXQgDbA/u4PpTMp4964y+/ZZW9VD3o8ErjeHU=; b=zmb6DQMwrihe
        96MoAV94M6WmVhERSCaqogB0EcBWoXjEy1SMRvzGrA9LRg2XLjIR+nyqbqHcAtgS
        RHXJ0F0pQromDRfbx4esxEj9Uwf2FFEZs+cS5dHkJ/JNTt2FuuDJO5GvHerniDUu
        PaiU7ShqRLSCpP3rRrwGX+i6IH05FtnxRdWMIQddfc5F1aT4oH1klZj2vowREbzM
        iZfZFM/WgeEccICC1dyPCXq55+M7Z+AKmO28tQ7KMEOnbAsh5oVnFaT2u2CgfYsO
        rtynnty0JC/usFryfQt0fx06o3DUqUJ+7zg7S7ffFtlCD10M25fAMUP5qdhjIcWE
        5cPIsjPZK/WzwR+nxBablOmhpNRnuuM7nAIHzNt89X74bPHTzZuEr+qvMEusCJLq
        HBaGwcpf+Ag8gMAg3xdyr+uEOqu9ew4UDatd0hV6EfzTH0Lv4BOlD6dPuBQcllP9
        0uclN39LyPHsbS2pu21om7GdDWiGi5RSLLEIl656cTsIpAc3k9QKJQqfYK1i/Mse
        Dbv7m55a3mm+DizyRX2sBr125GDwADAcXFqHTL3hnl5FQsf/CXqf+OcGYi6wO11i
        /ZlDI2bDWuD0/0AJfHUcrJKHoNp59LLPhJ5griTvAaNsXw9Pif0CNYiIIjZcwqOL
        TyhUeLmdCtApL4ESJZKA+GHmlPNm3dM=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b2weA5837KUK; Fri, 30 Dec 2022 18:31:40 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id 9D9AE144E;
        Fri, 30 Dec 2022 18:31:40 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 3A0D02491;
        Fri, 30 Dec 2022 18:31:40 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] doc:it_IT: align Italian documentation
Date:   Fri, 30 Dec 2022 18:31:27 +0100
Message-Id: <20221230173127.59553-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translation for the following patches

commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for process substitution")
commit 5372de4e4545 ("docs/doc-guide: Put meta title for kernel-doc HTML page")
commit 4d627ef12b40 ("docs/doc-guide: Mention make variable SPHINXDIRS")
commit 7c43214dddfd ("docs/doc-guide: Add footnote on Inkscape for better images in PDF documents")
commit 615041d42a1a ("docs: kernel-docs: shorten the lengthy doc title")
commit cbf4adfd4d19 ("Documentation: process: Update email client instructions for Thunderbird")
commit e72b3b9810dd ("maintainer-pgp-guide: minor wording tweaks")
commit ea522496afa1 ("Documentation: process: replace outdated LTS table w/ link")
commit 93431e0607e5 ("Replace HTTP links with HTTPS ones: documentation")
commit e648174b53f1 ("Documentation: Fix spelling mistake in hacking.rst")
commit 602684adb42a ("docs: Update version number from 5.x to 6.x in README.rst")
commit 489876063fb1 ("docs: add a man-pages link to the front page")
commit 0c7b4366f1ab ("docs: Rewrite the front page")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
V1 -> V2 fix typo in footnote link

 .../translations/it_IT/admin-guide/README.rst |  2 +-
 .../it_IT/doc-guide/kernel-doc.rst            |  2 +
 .../translations/it_IT/doc-guide/sphinx.rst   | 14 ++-
 Documentation/translations/it_IT/index.rst    | 93 +++++++++----------
 .../it_IT/kernel-hacking/hacking.rst          |  2 +-
 .../translations/it_IT/process/2.Process.rst  | 15 +--
 .../it_IT/process/7.AdvancedTopics.rst        |  8 +-
 .../translations/it_IT/process/changes.rst    | 11 +++
 .../it_IT/process/email-clients.rst           | 67 ++++++++-----
 .../it_IT/process/kernel-docs.rst             |  4 +-
 .../it_IT/process/maintainer-pgp-guide.rst    |  4 +-
 11 files changed, 127 insertions(+), 95 deletions(-)



diff --git a/Documentation/translations/it_IT/admin-guide/README.rst b/Documentation/translations/it_IT/admin-guide/README.rst
index b37166817842..c874586a9af9 100644
--- a/Documentation/translations/it_IT/admin-guide/README.rst
+++ b/Documentation/translations/it_IT/admin-guide/README.rst
@@ -4,7 +4,7 @@
 
 .. _it_readme:
 
-Rilascio del kernel Linux  5.x <http://kernel.org/>
+Rilascio del kernel Linux  6.x <http://kernel.org/>
 ===================================================
 
 .. warning::
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index 78082281acf9..5cece223b46b 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -3,6 +3,8 @@
 .. note:: Per leggere la documentazione originale in inglese:
 	  :ref:`Documentation/doc-guide/index.rst <doc_guide>`
 
+.. title:: Commenti in kernel-doc
+
 .. _it_kernel_doc:
 
 =================================
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 64528790dc34..1f513bc33618 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -151,7 +151,8 @@ Ovviamente, per generare la documentazione, Sphinx (``sphinx-build``)
 dev'essere installato. Se disponibile, il tema *Read the Docs* per Sphinx
 verrà utilizzato per ottenere una documentazione HTML più gradevole.
 Per la documentazione in formato PDF, invece, avrete bisogno di ``XeLaTeX`
-e di ``convert(1)`` disponibile in ImageMagick (https://www.imagemagick.org).
+e di ``convert(1)`` disponibile in ImageMagick
+(https://www.imagemagick.org). \ [#ink]_
 Tipicamente, tutti questi pacchetti sono disponibili e pacchettizzati nelle
 distribuzioni Linux.
 
@@ -162,9 +163,20 @@ la generazione potete usare il seguente comando ``make SPHINXOPTS=-v htmldocs``.
 Potete anche personalizzare l'ouptut html passando un livello aggiuntivo
 DOCS_CSS usando la rispettiva variabile d'ambiente ``DOCS_CSS``.
 
+La variable make ``SPHINXDIRS`` è utile quando si vuole generare solo una parte
+della documentazione. Per esempio, si possono generare solo di documenti in
+``Documentation/doc-guide`` eseguendo ``make SPHINXDIRS=doc-guide htmldocs``. La
+sezione dedicata alla documentazione di ``make help`` vi mostrerà quali sotto
+cartelle potete specificare.
+
 Potete eliminare la documentazione generata tramite il comando
 ``make cleandocs``.
 
+.. [#ink] Avere installato anche ``inkscape(1)`` dal progetto Inkscape ()
+          potrebbe aumentare la qualità delle immagini che verranno integrate
+          nel documento PDF, specialmente per quando si usando rilasci del
+          kernel uguali o superiori a 5.18
+
 Scrivere la documentazione
 ==========================
 
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index e80a3097aa57..5dd751349adc 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -1,13 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _it_linux_doc:
 
 ===================
 Traduzione italiana
 ===================
 
-.. raw:: latex
-
-	\kerneldocCJKoff
-
 :manutentore: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_disclaimer:
@@ -67,75 +65,68 @@ I miglioramenti alla documentazione sono sempre i benvenuti; per cui,
 se vuoi aiutare, iscriviti alla lista di discussione linux-doc presso
 vger.kernel.org.
 
-Documentazione sulla licenza dei sorgenti
------------------------------------------
-
-I seguenti documenti descrivono la licenza usata nei sorgenti del kernel Linux
-(GPLv2), come licenziare i singoli file; inoltre troverete i riferimenti al
-testo integrale della licenza.
+Lavorare con la comunità di sviluppo
+------------------------------------
 
-* :ref:`it_kernel_licensing`
+Le guide fondamentali per l'interazione con la comunità di sviluppo del kernel e
+su come vedere il proprio lavoro integrato.
 
-Documentazione per gli utenti
------------------------------
-
-I seguenti manuali sono scritti per gli *utenti* del kernel - ovvero,
-coloro che cercano di farlo funzionare in modo ottimale su un dato sistema
-
-.. warning::
+.. toctree::
+   :maxdepth: 1
 
-    TODO ancora da tradurre
+   process/development-process
+   process/submitting-patches
+   Code of conduct <process/code-of-conduct>
+   All development-process docs <process/index>
 
-Documentazione per gli sviluppatori di applicazioni
----------------------------------------------------
 
-Il manuale delle API verso lo spazio utente è una collezione di documenti
-che descrivono le interfacce del kernel viste dagli sviluppatori
-di applicazioni.
+Manuali sull'API interna
+------------------------
 
-.. warning::
+Di seguito una serie di manuali per gli sviluppatori che hanno bisogno di
+interfacciarsi con il resto del kernel.
 
-    TODO ancora da tradurre
+.. toctree::
+   :maxdepth: 1
 
+   core-api/index
 
-Introduzione allo sviluppo del kernel
--------------------------------------
+Strumenti e processi per lo sviluppo
+------------------------------------
 
-Questi manuali contengono informazioni su come contribuire allo sviluppo
-del kernel.
-Attorno al kernel Linux gira una comunità molto grande con migliaia di
-sviluppatori che contribuiscono ogni anno. Come in ogni grande comunità,
-sapere come le cose vengono fatte renderà il processo di integrazione delle
-vostre modifiche molto più semplice
+Di seguito una serie di manuali contenenti informazioni utili a tutti gli
+sviluppatori del kernel.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   process/index
+   process/license-rules
    doc-guide/index
    kernel-hacking/index
 
-Documentazione della API del kernel
------------------------------------
+Documentazione per gli utenti
+-----------------------------
 
-Questi manuali forniscono dettagli su come funzionano i sottosistemi del
-kernel dal punto di vista degli sviluppatori del kernel. Molte delle
-informazioni contenute in questi manuali sono prese direttamente dai
-file sorgenti, informazioni aggiuntive vengono aggiunte solo se necessarie
-(o almeno ci proviamo — probabilmente *non* tutto quello che è davvero
-necessario).
+Di seguito una serie di manuali per gli *utenti* del kernel - ovvero coloro che
+stanno cercando di farlo funzionare al meglio per un dato sistema, ma anche
+coloro che stanno sviluppando applicazioni che sfruttano l'API verso lo
+spazio-utente.
 
-.. toctree::
-   :maxdepth: 2
+Consultate anche `Linux man pages <https://www.kernel.org/doc/man-pages/>`_, che
+vengono mantenuti separatamente dalla documentazione del kernel Linux
+
+Documentazione relativa ai firmware
+-----------------------------------
+Di seguito informazioni sulle aspettative del kernel circa i firmware.
 
-   core-api/index
 
 Documentazione specifica per architettura
 -----------------------------------------
 
-Questi manuali forniscono dettagli di programmazione per le diverse
-implementazioni d'architettura.
 
-.. warning::
+Documentazione varia
+--------------------
 
-    TODO ancora da tradurre
+Ci sono documenti che sono difficili da inserire nell'attuale organizzazione
+della documentazione; altri hanno bisogno di essere migliorati e/o convertiti
+nel formato *ReStructured Text*; altri sono semplicamente troppo vecchi.
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index 560f1d0482d2..dd06bfc1a050 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -137,7 +137,7 @@ macro :c:func:`in_softirq()` (``include/linux/preempt.h``).
 .. warning::
 
     State attenti che questa macro ritornerà un falso positivo
-    se :ref:`botton half lock <it_local_bh_disable>` è bloccato.
+    se :ref:`bottom half lock <it_local_bh_disable>` è bloccato.
 
 Alcune regole basilari
 ======================
diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 62826034e0b2..25cd00351c03 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -136,18 +136,11 @@ Quindi, per esempio, la storia del kernel 5.2 appare così (anno 2019):
 La 5.2.21 fu l'aggiornamento finale per la versione 5.2.
 
 Alcuni kernel sono destinati ad essere kernel a "lungo termine"; questi
-riceveranno assistenza per un lungo periodo di tempo.  Al momento in cui
-scriviamo, i manutentori dei kernel stabili a lungo termine sono:
-
-	======  ================================  ==========================================
-	3.16	Ben Hutchings			  (kernel stabile molto più a lungo termine)
-	4.4	Greg Kroah-Hartman e Sasha Levin  (kernel stabile molto più a lungo termine)
-	4.9	Greg Kroah-Hartman e Sasha Levin
-	4.14	Greg Kroah-Hartman e Sasha Levin
-	4.19	Greg Kroah-Hartman e Sasha Levin
-	5.4i	Greg Kroah-Hartman e Sasha Levin
-	======  ================================  ==========================================
+riceveranno assistenza per un lungo periodo di tempo. Consultate il seguente
+collegamento per avere la lista delle versioni attualmente supportate e i
+relativi manutentori:
 
+       https://www.kernel.org/category/releases.html
 
 Questa selezione di kernel di lungo periodo sono puramente dovuti ai loro
 manutentori, alla loro necessità e al tempo per tenere aggiornate proprio
diff --git a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
index cc1cff5d23ae..dffd813a0910 100644
--- a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
@@ -35,9 +35,9 @@ git è parte del processo di sviluppo del kernel.  Gli sviluppatori che
 desiderassero diventare agili con git troveranno più informazioni ai
 seguenti indirizzi:
 
-	http://git-scm.com/
+	https://git-scm.com/
 
-	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+	https://www.kernel.org/pub/software/scm/git/docs/user-manual.html
 
 e su varie guide che potrete trovare su internet.
 
@@ -63,7 +63,7 @@ eseguire git-daemon è relativamente semplice .  Altrimenti, iniziano a
 svilupparsi piattaforme che offrono spazi pubblici, e gratuiti (Github,
 per esempio).  Gli sviluppatori permanenti possono ottenere un account
 su kernel.org, ma non è proprio facile da ottenere; per maggiori informazioni
-consultate la pagina web http://kernel.org/faq/.
+consultate la pagina web https://kernel.org/faq/.
 
 In git è normale avere a che fare con tanti rami.  Ogni linea di sviluppo
 può essere separata in "rami per argomenti" e gestiti indipendentemente.
@@ -137,7 +137,7 @@ vostri rami.  Citando Linus
 	facendo, e ho bisogno di fidarmi *senza* dover passare tutte
 	le modifiche manualmente una per una.
 
-(http://lwn.net/Articles/224135/).
+(https://lwn.net/Articles/224135/).
 
 Per evitare queste situazioni, assicuratevi che tutte le patch in un ramo
 siano strettamente correlate al tema delle modifiche; un ramo "driver fixes"
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 10e0ef9c34b7..473ec2cc558e 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -35,6 +35,7 @@ PC Card, per esempio, probabilmente non dovreste preoccuparvi di pcmciautils.
 GNU C                  5.1                gcc --version
 Clang/LLVM (optional)  11.0.0             clang --version
 GNU make               3.81               make --version
+bash                   4.2                bash --version
 binutils               2.23               ld -v
 flex                   2.5.35             flex --version
 bison                  2.0                bison --version
@@ -88,6 +89,11 @@ Make
 
 Per compilare il kernel vi servirà GNU make 3.81 o successivo.
 
+Bash
+----
+Per generare il kernel vengono usati alcuni script per bash.
+Questo richiede bash 4.2 o successivo.
+
 Binutils
 --------
 
@@ -370,6 +376,11 @@ Make
 
 - <ftp://ftp.gnu.org/gnu/make/>
 
+Bash
+----
+
+- <ftp://ftp.gnu.org/gnu/bash/>
+
 Binutils
 --------
 
diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index b792f2f06a74..970671cd91af 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -288,37 +288,62 @@ Thunderbird (GUI)
 Thunderbird è un clone di Outlook a cui piace maciullare il testo, ma esistono
 modi per impedirglielo.
 
+Dopo la configurazione, inclusa l'installazione delle estenzioni, dovrete
+riavviare Thunderbird.
+
 - permettere l'uso di editor esterni:
+
   La cosa più semplice da fare con Thunderbird e le patch è quello di usare
-  l'estensione "external editor" e di usare il vostro ``$EDITOR`` preferito per
-  leggere/includere patch nel vostro messaggio.  Per farlo, scaricate ed
-  installate l'estensione e aggiungete un bottone per chiamarla rapidamente
-  usando :menuselection:`Visualizza-->Barra degli strumenti-->Personalizza...`;
-  una volta fatto potrete richiamarlo premendo sul bottone mentre siete nella
-  finestra :menuselection:`Scrivi`
-
-  Tenete presente che "external editor" richiede che il vostro editor non
-  faccia alcun fork, in altre parole, l'editor non deve ritornare prima di
-  essere stato chiuso.  Potreste dover passare dei parametri aggiuntivi al
-  vostro editor oppure cambiargli la configurazione.  Per esempio, usando
-  gvim dovrete aggiungere l'opzione -f ``/usr/bin/gvim -f`` (Se il binario
-  si trova in ``/usr/bin``) nell'apposito campo nell'interfaccia di
-  configurazione di  :menuselection:`external editor`.  Se usate altri editor
-  consultate il loro  manuale per sapere come configurarli.
+  estensioni che permettano di aprire il vostro editor preferito.
+
+  Di seguito alcune estensioni che possono essere utili al caso.
+
+  - "External Editor Revived"
+
+    https://github.com/Frederick888/external-editor-revived
+
+    https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/
+
+    L'estensione richiede l'installazione di "native messaging host". Date
+    un'occhiata alla seguente wiki:
+    https://github.com/Frederick888/external-editor-revived/wiki
+
+  - "External Editor"
+
+    https://github.com/exteditor/exteditor
+
+    Per usarlo, scaricate ed installate l'applicazione. Poi aprite la finestra
+    :menuselection:`Scrivi` e a seguire aggiungete un bottone per eseguirlo
+    `Visualizza-->Barra degli strumenti-->Personalizza...`. Infine, premente
+    questo nuovo bottone tutte le volte che volete usare l'editor esterno.
+
+    Tenete presente che "external editor" richiede che il vostro editor non
+    faccia alcun fork, in altre parole, l'editor non deve ritornare prima di
+    essere stato chiuso.  Potreste dover passare dei parametri aggiuntivi al
+    vostro editor oppure cambiargli la configurazione.  Per esempio, usando
+    gvim dovrete aggiungere l'opzione -f ``/usr/bin/gvim -f`` (Se il binario
+    si trova in ``/usr/bin``) nell'apposito campo nell'interfaccia di
+    configurazione di  :menuselection:`external editor`.  Se usate altri editor
+    consultate il loro  manuale per sapere come configurarli.``)``
 
 Per rendere l'editor interno un po' più sensato, fate così:
 
-- Modificate le impostazioni di Thunderbird per far si che non usi
-  ``format=flowed``. Andate in :menuselection:`Modifica-->Preferenze-->Avanzate-->Editor di configurazione`
+- Modificate le impostazioni di Thunderbird per far si che non usi ``format=flowed``!
+  Andate sulla finestra principale e cercate il bottone per il menu a tendina principale.
+  Poi :menuselection:`Modifica-->Preferenze-->Avanzate-->Editor di configurazione`
   per invocare il registro delle impostazioni.
 
-- impostate ``mailnews.send_plaintext_flowed`` a ``false``
+  - impostate ``mailnews.send_plaintext_flowed`` a ``false``
 
-- impostate ``mailnews.wraplength`` da ``72`` a ``0``
+  - impostate ``mailnews.wraplength`` da ``72`` a ``0``
 
-- :menuselection:`Visualizza-->Corpo del messaggio come-->Testo semplice`
+- Non scrivete messaggi HTML! Andate sulla finestra principale ed aprite la
+  schermata :menuselection:`Menu principale-->Impostazioni account-->nome@unserver.ovunque-->Composizioni e indirizzi`.
+  Qui potrete disabilitare l'opzione "Componi i messaggi in HTML"
 
-- :menuselection:`Visualizza-->Codifica del testo-->Unicode`
+- Aprite i messaggi solo in formato testo! Andate sulla finestra principale e
+  selezionate
+  :menuselection:`Menu principale-->Visualizza-->Copro del messaggio come-->Testo semplice`
 
 
 TkRat (GUI)
diff --git a/Documentation/translations/it_IT/process/kernel-docs.rst b/Documentation/translations/it_IT/process/kernel-docs.rst
index 38e0a955121a..eadcbf50a1b5 100644
--- a/Documentation/translations/it_IT/process/kernel-docs.rst
+++ b/Documentation/translations/it_IT/process/kernel-docs.rst
@@ -6,8 +6,8 @@
 
 .. _it_kernel_docs:
 
-Indice di documenti per le persone interessate a capire e/o scrivere per il kernel Linux
-========================================================================================
+Ulteriore Documentazione Del Kernel Linux
+=========================================
 
 .. note::
    Questo documento contiene riferimenti a documenti in lingua inglese; inoltre
diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index a1e98ec9532e..4bd7a8a66904 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -286,9 +286,7 @@ magari in una cassetta di sicurezza in banca.
     Probabilmente la vostra stampante non è più quello stupido dispositivo
     connesso alla porta parallela, ma dato che il suo output è comunque
     criptato con la passphrase, eseguire la stampa in un sistema "cloud"
-    moderno dovrebbe essere comunque relativamente sicuro. Un'opzione potrebbe
-    essere quella di cambiare la passphrase della vostra chiave primaria
-    subito dopo aver finito con paperkey.
+    moderno dovrebbe essere comunque relativamente sicuro.
 
 Copia di riserva di tutta la cartella GnuPG
 -------------------------------------------
-- 
2.30.2

