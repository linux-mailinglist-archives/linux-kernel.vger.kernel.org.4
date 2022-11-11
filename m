Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0766255DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiKKI50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966B79D18;
        Fri, 11 Nov 2022 00:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99ED661EFC;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B40C43145;
        Fri, 11 Nov 2022 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=8dymqpuzXcztunwC+qLMQlrAR1UOIg2+qt0/dP7pvt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hr+iCVqaHcQ81ybHqTryh/Vjay9sVzbzUN5Liko9sRi9WDwl6HPV8BD/FN5Wyk+4F
         CtY0Nxb8UB8Ofkku8HI/Dlfhhs9LBRU+EGPd3GC/FShdfu/JTrWcJoV+aU1LQa5xfb
         S1kBXGjDr05FlcrnfOtx4P4YLpILMZz5SEmyCU14cmPjK1woaIOubrPN6eVzPP94f/
         HbKxM3egKSb3wWam7N3WKxC9Gxh3krqaxXVkPU3lE75RMhh4uCzhajmg09TC0eiT2T
         22wEmzAUHfxdR3PlaWlpfT4bH/prJ/xisQ/yOIoJctrfSyJGg/a+TxbdtN/xuGWZmH
         5KgPORDx5/b5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002Tv-52; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 04/22] phy: qcom-qmp-combo: rename PHY ops structures
Date:   Fri, 11 Nov 2022 09:56:25 +0100
Message-Id: <20221111085643.9478-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111085643.9478-1-johan+linaro@kernel.org>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
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

Rename the PHY operation structures so that they have a "phy_ops" suffix
and move them next to the implementation.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 40 +++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 2ac29b71d3b7..13800c2243e1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2118,6 +2118,24 @@ static int qmp_combo_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	return 0;
 }
 
+static const struct phy_ops qmp_combo_usb_phy_ops = {
+	.init		= qmp_combo_enable,
+	.exit		= qmp_combo_disable,
+	.set_mode	= qmp_combo_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static const struct phy_ops qmp_combo_dp_phy_ops = {
+	.init		= qmp_combo_init,
+	.configure	= qcom_qmp_dp_phy_configure,
+	.power_on	= qmp_combo_power_on,
+	.calibrate	= qcom_qmp_dp_phy_calibrate,
+	.power_off	= qmp_combo_power_off,
+	.exit		= qmp_combo_exit,
+	.set_mode	= qmp_combo_set_mode,
+	.owner		= THIS_MODULE,
+};
+
 static void qmp_combo_enable_autonomous_mode(struct qmp_phy *qphy)
 {
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -2542,24 +2560,6 @@ static int phy_dp_clks_register(struct qcom_qmp *qmp, struct qmp_phy *qphy,
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static const struct phy_ops qmp_combo_usb_ops = {
-	.init		= qmp_combo_enable,
-	.exit		= qmp_combo_disable,
-	.set_mode	= qmp_combo_set_mode,
-	.owner		= THIS_MODULE,
-};
-
-static const struct phy_ops qmp_combo_dp_ops = {
-	.init		= qmp_combo_init,
-	.configure	= qcom_qmp_dp_phy_configure,
-	.power_on	= qmp_combo_power_on,
-	.calibrate	= qcom_qmp_dp_phy_calibrate,
-	.power_off	= qmp_combo_power_off,
-	.exit		= qmp_combo_exit,
-	.set_mode	= qmp_combo_set_mode,
-	.owner		= THIS_MODULE,
-};
-
 static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 			void __iomem *serdes, const struct qmp_phy_cfg *cfg)
 {
@@ -2632,9 +2632,9 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 	}
 
 	if (cfg->type == PHY_TYPE_DP)
-		ops = &qmp_combo_dp_ops;
+		ops = &qmp_combo_dp_phy_ops;
 	else
-		ops = &qmp_combo_usb_ops;
+		ops = &qmp_combo_usb_phy_ops;
 
 	generic_phy = devm_phy_create(dev, np, ops);
 	if (IS_ERR(generic_phy)) {
-- 
2.37.4

