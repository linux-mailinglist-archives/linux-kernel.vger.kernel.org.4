Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A581E6006E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJQGvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJQGuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:50:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F14654644;
        Sun, 16 Oct 2022 23:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B2F4B80EBF;
        Mon, 17 Oct 2022 06:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B924BC433B5;
        Mon, 17 Oct 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665989440;
        bh=KHrQ1n0ZcTTSsUzPGNs73NDeWcbPJWAXEpqMTIB4g14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4FU4E0hIXvjFKKoOY5TVObdyGrA4+BPCvRpOrHD8oF4716q+reGzPqIL0TEVPFDS
         83DZPluW9oHHJyOyEjzAwHhdBr9NuKfSncpB7e1Tn9evtao8dgd/LJj7G40qTgFjMw
         bnYZy8iNmKZ0d569EHbzDIdv5hF3GvdhwUN5KmNBum3FZSy6/pIfKHu67E+y0NDEyz
         ulU5Ppb2Gxd46NDqNZ50ZGmRvT97bfvTkHcvhlGVrEtiXyXDs4mVV6AFsKEiNa9lst
         bcZ7J/VncLld3cQG09UbiM2GDZrrO3QqAxSn1FihfyofasX1/2xMPuhxY9yrn1V14A
         xbtxCfP/psvGQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okJxG-00057V-77; Mon, 17 Oct 2022 08:50:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 01/11] phy: qcom-qmp: fix obsolete lane comments
Date:   Mon, 17 Oct 2022 08:50:03 +0200
Message-Id: <20221017065013.19647-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017065013.19647-1-johan+linaro@kernel.org>
References: <20221017065013.19647-1-johan+linaro@kernel.org>
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
index 9807c4d935cd..8a2a35c0855b 100644
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
index 461f0b5d464a..707ec81c7a2a 100644
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
index f3f75eda01a6..e0408c423ac6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2319,7 +2319,7 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	qphy->cfg = cfg;
 	qphy->serdes = serdes;
 	/*
-	 * Get memory resources for each phy lane:
+	 * Get memory resources for the PHY:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
 	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
 	 * For single lane PHYs: pcs_misc (optional) -> 3.
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index c08d34ad1313..db5642e1f715 100644
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
index b84c0d4b5754..965e486ab87d 100644
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
2.37.3

