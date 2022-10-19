Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A76604DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiJSQ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJSQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:58:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B231D20C8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:57:53 -0700 (PDT)
X-QQ-mid: bizesmtp78t1666184348tkal0dp5
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 20:59:07 +0800 (CST)
X-QQ-SSF: 01000000008000F0I000B00A0000000
X-QQ-FEAT: bYR630AeiPgeSG88wd+uuK4XXAGFBYeXJOCjpMt6lGpBpMMIWT04kA0B1I9Q2
        xvmo5eIdJhFHBN26U5C+Z4IM0z3qREVkqGmci8Zuwx3VYD0GOw7dJ7LoBpB+kNl6vdTJMkW
        v3E5YSoV/i2ROqMKXE+AdAtpdPvCAUq60D+qvvLU6UrVHu/KFMd73TXT+iGmBPBT+/3ivQu
        pMj2A3jw/9+EIjGDW0YTT6Nm7NIs+763jvtFTj3DP+/gzmA8JRUhX1kW5Z6Grl5zeT0n26Z
        7DAI+TjZJOzl0BjOS6ZpQVtJ8UTPZwYJ15WI8ZVxH3QPa035Dc1lknwOJn/Y+lPRPi0FSZl
        nqruNkRZmq326pp8XrAS3Q9jFoBhnIuMhy61+UtM3AOWXjYiE7yDssQLCpmWA/TXv4FVLfb
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] agp/via: fix repeated words in comments
Date:   Wed, 19 Oct 2022 20:59:01 +0800
Message-Id: <20221019125901.56718-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'as'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/char/agp/via-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index b2f484f527fb..2a4befd1c438 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -398,7 +398,7 @@ static struct agp_device_ids via_agp_device_ids[] =
 	 * by 3D driver which wasn't available for the VT3336 and VT3364
 	 * generation until now.  Unfortunately, by testing, VT3364 works
 	 * but VT3336 doesn't. - explanation from via, just leave this as
-	 * as a placeholder to avoid future patches adding it back in.
+	 * a placeholder to avoid future patches adding it back in.
 	 */
 #if 0
 	{
-- 
2.36.1

