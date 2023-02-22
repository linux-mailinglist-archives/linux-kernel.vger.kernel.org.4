Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DAC69F6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBVOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjBVOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:43:47 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851BF3A091
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:43:42 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PMJmz28wLz9sTL;
        Wed, 22 Feb 2023 15:43:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sDcWV7853Llc; Wed, 22 Feb 2023 15:43:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PMJmw72vbz9sTR;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E2EF38B781;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XBs0U_H5tzDi; Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 929FF8B78B;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31MEhLeT1187101
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:43:21 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31MEhLeX1187100;
        Wed, 22 Feb 2023 15:43:21 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 04/17] powerpc/85xx: Remove #ifdefs CONFIG_PCI in mpc85xx_ds
Date:   Wed, 22 Feb 2023 15:42:51 +0100
Message-Id: <b8ff8526affea2e2653eeb79b47efe3aaf443818.1677076552.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677076552.git.christophe.leroy@csgroup.eu>
References: <cover.1677076552.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677076979; l=1249; s=20211009; h=from:subject:message-id; bh=JCayyRoure02691uo1aI3JU4oKI7/DRa3WvvOlic8tE=; b=a+Z0wj7IUdMg0vSAIlWoXp4iCqBx/Hk+1rPswmjNvlZjQ2THYMWD3CNY2cFW5aC0atypHdC22w2r 4hPWi14wALH5IN54/B6u6t8s3QwW5SqKfhZXBvAYQD9zozJ55API
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
a #ifdef CONFIG_PCI.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 26257509aabf..f385cd288a76 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -99,7 +99,6 @@ void __init mpc85xx_ds_pic_init(void)
 #endif	/* CONFIG_PPC_I8259 */
 }
 
-#ifdef CONFIG_PCI
 static struct device_node *pci_with_uli;
 
 static int mpc85xx_exclude_device(struct pci_controller *hose,
@@ -110,13 +109,14 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 
 	return PCIBIOS_SUCCESSFUL;
 }
-#endif	/* CONFIG_PCI */
 
 static void __init mpc85xx_ds_uli_init(void)
 {
-#ifdef CONFIG_PCI
 	struct device_node *node;
 
+	if (!IS_ENABLED(CONFIG_PCI))
+		return;
+
 	/* See if we have a ULI under the primary */
 
 	node = of_find_node_by_name(NULL, "uli1575");
@@ -129,7 +129,6 @@ static void __init mpc85xx_ds_uli_init(void)
 			break;
 		}
 	}
-#endif
 }
 
 /*
-- 
2.39.1

