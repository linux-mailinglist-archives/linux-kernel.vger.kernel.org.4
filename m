Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A246B2EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCIUrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCIUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:47:32 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCFF1009FA;
        Thu,  9 Mar 2023 12:46:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AFA24E98D6;
        Thu,  9 Mar 2023 12:46:43 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yTl-O_6SIRfm; Thu,  9 Mar 2023 12:46:43 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394802; bh=/z2SwHM5vj5rYgK4KMzwRo5c5566eC1bvjTqbFPVqIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGXTb9It5o2xhSYvsdtVpyWPy2ii2d635wqrCzjlC9KG51BFvXXSwciG72bQjL90U
         FsWKco/lu9A/GuJUX8hPamvRyIfFg66nBi4LfbY8mZKbDJ1JDrNNNREaTK03X3USyY
         jqZxTK9NEbYraEcPdDi3y3ARbJK0+vddZIjnx/+E9rXs2rmoks0Bt39g0JlVSJslPQ
         LoSFv3J5Ri1obD4H9bAqrlPpejina+igOFXKseOLOiFEqu/dP63diXa455hXIE7G4o
         xHAUou3SKULBluBadiCmui/LEk+jRvMbHH59wwrn1jh0IlxSwg9kP1OabO/AqlPJ1g
         RIdqu2/MkJREg==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 04/14] arm64: dts: imx8mq-librem5: Describe MIC_2V4 regulator
Date:   Thu,  9 Mar 2023 21:45:58 +0100
Message-Id: <20230309204608.237605-5-martin.kepplinger@puri.sm>
In-Reply-To: <20230309204608.237605-1-martin.kepplinger@puri.sm>
References: <20230309204608.237605-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

No functional change, but it describes the hardware better.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 6c44af94ac02b..9f374da5c18aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -91,6 +91,14 @@ reg_aud_1v8: regulator-audio-1v8 {
 		enable-active-high;
 	};
 
+	reg_mic_2v4: regulator-mic-2v4 {
+		compatible = "regulator-fixed";
+		regulator-name = "MIC_2V4";
+		regulator-min-microvolt = <2400000>;
+		regulator-max-microvolt = <2400000>;
+		vin-supply = <&reg_aud_1v8>;
+	};
+
 	/*
 	 * the pinctrl for reg_csi_1v8 and reg_vcam_1v8 is added to the PMIC
 	 * since we can't have it twice in the 2 different regulator nodes.
@@ -1033,7 +1041,7 @@ codec: audio-codec@1a {
 		DBVDD-supply = <&reg_aud_1v8>;
 		AVDD-supply = <&reg_aud_1v8>;
 		CPVDD-supply = <&reg_aud_1v8>;
-		MICVDD-supply = <&reg_aud_1v8>;
+		MICVDD-supply = <&reg_mic_2v4>;
 		PLLVDD-supply = <&reg_aud_1v8>;
 		SPKVDD1-supply = <&reg_vsys_3v4>;
 		SPKVDD2-supply = <&reg_vsys_3v4>;
-- 
2.30.2

