Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09E6DBBFE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDHPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDHPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB5D301
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D3B5615B4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B464C433A8;
        Sat,  8 Apr 2023 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680968961;
        bh=YEYW+9T4EI8T6uo7e4f/NgSgHv1w/SjKHzpBZaSdlx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrcbHqbbNxOyK2HY+wx1TAcSHuJKNfaXq3vpPuONPjWbum5slvVqFZbSjmM/tlM3n
         A3xrxVUIgZTB7+wua8CHoLiD4JY+lfvEuTPSa5dhkOqLsK02DaMhuYmIJAKF7uZ5vb
         AzXSpjAEGK0HyUn6M0J1OBBfvjbmFGsP1l/TQoaxPflF072BCdXrIeFMHRCGqlEjBX
         UATYMK5yJfYtPV047r8+yprg5+vNvkp4WCi48eI3ClzSnBYnWSNblfmeLPCXyKu+oV
         EHjehqE7PDsKUTFUQGcW/PWEwI1jHK7x2AAHzga5LMn86xL+JaofiVE9G+LyS1GqZW
         9a/qibwMWUiHw==
Received: by pali.im (Postfix)
        id 111382317; Sat,  8 Apr 2023 17:49:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] powerpc/fsl_uli1575: Mark uli_exclude_device() as static
Date:   Sat,  8 Apr 2023 17:48:14 +0200
Message-Id: <20230408154814.10400-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408154814.10400-1-pali@kernel.org>
References: <20230408154814.10400-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function uli_exclude_device() is not used outside of the fsl_uli1575.c
source file anymore. So mark it as static and remove public prototype.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/include/asm/ppc-pci.h   | 3 ---
 arch/powerpc/platforms/fsl_uli1575.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 0e393aeed912..d9fcff575027 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -58,7 +58,6 @@ void eeh_sysfs_remove_device(struct pci_dev *pdev);
 #endif /* CONFIG_EEH */
 
 #ifdef CONFIG_FSL_ULI1575
-int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn);
 void __init uli_init(void);
 #endif /* CONFIG_FSL_ULI1575 */
 
@@ -69,8 +68,6 @@ static inline void init_pci_config_tokens(void) { }
 #endif /* !CONFIG_PCI */
 
 #if !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575)
-#include <linux/pci.h>
-static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
 static inline void __init uli_init(void) {}
 #endif /* !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575) */
 
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index b073db9d7c79..b8d37a9932f1 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -344,7 +344,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, hpcd_quirk_uli5288);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, hpcd_quirk_uli5229);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5288, hpcd_final_uli5288);
 
-int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
+static int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn)
 {
 	if (hose->dn == fsl_pci_primary && bus == (hose->first_busno + 2)) {
 		/* exclude Modem controller */
-- 
2.20.1

