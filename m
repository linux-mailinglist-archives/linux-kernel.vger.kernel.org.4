Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006355F6A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiJFP0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiJFPZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:25:56 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CDC5F980;
        Thu,  6 Oct 2022 08:25:52 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [120.37.187.24])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 90F188000CB;
        Thu,  6 Oct 2022 23:25:46 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a
Date:   Thu,  6 Oct 2022 23:25:24 +0800
Message-Id: <20221006152524.502445-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006152524.502445-1-amadeus@jmu.edu.cn>
References: <20221006152524.502445-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThlPVklMTk8fGEtDSUMeSFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJS1VITFVKQ0xVSU9ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Ixw5Mz0pPk8MCwwBViJL
        IQ0KCi5VSlVKTU1OS01CQk9MSUtMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpJ
        S1VITFVKQ0xVSU9ZV1kIAVlBSE5LSDcG
X-HM-Tid: 0a83ade717beb03akuuu90f188000cb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nodes to Radxa ROCK3 Model A board to support PCIe v3.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 8adf672709e8..c1fa917083ba 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -67,6 +67,37 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-boot-on;
 	};
 
+	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	/* pi6c pcie clock generator */
+	vcc3v3_pi6c_03: vcc3v3-pi6c-03-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pi6c_03";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -546,6 +577,19 @@ &pcie2x1 {
 	status = "okay";
 };
 
+&pcie30phy {
+	phy-supply = <&vcc3v3_pi6c_03>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x2m1_pins>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
 &pinctrl {
 	cam {
 		vcc_cam_en: vcc_cam_en {
-- 
2.25.1

