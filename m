Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D4631C13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiKUIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiKUIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:52:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6E67FF03;
        Mon, 21 Nov 2022 00:51:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB9D060F43;
        Mon, 21 Nov 2022 08:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F0BC4FF0F;
        Mon, 21 Nov 2022 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669020715;
        bh=UoN5wh15U6OwcuNRI1oxfnYffMWGCblGCdMNWedim9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+8PL8DvTjpTmKm98hiriehVbwFSzWmaKK89M7oDFzQUQjeAb9X+NnQxNKzfpor77
         hAkcr4P3NIKRODEWIv/ZnvFWps3LcN7R8CUrLD8MxPA4cXHXoaSq+s7Ix9sAu4DvEp
         FNheVqSg/j8Yzh5JuHj3EabFX2TXYLXo3qAqVrxcoqb4iMvjf34ju7q8r5X/umR0+K
         JN65BfVjwbaVKAr6vbW7tne9QOiM17L2m8IaQH9JnjHNi0h1ChIPoxngzSWdGl+dnU
         bCKKvZPj3YXpk9jlmLPcOXMlKwTj/1zTDzx8Gem0T/2d6cYuOOW3f8PvuME9FXhZ8w
         7GFMk9DSdXBaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ox2WT-00088e-Bs; Mon, 21 Nov 2022 09:51:25 +0100
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
Subject: [PATCH v3 11/15] phy: qcom-qmp-combo: rename common-register pointers
Date:   Mon, 21 Nov 2022 09:50:54 +0100
Message-Id: <20221121085058.31213-12-johan+linaro@kernel.org>
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

The common registers are shared by the USB and DP parts of the PHY so
drop the misleading "dp" prefix from the corresponding pointers.

Note that the "DP" prefix could also be dropped from the corresponding
defines, but leave that in place for now.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index fb3705b00823..5777bd1f76b3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -864,7 +864,7 @@ struct qmp_combo {
 
 	const struct qmp_phy_cfg *cfg;
 
-	void __iomem *dp_com;
+	void __iomem *com;
 
 	void __iomem *serdes;
 	void __iomem *tx;
@@ -1767,7 +1767,7 @@ static int qmp_combo_dp_calibrate(struct phy *phy)
 static int qmp_combo_com_init(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	void __iomem *dp_com = qmp->dp_com;
+	void __iomem *com = qmp->com;
 	int ret;
 
 	mutex_lock(&qmp->phy_mutex);
@@ -1798,25 +1798,25 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
 	if (ret)
 		goto err_assert_reset;
 
-	qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
+	qphy_setbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
 
 	/* override hardware control for reset of qmp phy */
-	qphy_setbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
+	qphy_setbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
 			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
 			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 
 	/* Default type-c orientation, i.e CC1 */
-	qphy_setbits(dp_com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
+	qphy_setbits(com, QPHY_V3_DP_COM_TYPEC_CTRL, 0x02);
 
-	qphy_setbits(dp_com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE | DP_MODE);
+	qphy_setbits(com, QPHY_V3_DP_COM_PHY_MODE_CTRL, USB3_MODE | DP_MODE);
 
 	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
-	qphy_clrbits(dp_com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
+	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
 			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
 			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
 
-	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
-	qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
+	qphy_clrbits(com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
+	qphy_clrbits(com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
 
 	qphy_setbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
 			SW_PWRDN);
@@ -2538,9 +2538,9 @@ static int qmp_combo_parse_dt_legacy(struct qmp_combo *qmp, struct device_node *
 	if (IS_ERR(qmp->serdes))
 		return PTR_ERR(qmp->serdes);
 
-	qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(qmp->dp_com))
-		return PTR_ERR(qmp->dp_com);
+	qmp->com = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(qmp->com))
+		return PTR_ERR(qmp->com);
 
 	qmp->dp_serdes = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(qmp->dp_serdes))
-- 
2.37.4

