Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAF72F830
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbjFNIjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbjFNIju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:39:50 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C50F1BC3;
        Wed, 14 Jun 2023 01:39:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vl5rzQc_1686731984;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vl5rzQc_1686731984)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 16:39:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     neil.armstrong@linaro.org
Cc:     jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] clk: meson: Remove unneeded semicolon
Date:   Wed, 14 Jun 2023 16:39:43 +0800
Message-Id: <20230614083943.85660-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/clk/meson/clk-pll.c:373:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5531
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 56ec2210f1ad..8fef90bf962f 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -370,7 +370,7 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 		usleep_range(10, 20);
 		meson_parm_write(clk->map, &pll->current_en, 1);
 		usleep_range(40, 50);
-	};
+	}
 
 	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
 		meson_parm_write(clk->map, &pll->l_detect, 1);
-- 
2.20.1.7.g153144c

