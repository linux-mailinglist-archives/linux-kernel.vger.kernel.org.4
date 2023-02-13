Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9740693B91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBMBFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMBFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:05:53 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72C129
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 17:05:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VbRudjG_1676250347;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VbRudjG_1676250347)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 09:05:48 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, herve.codina@bootlin.com, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: codecs: Remove unneeded semicolon
Date:   Mon, 13 Feb 2023 09:05:47 +0800
Message-Id: <20230213010547.105312-1-yang.lee@linux.alibaba.com>
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

./sound/soc/codecs/peb2466.c:1851:2-3: Unneeded semicolon
./sound/soc/codecs/peb2466.c:1887:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4045
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/peb2466.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 4640b1860312..5dec69be0acb 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -1848,7 +1848,7 @@ static int peb2466_chip_direction_input(struct gpio_chip *c, unsigned int offset
 	if (offset < 16) {
 		/* SOx_{0,1} */
 		return -EINVAL;
-	};
+	}
 
 	ret = peb2466_chip_gpio_offset_to_dir_regmask(offset, &xr_reg, &mask);
 	if (ret) {
@@ -1884,7 +1884,7 @@ static int peb2466_chip_direction_output(struct gpio_chip *c, unsigned int offse
 	if (offset < 16) {
 		/* SOx_{0,1} */
 		return 0;
-	};
+	}
 
 	ret = peb2466_chip_gpio_offset_to_dir_regmask(offset, &xr_reg, &mask);
 	if (ret) {
-- 
2.20.1.7.g153144c

