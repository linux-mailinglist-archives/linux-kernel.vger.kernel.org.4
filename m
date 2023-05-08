Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07AD6FB07C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjEHMpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjEHMph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:45:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6B189;
        Mon,  8 May 2023 05:45:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3063b5f32aaso2846885f8f.2;
        Mon, 08 May 2023 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683549934; x=1686141934;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hOhOxkG7BZ4qWykY9UtvQLlVfaHXvEwqjgnjNpsvIs=;
        b=pkbseLmOjhh5CrDdFBI6wK4YQFp9Is3m30nb7ubrDjWmmkP+pa582C2089+qsBzZ5c
         4q5CoN4iXRrTTqUFoNFW1JV63rwpCTLbQu1l/dRkNaikvQnrNOTC3mNQ0+pzoaGY3q9p
         ex6NKyqHdAx09IGCP+6RcHa4TiZN4Y49VZBWNrlfL3moYh/lAFIp1082THAVTJeYCsTP
         O9eOpvgGRXMzEU9wQutvCuOvusC1aiHdMb00gMk5VJVWyE+x7mbQZnr8rPV8XQW/gTux
         gJCc930/7xytB8cJw2Zeo1weJsV7nWocuZhaSLhkWNJ6uioabvotVaTtHIkcZmw5zTsq
         bN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683549934; x=1686141934;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hOhOxkG7BZ4qWykY9UtvQLlVfaHXvEwqjgnjNpsvIs=;
        b=WSlnuym/KwqHlKDlt2iKuUqfdNpY214OgyLHIWkwApzQKn558QdFvecTFlG3d2Md8J
         PW1/t3hTgCKhHQ0hDiXvPZoF0xrgXCXO6R8mKGin70bj2CI73aWSYxfViW/c1EImIak0
         0+MIXeOj2WeZp7MX0Gpxzyw4zDkwPdNEi02Nt+u/Md7oiA0GBz3spaYSBe34dNAeCGcU
         dPYuYoZlV98MrM7WjC680veL3ozvkqlCddWqGHXX/dNbpzGmQyvKMBunK3IsKIdQC+Wd
         ztKKiCbA8o2MCIoHAoj2qDDOULn0HTn24kQ1QWwWdSfTdvLjCptFFKf7Dcg5aZyuyPFl
         fVbw==
X-Gm-Message-State: AC+VfDySduM00VU3v/M+fTOKZZrq8T8F0oWBKP7qj/ZU+05MJQbdMR1X
        YuIu8OJOo55gDUR3idOuGM0=
X-Google-Smtp-Source: ACHHUZ7cveukaiYu5ylC2OGZ0rwjlUADg5fgKWKViHX8bjLf/wjsG+Knq2paEmRFn/e3PfBFDLYElA==
X-Received: by 2002:adf:d0c7:0:b0:306:3711:11d7 with SMTP id z7-20020adfd0c7000000b00306371111d7mr6787225wrh.48.1683549934395;
        Mon, 08 May 2023 05:45:34 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5052000000b003078c535277sm6703827wrt.91.2023.05.08.05.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:45:34 -0700 (PDT)
Date:   Mon, 8 May 2023 14:45:32 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: bcm-mobile: align SDHCI node name with bindings
Message-ID: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect SDHCI/MMC node names to be "mmc".

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm/boot/dts/bcm11351.dtsi       | 8 ++++----
 arch/arm/boot/dts/bcm21664-garnet.dts | 6 +++---
 arch/arm/boot/dts/bcm21664.dtsi       | 8 ++++----
 arch/arm/boot/dts/bcm23550.dtsi       | 8 ++++----
 arch/arm/boot/dts/bcm28155-ap.dts     | 4 ++--
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index ba75784d66a9..c30ff1b02e03 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -125,7 +125,7 @@ GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH
 		interrupt-controller;
 	};
 
-	sdio1: sdio@3f180000 {
+	sdio1: mmc@3f180000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f180000 0x10000>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -133,7 +133,7 @@ sdio1: sdio@3f180000 {
 		status = "disabled";
 	};
 
-	sdio2: sdio@3f190000 {
+	sdio2: mmc@3f190000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f190000 0x10000>;
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -141,7 +141,7 @@ sdio2: sdio@3f190000 {
 		status = "disabled";
 	};
 
-	sdio3: sdio@3f1a0000 {
+	sdio3: mmc@3f1a0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1a0000 0x10000>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -149,7 +149,7 @@ sdio3: sdio@3f1a0000 {
 		status = "disabled";
 	};
 
-	sdio4: sdio@3f1b0000 {
+	sdio4: mmc@3f1b0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x10000>;
 		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/bcm21664-garnet.dts b/arch/arm/boot/dts/bcm21664-garnet.dts
index cd03fa0c2aae..dead91d97b63 100644
--- a/arch/arm/boot/dts/bcm21664-garnet.dts
+++ b/arch/arm/boot/dts/bcm21664-garnet.dts
@@ -20,18 +20,18 @@ serial@3e000000 {
 		status = "okay";
 	};
 
-	sdio1: sdio@3f180000 {
+	sdio1: mmc@3f180000 {
 		max-frequency = <48000000>;
 		status = "okay";
 	};
 
-	sdio2: sdio@3f190000 {
+	sdio2: mmc@3f190000 {
 		non-removable;
 		max-frequency = <48000000>;
 		status = "okay";
 	};
 
-	sdio4: sdio@3f1b0000 {
+	sdio4: mmc@3f1b0000 {
 		max-frequency = <48000000>;
 		cd-gpios = <&gpio 91 GPIO_ACTIVE_LOW>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index ed4de031e48e..4e96656dc36a 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -113,7 +113,7 @@ GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH
 		interrupt-controller;
 	};
 
-	sdio1: sdio@3f180000 {
+	sdio1: mmc@3f180000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f180000 0x801c>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -121,7 +121,7 @@ sdio1: sdio@3f180000 {
 		status = "disabled";
 	};
 
-	sdio2: sdio@3f190000 {
+	sdio2: mmc@3f190000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f190000 0x801c>;
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -129,7 +129,7 @@ sdio2: sdio@3f190000 {
 		status = "disabled";
 	};
 
-	sdio3: sdio@3f1a0000 {
+	sdio3: mmc@3f1a0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1a0000 0x801c>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -137,7 +137,7 @@ sdio3: sdio@3f1a0000 {
 		status = "disabled";
 	};
 
-	sdio4: sdio@3f1b0000 {
+	sdio4: mmc@3f1b0000 {
 		compatible = "brcm,kona-sdhci";
 		reg = <0x3f1b0000 0x801c>;
 		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/bcm23550.dtsi
index a36c9b1d23c8..8d96bdc4a8e5 100644
--- a/arch/arm/boot/dts/bcm23550.dtsi
+++ b/arch/arm/boot/dts/bcm23550.dtsi
@@ -224,7 +224,7 @@ usbphy: usb-phy@e30000 {
 			status = "disabled";
 		};
 
-		sdio1: sdio@e80000 {
+		sdio1: mmc@e80000 {
 			compatible = "brcm,kona-sdhci";
 			reg = <0x00e80000 0x801c>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -232,7 +232,7 @@ sdio1: sdio@e80000 {
 			status = "disabled";
 		};
 
-		sdio2: sdio@e90000 {
+		sdio2: mmc@e90000 {
 			compatible = "brcm,kona-sdhci";
 			reg = <0x00e90000 0x801c>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -240,7 +240,7 @@ sdio2: sdio@e90000 {
 			status = "disabled";
 		};
 
-		sdio3: sdio@ea0000 {
+		sdio3: mmc@ea0000 {
 			compatible = "brcm,kona-sdhci";
 			reg = <0x00ea0000 0x801c>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -248,7 +248,7 @@ sdio3: sdio@ea0000 {
 			status = "disabled";
 		};
 
-		sdio4: sdio@eb0000 {
+		sdio4: mmc@eb0000 {
 			compatible = "brcm,kona-sdhci";
 			reg = <0x00eb0000 0x801c>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 60c8ab8a2855..c496e33a71a6 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -44,7 +44,7 @@ pmu: pmu@8 {
 		};
 	};
 
-	sdio2: sdio@3f190000 {
+	sdio2: mmc@3f190000 {
 		non-removable;
 		max-frequency = <48000000>;
 		vmmc-supply = <&camldo1_reg>;
@@ -52,7 +52,7 @@ sdio2: sdio@3f190000 {
 		status = "okay";
 	};
 
-	sdio4: sdio@3f1b0000 {
+	sdio4: mmc@3f1b0000 {
 		max-frequency = <48000000>;
 		cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
 		vmmc-supply = <&sdldo_reg>;
-- 
2.25.1

