Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3449C5B31F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiIIIkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiIIIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:40:07 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C04057A;
        Fri,  9 Sep 2022 01:40:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 08FCBDFEEB;
        Fri,  9 Sep 2022 01:40:02 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jOfxinHGLqyD; Fri,  9 Sep 2022 01:40:01 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662712801; bh=7XOsAdHYBhnNoeLgbZQgNt3Sni/vbGsQJoj/Z+aSHlA=;
        h=From:To:Cc:Subject:Date:From;
        b=PI1CYTS6iPsT5gQhYDMYO/pEGSvEziURpl8g7VPb7WGwBDs0fnA716zph2H2wi1pc
         TEZfM7/6KfpLvYG6hfcz0slUreBa/FhhBrnoIdAAcquSCO8q4SylwaDStK6Yd1yNVp
         Ctf00gDHx8Qi4DeqrgxUZ6tYHoPiw158TmldmKodHZjTAOsRLy350r6iiYCXGYSqe7
         QcDP3H1cpTKcMIovPT4NXOq3NNqu1Jk+nv3++mXi/++/nJSSqi7eFvIF3r2kTBdIz4
         rYl5MI5/IaaibqVcKsTUL8BVVD2595MM9oK3jQg0XoFvx9PKxrzECDIKsUBKZ33Kia
         +04sNHDyCHJDg==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        dev@lynxeye.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] arm64: dts: imx8mq: fix dtschema warning for imx7-csi
Date:   Fri,  9 Sep 2022 10:39:40 +0200
Message-Id: <20220909083940.1554887-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to dtschema for the csi bridge, compatible is an enum and
only one must be used. Fixing this removes the following warning:

compatible: 'oneOf' conditional failed, one must be fixed

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e9f0cdd10ab62..a348169c40f15 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1184,7 +1184,7 @@ csi1_mipi_ep: endpoint {
 			};
 
 			csi1: csi@30a90000 {
-				compatible = "fsl,imx8mq-csi", "fsl,imx7-csi";
+				compatible = "fsl,imx8mq-csi";
 				reg = <0x30a90000 0x10000>;
 				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MQ_CLK_CSI1_ROOT>;
@@ -1236,7 +1236,7 @@ csi2_mipi_ep: endpoint {
 			};
 
 			csi2: csi@30b80000 {
-				compatible = "fsl,imx8mq-csi", "fsl,imx7-csi";
+				compatible = "fsl,imx8mq-csi";
 				reg = <0x30b80000 0x10000>;
 				interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MQ_CLK_CSI2_ROOT>;
-- 
2.30.2

