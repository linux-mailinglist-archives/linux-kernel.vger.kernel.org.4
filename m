Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700E67E15F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjA0KSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjA0KSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:18:32 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004D146AF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k16so3088833wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyF1uDKLmVnYezPgLe+itwoNDSKSxafbXq3CcgRX0+8=;
        b=KKDHJXoNlxQgyWUCnyh5lFbnu7GVYjh05n+a962cLd6oCvwb8kb5beoTtzSpjAQqIB
         H39KtIY7uBjj14t9xeqGSldf7HYD/C2+gSWdzvazapQMjEKDgv7LwyPvfz8WcvaxWZWR
         eItJDauwnp0ktik2f2rgIS8FsJVps+WXnjxGeoHEONcilRtRYymyyDwuG1K48DJk9A30
         ymzLpZxODqWZaOBuuvx7JoLIpjgTgBvoS0zkox7UIg8QFxpKQtm7vpJw0JtXH9/Js83b
         kJyxZeRjrlQpF1jKuY6gkYXTNIY+D9h1ogpGtywzLz14ah2kcWMMr4neRXpyri0vjfBF
         0HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyF1uDKLmVnYezPgLe+itwoNDSKSxafbXq3CcgRX0+8=;
        b=cq6nXnzpTy66m0N57lca3Tj0z3OP17ezPD+kfIWrRlgWTOZXy3GTvNHR8/oF/QYPG3
         mYegQoklc1eNynKFoKJTeotnKGfuCUSluIxrt6F1OUO/Fenqe8MVQs7sztLpHJyyoFgS
         zzjFgNcMSC9jPrvO8Slbnh3fcKQhoxgrcqUS+KKIVEKT62MY2zPHzBvt+x1gx3RHhla1
         /+Tsz9Yuoi+IOZZO+Xu3tnRwPBU5ck3S2bksJtX+z7/hDPaTaUsTVEjB0yl4Q2F2G88Y
         4txfG3hgKGIQ7k4Z6hNwAs+xGaVHhUx/5S8sFnBO/8Dyy//SmSVq4DhStcSY9wvC/qjx
         4NFg==
X-Gm-Message-State: AO0yUKUDUwpY/7H1jq5YkKy6smfUtJUhyBfubgVLwHz/19BoVAHhHsnj
        w797TssudD+LixiOKVstzS5D5WXbU/ReIuEo
X-Google-Smtp-Source: AK7set/2vMzZO1lhhs37wTScio8JmsV/p/w5C5OLgHJ7qhDSExpQH/BGDdQa8Jgmn5Tgoevmu1ah8Q==
X-Received: by 2002:a05:600c:5022:b0:3dc:3398:cf7f with SMTP id n34-20020a05600c502200b003dc3398cf7fmr2227541wmr.26.1674814709265;
        Fri, 27 Jan 2023 02:18:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c05c800b003c65c9a36dfsm3752368wmd.48.2023.01.27.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:18:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: apm: use "okay" for status
Date:   Fri, 27 Jan 2023 11:18:27 +0100
Message-Id: <20230127101827.93728-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"okay" over "ok" is preferred for status property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/apm/apm-merlin.dts  | 16 ++++++++--------
 arch/arm64/boot/dts/apm/apm-mustang.dts | 16 ++++++++--------
 arch/arm64/boot/dts/apm/apm-storm.dtsi  | 12 ++++++------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-merlin.dts b/arch/arm64/boot/dts/apm/apm-merlin.dts
index 049e7a5edca7..2e8069002ec1 100644
--- a/arch/arm64/boot/dts/apm/apm-merlin.dts
+++ b/arch/arm64/boot/dts/apm/apm-merlin.dts
@@ -45,38 +45,38 @@ poweroff: poweroff@10548010 {
 };
 
 &serial0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata1 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata2 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata3 {
-	status = "ok";
+	status = "okay";
 };
 
 &sgenet0 {
-	status = "ok";
+	status = "okay";
 };
 
 &xgenet1 {
-	status = "ok";
+	status = "okay";
 };
 
 &mmc0 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c4 {
 	rtc68: rtc@68 {
 		compatible = "dallas,ds1337";
 		reg = <0x68>;
-		status = "ok";
+		status = "okay";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index efac50aeca64..033e10e12b18 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -45,36 +45,36 @@ poweroff: poweroff@10548010 {
 };
 
 &pcie0clk {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie0 {
-	status = "ok";
+	status = "okay";
 };
 
 &serial0 {
-	status = "ok";
+	status = "okay";
 };
 
 &menet {
-	status = "ok";
+	status = "okay";
 };
 
 &sgenet0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sgenet1 {
-	status = "ok";
+	status = "okay";
 };
 
 &xgenet {
-	status = "ok";
+	status = "okay";
 	rxlos-gpios = <&sbgpio 12 1>;
 };
 
 &mmc0 {
-	status = "ok";
+	status = "okay";
 };
 
 &mdio {
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 2083b54adee6..d73e809fe41a 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -270,7 +270,7 @@ sataphy2clk: sataphy1clk@1f22c000 {
 				reg = <0x0 0x1f22c000 0x0 0x1000>;
 				reg-names = "csr-reg";
 				clock-output-names = "sataphy2clk";
-				status = "ok";
+				status = "okay";
 				csr-offset = <0x4>;
 				csr-mask = <0x3a>;
 				enable-offset = <0x0>;
@@ -284,7 +284,7 @@ sataphy3clk: sataphy1clk@1f23c000 {
 				reg = <0x0 0x1f23c000 0x0 0x1000>;
 				reg-names = "csr-reg";
 				clock-output-names = "sataphy3clk";
-				status = "ok";
+				status = "okay";
 				csr-offset = <0x4>;
 				csr-mask = <0x3a>;
 				enable-offset = <0x0>;
@@ -860,7 +860,7 @@ phy2: phy@1f22a000 {
 			reg = <0x0 0x1f22a000 0x0 0x100>;
 			#phy-cells = <1>;
 			clocks = <&sataphy2clk 0>;
-			status = "ok";
+			status = "okay";
 			apm,tx-boost-gain = <30 30 30 30 30 30>;
 			apm,tx-eye-tuning = <1 10 10 2 10 10>;
 		};
@@ -870,7 +870,7 @@ phy3: phy@1f23a000 {
 			reg = <0x0 0x1f23a000 0x0 0x100>;
 			#phy-cells = <1>;
 			clocks = <&sataphy3clk 0>;
-			status = "ok";
+			status = "okay";
 			apm,tx-boost-gain = <31 31 31 31 31 31>;
 			apm,tx-eye-tuning = <2 10 10 2 10 10>;
 		};
@@ -899,7 +899,7 @@ sata2: sata@1a400000 {
 			      <0x0 0x1f227000 0x0 0x1000>;
 			interrupts = <0x0 0x87 0x4>;
 			dma-coherent;
-			status = "ok";
+			status = "okay";
 			clocks = <&sata23clk 0>;
 			phys = <&phy2 0>;
 			phy-names = "sata-phy";
@@ -913,7 +913,7 @@ sata3: sata@1a800000 {
 			      <0x0 0x1f23e000 0x0 0x1000>;
 			interrupts = <0x0 0x88 0x4>;
 			dma-coherent;
-			status = "ok";
+			status = "okay";
 			clocks = <&sata45clk 0>;
 			phys = <&phy3 0>;
 			phy-names = "sata-phy";
-- 
2.34.1

