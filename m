Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22361133C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiJ1NnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiJ1Nmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:42:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24C130D71;
        Fri, 28 Oct 2022 06:42:18 -0700 (PDT)
X-QQ-mid: bizesmtp79t1666964523t4hfihhr
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:42:02 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: hEgsg0a1R29entsb7H0r/VDA8PcvuIJllYztK3wMsF2TUFT2YFz9FY1aa2M+7
        /5uef3/SNmZQL53GGGYGzfn5sZ79oJ6ooHD2F0gn13xFVf8aT7qDRy4cW0fLbMKErqd/RT9
        IcJJ4MD6ul8y59fWDdF9DHZAmjioqNy5YRGMc5dkn/E23TABHKew855bGmCgsMLsTFvgK1C
        Iv3XaAZ2XgWaM+hXwWuf0H73ysx9U+x0hOYiuh4lMZLs0eLsWu+TJaMOF9siP4ha3kUvHcv
        +GJ26b+Q2pJrXWl82GOAMssNDhs5J754WPg4PGD96YFdoMlWQbLCa0XL9ZZSFw2eB3RjWO+
        wRiZnW5sEHylcnpn6uXdGrpfPvl+As0YN97dJqE/9ULqjildYhg9ZkOr1bjhw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] clk: meson: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:41:56 +0800
Message-Id: <20221028134156.64042-1-yuanjilin@cdjrlc.com>
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

Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/clk/meson/clk-regmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index e365312da54e..e08a9fa0cc36 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -18,7 +18,7 @@
  * @data:	data specific to the clock type
  *
  * Clock which is controlled by regmap backed registers. The actual type of
- * of the clock is controlled by the clock_ops and data.
+ * the clock is controlled by the clock_ops and data.
  */
 struct clk_regmap {
 	struct clk_hw	hw;
-- 
2.36.1

