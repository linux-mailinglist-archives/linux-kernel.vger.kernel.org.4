Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77003657517
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiL1KFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiL1KFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C171004C;
        Wed, 28 Dec 2022 02:05:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n4so15661309plp.1;
        Wed, 28 Dec 2022 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3xQEZHxsyANIGoODmNVjsjeyx1NMMrnI1xGIfGuTuo=;
        b=XtS8+r1Iur/AdNm/wzdsGhQS7RnCEgs1MyY2YbZGgbt122+fsGuJSzc/j9KP6ezmnq
         nNS7MWWhdD5E9dJaL3kWWylVGgGB80K89KpXIgPznDXhJ8IGtliF2R9zHKuEoWYiwZfo
         YPxvDwJElMdaJcdM1g1dgxzPHZobHasK6JfkP6UHyVb2Q3DWYbatJWtJbJyMBOZHyISx
         d0m6UojgOIgAUY5GWaWRvK/GCUAPUQOsinBXphlSu6+PHwqHm83uGnNOvXBIpJRJXYn5
         b8rwswwSXJWMTtuQZ3LikoZtS3PCWUM5zvC0/rbhRtZCTW8RmujeyN3I7hvwzfguEGoA
         IcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3xQEZHxsyANIGoODmNVjsjeyx1NMMrnI1xGIfGuTuo=;
        b=fLeKPIPX48KlhWIff2AAiJEDrYFjFaB+8jXUtBgl3l9b+91aT+Yv/qX16S4HLdLWy3
         yBCItU8QjrXuJ3Od4Z1b3SyCyrVC4i6UooMs9/a/ml4tO1B7kMKcWh91zvTygb9BnxQO
         00s2kJusv1NFeLwU+HBYcur5ZNkeU+uG15XtrEGmPCHE2GMKYSeS7qdiupUmkqU1Nf4W
         iNI+PFB55F2ZqJUtic2Gy52esrGJOqLAvbc/HHhNRVqCFkzOBi9ow29jKrTVmbMpxDTk
         NRc8b5g5b3yh/FqsrSXXhpRzo+f0fFQlGkI/jGLeatXn04KIXwbYxyozG6JosCgFTcjX
         KzkQ==
X-Gm-Message-State: AFqh2kpEcKxfX5xqQ/YAtd9XMxkonyOkdsb/7ot1ZRECzp7fLWlGiNR7
        dF+Qe+Xj+I0T827DWC0yFtw=
X-Google-Smtp-Source: AMrXdXtSp/7y+cp2k4LknDET+kk81AS3xXLr7aiUHAdtj0txF0OuGUiSqXLwarIXL4mlrjayblOkZw==
X-Received: by 2002:a17:902:ecc1:b0:192:760f:c35e with SMTP id a1-20020a170902ecc100b00192760fc35emr14421541plh.53.1672221914056;
        Wed, 28 Dec 2022 02:05:14 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:13 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/11] ARM: dts: amlogic: Used onboard usb hub reset to enable usb hub
Date:   Wed, 28 Dec 2022 10:03:11 +0000
Message-Id: <20221228100321.15949-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
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

On Odroid c1 previously use gpio-hog to reset the usb hub,
switch to used on board usb hub reset to enable the usb hub
and enable power to usb hub.

Add usb hub regulator as per the schematic.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 40 +++++++++++++++++---------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 04356bc639fa..3b29169aac43 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -185,6 +185,33 @@ vdd_rtc: regulator-vdd-rtc {
 
 		vin-supply = <&vcc_3v3>;
 	};
+
+	usb_otg_pwr: regulator-usb-pwrs {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_OTG_PWR";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		/* signal name from schematics: PWREN */
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&p5v0>;
+	};
+
+	usb {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub@1 {
+			/* Genesys Logic GL852G-OHG usb hub */
+			compatible = "genesys,usb5e3,610";
+			reg = <1>;
+			vdd-supply = <&usb_otg_pwr>;
+			reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &cpu0 {
@@ -281,19 +308,6 @@ &gpio_ao {
 			  "J7 Header Pin 6", "J7 Header Pin 5",
 			  "J7 Header Pin 7", "HDMI_CEC",
 			  "SYS_LED", "", "";
-
-	/*
-	 * WARNING: The USB Hub on the Odroid-C1/C1+ needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller.
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	usb-hub {
-		gpio-hog;
-		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
 };
 
 &ir_receiver {
-- 
2.38.1

