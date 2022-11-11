Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB8625601
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiKKI6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiKKI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D97C8D0;
        Fri, 11 Nov 2022 00:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4FA2B8247C;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3520FC43158;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=tjdLAtpFKM7ActSSgOdENOYlJmZciCduoHtmcIoXW7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEfts/lOUnIqbp6hZybmadZpeiUsd9tuxdZZUPaapK1jbGyFr9qDVFSbNni8UFK3i
         RwvG6DQtVgypoleg8rhTdfuOKVAjQfZqR4da20BeERSjA9pOXIuiYsvSsePe558E9j
         3kTMYifIu81VDi1eEBeWOyfWmJAqt09r9+r/2Qo572+zbEMgVddu0cyDJeFAsf8YtJ
         fCpmCl2G+kFXz4tLj3JzF6jHSxl4aJ+Vz1JMDbaDdRyZBSkLFN/WV8rqMts6DU8Dvf
         QNCOE5kC1QEbLmXUMtx8XRsD2eEgVWvx4m0riCEs5NidB1tW5uqHBGDGbgOsNWUkoQ
         +MnWIsq09/9+g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002Tz-7X; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 05/22] phy: qcom-qmp-combo: drop unused DP PHY mode op
Date:   Fri, 11 Nov 2022 09:56:26 +0100
Message-Id: <20221111085643.9478-6-johan+linaro@kernel.org>
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

The set-mode operation is currently only used by the USB part of the
PHY so drop the corresponding callback from the DP PHY ops.

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

