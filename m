Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7072463C418
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbiK2PrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiK2PrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:47:00 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 376816315A;
        Tue, 29 Nov 2022 07:46:59 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.50])
        by mail-app4 (Coremail) with SMTP id cS_KCgBnaMxfKYZjT2esCA--.15899S4;
        Tue, 29 Nov 2022 23:46:56 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH v2 2/5] elevator: replace continue with else-if in elv_iosched_show
Date:   Tue, 29 Nov 2022 23:46:35 +0800
Message-Id: <77ac19ba556efd2c8639a6396eb4203c59bc13d6.1669736350.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1669736350.git.nickyc975@zju.edu.cn>
References: <cover.1669736350.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgBnaMxfKYZjT2esCA--.15899S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtr48XryrAr18ArWrur4UJwb_yoW3AFb_Ka
        s5Xwn7J345Jr9Ikr1jvFn5tFWjvwn3Jr15Kwnrtr97ta90gFyfA3Wxua45JryDWFWUu3s8
        Cw1DZFn7CryxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4
        vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUFYFADUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgIJB1ZdtcpCQAAFs9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

else-if is more readable than continue here.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/elevator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 308bee253564..ffa750976d25 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -776,11 +776,9 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 
 	spin_lock(&elv_list_lock);
 	list_for_each_entry(e, &elv_list, list) {
-		if (e == cur) {
+		if (e == cur)
 			len += sprintf(name+len, "[%s] ", cur->elevator_name);
-			continue;
-		}
-		if (elv_support_features(q, e))
+		else if (elv_support_features(q, e))
 			len += sprintf(name+len, "%s ", e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
-- 
2.34.1

