Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160026D7662
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbjDEIIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbjDEIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:07:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A1E95
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso2303154wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tORp1I37+JIRNlLfmuNLwniBkIh0XbsRy1El1Qwfh5w=;
        b=eeP894lK8vDYZvEdMPg/go0rW2JiNyxXyguTSdzNsHYp8A7Jd/nbTTbyUya4Yos2hp
         BUttqMhu7Ir9RNscSKTDxc33+4QkWcNBxkei+DmYtrtOVR9GahoxWf+wm2W7LF0lf/0O
         Jnia2bnqv0uXIdrROJI/Ve2IC11dXJI3jJohPe+dl3DvYaM3rf79PzjHXVCghZFSgku2
         y5FeYl4NsRYWG1KIm6Lq9zMUmnIB+xh6Rfq+alO5G7rh6EoH55gcN2TaFlAMXAVt3xTS
         Lv6+9/Ms/Ps0ZaAekcXwXKIASZIF7NkAmKjndd0PRJi2X0rxW6A+FZubqWK+Ef/xSigA
         /QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tORp1I37+JIRNlLfmuNLwniBkIh0XbsRy1El1Qwfh5w=;
        b=ehjcBzYexDAOHBiwEKMVvVRvaeB/5qWNuB2wETI43GeeLnFUMEKpXQLuZ+gKiI0rmE
         DwVED1NJaU7HXHPiGPbBPwewPfVx/8apUZNV3iojYs2au09ZrcibQuYbP1Km3UKzrXls
         bvn0vQYST/KA0texd5f1nWNPoNq5WlRh+toCQoft/eso+VMp6tu9VClkO9RYhJ97FVVX
         t5i3RZsoo+Un0LnmZgh8QKrFh4dvDsVdA4975653MGPRewFISNcFLcclEshG5vGMpISd
         zLZGyJ5sJsWx8vlznym/2PCA19Eicjg9liog6g6nf3Gpak9xcUsb5PGdqY/yhCLSIDrt
         zqag==
X-Gm-Message-State: AAQBX9dSuaw3rQ292nSqncEEe1sHK+eunOK/mDJRevTcXTfXLZWKjRwV
        ReHqQsjm4HnPD1Qv7iW8USCPQA==
X-Google-Smtp-Source: AKy350azRPXwLmeuJ9HfGFndgnxQIBgT/MvaBdrj/nuQm3xqNxg2dd5pm8+rxs1hnFyGYbhtiLAZ1Q==
X-Received: by 2002:a7b:c85a:0:b0:3ef:7594:48cc with SMTP id c26-20020a7bc85a000000b003ef759448ccmr3977617wml.23.1680682075524;
        Wed, 05 Apr 2023 01:07:55 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:55 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:49 +0200
Subject: [PATCH v2 07/10] arm64: dts: mediatek: add smi support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-7-60d5fa00e4e5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=J4LWefgCJNgBuhY1OJrPCpnKJtdzqFO3621y4agMuJ0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxTwyToUcCkEHjH8F8sUZh9X6+owHowBT7aSF+F
 7lPhpA+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUwAKCRArRkmdfjHURQzhD/
 4uBQiqBMwYx23RqLaC+0SBJRWWJN627CQImPNf7tP2RS7dyG2Nw8XMgZXBIVKCFgo+kzUHllX/iRiD
 JhZg8HMjto6Q6CAMDCXWWl5nSsd1VdK7qJpJNEQc88kCrMSSPVSkzrw5fthDnWvqBaXzmxrwUMoBT8
 4wLc+mja32gUQDBCjLLXxUBc/EfVHY8TH+8KoZeJ3sMIT+7Cur4nV0t9DboE5J26RLcmkc06REARH/
 n53/YDmRNrUXs0mtDlRgwuj0DJTH4faSO77slamIUvwRIuRtuYC5ruOS8KyMTNngQs3vs9f3r35DqC
 Qnh0gpN+LSd5vhyZaTiAL7uO3RXfdQGVQmS/4+GyGidH2aoMT5Jr3JIO9TABz7fVaTAVrT9LKR/Tij
 BMj30JKm6iabeZBDBg4Ah3ivT9Oico1DZayOdR5LU8BKtzjf66MpUlsWNRCoJUGoyf/bLv97ty06jN
 WrbNC6iuR/3om98bPgz8ILT9sSzWgv6N+1v6FrXRzDhXNTG6YVSI9p9t/XK3i/kNeospvF/GKXvkMq
 WaztOQJCReoxY0q5+FUtal1FF+dUWYCvkFuKMaPJhgWrMbDpXotFe2+L5LXHuhb2HqrCzxMA9HP8Xh
 NTPHy1BN/371OJ9pmEfPL97qwABcmJfvJVB++O0DONrHN8jIf9G2Bji/YBMg==
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

Smart Multimedia Interface (SMI) local arbiter does the arbitration for
memory requests from multi-media engines. Add SMI in the MT8365 DTS will
allow to add local ARBiter (LARB), use by IOMMU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 0e4fa69a2415..70915beb513c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -324,16 +324,19 @@ power-domain@MT8365_POWER_DOMAIN_CAM {
 							      "cam-4", "cam-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VDEC {
 						reg = <MT8365_POWER_DOMAIN_VDEC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_VENC {
 						reg = <MT8365_POWER_DOMAIN_VENC>;
 						#power-domain-cells = <0>;
+						mediatek,smi = <&smi_common>;
 					};
 
 					power-domain@MT8365_POWER_DOMAIN_APU {
@@ -351,6 +354,7 @@ power-domain@MT8365_POWER_DOMAIN_APU {
 							      "apu-5";
 						#power-domain-cells = <0>;
 						mediatek,infracfg = <&infracfg>;
+						mediatek,smi = <&smi_common>;
 					};
 				};
 
@@ -709,6 +713,17 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14002000 {
+			compatible = "mediatek,mt8365-smi-common";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_MM_SMI_COMM0>,
+				 <&mmsys CLK_MM_MM_SMI_COMM1>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
+		};
+
 		camsys: syscon@15000000 {
 			compatible = "mediatek,mt8365-imgsys", "syscon";
 			reg = <0 0x15000000 0 0x1000>;

-- 
2.25.1

