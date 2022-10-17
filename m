Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E4E6006D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJQGuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJQGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB55419E;
        Sun, 16 Oct 2022 23:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5706060F3D;
        Mon, 17 Oct 2022 06:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B8EC433C1;
        Mon, 17 Oct 2022 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665989440;
        bh=T1ZmsQDoQl71w7+tlwothg2XEVQBeNpf9sx0BIeNoyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pI8H4eWP5Sbtt1KR/8ykdvOoO5KfL4f02kyfl7stJUfKZs9SnpKQQ2lfkT9TXcqb9
         3BDyrYAbfoGKPINunO2EGwmXd3BdIGWJ3rR/og9bDM9A9BLvEXVeEC8mlHSBkYtHMT
         oghu1CJYSrPw+cVsjBv/7lzLX6pSmfS6womHLLB9lBWYN2lx5E4UYYdTa0hIl6hS0l
         yYBfcfA05FW0Cb4T+P6EHYtZZ1yfOLrK2mEoMlBPTI6IyVuZNsEqIZjJlsbsVKFHXc
         l8Iiwmo2+3f/6rKJV4gsIKDk7KIouXsYlPDvTCJb4CciI+npugWkkubQ0LBtervQt/
         obpko8TwL+b0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okJxG-00057X-A1; Mon, 17 Oct 2022 08:50:30 +0200
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
Subject: [PATCH v3 02/11] phy: qcom-qmp-combo: drop unused UFS reset
Date:   Mon, 17 Oct 2022 08:50:04 +0200
Message-Id: <20221017065013.19647-3-johan+linaro@kernel.org>
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

Drop the unused UFS reset code which isn't used since the QMP driver
split.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 8a2a35c0855b..c21512b9ab52 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -944,7 +944,6 @@ struct qmp_phy_dp_clks {
  * @phys: array of per-lane phy descriptors
  * @phy_mutex: mutex lock for PHY common block initialization
  * @init_count: phy common block initialization count
- * @ufs_reset: optional UFS PHY reset handle
  */
 struct qcom_qmp {
 	struct device *dev;
@@ -958,8 +957,6 @@ struct qcom_qmp {
 
 	struct mutex phy_mutex;
 	int init_count;
-
-	struct reset_control *ufs_reset;
 };
 
 static void qcom_qmp_v3_phy_dp_aux_init(struct qmp_phy *qphy);
@@ -2027,8 +2024,6 @@ static int qmp_combo_com_exit(struct qmp_phy *qphy)
 		return 0;
 	}
 
-	reset_control_assert(qmp->ufs_reset);
-
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 
 	clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
@@ -2103,10 +2098,6 @@ static int qmp_combo_power_on(struct phy *phy)
 	else
 		qmp_combo_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
-	ret = reset_control_deassert(qmp->ufs_reset);
-	if (ret)
-		goto err_disable_pipe_clk;
-
 	if (cfg->has_pwrdn_delay)
 		usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
 
-- 
2.37.3

