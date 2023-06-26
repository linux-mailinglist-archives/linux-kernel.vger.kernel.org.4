Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A29673EE89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFZWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFZWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:12:26 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA9AB;
        Mon, 26 Jun 2023 15:10:26 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-78374596182so1369339f.0;
        Mon, 26 Jun 2023 15:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817426; x=1690409426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU8j8+yqJIJIF3vjqAOZ5LrMZVY0whLH7n/GxQentKA=;
        b=BqpleR/ZEgJK9TgH/HJMPicgCmGE4sHyxhcScchm/U2rSKaS6qgI8CsWHeNyDDi+p3
         wMR+Ys7Q3/+wKmyXqR/q4jxOD+/Q6estG0bl9kvpIa2ug9tpxcjYzrdYXDv77xINxle3
         7x4D7yAaoFv1A5Zj5hN87vi+L0bRepsMgQHkb4qdbecQeESRRNY/nT09RfZvtXPc+HCF
         WTP4wzp43Utn+tuN/vOol2DPiosF48OKHHd/5fTiy8ZScjj2iNaor/ls7zshjGuzU/X3
         dYI5mySKOpStnFcH/4zuj9AddnvVBPZr+XMNzjfEBsUJHGZ10lAVXlDJ/HT3tC+qqoVr
         b02Q==
X-Gm-Message-State: AC+VfDxjAz8ehFX1h/qsdzzwiqrhECX1jw+7Xv1F5vDfh8gA4GfffCeG
        6d1lFG8ram2uzxJ5DdBnGA==
X-Google-Smtp-Source: ACHHUZ7SF/xsjff108KmVgcFxTtSeY8F5BTN4CnoW4AUKK9DR4gweGGpfQ9/jk4pRFnNAgKQxgl7mQ==
X-Received: by 2002:a6b:e90c:0:b0:780:d263:7500 with SMTP id u12-20020a6be90c000000b00780d2637500mr11667053iof.20.1687817425968;
        Mon, 26 Jun 2023 15:10:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t9-20020a028789000000b0041f4ce6e9cdsm2047871jai.65.2023.06.26.15.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:10:25 -0700 (PDT)
Received: (nullmailer pid 3946567 invoked by uid 1000);
        Mon, 26 Jun 2023 22:10:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: hisilicon: Fix "status" values
Date:   Mon, 26 Jun 2023 16:10:19 -0600
Message-Id: <20230626221019.3946448-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defined value for "status" is "disabled", not "disable".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/hisilicon/hi3519.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/hisilicon/hi3519.dtsi b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
index c524c854d319..a42b71cdc5d7 100644
--- a/arch/arm/boot/dts/hisilicon/hi3519.dtsi
+++ b/arch/arm/boot/dts/hisilicon/hi3519.dtsi
@@ -54,7 +54,7 @@ uart0: serial@12100000 {
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HI3519_UART0_CLK>, <&crg HI3519_UART0_CLK>;
 			clock-names = "uartclk", "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		uart1: serial@12101000 {
@@ -63,7 +63,7 @@ uart1: serial@12101000 {
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HI3519_UART1_CLK>, <&crg HI3519_UART1_CLK>;
 			clock-names = "uartclk", "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		uart2: serial@12102000 {
@@ -72,7 +72,7 @@ uart2: serial@12102000 {
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HI3519_UART2_CLK>, <&crg HI3519_UART2_CLK>;
 			clock-names = "uartclk", "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		uart3: serial@12103000 {
@@ -81,7 +81,7 @@ uart3: serial@12103000 {
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HI3519_UART3_CLK>, <&crg HI3519_UART3_CLK>;
 			clock-names = "uartclk", "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		uart4: serial@12104000 {
@@ -90,7 +90,7 @@ uart4: serial@12104000 {
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HI3519_UART4_CLK>, <&crg HI3519_UART4_CLK>;
 			clock-names = "uartclk", "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		dual_timer0: timer@12000000 {
@@ -100,7 +100,7 @@ dual_timer0: timer@12000000 {
 			reg = <0x12000000 0x1000>;
 			clocks = <&clk_3m>;
 			clock-names = "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		dual_timer1: timer@12001000 {
@@ -110,7 +110,7 @@ dual_timer1: timer@12001000 {
 			reg = <0x12001000 0x1000>;
 			clocks = <&clk_3m>;
 			clock-names = "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		dual_timer2: timer@12002000 {
@@ -120,7 +120,7 @@ dual_timer2: timer@12002000 {
 			reg = <0x12002000 0x1000>;
 			clocks = <&clk_3m>;
 			clock-names = "apb_pclk";
-			status = "disable";
+			status = "disabled";
 		};
 
 		spi_bus0: spi@12120000 {
@@ -132,7 +132,7 @@ spi_bus0: spi@12120000 {
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		spi_bus1: spi@12121000 {
@@ -144,7 +144,7 @@ spi_bus1: spi@12121000 {
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		spi_bus2: spi@12122000 {
@@ -156,7 +156,7 @@ spi_bus2: spi@12122000 {
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		sysctrl: system-controller@12020000 {
-- 
2.40.1

