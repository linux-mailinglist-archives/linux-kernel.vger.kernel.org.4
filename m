Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD7631C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKUIwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiKUIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:52:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE77FF00;
        Mon, 21 Nov 2022 00:51:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD84460F45;
        Mon, 21 Nov 2022 08:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E57C4FF07;
        Mon, 21 Nov 2022 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669020715;
        bh=RSCCNHg0pVmtS0IdanzEJRU1fo8izWYA/WxRqAymmF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OO9qHUMDKnLBjdXTTukUmV0MM718EyTHjXyefp2iLOUw1gUCKcbnNyKYj9lz0RqBP
         NQHFy/BqnDzgTI9ReWVieldnrgzfDdYDClzdePn+E0Ws2bvEt+1KD/E/wjpkOotZSn
         m5eRcTf3oqMN+N1A/Ds/yJnjzPWz8U2rsVos8Zv0/PkPNlV+vYVbXtUoFYcV4CVheM
         tdaRC95XdeFbkNT5DllABG45DpN/e4MAr3mFKeNO+Fbo+t9tRngmIoSJvSDi6H4cjC
         l6rNiy2QVVpe9muG3OukxBdXJiDGDsj3qlI9z7OXN99Fi7Qgr1Vyh7C8nw96qhcqEl
         YH1NIe8ZVHP7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ox2WT-00088c-8b; Mon, 21 Nov 2022 09:51:25 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 10/15] phy: qcom-qmp-combo: clean up DP clock callbacks
Date:   Mon, 21 Nov 2022 09:50:53 +0100
Message-Id: <20221121085058.31213-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221121085058.31213-1-johan+linaro@kernel.org>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the DP clock callbacks somewhat by dropping the redundant
"qcom" prefix and removing line breaks after type specifiers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 33 ++++++++++-------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 89a5b51c770d..fb3705b00823 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2304,8 +2304,7 @@ static int phy_pipe_clk_register(struct qmp_combo *qmp, struct device_node *np)
  *              for DP pixel clock
  *
  */
-static int qcom_qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw,
-						struct clk_rate_request *req)
+static int qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	switch (req->rate) {
 	case 1620000000UL / 2:
@@ -2317,8 +2316,7 @@ static int qcom_qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw,
 	}
 }
 
-static unsigned long
-qcom_qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+static unsigned long qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
@@ -2340,13 +2338,12 @@ qcom_qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	}
 }
 
-static const struct clk_ops qcom_qmp_dp_pixel_clk_ops = {
-	.determine_rate = qcom_qmp_dp_pixel_clk_determine_rate,
-	.recalc_rate = qcom_qmp_dp_pixel_clk_recalc_rate,
+static const struct clk_ops qmp_dp_pixel_clk_ops = {
+	.determine_rate	= qmp_dp_pixel_clk_determine_rate,
+	.recalc_rate	= qmp_dp_pixel_clk_recalc_rate,
 };
 
-static int qcom_qmp_dp_link_clk_determine_rate(struct clk_hw *hw,
-					       struct clk_rate_request *req)
+static int qmp_dp_link_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	switch (req->rate) {
 	case 162000000:
@@ -2359,8 +2356,7 @@ static int qcom_qmp_dp_link_clk_determine_rate(struct clk_hw *hw,
 	}
 }
 
-static unsigned long
-qcom_qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+static unsigned long qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
@@ -2379,13 +2375,12 @@ qcom_qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	}
 }
 
-static const struct clk_ops qcom_qmp_dp_link_clk_ops = {
-	.determine_rate = qcom_qmp_dp_link_clk_determine_rate,
-	.recalc_rate = qcom_qmp_dp_link_clk_recalc_rate,
+static const struct clk_ops qmp_dp_link_clk_ops = {
+	.determine_rate	= qmp_dp_link_clk_determine_rate,
+	.recalc_rate	= qmp_dp_link_clk_recalc_rate,
 };
 
-static struct clk_hw *
-qcom_qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct qmp_combo *qmp = data;
 	unsigned int idx = clkspec->args[0];
@@ -2408,7 +2403,7 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	int ret;
 
 	snprintf(name, sizeof(name), "%s::link_clk", dev_name(qmp->dev));
-	init.ops = &qcom_qmp_dp_link_clk_ops;
+	init.ops = &qmp_dp_link_clk_ops;
 	init.name = name;
 	qmp->dp_link_hw.init = &init;
 	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_link_hw);
@@ -2416,7 +2411,7 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 		return ret;
 
 	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(qmp->dev));
-	init.ops = &qcom_qmp_dp_pixel_clk_ops;
+	init.ops = &qmp_dp_pixel_clk_ops;
 	init.name = name;
 	qmp->dp_pixel_hw.init = &init;
 	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_pixel_hw);
@@ -2452,7 +2447,7 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_hw_provider(dp_np, qcom_qmp_dp_clks_hw_get, qmp);
+	ret = of_clk_add_hw_provider(dp_np, qmp_dp_clks_hw_get, qmp);
 	if (ret)
 		return ret;
 
-- 
2.37.4

