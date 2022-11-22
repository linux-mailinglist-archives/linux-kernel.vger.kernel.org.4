Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A402633ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiKVOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiKVOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:21:48 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9AE2490A1;
        Tue, 22 Nov 2022 06:21:46 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.50])
        by mail-app4 (Coremail) with SMTP id cS_KCgCHrN_o2nxjHR5BCA--.15646S5;
        Tue, 22 Nov 2022 22:21:42 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH 3/4] elevator: update the document of elevator_match
Date:   Tue, 22 Nov 2022 22:21:25 +0800
Message-Id: <a58424555202c07a9ccf7f60c3ad7e247da09e25.1669126766.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1669126766.git.nickyc975@zju.edu.cn>
References: <cover.1669126766.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgCHrN_o2nxjHR5BCA--.15646S5
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr18Gr1rWr4xZw1fCF13twb_yoWDZwb_G3
        yjy3Z7J34DJr1akF1IqF4Yqry7Zwn3Cry5Gr1xtFyxAayFgFnFyrZ7CryUCw1UXrW5C3W5
        Cw4Duw17Zr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij
        64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAg4CB1ZdtciuigABsa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elevator_match does not care about elevator_features any more. Remove
related descriptions from its document.

Fixes: ffb86425ee2c ("block: don't check for required features in elevator_match")
Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/elevator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 1fa45717b1d6..5287b39cd7a9 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -91,12 +91,11 @@ static inline bool elv_support_features(struct request_queue *q,
 }
 
 /**
- * elevator_match - Test an elevator name and features
+ * elevator_match - Check whether @e's name or alias matches @name
  * @e: Scheduler to test
  * @name: Elevator name to test
  *
- * Return true if the elevator @e name matches @name and if @e provides all
- * the features specified by @required_features.
+ * Return true if the elevator @e's name or alias matches @name.
  */
 static bool elevator_match(const struct elevator_type *e, const char *name)
 {
-- 
2.34.1

