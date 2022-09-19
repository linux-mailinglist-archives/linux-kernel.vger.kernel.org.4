Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83F5BC343
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiISG7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiISG6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:58:32 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C4C1D0FC;
        Sun, 18 Sep 2022 23:58:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MWFp54Ck3z6SCDK;
        Mon, 19 Sep 2022 14:56:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMPEyhjBBpFBA--.10045S5;
        Mon, 19 Sep 2022 14:58:26 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2 1/3] wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
Date:   Mon, 19 Sep 2022 15:09:14 +0800
Message-Id: <20220919070916.2738443-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220919070916.2738443-1-yukuai1@huaweicloud.com>
References: <20220919070916.2738443-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMPEyhjBBpFBA--.10045S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4fArykuFW5tr1rGw17ZFb_yoW5GFWfpa
        y7Ga4akF12gF4UWFyxJr4Duw43Kw48KrWxK3y8G3yYvrya9r129a1vkFW8XF95ZFWxCFsx
        Wrn0yrZ8uF4jgaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
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

This patch shows wbt_lat_usec as zero and forbid to set it while wbt
is disabled.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reported-and-tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
---
 block/blk-sysfs.c | 9 ++++++++-
 block/blk-wbt.c   | 7 +++++++
 block/blk-wbt.h   | 5 +++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e1f009aba6fd..1955bb6a284d 100644
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
@@ -493,6 +497,9 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
 			return ret;
 	}
 
+	if (wbt_disabled(q))
+		return -EINVAL;
+
 	if (val == -1)
 		val = wbt_default_latency_nsec(q);
 	else if (val >= 0)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a9982000b667..68851c2c02d2 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -422,6 +422,13 @@ static void wbt_update_limits(struct rq_wb *rwb)
 	rwb_wake_all(rwb);
 }
 
+bool wbt_disabled(struct request_queue *q)
+{
+	struct rq_qos *rqos = wbt_rq_qos(q);
+
+	return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT;
+}
+
 u64 wbt_get_min_lat(struct request_queue *q)
 {
 	struct rq_qos *rqos = wbt_rq_qos(q);
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 7e44eccc676d..e42465ddcbb6 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -94,6 +94,7 @@ void wbt_enable_default(struct request_queue *);
 
 u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
+bool wbt_disabled(struct request_queue *);
 
 void wbt_set_write_cache(struct request_queue *, bool);
 
@@ -125,6 +126,10 @@ static inline u64 wbt_default_latency_nsec(struct request_queue *q)
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

