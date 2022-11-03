Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966C3618A79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiKCVVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiKCVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:21:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381321E34;
        Thu,  3 Nov 2022 14:21:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so4532239wrb.13;
        Thu, 03 Nov 2022 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIcm/SirnZMuA7oz66y5Oz4Q+8fuoc4tcWENPsKxvJU=;
        b=km90eVlRFFREd/Ht0TdeBdyFn7QERBsyBxvACAsXnW5BgsIndfPfk3IugX6Q2o8J9C
         ZS9QtORTcfsH6lV9aelKa9N8/6FaXuSrk+8AcGaysY2QGp8NC05x1nO6g+uNy1yLFAtL
         SzuzNw4wAaoCAZKFt7hpeY9tyH2H4BMnrYjLOZArOMJvGUu6sYt/ZgPIbY9c37UyCcPW
         ZlXllmPdx/FnnavTKRHzK19ib2uupuzalotJyCuybb9lO4w0AyNmbB7Elw3VmUsy0Yfy
         y1PNHGzZchJ5WM2d23hNDbk2mcv5TiFzbdYaHI0zXueNJJMprlVCJHKsDeyaQnBsnUNG
         IgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIcm/SirnZMuA7oz66y5Oz4Q+8fuoc4tcWENPsKxvJU=;
        b=eyjLnMXZO2MU5SdsP4cHqBDKgYigDV+PvDNi6gooPbf2+zjnZDKQFBroC9HMbSMOcW
         C9z+KTkz70CZGPNfRVUHapUJTaqrx2ztkKlL/o9iZPVhsbsx/eGUjevktVgmbZZ4BEXu
         XQhC0a0iseE/5y5v+VLIeU6kYqldVL/anLrOuXsytWPQJR9dzsGiTH1OqF+xNFu3Z0Ej
         l8y/L/XrJ2mCe5/DWeHi5S1snZ/WcZGknxYl8p3T+k0hppq/szYuY4PYqVIH6Y7E3cQe
         V280RduzLPGo8NnE2wQgn0UKg60HCHR1A4U8QqNRZxmUDf7JNwUBfKPN8FtvP4Wwbl/6
         5Upg==
X-Gm-Message-State: ACrzQf2Wz55ZJGGr3HPMCxZw+cz6KzbcQx6SpDYIpVA8MqChafbHVTqE
        031AYe3BygoJ8RrOJbU1qcY=
X-Google-Smtp-Source: AMsMyM4Tc7NHZWTmPrJLUG4XIhrT0h6TeynUXjG6j3uBaakeeybFCdXAj7cn1BoDQg0XLzlwqOVi+w==
X-Received: by 2002:a5d:4887:0:b0:226:ed34:7bbd with SMTP id g7-20020a5d4887000000b00226ed347bbdmr19529597wrq.561.1667510501178;
        Thu, 03 Nov 2022 14:21:41 -0700 (PDT)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id m29-20020a05600c3b1d00b003b47b913901sm6968320wms.1.2022.11.03.14.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 14:21:40 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] phy: qcom-qmp-pcie: split pcs_misc init cfg for ipq8074 pcs table
Date:   Thu,  3 Nov 2022 22:21:24 +0100
Message-Id: <20221103212125.17156-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit af6643242d3a ("phy: qcom-qmp-pcie: split pcs_misc region for ipq6018
pcie gen3") reworked the pcs regs values and removed the 0x400 offset
for each pcs_misc regs.

This change caused the malfunction of ipq8074 downstream since it still
has the legacy pcs table where pcs_misc are not placed on a different
table and instead put together assuming the offset of 0x400 for the
related pcs_misc regs.

Split pcs_misc init cfg from the ipq8074 pcs init table to be handled
correctly to prepare for actual support for gen3 pcie for ipq8074.

Fixes: af6643242d3a ("phy: qcom-qmp-pcie: split pcs_misc region for ipq6018 pcie gen3")
Reported-by: Robert Marko <robimarko@gmail.com>
Tested-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 7c81667dd968..d699fb4f7436 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -485,6 +485,13 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_FLL_CNTRL1, 0x01),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x0),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x1),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0d),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS, 0x0),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
@@ -497,11 +504,7 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x50),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x1a),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x6),
-	QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
-	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
-	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
-	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0d),
 };
 
 static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
@@ -1506,6 +1509,8 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 		.rx_num		= ARRAY_SIZE(ipq8074_pcie_gen3_rx_tbl),
 		.pcs		= ipq8074_pcie_gen3_pcs_tbl,
 		.pcs_num	= ARRAY_SIZE(ipq8074_pcie_gen3_pcs_tbl),
+		.pcs_misc	= ipq8074_pcie_gen3_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(ipq8074_pcie_gen3_pcs_misc_tbl),
 	},
 	.clk_list		= ipq8074_pciephy_clk_l,
 	.num_clks		= ARRAY_SIZE(ipq8074_pciephy_clk_l),
-- 
2.37.2

