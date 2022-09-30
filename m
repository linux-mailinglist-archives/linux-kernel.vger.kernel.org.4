Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEB25F0314
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 04:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiI3C50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 22:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiI3C5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 22:57:10 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B901104627;
        Thu, 29 Sep 2022 19:57:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MdvwP2MSyz6SCKp;
        Fri, 30 Sep 2022 10:55:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgAnenP_WjZjTFJvBg--.12213S8;
        Fri, 30 Sep 2022 10:57:06 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, hch@infradead.org, ebiggers@kernel.org,
        paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v4 4/6] blk-wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
Date:   Fri, 30 Sep 2022 11:19:04 +0800
Message-Id: <20220930031906.4164306-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenP_WjZjTFJvBg--.12213S8
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxZw1ruw4fWFWkGryxuFg_yoW5Jr4xpa
        y7GFyakF42gF48XFyxJF4DW3yakw10kFW7GrWxG3yYyF1Y9r12va1vkFW8XF95ZFWxCFsx
        Xrn0yrZ8Cr4jg3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkU
        UUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, if wbt is initialized and then disabled by
wbt_disable_default(), sysfs will still show valid wbt_lat_usec, which
will confuse users that wbt is still enabled.

This patch shows wbt_lat_usec as zero if it's disabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reported-and-tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
 block/blk-sysfs.c | 6 +++++-
 block/blk-wbt.c   | 8 ++++++++
 block/blk-wbt.h   | 5 +++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e71b3b43927c..5a6950b4ff69 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -467,10 +467,14 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
 
 static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
 {
+	u64 lat;
+
 	if (!wbt_rq_qos(q))
 		return -EINVAL;
 
-	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
+	lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
+
+	return sprintf(page, "%llu\n", lat);
 }
 
 static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 9cac54569ff1..1852ef223c68 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -422,6 +422,14 @@ static void wbt_update_limits(struct rq_wb *rwb)
 	rwb_wake_all(rwb);
 }
 
+bool wbt_disabled(struct request_queue *q)
+{
+	struct rq_qos *rqos = wbt_rq_qos(q);
+
+	return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT ||
+	       RQWB(rqos)->enable_state == WBT_STATE_OFF_MANUAL;
+}
+
 u64 wbt_get_min_lat(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 7fe98638fff5..e3ea6e7e2900 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -96,6 +96,7 @@ void wbt_enable_default(struct request_queue *);
 
 u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
+bool wbt_disabled(struct request_queue *);
 
 void wbt_set_write_cache(struct request_queue *, bool);
 
@@ -127,6 +128,10 @@ static inline u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	return 0;
 }
+static inline bool wbt_disabled(struct request_queue *q)
+{
+	return true;
+}
 
 #endif /* CONFIG_BLK_WBT */
 
-- 
2.31.1

