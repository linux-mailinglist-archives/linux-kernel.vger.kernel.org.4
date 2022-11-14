Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547D8627B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiKNLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiKNLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2DF20BC3;
        Mon, 14 Nov 2022 03:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F042C61016;
        Mon, 14 Nov 2022 11:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D00C4315D;
        Mon, 14 Nov 2022 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424033;
        bh=3oKBVvbim8AnILN7ovfk5Q/WICjkxryDGKgk86VJ0wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ow1nNeFOTv3yxZwqzIwbFSZ3b+zPr4r2YVn82VeWPXR6Rmy895qmA6/1A5cxC3pBs
         bC1q4c9+sT9ddKSJnaRWUXikKOlQRig+vklMqugzLH1765+us6wbfF/WHgjG3NQgHG
         wo544QdP5RJ4oeIwIzkRUr388n51+G6crOM6btDgGj/XCGqEXGBTgeqHcnv4Vdo9SS
         v+dAlJgoS/i1lq73FiqgYcDqcAJPLkBCkcPiB9Vyt+1Uc7+w3FCILG3O2sXXUSDe+I
         2eI/0483wWhUadZWp9UdDlCijogTYLDB8VMIM/pxGB3c9p2wrc5pd1cd100wTPpVkn
         sxLEIVV0GvDYQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIY-0001Ed-8E; Mon, 14 Nov 2022 12:06:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 06/22] phy: qcom-qmp-combo: rename USB PHY ops
Date:   Mon, 14 Nov 2022 12:06:05 +0100
Message-Id: <20221114110621.4639-7-johan+linaro@kernel.org>
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

Add a "usb" infix to the USB PHY operation functions and name them
after the corresponding operations (e.g. "init" rather than "enable").

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index cec487560fd7..bf0874d22d91 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2084,7 +2084,7 @@ static int qmp_combo_exit(struct phy *phy)
 	return 0;
 }
 
-static int qmp_combo_enable(struct phy *phy)
+static int qmp_combo_usb_init(struct phy *phy)
 {
 	int ret;
 
@@ -2099,7 +2099,7 @@ static int qmp_combo_enable(struct phy *phy)
 	return ret;
 }
 
-static int qmp_combo_disable(struct phy *phy)
+static int qmp_combo_usb_exit(struct phy *phy)
 {
 	int ret;
 
@@ -2109,7 +2109,7 @@ static int qmp_combo_disable(struct phy *phy)
 	return qmp_combo_exit(phy);
 }
 
-static int qmp_combo_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+static int qmp_combo_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct qmp_phy *qphy = phy_get_drvdata(phy);
 
@@ -2119,9 +2119,9 @@ static int qmp_combo_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 }
 
 static const struct phy_ops qmp_combo_usb_phy_ops = {
-	.init		= qmp_combo_enable,
-	.exit		= qmp_combo_disable,
-	.set_mode	= qmp_combo_set_mode,
+	.init		= qmp_combo_usb_init,
+	.exit		= qmp_combo_usb_exit,
+	.set_mode	= qmp_combo_usb_set_mode,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.37.4

