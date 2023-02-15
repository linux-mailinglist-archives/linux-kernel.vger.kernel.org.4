Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C76697D46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjBON2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBON2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:28:15 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB61EBD8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:27:54 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PGzQw6WMxz9sn5;
        Wed, 15 Feb 2023 14:27:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6AZbfSIy0bID; Wed, 15 Feb 2023 14:27:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PGzNR6KfMz9sqR;
        Wed, 15 Feb 2023 14:25:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E0DD8B7CF;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rihwisEUme3x; Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 37CF08B7CB;
        Wed, 15 Feb 2023 13:53:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31FCrrnr217585
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 13:53:53 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31FCrrWl217576;
        Wed, 15 Feb 2023 13:53:53 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/9] powerpc/47x: Split ppc47x machine in two
Date:   Wed, 15 Feb 2023 13:53:32 +0100
Message-Id: <ae59e5bec0293b09a1e31690570cd1347b2d6fa6.1676465585.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
References: <04ed69b4226633ab90983d7efb5bd4791078fe71.1676465585.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676465615; l=1735; s=20211009; h=from:subject:message-id; bh=mO1ZrqR5QlDGNqQ7T7X5dkk0teKsfGmlGQmXCJH93zY=; b=ZAHjOOAT4cPs4/5kInkZupcmV5xdeIGGCC7nofeEZLZwT2HL8i3t6rR4pq/KPa1CC08eaI0XAhhW 4Xd8QhFuCUTizN4h+v59aUHcJYvUUGIAHzqUSw5nKB4LOe/gci3E
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This machine matches two compatibles and sets .pci_irq_fixup
on one of them.

Split it into two machines, then the probe function can be dropped.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/44x/ppc476.c | 31 +++++++++++++----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index 7c91ac5a5241..f0b411cc7bb7 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -268,27 +268,24 @@ static void ppc47x_pci_irq_fixup(struct pci_dev *dev)
 	}
 }
 
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init ppc47x_probe(void)
-{
-	if (of_machine_is_compatible("ibm,akebono"))
-		return 1;
-
-	if (of_machine_is_compatible("ibm,currituck")) {
-		ppc_md.pci_irq_fixup = ppc47x_pci_irq_fixup;
-		return 1;
-	}
-
-	return 0;
-}
+define_machine(ppc47x_akebono) {
+	.name			= "PowerPC 47x (akebono)",
+	.compatible		= "ibm,akebono",
+	.probe			= ppc47x_probe,
+	.progress		= udbg_progress,
+	.init_IRQ		= ppc47x_init_irq,
+	.setup_arch		= ppc47x_setup_arch,
+	.restart		= ppc4xx_reset_system,
+	.calibrate_decr		= generic_calibrate_decr,
+};
 
-define_machine(ppc47x) {
-	.name			= "PowerPC 47x",
+define_machine(ppc47x_currituck) {
+	.name			= "PowerPC 47x (currituck)",
+	.compatible		= "ibm,currituck",
 	.probe			= ppc47x_probe,
 	.progress		= udbg_progress,
 	.init_IRQ		= ppc47x_init_irq,
+	.pci_irq_fixup		= ppc47x_pci_irq_fixup,
 	.setup_arch		= ppc47x_setup_arch,
 	.restart		= ppc4xx_reset_system,
 	.calibrate_decr		= generic_calibrate_decr,
-- 
2.39.1

