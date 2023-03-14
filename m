Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9806B8FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCNKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCNKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:02 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9282EC14A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:30 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4n6YldzMqQFl;
        Tue, 14 Mar 2023 11:24:25 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4n34Mfz2MSK;
        Tue, 14 Mar 2023 11:24:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789465;
        bh=2xjbI6a1WqgCjyvEIZ/djew2Pp6WJIdI/TFBsRr1UDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LB8EZjRGirZRcvTLbpmKfRuubkUl34V/z00AQGdz6Zf9MpEAMOSvjRlpejBYcn+EA
         4e5FvsSYFXODsjjdpgfbfIVk6TH29dyvmOWlyZ2fvq8oTN+xSXq66kD1FJ3hxYu9tq
         NiuXNWdzXMilIOMovg4YHGliKG5YHMMNvnho/yh0=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/23] arm64: dts: colibri-imx8x: Add separate pinctrl group for cs2
Date:   Tue, 14 Mar 2023 11:23:54 +0100
Message-Id: <20230314102410.424773-9-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
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

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 26bf14cf5343..1d4e127ffa7e 100644
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
@@ -223,8 +223,7 @@ pinctrl_gpiokeys: gpiokeysgrp {
 	};
 
 	pinctrl_hog0: hog0grp {
-		fsl,pins = <IMX8QXP_ENET0_RGMII_TXD3_LSIO_GPIO5_IO02		0x06000020>,	/* SODIMM  65 */
-			   <IMX8QXP_CSI_D07_CI_PI_D09				0x61>,		/* SODIMM  65 */
+		fsl,pins = <IMX8QXP_CSI_D07_CI_PI_D09				0x61>,		/* SODIMM  65 */
 			   <IMX8QXP_QSPI0A_DATA2_LSIO_GPIO3_IO11		0x20>,		/* SODIMM  69 */
 			   <IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26			0x20>,		/* SODIMM  79 */
 			   <IMX8QXP_CSI_D02_CI_PI_D04				0x61>,		/* SODIMM  79 */
@@ -327,6 +326,10 @@ pinctrl_lpspi2: lpspi2grp {
 			   <IMX8QXP_SPI2_SCK_ADMA_SPI2_SCK			0x06000040>;	/* SODIMM  88 */
 	};
 
+	pinctrl_lpspi2_cs2: lpspi2cs2grp {
+		fsl,pins = <IMX8QXP_ENET0_RGMII_TXD3_LSIO_GPIO5_IO02		0x21>;		/* SODIMM  65 */
+	};
+
 	/* Colibri UART_B */
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <IMX8QXP_UART0_RX_ADMA_UART0_RX			0x06000020>,	/* SODIMM  36 */
-- 
2.39.2

