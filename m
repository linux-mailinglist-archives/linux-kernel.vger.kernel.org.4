Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622BF6D7663
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbjDEIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjDEIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:07:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993E4ECB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o32so20364566wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KFcOYEAi46ZIl7QCtzcN5XD6VlwA2hJvytxtJEenkQ=;
        b=vC37SPRuGSTtJnMrgLOqcrANQR2a4Xjl57wIS2cFdSmSDXVTJv87ZOCMnfWR/ekZmg
         zmxTY9Vly7gEaFZr9rrndEJL0fwvCfEZiKMlSh88tTP80g5ga2H1lyFQpRAlTRkVWs70
         95EV1zgB4kEyXhwIRYRZZw80RPSRh6ov4mHpFvrQ5bN+e8gyxcFjA/gQyZZG1XylGquC
         j+V3A8UVrRtnCasdq/MNHMUYZctcx8+VlPJNWCdwRrAa8aYZnbVOm1K80TIFQqCX6GaY
         zoywVAJrYtnG8mUZh1tZwAOt7bb7qKHRnwVc1F9pawsXXjGSnOd3Vv+la8xLUP6nKrJ9
         mZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KFcOYEAi46ZIl7QCtzcN5XD6VlwA2hJvytxtJEenkQ=;
        b=pQjv4JslI1LYZR4EFai9WMShoT/txhzFBxNvV0B8hlBD3lgp5ap5ePjVHKFMLgziiI
         3Z8wHqxcOJXM36tEMkf8U8C/mZ9Tf5xN+KPFuTrirEdXslrSk5JONuYRAFQXA9nR+uWU
         EUCs5HmyOLRGR/sifIQXVGw8OsVNrr+U8FUI2+KO7EZnqOSYhf4zH7LCutb5DTK7xLGp
         Tg0nnQ0GlhytewSvdOW8O0xhy2JUJc+qzjMuqZW4FZctiLnfAukiMgrwid8fU1wodYl9
         2TZeS32VyIs7qkakBvJQNResRMW4/eoC4rWB3/rw/FKhkwNgFsFcX1sDmKqky8bO4S6k
         oXrQ==
X-Gm-Message-State: AAQBX9ckkLUciJHbgDrFRmatl5SQylcc/2qVfuXCgR+GThFj73SSjUCB
        8RfVKqTNALzSQIK7gNllYLCe7g==
X-Google-Smtp-Source: AKy350ZlwKxcKrdi1y+uB18vJkxgLBTl7GEMfPyPnXCKZka9q56+j7miIS2FFOvPTDEe5qCNKGJp+A==
X-Received: by 2002:a05:600c:2054:b0:3ee:d7f:6676 with SMTP id p20-20020a05600c205400b003ee0d7f6676mr3956095wmg.11.1680682074529;
        Wed, 05 Apr 2023 01:07:54 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:54 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:48 +0200
Subject: [PATCH v2 06/10] arm64: dts: mediatek: add power domain support
 for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-6-60d5fa00e4e5@baylibre.com>
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
In-Reply-To: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
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
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxSZvY7WYtrVZZ048+sAksLv7mZ/3DDV3PIV9FZ
 VuXyio2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUgAKCRArRkmdfjHUReXKD/
 98PT57pl0/HAZiA9k2UQRohub2R1PIJLlVB/FWhUTECl1UlKdYDJROhK19Y90ApxgQ82t2+uStIZwa
 j0LF0qW5GFKDCpUD+twPVbP5YyYTpojOnn3oFVZrvS2WSZg3udt/ZNxXPsu5UFC7MVaWq15AJk/7fS
 7hLKrUjQA6s+3IBgfG+LqEV6XdPM5I49Tw3WWOUuyM0WOTHSTA6Wy4TuD2zdRwBRf5dBi4w6NgsV0A
 adG7XQbITYgCX7L9Z0xR6ApUjn2q0hAN2LbGCUi7zCLNkwWc4m25NICMHGXy6rlPk2B/Mjx9t41GBv
 eB64iiuQTvBqYPARuWv1KT1QhXVgbw7YNbHzQijc4omjkmYmQQebCMJSKi8VtV39f7hICaBvNNq23z
 +o299/8ex3ABSkjh9QcGFsL4NwEhf6tjcDqweQo/LjANxqBWK2i53aEuX7R0jAo2YtjTuYFuj9q3v/
 s/oShVO7bYnWhC+/JY1rW60pCuY+pM7m+ypT4qZvH1SzRmZH/uJ5Ds08MtzMf85KNypMOr/W+uF4lt
 7dpC68Fc0LIkIap8feQJm5Lt5RBstpS1j+iW1/jMFE1FoPrrRg9IfwmS5QpaR3ibMV5hYfMDESSour
 k1aI4F2WQ4ieUmj3D+vt+hmORx8vkhAwh8nrCTy4uJ6SdR4Fd++loOxV79WA==
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

