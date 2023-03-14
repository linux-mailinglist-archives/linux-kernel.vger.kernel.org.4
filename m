Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F367A6B8FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCNKZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCNKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:00 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA60D9BE29
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:28 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4n2FcRzMqQGx;
        Tue, 14 Mar 2023 11:24:25 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4m5cgrz2N3w;
        Tue, 14 Mar 2023 11:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789465;
        bh=+onK7eaGZ380BYytwnmLdj2VsO+vJYYJ0pcAXmCDRfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRjiPwcfZZ8Qo7EL+fb94f8qOiWDvtu3U2sBdAl6X4s5SVgpq38m2/piy5u3q9RA9
         2UlRZC+Rh7hYApN8aJs9UQSih3W4WdvTOtLe5BKkYLdJeHY0J8vZtbWQ9ao/i9Rp49
         yjglz+EC3Andzl02sxS0fft3/A8vkYupayQx+J+c=
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
Subject: [PATCH v2 07/23] arm64: dts: colibri-imx8x: Correct pull on lcdif
Date:   Tue, 14 Mar 2023 11:23:53 +0100
Message-Id: <20230314102410.424773-8-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 10dce84dc153..26bf14cf5343 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -295,8 +295,8 @@ pinctrl_lcdif: lcdifgrp {
 		fsl,pins = <IMX8QXP_MCLK_OUT0_ADMA_LCDIF_CLK			0x60>,		/* SODIMM  56 */
 			   <IMX8QXP_SPI3_CS0_ADMA_LCDIF_HSYNC			0x60>,		/* SODIMM  68 */
 			   <IMX8QXP_MCLK_IN0_ADMA_LCDIF_VSYNC			0x60>,		/* SODIMM  82 */
-			   <IMX8QXP_MCLK_IN1_ADMA_LCDIF_EN			0x60>,		/* SODIMM  44 */
-			   <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19		0x60>,		/* SODIMM  44 */
+			   <IMX8QXP_MCLK_IN1_ADMA_LCDIF_EN			0x40>,		/* SODIMM  44 */
+			   <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19		0x40>,		/* SODIMM  44 */
 			   <IMX8QXP_ESAI0_FSR_ADMA_LCDIF_D00			0x60>,		/* SODIMM  76 */
 			   <IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21			0x60>,		/* SODIMM  76 */
 			   <IMX8QXP_ESAI0_FST_ADMA_LCDIF_D01			0x60>,		/* SODIMM  70 */
-- 
2.39.2

