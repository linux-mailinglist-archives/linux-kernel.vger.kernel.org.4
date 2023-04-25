Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873996EE0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjDYLMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjDYLMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:12:38 -0400
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 04:12:32 PDT
Received: from smtp.tiscali.it (santino-notr.mail.tiscali.it [213.205.33.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2E501707
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:12:32 -0700 (PDT)
Received: from localhost.localdomain ([82.50.13.242])
        by santino.mail.tiscali.it with 
        id oz2K290035DLhyi01z2KTg; Tue, 25 Apr 2023 11:02:19 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
From:   Fabio Fantoni <fantonifabio@tiscali.it>
To:     corbet@lwn.net
Cc:     federico.vaga@vaga.pv.it, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabio Fantoni <fantonifabio@tiscali.it>
Subject: [PATCH] doc:it_IT: fix some typos
Date:   Tue, 25 Apr 2023 13:01:58 +0200
Message-Id: <20230425110158.9755-1-fantonifabio@tiscali.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1682420540; bh=3be052tQCPQFRoxGAIepL6ULuIzfWsFIYHBqOVLM3MU=;
        h=From:To:Cc:Subject:Date;
        b=SljS0bTbIdBfHZpp+iD1MPiEsWh9bsWNuD3MM3F8EMflsZoSNm7nkQyyNmyLonS8B
         /WyRaJORdYb5FDkn7Onvv7cFL78d7DFlGgwlI8Ewoq2qY58agqlw9Qox/xi5U36BGg
         PS4oChmfNyfxLs9ZPM+XeLWE6jpp1hIwElyRy65s=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of some typos spotted reading documentation in italian and latest
changes for 6.4

Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>
---
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 2 +-
 Documentation/translations/it_IT/process/deprecated.rst     | 2 +-
 .../translations/it_IT/process/submitting-patches.rst       | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index a9e781d2e323..4c21cf60f775 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1030,7 +1030,7 @@ alle corse critiche, dovreste usare timer_delete_sync()
 (``include/linux/timer.h``) per gestire questo caso.
 
 Prima di rilasciare un temporizzatore dovreste chiamare la funzione
-timer_shutdown() o timer_shutdown_sync() di modo che non venga più ricarmato.
+timer_shutdown() o timer_shutdown_sync() di modo che non venga più riarmato.
 Ogni successivo tentativo di riarmare il temporizzatore verrà silenziosamente
 ignorato.
 
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index 57b501f0dfa4..ba0ed7dc154c 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -386,7 +386,7 @@ combinazione con struct_size() e flex_array_size()::
 Ci sono due casi speciali dove è necessario usare la macro DECLARE_FLEX_ARRAY()
 (da notare che la stessa macro è chiamata __DECLARE_FLEX_ARRAY() nei file di
 intestazione UAPI). Uno è quando l'array flessibile è l'unico elemento di una
-struttura, e l'altro è quando è parti un unione. Per motivi non tecnici, entrambi
+struttura, e l'altro quando è parte di un unione. Per motivi non tecnici, entrambi
 i casi d'uso non sono permessi dalla specifica C99. Per esempio, per
 convertire il seguente codice::
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index 447b18792e61..f91c8092844f 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -532,7 +532,7 @@ manutentori che qualche verifica è stata fatta, fornisce un mezzo per trovare
 persone che possano verificare il codice in futuro, e garantisce che queste
 stesse persone ricevano credito per il loro lavoro.
 
-Reviewd-by:, invece, indica che la patch è stata revisionata ed è stata
+Reviewed-by:, invece, indica che la patch è stata revisionata ed è stata
 considerata accettabile in accordo con la dichiarazione dei revisori:
 
 Dichiarazione di svista dei revisori
@@ -563,13 +563,13 @@ una modifica che si ritiene appropriata e senza alcun problema tecnico
 importante.  Qualsiasi revisore interessato (quelli che lo hanno fatto)
 possono offrire il proprio Reviewed-by per la patch.  Questa etichetta serve
 a dare credito ai revisori e a informare i manutentori sul livello di revisione
-che è stato fatto sulla patch.  L'etichetta Reviewd-by, quando fornita da
+che è stato fatto sulla patch.  L'etichetta Reviewed-by, quando fornita da
 revisori conosciuti per la loro conoscenza sulla materia in oggetto e per la
 loro serietà nella revisione, accrescerà le probabilità che la vostra patch
 venga integrate nel kernel.
 
 Quando si riceve una email sulla lista di discussione da un tester o
-un revisore, le etichette Tested-by o Reviewd-by devono essere
+un revisore, le etichette Tested-by o Reviewed-by devono essere
 aggiunte dall'autore quando invierà nuovamente la patch. Tuttavia, se
 la patch è cambiata in modo significativo, queste etichette potrebbero
 non avere più senso e quindi andrebbero rimosse. Solitamente si tiene traccia
-- 
2.25.1

