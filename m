Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0557A6968AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjBNP6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjBNP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:58:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3334B2BF3A;
        Tue, 14 Feb 2023 07:57:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B26B6B81E23;
        Tue, 14 Feb 2023 15:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69FD1C433A4;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676390262;
        bh=T0yrlYh6fLNBmEygIOf06ax4LoeO/yfEvilUDk3ALb0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=vJyOZJRS85OiH26Yuvz9dUda7A9oXYAjobYN/6Od0l+4sV5O7txxj8sCVw3uTKSxf
         O1QVipiWdi3So8NwVAXDrXyirSJuhQmBwhzkjuKAzVUau/vHzRoxhlnlAExBrC4eM9
         rhof3qeMFEzfoWxuL2tH5d3guOLEza2AKDylFlltPlzVIEzE9Ey273AqkXu3QIb34r
         cMcOaASPk/SsjRQlkAGpbP48R2ng4dEgr/0KYodN1dxMUeG3rTwkyHOXDqej03Bs6Z
         lJ9xwX/ZmV/fzaxMZ/oEjveDj+Y6CyNdudFWhUVEXIsZDli+kApMvPkiuLVWGXUnjT
         GLvmrlrI3nNGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 5751FC61DA4;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
From:   Sasha Finkelstein via B4 Submission Endpoint 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Tue, 14 Feb 2023 16:57:26 +0100
Subject: [PATCH RESEND 2 v7 4/5] arm64: dts: apple: t600x: Add PWM
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-fpwm-v7-4-fb0a6bfbd037@gmail.com>
References: <20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com>
In-Reply-To: <20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sasha Finkelstein <7d578vix8hzw@opayq.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676390260; l=2061;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=kC8e0IqG+WMbKwdUXKBwuQCvwcxm5IAUASQM0mxJcPI=;
 b=zGEWaepBrbPEkQW+DCCoHr+t9lOmeP0pCzkIVcJZXf01/1a4XZzv1NyxN1Mlf8HrqymEXgxpC
 UYK160mvLHrCGy8/njLg3+Tgsu8mcEYZDktFIQb2iHTSN3bXNKSk90r
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Submission Endpoint for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <7d578vix8hzw@opayq.net>

Adds PWM controller and keyboard backlight bindings for M1 Pro/Max MacBook Pros

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  9 +++++++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 1c41954e3899..9157ae2a9f7f 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -71,6 +71,15 @@ sio_dart_1: iommu@39b008000 {
 		power-domains = <&ps_sio_cpu>;
 	};
 
+	fpwm0: pwm@39b030000 {
+		compatible = "apple,t6000-fpwm", "apple,s5l-fpwm";
+		reg = <0x3 0x9b030000 0x0 0x4000>;
+		power-domains = <&ps_fpwm0>;
+		clocks = <&clkref>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
 	i2c0: i2c@39b040000 {
 		compatible = "apple,t6000-i2c", "apple,i2c";
 		reg = <0x3 0x9b040000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index 34906d522f0a..96de7165df6d 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -9,6 +9,8 @@
  * Copyright The Asahi Linux Contributors
  */
 
+#include <dt-bindings/leds/common.h>
+
 / {
 	aliases {
 		serial0 = &serial0;
@@ -34,6 +36,18 @@ memory@10000000000 {
 		device_type = "memory";
 		reg = <0x100 0 0x2 0>; /* To be filled by loader */
 	};
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm0 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
 };
 
 &serial0 {
@@ -110,5 +124,9 @@ &pcie0_dart_3 {
 	status = "disabled";
 };
 
+&fpwm0 {
+	status = "okay";
+};
+
 /delete-node/ &port02;
 /delete-node/ &port03;

-- 
Git-137.1)

