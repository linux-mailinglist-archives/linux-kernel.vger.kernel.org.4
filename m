Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD3677F56
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAWPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAWPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBB32943B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l8so9275166wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHbiWI/qNowaHUXXLozc3u0DRaqYJ2VyGTaosWtQNOA=;
        b=wK/W3MYW9tq1IC1OjKAlCqXosnGSv0EZQtP5beGjlikA2URLQlsoRcAQrRi9AJNmaI
         Yp8XLy/xwjQH0aS/fqaazGVtURWNrcpiu8Q9ZJoEzddEVXqC+xwXUrjlKyDQbpmzF7qq
         aynjkgryPnWKY3k6j5Y5i3VSMnRgOIlY+S1TmIAgFAl86BM82A1VAlzG6yCiioQ9g2iw
         vsL0P7qBohSffB98+GK12L8jIM4XdpIprGw+pVR9grPzZegvlm7KQXuU8i2PBEjggfu8
         ry9dUvrmspjZ8lbvRnwBUNrFKgLDeotXRSuPn79xPsW/upfTb8ixyAFI0OYcGvVP+goE
         rT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHbiWI/qNowaHUXXLozc3u0DRaqYJ2VyGTaosWtQNOA=;
        b=xdfY/ZOlrh/e2hR3upQoGhaks5lZOOvdSTn6oEQqYcukomxNHscB/s67tafHA1vsey
         +GzkglHCDpwpt97Qgxdweivlp8SnnpaABmLWy3l6oXcSvzlGKqR5TnZouNHIcEdtz6ml
         jRef1rJ7VB1BROu/9euZncgsf8kWBSHMRsUWcqi3KEAI2U+JYTmSOT1CUGyZMPNNx4MJ
         cAg275uvbAC66yguvT/MhCk3X2Lwvt6uh593bqq+NYgwK1cvm8hFTGUmq0iBSFO3y5so
         OeAwZioWph0uE3IIRLmDtGoKsyRrKPb7uzPyuWq0ueCQU6s+sXpff94OfCnx+glYEPZs
         Myog==
X-Gm-Message-State: AFqh2kpBcNkdwgZCWYSDnajN7ceekXm6nhGXFfoMopi1ce5e6rOgVtYP
        SXIxYeaY2rgGgZCNzugJ8I+4H0ctwyB2GqLd
X-Google-Smtp-Source: AMrXdXtqXtRCQS5ADjwp8FIdQH2xhDxwu6u9W++A+Ckw44vChnBF+RxLS7qT6tyUwCMjhYfiTWNiTQ==
X-Received: by 2002:a7b:cbd6:0:b0:3db:622:4962 with SMTP id n22-20020a7bcbd6000000b003db06224962mr24328410wmi.21.1674486945000;
        Mon, 23 Jan 2023 07:15:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b003db32ccf4bfsm10987124wmq.41.2023.01.23.07.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: tegra: drop serial clock-names and reset-names
Date:   Mon, 23 Jan 2023 16:15:43 +0100
Message-Id: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
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

The serial node does not use clock-names and reset-names:

  tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not allowed ('clock-names', 'reset-names' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 8 --------
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 --
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ----
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 8 --------
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 --
 5 files changed, 24 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index c017764bc27e..8b78be8f4f9d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -338,9 +338,7 @@ uarta: serial@70006000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTA>;
-		clock-names = "serial";
 		resets = <&tegra_car 6>;
-		reset-names = "serial";
 		dmas = <&apbdma 8>, <&apbdma 8>;
 		dma-names = "rx", "tx";
 		status = "disabled";
@@ -352,9 +350,7 @@ uartb: serial@70006040 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTB>;
-		clock-names = "serial";
 		resets = <&tegra_car 7>;
-		reset-names = "serial";
 		dmas = <&apbdma 9>, <&apbdma 9>;
 		dma-names = "rx", "tx";
 		status = "disabled";
@@ -366,9 +362,7 @@ uartc: serial@70006200 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTC>;
-		clock-names = "serial";
 		resets = <&tegra_car 55>;
-		reset-names = "serial";
 		dmas = <&apbdma 10>, <&apbdma 10>;
 		dma-names = "rx", "tx";
 		status = "disabled";
@@ -380,9 +374,7 @@ uartd: serial@70006300 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTD>;
-		clock-names = "serial";
 		resets = <&tegra_car 65>;
-		reset-names = "serial";
 		dmas = <&apbdma 19>, <&apbdma 19>;
 		dma-names = "rx", "tx";
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0216b565a370..995276ef55eb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -610,9 +610,7 @@ uarta: serial@3100000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&bpmp TEGRA186_CLK_UARTA>;
-		clock-names = "serial";
 		resets = <&bpmp TEGRA186_RESET_UARTA>;
-		reset-names = "serial";
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 5ce2650128b1..b9092790c811 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -745,9 +745,7 @@ uarta: serial@3100000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTA>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTA>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
@@ -757,9 +755,7 @@ uartb: serial@3110000 {
 			reg-shift = <2>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA194_CLK_UARTB>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA194_RESET_UARTB>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 980565bf02c9..0e463b3cbe01 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -618,9 +618,7 @@ uarta: serial@70006000 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_UARTA>;
-		clock-names = "serial";
 		resets = <&tegra_car 6>;
-		reset-names = "serial";
 		dmas = <&apbdma 8>, <&apbdma 8>;
 		dma-names = "rx", "tx";
 		status = "disabled";
@@ -632,9 +630,7 @@ uartb: serial@70006040 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_UARTB>;
-		clock-names = "serial";
 		resets = <&tegra_car 7>;
-		reset-names = "serial";
 		dmas = <&apbdma 9>, <&apbdma 9>;
 		dma-names = "rx", "tx";
 		status = "disabled";
@@ -646,9 +642,7 @@ uartc: serial@70006200 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_UARTC>;
-		clock-names = "serial";
 		resets = <&tegra_car 55>;
-		reset-names = "serial";
 		dmas = <&apbdma 10>, <&apbdma 10>;
 		dma-names = "rx", "tx";
 		status = "disabled";
@@ -660,9 +654,7 @@ uartd: serial@70006300 {
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_UARTD>;
-		clock-names = "serial";
 		resets = <&tegra_car 65>;
-		reset-names = "serial";
 		dmas = <&apbdma 19>, <&apbdma 19>;
 		dma-names = "rx", "tx";
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index b54353f31df5..372be226a7f4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -676,9 +676,7 @@ uarta: serial@3100000 {
 			reg = <0x0 0x03100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&bpmp TEGRA234_CLK_UARTA>;
-			clock-names = "serial";
 			resets = <&bpmp TEGRA234_RESET_UARTA>;
-			reset-names = "serial";
 			status = "disabled";
 		};
 
-- 
2.34.1

