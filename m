Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39EC614E15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKAPPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiKAPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:15:07 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E3411BE93;
        Tue,  1 Nov 2022 08:12:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.14.30.251])
        by mail-app4 (Coremail) with SMTP id cS_KCgCH_k0qN2FjsHmtBw--.39315S3;
        Tue, 01 Nov 2022 23:12:02 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH 1/4] blk-mq: update comment for blk_mq_quiesce_queue_nowait()
Date:   Tue,  1 Nov 2022 23:11:34 +0800
Message-Id: <489a9322eed1f95f8770752cc715084f1fa961d3.1667314759.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667314759.git.nickyc975@zju.edu.cn>
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgCH_k0qN2FjsHmtBw--.39315S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy8Kry7Ww15Xr4xKryUZFb_yoWkCFg_Gw
        1qvr10kFs8Gr1a9F4YkFW5ZFWrKay8JF43JFWIg39xX3s2yFsxA3y29r15CrZ3WanrGa13
        Jr4UWa43Ar4SgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjfUOlksUUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgIAB1ZdtcLuXwAGsM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_quiesce_queue_nowait() is now reasonably used by scsi_host_block()
to avoid calling synchronize_rcu() for each LUN. We should not consider to
remove it.

See commit f983622ae60516d634008c7b1ff9ffff4f7bb8ae ("scsi: core: Avoid
calling synchronize_rcu() for each device in scsi_host_block()")

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-mq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 623e8a506539..7ceceea91b3b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -237,9 +237,12 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
-/*
- * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
- * mpt3sas driver such that this function can be removed.
+/**
+ * blk_mq_quiesce_queue_nowait() - start the quiesce of the queue
+ * @q: request queue.
+ *
+ * Note: synchronize_rcu() or synchronize_srcu(q->srcu) needs to
+ * be called to ensure the quiesce is done.
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-- 
2.31.1

