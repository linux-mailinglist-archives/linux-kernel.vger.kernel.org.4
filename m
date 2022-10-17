Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C35601242
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJQPA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiJQO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:59:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B046B8E5;
        Mon, 17 Oct 2022 07:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2BE7B818F9;
        Mon, 17 Oct 2022 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05F5C433B5;
        Mon, 17 Oct 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018478;
        bh=PkjNR+pEzmOYfE2IfEfjNtpDBUAoZAWCYslxLltfZwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbpUfkDhdPnLEM+AVHTs1VWszP4cg4+cb2JQOO4bVXSYKKzlZqkAl133/5Wswei4l
         hdNC/nPErDGMOvTTfSnRocdS4r3fighVkvcah/gsq8FcRW+86fHiwq5Prk3GHzdgJE
         ixUpF4qRWFkPqUkAZHwJNa5uF7bIuKh2Uev/3pr/MwY8onmh6ib17u3I0H2Qab/759
         88WgZqXQ+31fyITyhZYuxTaNRvP2lwz4rz/Q01xX60pqSkqmM6BIup8skcirEER6GH
         g6cQP1kxLTMbjQ6SCQghbBS9vL1aOZ8lSNlnIdR0G7O9QTSProWp9TooYr9MTxhoZK
         +3Pf2Go+RutWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okRVc-0005mA-VT; Mon, 17 Oct 2022 16:54:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/15] phy: qcom-qmp-pcie: rename PHY ops structure
Date:   Mon, 17 Oct 2022 16:53:19 +0200
Message-Id: <20221017145328.22090-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017145328.22090-1-johan+linaro@kernel.org>
References: <20221017145328.22090-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the PHY operation structure so that it has a "phy_ops" suffix and
move it next to the implementation.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index e30cbc94cbf6..bd946438e3c3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2037,6 +2037,13 @@ static int qmp_pcie_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	return 0;
 }
 
+static const struct phy_ops qmp_pcie_phy_ops = {
+	.power_on	= qmp_pcie_enable,
+	.power_off	= qmp_pcie_disable,
+	.set_mode	= qmp_pcie_set_mode,
+	.owner		= THIS_MODULE,
+};
+
 static int qmp_pcie_vreg_init(struct qmp_pcie *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -2160,13 +2167,6 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static const struct phy_ops qmp_pcie_ops = {
-	.power_on	= qmp_pcie_enable,
-	.power_off	= qmp_pcie_disable,
-	.set_mode	= qmp_pcie_set_mode,
-	.owner		= THIS_MODULE,
-};
-
 static int qmp_pcie_create(struct qmp_pcie *qmp, struct device_node *np)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -2229,7 +2229,7 @@ static int qmp_pcie_create(struct qmp_pcie *qmp, struct device_node *np)
 				     "failed to get pipe clock\n");
 	}
 
-	generic_phy = devm_phy_create(dev, np, &qmp_pcie_ops);
+	generic_phy = devm_phy_create(dev, np, &qmp_pcie_phy_ops);
 	if (IS_ERR(generic_phy)) {
 		ret = PTR_ERR(generic_phy);
 		dev_err(dev, "failed to create PHY: %d\n", ret);
-- 
2.37.3

