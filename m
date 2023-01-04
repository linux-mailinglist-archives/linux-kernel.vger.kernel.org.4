Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3A65CD0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjADGZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:24:25 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019917419;
        Tue,  3 Jan 2023 22:24:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nn01b119Cz4f3nGH;
        Wed,  4 Jan 2023 14:24:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGOG7Vju3lKBA--.23788S15;
        Wed, 04 Jan 2023 14:24:21 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v2 13/13] blk-mq: correct stale comment of .get_budget
Date:   Wed,  4 Jan 2023 22:22:59 +0800
Message-Id: <20230104142259.2673013-14-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGOG7Vju3lKBA--.23788S15
X-Coremail-Antispam: 1UD129KBjvJXoW7CryrWr47uF1kXw43Jr45trb_yoW8Ar1xpr
        ZxKrWYkr4jqryDXFyfAa17JanakanFqF9xJr1ftw1Fy3W3CrZ7Xr48K345Ca18AFZaka9x
        ZrsF9r90qws3u37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 88022d7201e96 ("blk-mq: don't handle failure in .get_budget")
remove BLK_STS_RESOURCE return value and we only check if we can get
the budget from .get_budget() now.
Correct stale comment that ".get_budget() returns BLK_STS_NO_RESOURCE"
to ".get_budget() fails to get the budget".

Fixes: 88022d7201e9 ("blk-mq: don't handle failure in .get_budget")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ae40cdb7a383..06b312c69114 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -81,7 +81,7 @@ static bool blk_mq_dispatch_hctx_list(struct list_head *rq_list)
 /*
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
- * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ * restart queue if .get_budget() fails to get the budget.
  *
  * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
  * be run again.  This is necessary to avoid starving flushes.
@@ -209,7 +209,7 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
 /*
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
- * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ * restart queue if .get_budget() fails to get the budget.
  *
  * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
  * be run again.  This is necessary to avoid starving flushes.
-- 
2.30.0

