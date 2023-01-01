Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B6365AA7C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjAAP4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAAP4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:56:13 -0500
Received: from smtp.tiscali.it (santino-notr.mail.tiscali.it [213.205.33.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35C6B44
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:56:10 -0800 (PST)
Received: from localhost.localdomain ([95.236.88.218])
        by santino.mail.tiscali.it with 
        id 3Tw62900u4ifYS701Tw7rk; Sun, 01 Jan 2023 15:56:07 +0000
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
Subject: [PATCH] doc:it_IT: fix of 2 typos
Date:   Sun,  1 Jan 2023 16:55:48 +0100
Message-Id: <20230101155548.12350-1-fantonifabio@tiscali.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1672588567; bh=UgaiJxiMPovoFF2XoBdbAEToxfBelkU9Vdzn09r5cgY=;
        h=From:To:Cc:Subject:Date;
        b=LIMItimcBLdyG6CTb2MpFyiAQIx26TzMyfYjSQS+wP1JbUGwEwP2StoVrYsJn8bBs
         SON7wsKafxY3ofCGE8hAI2jFEeWsE9gqrNygiOqP20jh6I4llcgD7+//gStyyqFccd
         ivXvhbI5LrymgalT+n5SM5oG31nV5tqvssf9LACc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of 2 typos spotted reading documentation in italian

Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>
---
 .../translations/it_IT/process/maintainer-pgp-guide.rst         | 2 +-
 Documentation/translations/it_IT/process/submitting-patches.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index a1e98ec9532e..37a8ecb00af2 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -163,7 +163,7 @@ chiave principale attraverso firme certificate. È quindi importante
 comprendere i seguenti punti:
 
 1. Non ci sono differenze tecniche tra la chiave principale e la sottochiave.
-2. In fesa di creazione, assegniamo limitazioni funzionali ad ogni chiave
+2. In fase di creazione, assegniamo limitazioni funzionali ad ogni chiave
    assegnando capacità specifiche.
 3. Una chiave PGP può avere 4 capacità:
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index a3bb0008837a..c2cfa0948b2b 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -340,7 +340,7 @@ Assicuratevi di dire ai revisori quali cambiamenti state facendo e di
 ringraziarli per il loro tempo.  Revisionare codice è un lavoro faticoso e che
 richiede molto tempo, e a volte i revisori diventano burberi. Tuttavia, anche in
 questo caso, rispondete con educazione e concentratevi sul problema che hanno
-evidenziato. Quando inviate una version successiva ricordatevi di aggiungere un
+evidenziato. Quando inviate una versione successiva ricordatevi di aggiungere un
 ``patch changelog`` alla email di intestazione o ad ogni singola patch spiegando
 le differenze rispetto a sottomissioni precedenti (vedere
 :ref:`it_the_canonical_patch_format`).
-- 
2.25.1

