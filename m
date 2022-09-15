Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A235B95E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiIOICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiIOICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:02:50 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAAB4DF34
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:02:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VPs0xZi_1663228961;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPs0xZi_1663228961)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 16:02:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] soc: imx: Remove unnecessary .owner
Date:   Thu, 15 Sep 2022 16:02:22 +0800
Message-Id: <20220915080222.114612-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220915080222.114612-1-jiapeng.chong@linux.alibaba.com>
References: <20220915080222.114612-1-jiapeng.chong@linux.alibaba.com>
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

Remove .owner field if calls are used which set it automatically.

./drivers/soc/imx/imx93-src.c:24:3-8: No need to set .owner here. The core will do it.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2188
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/soc/imx/imx93-src.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/imx/imx93-src.c b/drivers/soc/imx/imx93-src.c
index 4d74921cae0f..f1c2e22d5cbd 100644
--- a/drivers/soc/imx/imx93-src.c
+++ b/drivers/soc/imx/imx93-src.c
@@ -21,7 +21,6 @@ MODULE_DEVICE_TABLE(of, imx93_src_ids);
 static struct platform_driver imx93_src_driver = {
 	.driver = {
 		.name	= "imx93_src",
-		.owner	= THIS_MODULE,
 		.of_match_table = imx93_src_ids,
 	},
 	.probe = imx93_src_probe,
-- 
2.20.1.7.g153144c

