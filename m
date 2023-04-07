Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281B6DAAFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbjDGJfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbjDGJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:34:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BD69764
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:34:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so41833887wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680860070; x=1683452070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KFcOYEAi46ZIl7QCtzcN5XD6VlwA2hJvytxtJEenkQ=;
        b=rC8CFk78Ear9yw17oS85VokG+Iofo1AOflOUpNSVcFrPRfhKZChYgbY6Lc0R8pO0/G
         IqeuRobc0vx2r+nYVnR6mn7zvus2uJjdS5yKMeGei6Uylo1BRVvuOcsZjWdKaTdTwKq0
         VAkCfLENFoIqZfkMuBrP6Lh1c1soi+HmmOBcEjx2p+3wzcDkBLw2MjNORRUytkavLRmK
         3blAnIADp7fkoWhhihP/damDXlGg+dmuuswb3j0JYJUWTH01az0CaXOSe8j8ySkNUxqj
         E7fGc5OfNwPyukrAwoxPiUzFvalAGSP5hiUTrUL6bIBdyoMPkjVm78cIVC0UPM6mKri9
         33eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860070; x=1683452070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KFcOYEAi46ZIl7QCtzcN5XD6VlwA2hJvytxtJEenkQ=;
        b=JjtJWAe5/RYuizKRFuXN0+hkVOT9IeGAKZcbWO5sl1FfD3HvJ0a6sfQ7USWIbvYOb4
         vzdk1A/mmcViit8jY3jWmbjyaGLMesODLnT/1ZWWnFGvKn68u1bXiJEWGofjCNNli/Sq
         kwUyI1u121ScVyKowAs8yjdQMGDTPcMoBJlQsJvzd5CcXEm/thytCveFxf5JaP+mBB9y
         cm5q47JA7S5FIWsciwsR6DPMMADAdtWc7cPk1vK84e3oOwtaRYiHNHP1icM+oYFiPSpu
         qfffYF/SHgPWlFW4qZT7B+hYW+SI6Bx4+NXJ/PgoSQihwds+kJo4DWvZnUepIHfuekfM
         2O0Q==
X-Gm-Message-State: AAQBX9fc0wuOd0ib9kb6688xxUSAlJPUJnQoagmPdWOokCIxTHoDqNt8
        GKTLEpa7+5/QCSsQ+ASIftSjCGdcqVmamyGo07Y=
X-Google-Smtp-Source: AKy350aG9du0uwosq+FqixFFe8BXT07SgAILsAGexfDRZ7ImSOnkQuzCW7B0NCut1ljngJTh+NOpxA==
X-Received: by 2002:a5d:69c8:0:b0:2ef:b341:4a2d with SMTP id s8-20020a5d69c8000000b002efb3414a2dmr605249wrw.24.1680860070539;
        Fri, 07 Apr 2023 02:34:30 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm4020432wrt.111.2023.04.07.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:34:30 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:34:15 +0200
Subject: [PATCH v3 4/7] arm64: dts: mediatek: add power domain support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v3-4-97e19ad4e85d@baylibre.com>
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
In-Reply-To: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4617; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=8SGgl6AnSEaP0TiVCLT5CLjF1FPWuK/os69MqWsUi8E=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL+OhYJB2BSSOnaWMDYSq5zrvNqXrrgEb/LQGOuDr
 XDl98PCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/joQAKCRArRkmdfjHURfwwEA
 CQXrE5TNxhv9xOA85ddxAywpvG6jv8pV5Eiy5GCVg9QUu+fCzZOjMd23dJyCqOgiPwHGwpTAbmCLco
 nfJaygKL70cBOElQTB+bkcDDyNmwa7yVbxU5fdFQNfA6gyASnf21NRskxCPnebZBHfRRY+U+pKGQAy
 OvrpoxdmY4e04GcN0V/LCXCT7GAQJOtar4fRJRwjXPh/e9qmLHm2Vanp6tDsV8zLkG48Xu+0492Kyn
 BdRX6qDKOuin6nC+vdkvS26MfdzelcqaB+DuhxJzgLYWSaAf/KQwKqNq4KyLJfxGveP3b3Ok89GgTg
 wy3WqwlsP8VSt4No7qqW3xaDQXmEuqmzHVlQekIgtVEeOT0N9gCit5iC+jUT4YM9giLkP9bRAPSP2S
 kgAwCEDS3MiLR85sb+EBreauTm7iIvrbzmOUXylDsjj9kjVAa/Pa8f97KiuXus1asSOYhUyP3/z/OP
 /x61gEjFyIpdFepotbTAT/xO5Crb0/6S7rEmf6YzNA5mtHOiiI8x3Mcsgrfihv05YkfAwqSFvpprER
 48Uo2aqssvj7DcXNeujgHi8cscdQn9vyev5HEHN0de614iriB1fjLd396gQ0QznL0n/QbgEpsiiWZf
 z1Zh9agJ9HI/o/6McjhJ2sy/TsUsTs3dMr6mvFukpx/mt5v7E2MGJ53a3sRw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following power domain are added to the SoC dts:
- MM (MultiMedia)
- CONN (Connectivity)
- MFG (MFlexGraphics)
- Audio
- Cam (Camera)
- DSP (Digital Signal Processor)
- Vdec (Video decoder)
- Venc (Video encoder)
- APU (AI Processor Unit)

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 110 +++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 386ab8902b55..0e4fa69a2415 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/mediatek,mt8365-power.h>
 
 / {
 	compatible = "mediatek,mt8365";
@@ -282,6 +283,115 @@ syscfg_pctl: syscfg-pctl@10005000 {
 			reg = <0 0x10005000 0 0x1000>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8365-syscfg", "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+			#power-domain-cells = <1>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8365-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domains of the SoC */
+				power-domain@MT8365_POWER_DOMAIN_MM {
+					reg = <MT8365_POWER_DOMAIN_MM>;
+					clocks = <&topckgen CLK_TOP_MM_SEL>,
+						 <&mmsys CLK_MM_MM_SMI_COMMON>,
+						 <&mmsys CLK_MM_MM_SMI_COMM0>,
+						 <&mmsys CLK_MM_MM_SMI_COMM1>,
+						 <&mmsys CLK_MM_MM_SMI_LARB0>;
+					clock-names = "mm", "mm-0", "mm-1",
+						      "mm-2", "mm-3";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+					mediatek,infracfg-nao = <&infracfg_nao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@MT8365_POWER_DOMAIN_CAM {
+						reg = <MT8365_POWER_DOMAIN_CAM>;
+						clocks = <&camsys CLK_CAM_LARB2>,
+							 <&camsys CLK_CAM_SENIF>,
+							 <&camsys CLK_CAMSV0>,
+							 <&camsys CLK_CAMSV1>,
+							 <&camsys CLK_CAM_FDVT>,
+							 <&camsys CLK_CAM_WPE>;
+						clock-names = "cam-0", "cam-1",
+							      "cam-2", "cam-3",
+							      "cam-4", "cam-5";
+						#power-domain-cells = <0>;
+						mediatek,infracfg = <&infracfg>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VDEC {
+						reg = <MT8365_POWER_DOMAIN_VDEC>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_VENC {
+						reg = <MT8365_POWER_DOMAIN_VENC>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8365_POWER_DOMAIN_APU {
+						reg = <MT8365_POWER_DOMAIN_APU>;
+						clocks = <&infracfg CLK_IFR_APU_AXI>,
+							 <&apu CLK_APU_IPU_CK>,
+							 <&apu CLK_APU_AXI>,
+							 <&apu CLK_APU_JTAG>,
+							 <&apu CLK_APU_IF_CK>,
+							 <&apu CLK_APU_EDMA>,
+							 <&apu CLK_APU_AHB>;
+						clock-names = "apu", "apu-0",
+							      "apu-1", "apu-2",
+							      "apu-3", "apu-4",
+							      "apu-5";
+						#power-domain-cells = <0>;
+						mediatek,infracfg = <&infracfg>;
+					};
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_CONN {
+					reg = <MT8365_POWER_DOMAIN_CONN>;
+					clocks = <&topckgen CLK_TOP_CONN_32K>,
+						 <&topckgen CLK_TOP_CONN_26M>;
+					clock-names = "conn", "conn1";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_MFG {
+					reg = <MT8365_POWER_DOMAIN_MFG>;
+					clocks = <&topckgen CLK_TOP_MFG_SEL>;
+					clock-names = "mfg";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_AUDIO {
+					reg = <MT8365_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>,
+						 <&infracfg CLK_IFR_AUDIO>,
+						 <&infracfg CLK_IFR_AUD_26M_BK>;
+					clock-names = "audio", "audio1", "audio2";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+
+				power-domain@MT8365_POWER_DOMAIN_DSP {
+					reg = <MT8365_POWER_DOMAIN_DSP>;
+					clocks = <&topckgen CLK_TOP_DSP_SEL>,
+						 <&topckgen CLK_TOP_DSP_26M>;
+					clock-names = "dsp", "dsp1";
+					#power-domain-cells = <0>;
+					mediatek,infracfg = <&infracfg>;
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8365-wdt",
 				     "mediatek,mt6589-wdt";

-- 
2.25.1

