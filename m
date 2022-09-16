Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E75BB0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIPQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiIPQDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:03:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBFB56D4;
        Fri, 16 Sep 2022 09:03:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f20so27666500edf.6;
        Fri, 16 Sep 2022 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=0tzsYhIa/dJvbCToayIrS0oYwHSfAteRC0zZoxGOrYs=;
        b=ood1pSNoIDGVsXsJLLimQBf0wBeePDy5702cPx3nGCu0Tnl5hw29tfYIC6dLIOgtyI
         FCvrpwOEjXHHFrpZ8hDRrIpUYxFl+eIS42VhT4Mj8vjyvHWojC675/LjbrLdtzIqeFMh
         f8Y5jsO50gTRwTenIEEMto21rJ2DEVR7uTQOYNUkyJFRiynrJhVfYed2GCMrrcgIoIc5
         JkAYBUZwukXx3y4hgSTK8IuDAvMvWCL6gzq9A/66QgqK1voi7i17NXA0da+TyO/VfiVF
         +FKM1XvridpgPulfJUEikthb2GszkqrgaE49V+rRINW5pHeFY73yFj0ckEeI8Phxx7UZ
         nzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0tzsYhIa/dJvbCToayIrS0oYwHSfAteRC0zZoxGOrYs=;
        b=TcxSzAUmgR86YHZrRrAm6GVpggte5MOaXyDFgjBD1/Vgdiw63CSBtJDGQrcHEZX36C
         UkvYuee2kH1GQcUbWwyaSUeVRriXFWJAV4XjamWnVcj2fAEStVFIFWPZP+I/hxPMXpNi
         V68XUP5Da5s3ehkDE0TTtfpScnr+SRXsGSrjq3DX5RUc1DC6Nt9qnd0Tp7zL81Q5XIDH
         iIq6t4ulymC3hwRo/58Ehj/KkXouAxmstnBt2XEmDJXsL2CzqcwOv3Pyh7ZoVz/NvmFi
         doJljl4xZgNNFvfP7rL0pM1TXQfvKb4Q1d62LcbXrzBHxH65ss+p0g0nCfyd33egT2tF
         1Blg==
X-Gm-Message-State: ACrzQf1ZPti2bywZQZ2lWJS5Yt9k3U9zvmfMKrwUpCuIs7HAzoYDYvXa
        iiSPB59j7RuH5JOoevG/Cgk=
X-Google-Smtp-Source: AMsMyM5npQxF7K1v7kagePkuwRUXy27ta1vg9zfBOyLq7NF5/u9kulaO10bqfVSrJZ3HjJZO6N9woQ==
X-Received: by 2002:a05:6402:34c8:b0:451:c7db:4984 with SMTP id w8-20020a05640234c800b00451c7db4984mr4523980edc.171.1663344217479;
        Fri, 16 Sep 2022 09:03:37 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id la6-20020a170907780600b0078015cebd8csm4780157ejc.117.2022.09.16.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:03:36 -0700 (PDT)
Date:   Fri, 16 Sep 2022 15:58:50 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: dts: rockchip: k3566-quartz64-a: fix names
 entries
Message-ID: <YySdOhxoFI/hkRN3@lab.hqhome163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: "No underscores in node names" general rule,
Fixes: The newly agreed on scheme for regulators to have
"-regulator" at the end

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index d943559b157c..a30b17fd3c27 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -28,7 +28,7 @@ gmac1_clkin: external-gmac1-clock {
 		#clock-cells = <0>;
 	};
 
-	fan: gpio_fan {
+	fan: gpio-fan {
 		compatible = "gpio-fan";
 		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
 		gpio-fan,speed-map = <0    0
@@ -38,7 +38,7 @@ fan: gpio_fan {
 		#cooling-cells = <2>;
 	};
 
-	hdmi-con {
+	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
 
@@ -116,7 +116,7 @@ simple-audio-card,codec {
 		};
 	};
 
-	vcc12v_dcin: vcc12v_dcin {
+	vcc12v_dcin: vcc12v-dcin-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
@@ -139,7 +139,7 @@ vbus: vbus {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
+	vcc3v3_pcie_p: vcc3v3-p-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
@@ -151,7 +151,7 @@ vcc3v3_pcie_p: vcc3v3-pcie-p-regulator {
 		vin-supply = <&vcc_3v3>;
 	};
 
-	vcc5v0_usb: vcc5v0_usb {
+	vcc5v0_usb: vcc5v0-usb-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -165,7 +165,7 @@ vcc5v0_usb: vcc5v0_usb {
 	 * the host ports are sourced from vcc5v0_usb
 	 * the otg port is sourced from vcc5v0_midu
 	 */
-	vcc5v0_usb20_host: vcc5v0_usb20_host {
+	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -177,7 +177,7 @@ vcc5v0_usb20_host: vcc5v0_usb20_host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
-	vcc5v0_usb20_otg: vcc5v0_usb20_otg {
+	vcc5v0_usb20_otg: vcc5v0-usb20-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
@@ -187,7 +187,7 @@ vcc5v0_usb20_otg: vcc5v0_usb20_otg {
 		vin-supply = <&dcdc_boost>;
 	};
 
-	vcc3v3_sd: vcc3v3_sd {
+	vcc3v3_sd: vcc3v3-sd-regulator {
 		compatible = "regulator-fixed";
 		enable-active-low;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
@@ -201,7 +201,7 @@ vcc3v3_sd: vcc3v3_sd {
 	};
 
 	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
-	vcc_sys: vcc_sys {
+	vcc_sys: vcc-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
 		regulator-always-on;
@@ -212,7 +212,7 @@ vcc_sys: vcc_sys {
 	};
 
 	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
-	vcc_wl: vcc_wl {
+	vcc_wl: vcc-wl-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_wl";
 		regulator-always-on;
@@ -249,7 +249,7 @@ &cpu3 {
 
 &cpu_thermal {
 	trips {
-		cpu_hot: cpu_hot {
+		cpu_hot: cpu-hot {
 			temperature = <55000>;
 			hysteresis = <2000>;
 			type = "active";
-- 
2.34.1

