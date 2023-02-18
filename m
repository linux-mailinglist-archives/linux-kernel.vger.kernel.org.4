Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070AD69B8FB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBRJQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBRJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:16:57 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676DF59731
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 01:16:38 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PJjjF0ZDGz9scy;
        Sat, 18 Feb 2023 10:16:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sWFCrmNmOl8R; Sat, 18 Feb 2023 10:16:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PJjjC2n87z9scs;
        Sat, 18 Feb 2023 10:16:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 499E18B768;
        Sat, 18 Feb 2023 10:16:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bU9qg2aDXMn8; Sat, 18 Feb 2023 10:16:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E001A8B76E;
        Sat, 18 Feb 2023 10:16:14 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31I9G9j9642589
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 10:16:09 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31I9G9sG642588;
        Sat, 18 Feb 2023 10:16:09 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/10] powerpc/85xx: Don't check ppc_md.progress in mpc85xx_cds_setup_arch()
Date:   Sat, 18 Feb 2023 10:15:53 +0100
Message-Id: <2830e8982942088a5dc882980045d924ef6e4a90.1676711562.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <6cb9865d916231c38401ba34ad1a98c249fae135.1676711562.git.christophe.leroy@csgroup.eu>
References: <6cb9865d916231c38401ba34ad1a98c249fae135.1676711562.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676711719; l=1383; s=20211009; h=from:subject:message-id; bh=CkexO9nWG62Wgf3O48GCFq1qIddbZ+AKNgX3L52bRU0=; b=EEtN26aojMQXzRmU0xyXr6V3ZCYpYQi6bZGjjsrRYE7Mo9tyYPPnOouiq0xt5TBavf6EC854x6gJ 4Z+UNZj1C3QpCPpfLj2pFxLWS46HYBiqPKfaKDo/tR0i5BsIY6OP
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc85xx_cds_setup_arch() is not a hot path, creating the string to be
printed even when it doesn't get printed at the end is not an problem.

Do it at all time.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 41079d02dee8..dd969311b78e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -318,6 +318,7 @@ static void __init mpc85xx_cds_setup_arch(void)
 {
 	struct device_node *np;
 	int cds_pci_slot;
+	char buf[40];
 
 	ppc_md_progress("mpc85xx_cds_setup_arch()", 0);
 
@@ -334,13 +335,9 @@ static void __init mpc85xx_cds_setup_arch(void)
 		return;
 	}
 
-	if (ppc_md.progress) {
-		char buf[40];
-		cds_pci_slot = ((in_8(&cadmus->cm_csr) >> 6) & 0x3) + 1;
-		snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n",
-				in_8(&cadmus->cm_ver), cds_pci_slot);
-		ppc_md_progress(buf, 0);
-	}
+	cds_pci_slot = ((in_8(&cadmus->cm_csr) >> 6) & 0x3) + 1;
+	snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n", in_8(&cadmus->cm_ver), cds_pci_slot);
+	ppc_md_progress(buf, 0);
 
 #ifdef CONFIG_PCI
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
-- 
2.39.1

