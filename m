Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07535EF209
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiI2JaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiI2J33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:29:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B2D145964;
        Thu, 29 Sep 2022 02:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A304ACE20F5;
        Thu, 29 Sep 2022 09:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CCEC433C1;
        Thu, 29 Sep 2022 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664443763;
        bh=kro7aDlZROhupYv5MZjecCfiwnFNkfBZUEuYby/yjeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YI97mZfb169VX05+lNOg3+H7WS2L3bre/5RRB0YAfMnH4uwwgSq9U3htQfFPJth9G
         ODrICMFBZ+5pvfTWKNnBydOn9UExyX3sxv8nSk2ZHIqRZl8Bx0dFgRJoBrYtofSgrt
         ZbyFwfRBkqgJ6yvzSFlklklmcPQuD6TGP+SfwHh582HPt7STiY+/zWYpWep57gP6/T
         3XsAMIasmSDU7iRSL3S/gwaZZrRB4d29/nvLfKmyW7h2tAJa3Ib6ZlclBUXW+5gEBq
         KR1iRQX1LFb43piHbgY5Pv8GY1s+tf+9/8cm4Kob58kTsMkhVDtlZLdepKaNwDJxwt
         gt8xu6/xuKiAg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odprF-00061F-Ga; Thu, 29 Sep 2022 11:29:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 01/11] phy: qcom-qmp: fix obsolete lane comments
Date:   Thu, 29 Sep 2022 11:29:06 +0200
Message-Id: <20220929092916.23068-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220929092916.23068-1-johan+linaro@kernel.org>
References: <20220929092916.23068-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All QMP drivers but the MSM8996 and combo ones handle exactly one PHY
and the corresponding memory resources are not per-lane, but per PHY.

Update the obsolete comments.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index ad3b0aa22048..0cf1eb8a62f6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2669,7 +2669,7 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
-	 * Get memory resources for each phy lane:
+	 * Get memory resources for each PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 0f8e739936ab..d9646bf5dc91 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -777,7 +777,7 @@ static int qmp_pcie_msm8996_create(struct device *dev, struct device_node *np, i
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
-	 * Get memory resources for each phy lane:
+	 * Get memory resources for each PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 */
 	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 83fbbb446c9d..f4634af75890 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2201,7 +2201,7 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
-	 * Get memory resources for each phy lane:
+	 * Get memory resources for the PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index d21b977850b3..d7b35b715b95 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1094,7 +1094,7 @@ static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
-	 * Get memory resources for each phy lane:
+	 * Get memory resources for the PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index f01b3022a10d..f8685eddbf80 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2581,7 +2581,7 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
-	 * Get memory resources for each phy lane:
+	 * Get memory resources for the PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
-- 
2.35.1

