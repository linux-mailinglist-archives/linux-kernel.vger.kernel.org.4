Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39497611367
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJ1NpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJ1Noy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:44:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41313F8A;
        Fri, 28 Oct 2022 06:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C197CB82A38;
        Fri, 28 Oct 2022 13:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D3AC43163;
        Fri, 28 Oct 2022 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964681;
        bh=ILxmO+luaNlHEkk+yA0QURG+N4WAyWonqKyVeubJWJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcYx8KXrZNl9Y6aSkV5am2QJsAArAwoAvHOtcAAkLk6FtZb7rku24ubOq0ewTTNIF
         UlilfuxZqCJRo6PLFXqUpnJIa/FjrDhOtXDef0vYyytsMoeNcCAMj/D+eovTU4X6Sz
         mtuL8p+y3FOqlTN3+JbXXpjxLQVUkf0gmSxkHDlgTjws0RpeyG2czgjvcV7A6DntNh
         BeN1k4hJ+qx9gYCgnLa9QEoJm8vVN8/XMjctksNuDs/8y4hW7zO0ZNNybn/oZbaxhA
         GV/eR+19Oc8pblClhQz0bPgTLPBByTTSB4oDQcsfhju3AAT0xGneFxyD6vO07o2Zue
         wXOCYiaDvMpDg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ooPet-00052M-Gf; Fri, 28 Oct 2022 15:44:27 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 08/13] phy: qcom-qmp-usb: rename PHY ops structure
Date:   Fri, 28 Oct 2022 15:44:02 +0200
Message-Id: <20221028134407.19300-9-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028134407.19300-1-johan+linaro@kernel.org>
References: <20221028134407.19300-1-johan+linaro@kernel.org>
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 2e603831e45e..4a7b961d2965 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -2149,6 +2149,13 @@ static int qmp_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	return 0;
 }
 
+static const struct phy_ops qmp_usb_phy_ops = {
+	.init		= qmp_usb_enable,
+	.exit		= qmp_usb_disable,
+	.set_mode	= qmp_usb_set_mode,
+	.owner		= THIS_MODULE,
+};
+
 static void qmp_usb_enable_autonomous_mode(struct qmp_usb *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -2366,13 +2373,6 @@ static int phy_pipe_clk_register(struct qmp_usb *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
-static const struct phy_ops qmp_usb_ops = {
-	.init		= qmp_usb_enable,
-	.exit		= qmp_usb_disable,
-	.set_mode	= qmp_usb_set_mode,
-	.owner		= THIS_MODULE,
-};
-
 static void __iomem *qmp_usb_iomap(struct device *dev, struct device_node *np,
 					int index, bool exclusive)
 {
@@ -2451,7 +2451,7 @@ static int qmp_usb_create(struct qmp_usb *qmp, struct device_node *np)
 				     "failed to get pipe clock\n");
 	}
 
-	generic_phy = devm_phy_create(dev, np, &qmp_usb_ops);
+	generic_phy = devm_phy_create(dev, np, &qmp_usb_phy_ops);
 	if (IS_ERR(generic_phy)) {
 		ret = PTR_ERR(generic_phy);
 		dev_err(dev, "failed to create PHY: %d\n", ret);
-- 
2.37.3

