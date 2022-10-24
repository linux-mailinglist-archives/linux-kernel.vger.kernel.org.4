Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD3609D61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJXJCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiJXJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37A53FA10;
        Mon, 24 Oct 2022 02:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22800CE11E3;
        Mon, 24 Oct 2022 09:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF7C43140;
        Mon, 24 Oct 2022 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602097;
        bh=Tmh6pbvKpEc0/eNCkRs724u74bdzB1yjPkgJEJk9y9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHEk0KKMkMiHpQe3w3rT7WYhnEGnTXW+mVHEo9TmKYvbOrw+cHSBW1Wmw3dhrXHTv
         6yxYd+9WRqENiFr7/6oYDQzY+b/SbmLh36Chk3tv4CalCCwk/ib7zOo7BSwD8dokQr
         cwtUrZjJqWgjXAGMeUZUs4JEzpViRa4KGcC9fzlg8e2+vAOENgYp9i5k5kcTniCZ0Z
         e+74HtyeXhkstvDz1O9beziqkyjGi69C4TVUAViBNZMa9otuHqrYxydAKyunqZ6jWn
         kgPWda7XE106CABlC8tLmVRSg8iCLXuujN6Zoy+0I8fxkaEa6j5Da80ENNLow3OQNL
         aMdlABSt5cD6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKj-00056X-E1; Mon, 24 Oct 2022 11:01:21 +0200
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
Subject: [PATCH 05/10] phy: qcom-qmp-ufs: rename PHY ops structure
Date:   Mon, 24 Oct 2022 11:00:36 +0200
Message-Id: <20221024090041.19574-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the PHY operation structure so that it has a "phy_ops" suffix and
move it next to the implementation.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 057f9a3fdd6d..90583b87efd1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -945,6 +945,12 @@ static int qmp_ufs_disable(struct phy *phy)
 	return qmp_ufs_exit(phy);
 }
 
+static const struct phy_ops qcom_qmp_ufs_phy_ops = {
+	.power_on	= qmp_ufs_enable,
+	.power_off	= qmp_ufs_disable,
+	.owner		= THIS_MODULE,
+};
+
 static int qmp_ufs_vreg_init(struct qmp_ufs *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -979,12 +985,6 @@ static int qmp_ufs_clk_init(struct qmp_ufs *qmp)
 	return devm_clk_bulk_get(dev, num, qmp->clks);
 }
 
-static const struct phy_ops qcom_qmp_ufs_ops = {
-	.power_on	= qmp_ufs_enable,
-	.power_off	= qmp_ufs_disable,
-	.owner		= THIS_MODULE,
-};
-
 static int qmp_ufs_create(struct qmp_ufs *qmp, struct device_node *np)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -1027,7 +1027,7 @@ static int qmp_ufs_create(struct qmp_ufs *qmp, struct device_node *np)
 	if (IS_ERR(qmp->pcs_misc))
 		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
 
-	generic_phy = devm_phy_create(dev, np, &qcom_qmp_ufs_ops);
+	generic_phy = devm_phy_create(dev, np, &qcom_qmp_ufs_phy_ops);
 	if (IS_ERR(generic_phy)) {
 		ret = PTR_ERR(generic_phy);
 		dev_err(dev, "failed to create PHY: %d\n", ret);
-- 
2.37.3

