Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B769F6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjBVOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjBVOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:44:14 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D073BD9A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:43:58 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PMJn12ZFvz9sTQ;
        Wed, 22 Feb 2023 15:43:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3DgWs34JgsOx; Wed, 22 Feb 2023 15:43:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PMJmw6p2hz9sTK;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D7A3C8B794;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7003Of7F5LMG; Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FCE48B781;
        Wed, 22 Feb 2023 15:43:28 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31MEhKhK1187089
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 15:43:20 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31MEhKoB1187087;
        Wed, 22 Feb 2023 15:43:20 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 01/17] powerpc/fsl_uli1575: Misc cleanup
Date:   Wed, 22 Feb 2023 15:42:48 +0100
Message-Id: <70972191244129f5cea0b3eb69e59ad5059e95f9.1677076552.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677076552.git.christophe.leroy@csgroup.eu>
References: <cover.1677076552.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677076979; l=2790; s=20211009; h=from:subject:message-id; bh=Iw2tMxl05JMdpPVBeFUeUnlADwfpURzME+4librsKOA=; b=EhSz/Ck62OYqTJaShHsBbTjlBY88F1HKt7DyMb9FshvBatW1AkA1CmPYhBVAetMbjfzyM9YWuf1i x9CDTKjQAlL40D9uM1grUel/qXFj+KLPijVakenjjPt+Hc8fATmS
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a single line for uli_exclude_device()

Add uli_exclude_device() prototype in ppc-pci.h

Remove that prototype from mpc85xx_ds.c

Make uli_pirq_to_irq[] static as it is used only in that file.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-pci.h       | 2 ++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 4 +---
 arch/powerpc/platforms/fsl_uli1575.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index f6cf0159024e..1e9a7f8b05c9 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -57,6 +57,8 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev);
 
 #endif /* CONFIG_EEH */
 
+int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn);
+
 #define PCI_BUSNO(bdfn) ((bdfn >> 8) & 0xff)
 
 #else /* CONFIG_PCI */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index f8d2c97f39bd..97e441878409 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -26,6 +26,7 @@
 #include <asm/mpic.h>
 #include <asm/i8259.h>
 #include <asm/swiotlb.h>
+#include <asm/ppc-pci.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -107,9 +108,6 @@ void __init mpc85xx_ds_pic_init(void)
 }
 
 #ifdef CONFIG_PCI
-extern int uli_exclude_device(struct pci_controller *hose,
-				u_char bus, u_char devfn);
-
 static struct device_node *pci_with_uli;
 
 static int mpc85xx_exclude_device(struct pci_controller *hose,
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 84afae7a2561..a32f9cef7845 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 
 #define ULI_PIRQA	0x08
 #define ULI_PIRQB	0x09
@@ -36,7 +37,7 @@
 #define ULI_8259_IRQ14	0x0d
 #define ULI_8259_IRQ15	0x0f
 
-u8 uli_pirq_to_irq[8] = {
+static u8 uli_pirq_to_irq[8] = {
 	ULI_8259_IRQ9,		/* PIRQA */
 	ULI_8259_IRQ10,		/* PIRQB */
 	ULI_8259_IRQ11,		/* PIRQC */
@@ -341,8 +342,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, hpcd_quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, hpcd_quirk_uli5229);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5288, hpcd_final_uli5288);
 
-int uli_exclude_device(struct pci_controller *hose,
-			u_char bus, u_char devfn)
+int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
 	if (bus == (hose->first_busno + 2)) {
 		/* exclude Modem controller */
-- 
2.39.1

