Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D669F6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjBVOpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBVOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:45:09 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EFF2201B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:44:34 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PMJn24BcHz9sTK;
        Wed, 22 Feb 2023 15:43:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1B_hiUGDNoUU; Wed, 22 Feb 2023 15:43:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PMJmw6rcyz9sTP;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA1F98B798;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tVgWbnZBDkVp; Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FBE58B78F;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31MEhM2J1187117
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:43:22 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31MEhMbw1187116;
        Wed, 22 Feb 2023 15:43:22 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 08/17] powerpc/85xx: Remove #ifdefs CONFIG_PPC_I8259 in mpc85xx_ds
Date:   Wed, 22 Feb 2023 15:42:55 +0100
Message-Id: <3fc29340ba57d61921ddf395ac80a3a83b37783b.1677076552.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677076552.git.christophe.leroy@csgroup.eu>
References: <cover.1677076552.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677076980; l=2267; s=20211009; h=from:subject:message-id; bh=nWBQe8lwquK/CyACk0YHIWCQ+dvzXRrfH8PjQNsiwUc=; b=vOen4Nhkhe/fay27COFNi0kjTgJH/0sSQB9xScuRfbh1tOmbIxSyKhI5R0RYOVy5gNMmzoQY/+Wm WE46ykuwBIwVWB6AkHyNgQXFfTSB20Ayxjzsz1DLYrVrlxzbpAYz
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All necessary items are declared all the time, no need to use
a #ifdef CONFIG_PPC_I8259.

Refactor CONFIG_PPC_I8259 actions into a dedicated init function.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 37 +++++++++++++-----------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index e995c939c14d..2b3e9aecb3ad 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -34,7 +34,6 @@
 
 #include "mpc85xx.h"
 
-#ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -45,29 +44,16 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
 	}
 	chip->irq_eoi(&desc->irq_data);
 }
-#endif	/* CONFIG_PPC_I8259 */
 
-void __init mpc85xx_ds_pic_init(void)
+static void __init mpc85xx_8259_init(void)
 {
-	struct mpic *mpic;
-	int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU;
-#ifdef CONFIG_PPC_I8259
 	struct device_node *np;
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
-#endif
 
-	if (of_machine_is_compatible("fsl,MPC8572DS-CAMP"))
-		flags |= MPIC_NO_RESET;
-
-	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
-
-	if (WARN_ON(!mpic))
+	if (!IS_ENABLED(CONFIG_PPC_I8259))
 		return;
 
-	mpic_init(mpic);
-
-#ifdef CONFIG_PPC_I8259
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
 	    if (of_device_is_compatible(np, "chrp,iic")) {
@@ -92,7 +78,24 @@ void __init mpc85xx_ds_pic_init(void)
 	of_node_put(cascade_node);
 
 	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
-#endif	/* CONFIG_PPC_I8259 */
+}
+
+void __init mpc85xx_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU;
+
+	if (of_machine_is_compatible("fsl,MPC8572DS-CAMP"))
+		flags |= MPIC_NO_RESET;
+
+	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
+
+	if (WARN_ON(!mpic))
+		return;
+
+	mpic_init(mpic);
+
+	mpc85xx_8259_init();
 }
 
 static struct device_node *pci_with_uli;
-- 
2.39.1

