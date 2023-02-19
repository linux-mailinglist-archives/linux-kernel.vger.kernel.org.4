Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9369BE40
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjBSClv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBSCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:28 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F0612864;
        Sat, 18 Feb 2023 18:41:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PK8v719P1z4f3npw;
        Sun, 19 Feb 2023 10:41:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S12;
        Sun, 19 Feb 2023 10:41:25 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 10/17] block, bfq: fix typo in comment
Date:   Sun, 19 Feb 2023 18:43:02 +0800
Message-Id: <20230219104309.1511562-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S12
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4fuw1fGr13KF18Wr45Jrb_yoW8Xr1rpa
        srKF1fZr4xKF45XFW8Wa15Xr93Aan5Cr9rJFZFvw4jvrW7u3Z2qanIk348XF1Iqr93CF4D
        ZwnFqryDZr4xGr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IO/ -> I/O
bfq_fqq_update_budg_for_activation -> bfq_bfqq_update_budg_for_activation

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 2 +-
 block/bfq-wf2q.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0a11a381ee7d..2559343593bb 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5734,7 +5734,7 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  *
  * Putting these two facts together, this commits merges stably the
  * bfq_queues associated with these I/O flows, i.e., with the
- * processes that generate these IO/ flows, regardless of how many the
+ * processes that generate these I/O flows, regardless of how many the
  * involved processes are.
  *
  * To decide whether a set of bfq_queues is actually associated with
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 7941b6f07391..1b8d05bae116 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -931,7 +931,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 	bool backshifted = false;
 	unsigned long long min_vstart;
 
-	/* See comments on bfq_fqq_update_budg_for_activation */
+	/* See comments on bfq_bfqq_update_budg_for_activation */
 	if (non_blocking_wait_rq && bfq_gt(st->vtime, entity->finish)) {
 		backshifted = true;
 		min_vstart = entity->finish;
-- 
2.30.0

