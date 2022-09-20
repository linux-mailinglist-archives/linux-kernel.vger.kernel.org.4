Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0C5BDE66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiITHjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiITHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330660522;
        Tue, 20 Sep 2022 00:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD1362441;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D0EC433B5;
        Tue, 20 Sep 2022 07:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663659539;
        bh=ja9XqDAmZ5CFMR6H8RvNH8uNGTVJF/3Unra5I3v55cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8xgu2B74jte4blFCGoySWzInTORniHueikbkE1ZEsVPHkWmy9PgqFVJaZWG9V+dF
         Mru2NFKEw492A95chuuAje0n3VX9+dqrNefLk9fhxPUN9uvgH90KMTVEt/LykWiejf
         oyNcKcrIT9SUyxx7Vg+y86cs3K4VGGD/PLBsWE4EDAYBPSFl+u7lwNU1XYNdHtFdn8
         0ZpGiLaCA0S7qh+LYJ1WirYcVo4qkaLiBB4Z+VBO0Ply8WI2oX/Z4CMnc0o3kW0zzU
         Ill/8q4UB2syRmiI0wjz11wXJ9n4evrjpo8sh8iFvPJOxqmSwWEAVsjMQRaJnZ/HdD
         HYFaq5T6AYhhQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaXqP-0005Qi-Gc; Tue, 20 Sep 2022 09:39:01 +0200
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
Subject: [PATCH 03/17] phy: qcom-qmp-ufs: drop unused type from config
Date:   Tue, 20 Sep 2022 09:38:12 +0200
Message-Id: <20220920073826.20811-4-johan+linaro@kernel.org>
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

The configuration PHY type is no longer used since the QMP driver split
so drop it from the configuration.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 7b335b50b4a1..e5c8d3a4fdaa 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -535,8 +535,6 @@ struct qmp_phy;
 
 /* struct qmp_phy_cfg - per-PHY initialization config */
 struct qmp_phy_cfg {
-	/* phy-type - PCIE/UFS/USB */
-	unsigned int type;
 	/* number of lanes provided by phy */
 	int nlanes;
 
@@ -668,7 +666,6 @@ static const char * const qmp_phy_vreg_l[] = {
 };
 
 static const struct qmp_phy_cfg msm8996_ufs_cfg = {
-	.type			= PHY_TYPE_UFS,
 	.nlanes			= 1,
 
 	.serdes_tbl		= msm8996_ufs_serdes_tbl,
@@ -694,7 +691,6 @@ static const struct qmp_phy_cfg msm8996_ufs_cfg = {
 };
 
 static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
-	.type			= PHY_TYPE_UFS,
 	.nlanes			= 2,
 
 	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
@@ -720,7 +716,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
-	.type			= PHY_TYPE_UFS,
 	.nlanes			= 1,
 
 	.serdes_tbl		= sm6115_ufsphy_serdes_tbl,
@@ -744,7 +739,6 @@ static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
-	.type			= PHY_TYPE_UFS,
 	.nlanes			= 2,
 
 	.serdes_tbl		= sm8150_ufsphy_serdes_tbl,
@@ -769,7 +763,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
-	.type			= PHY_TYPE_UFS,
 	.nlanes			= 2,
 
 	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
@@ -794,7 +787,6 @@ static const struct qmp_phy_cfg sm8350_ufsphy_cfg = {
 };
 
 static const struct qmp_phy_cfg sm8450_ufsphy_cfg = {
-	.type			= PHY_TYPE_UFS,
 	.nlanes			= 2,
 
 	.serdes_tbl		= sm8350_ufsphy_serdes_tbl,
-- 
2.35.1

