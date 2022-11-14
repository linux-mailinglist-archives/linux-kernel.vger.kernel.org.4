Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82382627B87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiKNLHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiKNLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A7205EA;
        Mon, 14 Nov 2022 03:07:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6173860FC6;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7137C433D7;
        Mon, 14 Nov 2022 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424033;
        bh=O+BuwvcIR1ujubiKjZ/hxdoHFbephL6Vp4d7nMoXnMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsxDH8/WBWMXgYvDtlaGRmWS0oUfSyaZ25aI6Rb8PJLSqlGYnomEyiS5IczRsoucY
         G7dQYA03WEbJ8q8FlmFBtod/QoomYnopNUY+IOuQCz7LHHX4MoEtJRMAbzyo/Zu+ZC
         R1za8qhAurayOJFfE1zf4i2Dp34Qj52B5j7NV0kzOvUePRhNRtborEYW8Xiiwqf+zH
         Zad7n5XvweHBrD/Rfp5/MQQ2qQgy6fvdGJaAZe83Rai3sOR3UGt6n+5yi0aGTs8rNV
         vkt/vlTKVWexmlknaUJZIgbotEaFkhaSVF7a/R7YhTmPqHyeKu8P9kZb+HRkaC+wsL
         Cb5CPwUQy6ljQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIY-0001Eb-5l; Mon, 14 Nov 2022 12:06:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 05/22] phy: qcom-qmp-combo: drop unused DP PHY mode op
Date:   Mon, 14 Nov 2022 12:06:04 +0100
Message-Id: <20221114110621.4639-6-johan+linaro@kernel.org>
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

The set-mode operation is currently only used by the USB part of the
PHY so drop the corresponding callback from the DP PHY ops.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 13800c2243e1..cec487560fd7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2132,7 +2132,6 @@ static const struct phy_ops qmp_combo_dp_phy_ops = {
 	.calibrate	= qcom_qmp_dp_phy_calibrate,
 	.power_off	= qmp_combo_power_off,
 	.exit		= qmp_combo_exit,
-	.set_mode	= qmp_combo_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.37.4

