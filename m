Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD086BE129
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCQGVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjCQGVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:21:01 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A4AF6AF;
        Thu, 16 Mar 2023 23:20:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ve1mUQ2_1679034047;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ve1mUQ2_1679034047)
          by smtp.aliyun-inc.com;
          Fri, 17 Mar 2023 14:20:55 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] clk: qcom: Remove the unused variables
Date:   Fri, 17 Mar 2023 14:20:45 +0800
Message-Id: <20230317062045.130638-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable gpucc_parent_map_2 and gpucc_parent_data_2 is not effectively
used, so delete it.

drivers/clk/qcom/gpucc-sm6375.c:145:37: warning: unused variable 'gpucc_parent_data_2'.
drivers/clk/qcom/gpucc-sm6375.c:139:32: warning: unused variable 'gpucc_parent_map_2'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4555
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/clk/qcom/gpucc-sm6375.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
index eb9ffa956950..d8f4c4b59f1b 100644
--- a/drivers/clk/qcom/gpucc-sm6375.c
+++ b/drivers/clk/qcom/gpucc-sm6375.c
@@ -136,18 +136,6 @@ static const struct clk_parent_data gpucc_parent_data_1[] = {
 	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
 };
 
-static const struct parent_map gpucc_parent_map_2[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_GCC_GPU_GPLL0_CLK_SRC, 5 },
-	{ P_GCC_GPU_GPLL0_DIV_CLK_SRC, 6 },
-};
-
-static const struct clk_parent_data gpucc_parent_data_2[] = {
-	{ .index = P_BI_TCXO },
-	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
-	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
-};
-
 static const struct freq_tbl ftbl_gpucc_gmu_clk_src[] = {
 	F(200000000, P_GCC_GPU_GPLL0_DIV_CLK_SRC, 1.5, 0, 0),
 	{ }
-- 
2.20.1.7.g153144c

