Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE15F37A9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJCV0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJCVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:25:40 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D80B13E12;
        Mon,  3 Oct 2022 14:14:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a00:f41:18f3:7ee6:a401:45d0:c41f:c16e])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E59AE3F218;
        Mon,  3 Oct 2022 23:14:44 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sm6375: Remove unused variables
Date:   Mon,  3 Oct 2022 23:14:38 +0200
Message-Id: <20221003211438.25691-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc_parent_data_15 and gcc_parent_map_15 are not used in this driver.
Remove them.

No Fixes tag, as the commit introducing it is still in -next.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/clk/qcom/gcc-sm6375.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 6f39a85da85b..a3188c462a8b 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -688,18 +688,6 @@ static const struct clk_parent_data gcc_parent_data_14[] = {
 	{ .hw = &gpll11.clkr.hw },
 };
 
-static const struct parent_map gcc_parent_map_15[] = {
-	{ P_BI_TCXO, 0 },
-	{ P_GPLL0_OUT_MAIN, 1 },
-	{ P_GPLL6_OUT_EVEN, 4 },
-};
-
-static const struct clk_parent_data gcc_parent_data_15[] = {
-	{ .index = DT_BI_TCXO },
-	{ .hw = &gpll0.clkr.hw },
-	{ .hw = &gpll6_out_even.clkr.hw },
-};
-
 static const struct freq_tbl ftbl_gcc_camss_axi_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(150000000, P_GPLL0_OUT_EVEN, 2, 0, 0),
-- 
2.30.2

