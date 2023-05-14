Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD5701C96
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjENJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjENJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:23:17 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F71FF3;
        Sun, 14 May 2023 02:23:14 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id A4B4C21320;
        Sun, 14 May 2023 11:23:11 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 3/4] arm64: dts: colibri-imx8x: fix iris pinctrl configuration
Date:   Sun, 14 May 2023 11:22:45 +0200
Message-Id: <20230514092246.9741-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230514092246.9741-1-francesco@dolcini.it>
References: <20230514092246.9741-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Remove GPIO3_IO10 from Iris carrier board pinctrl configuration,
this is already defined in the SOM dtsi since this is a
standard SOM functionality (wake-up button).

Duplicating it leads to the following error message
imx8qxp-pinctrl scu:pinctrl: pin IMX8QXP_QSPI0A_DATA1 already requested

Fixes: aefb5e2d974d ("arm64: dts: colibri-imx8x: Add iris carrier board")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: remove stray newline after Fixes: tag
---
 arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
index 5f30c88855e7..f8953067bc3b 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
@@ -48,8 +48,7 @@ pinctrl_gpio_iris: gpioirisgrp {
 			   <IMX8QXP_SAI0_TXFS_LSIO_GPIO0_IO28		0x20>,		/* SODIMM 101 */
 			   <IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27		0x20>,		/* SODIMM  97 */
 			   <IMX8QXP_ENET0_RGMII_RXC_LSIO_GPIO5_IO03	0x06000020>,	/* SODIMM  85 */
-			   <IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20>,		/* SODIMM  79 */
-			   <IMX8QXP_QSPI0A_DATA1_LSIO_GPIO3_IO10	0x06700041>;	/* SODIMM  45 */
+			   <IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20>;		/* SODIMM  79 */
 	};
 
 	pinctrl_uart1_forceoff: uart1forceoffgrp {
-- 
2.25.1

