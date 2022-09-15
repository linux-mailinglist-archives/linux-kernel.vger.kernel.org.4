Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6233A5B95E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIOICt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:02:46 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75874DF34
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:02:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VPrv8h7_1663228944;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPrv8h7_1663228944)
          by smtp.aliyun-inc.com;
          Thu, 15 Sep 2022 16:02:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/2] soc: imx: Remove unnecessary .owner
Date:   Thu, 15 Sep 2022 16:02:21 +0800
Message-Id: <20220915080222.114612-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove .owner field if calls are used which set it automatically.

./drivers/soc/imx/imx93-pd.c:154:3-8: No need to set .owner here. The core will do it.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2189
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/soc/imx/imx93-pd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
index 1f3d7039c1de..fa52a2a9e5b1 100644
--- a/drivers/soc/imx/imx93-pd.c
+++ b/drivers/soc/imx/imx93-pd.c
@@ -151,7 +151,6 @@ MODULE_DEVICE_TABLE(of, imx93_pd_ids);
 static struct platform_driver imx93_power_domain_driver = {
 	.driver = {
 		.name	= "imx93_power_domain",
-		.owner	= THIS_MODULE,
 		.of_match_table = imx93_pd_ids,
 	},
 	.probe = imx93_pd_probe,
-- 
2.20.1.7.g153144c

