Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAAF6256D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiKKJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiKKJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25A67B220;
        Fri, 11 Nov 2022 01:26:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C1861F1D;
        Fri, 11 Nov 2022 09:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44518C4FF08;
        Fri, 11 Nov 2022 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158765;
        bh=bEcxDHyAYgLc3wiWBz5WNZrUp7HQnJ1/WycWoNsGCDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLTTzykNM+DQpO761Sp8YaTO6oMdwunaz6VPsgxZB3sp/Mozxq0Fa+JXNTE9fNOfq
         aWkArENP6sBIoIrlhRLLyrqLeBvkgvZvnXmQizX5lBgwptR/otoRkIWzQETUe7Lw4e
         kWcI0X2sd1oGoTZv24T2U3gcRxcYoDXUUOHfqHi/afBZvcHSbwLjDS9piqWllCZr7I
         Q7rrJ2A2Io9piVxQrir2PenlL1KxXeiqo29ynoe1unoGvKRIceFYQDz3wm9Ev5JWS2
         tM2A5237kb03p+dxtF4KI1DThchAohL9SlSIDeHSWbBpUx7bUHvNt6eKdQNBe/m7R2
         hPmbKmDZO3IQQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI5-0002lH-De; Fri, 11 Nov 2022 10:25:37 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 11/14] phy: qcom-qmp-combo: clean up DP clock callbacks
Date:   Fri, 11 Nov 2022 10:24:54 +0100
Message-Id: <20221111092457.10546-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111092457.10546-1-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
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

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 33 ++++++++++-------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index f3d3229d3aa2..5068f8674faf 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2316,8 +2316,7 @@ static int phy_pipe_clk_register(struct qmp_combo *qmp, struct device_node *np)
  *              for DP pixel clock
  *
  */
-static int qcom_qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw,
-						struct clk_rate_request *req)
+static int qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	switch (req->rate) {
 	case 1620000000UL / 2:
@@ -2329,8 +2328,7 @@ static int qcom_qmp_dp_pixel_clk_determine_rate(struct clk_hw *hw,
 	}
 }
 
-static unsigned long
-qcom_qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+static unsigned long qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
@@ -2352,13 +2350,12 @@ qcom_qmp_dp_pixel_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
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
@@ -2371,8 +2368,7 @@ static int qcom_qmp_dp_link_clk_determine_rate(struct clk_hw *hw,
 	}
 }
 
-static unsigned long
-qcom_qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+static unsigned long qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 	const struct qmp_combo *qmp;
 	const struct phy_configure_opts_dp *dp_opts;
@@ -2391,13 +2387,12 @@ qcom_qmp_dp_link_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
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
@@ -2420,7 +2415,7 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	int ret;
 
 	snprintf(name, sizeof(name), "%s::link_clk", dev_name(qmp->dev));
-	init.ops = &qcom_qmp_dp_link_clk_ops;
+	init.ops = &qmp_dp_link_clk_ops;
 	init.name = name;
 	qmp->dp_link_hw.init = &init;
 	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_link_hw);
@@ -2428,7 +2423,7 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 		return ret;
 
 	snprintf(name, sizeof(name), "%s::vco_div_clk", dev_name(qmp->dev));
-	init.ops = &qcom_qmp_dp_pixel_clk_ops;
+	init.ops = &qmp_dp_pixel_clk_ops;
 	init.name = name;
 	qmp->dp_pixel_hw.init = &init;
 	ret = devm_clk_hw_register(qmp->dev, &qmp->dp_pixel_hw);
@@ -2464,7 +2459,7 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_hw_provider(dp_np, qcom_qmp_dp_clks_hw_get, qmp);
+	ret = of_clk_add_hw_provider(dp_np, qmp_dp_clks_hw_get, qmp);
 	if (ret)
 		return ret;
 
-- 
2.37.4

