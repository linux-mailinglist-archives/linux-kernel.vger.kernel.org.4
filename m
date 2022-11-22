Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA8633ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKVOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiKVOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:21:48 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48A246829D;
        Tue, 22 Nov 2022 06:21:46 -0800 (PST)
Received: from localhost.localdomain (unknown [10.14.30.50])
        by mail-app4 (Coremail) with SMTP id cS_KCgCHrN_o2nxjHR5BCA--.15646S6;
        Tue, 22 Nov 2022 22:21:43 +0800 (CST)
From:   Jinlong Chen <nickyc975@zju.edu.cn>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nickyc975@zju.edu.cn
Subject: [PATCH 4/4] elevator: remove an outdated comment in elevator_change
Date:   Tue, 22 Nov 2022 22:21:26 +0800
Message-Id: <cbf47824fc726440371e74c867bf635ae1b671a3.1669126766.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1669126766.git.nickyc975@zju.edu.cn>
References: <cover.1669126766.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgCHrN_o2nxjHR5BCA--.15646S6
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY37CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
        JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
        IYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgECB1ZdtciuiwAAsV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mq is no longer a special case.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/elevator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5287b39cd7a9..599413620558 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -721,9 +721,6 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
 	if (!blk_queue_registered(q))
 		return -ENOENT;
 
-	/*
-	 * Special case for mq, turn off scheduling
-	 */
 	if (!strncmp(elevator_name, "none", 4)) {
 		if (q->elevator)
 			elevator_disable(q);
-- 
2.34.1

