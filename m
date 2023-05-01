Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB46F339B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjEAQjm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 May 2023 12:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:39:40 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2070.outbound.protection.outlook.com [40.107.222.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B26E58
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXyggMvKkZvr0sD7QgKh7WEsfG6PW9ohgM3zRhr+cv897Wzg4hjamzrcrYQQoIZiycubMUfRUmFRnsfMZV4woonKWv7F9fVsN/xqT61McZl6BHY2tDUIRS2VEI44FpPuSJUQT/e88sQ/P/7nxg3Qd78tRjmMtpEzO0aQupAdRLNDdHCns4bJVUL/fS+lEb+BGFgRSBNFUZopPpmqRMibk9qCJnkXvCpzQgKzvBOADEtoEr9aQIUnGgy5n8+F9MWrdKuVWj90dgWxxyWqxj3kjTJyYQQ835oQxzlxyvKdnb/cXc0aznOofNJoLortv2NpexPPYn9XZ3fGAE/61sm17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/szcFTppAsj9CSQa2rC65pTmBwWNAETs+N5II3wQZxA=;
 b=DrAPdcw8xJ+ehYlULpNG9m9M/sn2v05i/BhOx5aIUs3vG0AC0MUey/94qknMORvEPdwuBXZ+tYL80ElPmf3L0At/2Od9DzsKw8RC1Nm75kRbfhyim6sfdkKopdeFPJhCRxqS+vSy3S28yGiapMZVKq7NP9gVEb4qT17T1ZswBQ7Tt27zOYX4h6n4OR5ntRVLzXl2zFIRNKsY6DgXWoMPzcbgvNuA9qOBWOeMIA2kWIzJmAg7ZbUKOvY85/roYe7avd2/yqqXA4KTivKzihPC2BRcH9KLxARMOGxn0RO/7dbQY6Y8etyl2edvgjpkeU7C39VtQjy8Pluq9Od8zxH13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNYPR01MB8335.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:54::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 16:39:35 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 16:39:35 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
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
Subject: [PATCH V2] arm64: dts: Add a device tree file for Emtop SOM IMX8MM
Thread-Topic: [PATCH V2] arm64: dts: Add a device tree file for Emtop SOM
 IMX8MM
Thread-Index: AQHZfEtegpDM2nagJ0q1JDDmkpZEPw==
Date:   Mon, 1 May 2023 16:39:35 +0000
Message-ID: <BM1PR01MB4899A5B20580E5988FBF80EA9A6E9@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB4899:EE_|PNYPR01MB8335:EE_
x-ms-office365-filtering-correlation-id: ae471e3c-fca2-43ca-c44d-08db4a62a5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxffOLvGMXQvX7bXlBKDyQYYX3YEei7iEMM8iac+3QEQeGbBqTAU+Rio1VVhdkyRLcnV8WgZ+C0c1wVp4uX/NvMSpXV+COU2pGitwg3mnGpfkoXlfJ98vubcSueJGdvjPvvbj/PDDw/qCjdWfror/GS0yGEKLJOz2fbnsXe5LlX6dEpoC1gW9P1UtEEgMakHv1NLfUHOO5dZOx/lr/e0YzmCSYtw/rx4c8hBQT/6ZYAbesXTmck+UQXcBaqwDz0aG0tMAjWRTjBXdEWrq1SyoVb4lIj7STllviYcxXW8bz0bFinPbh1/HtnG6XM8NqJ4NOz7wNSYqxLBWaENpRGrcWYrQ2vyldGXzgPHL09updWSYoR+zBOBJcQVtpiUeJhgQXyRSW4D7SB7Wot6Ow2p1HmsnEfBP7K/g0VXCN0G8Uj2Ipa60q2HlsU1ZuGHO6HuHPwaYK/xdIkxZv9KXmRgixVAFftPfDyX0aioc2c5o+dU3dsMIJEDh3fQmud/ULIhNfHbs+B5ISYD1zq7k3ge6gJJAqdxJeBPfrKAZ4xO/08XAusSs5rW6wlhHivSt9E9V7W4OlE53j/gWAXwIBUfbj9KbbewAOH7ND0ErEpFFt7CnvJPtNyq4B1xNao3i2+xl352ePBv1z3n6Gk8n9xx6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39830400003)(451199021)(55016003)(316002)(4326008)(9686003)(6506007)(53546011)(186003)(41300700001)(83380400001)(66946007)(478600001)(54906003)(26005)(110136005)(71200400001)(7696005)(66446008)(66556008)(64756008)(66476007)(38100700002)(76116006)(2906002)(122000001)(86362001)(33656002)(38070700005)(7416002)(8936002)(44832011)(8676002)(52536014)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v6lgaNesP+dXQro6gf+TWpiuCDl5miYgy/ztm52zprgZaAVGAIBoGYnMmG?=
 =?iso-8859-1?Q?U70wE/9GmLFt9Ynn5g2bzDL5EbYwfhSLa/t+/6SbpF4rPgRBTVBYto+30M?=
 =?iso-8859-1?Q?cIBDaz8BeKYmZ2dM3YZKMnRFef8iews70wZ0xS/xP67Zhl9baGgJH5Wivf?=
 =?iso-8859-1?Q?wdZ9vGTC6MLL5atdvz0MKCgNnL8jLM2uPUsYZfuw4ivR6pIUFZZzbucI7z?=
 =?iso-8859-1?Q?onc3z76vAdoSF6TE8NFazyce/WxtA4Kpb52Piz09+sMn3w45q8wFiQPWkq?=
 =?iso-8859-1?Q?+73xMe1vbmn3S2VXGIb1aK7ejl/1NdvilA8C8L7qcRTMfwTz6Xs7krhjKR?=
 =?iso-8859-1?Q?ZBx60uHBhhAzpgFX409Ru5y5e65zQVCmFQSKv7ZQW3oBtw3C1w9oMsnf9+?=
 =?iso-8859-1?Q?wVOrLByJTxCXYBoqXugN7iEn+dKrw9nxXqllmNkNk8sTknO98eizyVxF6u?=
 =?iso-8859-1?Q?4AE1E+RI6nojqDeE9zVbS/uME4z9hAx99GWztyWCXneM9cmPwW1Ax84W+b?=
 =?iso-8859-1?Q?easVXg88nk422Q1KFc/8vmeiJD5algg4eTvrZlH9fcESwSTtp7ojHtCJIs?=
 =?iso-8859-1?Q?lqK6jhJSsTFAM9wRgkejYdMGVsutVd7skQuZAEsa0GKUxZCAnmTyfQq1Dh?=
 =?iso-8859-1?Q?rt12cAkRVTXyspiA+RZu10oWhRXRRXDD2UChb/SVWk0u6R2SheFcyH58D0?=
 =?iso-8859-1?Q?kOv/fNsI/xNeZ9Y46AMxfRLoQL6stqt1BKyOABEpoRy58DczraL/xPRNXS?=
 =?iso-8859-1?Q?slrFERh0lyr8JWhyuXVyOerOl1NmoVCqFx0R0ocfZHRsT0VXLxGXYYjP0x?=
 =?iso-8859-1?Q?+6MV/ri/INtotfd0JyAPBqQk9qPkL+cvZwF3jgKQ0UpJb4dSjMbYGa1RBn?=
 =?iso-8859-1?Q?ihgm0AVVC93fhp4wSNVGkiD6myFtfXzsyqRoi1ZjRHcivUAmJuw2bf408L?=
 =?iso-8859-1?Q?vDq4p/CGae/VeVUpW+sxvm4gPBzjlHlL5YEXskAamWrko1TDHjzjV3bVUL?=
 =?iso-8859-1?Q?2MjGWa5SrqogHvq3IcA5C2MwwXmbDJh4CadfgWZnHaFugQU9Gq/NARzYvi?=
 =?iso-8859-1?Q?lL5gaJ/oZH+YTUa+3ompqwaKrhbkvWt4EOW/O+MK01kPGzPEITAdxffZun?=
 =?iso-8859-1?Q?QqtV4Hgni2CtiT5Mz/9ICHgsJEMJc4pmDqkvd08du6ts5yzGE06FZKlJmE?=
 =?iso-8859-1?Q?garqtAYgD8nfoED7nauO/o6ZthKCcwZvrBj/NpoMb6D4HYvOhurbbBcFfT?=
 =?iso-8859-1?Q?uv5oVeXJ7hT4vObpkde1Hh6d1bCLlOacQiBH4hD3L+SaSDXHldeJWhNEaz?=
 =?iso-8859-1?Q?YYy7SptZvxIjDesaa0/cpBS9WAvGffOKyoxmEXdLV22SAf3NO/aWbnQIkT?=
 =?iso-8859-1?Q?b0I2L9HuAVMRN7AT7jU8oBWNiGuDLNerFBXayAjtHv3WCauHJRsWk6qAK6?=
 =?iso-8859-1?Q?yklyeNIOLxAFEtgGYJfVEFsXQdPgVSRZFCGgiZ5aawx3Ea4gCDsyqZeSbC?=
 =?iso-8859-1?Q?j4PEZVxCWNJ3v6K0HfjgdjWEuApd1zYQMkY9x/4wKh/UACHCNdU8yGar2h?=
 =?iso-8859-1?Q?xEs/Hz1WapYGoXy27rQ8CUOzr2GA0fT2LJxuhe06FKCuBWIgTFUzbkl17i?=
 =?iso-8859-1?Q?csKbZqKqNND+Jg0zhsaM16PTB7TLqzouAtVM6BwZSp5lAfWRjc77Dw884n?=
 =?iso-8859-1?Q?p4taCpVsi1XANKLkXt0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae471e3c-fca2-43ca-c44d-08db4a62a5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 16:39:35.4526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jETr5M3uN0VeACBl6AJiMxld+IYhcvO2xuXT/eeNPisg7ZAK4yEglqFTsGHeu7qF0qWTM5SQWyMYV9jG0Fn7TpgML0ChmeDBm/3Qwv9s+CVmPPft6BFr2tNf6HIxmr12
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8335
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 33b96ec2602598f2a29e876c1f83b101d88faf2e Mon Sep 17 00:00:00 2001
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Date: Mon, 1 May 2023 21:50:44 +0530
Subject: [PATCH] Added dts for describing the Emtop SOM-IMX8MM

Changes in v2:
	- Update dtb add order in Makefile
	- Update bindings
	- Update proper prefix/name in dts
	- Removed stray blank line
	- Add pinctrl-names in pmic node

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 198fff3731ae..36590515fbc1 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
new file mode 100644
index 000000000000..5c569bbedc69
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Emtop
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
+
+#include "imx8mm.dtsi"
+
+/ {
+	model = "Emtop SOM i.MX8MM";
+	compatible = "emtop,imx8mm-emtop", "fsl,imx8mm";
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
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+/*	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		sys {
+			label = "sys";
+			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};*/
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+        cpu-supply = <&buck2>;
+};
+ 
+&A53_2 {
+        cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+        cpu-supply = <&buck2>;
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
+		compatible = "nxp,pca9450";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		/* PMIC PCA9450 PMIC_nINT GPIO1_IO3 */
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+
+		regulators {
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
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE 			0x196
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
