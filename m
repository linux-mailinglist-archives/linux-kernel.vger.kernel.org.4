Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510F069BE47
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBSCmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBSCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:30 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB211EA6;
        Sat, 18 Feb 2023 18:41:28 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PK8v80V46z4f3mLw;
        Sun, 19 Feb 2023 10:41:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S15;
        Sun, 19 Feb 2023 10:41:26 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 13/17] block, bfq: remove unnecessary "wr" part of wr_or_deserves_wr
Date:   Sun, 19 Feb 2023 18:43:05 +0800
Message-Id: <20230219104309.1511562-14-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1rCFW7Xr47Aw4kKFy5twb_yoW8tr13pr
        WrK3W2qry5Jr15ZFWrta18XF1av3WfXFW7tanIqr95Xr4UJr92qa4qyw1rtF93WrZ3Kr47
        Z34DW3y8ZF1kAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Before commit 96a291c38c3299 ("block, bfq: preempt lower-weight or
lower-priority queues"), wr_or_deserves_wr is used to check if
preempt is wanted. Currently, wr_or_deserves_wr is only used in
bfq_update_bfqq_wr_on_rq_arrival to check if weight raising is
needed, so the "wr" part of wr_or_deserves_wr is not needed
anymore. Rename wr_or_deserves_wr to deserves_wr and remove
unnecessary bfqq->wr_coeff > 1 for original wr_or_deserves_wr.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index eda6669d0571..6a8ea9a451cc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1656,12 +1656,12 @@ static unsigned long bfq_smallest_from_now(void)
 static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
 					     unsigned int old_wr_coeff,
-					     bool wr_or_deserves_wr,
+					     bool deserves_wr,
 					     bool interactive,
 					     bool in_burst,
 					     bool soft_rt)
 {
-	if (old_wr_coeff == 1 && wr_or_deserves_wr) {
+	if (old_wr_coeff == 1 && deserves_wr) {
 		/* start a weight-raising period */
 		if (interactive) {
 			bfqq->service_from_wr = 0;
@@ -1873,7 +1873,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	bfq_clear_bfqq_just_created(bfqq);
 
 	if (bfqd->low_latency) {
-		bool soft_rt, in_burst,	wr_or_deserves_wr;
+		bool soft_rt, in_burst,	deserves_wr;
 		bool bfqq_non_merged_or_stably_merged =
 			bfqq->bic ||
 			RQ_BIC(rq)->bfqq_data[act_idx].stably_merged;
@@ -1916,14 +1916,13 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 			 * processes. So let also stably-merged queued enjoy weight
 			 * raising.
 			 */
-			wr_or_deserves_wr = (bfqq->wr_coeff > 1 ||
-				(bfq_bfqq_sync(bfqq) &&
+			deserves_wr = (bfq_bfqq_sync(bfqq) &&
 				bfqq_non_merged_or_stably_merged &&
-				(*interactive || soft_rt)));
+				(*interactive || soft_rt));
 
 			bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
 							 old_wr_coeff,
-							 wr_or_deserves_wr,
+							 deserves_wr,
 							 *interactive,
 							 in_burst,
 							 soft_rt);
-- 
2.30.0

