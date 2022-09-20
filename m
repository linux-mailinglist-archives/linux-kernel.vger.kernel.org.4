Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6765BDE88
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiITHkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiITHjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF661108;
        Tue, 20 Sep 2022 00:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5CF1B82577;
        Tue, 20 Sep 2022 07:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647D2C4167D;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=zOdQjnl5TA8CaiEtXPoNIzijrF9o1v8X4pqZ69iwdbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lu75lqXnQabIcVhKwUHULYueqhIK64GVttShUA6aE8ytKLIfDKhSguBUjTLjotASE
         EACQWTsehJXqOJlOvuiNmvRmtoIepsGlRzejOQA5daoE/in2rXBLI5ToDFzPvknvuc
         I2WsI09JctKYRAfe74EcrJZd6M61dHW3c45+tedJ0OBnEaHIpbtx4QVl3TBfaDYgsZ
         9698U85pAaw0kLI5x8yH8TE6lfQG3jRNnDlcrMudMGUd030u+Jd1SiAKaHZWxap5nq
         cqK8VrgNGoZPRDYLt3yajf8a9c0mTaqNrvktZEuukifqwAS+sYmk11OPFpcdpmF4RG
         /BfcPEnIZNrXQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqQ-0005R7-7l; Tue, 20 Sep 2022 09:39:02 +0200
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
Subject: [PATCH 11/17] phy: qcom-qmp: drop unused index field
Date:   Tue, 20 Sep 2022 09:38:20 +0200
Message-Id: <20220920073826.20811-12-johan+linaro@kernel.org>
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

Only the MSM8996 PCIe QMP driver uses the index field so drop it from
the other drivers.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c  | 3 ---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c   | 3 ---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c   | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 41f938126ff1..08e96e383a29 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -906,7 +906,6 @@ struct qmp_phy_combo_cfg {
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pcs_usb: iomapped memory space for lane's pcs_usb
  * @pipe_clk: pipe clock
- * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  * @mode: current PHY mode
  * @dp_aux_cfg: Display port aux config
@@ -925,7 +924,6 @@ struct qmp_phy {
 	void __iomem *pcs_misc;
 	void __iomem *pcs_usb;
 	struct clk *pipe_clk;
-	unsigned int index;
 	struct qcom_qmp *qmp;
 	enum phy_mode mode;
 	unsigned int dp_aux_cfg;
@@ -2779,7 +2777,6 @@ static int qmp_combo_create(struct device *dev, struct device_node *np, int id,
 	}
 
 	qphy->phy = generic_phy;
-	qphy->index = id;
 	qphy->qmp = qmp;
 	qmp->phys[id] = qphy;
 	phy_set_drvdata(generic_phy, qphy);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index d22d2cf2fc18..387abed33727 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1371,7 +1371,6 @@ struct qmp_phy_cfg {
  * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pipe_clk: pipe clock
- * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  */
 struct qmp_phy {
@@ -1385,7 +1384,6 @@ struct qmp_phy {
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
-	unsigned int index;
 	struct qcom_qmp *qmp;
 };
 
@@ -2264,7 +2262,6 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	}
 
 	qphy->phy = generic_phy;
-	qphy->index = id;
 	qphy->qmp = qmp;
 	qmp->phys[id] = qphy;
 	phy_set_drvdata(generic_phy, qphy);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index cc49dec46df4..ca9a42250556 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -580,7 +580,6 @@ struct qmp_phy_cfg {
  * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
  * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
  * @pcs_misc: iomapped memory space for lane's pcs_misc
- * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  */
 struct qmp_phy {
@@ -593,7 +592,6 @@ struct qmp_phy {
 	void __iomem *tx2;
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
-	unsigned int index;
 	struct qcom_qmp *qmp;
 };
 
@@ -1149,7 +1147,6 @@ static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
 	}
 
 	qphy->phy = generic_phy;
-	qphy->index = id;
 	qphy->qmp = qmp;
 	qmp->phys[id] = qphy;
 	phy_set_drvdata(generic_phy, qphy);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 820062a95211..a34320738f60 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1491,7 +1491,6 @@ struct qmp_phy_cfg {
  * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pcs_usb: iomapped memory space for lane's pcs_usb
  * @pipe_clk: pipe clock
- * @index: lane index
  * @qmp: QMP phy to which this lane belongs
  * @mode: current PHY mode
  */
@@ -1507,7 +1506,6 @@ struct qmp_phy {
 	void __iomem *pcs_misc;
 	void __iomem *pcs_usb;
 	struct clk *pipe_clk;
-	unsigned int index;
 	struct qcom_qmp *qmp;
 	enum phy_mode mode;
 };
@@ -2648,7 +2646,6 @@ int qmp_usb_create(struct device *dev, struct device_node *np, int id,
 	}
 
 	qphy->phy = generic_phy;
-	qphy->index = id;
 	qphy->qmp = qmp;
 	qmp->phys[id] = qphy;
 	phy_set_drvdata(generic_phy, qphy);
-- 
2.35.1

