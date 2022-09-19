Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E15BD354
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiISRIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiISRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:08:08 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B36B3F317
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:06:04 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MWWF90gRnz9slF;
        Mon, 19 Sep 2022 19:02:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ie8HRh2nz6OU; Mon, 19 Sep 2022 19:02:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MWWDr63Klz9slC;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ADBF68B77D;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pLzKLz5YKgIo; Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A7FF8B778;
        Mon, 19 Sep 2022 19:02:04 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28JH20iq1549653
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 19:02:00 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28JH20Ud1549652;
        Mon, 19 Sep 2022 19:02:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 19/19] powerpc: Remove impossible mmu_psize_defs[] on nohash
Date:   Mon, 19 Sep 2022 19:01:43 +0200
Message-Id: <030a843449f348c0b709ca5349640624f36a016f.1663606876.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663606900; l=2716; s=20211009; h=from:subject:message-id; bh=nioyTUrOcI0IAX5HeERk3XUyDqQ/dEMnQUd5F2Nwdqs=; b=nR6Hho7Ye5PVaGQECxLSQ1KMmCb9+i66cAkobdtkukNvnAX6oQFyuXreMNVuO1lEDa6xfkPTyvqq gzXNSvnVDqyiFhHvF357JJ/Yw3Ub1e0HJ3azDa3h3v6ooO5xX5G3
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today there is:

  if e500 or 8xx
    if e500
      mmu_psize_defs[] =
    else if 8xx
      mmu_psize_defs[] =
    else
      mmu_psize_defs[] =
    endif
  endif

The else leg is dead definition.

Drop that else leg and rewrite as:

  if e500
    mmu_psize_defs[] =
  endif
  if 8xx
    mmu_psize_defs[] =
  endif

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Fix build failure
---
 arch/powerpc/mm/nohash/tlb.c | 64 +++++++++---------------------------
 1 file changed, 15 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index fac59fbd475a..2c15c86c7015 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -49,7 +49,6 @@
  * other sizes not listed here.   The .ind field is only used on MMUs that have
  * indirect page table entries.
  */
-#if defined(CONFIG_PPC_E500) || defined(CONFIG_PPC_8xx)
 #ifdef CONFIG_PPC_E500
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
@@ -81,7 +80,20 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.enc	= BOOK3E_PAGESZ_1GB,
 	},
 };
-#elif defined(CONFIG_PPC_8xx)
+
+static inline int mmu_get_tsize(int psize)
+{
+	return mmu_psize_defs[psize].enc;
+}
+#else
+static inline int mmu_get_tsize(int psize)
+{
+	/* This isn't used on !Book3E for now */
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PPC_8xx
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
@@ -96,53 +108,7 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 		.shift	= 23,
 	},
 };
-#else
-struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
-	[MMU_PAGE_4K] = {
-		.shift	= 12,
-		.ind	= 20,
-		.enc	= BOOK3E_PAGESZ_4K,
-	},
-	[MMU_PAGE_16K] = {
-		.shift	= 14,
-		.enc	= BOOK3E_PAGESZ_16K,
-	},
-	[MMU_PAGE_64K] = {
-		.shift	= 16,
-		.ind	= 28,
-		.enc	= BOOK3E_PAGESZ_64K,
-	},
-	[MMU_PAGE_1M] = {
-		.shift	= 20,
-		.enc	= BOOK3E_PAGESZ_1M,
-	},
-	[MMU_PAGE_16M] = {
-		.shift	= 24,
-		.ind	= 36,
-		.enc	= BOOK3E_PAGESZ_16M,
-	},
-	[MMU_PAGE_256M] = {
-		.shift	= 28,
-		.enc	= BOOK3E_PAGESZ_256M,
-	},
-	[MMU_PAGE_1G] = {
-		.shift	= 30,
-		.enc	= BOOK3E_PAGESZ_1GB,
-	},
-};
-#endif /* CONFIG_PPC_85xx */
-
-static inline int mmu_get_tsize(int psize)
-{
-	return mmu_psize_defs[psize].enc;
-}
-#else
-static inline int mmu_get_tsize(int psize)
-{
-	/* This isn't used on !Book3E for now */
-	return 0;
-}
-#endif /* CONFIG_PPC_E500 */
+#endif
 
 /* The variables below are currently only used on 64-bit Book3E
  * though this will probably be made common with other nohash
-- 
2.37.1

