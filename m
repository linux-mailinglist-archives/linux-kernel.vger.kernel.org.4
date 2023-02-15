Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2D697D29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjBON0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjBON0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:26:17 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7959EFE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:26:15 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PGzNx0t9Fz9slx;
        Wed, 15 Feb 2023 14:26:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HOsRgCvTSLX7; Wed, 15 Feb 2023 14:26:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PGzNQ6858z9smj;
        Wed, 15 Feb 2023 14:25:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 88EC18B7D2;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0iGE514H0KW3; Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D70F8B7C6;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31FCrsAu217593
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 13:53:54 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31FCrsXw217592;
        Wed, 15 Feb 2023 13:53:54 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 5/9] powerpc/85xx: Fix function naming for p1023_rdb platform
Date:   Wed, 15 Feb 2023 13:53:34 +0100
Message-Id: <c50909619cc0b327876ec5871bd6bf1b2b78b5d1.1676465585.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
References: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676465615; l=1494; s=20211009; h=from:subject:message-id; bh=gJxEFqZl8q6pBdgMpC6eax3T1hJVT92UBHCAGel8LtQ=; b=CcFpAkQ2GBlDQpHvYcEGFHfjQ65lgf5n/IaM8WPiyapwI0EzvOSVkjRLozJcXcVGZdyITPGTRti3 QveidEWrDWbPBMuPKnVKC/GbDsz0iGbV9YdAg4v9UoXWWiW7OVMn
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p1023_rdb platform is a copy of mpc85xx_rdb platform and some of its
functions have kept mpc85xx_rdb names.

Rename the said functions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/p1023_rdb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index 37e78f40d424..e199fc44fc2f 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -37,7 +37,7 @@
  * Setup the architecture
  *
  */
-static void __init mpc85xx_rdb_setup_arch(void)
+static void __init p1023_rdb_setup_arch(void)
 {
 	struct device_node *np;
 
@@ -83,7 +83,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 machine_arch_initcall(p1023_rdb, mpc85xx_common_publish_devices);
 
-static void __init mpc85xx_rdb_pic_init(void)
+static void __init p1023_rdb_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
 		MPIC_SINGLE_DEST_CPU,
@@ -97,8 +97,8 @@ static void __init mpc85xx_rdb_pic_init(void)
 define_machine(p1023_rdb) {
 	.name			= "P1023 RDB",
 	.compatible		= "fsl,P1023RDB",
-	.setup_arch		= mpc85xx_rdb_setup_arch,
-	.init_IRQ		= mpc85xx_rdb_pic_init,
+	.setup_arch		= p1023_rdb_setup_arch,
+	.init_IRQ		= p1023_rdb_pic_init,
 	.get_irq		= mpic_get_irq,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-- 
2.39.1

