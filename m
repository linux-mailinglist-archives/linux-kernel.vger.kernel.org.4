Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F46CD6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjC2Jwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjC2Jwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:52:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6093C4201
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d17so14991806wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680083556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITsXYmWdm8bbIlPl+WjhWF1RolkMvLm/Ssz9gxboyio=;
        b=vyHg6d1Mka0j0t+v/2rS+UlUcsu3DFXIRh9CJ1gm/mvVuZphiOZq25TSRMZoMPsdA4
         +T87uD15LK3tU1b/WCsAfBwu4ZqzKomb75OSbJY99CiZM80aW3oRSW4Oprq6newF8uX8
         vMSB0TTkLoJ6D7ba1B1jahqBth8LgDm3vyvPx5uLN5A5LAFoSNMi10gTEQm/GWttijSH
         ZZN4PCc41RSdzdKjuk6sE38gRcCOpUn2H0SLtGN0xD5t74MQgDP2K8AVigBJTGDAPGQt
         Stgl4WbFVv4p2Q5cJYx8zBExtMuukj9PFxk7wXV45q0IX+7QuHIW2Zv/tDoL0/EgK3E1
         JaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITsXYmWdm8bbIlPl+WjhWF1RolkMvLm/Ssz9gxboyio=;
        b=aBK6X+5JyWBPLCaYH8RqL1pWYeWWm6NuwKEJqftMf7mZw56+7paMfWuEmEa6DUZ3Ln
         U7yLSdm2a5t48j+Qqw0B5Ipwv+IuZKPe3f5n0vljZLMDIi380J1Pe9yn6Iarekqkpa2t
         0P4V8iwGml3nMjVA95MXPTG0z3SEkW3vkaeE1Bkc3uLc3IYvigY89NbKKJNNB11ldACJ
         gmUJXZvuBRUJUax/A4poNQepD1G4qQaZI7agFNLg7z8RK4hjXSITvAMDkWKum7zpuhEM
         wtxamBnPUoyA0TjZ7LklbXMjUBUFMRX9flRshHCqx5+XPynFvSgiN0hiGMQCVWOOp0cA
         Updw==
X-Gm-Message-State: AAQBX9ecRsx59e29XO6BEH/R3g4H12dhufNHLdSjR07swSJquev0GW8b
        fTD1eEzTxvhW4DUQandjWLDMDA==
X-Google-Smtp-Source: AKy350aW13UbN8B088JwKLmgCmgH5KfnTJVskMiGbea27enBo9BkH1Gl0rpSin7h24t+JNM3gCeZPw==
X-Received: by 2002:a5d:4dcb:0:b0:2ca:8da1:db96 with SMTP id f11-20020a5d4dcb000000b002ca8da1db96mr13854363wru.50.1680083555852;
        Wed, 29 Mar 2023 02:52:35 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm29667158wru.40.2023.03.29.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:52:35 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 11:52:23 +0200
Subject: [PATCH RESEND 4/6] arm64: dts: mediatek: add smi support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v1-4-4a902f9aa412@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=oTviy6aar/3azmPvk4PWpNpnaMyShkhx+Aj3IrIsAQE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJApfVGbQXStEbLyxJZZ2heAAFQwrZKjJYK+BtSsA
 93Jwec6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCQKXwAKCRArRkmdfjHURRwtD/
 9lz9/Xq7V8FM/c2aDIcxwEKCj95C9+ZMNpUXfSJ30grI0WKp6zMPdEd3apg9nfB7+BEjW9Zl5A5aeV
 qvLqK39wzzw6DxxvCRqyaoisk0OlKGXL92SrEUaejRyXjh78JFOxEKRm2WrWD6wKbwa7Km7e6ZNbc8
 xMB5UCc0J6JehS79xn8US9xiO+Sbs7ZSwGMZ15lra7NNfYlZNHgj81sxOAx6KSJqXbg1Dyp9tTV1wJ
 cM1FRnrPYsufMQuCQ6fF9fhpU3zPOTqKhVSZFkz27kNOXgNieGy+xLr8tOXBL9rY0VMeyIzGYqqhOi
 M4po2lWQkIHX40fszfCrfCLNqhvTmzzvrMiLo3lCgijRUGieZp3VR+TNd2FKwQWWVtI4Utr87zGNYJ
 lJNnCd4SmHZFUDJrbAHtux+SEuqM784uJXXF4zvIQSUGZrjD255X0Cm1Orv3HEAhwh1OgDf7F+r875
 4xbHCZsxVMKTtOPLmxwwe6Dxr+zGBD0KoM7m/6FVj8Rts4/wKBZQAKVNwUp2x8MVX9T5ITI26nbfIC
 dIAM+VjOoh0Y4A+I/ayIHuwNn7jEHaxlxP++BRxL2m7Q2w32sDjUMgDvN9+h7vCUBUpqt0Hcs8rEgi
 TB+++i/PsIkm0jC7qu35aQZHG1zOa9AYH2gT3Qkhhh3UU6/FgV5tBmgrVO8g==
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
memory requests from multi-media engines. Add SMI in the MT8365 DTS will allow
to add local ARBiter (LARB), use by IOMMU.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 67b375fe2020..61333800ff4a 100644
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
 
@@ -709,6 +713,18 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14002000 {
+			compatible = "mediatek,mt8365-smi-common",
+				     "mediatek,mt8186-smi-common";
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
@@ -720,7 +736,6 @@ apu: syscon@19020000 {
 			reg = <0 0x19020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-
 	};
 
 	timer {

-- 
2.25.1

