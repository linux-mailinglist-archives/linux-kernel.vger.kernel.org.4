Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC2620878
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiKHEwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiKHEwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:52:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3887F1BE9F;
        Mon,  7 Nov 2022 20:52:31 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5wgn4djDzRp44;
        Tue,  8 Nov 2022 12:52:21 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:28 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 02/10] block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
Date:   Tue, 8 Nov 2022 12:52:16 +0800
Message-ID: <20221108045224.19092-3-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221108045224.19092-1-shikemeng@huawei.com>
References: <20221108045224.19092-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter reason is never used, just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b0bee8ab65e6..fc71181a7e5d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4132,8 +4132,7 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
  * function to evaluate the I/O speed of a process.
  */
 static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				 bool compensate, enum bfqq_expiration reason,
-				 unsigned long *delta_ms)
+				 bool compensate, unsigned long *delta_ms)
 {
 	ktime_t delta_ktime;
 	u32 delta_usecs;
@@ -4329,7 +4328,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	/*
 	 * Check whether the process is slow (see bfq_bfqq_is_slow).
 	 */
-	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, reason, &delta);
+	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, &delta);
 
 	/*
 	 * As above explained, charge slow (typically seeky) and
-- 
2.30.0

