Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41880604440
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiJSMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiJSL7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816401B867E;
        Wed, 19 Oct 2022 04:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C23AB822F0;
        Wed, 19 Oct 2022 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F8EC433D6;
        Wed, 19 Oct 2022 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666179379;
        bh=OAHvQPsmhoyvpGDhBc9HWxp3abjp8PyJCASV///rrLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2iMKyeyUreKZCvmlXBIRBMF+zMqkJEu5OjmxYzl8inlaEF7pBm+tqHn6JmijlxIa
         FeWsnjXCrWGjwqKlSEn9YsCyU/kB0IL+p3rPeLnUXEXHqWsbRSKlQxkTzOKqKpEdDl
         Lt3U8Mi7icR+lXAH4d+7DmEcPZiJDdU4Mc23xEQkWsNdwMwv4m2JpCNYx/7yLiYSCb
         5+fQka816LMqUqZsc4onX4cgtMtmlKp9Opbl2QdJHMp+7vcknpMBKZ1kYhrbFzp15+
         IHq6mdq+1bJIypz3XQxswPRV+ehBwihUd5pK0cKyBCPr8CBmuE2uoj/JumGDpGrMQv
         B65pZTVJADCOg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ol7Ml-0005pG-A2; Wed, 19 Oct 2022 13:36:07 +0200
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
Subject: [PATCH v2 01/15] phy: qcom-qmp-pcie: sort device-id table
Date:   Wed, 19 Oct 2022 13:35:38 +0200
Message-Id: <20221019113552.22353-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019113552.22353-1-johan+linaro@kernel.org>
References: <20221019113552.22353-1-johan+linaro@kernel.org>
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

Sort the device-id table by compatible string to make it easier to find
and add new entries.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 7c81667dd968..4e5111d19692 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2282,17 +2282,17 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 
 static const struct of_device_id qmp_pcie_of_match_table[] = {
 	{
-		.compatible = "qcom,msm8998-qmp-pcie-phy",
-		.data = &msm8998_pciephy_cfg,
-	}, {
-		.compatible = "qcom,ipq8074-qmp-pcie-phy",
-		.data = &ipq8074_pciephy_cfg,
+		.compatible = "qcom,ipq6018-qmp-pcie-phy",
+		.data = &ipq6018_pciephy_cfg,
 	}, {
 		.compatible = "qcom,ipq8074-qmp-gen3-pcie-phy",
 		.data = &ipq8074_pciephy_gen3_cfg,
 	}, {
-		.compatible = "qcom,ipq6018-qmp-pcie-phy",
-		.data = &ipq6018_pciephy_cfg,
+		.compatible = "qcom,ipq8074-qmp-pcie-phy",
+		.data = &ipq8074_pciephy_cfg,
+	}, {
+		.compatible = "qcom,msm8998-qmp-pcie-phy",
+		.data = &msm8998_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sc8180x-qmp-pcie-phy",
 		.data = &sc8180x_pciephy_cfg,
@@ -2302,6 +2302,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sdm845-qmp-pcie-phy",
 		.data = &sdm845_qmp_pciephy_cfg,
+	}, {
+		.compatible = "qcom,sdx55-qmp-pcie-phy",
+		.data = &sdx55_qmp_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sm8250-qmp-gen3x1-pcie-phy",
 		.data = &sm8250_qmp_gen3x1_pciephy_cfg,
@@ -2311,9 +2314,6 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8250-qmp-modem-pcie-phy",
 		.data = &sm8250_qmp_gen3x2_pciephy_cfg,
-	}, {
-		.compatible = "qcom,sdx55-qmp-pcie-phy",
-		.data = &sdx55_qmp_pciephy_cfg,
 	}, {
 		.compatible = "qcom,sm8450-qmp-gen3x1-pcie-phy",
 		.data = &sm8450_qmp_gen3x1_pciephy_cfg,
-- 
2.37.3

