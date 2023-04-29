Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1828A6F24EA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjD2NpP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 29 Apr 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjD2NpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:45:12 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f403:7011::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A804198A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 06:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/zAMhaOPs+Qk6e8kODoUzcVKskiENuJdzpYfrzUMtj6Zr3dg2/bIghWW2ckoqIppUIhLyeWUCMNPavtw2Oe0LYAONBYxyANX//qNb0shl5cJnPLo4MER6DahqsJQgmMNH6TlrwwoPmsoFOlJ7NHC2PqN0+pYEFfaXK4TILC9mMT1qCmeyXoECvhzHPEOd7/Ra1C7//Auyy4Ci/DGQ38ye1cKjbTAdUGNhAd/A142jaecdpe/w5y4aGt0JIkVKsIHwtqggcKP/L0CnQ1j4XAtUut9kaGd0BPuUemcn+EwsVeoRbBA/MumKFmjbaszXjb3dKQtYByFN9xtoU1SeYNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttTrU2CRxDZSDbehMvw0fB+F7/IfymS0E6ApW44VRDA=;
 b=Xao1yqJeXo+HoWgdQj4bdBSCedjJny2bTvW4gXXjRMTVwewOwb5pfil0CUPy1hvqAW51kJCije4JcUKS42ngmdzeejCcw3ht/eytsqhTxdpaJhYJZA572Iqb82seDGV4ag2umjfhNTPXNBRHp0X1udarSD4/yq1icpi5EI8HV/4Q1LCkPg9wWN2hvTs4gXPZHkpBmHBy3A2WLVKW73dt6eo1SUDwOnNcqEoMPiXT59hMsZDWLB6GBkXBmNRTx7PUnjtQ8nnhJSllYzJTCqiC5SzEONPra2jJZYDNGW544Fu22rYKWQYXwZptBIbChuevtoKBVfW0qpTpcPTT3WUOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.25; Sat, 29 Apr
 2023 13:45:00 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 13:44:59 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: Add a device tree file for Emtop SOM IMX8MM
Thread-Topic: [PATCH] arm64: dts: Add a device tree file for Emtop SOM IMX8MM
Thread-Index: AQHZeqAd1qJOo0CtDEuC7bYu3/yuGw==
Date:   Sat, 29 Apr 2023 13:44:59 +0000
Message-ID: <BM1PR01MB4899EDE006EB24863E80D8C09A689@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB4899:EE_|PN3PR01MB7694:EE_
x-ms-office365-filtering-correlation-id: 4a41a9b2-95cd-4430-dee5-08db48b7ed1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 311Dvzlej+W8V83WCJd6FQaAUeOz3k/pZGM0qVjCSryN7+JBfwOzO5twcQT9HkccRTvbCYtPBtQZNanzUA7z1nZDUOqQIP1RA/8yv+xJhuez8VAuoUF4M1c2FDEjmrokseGlk3hfk5oX1XZ4nShCokjLxh0fFgjUtZW+vPpIwA0Trg4ZBu42N9aa/fAuozajxYXPa8lml2pPONeEOK7TgaYOdj/fnMY9sfIcrMqJSzyTftPVOebn6Ki1UJZyj3Y26g4pqdXyhpdwch86t3DdZJcHoQLD5bArxPvy96ITEgdpH4wUucZmE+v7Poq2iTlEvzvKD3FlPZJbTp9CPZkSFScA0uPItzwFgiWUEWxHEeGV03U5N14s3i3TVGTpum17BfaNbozoYyu9sa+xf61C1IWXtZKrJadEVZEBqNfEwDUvVInuPhDljZNi7ZSr16VmP/A74NJE4VOvf3tnKJIPI6xirdTDESTceUiG+5bFAgpZuB1nZu52YwTV+XSP5efQIobNTjvGw/Mw82lEGGQyXlZJGi513kmN6rnlEKf9EYWxkoieOdZvefJ76k+wWE72xHyO4d/qR+ECKrvG92GbqQjLYRJLSIaJ6bn83ypjByg50qEL57u42Paw+cK19Em5UusWKpgXKGL9l4stExWDAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(136003)(396003)(346002)(366004)(376002)(451199021)(55016003)(316002)(4326008)(53546011)(9686003)(6506007)(186003)(41300700001)(83380400001)(76116006)(66946007)(26005)(54906003)(478600001)(6916009)(66446008)(66476007)(71200400001)(7696005)(66556008)(64756008)(38100700002)(2906002)(122000001)(38070700005)(33656002)(86362001)(8936002)(8676002)(44832011)(52536014)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MJXqnZxX9sdr7kYYzcNzPQyIs9A7RqlAl3s8QGHJbUGxQO6UEeDA37/6LC?=
 =?iso-8859-1?Q?cWyD9BSkGyuprNnXL6E4AJ9y4gAc38aRD1L5+RvMo8dKdnj1crbyd8ZYg5?=
 =?iso-8859-1?Q?uEXTaGLwPmpM72qif/nDZaWiaoejArrz/2P6Q4Bp1hW1NpzWgTMSU+YSw1?=
 =?iso-8859-1?Q?VmDGlKgkXMHX9ye9Zyw6NKzgtcv7wvDz6A6T7m3IfB9DBKFvagFn+Dyd1+?=
 =?iso-8859-1?Q?5zf+26bbnloAP/T1bWiQpl1Sn6E+tQAqH+QY5IzWNENCsduZkps2wE4y+j?=
 =?iso-8859-1?Q?ICm0Z99AMZ+7mkYJBnVuntyfGaN95fW0ToM5kC/yVLJIYh6E980EW42ZDo?=
 =?iso-8859-1?Q?swT3nup7iiyJr6J9/FdW4/qUUYUoa8frzYxvPyHAH5j7E+y7KPtjOxgUVA?=
 =?iso-8859-1?Q?Eaph+0uzBwrZmj/JQ/EqZK8yoFlq7p9MnvFJgtUg0Sv6MChv9S0NJHngTG?=
 =?iso-8859-1?Q?mh1KumAiYTGF01bIjM/4+x7RZZoLTWuhl/6EQMkjk95TO5dKzh9mVM7on7?=
 =?iso-8859-1?Q?MyhlIHPiqbdJZaZvKo/FCGwlWCiOVUvKYrfEQ8tg9YL098lUXCVNLd/UAp?=
 =?iso-8859-1?Q?FuuRwtzwcrCLwn16j67/lWexLgeOrlAYamEFZ1+D8zAAbOpIkwdRxQE6/j?=
 =?iso-8859-1?Q?FIOHvXpWXaQ54FY8Os6MFVSzoOtYjyYmUA532lw/uuZjRT9JYDPaCmljAp?=
 =?iso-8859-1?Q?OSO0VxiB3pjsZPL3k0KnkqLGlesemHje9cXljtyCCbKGGdyrsmC+roBJ2s?=
 =?iso-8859-1?Q?1zC6jNa1PfgR6CfwWH9wnmR9B6tZDdcj0U/uy1gpFqCbgA5FWUKwuhmRWI?=
 =?iso-8859-1?Q?5oOJy8xv5jxDuFlvtnzS7RDMYykBEcUdhBlLP9bN2qc5pSmkdPQw8/AYQc?=
 =?iso-8859-1?Q?sDeV787dTr9UlEAiNkGuE6J1KoyQLQS+bds+IKx4XKC/n+eG3O2+4vWyUG?=
 =?iso-8859-1?Q?+vz0V95ZzjbxyvryGlK+OW89Lvk8sTjYQZ0+fuF9lS0uQAXDP9mvMZyBGx?=
 =?iso-8859-1?Q?KLQE2uMF42wn9xiTJVyVR2hR2WojTU79j7ZdjjxBzCY/W5P+fJd6ERq5ed?=
 =?iso-8859-1?Q?kO8IRtpamdq7aL8LXXrli5YGR/XjM5RiUnlFlH6kDIfL56SFCTt/9SCpEt?=
 =?iso-8859-1?Q?n2kK+1TWNBpvkyyiDbpH2k1d+mnwCpvpbPaF4zKgMVsncYGAECtfJHHUUP?=
 =?iso-8859-1?Q?6oa32oT6lcLET7+tAGM2i1Jy1RwQk8jm8apzcwnM01c4WAhHaK0c8lVqQP?=
 =?iso-8859-1?Q?qsxLy7anqGDNXQmF1qBkXS5HMacfWmOXpB51CJPTL/Jt/ud9xasbBx9klG?=
 =?iso-8859-1?Q?zPR7vJ52LKuI1aQhn3EnI+/wkO7qmnqdmAECKC/xeBBWYkAvNAAavlkTBJ?=
 =?iso-8859-1?Q?GJhjVVn1mIOjJawU+W+iuUA7BIoEy5gzritUzsJXSM93yZpxpait4KHcCY?=
 =?iso-8859-1?Q?H3R4Sbs8wCbqgLiFPNUMpe6mL5k7IwhWL5vwM2mxt0Yhv1osb8kFLxvTzQ?=
 =?iso-8859-1?Q?yUaGQ9Sup0GODTJ3cPUmC+Q6o4BrwR0PD7r1AwMssBpqkJg2jymUTFhSny?=
 =?iso-8859-1?Q?GrzuG/iwzKWPp17LfZS1QpEtd+Jx2frgeTLXe/qlTDHkKGBnY/RmBcLjY5?=
 =?iso-8859-1?Q?2MjATkqXzVJ5Fy2FfSLsFu3pj3ZCAyr341UTNHP5oX+FM6nDxN0Cyy7g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a41a9b2-95cd-4430-dee5-08db48b7ed1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2023 13:44:59.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tg+tdNsbmtkXhZPWAOXN/mdGPiI9UubrkxgjDxalpT1xvkBf/97BpVTneOsGD3NQaDYkRovVpOrACzQh0WkRBHZZ4aeC5UbIL+9ZO7BH3EdnJUyKQHTpkpeRJBdOVkpE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7694
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 9b2f563e1286c960ad81bc78ec811029ffb2f57a Mon Sep 17 00:00:00 2001
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Date: Sat, 29 Apr 2023 19:03:53 +0530
Subject: [PATCH] Add a device tree file for Emtop SOM IMX8MM

Added dts for describing the Emtop SOM-IMX8MM

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 198fff3731ae..8f281c753e5a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -79,6 +79,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-yavia.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
new file mode 100644
index 000000000000..5238a3b5f4cf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2019 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx8mm.dtsi"
+
+/ {
+	model = "FSL i.MX8MM Emtop SOM";
+	compatible = "fsl,imx8mm-emtop", "fsl,imx8mm-evk", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		sys {
+			label = "sys";
+			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&uart2 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@25 {
+		reg = <0x25>;
+		compatible = "nxp,pca9450";
+		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+
+		regulators {
+
+			buck1: BUCK1 {
+				regulator-compatible = "BUCK1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-compatible = "BUCK2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck3: BUCK3 {
+				regulator-compatible = "BUCK3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4: BUCK4 {
+				regulator-compatible = "BUCK4";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {
+				regulator-compatible = "BUCK5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-compatible = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-compatible = "LDO1";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-compatible = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <945000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-compatible = "LDO3";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-compatible = "LDO4";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <945000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-compatible = "LDO5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <3600000>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16			0x19
+			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29			0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL				0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA				0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicirq {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3			0x41
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX			0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX			0x140
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x190
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d0
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d0
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d0
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d0
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d0
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d0
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d0
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d0
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d0
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x194
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d4
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d4
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d4
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d4
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d4
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d4
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d4
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d4
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d4
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x196
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d6
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d6
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d6
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d6
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d6
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d6
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d6
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d6
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d6
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x196
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B			0xc6
+		>;
+	};
+};
-- 
2.25.1
