Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4827C74AC12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGGHjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGGHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:39:11 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2420A19B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:39:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qy4yt6fgcz4f3jMc
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:39:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXsc8XwadktcpJNQ--.23358S2;
        Fri, 07 Jul 2023 15:39:05 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: correct stale comment of function check_pte
Date:   Fri,  7 Jul 2023 23:39:53 +0800
Message-Id: <20230707153953.1380615-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXsc8XwadktcpJNQ--.23358S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DJw1UZF15JF4kuFyUZFb_yoW8AFyxp3
        Z3G3Z5XrykK3s0kw12yFZI9r45twnxXrWFyr4rCw1fAws8Gw4kWFy5JFW8Zr40qayxJ3sr
        J3y2yr43Aa48tFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2aff7a4755bed ("mm: Convert page_vma_mapped_walk to work on PFNs")
replaced page with pfns in page_vma_mapped_walk structure and updated
"@pvmw->page" to "@pvmw->pfn" in comment of function page_vma_mapped_walk.

This patch update stale "page" to "pfn" in comment of check_pte.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_vma_mapped.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 6ac795a87279..dbe2418b44e5 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -73,20 +73,22 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 }
 
 /**
- * check_pte - check if @pvmw->page is mapped at the @pvmw->pte
- * @pvmw: page_vma_mapped_walk struct, includes a pair pte and page for checking
+ * check_pte - check if [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages) is
+ * mapped at the @pvmw->pte
+ * @pvmw: page_vma_mapped_walk struct, includes a pair pte and pfn range
+ * for checking
  *
- * page_vma_mapped_walk() found a place where @pvmw->page is *potentially*
+ * page_vma_mapped_walk() found a place where pfn range is *potentially*
  * mapped. check_pte() has to validate this.
  *
  * pvmw->pte may point to empty PTE, swap PTE or PTE pointing to
  * arbitrary page.
  *
  * If PVMW_MIGRATION flag is set, returns true if @pvmw->pte contains migration
- * entry that points to @pvmw->page or any subpage in case of THP.
+ * entry that points to [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages)
  *
  * If PVMW_MIGRATION flag is not set, returns true if pvmw->pte points to
- * pvmw->page or any subpage in case of THP.
+ * [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages)
  *
  * Otherwise, return false.
  *
-- 
2.30.0

