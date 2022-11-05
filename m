Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2401461DB7E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKEPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKEPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4654C1055E;
        Sat,  5 Nov 2022 08:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0170B80171;
        Sat,  5 Nov 2022 15:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B51C4315E;
        Sat,  5 Nov 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660570;
        bh=PpdUtPZs9MpphCIeL3UrfFdOiK5XTAbpl61pby3c3ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOi3i1c0ZRZwUnJgP67jehy8y/UJKktxUzHnRFii5q8pdRedmUMy3w3TeaRDBolC6
         LOcgnOjDyDZMyX5fxvfU3OZCP8/lBsvIZnyqBbfxmSW/FlNZoa6OkEWQ8Q9sTW8PhC
         xvi9/rWelxpryItEjSBwPIjYWUlSDunG+U0efFtrr0PX5YOyMoSQeJmbIa6d/j5T9d
         na22I4bhm+1Z9djgRuzPtJhyMf8wgbz159ccT4eDCA5JQR420nEKt7ILRCacyKU/rx
         /71YgU0w5mPeIqnx0luf41bOSOPf2U4+lAsgrgngyNfO30Q34glE6nBO29ttU5s+Vd
         xNcpRQh7RpeOw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgp-0005KU-64; Sat, 05 Nov 2022 16:02:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 06/16] phy: qcom-qmp-pcie: rename PHY ops structure
Date:   Sat,  5 Nov 2022 15:59:29 +0100
Message-Id: <20221105145939.20318-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221105145939.20318-1-johan+linaro@kernel.org>
References: <20221105145939.20318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the PHY operation structure so that it has a "phy_ops" suffix and
move it next to the implementation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
2.37.4

