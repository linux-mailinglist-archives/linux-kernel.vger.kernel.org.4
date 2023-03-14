Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DCF6B8FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCNK0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCNKZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:26 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D3F7F020
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:25:03 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4m0YLxzMqPNc;
        Tue, 14 Mar 2023 11:24:24 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4l4SJbz2MRr;
        Tue, 14 Mar 2023 11:24:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789463;
        bh=I0KeS8ugAQYe9CD2SmZqCUD+uUthjX5OaJZElwBkz60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zcn6rfFXQg8xqtwoS0HZLpSO0yRDZO5OQ9RPWaDIxFnKlcCYxKEGVU2wwNCj9v2np
         wX/TMsxAc+zKffj6XIsXKimwl5/bosn5IsMtJ/SByxPG/Ge4Tf2nxNzxeqOvmKfciU
         b7uKuMgK+sP/e5DATmRD8PWDBfyqHc0JMmDxSy+U=
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
Subject: [PATCH v2 05/23] arm64: dts: colibri-imx8x: Add pinctrl group for csi_mclk
Date:   Tue, 14 Mar 2023 11:23:51 +0100
Message-Id: <20230314102410.424773-6-dev@pschenker.ch>
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

Add missing pinctrl groups that can be used to enable the correct
muxing if csi_mclk is needed on SODIMM 75.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 5019439a3a75..a352246aa1f3 100644
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

