Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2105ECE16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiI0UOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiI0UNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:13:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C41ED236;
        Tue, 27 Sep 2022 13:12:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a41so14670044edf.4;
        Tue, 27 Sep 2022 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8pSjB+gJohvS5unlBusQ5X7FD9nY+Kc3aHB8SHm0lc4=;
        b=V6IyQApKrHwEnRiPh8ZfEmMdlOzzFZe+WqBG6IfHy30xgJSByiS0mhqIQrO4L69zHW
         ZrlJs2n+vTkLiQBEFEvfYvK9tpdaFmEXYU+/WVTczn67+qY6WfrzIP/cU4sdRaOUtKX0
         3lX8sVOuwQOLVyC4g/yud+2K9uZTgwYgtjz3njjIO8umgu0hN3aqZN2HMm59npWnMGO4
         ZnGMd+JFlBCJW4KB8QF/s/RasWZbSjRnLDWbaF+4ybIajEIOXVlkc4Z/2S7lbhT61uEq
         y3wVaS/Ay1KHgBiYYD9VQ5zDx1zxijwZ4jebuzJlWUPY/2WECH7RpllKr0bIycvUx+UV
         dV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8pSjB+gJohvS5unlBusQ5X7FD9nY+Kc3aHB8SHm0lc4=;
        b=SGqaj69WedHRW6Be7AjjhUs55v4k58Fp6GGu53/Cr6LabekfGv5zVZCY46BQLHSIxg
         rWPDHZhSkVaC28nZ61XjeI58IHie910zcwmSO1XIA6hrj+i8C4GD82DaIBpeQDCZz/NC
         /Mf6Db6W7cRiZtFZeUuaFRcJm74+L5u9kebKaebTD31ChznBAOfmeliT5RBfmoBbNriK
         aPNNtYG5aLQ7/aFaTL29HQvtvqxZsGnaqdScbaz4W3L8Ypt5yKwh61Ll+HGlPwKAUWeY
         AP/Yl9MSmAfqme6Y9vwVLu+yLXZqzzT6MjBMXv3pnD1gJdLfdQ6AptrKXnlluncw3xvR
         mYmQ==
X-Gm-Message-State: ACrzQf2h9kxl/VXL68enR8NwWcWU/+0N0HJvQGANzXnKa9N99j/Jqtba
        eV4SAvoJc9p8IvKpaOLH1GE=
X-Google-Smtp-Source: AMsMyM41T3Qq7C/k7coJhotULEWD9XIfdLvFgcvBGe2okVecVjdNY7B892RoEHjUV1oXGDSf/Cy0Ng==
X-Received: by 2002:a05:6402:5188:b0:452:5395:a271 with SMTP id q8-20020a056402518800b004525395a271mr29585135edd.383.1664309542538;
        Tue, 27 Sep 2022 13:12:22 -0700 (PDT)
Received: from fedora.. (dh207-96-59.xnet.hr. [88.207.96.59])
        by smtp.googlemail.com with ESMTPSA id t7-20020a170906a10700b0074136cac2e7sm1267548ejy.81.2022.09.27.13.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:12:22 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq6018: move ARMv8 timer out of SoC node
Date:   Tue, 27 Sep 2022 22:12:18 +0200
Message-Id: <20220927201218.1264506-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927201218.1264506-1-robimarko@gmail.com>
References: <20220927201218.1264506-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM timer is usually considered not part of SoC node, just like
other ARM designed blocks (PMU, PSCI).  This fixes dtbs_check warning:

arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: soc: timer: {'compatible': ['arm,armv8-timer'], 'interrupts': [[1, 2, 3848], [1, 3, 3848], [1, 4, 3848], [1, 1, 3848]]} should not be valid under {'type': 'object'}
	From schema: dtschema/schemas/simple-bus.yaml

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 57978a8ab498..428e99e127c3 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -511,14 +511,6 @@ a53pll: clock@b116000 {
 			clock-names = "xo";
 		};
 
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -770,6 +762,14 @@ dwc_0: usb@8a00000 {
 		};
 	};
 
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	wcss: wcss-smp2p {
 		compatible = "qcom,smp2p";
 		qcom,smem = <435>, <428>;
-- 
2.37.3

