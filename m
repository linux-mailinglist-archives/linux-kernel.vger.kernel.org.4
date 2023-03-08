Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C86B07C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCHNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjCHNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:37 -0500
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D04968D9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:57 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgC1QsmzMrSkP;
        Wed,  8 Mar 2023 13:53:11 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgB56d7zMslsN;
        Wed,  8 Mar 2023 13:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279991;
        bh=DdI7zz/2Af/iixDyboJAP4/caijuU/UOT9DWQlN4ET0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrMZO0xqJC/Ae4RjzPab9JrGaIfb6XXIJM+cpneZYl5a1AWglV+dQo0ssq8fWLrcK
         POLN4Ijsffjiv0g7qsJjVF1aCb4OTs0CTY9u1kBpYf4Zj/AkqfNyNGXOPMU0GCVx+5
         1tfMbYpFVr+1RZTngx8fjJuOx79aWtrmsgZ1Ywng=
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
Subject: [PATCH v1 08/25] arm64: dts: colibri-imx8x: Correct pull on lcdif
Date:   Wed,  8 Mar 2023 13:52:42 +0100
Message-Id: <20230308125300.58244-9-dev@pschenker.ch>
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

The pads USDHC1_RESET_B and MCLK_IN1 need a pull-down instead of
pull-disabled. Correct this.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 432449359625..d4d748a93afc 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -304,7 +304,7 @@ pinctrl_lcdif: lcdifgrp {
 			   <IMX8QXP_ESAI0_TX4_RX1_ADMA_LCDIF_D08		0x60>,		/* SODIMM  62 */
 			   <IMX8QXP_ESAI0_TX5_RX0_ADMA_LCDIF_D09		0x60>,		/* SODIMM  48 */
 			   <IMX8QXP_MCLK_IN0_ADMA_LCDIF_VSYNC			0x60>,		/* SODIMM  82 */
-			   <IMX8QXP_MCLK_IN1_ADMA_LCDIF_EN			0x60>,		/* SODIMM  44 */
+			   <IMX8QXP_MCLK_IN1_ADMA_LCDIF_EN			0x40>,		/* SODIMM  44 */
 			   <IMX8QXP_MCLK_OUT0_ADMA_LCDIF_CLK			0x60>,		/* SODIMM  56 */
 			   <IMX8QXP_SPDIF0_EXT_CLK_ADMA_LCDIF_D12		0x60>,		/* SODIMM  52 */
 			   <IMX8QXP_SPDIF0_RX_ADMA_LCDIF_D10			0x60>,		/* SODIMM  74 */
@@ -315,7 +315,7 @@ pinctrl_lcdif: lcdifgrp {
 			   <IMX8QXP_SPI3_SDI_ADMA_LCDIF_D15			0x60>,		/* SODIMM  64 */
 			   <IMX8QXP_SPI3_SDO_ADMA_LCDIF_D14			0x60>,		/* SODIMM  66 */
 			   <IMX8QXP_UART1_CTS_B_ADMA_LCDIF_D17			0x60>,		/* SODIMM  61 */
-			   <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19		0x60>,		/* SODIMM  44 */
+			   <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19		0x40>,		/* SODIMM  44 */
 			   <IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21			0x60>;		/* SODIMM  76 */
 	};
 
-- 
2.39.2

