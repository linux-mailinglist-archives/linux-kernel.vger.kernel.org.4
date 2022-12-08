Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6294647544
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLHSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLHSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:03:27 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD845BD60
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:03:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2337108pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sO5CoFHWHd3hJkT66P6565Tno5APV7gOVtSSvr1Kmak=;
        b=OpJs82IF483zMRR10B9ZK8uXKr26ww50hoZUuCpAvcj54ywnyFbiRuv6Hmy84v5RFq
         LvLarleVe0COhyAsoDAHvPMzpgopqUQQKO2ZbnnACbczT6d8YP0h0Wp/uJBcnmLwKfYn
         RnVLhdnDZPZIKpJVOKRkH69LIOnMGPC2BGyImnquIEmGGpbuHsOgGyJsgy2MSMcHx1rf
         Vq87c4y6s5XMnWQnnDuT5+NYeWEnBW/e5m5cbZwB04aLDpJV98fF+pn7N5Sdj3x+dsLn
         XMzHsVtrUQslsJQolDztnRuuDqwC7u5gtWQVj7HhF/cd/6Lh2plHxGOrsnFmAuNWKFGZ
         +yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sO5CoFHWHd3hJkT66P6565Tno5APV7gOVtSSvr1Kmak=;
        b=NmKAOksxwG4aXpwsTjVn0V9cZpCfQnIguaXLA+Fc+ASg+dpkg0CeRnswy+86RYds2G
         1zoLvhmm3cZpEDPehFemvSe5o6x7+6LamVrSjqiOdG03cmFjc5bW0tLbULnJb/6CXZLb
         EwIbgPjjejac9vs3XIFm/nPXUx4McgdcHrKzLZNiYoJjgUSvvpq3MK0QAVn3IbYBzRdl
         +LzsWtRLRhUE4IPnkH4qIP7ZVz1Cszd4zUiHZ8P92jkLVc29JS0qJRaLOd3zXfia7bh0
         EQm1MnyDakHuhn5MeXSHzTO31+QQOGr2KSB+6sbWT8p8ysFzf/f9fhH+PyMpcHGLh0lH
         59Yw==
X-Gm-Message-State: ANoB5pkYNSOHhnSnlik8xV+RpD+mczLh7EtAX74weQ4pMZXlpdvJn9T7
        ryozqijGkTZi86juV9RF1CI=
X-Google-Smtp-Source: AA0mqf4wqo11j3YseWJivRlvVsI70evGtgCftTqnGdlt4+R5iI2+u8R1yWbvNTkV85f+uZLnMttwbg==
X-Received: by 2002:a17:90a:d347:b0:219:9676:fef5 with SMTP id i7-20020a17090ad34700b002199676fef5mr2840489pjx.12.1670522606635;
        Thu, 08 Dec 2022 10:03:26 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id x23-20020a63db57000000b004785e505bcdsm13377909pgi.51.2022.12.08.10.03.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Dec 2022 10:03:26 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 3/5] swap: fold swap_ra_clamp_pfn into swap_ra_info
Date:   Fri,  9 Dec 2022 02:02:07 +0800
Message-Id: <20221208180209.50845-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221208180209.50845-1-ryncsn@gmail.com>
References: <20221208180209.50845-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

This make the code cleaner. This helper is made of only two line of
self explanational code and not reused anywhere else.

And this actually make the compiled object smaller by a bit:

          text    data     bss     dec     hex filename
Before:   9502     976      12   10490    28fa mm/swap_state.o
After:    9470     976      12   10458    28da mm/swap_state.o

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 60136bda78e3..19089417abd1 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -696,28 +696,15 @@ void exit_swap_address_space(unsigned int type)
 	swapper_spaces[type] = NULL;
 }
 
-static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
-				     unsigned long faddr,
-				     unsigned long lpfn,
-				     unsigned long rpfn,
-				     unsigned long *start,
-				     unsigned long *end)
-{
-	*start = max3(lpfn, PFN_DOWN(vma->vm_start),
-		      PFN_DOWN(faddr & PMD_MASK));
-	*end = min3(rpfn, PFN_DOWN(vma->vm_end),
-		    PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
-}
-
 static void swap_ra_info(struct vm_fault *vmf,
-			struct vma_swap_readahead *ra_info)
+			 struct vma_swap_readahead *ra_info)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long ra_val;
-	unsigned long faddr, pfn, fpfn;
+	unsigned long faddr, pfn, fpfn, lpfn, rpfn;
 	unsigned long start, end;
 	pte_t *pte, *orig_pte;
-	unsigned int max_win, hits, prev_win, win, left;
+	unsigned int max_win, hits, prev_win, win;
 #ifndef CONFIG_64BIT
 	pte_t *tpte;
 #endif
@@ -745,16 +732,23 @@ static void swap_ra_info(struct vm_fault *vmf,
 
 	/* Copy the PTEs because the page table may be unmapped */
 	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
-	if (fpfn == pfn + 1)
-		swap_ra_clamp_pfn(vma, faddr, fpfn, fpfn + win, &start, &end);
-	else if (pfn == fpfn + 1)
-		swap_ra_clamp_pfn(vma, faddr, fpfn - win + 1, fpfn + 1,
-				  &start, &end);
-	else {
-		left = (win - 1) / 2;
-		swap_ra_clamp_pfn(vma, faddr, fpfn - left, fpfn + win - left,
-				  &start, &end);
+	if (fpfn == pfn + 1) {
+		lpfn = fpfn;
+		rpfn = fpfn + win;
+	} else if (pfn == fpfn + 1) {
+		lpfn = fpfn - win + 1;
+		rpfn = fpfn + 1;
+	} else {
+		unsigned int left = (win - 1) / 2;
+
+		lpfn = fpfn - left;
+		rpfn = fpfn + win - left;
 	}
+	start = max3(lpfn, PFN_DOWN(vma->vm_start),
+		     PFN_DOWN(faddr & PMD_MASK));
+	end = min3(rpfn, PFN_DOWN(vma->vm_end),
+		   PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
+
 	ra_info->nr_pte = end - start;
 	ra_info->offset = fpfn - start;
 	pte -= ra_info->offset;
-- 
2.35.2

