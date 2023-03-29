Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204446CD701
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjC2Jwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjC2Jwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:52:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA326BB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d17so14991842wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680083557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sjNWrLufbVa/jzWsOvdujGFS805Gfxk1vTY2q5k8U0=;
        b=uy8np/PFQIWNadmZTPihVohkAv/7etLUp5p9bZKcixeLJwpsYaJtvXzQGoOLKvg9pb
         33he5oIDniXzvTBL3qlUoMFxHXVXdZW8fsmPO0vjSgsWKKerpERFKmrmHSZsPep8aW1+
         0w+JPFO+5Cm1JyRRQZiFkMqO3lyxslzSAeakBcSW9cmYGNiJuYkuwiuLiy+IFek8se/E
         JUM8Mbv0FcApOMIJUsPbqwdtZb2/7RtNeJQOVnQ1spSvxffFV3lx9YarAAHukMs0TqWo
         M164vrQxlnGRxbGbykkQUYsJ02W18qrUTMCUlZyTV1F7hCtnVa7KDmk1gOunf8i8VZ6C
         WtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sjNWrLufbVa/jzWsOvdujGFS805Gfxk1vTY2q5k8U0=;
        b=B8yn0CbzbWfz7XCjQeiIoOXkRXW/IWzjRPIN3C9Uk00It0iKvdyj6ZI2/sUxnsTmRi
         v4yvah0tQSp4AttZj0pKBb1xediFdrQtaR3F3F6TFpTwmDRc34K20Tauw0yeYwaLkDIX
         QGllx0QIdlgDv0frtbkZPBD1CNHzgLMNm5LLZizRYPGYG53OjhS+bgXbAFanmYTjrQwZ
         UR9D1iMA87znXTy5SN2mVjMEepDFMSyyFkpxvdtQ+74UKsI0yhRQmtvZhAsJA1KOqnHS
         n5NEKSxPdPD0/4N1SkEM2XH4L1gVZL1tQ6EfVhotgbOGl61bYinarv6heze+sC5+yBGN
         6pjg==
X-Gm-Message-State: AAQBX9cCX5ii2Lp2GpwRwzim3CFIp7L5UlUNSYi63faXDLdSxuIXW2Wq
        w4HHziFvtr0KmvlD/RiBQNducsr7i9mT+Mrm9yU=
X-Google-Smtp-Source: AKy350ZXpkkaSgHa3y8j2yEIr7Up50Td3FYauEQHsVMB8ri+XrguR+om1tVRr9dbM05ylJuieR7m0g==
X-Received: by 2002:adf:da51:0:b0:2ce:a6f3:34ab with SMTP id r17-20020adfda51000000b002cea6f334abmr16519247wrl.6.1680083556763;
        Wed, 29 Mar 2023 02:52:36 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm29667158wru.40.2023.03.29.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:52:36 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 11:52:24 +0200
Subject: [PATCH RESEND 5/6] arm64: dts: mediatek: add larb support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v1-5-4a902f9aa412@baylibre.com>
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
In-Reply-To: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=XjVkw1GDKMmeBhzbo3W1bEYNyW+ZnWm1iMDrvQExCYA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJApf/0xy8f4tuG475vEqLpUT9xY0KkdHZQQ16mEE
 UQPiw+aJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCQKXwAKCRArRkmdfjHURXdwD/
 sF3luANvTX/Sa5VyhmA9Hasmqiwa6puy5j3JQ79X/9L/KmyFAFND/Bgphp6AMuEviGaRVPdgR+9hye
 1jXJqcsaF6eIDmuBGRxGJOsNzUy8Pv5jMOEtrFFgD3dmS3UWsjGyEjU4RQqz9uDTa28p7GB0TPErz3
 uaMUbhJfpvgYY0zNidXInfXirOkPNyBspyhlTGRJjRqFMIKwZM+4HKZe58AIOA4OeYNQP38ZrOncgD
 01ML1FkhJrFPDV106REYQw5K2G03GxbKD4nOGXuDLJT3mAlSiV+rWB/S+L+loKmBZWI6NLwsLfouQI
 W5rAPb6vWFHY77ZxYsVfQnMFhXrBJrUTWu1r2If/J5BA90Jg3qtRXlj/nlaalx5gkQdxnre8A/inl9
 D8wYmODOQ9O5v1UgCkYcopTm2Ao5B6f8adc7zD3FZ4OCfhQeN9SDcGPDLrMnpOM3mYmXZuwjubI7+g
 Yn2Ul0EelA6lw9TwpFMvI/+psr59bePCoyubIcTB+DrK5TshHrRoWcuv6nuZrROQTkVaUNaHE2E7MH
 pjUsbKXjQ7ndRHSPRaKOW26JAyVAu9O/U7jeMBcEWt4MYCQYLmxAbqh3CaDtsCmoorEiXqdcClX3XU
 Dg2AFjmeizRd2PIoIJVTqEoJbYD8Ku36OAiuUpE80pnALRXjkH5CmvHQ9W3Q==
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

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 61333800ff4a..db0b897f58bb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -725,12 +725,71 @@ smi_common: smi@14002000 {
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

