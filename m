Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1FA603395
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJRTx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJRTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:53:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0BF8FD5A;
        Tue, 18 Oct 2022 12:53:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o21so12444667ple.5;
        Tue, 18 Oct 2022 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Decn228I23NeLLtliUyA2wHQT/chAyjBvAFPep29TTY=;
        b=gPXw0e5DdOSjS6vUUvJpAJ25al5FdM+3bpuoFbiQViQvegio6bFFg4zi3gRrQqc8QI
         uNd1nwd6fspz6ZrvMd2DvKYPo7yuPe3pPbz1xvMikstoqaxGPr67o75E0KE0VA4orT55
         4KSz4FB75Q3BlufHKu3D58LBG/Gm/tF83H5lUxzVtDjyPNT0WZAaYZ5z1XV/djSnR9/7
         p0p7hcIk2ESbzkY1StAXf9RLw+rFJcE3n9Y/TL4rwvQ2syZxXXtVvylM4HhP165eEpYy
         3R6v4priW798+Ub3UG0W+hb7YrtEuAqx9pfhkT1JsKwwgTZJeGxJJu59xbITIrYevMDO
         Z2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Decn228I23NeLLtliUyA2wHQT/chAyjBvAFPep29TTY=;
        b=gmyD52dh5cC2AqZebOcOij1cBAlk016R6wDpmIJWgCLU/wTy2zr3axPxfJsNjGNFYz
         /xUf9Ge2jW8C6M5vmbq2A3Sq5G9hsbBW0M9hjoOFktM5PkKjzNVmJuEpMQkd+OnGwWe/
         UtWP/ZU1OzRaU44harA76iXTBU5X0YGAKZ/svQzZw+FJSyebYmzQhEkYpovPsHKuye26
         MOVByLKGdESEu5mxAy6z/e2xRjbJbPz04oAQ53yrwAy3cRgn6NbguK59ubm9ZegrSsg3
         TinrCV0trXSxLwC7yrfUwUQTjWJORBVnW2fEWcxRZ3/XDtyaqkjnygdDLm1h/g37BC9M
         FF2A==
X-Gm-Message-State: ACrzQf1qTGvKUPH2hDO5JKFm87J0AF19uTKPhLqiDnm+xWC4XoySE7we
        NWdsVIvBHrFyUl8vM9HVCjY=
X-Google-Smtp-Source: AMsMyM4052ls7BSb0cFjir+Iyuqwp7lSrhnhy4HuHtKCGVeTeGzapD1MCYEa5WwiM98xw7FSZwedAQ==
X-Received: by 2002:a17:902:8491:b0:183:c3d2:2112 with SMTP id c17-20020a170902849100b00183c3d22112mr4773643plo.133.1666122789257;
        Tue, 18 Oct 2022 12:53:09 -0700 (PDT)
Received: from localhost.localdomain ([103.51.72.20])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79479000000b0056126b79072sm9666063pfq.21.2022.10.18.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:53:08 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on Odroid N2/N2+
Date:   Tue, 18 Oct 2022 19:51:19 +0000
Message-Id: <20221018195122.8877-1-linux.amoon@gmail.com>
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
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index fd3fa82e4c33..e61a4285a910 100644
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
+		ddr_active: cpu-active {
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

