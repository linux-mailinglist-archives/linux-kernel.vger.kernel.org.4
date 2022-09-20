Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996AF5BDE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiITHkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiITHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99618606B5;
        Tue, 20 Sep 2022 00:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 277CDB82561;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A80C4347C;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=0WpKIrtzSvxKkXOUcVo1f8LRvOiN+BejO8qNmQISNBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4IEvIkh4aCyXSdKBw3seimUVuF4xGK+A33aXd443yDuSkAUPO4cbGpBtyGQGH1vE
         xkYnI8iW2eAAQBUYLGtzP4LMBW9zLo7plqWm5ZihDpn7dLIGbAtLWnctZu1GRqmgUj
         wsE1x1cDLLmCIwlScm7LMlsBKpFWUO0rhXmzlChJaZcMzBWDCJwhRt8Izgg79Nhwd8
         MnC4+SDeNdZ/8zYkFKdPB/hx8hw48XfzLnwDvvuglHqxzwsUIgcEcnP56Vmlvd0aVZ
         YFMB9FZtCQEEpPQxt8vqcrkcVBHfDPfEhnL9d9zBOEUu5xBfFlpBnaKRqP1PZg8X+n
         cszKR6tXgctEw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqP-0005Qe-BB; Tue, 20 Sep 2022 09:39:01 +0200
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
Subject: [PATCH 01/17] phy: qcom-qmp-pcie: drop unused type from config
Date:   Tue, 20 Sep 2022 09:38:10 +0200
Message-Id: <20220920073826.20811-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920073826.20811-1-johan+linaro@kernel.org>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
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

The configuration PHY type is no longer used since the QMP driver split
so drop it from the configurations.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 4939edcd8cb1..d25f9215b86f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1304,8 +1304,6 @@ struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
-	/* phy-type - PCIE/UFS/USB */
-	unsigned int type;
 	/* number of lanes provided by phy */
 	int nlanes;
 
@@ -1470,7 +1468,6 @@ static const char * const sdm845_pciephy_reset_l[] = {
 };
 
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
-	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
 	.serdes_tbl		= ipq8074_pcie_serdes_tbl,
@@ -1499,7 +1496,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
-	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
 	.serdes_tbl		= ipq8074_pcie_gen3_serdes_tbl,
@@ -1529,7 +1525,6 @@ static const struct qmp_phy_cfg ipq8074_pciephy_gen3_cfg = {
 };
 
 static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
-	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
 	.serdes_tbl		= ipq6018_pcie_serdes_tbl,
@@ -1559,7 +1554,6 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
 	.serdes_tbl		= sdm845_qmp_pcie_serdes_tbl,
@@ -1590,7 +1584,6 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
 	.serdes_tbl		= sdm845_qhp_pcie_serdes_tbl,
@@ -1619,7 +1612,6 @@ static const struct qmp_phy_cfg sdm845_qhp_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
 	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
@@ -1658,7 +1650,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 2,
 
 	.serdes_tbl		= sm8250_qmp_pcie_serdes_tbl,
@@ -1698,7 +1689,6 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
-	.type			= PHY_TYPE_PCIE,
 	.nlanes			= 1,
 
 	.serdes_tbl		= msm8998_pcie_serdes_tbl,
@@ -1723,7 +1713,6 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
 	.serdes_tbl		= sc8180x_qmp_pcie_serdes_tbl,
@@ -1753,7 +1742,6 @@ static const struct qmp_phy_cfg sc8180x_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 2,
 
 	.serdes_tbl		= sdx55_qmp_pcie_serdes_tbl,
@@ -1785,7 +1773,6 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 1,
 
 	.serdes_tbl		= sm8450_qmp_gen3x1_pcie_serdes_tbl,
@@ -1816,7 +1803,6 @@ static const struct qmp_phy_cfg sm8450_qmp_gen3x1_pciephy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8450_qmp_gen4x2_pciephy_cfg = {
-	.type = PHY_TYPE_PCIE,
 	.nlanes = 2,
 
 	.serdes_tbl		= sm8450_qmp_gen4x2_pcie_serdes_tbl,
-- 
2.35.1

