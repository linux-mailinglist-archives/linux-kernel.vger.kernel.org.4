Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2A653EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiLVLSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbiLVLRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:17:51 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF7FDFC2;
        Thu, 22 Dec 2022 03:17:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nd789598zz4f3pFM;
        Thu, 22 Dec 2022 19:17:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgB3a+nXPKRjMew+AQ--.3596S11;
        Thu, 22 Dec 2022 19:17:48 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: [PATCH RESEND v2 09/10] block, bfq: remove unused bfq_wr_max_time in struct bfq_data
Date:   Fri, 23 Dec 2022 03:16:40 +0800
Message-Id: <20221222191641.1643117-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3a+nXPKRjMew+AQ--.3596S11
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUJw1kCr15GFyUtw4rAFb_yoW8WF15pa
        nrK347WF17Kr4FgF1DAa4rXFnxta13uF9rKa1a9w4YyFW8XF1a93ZYyw1fX3Z2vFZ3Cr4f
        Zw4Fqa4Dtw18K3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfqd->bfq_wr_max_time is set to 0 in bfq_init_queue and is never changed.
It is only used in bfq_wr_duration when bfq_wr_max_time > 0 which never
meets, so bfqd->bfq_wr_max_time is not used actually. Just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 4 ----
 block/bfq-iosched.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 195cdc6be087..91bc68fba72d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1068,9 +1068,6 @@ static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
 {
 	u64 dur;
 
-	if (bfqd->bfq_wr_max_time > 0)
-		return bfqd->bfq_wr_max_time;
-
 	dur = bfqd->rate_dur_prod;
 	do_div(dur, bfqd->peak_rate);
 
@@ -7079,7 +7076,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 */
 	bfqd->bfq_wr_coeff = 30;
 	bfqd->bfq_wr_rt_max_time = msecs_to_jiffies(300);
-	bfqd->bfq_wr_max_time = 0;
 	bfqd->bfq_wr_min_idle_time = msecs_to_jiffies(2000);
 	bfqd->bfq_wr_min_inter_arr_async = msecs_to_jiffies(500);
 	bfqd->bfq_wr_max_softrt_rate = 7000; /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 9fa89577322d..0b1a5438046a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -719,8 +719,6 @@ struct bfq_data {
 	 * is multiplied.
 	 */
 	unsigned int bfq_wr_coeff;
-	/* maximum duration of a weight-raising period (jiffies) */
-	unsigned int bfq_wr_max_time;
 
 	/* Maximum weight-raising duration for soft real-time processes */
 	unsigned int bfq_wr_rt_max_time;
-- 
2.30.0

