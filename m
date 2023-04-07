Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112BB6DAAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbjDGJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbjDGJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:34:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59159CF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:34:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d17so41831269wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680860072; x=1683452072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8wkncoEW3UcSZNKmP1QjzM0HpYGIsR05ILVR35YRK0=;
        b=G+fKrs4Rnok+T9yu2dpYxTmWAs3dOQ7vbOz5QdPnis+h4koToGr8bX6tycleAtiA37
         7ugBnFSk8S2CGL6/QOAkQgm/oZdsXBQtqGNeQ6C9AXvJ6N2lcrmeXyPm5+mS4Ia4KnVC
         Of7ZxgiUyQRbBbs+XXMrt0lGmmPXFthSRGZCmbAwWgUWmgLBXwF58sWPTjVSuQSQb1NH
         9IDgUDsjGkZIV77mG8sJDUrmRd+7xsm8NJmkEQrKMgAnC8iEGbPzgJV8M9ZPlZcdGPSn
         7lTbsufFJoAfOcF6v6LOqo9zdihkTcloXVRrPWhSV7O6inRolkh3Kx6Pk0hdbkZHlQH4
         OKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860072; x=1683452072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8wkncoEW3UcSZNKmP1QjzM0HpYGIsR05ILVR35YRK0=;
        b=jzIn1hxN+9AVdZ4ULLxrKraj1WxNyIiJHBI7zsQ+qTPqlPY5dzwRCBWDjsVOTZW1o7
         hhrKp9J6eXqHh8VvJnM2x34o9jUv0EW1oG26idt1rCdpfZTVmvp3+LZawpMVBGAquNfe
         PyHU2lliSXsJzvN+tkv3+wNGNlScEle2fCs89sRGqlbElPcXX1JnAAv6rNE/gqSelK09
         MakKKaSpZjmduFXErwfbeXUYx28InzEPclvUXhZE3Sa6BrG+CoNjzdKbT85WTnis8xE/
         2pY6+jBC9LpiijXajy33VU1THLtIKIfapGTDHL0xol2vUFAW3odA0faaDLiHmMguEkMU
         zQKQ==
X-Gm-Message-State: AAQBX9eRotBAtkpYAx/jBW32kXVBtkeapNfp+ReQqaQwzEQddCQZ2DFT
        U9H5Kzge/zHdje94Vzwn75TRAvgEEF8+7yxUCGY=
X-Google-Smtp-Source: AKy350aJyj0LUObDGF6QkURIbj/dclVOrpykWjc8RqbTL5P++90kDPYRhFUSx9890NzrvYhvhiUokg==
X-Received: by 2002:adf:ee03:0:b0:2ce:b7a1:c1a3 with SMTP id y3-20020adfee03000000b002ceb7a1c1a3mr998008wrn.3.1680860072739;
        Fri, 07 Apr 2023 02:34:32 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm4020432wrt.111.2023.04.07.02.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:34:32 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:34:17 +0200
Subject: [PATCH v3 6/7] arm64: dts: mediatek: add larb support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v3-6-97e19ad4e85d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=/eg96dGEgFTbseacSYltO+tu8R5mtjKMtqf32ClmdXM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL+OhAHQ1FqZYfC72oBjPFXJ5fQNLH9cxIalmzV/J
 ZfLtvduJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/joQAKCRArRkmdfjHURWsEEA
 DE/WrZfKEfR7OQxQ2VlvgVUR/0jjuKcg7X2Cgh9UAltf6sQT+Hbj66w1Ty9fv3rTvNU4N7Anhzv5pE
 hy4NXMYoRO/+qVnfkIMQLQDLZffN799KGzWbh/xNfhH3exmfCuTQ2emeDGrAUZ8bFXJH/v0RGp45S2
 9e2UBjmy5ib0xKBi9P8lKmx2mS50YhNTAaihC1jitXfALrfc6HP/FikAQSlY+BFiX9hDYwwYURaX2i
 o60+B+ymNVmUsCw0SLtWdN4YN0uClPbaYdVCIFYMmlqJVAAaPCfqLiF1YxPViWaLVuTmS3Ylw/Cq/v
 KFClmwOEVxo49P//NQWu0n/7K5+i+XAwo6SvDWucr5O42YnXJDD5w7YMk2nqzeC5mb7ctyjBZkkXlg
 KxQQ44dn6DHX+XY29ATDNwKdBcEWYpTxqWYNB+ZxE0fiuVkQTpLvMARpRp9S4ortu5CvNitzvgp9wx
 zvCZXu/aQfkSP2juKeiqqD/4il65nNPd00U1/a8ioixNEMOMcfyvj4QSLSkj75thT1VXNAvIx4XZrF
 dP7KV5tABzRJ7eOEWw9iyjS4YgdMRIjaAEMrXCHAxMiQkDwN0EqrOrrq+3kCf/y3Okdfq/bAP5jk5P
 LnDm9fAeFPQoj/KGk9XZg24wAJLMMInusHgU7H2pfxLZ9zC4DPQYcZpqutLg==
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

Local arbiter (LARB) is a component of Smart Multimedia Interface (SMI),
used to help the memory management (IOMMU).
This patch add 4 LARBs and 2 clocks for the larb1 and larb3 support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 70915beb513c..07a7267f338e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -724,12 +724,71 @@ smi_common: smi@14002000 {
 			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
 		};
 
+		larb0: larb@14003000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_LARB0>,
+				 <&mmsys CLK_MM_MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+			mediatek,larb-id = <0>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb2: larb@15001000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_MM_SMI_IMG>,
+				 <&camsys CLK_CAM_LARB2>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+			mediatek,larb-id = <2>;
+		};
+
+		vdecsys: syscon@16000000 {
+			compatible = "mediatek,mt8365-vdecsys", "syscon";
+			reg = <0 0x16000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb3: larb@16010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_LARB1>,
+				 <&vdecsys CLK_VDEC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VDEC>;
+			mediatek,larb-id = <3>;
+		};
+
+		vencsys: syscon@17000000 {
+			compatible = "mediatek,mt8365-vencsys", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		larb1: larb@17010000 {
+			compatible = "mediatek,mt8365-smi-larb",
+				     "mediatek,mt8186-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC>, <&vencsys CLK_VENC>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8365_POWER_DOMAIN_VENC>;
+			mediatek,larb-id = <1>;
+		};
+
 		apu: syscon@19020000 {
 			compatible = "mediatek,mt8365-apu", "syscon";
 			reg = <0 0x19020000 0 0x1000>;

-- 
2.25.1

