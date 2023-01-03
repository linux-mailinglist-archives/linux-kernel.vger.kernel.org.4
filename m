Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4C65B91B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbjACBzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbjACByZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:54:25 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30F2766C;
        Mon,  2 Jan 2023 17:54:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NmG4W650pz4f3v57;
        Tue,  3 Jan 2023 09:54:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBHr7LJirNj9wMDBA--.19481S10;
        Tue, 03 Jan 2023 09:54:22 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.com, paolo.valente@linaro.org, axboe@kernel.dk
Cc:     hch@lst.de, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] block, bfq: remove unused bfq_wr_max_time in struct bfq_data
Date:   Tue,  3 Jan 2023 17:53:03 +0800
Message-Id: <20230103095303.2223546-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
References: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHr7LJirNj9wMDBA--.19481S10
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyUJw1kCr15GFy8JrW8Zwb_yoW8WFWxpa
        1DK347WF17Jr4FgF1DAa4rXF15ta1xuF9rKa1a9w4YyFWUXF1a93ZYyw1fX3WIvFZ3Cr4f
        Zw1Yqa4Dtw18KaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 4 ----
 block/bfq-iosched.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a11be312ac77..206b41bc864e 100644
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
 
@@ -7080,7 +7077,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
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

