Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9960DE46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiJZJhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiJZJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:37:05 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F45CBB383;
        Wed, 26 Oct 2022 02:37:04 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout4.routing.net (Postfix) with ESMTP id C13F010264B;
        Wed, 26 Oct 2022 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666777022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPaMmZqaVOBbVqc55wuqKdkhRgNoXT7scgWLMFxVc9s=;
        b=jft9/6FmV9Adsms6UtY7JVDmWilcTgttU9+dCUc01tNh1vRhuRRgMnXUYRAuQ66fxqLOLE
        73P4lGDaWePho4EGTa296J7d6iCDJFnT0W4g/X2UfCNsjFPHfxQ0AuU2XYs9MY0oC0YNfV
        7iS7rmYmGeWfwH5Dc56bS1PuCb16L+Y=
Received: from frank-G5.. (fttx-pool-80.245.72.174.bambit.de [80.245.72.174])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 01978803B1;
        Wed, 26 Oct 2022 09:37:01 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Vic Wu <vic.wu@mediatek.com>
Subject: [RFC v2 4/7] arm64: dts: mt7986: add crypto related device nodes
Date:   Wed, 26 Oct 2022 11:36:47 +0200
Message-Id: <20221026093650.110290-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026093650.110290-1-linux@fw-web.de>
References: <20221026093650.110290-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f18327e7-a19f-4daf-b55c-de53ec6234ad
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This patch adds crypto engine support for MT7986.

Signed-off-by: Vic Wu <vic.wu@mediatek.com>
Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts |  4 ++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 15 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index de5d771e5251..2b5d7ea31b4d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -43,6 +43,10 @@ reg_5v: regulator-5v {
 	};
 };
 
+&crypto {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 58bbecfbab98..1c7a973c28ca 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -205,6 +205,21 @@ trng: rng@1020f000 {
 			status = "disabled";
 		};
 
+		crypto: crypto@10320000 {
+			compatible = "inside-secure,safexcel-eip97";
+			reg = <0 0x10320000 0 0x40000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ring0", "ring1", "ring2", "ring3";
+			clocks = <&infracfg CLK_INFRA_EIP97_CK>;
+			clock-names = "infra_eip97_ck";
+			assigned-clocks = <&topckgen CLK_TOP_EIP_B_SEL>;
+			assigned-clock-parents = <&apmixedsys CLK_APMIXED_NET2PLL>;
+			status = "disabled";
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt7986-uart",
 				     "mediatek,mt6577-uart";
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index cd1763fa7f19..a98025112b5a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -43,6 +43,10 @@ reg_5v: regulator-5v {
 	};
 };
 
+&crypto {
+	status = "okay";
+};
+
 &eth {
 	status = "okay";
 
-- 
2.34.1

