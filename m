Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B4F5EA89D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiIZOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiIZOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:38:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B76C75E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:58:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p5so7295541ljc.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=w6V4EDGBi7bc0hFey/MeSVbaztlhpHUML/SAzePq6Ps=;
        b=s3T/OeCEjWcCz7Xde265NAXhd7T92aAzYkDD+yKiPpScRmSd7Z4y2P82OY2M8nHASJ
         vQ8AcpgWf6saxJ3NSt/KnIRozgerqP2P2jqVxa7KEecSIF9bIIQwcbuJoGIeQmHfvCnx
         NvexNjf7ezbHy/MylH1N15/injexr/BCIZOt4fethBLaTvM/H+kqm6p9F/feqNUaxHMc
         IdiIi7dRkww+j0Cf7tswoUT+dDQCzF9FVv+54eqMsYYAvF+Wwpq3wJOwrl1ntA0Vzmv0
         +dkSHUrqakgRkAN46UrUm8HEI4MAjypOFH4wTZPHqUZyN/ewgxhbZU5nKs3yyR+HPzuI
         Jf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=w6V4EDGBi7bc0hFey/MeSVbaztlhpHUML/SAzePq6Ps=;
        b=JSyPt70MYmcirFJbGtX9HjJEycjJc72cD8dkEdv4BjZQdeec1MLifqrfgf7Za2/1H3
         RR5xGVo17NsB+XG8TF0YitjGxT7kArmAj/hvDbySQzU6hxAjDRRQbjWzR9HYlFmKvNqV
         xcf1BBKlZ/yDJk9/6EPy3AbKxCrgrj7BDNA87WqZTivU9qf3qzS3JSZhVCw7v5819AFg
         vYCYxPved7GSMWZCfyANFiNPgXsp1FFm4c/hxBdZSqiYy+CNF40WbVWSNoGtZG+GuR4J
         lO92s0WlUHWMLZJ1JJLLKdjp6UwQl9lH/p9GE2bwTzzleODodQfj6D0FoYLJ1cjPLIkl
         jRzA==
X-Gm-Message-State: ACrzQf1r77QycAK9RnIbYDzMZPCbdIm0OfT6p66AkQOhL9p9iJ5X5Rv/
        9oSdUoiXLpvum7lc5mcK6t6vRQ==
X-Google-Smtp-Source: AMsMyM4LA+tL4Jz/ex7fkTi1ACk8iXZOpCcJWqZscXaQxyNRSe9Ac633TD2N2XyvQSlagF944m2FUg==
X-Received: by 2002:a2e:be24:0:b0:26d:9942:dfe with SMTP id z36-20020a2ebe24000000b0026d99420dfemr1721034ljq.16.1664197112498;
        Mon, 26 Sep 2022 05:58:32 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q2-20020a19a402000000b00492d7a7b4e3sm2528790lfc.4.2022.09.26.05.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 05:58:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: s5pv210: correct double "pins" in pinmux node
Date:   Mon, 26 Sep 2022 14:58:24 +0200
Message-Id: <20220926125824.477920-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop second "pins" suffix from pin configuration/mux nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi  | 4 ++--
 arch/arm/boot/dts/s5pv210-galaxys.dts | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 5541df4df628..964c5fe51755 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -738,7 +738,7 @@ wifi_wake: wifi-wake-pins {
 		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 
-	magnetometer_i2c_pins: yas529-i2c-pins-pins {
+	magnetometer_i2c_pins: yas529-i2c-pins {
 		samsung,pins = "gpj0-0", "gpj0-1";
 		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
@@ -788,7 +788,7 @@ accel_i2c_pins: accel-i2c-pins {
 		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
-	pmic_i2c_pins: pmic-i2c-pins-pins {
+	pmic_i2c_pins: pmic-i2c-pins {
 		samsung,pins = "gpj4-0", "gpj4-3";
 		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index cdd3653d487f..532d3f5bceb1 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -150,7 +150,7 @@ &pinctrl0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep_cfg>;
 
-	fm_i2c_pins: fm-i2c-pins-pins {
+	fm_i2c_pins: fm-i2c-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
 		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
-- 
2.34.1

