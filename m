Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524FA62BD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiKPMIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiKPMHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:07:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7325140F5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:05 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o4so29414998wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT9H3gXeVvORQWBGrUSh/ylC/ESmIB4rbZL+xyzy2UI=;
        b=SglN3jQFrYlBmgSx7LFRLAeUMxIMm6GeJ8GTfPr6dTEkQ28ZCIxe7EoPtTq8CyGcjI
         5l4OX65rBiY8zOlWT0NxRto0ZCco/IXn93N3F9fYvpXTxN5Hk6K2vQ0dneN/6vbIESGa
         nKzI094hycS/G8aK+5GRzpRcNLJvOZdTsR/vblUG48SjPGsM0mcGzGlzTPcncl3o3zXn
         iAcl7MH5v0gWaH7wz/okjyD5633Lc+a+ZUt1NtrLc4HQN1pqVTGKg4ItqMS0tYYSoFL6
         /8SS173xpcPxmY5tV9nXLRm6YzkQ7XdUUI21Nu6Q5UV1UH/sAqgVxE4NDHNWjORnV37l
         yAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KT9H3gXeVvORQWBGrUSh/ylC/ESmIB4rbZL+xyzy2UI=;
        b=hffIwlfyMV1caIYqo5bui8Gdjdxe+bZYFbD4i308r/c2r0TmWtVPIEaJb2LQ76hu4T
         c1wgpe9I4Li5u2DfigFPI/G93g4PwYihqygVtiA4O0YY/TFE1Y+lV3Y7Qi8uHmBFreUb
         P8MxgPdHTyHAOg908Elke96cKQiYXjvh9w0XsJ/ZjYR+aYblntERBOMH6lgFxwdSdgRT
         2bWEUuLPau4i/vbAhXtwFDqEvo6gszz4C5kPhVj9EInl7CZZDC8zT/PnHY5yQ4Z0+oEY
         OUFOHrZv8PD/5f8t32wdVocrSmkVjN1kEVYr3D5nWTN10HvWPoYNiyL41m4WEceLtA92
         sRSw==
X-Gm-Message-State: ANoB5pkbMICApdVUH8emjGdfbkzrA2SmLmwQ+iH+SpZgATFBhsbYLmoq
        I2L6fk7n0hR6Oo/x7NR7RDfOvQ==
X-Google-Smtp-Source: AA0mqf7vaXlbYut3AJyLaN4zqBQmvBFy3NvspvqK0q6Kr93j5ijb1fyGzmGPIInzhmqvZjUaVHIBKw==
X-Received: by 2002:adf:fbc6:0:b0:22e:3392:fb46 with SMTP id d6-20020adffbc6000000b0022e3392fb46mr13247393wrs.706.1668600124172;
        Wed, 16 Nov 2022 04:02:04 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b002206203ed3dsm15120109wrx.29.2022.11.16.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:02:03 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH 03/10] phy: qcom-qmp-ufs: Add SM8550 support
Date:   Wed, 16 Nov 2022 14:01:50 +0200
Message-Id: <20221116120157.2706810-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116120157.2706810-1-abel.vesa@linaro.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM8550 specific register layout and table configs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 91 +++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 189103d1bd18..14cb716752e6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -96,6 +96,13 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int sm8550_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V6_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V6_PCS_UFS_READY_STATUS,
+	[QPHY_SW_RESET]			= QPHY_V6_PCS_UFS_SW_RESET,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
 static const struct qmp_phy_init_tbl msm8996_ufs_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
 	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0xd7),
@@ -520,6 +527,65 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 };
 
+static const struct qmp_phy_init_tbl sm8550_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
+};
+
+static const struct qmp_phy_init_tbl sm8550_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sm8550_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6, 0x60),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B6, 0x60),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B4, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B5, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sm8550_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+};
+
 struct qmp_ufs_offsets {
 	u16 serdes;
 	u16 pcs;
@@ -613,6 +679,10 @@ static const char * const sm8450_ufs_phy_clk_l[] = {
 	"qref", "ref", "ref_aux",
 };
 
+static const char * const sm8550_ufs_phy_clk_l[] = {
+	"qref", "ref",
+};
+
 static const char * const sdm845_ufs_phy_clk_l[] = {
 	"ref", "ref_aux",
 };
@@ -766,6 +836,24 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 	.regs			= sm8150_ufsphy_regs_layout,
 };
 
+static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.serdes_tbl		= sm8550_ufsphy_serdes,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8550_ufsphy_serdes),
+	.tx_tbl			= sm8550_ufsphy_tx,
+	.tx_tbl_num		= ARRAY_SIZE(sm8550_ufsphy_tx),
+	.rx_tbl			= sm8550_ufsphy_rx,
+	.rx_tbl_num		= ARRAY_SIZE(sm8550_ufsphy_rx),
+	.pcs_tbl		= sm8550_ufsphy_pcs,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8550_ufsphy_pcs),
+	.clk_list		= sm8550_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sm8550_ufs_phy_clk_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= sm8550_ufsphy_regs_layout,
+};
+
 static void qmp_ufs_configure_lane(void __iomem *base,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
@@ -1189,6 +1277,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8450-qmp-ufs-phy",
 		.data = &sm8450_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8550-qmp-ufs-phy",
+		.data = &sm8550_ufsphy_cfg,
 	},
 	{ },
 };
-- 
2.34.1

