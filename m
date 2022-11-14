Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C659627BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiKNLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiKNLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E221804;
        Mon, 14 Nov 2022 03:07:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 536E4B80DF0;
        Mon, 14 Nov 2022 11:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1017C4FF15;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424034;
        bh=kJP38ZwmxY+SSFCvUPkMeWW5gEsGGyjDPb8h9yV4MwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQOKC8dVPTg2lM+avo5ZTFLkH4JKOPfbQ4OVzmh19AfMoNWCYbcQ939wb+3Un8QdL
         cNlObyxgSCbhywTqKZfWYPajGyA4PoFS3rJ5gFGZc7LVYvZ6aKhz4H8+kV0ixc0uqv
         HGmEnwrVRoobWE68xaMJXN+L97nbsEcG3jW8gjGtIR2AAs/asfeMMpQYWd69FfH+T5
         c4GOciXieH1EVeoMB+0iFrxCZ6XuSkYyyCzYpEAoBa+k6/FD7TE1tyetjE3fTAb6Xo
         9DGH2XgyK/ORWK84hg1ObEP/LwSPjQmEbFYg/qIXqy8geXayxx1kNNffsD6WUiyi5T
         MA8XaTmvd/fHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIZ-0001F6-0z; Mon, 14 Nov 2022 12:06:43 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 15/22] phy: qcom-qmp-combo: rename sc8280xp config
Date:   Mon, 14 Nov 2022 12:06:14 +0100
Message-Id: <20221114110621.4639-16-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221114110621.4639-1-johan+linaro@kernel.org>
References: <20221114110621.4639-1-johan+linaro@kernel.org>
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

In preparation for merging the USB and DP configurations, drop the
"combo" infix from the SC8280XP combined configuration for consistency
with the other platforms.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 50c011d23a9e..d3fd6bde4af5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1228,7 +1228,7 @@ static const struct qmp_phy_cfg sc8280xp_usb43dp_dp_cfg = {
 	.calibrate_dp_phy	= qcom_qmp_v4_dp_phy_calibrate,
 };
 
-static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_combo_cfg = {
+static const struct qmp_phy_combo_cfg sc8280xp_usb43dpphy_cfg = {
 	.usb_cfg		= &sc8280xp_usb43dp_usb_cfg,
 	.dp_cfg			= &sc8280xp_usb43dp_dp_cfg,
 };
@@ -2857,7 +2857,7 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
 	},
 	{
 		.compatible = "qcom,sc8280xp-qmp-usb43dp-phy",
-		.data = &sc8280xp_usb43dpphy_combo_cfg,
+		.data = &sc8280xp_usb43dpphy_cfg,
 	},
 	{
 		.compatible = "qcom,sdm845-qmp-usb3-dp-phy",
-- 
2.37.4

