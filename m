Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10CB69B91B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBRJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:29:03 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A5829E26
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 01:29:02 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PJjzx3JR0z9sbd;
        Sat, 18 Feb 2023 10:29:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1yBzKFv13ba2; Sat, 18 Feb 2023 10:29:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PJjzx2ZJ4z9sWY;
        Sat, 18 Feb 2023 10:29:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 451668B768;
        Sat, 18 Feb 2023 10:29:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id O_BMGtLZa0IN; Sat, 18 Feb 2023 10:29:01 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E1C48B764;
        Sat, 18 Feb 2023 10:29:01 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 31I9Sq3d644371
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 18 Feb 2023 10:28:53 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 31I9SpLa644369;
        Sat, 18 Feb 2023 10:28:51 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/e500: Add missing prototype for 'relocate_init'
Date:   Sat, 18 Feb 2023 10:28:50 +0100
Message-Id: <ac9107acf24135e1a07e8f84d2090572d43e3fe4.1676712510.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676712516; l=1217; s=20211009; h=from:subject:message-id; bh=pfVj+fGo1djC+tVecmlDArzordscRtCM4E2ms3R4K3U=; b=6OT4l93tyj8545rUYFu1CCuXDkDFOIwBCZTCy572l5zArzVPKJ6mFf5Lqe9Re/2q/QrmdRsKj5FV vPDMZSG/Af+/o+whdbcQrRI3MfiBcIWFAJsTfLU7EYX/2EJy9hn4
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot reports:

 arch/powerpc/mm/nohash/e500.c:314:21: warning: no previous prototype for 'relocate_init' [-Wmissing-prototypes]
     314 | notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
         |                     ^~~~~~~~~~~~~

Add it in mm/mmu_decl.h, close to associated is_second_reloc
variable declaration.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302181136.wgyCKUcs-lkp@intel.com/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mmu_decl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index bd9784f77f2e..c6dccb4f06dc 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -120,6 +120,7 @@ extern int switch_to_as1(void);
 extern void restore_to_as0(int esel, int offset, void *dt_ptr, int bootcpu);
 void create_kaslr_tlb_entry(int entry, unsigned long virt, phys_addr_t phys);
 void reloc_kernel_entry(void *fdt, int addr);
+void relocate_init(u64 dt_ptr, phys_addr_t start);
 extern int is_second_reloc;
 #endif
 extern void loadcam_entry(unsigned int index);
-- 
2.39.1

