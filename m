Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA96F6255F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiKKI5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiKKI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DDE7E984;
        Fri, 11 Nov 2022 00:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83BC161F02;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC652C4FF0D;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=2e1sFaescafNae6TCenVsXtXuc6P0oDVvqweiOwbJuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJF31Wlts6vDFKHbmP8+/NrGyWGC1rKSlhmvQUsixCS/uRKYFBu8jL4h6v1R3XqG3
         JHAj3Dc+avslOLqKyqKr8DED6FKmSQa0fsN/03KLaXK4kKoHCoOsxIUc2rF9nRCOBz
         b0V0yyBepzAjkh0fCEOiTtrvb3LuWxiH7totaznXzdYu7Sy+kj6THycudS5m7J9rZq
         BRG65UWIdt1IPYqE9FfLmHlKNvDhzkV0uki7Wvhngn+PScmF6SwXBuyoWyXopMMIFQ
         OI5sK9KZagFrFyio9XER/dUT10gp0jB0bnLvmvhJc97oahjzsZEdukoX9b0A5rngKP
         UXHSFtzKE9UYw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqK-0002UU-3W; Fri, 11 Nov 2022 09:56:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 15/22] phy: qcom-qmp-combo: rename sc8280xp config
Date:   Fri, 11 Nov 2022 09:56:36 +0100
Message-Id: <20221111085643.9478-16-johan+linaro@kernel.org>
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

In preparation for merging the USB and DP configurations, drop the
"combo" infix from the SC8280XP combined configuration for consistency
with the other platforms.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c01cedda221c..499368e19e00 100644
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
@@ -2858,7 +2858,7 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
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

