Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A55EAF97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIZSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIZSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:22:16 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7DA20BD5;
        Mon, 26 Sep 2022 11:18:47 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.195])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 038428000E4;
        Tue, 27 Sep 2022 02:01:24 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     linux.amoon@gmail.com
Cc:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        michael.riesch@wolfvision.net, robh+dt@kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/3] arm64: dts: rockchip: Add regulator suffix to rock-3a
Date:   Tue, 27 Sep 2022 02:01:00 +0800
Message-Id: <20220926180102.37614-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926180102.37614-1-amadeus@jmu.edu.cn>
References: <20220926061420.1248-1-linux.amoon@gmail.com>
 <20220926180102.37614-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSRhMVkNOTRhITU9NSk9DSVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJOWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46EBw6Aj0oUQhWOikRSR8p
        OAoKCi9VSlVKTU1PSUpOSUNOTUlCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJOWVdZCAFZQUhMS0M3Bg++
X-HM-Tid: 0a837af5fdf9b03akuuu038428000e4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -regulator suffix to regulator names on Radxa ROCK3 Model A
board. This makes the naming more consistent.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index fb87a168fe96..8adf672709e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -60,7 +60,7 @@ simple-audio-card,codec {
 		};
 	};
 
-	vcc12v_dcin: vcc12v-dcin {
+	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -79,7 +79,7 @@ vcc3v3_pcie: vcc3v3-pcie-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: vcc3v3-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -89,7 +89,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: vcc5v0-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -99,7 +99,7 @@ vcc5v0_sys: vcc5v0-sys {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc5v0_usb: vcc5v0-usb {
+	vcc5v0_usb: vcc5v0-usb-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -109,7 +109,7 @@ vcc5v0_usb: vcc5v0-usb {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc5v0_usb_host: vcc5v0-usb-host {
+	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -144,7 +144,7 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
-	vcc_cam: vcc-cam {
+	vcc_cam: vcc-cam-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
@@ -160,7 +160,7 @@ regulator-state-mem {
 		};
 	};
 
-	vcc_mipi: vcc-mipi {
+	vcc_mipi: vcc-mipi-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
-- 
2.25.1

