Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7850F5B8CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiINQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiINQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:26:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732237D7A1;
        Wed, 14 Sep 2022 09:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A4E9B8171A;
        Wed, 14 Sep 2022 16:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04CCC4315B;
        Wed, 14 Sep 2022 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663172798;
        bh=fzSBWqAV/KoAW+IM7FR2klj1KXJLCORvoez5yC2eol4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCYFvcvsouLftsvnw22RTKlQ1SxZmOENXG6zPOwvdXrIQB9pGh+Xn8FTKb7nSttT/
         oZc28O0eVbcH11RO+EyEFAiMFUhV6GjPBKDznp81Ysit6BweK/mjCCzH54wPhwe+Rz
         HmaFSpcN/2O1o4DjEWTi18eJsNzNS9JgSRIsvd31ROslEtSnfSc3yuljJgesNidyxW
         t9E1yw+ilKQKnP7cKFYNkdmqJ4mQwBPhCPRnfVFXB8XDPLonbgwwWum72ixFbSKL7m
         l5SPM27Fp9Unm9syWmv+JOB/AVfWMOqN+eW7QUeecVD66cnLslXeN4VV3h/QhQLUG7
         0YrLFkcbeQ4OA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oYVDk-0001el-0q; Wed, 14 Sep 2022 18:26:40 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 07/11] phy: qcom-qmp-pcie-msm8996: drop unused pcs_misc handling
Date:   Wed, 14 Sep 2022 18:25:41 +0200
Message-Id: <20220914162545.6289-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220914162545.6289-1-johan+linaro@kernel.org>
References: <20220914162545.6289-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8996 QMP PHY driver does not use the PCS_MISC IO region (and
neither do the DT binding specify it) so remove the corresponding code
from the driver.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index 6664d84bb599..245f6dc1710e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -202,8 +202,6 @@ struct qmp_phy_cfg {
 	int rx_tbl_num;
 	const struct qmp_phy_init_tbl *pcs_tbl;
 	int pcs_tbl_num;
-	const struct qmp_phy_init_tbl *pcs_misc_tbl;
-	int pcs_misc_tbl_num;
 
 	/* clock ids to be requested */
 	const char * const *clk_list;
@@ -240,7 +238,6 @@ struct qmp_phy_cfg {
  * @tx: iomapped memory space for lane's tx
  * @rx: iomapped memory space for lane's rx
  * @pcs: iomapped memory space for lane's pcs
- * @pcs_misc: iomapped memory space for lane's pcs_misc
  * @pipe_clk: pipe clock
  * @index: lane index
  * @qmp: QMP phy to which this lane belongs
@@ -254,7 +251,6 @@ struct qmp_phy {
 	void __iomem *tx;
 	void __iomem *rx;
 	void __iomem *pcs;
-	void __iomem *pcs_misc;
 	struct clk *pipe_clk;
 	unsigned int index;
 	struct qcom_qmp *qmp;
@@ -523,7 +519,6 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
 	void __iomem *tx = qphy->tx;
 	void __iomem *rx = qphy->rx;
 	void __iomem *pcs = qphy->pcs;
-	void __iomem *pcs_misc = qphy->pcs_misc;
 	void __iomem *status;
 	unsigned int mask, val, ready;
 	int ret;
@@ -552,9 +547,6 @@ static int qmp_pcie_msm8996_power_on(struct phy *phy)
 
 	qmp_pcie_msm8996_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
-	qmp_pcie_msm8996_configure(pcs_misc, cfg->regs, cfg->pcs_misc_tbl,
-			       cfg->pcs_misc_tbl_num);
-
 	/*
 	 * Pull out PHY from POWER DOWN state.
 	 * This is active low enable signal to power-down PHY.
@@ -793,8 +785,6 @@ static int qmp_pcie_msm8996_create(struct device *dev, struct device_node *np, i
 	/*
 	 * Get memory resources for each phy lane:
 	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
-	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
-	 * For single lane PHYs: pcs_misc (optional) -> 3.
 	 */
 	qphy->tx = devm_of_iomap(dev, np, 0, NULL);
 	if (IS_ERR(qphy->tx))
@@ -808,10 +798,6 @@ static int qmp_pcie_msm8996_create(struct device *dev, struct device_node *np, i
 	if (IS_ERR(qphy->pcs))
 		return PTR_ERR(qphy->pcs);
 
-	qphy->pcs_misc = devm_of_iomap(dev, np, 3, NULL);
-	if (IS_ERR(qphy->pcs_misc))
-		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
-
 	qphy->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
 	if (IS_ERR(qphy->pipe_clk)) {
 		return dev_err_probe(dev, PTR_ERR(qphy->pipe_clk),
-- 
2.35.1

