Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8FF611333
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiJ1NmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiJ1Nlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:41:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AACC159D7D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:40:49 -0700 (PDT)
X-QQ-mid: bizesmtp62t1666964444tg65c2f4
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:40:42 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: +e7paLVVZUnbgx/ACZMyiBePvRE/WiYvFsnGVOPH7K6Hz+evUztgSSUOpqx49
        +5dTHojD52dA6cQY8Y16agXXyhEO9UB68MBB1X1tmpocImzp9r/PXlVbnRiTRWKL34/TVzW
        od9I09GkYYA4PgG/moVZDEKSikIejP0+t4EiECo1TRt5SMIT4g4uIzJwAWwIE8bno7X2mmb
        NaA7Y0tg9PT1YXRPFExIdNhQZ3b2ivA7pzoY0NXw7X6fGYVaCQ7dvMo/IncbNvdxSYQWjX0
        Pp04OqLYwxJrpYCQheoXu/S5CmjpvCPkuUV7D5yuD3H08J8ACuMOP/cOxfqvpIQh7l6Xy7Z
        Lbjl/XT4Ed4Mb6rbEQY/18ens+/2IcUQV0JBnoJ1vswcBaI7RXbIqnlLIcGAcThIRaSzujk
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mtd: inftlcore: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:40:36 +0800
Message-Id: <20221028134036.63000-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'it'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mtd/inftlcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 58ca1c21ebe6..9739387cff8c 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -356,7 +356,7 @@ static u16 INFTL_foldchain(struct INFTLrecord *inftl, unsigned thisVUC, unsigned
 	 * Newest unit in chain now contains data from _all_ older units.
 	 * So go through and erase each unit in chain, oldest first. (This
 	 * is important, by doing oldest first if we crash/reboot then it
-	 * it is relatively simple to clean up the mess).
+	 * is relatively simple to clean up the mess).
 	 */
 	pr_debug("INFTL: want to erase virtual chain %d\n", thisVUC);
 
-- 
2.36.1

