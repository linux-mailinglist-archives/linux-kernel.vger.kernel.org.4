Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E2600CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiJQKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:42:05 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB886050B;
        Mon, 17 Oct 2022 03:42:02 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 79B3E40544;
        Mon, 17 Oct 2022 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666003320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRhkmMdr4kbCCbRWT2nxseEW8IW5jbRk7B4fVTibJzo=;
        b=CPUJvv//lfITZyJ3h2TOmcYP06VH82A3WnrTVmBE1RDxsohCQfYS/q5NWXx2jP2/S6KLPx
        t+aKoAypT6G5OGzS55hJmmCgsOMae4rpPll8R4BW2Yasw8whysfF84bt9VmqdExRBvTcSp
        w+jzwfEJEj9RCDjOWD1WKJo707Atty8=
Received: from frank-G5.. (fttx-pool-217.61.154.127.bambit.de [217.61.154.127])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id B6ABE406D6;
        Mon, 17 Oct 2022 10:41:59 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Vic Wu <vic.wu@mediatek.com>
Subject: [RFC v1 09/12] arm64: dts: mt7986: add crypto related device nodes
Date:   Mon, 17 Oct 2022 12:41:38 +0200
Message-Id: <20221017104141.7338-10-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017104141.7338-1-linux@fw-web.de>
References: <20221017104141.7338-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 4f24e7d5-e179-46df-b3f0-0312d410deba
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 1a6ae2f05afa..7e339f5ded59 100644
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
index e48846e18b04..aac129c6f295 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -206,6 +206,21 @@ trng: trng@1020f000 {
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

