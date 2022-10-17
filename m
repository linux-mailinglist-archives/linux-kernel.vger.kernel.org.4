Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE71600863
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJQILQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJQILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:11:13 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4854A839;
        Mon, 17 Oct 2022 01:11:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VSKm2em_1665994261;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VSKm2em_1665994261)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 16:11:07 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] leds-pca955x: Remove the unused function pca95xx_num_led_regs()
Date:   Mon, 17 Oct 2022 16:10:53 +0800
Message-Id: <20221017081053.52388-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function pca95xx_num_led_regs() is defined in the leds-pca955x.c
file, but not called elsewhere, so delete this unused function.

drivers/leds/leds-pca955x.c:149:19: warning: unused function 'pca95xx_num_led_regs'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2411
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/leds/leds-pca955x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 81aaf21212d7..33ec4543fb4f 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -145,12 +145,6 @@ static inline int pca95xx_num_input_regs(int bits)
 	return (bits + 7) / 8;
 }
 
-/* 4 bits per LED selector register */
-static inline int pca95xx_num_led_regs(int bits)
-{
-	return (bits + 3)  / 4;
-}
-
 /*
  * Return an LED selector register value based on an existing one, with
  * the appropriate 2-bit state value set for the given LED number (0-3).
-- 
2.20.1.7.g153144c

