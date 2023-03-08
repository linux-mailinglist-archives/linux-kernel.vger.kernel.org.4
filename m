Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC686B07B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCHNAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCHNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:25 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 04:59:51 PST
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E20C3E36
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:50 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgC67PvzMrBx1;
        Wed,  8 Mar 2023 13:53:11 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgC29XbzMslsf;
        Wed,  8 Mar 2023 13:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279991;
        bh=09hYvgVw1FJAE0n/qOeP7u/y8kJU55y8cqSUIePfRzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2or7BpYTNcOQX8DbIyxe5ylAe4Ms17Y2d6rvBU40I/tEL4PTKvWJa3HdbLM3emcQ
         IhKZZHai9LHQeiv9SuaT3yGzvk3fVtZr5vrac40lvBH9JLC4rLdU3jlvTWr7eA1GDP
         zFl5dbOZRMx+tdH+qqtF4XsAXhA4efLGBTEB+2pU=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/25] arm64: dts: colibri-imx8x: Add separate pinctrl group for cs2
Date:   Wed,  8 Mar 2023 13:52:43 +0100
Message-Id: <20230308125300.58244-10-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add a separate pinctrl group for chip-select 2 for Colibri SPI. That way
one is able to use it separately.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index d4d748a93afc..2cc94589c36f 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -120,7 +120,7 @@ &usdhc2 {
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>,
-		    <&pinctrl_hog2>;
+		    <&pinctrl_hog2>, <&pinctrl_lpspi2_cs2>;
 
 	/* On-module touch pen-down interrupt */
 	pinctrl_ad7879_int: ad7879intgrp {
@@ -231,7 +231,6 @@ pinctrl_hog0: hog0grp {
 			   <IMX8QXP_CSI_D07_CI_PI_D09				0x61>,		/* SODIMM  65 */
 			   <IMX8QXP_CSI_PCLK_LSIO_GPIO3_IO00			0x20>,		/* SODIMM  96 */
 			   <IMX8QXP_ENET0_RGMII_RXC_LSIO_GPIO5_IO03		0x06000020>,	/* SODIMM  85 */
-			   <IMX8QXP_ENET0_RGMII_TXD3_LSIO_GPIO5_IO02		0x06000020>,	/* SODIMM  65 */
 			   <IMX8QXP_QSPI0A_DATA2_LSIO_GPIO3_IO11		0x20>,		/* SODIMM  69 */
 			   <IMX8QXP_QSPI0B_DATA0_LSIO_GPIO3_IO18		0x20>,		/* SODIMM  99 */
 			   <IMX8QXP_QSPI0B_DATA1_LSIO_GPIO3_IO19		0x20>,		/* SODIMM 105 */
@@ -327,6 +326,10 @@ pinctrl_lpspi2: lpspi2grp {
 			   <IMX8QXP_SPI2_SDO_ADMA_SPI2_SDO			0x06000040>;	/* SODIMM  92 */
 	};
 
+	pinctrl_lpspi2_cs2: lpspi2cs2grp {
+		fsl,pins = <IMX8QXP_ENET0_RGMII_TXD3_LSIO_GPIO5_IO02		0x21>;		/* SODIMM  65 */
+	};
+
 	/* Colibri UART_B */
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <IMX8QXP_FLEXCAN0_RX_ADMA_UART0_RTS_B		0x06000020>,	/* SODIMM  34 */
-- 
2.39.2

