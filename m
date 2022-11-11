Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321CB625603
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiKKI6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiKKI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3997C8EC;
        Fri, 11 Nov 2022 00:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB495B8247D;
        Fri, 11 Nov 2022 08:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E053C4314E;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157043;
        bh=i+5rmFasy+HGgD2rie4c9TgbQa/4v2XZWs6Frs5NDiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRtsd4n+QyCas2kMMqxpJoyNk8OATXZQVT6PZJQKixJX+627i3conExRA9/Kh+9Py
         gxpvPDdz5XXy368p3ZzkwI5tJ2kuagtne2wThvBboFGV7P93aAfwzHpb9LC4+nSrHo
         2raRnE1QUXSfMnrQnVjwmMK8UXWv3mk23HwhVC6LBkr44zykaPR1qmHmqfZ9268D5A
         Jn6IizBfnuMOzA+G9hU5RAeFXKEDH+FDzGCisAv2Tee95x4k47vUm8eMdkoF6y4jHL
         pJ7TiIe1CGRbBZAWCkOUqxWqh+7r3vdshWVgmJs+EdjSM8Zdf9enPO8mMtioUtb2HF
         tpBbJrzb4ic/w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqJ-0002U2-9i; Fri, 11 Nov 2022 09:56:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/22] phy: qcom-qmp-combo: rename USB PHY ops
Date:   Fri, 11 Nov 2022 09:56:27 +0100
Message-Id: <20221111085643.9478-7-johan+linaro@kernel.org>
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

Add a "usb" infix to the USB PHY operation functions and name them
after the corresponding operations (e.g. "init" rather than "enable").

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

