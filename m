Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD0C677F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjAWPQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjAWPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D4274B6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so6628557wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHfgAA7OAQIvUcUxQlsv6bkKlA5JQEtec2yYoAt35BU=;
        b=suPnw4I/jViCqE4sFKqw5HP2qWRgOG8dZrN6JLySIEDSWF/7nw4xp+pSqiIya4ZYOC
         6RotZchWHcmiu68TGahWPi1PAxKfLmUay/5xwv2igGU8IgofmeRHWbraGrx22Kuw6rc6
         ffeDnHiTPXw/6wsnHE463osgiHdKHltVvvA8cEB4PImh0f9Qoy3NZaLEmUH30VO1MfN2
         LQeE8Ha1N5qFagcbQKJZFFKvxlBaYlzWmxC2QErzuI1FgbptteIj8DKC3N5WD2IvEaZn
         A2QYBYyf6O/YS7HUHAY5X87/E2ZS8knyUixgAVOi5FJATXhCdF0V2vWmR9cJ4buPY+MP
         nz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHfgAA7OAQIvUcUxQlsv6bkKlA5JQEtec2yYoAt35BU=;
        b=ef2xwgDjbXYl1RLmnIjOQZrY2oSJsE0ObYG0ubGl1U2Ic2lsEK0O0An6/Z/klLRgqf
         +gHscNFVwNmpB2H5Nn/LGP0VhTQ2Q4CvUkXK9bTgadlp2C8hrF5aMxFmwsYIeFnzaH29
         42caIRgMHk6nfatvc11ih/hfFQwgCkFU5oymxgDRZVHzcEIEcVM8xABigqNBDwW6ztRA
         RGBr6oxqe1BVfBwp0J7WiLwe0zh6CWiIIPxPUK+3Cv4ZxaJQ8G5ZuMYWFOfLTyP/WWCw
         ziz1CZ/JD2RQqHKzg2AcCMJ8aaO7tM7CL49tTCEs1enm2fyl6uCxZm0P+v1yFuBsZ5xS
         YxzA==
X-Gm-Message-State: AFqh2koh68fp2QmFf0NEQwN5WmlgyyuI4RbhHKWBl9MqLTFnYBjmaPC1
        9/+lxZCZBQfXoe9oaingiJslJA==
X-Google-Smtp-Source: AMrXdXvL30zLCjVjzFFrYWpWHR1KpGK/rChw+v5yQJJOXNCEjz7e3P6tM92SH75k0U1zPp2cm3Sbyg==
X-Received: by 2002:a5d:5646:0:b0:2bf:963a:f266 with SMTP id j6-20020a5d5646000000b002bf963af266mr8711203wrw.27.1674486923024;
        Mon, 23 Jan 2023 07:15:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b002bbb2d43f65sm3184124wrw.14.2023.01.23.07.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: socfpga: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:21 +0100
Message-Id: <20230123151521.369188-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/socfpga.dtsi         | 4 ++--
 arch/arm/boot/dts/socfpga_arria10.dtsi | 4 ++--
 arch/arm/boot/dts/socfpga_vt.dts       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 3fee80bbae21..4c1d140f40f8 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -905,7 +905,7 @@ timer3: timer3@ffd01000 {
 			reset-names = "timer";
 		};
 
-		uart0: serial0@ffc02000 {
+		uart0: serial@ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x1000>;
 			interrupts = <0 162 4>;
@@ -918,7 +918,7 @@ uart0: serial0@ffc02000 {
 			resets = <&rst UART0_RESET>;
 		};
 
-		uart1: serial1@ffc03000 {
+		uart1: serial@ffc03000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc03000 0x1000>;
 			interrupts = <0 163 4>;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 3b2a2c9c6547..72c55e5187ca 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -845,7 +845,7 @@ timer3: timer3@ffd00100 {
 			reset-names = "timer";
 		};
 
-		uart0: serial0@ffc02000 {
+		uart0: serial@ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x100>;
 			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -856,7 +856,7 @@ uart0: serial0@ffc02000 {
 			status = "disabled";
 		};
 
-		uart1: serial1@ffc02100 {
+		uart1: serial@ffc02100 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02100 0x100>;
 			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index 3d0d806888b7..845ab2cc5ce6 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -57,11 +57,11 @@ timer3@ffd01000 {
 			clock-frequency = <7000000>;
 		};
 
-		serial0@ffc02000 {
+		serial@ffc02000 {
 			clock-frequency = <7372800>;
 		};
 
-		serial1@ffc03000 {
+		serial@ffc03000 {
 			clock-frequency = <7372800>;
 		};
 
-- 
2.34.1

