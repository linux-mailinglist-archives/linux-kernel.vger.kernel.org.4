Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC075002E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGLHiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjGLHiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:38:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C51717;
        Wed, 12 Jul 2023 00:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ6tLcQx8LetD2G1p/J2pAxM/mDwN/amHdsTHMTuiNdD7oqXj8k8Ma278CVU29X13DXtQVQXjVDgkVbs+f+GPFoKGQ7VUaqNWb96s39GdN58TvSHOxJy1tNVu2adxPrj5kXHPVfyNexXu+KA3EDC7O6wR+Y72ct2Iwt0DGzzaew5tuq79pyYbgd8E0+4rQmw+KIk0TtgZCJ9CjFblNnPr5HabBtqN8A3gjx41v8cDW/UlR8Ryd0xB0kog9ZWqmuOnqhiAmSpkEC9KsYHRa/iSOujBjUcKk5fDIlOG9Ultj6iHnakLV6dqncu0gaKn103mzt6iqQInLYLQQEJarbM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XO3dM5WHuISiWOQFPLcj/X+/hHp3U0g6oQnArdn2C2c=;
 b=euq1eWI/BQE9DmCZ1Bw4xTYyzuCydkoHyhcLROZxOL+NBcMtg+ocfxn0Padu39mJNlCEbOm7njBV702VoI6onymroQzDTUDgV5KfwyiBIscsiEk0uSVwffuCWNWIe+kSh/jXWFb/XxG9EYatEfD9DV+urKfNgh8fQKQaGmOtnitjurX7K0TkIrEDVS699BtE4qYIVsdyPCHIpOUgEdGHGC8T2nPb3rjnH/5l21Ct+0Wsx1zgqj30DLQ4NuvnAT/zcSurl45qvz8hx3rA30nFJEqN67rGSN+OLKAfIhi0CniKEDjM71/QWhx5KC/eHZ90s2UiyJFjKOUEbF/J4j7YQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XO3dM5WHuISiWOQFPLcj/X+/hHp3U0g6oQnArdn2C2c=;
 b=La6cB8ArMMVe5rhatTghpZ9I9OZB8vroS6TP5gve9qq3eGY8G2O/vAcXGm8RMYVh0rsvUpAoSU/4vHPAGPl+Z+7NTd73mETRnyHzO/UPbdvUfZpHehBBsar0JmMgdLS41jAF60x2fHkTQhvICZwu/i3Ulb9kJazAeR/xxjDKE0ZF/8rxFLz/EBpFM5SSr7PKfpjeZYo7ZMqiG2w03ZE0Tl74s+PnK9SjZC5C7hPXO9si9ftJ3E0y6aUojFjtSmxUwmD3cqomya6OaFF0Vp9XuuJJVJ6ecS3EfS5f/VkGKbpoC10dmw75VlejCMDWqZrQH5bgswhZ4oQymv+GVWvs5g==
Received: from SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23) by
 SI2PR04MB6618.apcprd04.prod.outlook.com (2603:1096:4:1fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 07:38:11 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:4:be:cafe::48) by SG3P274CA0011.outlook.office365.com
 (2603:1096:4:be::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Wed, 12 Jul 2023 07:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 07:38:11
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: aspeed: yosemitev4: add Facebook Yosemite V4 BMC
Date:   Wed, 12 Jul 2023 15:37:50 +0800
Message-Id: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712073752.54624-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230712073752.54624-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SI2PR04MB6618:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e351da70-c6e9-40e5-f8ee-08db82aaf1c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vcrGeHMf3TlAQ0KpjkTPtdfJdpzYKr73O3lbaLqOvpdY0DKLhXkgzO4mzV7C5BWYAvyFOnTtVkvSaULic5Y7tVvVfAc56mMf0W+g3NqOiBXPPqawY7EkEuxWzlf+XE6km6w89Yv8YZi367KHZSY+aIpdrgmDe/hnCnSaYRXTAZHalRVXr1mkN4Fb3N3nu59RCPDAoYo/h39/H1yTS0RqTH2QxrIZpJ2i7Oij/liG6N87ChU4yhuJ1d8S44i7yQRFLXBuJ1RPWCoAxJZBijcJIMFjGtTCOELt+Q6r23K/BO3DTGghiCmNjlpXCg/05qY4Qq77XSCzG81hFRAnSiwm1jKPpVvadWmExyZHXgxOjKeCB2xfBIaRG9YrV66DV/6yzTrZywah28R+xMmfdth8/JEwgpYIPlgVEtTYFy4vurJK+ejaOQBYF1y3P7JZmRUPiMcH72vyDPujoyvW5IInpU9bjf3b7vlmbd0DCHtheEQO82WTN35J5YNgfV6mghyz7JvuHiDA9mHb2c2zR5zAkQqOCPuvtLLTiOLTU2g+EOYxcBWkg+xIOK7hELv0Bl9RBGKlSv4FGFTK+VVK7YEY4tSPZAFBtXE02hK95g13Ux3VbnC4glSbqRgPPwiVgVaDOBK3YVViZHkRhS0nYcTZLKtyfq1Qoaa2H9qufEzI/hpjJ318ZwkzLSkSK6Tpwd9kixSNC8kv/fYHMew/KcKcw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(376002)(136003)(396003)(346002)(39860400002)(47680400002)(451199021)(36840700001)(46966006)(6486002)(6666004)(478600001)(81166007)(110136005)(356005)(82740400003)(7416002)(9316004)(8936002)(8676002)(36756003)(2906002)(5660300002)(86362001)(82310400005)(4326008)(36736006)(70206006)(40480700001)(316002)(70586007)(41300700001)(36860700001)(1076003)(26005)(6506007)(336012)(47076005)(186003)(2616005)(956004)(6512007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:38:11.2070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e351da70-c6e9-40e5-f8ee-08db82aaf1c2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6618
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to
Yosemite V4 specific devices connected to BMC SoC.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/aspeed-bmc-facebook-yosemitev4.dts    | 570 ++++++++++++++++++
 2 files changed, 571 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..871e6d271262 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1631,6 +1631,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-greatlakes.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
+	aspeed-bmc-facebook-yosemitev4.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
new file mode 100644
index 000000000000..1df151fb6ff3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev4.dts
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Yosemite V4 BMC";
+	compatible = "facebook,yosemitev4-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		serial8 = &uart9;
+	};
+
+	chosen {
+		bootargs = "console=ttyS4,57600n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				<&adc1 0>, <&adc1 1>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&uart8 {
+	status = "okay";
+};
+
+&uart9 {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc2";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <400000>;
+	multi-master;
+	adm1278@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	bus-frequency = <400000>;
+	i2cswitch@70 {
+	compatible = "nxp,pca9544";
+	idle-state = <0>;
+	i2c-mux-idle-disconnect;
+	reg = <0x70>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	bus-frequency = <400000>;
+	i2cswitch@71 {
+	compatible = "nxp,pca9544";
+	idle-state = <0>;
+	i2c-mux-idle-disconnect;
+	reg = <0x71>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&i2c11 {
+	status = "okay";
+	bus-frequency = <400000>;
+	adm1272@10 {
+		compatible = "adi, adm1272";
+		reg = <0x10>;
+	};
+
+	adm1272@12 {
+		compatible = "adi, adm1272";
+		reg = <0x12>;
+	};
+
+	pca9555@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pca9555@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tmp75@48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+
+	tmp75@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+
+	tmp75@4a {
+		compatible = "ti,tmp75";
+		reg = <0x4a>;
+	};
+
+	tmp75@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+
+	eeprom@54 {
+		compatible = "atmel,24c256";
+		reg = <0x54>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&i2c13 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&i2c14 {
+	status = "okay";
+	bus-frequency = <400000>;
+	adc128d818@1d {
+		compatible = "ti,adc128d818";
+		reg = <0x1d>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	adc128d818@35 {
+		compatible = "ti,adc128d818";
+		reg = <0x35>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	adc128d818@37 {
+		compatible = "ti,adc128d818";
+		reg = <0x37>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	ina230@40 {
+		compatible = "ti,ina230";
+		reg = <0x40>;
+	};
+
+	ina230@41 {
+		compatible = "ti,ina230";
+		reg = <0x41>;
+	};
+
+	ina230@42 {
+		compatible = "ti,ina230";
+		reg = <0x42>;
+	};
+
+	ina230@41 {
+		compatible = "ti,ina230";
+		reg = <0x43>;
+	};
+
+	ina230@44 {
+		compatible = "ti,ina230";
+		reg = <0x44>;
+	};
+
+	tmp75@48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+
+	tmp75@4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+
+	tmp75@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	i2cswitch@71 {
+		compatible = "nxp,pca9846";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x71>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc128d818@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <2>;
+			};
+
+			max31790@20{
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			tca6424@22{
+				compatible = "ti,tca6424";
+				reg = <0x22>;
+			};
+
+			max31790@23{
+				compatible = "max31790";
+				reg = <0x23>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			max11615@33 {
+				compatible = "maxim,max11615";
+				reg = <0x33>;
+			};
+
+			eeprom@52 {
+				compatible = "atmel,24c128";
+				reg = <0x52>;
+			};
+
+			pca9552@61 {
+				compatible = "nxp,pca9552";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc128d818@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <2>;
+			};
+
+			max31790@20{
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			tca6424@22{
+				compatible = "ti,tca6424";
+				reg = <0x22>;
+			};
+
+			max31790@23{
+				compatible = "max31790";
+				reg = <0x23>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fan-mode = "pwm";
+				fanconfig = /bits/ 8 <0x19 0x19 0x19 0x18 0x18 0x18>;
+			};
+
+			max11615@33 {
+				compatible = "maxim,max11615";
+				reg = <0x33>;
+			};
+
+			eeprom@52 {
+				compatible = "atmel,24c128";
+				reg = <0x52>;
+			};
+
+			pca9552@61 {
+				compatible = "nxp,pca9552";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+
+	i2cswitch@73 {
+		compatible = "nxp,pca9544";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x73>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			max11617@6a {
+				compatible = "maxim,max11617";
+				reg = <0x6a>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			max11617@6a {
+				compatible = "maxim,max11617";
+				reg = <0x6a>;
+			};
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+	bus-frequency = <400000>;
+};
+
+&adc0 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+			&pinctrl_adc2_default &pinctrl_adc3_default
+			&pinctrl_adc4_default &pinctrl_adc5_default
+			&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+};
+
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
-- 
2.25.1

