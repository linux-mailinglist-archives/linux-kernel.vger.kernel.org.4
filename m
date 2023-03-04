Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2E6AA8AB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCDIRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCDIRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:17:43 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F30F4B805;
        Sat,  4 Mar 2023 00:17:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PTHl53Q5Wz4f3jJH;
        Sat,  4 Mar 2023 16:17:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyGg_gJkXTNDEQ--.38480S7;
        Sat, 04 Mar 2023 16:17:39 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 3/3] blk-wbt: remove deadcode
Date:   Sat,  4 Mar 2023 16:40:53 +0800
Message-Id: <20230304084053.2822411-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230304084053.2822411-1-yukuai1@huaweicloud.com>
References: <20230304084053.2822411-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyGg_gJkXTNDEQ--.38480S7
X-Coremail-Antispam: 1UD129KBjvJXoWruw1DAF4rtFW5WFW5WF18uFg_yoW8Jr1rpw
        4ak3sIkFWqqF1vva1Dtr48X3yay3ykGryxXFZ8CrZxZr17Cw1a9a4kCr10ka4FvrWfuF42
        gr129ry5CF1rJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

wbt can never be enabled or disabled while io is still inflight.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 2d5a2f4ee8bc..247f27a15062 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -200,15 +200,6 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct rq_wait *rqw,
 
 	inflight = atomic_dec_return(&rqw->inflight);
 
-	/*
-	 * wbt got disabled with IO in flight. Wake up any potential
-	 * waiters, we don't have to do more than that.
-	 */
-	if (unlikely(!rwb_enabled(rwb))) {
-		rwb_wake_all(rwb);
-		return;
-	}
-
 	/*
 	 * For discards, our limit is always the background. For writes, if
 	 * the device does write back caching, drop further down before we
@@ -544,13 +535,6 @@ static inline unsigned int get_limit(struct rq_wb *rwb, blk_opf_t opf)
 {
 	unsigned int limit;
 
-	/*
-	 * If we got disabled, just return UINT_MAX. This ensures that
-	 * we'll properly inc a new IO, and dec+wakeup at the end.
-	 */
-	if (!rwb_enabled(rwb))
-		return UINT_MAX;
-
 	if ((opf & REQ_OP_MASK) == REQ_OP_DISCARD)
 		return rwb->wb_background;
 
-- 
2.31.1

