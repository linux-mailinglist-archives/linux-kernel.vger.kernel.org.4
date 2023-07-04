Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B97472E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjGDNjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGDNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:39:11 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C308173C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:38:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwP5D31Slz4f3rBM
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 21:38:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDXQy7fIKRkscXqMQ--.53780S4;
        Tue, 04 Jul 2023 21:38:41 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 2/2] mm: correct stale comment of function check_pte
Date:   Wed,  5 Jul 2023 05:39:32 +0800
Message-Id: <20230704213932.1339204-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230704213932.1339204-1-shikemeng@huaweicloud.com>
References: <20230704213932.1339204-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDXQy7fIKRkscXqMQ--.53780S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DJw1UZF15JF4kuFyUZFb_yoW8Cr1Upa
        n3Cwn5XFy8K3s09w12yrZI9r45twnxXrWSyr4rCw1fAws8Gw4kWFy5JFW8Zr4jqa1xJwnr
        J3y2yr43Aa48tFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
        87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRET5lUUUUUU=
        =
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
 mm/page_vma_mapped.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 83858758e239..dd0a820a0e6c 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -54,20 +54,23 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
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
+ * page_vma_mapped_walk() found a place where @pvmw->pfn is *potentially*
  * mapped. check_pte() has to validate this.
  *
  * pvmw->pte may point to empty PTE, swap PTE or PTE pointing to
  * arbitrary page.
  *
  * If PVMW_MIGRATION flag is set, returns true if @pvmw->pte contains migration
- * entry that points to @pvmw->page or any subpage in case of THP.
+ * entry that points to @pvmw->pfn or [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages)
+ * in case of THP.
  *
  * If PVMW_MIGRATION flag is not set, returns true if pvmw->pte points to
- * pvmw->page or any subpage in case of THP.
+ * pvmw->pfn or [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages) in case of THP.
  *
  * Otherwise, return false.
  *
-- 
2.30.0

