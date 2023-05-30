Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367EC715E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjE3MEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjE3MEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:04:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8F5F3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:04:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4r-0000BE-Gn; Tue, 30 May 2023 14:03:49 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4q-003rWb-PO; Tue, 30 May 2023 14:03:48 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4o-00C3uq-Ob; Tue, 30 May 2023 14:03:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 04/15] ARM: dts: imx6q: prtwd2: Correct iomux configuration for ENET MDIO and MDC
Date:   Tue, 30 May 2023 14:03:34 +0200
Message-Id: <20230530120345.2874900-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530120345.2874900-1-o.rempel@pengutronix.de>
References: <20230530120345.2874900-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

This commit addresses a misconfiguration in the prtwd2 device tree
source. Specifically, the ENET MDIO and MDC pins were mistakenly
assigned to the Ethernet block, while they are actually used by the I2C4
interface.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-prtwd2.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-prtwd2.dts b/arch/arm/boot/dts/imx6q-prtwd2.dts
index 54a57a4548e2..792b8903d345 100644
--- a/arch/arm/boot/dts/imx6q-prtwd2.dts
+++ b/arch/arm/boot/dts/imx6q-prtwd2.dts
@@ -156,9 +156,6 @@ MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x1b0b0
 			MX6QDL_PAD_CSI0_DAT4__GPIO5_IO22	0x1b0b0
 			/* nINTRP */
 			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23	0x1b0b0
-
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x10030
-			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x10030
 		>;
 	};
 
-- 
2.39.2

