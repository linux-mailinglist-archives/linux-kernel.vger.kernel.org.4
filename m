Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8E5FC1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJLIQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJLIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839DA5F124;
        Wed, 12 Oct 2022 01:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA07161475;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D7CC43470;
        Wed, 12 Oct 2022 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665562555;
        bh=ePkorG5FNkC6a6upNo+L63Iiyp3pAh4AuCKmPgyEhh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCq4QgvBVzumQa9j5OsEYWacvcmvCeSf64yM2TDUGGtthw6IrKnMAhV/YlWr6Xyuf
         36SYfe8gC+jM2iQQyJQD/DzGFunb0F2PSUxsobXTmlgdRTTHbIHpqBcL9+YyL2AKz5
         n++w3TKYidbBxJGtHpAtGyNNmCZ8nQedxF+2FxqA8bpc/vHBwf1DOdREk8BUVcBCqS
         8GmbB4/As+bk1vt0C5SHjR0b4uolDDc8W7/N0I1Jj7BxSXA4kbmhP/CQVrq0CoBCdc
         PeTcHJhzYcP9Sae59NhL9nll+sp3ml9iYDpazVFuxdHztkS+3cJZm+p9gl3lQ1A0eB
         IsAH/ZZAgdNHQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiWu2-0004oO-Ak; Wed, 12 Oct 2022 10:15:46 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 02/14] phy: qcom-qmp: drop superfluous comments
Date:   Wed, 12 Oct 2022 10:12:29 +0200
Message-Id: <20221012081241.18273-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012081241.18273-1-johan+linaro@kernel.org>
References: <20221012081241.18273-1-johan+linaro@kernel.org>
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

Drop some unnecessary or incorrect comments.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 4 ----
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 3 ---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 3 ---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 3 ---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 5 -----
 5 files changed, 18 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 998c8f80ccd8..3889dcf73c59 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1949,7 +1949,6 @@ static int qmp_combo_com_init(struct qmp_phy *qphy)
 		return 0;
 	}
 
-	/* turn on regulator supplies */
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
@@ -2779,7 +2778,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	qmp->dev = dev;
 	dev_set_drvdata(dev, qmp);
 
-	/* Get the specific init parameters of QMP phy */
 	combo_cfg = of_device_get_match_data(dev);
 	if (!combo_cfg)
 		return -EINVAL;
@@ -2787,7 +2785,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	usb_cfg = combo_cfg->usb_cfg;
 	cfg = usb_cfg; /* Setup clks and regulators */
 
-	/* per PHY serdes; usually located at base address */
 	usb_serdes = serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
@@ -2796,7 +2793,6 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (IS_ERR(qmp->dp_com))
 		return PTR_ERR(qmp->dp_com);
 
-	/* Only two serdes for combo PHY */
 	dp_serdes = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(dp_serdes))
 		return PTR_ERR(dp_serdes);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 45c0e2958bf6..8b74948eb467 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -420,7 +420,6 @@ static int qmp_pcie_msm8996_com_init(struct qmp_phy *qphy)
 		return 0;
 	}
 
-	/* turn on regulator supplies */
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
@@ -845,12 +844,10 @@ static int qmp_pcie_msm8996_probe(struct platform_device *pdev)
 	qmp->dev = dev;
 	dev_set_drvdata(dev, qmp);
 
-	/* Get the specific init parameters of QMP phy */
 	cfg = of_device_get_match_data(dev);
 	if (!cfg)
 		return -EINVAL;
 
-	/* per PHY serdes; usually located at base address */
 	serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index dc7f8ba413b9..de04d8dd5350 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1978,7 +1978,6 @@ static int qmp_pcie_init(struct phy *phy)
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
 	int ret;
 
-	/* turn on regulator supplies */
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
@@ -2425,12 +2424,10 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 	qmp->dev = dev;
 	dev_set_drvdata(dev, qmp);
 
-	/* Get the specific init parameters of QMP phy */
 	cfg = of_device_get_match_data(dev);
 	if (!cfg)
 		return -EINVAL;
 
-	/* per PHY serdes; usually located at base address */
 	serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 566365fbfe1a..ab69f648ee38 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -849,7 +849,6 @@ static int qmp_ufs_com_init(struct qmp_phy *qphy)
 	void __iomem *pcs = qphy->pcs;
 	int ret;
 
-	/* turn on regulator supplies */
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
@@ -1194,12 +1193,10 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 	qmp->dev = dev;
 	dev_set_drvdata(dev, qmp);
 
-	/* Get the specific init parameters of QMP phy */
 	cfg = of_device_get_match_data(dev);
 	if (!cfg)
 		return -EINVAL;
 
-	/* per PHY serdes; usually located at base address */
 	serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index a0b97fd5d0a5..2c5e4041bcf9 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2120,7 +2120,6 @@ static int qmp_usb_init(struct phy *phy)
 	void __iomem *dp_com = qmp->dp_com;
 	int ret;
 
-	/* turn on regulator supplies */
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
@@ -2229,7 +2228,6 @@ static int qmp_usb_power_on(struct phy *phy)
 					cfg->rx_tbl, cfg->rx_tbl_num, 2);
 	}
 
-	/* Configure link rate, swing, etc. */
 	qmp_usb_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
 	if (cfg->has_pwrdn_delay)
@@ -2719,17 +2717,14 @@ static int qmp_usb_probe(struct platform_device *pdev)
 	qmp->dev = dev;
 	dev_set_drvdata(dev, qmp);
 
-	/* Get the specific init parameters of QMP phy */
 	cfg = of_device_get_match_data(dev);
 	if (!cfg)
 		return -EINVAL;
 
-	/* per PHY serdes; usually located at base address */
 	serdes = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(serdes))
 		return PTR_ERR(serdes);
 
-	/* per PHY dp_com; if PHY has dp_com control block */
 	if (cfg->has_phy_dp_com_ctrl) {
 		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(qmp->dp_com))
-- 
2.35.1

