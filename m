Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0D608B39
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJVKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJVKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:04:33 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ECE29C48B;
        Sat, 22 Oct 2022 02:20:31 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id y10so3410426qvo.11;
        Sat, 22 Oct 2022 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=weLbIcCNbVsHr1aN9+oDZ9csZQvS2rrHQIhJrGtb3xY=;
        b=ZdhqrO8dUBRyrVmTSDjKjyupq7G+G+kVjVIz8irauY0guJaoETll1LdUIwOJfFCmca
         28S01QR1hirbxyJViBW5U55IuOHMiXihd13MpBdIxY7B9uiAdjW0forCbIFmKI7Asw7V
         uzFD6M8splAU+GsKCmBY698w85NEwWSoCb3iGYOsqoXJqPDq4V+GcD7Eocr5Bkl/MaOM
         XSd4lUBoTkHefZUb0fPxlv33g1X39czbIo96ELLbLAkq8vns6+faSvUS4XSCrDhHMr+Q
         1v10+vgpaCdGFQUvpqtf+xCqoHcgZ3El+k25SBSUfWmfNgJOR5EsUk+U9cSTfmEzxm8+
         ojRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weLbIcCNbVsHr1aN9+oDZ9csZQvS2rrHQIhJrGtb3xY=;
        b=I3ZhNMm/4qp/xr8dd8Hry76uevZjrA4MN/cTG3LdsmAfykcfbttXF0/Y7kNigexCuF
         wgOHYOOJ5B8ILBXeK1SHyxqJQcRsTHFHAtMxsrIdKhqVNMxn2eTEsJf4q0JBKCNT6XtU
         63dbJEGMIqyrmNuWx2ejm1Ghg2A6AJkENS+SriziTsy7wrJH4pw2xKkxtx19TE2MQ4v2
         vAv/kojCb53xAzXAWuhZsE0fR/wOzJDSNP17ud+gEeUfLcDDhYYesHMB2xsLDrLNGhkV
         2QXSynYrBCePvUyipVguchG2cttaTHU/v8X1cVPHXVgdOdkgZnK1QMQhE0UZ+Yw9L+19
         rOVw==
X-Gm-Message-State: ACrzQf0UBRIzuqFth4Ncmt82lT+HXDNgjG5bkWIqH6tdnN4wgb2eFyRP
        ctVmuxcF8Ur+ABrO5Y9YK6k1d9xAT74=
X-Google-Smtp-Source: AMsMyM4r3OWLlX7+sUVn2cpmmJhUIG8Fv5DeOgSPiIFTH50CoR3FZs4S0oHgANqZ54uQexeSvhDVUw==
X-Received: by 2002:a17:902:e80a:b0:184:6043:752d with SMTP id u10-20020a170902e80a00b001846043752dmr23163056plg.137.1666428479543;
        Sat, 22 Oct 2022 01:47:59 -0700 (PDT)
Received: from localhost.localdomain ([103.51.72.20])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b005631f2b9ba2sm16843911pfb.14.2022.10.22.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 01:47:58 -0700 (PDT)
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
Subject: [PATCHv3] arm64: dts: meson: Enable active coling using gpio-fan on Odroid N2/N2+
Date:   Sat, 22 Oct 2022 08:47:34 +0000
Message-Id: <20221022084737.1028-1-linux.amoon@gmail.com>
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
on this boards. Drop bias-disable from set pwm_ao_d_10 the pin
as to allow transition from say pull-up to pull-down for on/off
of the fan.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: changes tip name cpu-active --> ddr-active
v3: drop bias-disable for pwm_ao_d_10 pine.
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    |  1 -
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 45947c1031c4..10a09fe362fa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1982,7 +1982,6 @@ pwm_ao_d_10_pins: pwm-ao-d-10 {
 						mux {
 							groups = "pwm_ao_d_10";
 							function = "pwm_ao_d";
-							bias-disable;
 						};
 					};
 
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

base-commit: 4da34b7d175dc99b8befebd69e96546c960d526c
-- 
2.38.0

