Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFC6255F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiKKI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKKI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DE87C8EC;
        Fri, 11 Nov 2022 00:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 562D061EFD;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AC8C43162;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=UcjQPB9m1Y/nqixRql/KGV5QHSLIloXxZBPzAAJt1eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxDnJheg/YmYxRIQJfUkUj4qVyKalxgGT27Fvr4wfAPP6SMAPYly3BjLR5ES59b1Y
         U6eX2/ZH4tyxfxGJeIX39eUgD83JKRrjlv6LE/Ez2VKkw7fLyKNcj5ZKSuGOCn+b+b
         6xJRxrh2k4epKNbBvm7WxbgFLp77C/mYFzcgiVkOsrElk1vZNvPmA1RlhM/nByi7Cz
         NX784g06yky8g/DCyvd8yoetlG82kz5avkVWzziKwTMiaJQ74etK9RbY0seRWeJWZ8
         P6yBvvOrS7G+D0EimD3TEut1OOWEFUeqNiLeBE4TNrFgfhT+iC3v77r7W2Qmw4Lv4g
         JpCujZxRRxkHg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002UA-In; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 09/22] phy: qcom-qmp-combo: rename DP PHY ops
Date:   Fri, 11 Nov 2022 09:56:30 +0100
Message-Id: <20221111085643.9478-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111085643.9478-1-johan+linaro@kernel.org>
References: <20221111085643.9478-1-johan+linaro@kernel.org>
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

Rename the configure and calibrate DP PHY ops using the common prefix
for consistency.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 5d985195df38..7392ae460fd7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1842,7 +1842,7 @@ static int qcom_qmp_v4_dp_phy_calibrate(struct qmp_phy *qphy)
 	return 0;
 }
 
-static int qcom_qmp_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
+static int qmp_combo_dp_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	const struct phy_configure_opts_dp *dp_opts = &opts->dp;
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
@@ -1857,7 +1857,7 @@ static int qcom_qmp_dp_phy_configure(struct phy *phy, union phy_configure_opts *
 	return 0;
 }
 
-static int qcom_qmp_dp_phy_calibrate(struct phy *phy)
+static int qmp_combo_dp_calibrate(struct phy *phy)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qphy->cfg;
@@ -2127,9 +2127,9 @@ static const struct phy_ops qmp_combo_usb_phy_ops = {
 
 static const struct phy_ops qmp_combo_dp_phy_ops = {
 	.init		= qmp_combo_dp_init,
-	.configure	= qcom_qmp_dp_phy_configure,
+	.configure	= qmp_combo_dp_configure,
 	.power_on	= qmp_combo_power_on,
-	.calibrate	= qcom_qmp_dp_phy_calibrate,
+	.calibrate	= qmp_combo_dp_calibrate,
 	.power_off	= qmp_combo_power_off,
 	.exit		= qmp_combo_dp_exit,
 	.owner		= THIS_MODULE,
-- 
2.37.4

