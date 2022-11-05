Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3461DB7F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiKEPDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiKEPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:02:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B181055F;
        Sat,  5 Nov 2022 08:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F45B80159;
        Sat,  5 Nov 2022 15:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594F0C4315D;
        Sat,  5 Nov 2022 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667660570;
        bh=YWp7kItkvrNSS6rRbYPEscUmb7SKqkwrWganfIrPbQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JP1GkJ0X2DSQJuM4QFrPz1ZFU1KhCeuS6PpnE/qSi6QBiCh8Y6yDk7yHxWYAhnkls
         80BKw/QIpcrDJmi5sc4WMxqiB3ZlgYPffq09LGN4AdIjuJb/Iiw9Q5sQJGy6UpFWCz
         2q0U+Fr6CsMBTigX+M3EYtGfF0eROvQjrFiWCuqSKTGRizUEpFvpW5LZS4JuqLEUOx
         a/AoVk5B27Ynr7ZE/rrjONPCsr0pr73Wyw98fgDGxMVUJvKF1b/yUHqVRqrWKGp00r
         vhFVqk1qDBXcJO1vOK8IUbeskFrkVQsDE5k9OY0bVre1Spn4qwoAGXES2O1oVRAEXj
         kklc3mHj2F4xw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1orKgp-0005Ka-CD; Sat, 05 Nov 2022 16:02:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v5 08/16] phy: qcom-qmp-pcie: use shorter tables identifiers
Date:   Sat,  5 Nov 2022 15:59:31 +0100
Message-Id: <20221105145939.20318-9-johan+linaro@kernel.org>
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

The QMP drivers all use 'tbl' to refer to their register initialisation
tables.

For consistency use 'tbls' rather than 'tables' to refer to the new
aggregate table structures.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 90 ++++++++++++------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index dd7e72424fc0..a977f2bbd831 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1313,7 +1313,7 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
 	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
 };
 
-struct qmp_phy_cfg_tables {
+struct qmp_phy_cfg_tbls {
 	const struct qmp_phy_init_tbl *serdes;
 	int serdes_num;
 	const struct qmp_phy_init_tbl *tx;
@@ -1331,7 +1331,7 @@ struct qmp_phy_cfg {
 	int lanes;
 
 	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
-	const struct qmp_phy_cfg_tables tables;
+	const struct qmp_phy_cfg_tbls tbls;
 	/*
 	 * Additional init sequences for PHY blocks, providing additional
 	 * register programming. They are used for providing separate sequences
@@ -1339,8 +1339,8 @@ struct qmp_phy_cfg {
 	 *
 	 * If EP mode is not supported, both tables can be left unset.
 	 */
-	const struct qmp_phy_cfg_tables *tables_rc;
-	const struct qmp_phy_cfg_tables *tables_ep;
+	const struct qmp_phy_cfg_tbls *tbls_rc;
+	const struct qmp_phy_cfg_tbls *tbls_ep;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -1442,7 +1442,7 @@ static const char * const sdm845_pciephy_reset_l[] = {
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= ipq8074_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(ipq8074_pcie_serdes_tbl),
 		.tx		= ipq8074_pcie_tx_tbl,
@@ -1467,7 +1467,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= ipq8074_pcie_gen3_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(ipq8074_pcie_gen3_serdes_tbl),
 		.tx		= ipq8074_pcie_gen3_tx_tbl,
@@ -1494,7 +1494,7 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= ipq6018_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(ipq6018_pcie_serdes_tbl),
 		.tx		= ipq6018_pcie_tx_tbl,
@@ -1521,7 +1521,7 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sdm845_qmp_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sdm845_qmp_pcie_serdes_tbl),
 		.tx		= sdm845_qmp_pcie_tx_tbl,
@@ -1548,7 +1548,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sdm845_qhp_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sdm845_qhp_pcie_serdes_tbl),
 		.tx		= sdm845_qhp_pcie_tx_tbl,
@@ -1573,7 +1573,7 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sm8250_qmp_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
 		.tx		= sm8250_qmp_pcie_tx_tbl,
@@ -1585,7 +1585,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 		.pcs_misc	= sm8250_qmp_pcie_pcs_misc_tbl,
 		.pcs_misc_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.tables_rc = &(const struct qmp_phy_cfg_tables) {
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
 		.serdes		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
 		.rx		= sm8250_qmp_gen3x1_pcie_rx_tbl,
@@ -1610,7 +1610,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 	.lanes			= 2,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sm8250_qmp_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
 		.tx		= sm8250_qmp_pcie_tx_tbl,
@@ -1622,7 +1622,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 		.pcs_misc	= sm8250_qmp_pcie_pcs_misc_tbl,
 		.pcs_misc_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
 	},
-	.tables_rc = &(const struct qmp_phy_cfg_tables) {
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
 		.tx		= sm8250_qmp_gen3x2_pcie_tx_tbl,
 		.tx_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
 		.rx		= sm8250_qmp_gen3x2_pcie_rx_tbl,
@@ -1647,7 +1647,7 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= msm8998_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(msm8998_pcie_serdes_tbl),
 		.tx		= msm8998_pcie_tx_tbl,
@@ -1674,7 +1674,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sc8180x_qmp_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sc8180x_qmp_pcie_serdes_tbl),
 		.tx		= sc8180x_qmp_pcie_tx_tbl,
@@ -1701,7 +1701,7 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.lanes			= 2,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sdx55_qmp_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sdx55_qmp_pcie_serdes_tbl),
 		.tx		= sdx55_qmp_pcie_tx_tbl,
@@ -1728,7 +1728,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 	.lanes			= 1,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen3x1_pcie_serdes_tbl),
 		.tx		= sm8450_qmp_gen3x1_pcie_tx_tbl,
@@ -1755,7 +1755,7 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 	.lanes			= 2,
 
-	.tables = {
+	.tbls = {
 		.serdes		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_serdes_tbl),
 		.tx		= sm8450_qmp_gen4x2_pcie_tx_tbl,
@@ -1768,14 +1768,14 @@ static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
 		.pcs_misc_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_pcs_misc_tbl),
 	},
 
-	.tables_rc = &(const struct qmp_phy_cfg_tables) {
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
 		.serdes		= sm8450_qmp_gen4x2_pcie_rc_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_rc_serdes_tbl),
 		.pcs_misc	= sm8450_qmp_gen4x2_pcie_rc_pcs_misc_tbl,
 		.pcs_misc_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_rc_pcs_misc_tbl),
 	},
 
-	.tables_ep = &(const struct qmp_phy_cfg_tables) {
+	.tbls_ep = &(const struct qmp_phy_cfg_tbls) {
 		.serdes		= sm8450_qmp_gen4x2_pcie_ep_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sm8450_qmp_gen4x2_pcie_ep_serdes_tbl),
 		.pcs_misc	= sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl,
@@ -1820,17 +1820,17 @@ static void qmp_pcie_configure(void __iomem *base,
 	qmp_pcie_configure_lane(base, tbl, num, 0xff);
 }
 
-static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_serdes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	void __iomem *serdes = qmp->serdes;
 
-	if (!tables)
+	if (!tbls)
 		return;
 
-	qmp_pcie_configure(serdes, tables->serdes, tables->serdes_num);
+	qmp_pcie_configure(serdes, tbls->serdes, tbls->serdes_num);
 }
 
-static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *tx = qmp->tx;
@@ -1838,28 +1838,28 @@ static void qmp_pcie_lanes_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_t
 	void __iomem *tx2 = qmp->tx2;
 	void __iomem *rx2 = qmp->rx2;
 
-	if (!tables)
+	if (!tbls)
 		return;
 
-	qmp_pcie_configure_lane(tx, tables->tx, tables->tx_num, 1);
-	qmp_pcie_configure_lane(rx, tables->rx, tables->rx_num, 1);
+	qmp_pcie_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
+	qmp_pcie_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
 
 	if (cfg->lanes >= 2) {
-		qmp_pcie_configure_lane(tx2, tables->tx, tables->tx_num, 2);
-		qmp_pcie_configure_lane(rx2, tables->rx, tables->rx_num, 2);
+		qmp_pcie_configure_lane(tx2, tbls->tx, tbls->tx_num, 2);
+		qmp_pcie_configure_lane(rx2, tbls->rx, tbls->rx_num, 2);
 	}
 }
 
-static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tables *tables)
+static void qmp_pcie_pcs_init(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	void __iomem *pcs = qmp->pcs;
 	void __iomem *pcs_misc = qmp->pcs_misc;
 
-	if (!tables)
+	if (!tbls)
 		return;
 
-	qmp_pcie_configure(pcs, tables->pcs, tables->pcs_num);
-	qmp_pcie_configure(pcs_misc, tables->pcs_misc, tables->pcs_misc_num);
+	qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
+	qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
 }
 
 static int qmp_pcie_init(struct phy *phy)
@@ -1918,7 +1918,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 {
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	const struct qmp_phy_cfg_tables *mode_tables;
+	const struct qmp_phy_cfg_tbls *mode_tbls;
 	void __iomem *pcs = qmp->pcs;
 	void __iomem *status;
 	unsigned int mask, val;
@@ -1928,12 +1928,12 @@ static int qmp_pcie_power_on(struct phy *phy)
 			cfg->pwrdn_ctrl);
 
 	if (qmp->mode == PHY_MODE_PCIE_RC)
-		mode_tables = cfg->tables_rc;
+		mode_tbls = cfg->tbls_rc;
 	else
-		mode_tables = cfg->tables_ep;
+		mode_tbls = cfg->tbls_ep;
 
-	qmp_pcie_serdes_init(qmp, &cfg->tables);
-	qmp_pcie_serdes_init(qmp, mode_tables);
+	qmp_pcie_serdes_init(qmp, &cfg->tbls);
+	qmp_pcie_serdes_init(qmp, mode_tbls);
 
 	ret = clk_prepare_enable(qmp->pipe_clk);
 	if (ret) {
@@ -1942,11 +1942,11 @@ static int qmp_pcie_power_on(struct phy *phy)
 	}
 
 	/* Tx, Rx, and PCS configurations */
-	qmp_pcie_lanes_init(qmp, &cfg->tables);
-	qmp_pcie_lanes_init(qmp, mode_tables);
+	qmp_pcie_lanes_init(qmp, &cfg->tbls);
+	qmp_pcie_lanes_init(qmp, mode_tbls);
 
-	qmp_pcie_pcs_init(qmp, &cfg->tables);
-	qmp_pcie_pcs_init(qmp, mode_tables);
+	qmp_pcie_pcs_init(qmp, &cfg->tbls);
+	qmp_pcie_pcs_init(qmp, mode_tbls);
 
 	/* Pull PHY out of reset state */
 	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
@@ -2217,9 +2217,9 @@ static int qmp_pcie_create(struct qmp_pcie *qmp, struct device_node *np)
 		qmp->pcs_misc = qmp->pcs + 0x400;
 
 	if (IS_ERR(qmp->pcs_misc)) {
-		if (cfg->tables.pcs_misc ||
-		    (cfg->tables_rc && cfg->tables_rc->pcs_misc) ||
-		    (cfg->tables_ep && cfg->tables_ep->pcs_misc)) {
+		if (cfg->tbls.pcs_misc ||
+		    (cfg->tbls_rc && cfg->tbls_rc->pcs_misc) ||
+		    (cfg->tbls_ep && cfg->tbls_ep->pcs_misc)) {
 			return PTR_ERR(qmp->pcs_misc);
 		}
 	}
-- 
2.37.4

