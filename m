Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3344D69F6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjBVOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBVOnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:43:37 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED5830187
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:43:33 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PMJmx0CJkz9sTS;
        Wed, 22 Feb 2023 15:43:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g40_R-pM2LYA; Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PMJmw6S1Gz9sTB;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD7398B792;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N7c-RGXU8gm7; Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EC268B763;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31MEhLmU1187113
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:43:22 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31MEhLPk1187112;
        Wed, 22 Feb 2023 15:43:21 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 07/17] powerpc/85xx: mpc85xx_{ds/rdb} replace prink by pr_xxx macro
Date:   Wed, 22 Feb 2023 15:42:54 +0100
Message-Id: <7ae9b975a748d4f6363b2b16cf004228c0b07201.1677076552.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677076552.git.christophe.leroy@csgroup.eu>
References: <cover.1677076552.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677076980; l=1861; s=20211009; h=from:subject:message-id; bh=zQ8/c7+TvYXkwm4Y4srKRxXjUkN4RF8MxkzWsUPn0Pw=; b=x4mdee88ParytD4/l4TUCDwqWamtnCaC2qGYnLQWK1HtsDBOTURqqxTneQ3E5UfzNKGghgQX8f1D NCcfpLGeBWNXOWE7fhBLUPdm3CZTO9U51ujnxduK9gg+XVxN+UKU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_debug() instead of printk(KERN_DEBUG
Use pr_err() instead of printk(KERN_ERR
Use pr_info() instead of printk(KERN_INFO or printk("

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  | 6 +++---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 60d473d9b8ee..e995c939c14d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -76,13 +76,13 @@ void __init mpc85xx_ds_pic_init(void)
 	}
 
 	if (cascade_node == NULL) {
-		printk(KERN_DEBUG "Could not find i8259 PIC\n");
+		pr_debug("Could not find i8259 PIC\n");
 		return;
 	}
 
 	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
 	if (!cascade_irq) {
-		printk(KERN_ERR "Failed to map cascade interrupt\n");
+		pr_err("Failed to map cascade interrupt\n");
 		return;
 	}
 
@@ -140,7 +140,7 @@ static void __init mpc85xx_ds_setup_arch(void)
 	mpc85xx_ds_uli_init();
 	mpc85xx_smp_init();
 
-	printk("MPC85xx DS board from Freescale Semiconductor\n");
+	pr_info("MPC85xx DS board from Freescale Semiconductor\n");
 }
 
 /*
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 34b65441661e..8b0d81f0e1c9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -92,7 +92,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 #endif
 #endif	/* CONFIG_QUICC_ENGINE */
 
-	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
+	pr_info("MPC85xx RDB board from Freescale Semiconductor\n");
 }
 
 machine_arch_initcall(p2020_rdb, mpc85xx_common_publish_devices);
-- 
2.39.1

