Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B374AD78
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjGGJAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGGJAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:00:40 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA611B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 02:00:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vmo-124_1688720435;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vmo-124_1688720435)
          by smtp.aliyun-inc.com;
          Fri, 07 Jul 2023 17:00:36 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] mm: Fix some kernel-doc comments
Date:   Fri,  7 Jul 2023 17:00:34 +0800
Message-Id: <20230707090034.125511-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of @mm_wr_locked and @mm.
to silence the warnings:

mm/memory.c:1716: warning: Function parameter or member 'mm_wr_locked' not described in 'unmap_vmas'
mm/memory.c:5110: warning: Function parameter or member 'mm' not described in 'mm_account_fault'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index db42a3e939d5..ceff67b5a0e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1698,6 +1698,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
  * @vma: the starting vma
  * @start_addr: virtual address at which to start unmapping
  * @end_addr: virtual address at which to end unmapping
+ * @mm_wr_locked: lock flag
  *
  * Unmap all pages in the vma list.
  *
@@ -5091,7 +5092,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 
 /**
  * mm_account_fault - Do page fault accounting
- *
+ * @mm: mm from which memcg should be extracted. It can be NULL.
  * @regs: the pt_regs struct pointer.  When set to NULL, will skip accounting
  *        of perf event counters, but we'll still do the per-task accounting to
  *        the task who triggered this page fault.
-- 
2.20.1.7.g153144c

