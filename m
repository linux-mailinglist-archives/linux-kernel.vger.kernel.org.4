Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7018727946
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjFHH4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFHH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:56:00 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D2B19BB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:55:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VkdWBH-_1686210941;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VkdWBH-_1686210941)
          by smtp.aliyun-inc.com;
          Thu, 08 Jun 2023 15:55:53 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: max98088: clean up some inconsistent indenting
Date:   Thu,  8 Jun 2023 15:55:40 +0800
Message-Id: <20230608075540.61575-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

sound/soc/codecs/max98088.c:316 m98088_eq_band() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5461
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/max98088.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index fb136e2b849b..8b56ee550c09 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -310,24 +310,24 @@ static const struct regmap_config max98088_regmap = {
 static void m98088_eq_band(struct snd_soc_component *component, unsigned int dai,
                    unsigned int band, u16 *coefs)
 {
-       unsigned int eq_reg;
-       unsigned int i;
+	unsigned int eq_reg;
+	unsigned int i;
 
 	if (WARN_ON(band > 4) ||
 	    WARN_ON(dai > 1))
 		return;
 
-       /* Load the base register address */
-       eq_reg = dai ? M98088_REG_84_DAI2_EQ_BASE : M98088_REG_52_DAI1_EQ_BASE;
+	/* Load the base register address */
+	eq_reg = dai ? M98088_REG_84_DAI2_EQ_BASE : M98088_REG_52_DAI1_EQ_BASE;
 
-       /* Add the band address offset, note adjustment for word address */
-       eq_reg += band * (M98088_COEFS_PER_BAND << 1);
+	/* Add the band address offset, note adjustment for word address */
+	eq_reg += band * (M98088_COEFS_PER_BAND << 1);
 
-       /* Step through the registers and coefs */
-       for (i = 0; i < M98088_COEFS_PER_BAND; i++) {
-               snd_soc_component_write(component, eq_reg++, M98088_BYTE1(coefs[i]));
-               snd_soc_component_write(component, eq_reg++, M98088_BYTE0(coefs[i]));
-       }
+	/* Step through the registers and coefs */
+	for (i = 0; i < M98088_COEFS_PER_BAND; i++) {
+		snd_soc_component_write(component, eq_reg++, M98088_BYTE1(coefs[i]));
+		snd_soc_component_write(component, eq_reg++, M98088_BYTE0(coefs[i]));
+	}
 }
 
 /*
-- 
2.20.1.7.g153144c

