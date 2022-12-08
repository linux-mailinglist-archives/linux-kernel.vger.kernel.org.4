Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF7647145
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiLHODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiLHOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:02:48 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356065F9;
        Thu,  8 Dec 2022 06:02:43 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NSbSp3y6Pz4f3tpt;
        Thu,  8 Dec 2022 22:02:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgBXAbB77pFjF4YRBw--.33249S4;
        Thu, 08 Dec 2022 22:02:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com
Subject: [PATCH 2/4] sbitmap: remove redundant check in __sbitmap_queue_get_batch
Date:   Fri,  9 Dec 2022 06:01:45 +0800
Message-Id: <20221208220147.3315388-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221208220147.3315388-1-shikemeng@huaweicloud.com>
References: <20221208220147.3315388-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXAbB77pFjF4YRBw--.33249S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF47Aw45urWUAr4fGry3Arb_yoW8Xr1xpF
        Wjg34rWr4IqFy2v34DA3WUA3W8t398Cryayrs2g34akw1Dtrn3XrWIkFW3u3W3XF95A3W3
        Za1fZasF9rWUXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsNB_UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fbb564a557809 ("lib/sbitmap: Fix invalid loop in
__sbitmap_queue_get_batch()") mentioned that "Checking free bits when
setting the target bits. Otherwise, it may reuse the busying bits."
This commit add check to make sure all masked bits in word before
cmpxchg is zero. Then the existing check after cmpxchg to check any
zero bit is existing in masked bits in word is redundant.

Actually, old value of word before cmpxchg is stored in val and we
will filter out busy bits in val by "(get_mask & ~val)" after cmpxchg.
So we will not reuse busy bits methioned in commit fbb564a557809
("lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()"). Revert
new-added check to remove redundant check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 lib/sbitmap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index cb5e03a2d65b..11e75f4040fb 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -518,11 +518,9 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 
 			get_mask = ((1UL << nr_tags) - 1) << nr;
 			val = READ_ONCE(map->word);
-			do {
-				if ((val & ~get_mask) != val)
-					goto next;
-			} while (!atomic_long_try_cmpxchg(ptr, &val,
-							  get_mask | val));
+			while (!atomic_long_try_cmpxchg(ptr, &val,
+							  get_mask | val))
+				;
 			get_mask = (get_mask & ~val) >> nr;
 			if (get_mask) {
 				*offset = nr + (index << sb->shift);
-- 
2.30.0

