Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988F6B081C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCHNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjCHNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:12:48 -0500
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70237C80AE;
        Wed,  8 Mar 2023 05:10:00 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsg96jYjzMrTBT;
        Wed,  8 Mar 2023 13:53:09 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsg934QyzMslsG;
        Wed,  8 Mar 2023 13:53:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279989;
        bh=Q1nzKQ150Q4X0uS6VSJZfX77+4AiYSqc1/pfiBJryZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mweahVRWrc7rNpBJX2Bv9tN4fYxgIJ/9wktrXK3aTMkyfhLzB+y1kgQhjpTOlt5YD
         P7UzOXtoPBO2MfYdUkFp4h4qYUHhVC8ZRchk0yRbdPLQ3fWbtsQ22Idb4kBWVuaCE7
         ea+eXy5MquFBR/orW8EU6AUrXFIoA9wmdio3OAfc=
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
Subject: [PATCH v1 06/25] arm64: dts: colibri-imx8x: Add pinctrl group for csi_mclk
Date:   Wed,  8 Mar 2023 13:52:40 +0100
Message-Id: <20230308125300.58244-7-dev@pschenker.ch>
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

Add missing pinctrl groups that can be used to enable the correct
muxing if csi_mclk is needed on SODIMM 75.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 0b84b65c846a..e1b907b7a85d 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -159,6 +159,10 @@ pinctrl_csi_ctl: csictlgrp {
 			   <IMX8QXP_QSPI0A_SS1_B_LSIO_GPIO3_IO15		0x20>;		/* SODIMM  89 */
 	};
 
+	pinctrl_csi_mclk: csimclkgrp {
+		fsl,pins = <IMX8QXP_CSI_MCLK_CI_PI_MCLK				0xC0000041>;	/* SODIMM  75 / X3-12 */
+	};
+
 	pinctrl_ext_io0: extio0grp {
 		fsl,pins = <IMX8QXP_ENET0_RGMII_RXD3_LSIO_GPIO5_IO08		0x06000040>;	/* SODIMM 135 */
 	};
-- 
2.39.2

