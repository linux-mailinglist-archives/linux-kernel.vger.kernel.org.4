Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9826653EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiLVLRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLVLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:17:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD621F611;
        Thu, 22 Dec 2022 03:17:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nd7871nM9z4f3p5M;
        Thu, 22 Dec 2022 19:17:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgB3a+nXPKRjMew+AQ--.3596S4;
        Thu, 22 Dec 2022 19:17:46 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jack@suse.cz, hch@lst.de, damien.lemoal@wdc.com
Subject: [PATCH RESEND v2 02/10] block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
Date:   Fri, 23 Dec 2022 03:16:33 +0800
Message-Id: <20221222191641.1643117-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
References: <20221222191641.1643117-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3a+nXPKRjMew+AQ--.3596S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4UJry8XrykGFW8KrW5GFg_yoWDKwcEq3
        WxKws7AFn5JryrCFyak395X34j9FWfJ3Wq9F90grZ8uF15Aan5Z397trW5CFs3WFsF9a4a
        vrnYv3yUJF409jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
        F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
        0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_
        Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnwa9DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter reason is never used, just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1220c41fc767..5a6d9e8c329d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4066,8 +4066,7 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
  * function to evaluate the I/O speed of a process.
  */
 static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				 bool compensate, enum bfqq_expiration reason,
-				 unsigned long *delta_ms)
+				 bool compensate, unsigned long *delta_ms)
 {
 	ktime_t delta_ktime;
 	u32 delta_usecs;
@@ -4263,7 +4262,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	/*
 	 * Check whether the process is slow (see bfq_bfqq_is_slow).
 	 */
-	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, reason, &delta);
+	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, &delta);
 
 	/*
 	 * As above explained, charge slow (typically seeky) and
-- 
2.30.0

