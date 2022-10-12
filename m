Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908965FC258
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJLIvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJLIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:50:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C63876542;
        Wed, 12 Oct 2022 01:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A9261488;
        Wed, 12 Oct 2022 08:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552A1C4315B;
        Wed, 12 Oct 2022 08:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665564639;
        bh=L2r5Llz8bICSfAgFyovsSZ4B8gYdr24Rp3FuSWegNM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FH0mkLZeCGwM/4rZwPIcpyFuBWSaUnftGJvPP0pM+dwkH7tA8AUsMyoWIqE6HPaEq
         /lb91fXAl7I8G0fVmWtHAKwSu/tJpXnDR9amcWAilmOqvYS5dtcONCdmJ9xDrplPJD
         tkgUTduMMP8NQCVAKce3H1ZtRl82ZnschU/3AJ3+YxyQuHplYWWN8ymP+0vpaoLB9m
         9TrZwEUaSMGRUarpZP4xSUnYRuQKv18MVYMNikMZWfiOjGAmqmpXiKJzdB3n1hZQKu
         p969hvJJsoIFL7uUaSZ0C92wKaAjcOYZ4qLM40gurQMSy+nu4G2iZQJaiMjCpGlp+d
         /jc3VXO1rS/ZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oiXRe-0006Hv-Tu; Wed, 12 Oct 2022 10:50:30 +0200
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
Subject: [PATCH 10/20] phy: qcom-qmp-ufs: drop unused phy-status config
Date:   Wed, 12 Oct 2022 10:49:52 +0200
Message-Id: <20221012085002.24099-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221012085002.24099-1-johan+linaro@kernel.org>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
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

Drop the unused phy-status configuration mask which has never been used
for UFS PHYs.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 02931b82132f..1c7d8fc9b94a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -31,8 +31,6 @@
 /* QPHY_START_CONTROL bits */
 #define SERDES_START				BIT(0)
 #define PCS_START				BIT(1)
-/* QPHY_PCS_STATUS bit */
-#define PHYSTATUS				BIT(6)
 /* QPHY_PCS_READY_STATUS bit */
 #define PCS_READY				BIT(0)
 
@@ -548,8 +546,6 @@ struct qmp_phy_cfg {
 
 	unsigned int start_ctrl;
 	unsigned int pwrdn_ctrl;
-	/* bit offset of PHYSTATUS in QPHY_PCS_STATUS register */
-	unsigned int phy_status;
 
 	/* true, if PCS block has no separate SW_RESET register */
 	bool no_pcs_sw_reset;
@@ -668,7 +664,6 @@ static const struct qmp_phy_cfg msm8996_ufs_cfg = {
 
 	.start_ctrl		= SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 
 	.no_pcs_sw_reset	= true,
 };
@@ -692,7 +687,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 
 	.start_ctrl		= SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 
 	.no_pcs_sw_reset	= true,
 };
@@ -739,7 +733,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 
 	.start_ctrl		= SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 };
 
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
@@ -761,7 +754,6 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 
 	.start_ctrl		= SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 };
 
 static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
@@ -783,7 +775,6 @@ static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
 
 	.start_ctrl		= SERDES_START,
 	.pwrdn_ctrl		= SW_PWRDN,
-	.phy_status		= PHYSTATUS,
 };
 
 static void qmp_ufs_configure_lane(void __iomem *base,
-- 
2.35.1

