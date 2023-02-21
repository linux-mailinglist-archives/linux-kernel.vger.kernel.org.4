Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFAC69E1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBUOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjBUOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:07:06 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0BA270
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:06:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PLgpk0ZN2z9xFrF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:57:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.218.48])
        by APP2 (Coremail) with SMTP id GxC2BwAn913fz_Rj5Fo8AQ--.7877S2;
        Tue, 21 Feb 2023 15:06:29 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     patchwork@huawei.com, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     roberto.sassu@huawei.com
Subject: [PATCH] swiotlb: remove unnecessary function swiotlb_max_segment()
Date:   Tue, 21 Feb 2023 15:06:09 +0100
Message-Id: <20230221140609.386-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAn913fz_Rj5Fo8AQ--.7877S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1kZr1fAF4UXw4xXrWfGrg_yoW8uFyDpr
        yrCF4jgFWUtFykCFWDCw1kA3W3Kw1kG3y7ZFy3Wr95Jr47J3WfXrWDKrWFyr1FqrW09F47
        JFy3ZryFkw42q3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07je9a9UUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

It is difficult to imagine how this function should be used by
drivers. The last in-tree user was removed by commit
d3f6bacfca86 ("drm/i915: stop abusing swiotlb_max_segment"), and
even this user had been abusing it to achieve a different goal.

Let's remove this function now, as already suggested by Chris
Hellwig about a year ago in commit a2daa27c0c61 ("swiotlb:
simplify swiotlb_max_segment").

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h | 5 -----
 kernel/dma/swiotlb.c    | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 35bc4e281c21..bcef10e20ea4 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -121,7 +121,6 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 
 void swiotlb_init(bool addressing_limited, unsigned int flags);
 void __init swiotlb_exit(void);
-unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
@@ -140,10 +139,6 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 static inline void swiotlb_exit(void)
 {
 }
-static inline unsigned int swiotlb_max_segment(void)
-{
-	return 0;
-}
 static inline size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	return SIZE_MAX;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a34c38bbe28f..f35d934f6e58 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -156,14 +156,6 @@ setup_io_tlb_npages(char *str)
 }
 early_param("swiotlb", setup_io_tlb_npages);
 
-unsigned int swiotlb_max_segment(void)
-{
-	if (!io_tlb_default_mem.nslabs)
-		return 0;
-	return rounddown(io_tlb_default_mem.nslabs << IO_TLB_SHIFT, PAGE_SIZE);
-}
-EXPORT_SYMBOL_GPL(swiotlb_max_segment);
-
 unsigned long swiotlb_size_or_default(void)
 {
 	return default_nslabs << IO_TLB_SHIFT;
-- 
2.25.1

