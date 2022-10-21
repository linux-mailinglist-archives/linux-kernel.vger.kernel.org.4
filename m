Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B113606F27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJUFJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJUFJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:09:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A0555A9;
        Thu, 20 Oct 2022 22:09:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y191so1587761pfb.2;
        Thu, 20 Oct 2022 22:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ba9dLdgOZBOgG+Y/zhEkRy4LHyrM2NTx3VqdcRa7tz8=;
        b=JO5pUJWXDe6yMAmpZGe9HeFCZjsqKRSnxnoFGevEUfDgzex5fnqR4h4RB/YGKnbgpw
         vHWKzdcTs0BGsdyYklukTlJkeA3QmP92h83HAAQWoV1dW0Ew5xg9LLPwPyr5+/lk38+s
         eGFP5bJhd9g8vw0FEzafKvXmlwddS8gn5I9mRCwgdiWuaQQGvB6PTn7kF4D3q2cZHzcq
         BfyBCUPbcSxTD8wPxxe2gKlOZtejX1y/wkK/wknSr14WRN6cnOmzIxNfEs7x5OxpV0Yz
         7bgtnDHXrkxpXu/Xga6XCzgYSXIbrV4If/HA/XT3hh/cpOIe6eUkJ8sarB4szRWAtG+c
         RE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ba9dLdgOZBOgG+Y/zhEkRy4LHyrM2NTx3VqdcRa7tz8=;
        b=RnDwVa31xM+K/+rEpmS3TqICSprT1arPOVkciyK8Ou/Wm/914CfOAeBoezekFjdOLa
         9IHEL6ascqgDb3oTl66JLPyb+JkSgNsgWzWeYxP50fDQxWs/x8kT3oPXhgRxIjVlVrDo
         JgH9c/pTWFhh7B8Dtkch8a9cCW/F3EfB4u4i/uGXj64zkFrYLSOBFzV6PkFQ7rJ2rySW
         IprfGKWyKkh7IHLQ5dZKSO2yM+VuqWwCBs2gAEIoSGi7BFv9vafvK97hC5IX7wYh0och
         n4WTAo9FQH6S4DIPYqEQY88tsqJb0/m/50DESz5pR9D6IvkEb7jlKUCw1Ck44LESOXeD
         D9JA==
X-Gm-Message-State: ACrzQf2AKq6BZs1zcii/h9X7Ua78N38xqxSkeCAE75uRlKzI/BT0IMFv
        KLovlMXdiAevf4ZwKuzr1lr/h6Uki6A=
X-Google-Smtp-Source: AMsMyM59WgmWh7/zaSdlePpeiOjBk6mOvLdnDVwax23Fa9VVLugMGyWLWkUYZEEAcovwo69V/hk9mQ==
X-Received: by 2002:a65:56cb:0:b0:460:442e:b293 with SMTP id w11-20020a6556cb000000b00460442eb293mr14621854pgs.49.1666328966431;
        Thu, 20 Oct 2022 22:09:26 -0700 (PDT)
Received: from localhost.localdomain ([103.51.72.20])
        by smtp.gmail.com with ESMTPSA id ik3-20020a170902ab0300b00170d34cf7f3sm13520770plb.257.2022.10.20.22.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 22:09:25 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Dan Johansen <strit@manjaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] arm64: dts: meson: Enable active coling using gpio-fan on Odroid N2/N2+
Date:   Fri, 21 Oct 2022 05:09:03 +0000
Message-Id: <20221021050906.1158-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Odroid N2/N2+ support active cooling via gpio-fan controller.
Add fan controls and tip point for cpu and ddr thermal sensor
on this boards.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: changes tip name cpu-active --> ddr-active
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index fd3fa82e4c33..667d2b774924 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -39,6 +39,14 @@ emmc_pwrseq: emmc-pwrseq {
 		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
 	};
 
+	fan: gpio-fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio_ao GPIOAO_10 GPIO_ACTIVE_HIGH>;
+		/* Using Dummy Speed */
+		gpio-fan,speed-map = <0 0>, <1 1>;
+		#cooling-cells = <2>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -410,6 +418,40 @@ &cpu103 {
 	clock-latency = <50000>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_active: cpu-active {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&cpu_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&ddr_thermal {
+	trips {
+		ddr_active: ddr-active {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&ddr_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
 		/* Realtek RTL8211F (0x001cc916) */

base-commit: aae703b02f92bde9264366c545e87cec451de471
-- 
2.38.0

