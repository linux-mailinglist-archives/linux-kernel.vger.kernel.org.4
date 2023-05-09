Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3476FC4CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjEILTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjEILTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:19:04 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2067.outbound.protection.outlook.com [40.107.239.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D3100D9;
        Tue,  9 May 2023 04:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WewyAW00uQqP2MR33LT/7+n8FobjsCVax3o18EJpc74cMgrD2KYsXukbktBSi7a5JBZJmeScenbdlMFScdNhXemxUI0KwEItWO0yZPkmdCOJ7qB43UrzE2IWCOprGjDGAh65H5kzGsh2bDtSnxqGnd9MM1XpMXcWY54hxeSUC7JgE9Jgq0wB0CwkL5KVh1NEQaccXKjeoE5txxYQ6oi/KgOdw7RA5CyHOoQW9u7l1WkuU2xJfkS60gd4PwYJNpE2a16PvjXaufHu2Sm5Jfy419nPaTQfk9Y/7Yae0HYzO8bT05gjN2yg5bzFuxzU+P3CrWvAegH/5qHXuggQq3CTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgG7I5PIro1vk5XWdLiTm6QnITYG7k8g9idsolGWkPU=;
 b=eBOUOufjCx+imJoEkJc+/yQxHby/o4MYl7cymuSAsjtisr9iWVwZVWBxE4aQrbH6O8j3+lZ3VmHqif68zGsUmRRbgpQM4RjTakEJoY9L9JTdgX5n/8nrNLuvktcNzMMm+9VYfpnJvPsQaG3vaKKVpVwbUEte/is3tDqrG2EKH/Bdbm6mU0wHzl50zw5ZIZZ+m8wRMchs3yIg2qFZcCqMOQjOCB21rdU63MDtSG2HVd0vHSWT9WmbQZH36yIIdoCc6X+ST/yo4BUAdN6wXLpz9cHhVozOHs8MwAgt+Tv2PWmXjAdj6YKM2O+xgUTyuGHvD76jU2hmvpY7Pe4QeO9+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by MA0PR01MB9627.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 11:18:13 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 11:18:13 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     himanshu.bhavani@siliconsignals.io,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: Add device tree for the Emtop SOM IMX8MM
Date:   Tue,  9 May 2023 16:47:52 +0530
Message-Id: <20230509111754.3301369-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|MA0PR01MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 23aaec90-6f80-41aa-7ecd-08db507f13f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sF9WzIcwHQwoqqfobhx7oBhzfr6YZi/oqqVoXMmlvC/UhzFMo8fIZPwr1AGh+P01r2uoBl1FcVx98M2HutYZ9cnjDd56OgdwcEMFauCw/8oR6uWdHGT1DnIoLjVKvutaulEZTa/YQwskze0gP+CTw80HLU+WLsn6uJyJjgiS79L+pZghMP+OWaOpxSk7BH4Wja49D6vJxUAMba8D1DYfFOD1I0HkBbT1rElQs1GDhOVuLPS+1fEkhqd9DMmdkEPbI3aqi6nNjElrNTR6gikuYdtM2mNkmi308Q1PT03bWJ0qP3CuEBZ1iafz0NOtr9nO2eIn5nBPtOVjV1ixvZloEIWzP2SbsBE9UTQZ8Qs2GUU+iaLzY4b0DNovGS6ySttFeDjoKm2DuYwTEUovXR7U2wagmUtWtKOI8DlgvML1NQXBukIqAo3P4l65Nph5A4gbs6I1TIMiw+IihhjAqdWG134CEJD35kAjX8VfQdU7qfNfZTc5k7pB00mIdRJpT51B68ss75H8FZNvAch2fa8CMjzue8ROdTVXjAVVN0TuIlzgTQhijzarbgWXjaB1PVGQVSNYL1b//87A70wvhFOpY3EvoXpSuSMEaflPlCFNr1b1Z+QUyZWpn1DRum7gB16TkVSGjRFdnk+oe82D/TH3Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39830400003)(376002)(451199021)(186003)(38350700002)(2906002)(6512007)(26005)(1076003)(6506007)(36756003)(38100700002)(83380400001)(2616005)(316002)(6666004)(6916009)(66556008)(66946007)(41300700001)(6486002)(66476007)(4326008)(52116002)(54906003)(86362001)(478600001)(7416002)(8676002)(44832011)(5660300002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPMVegNIW6OJG0+Gs591zBXPAr+EXVWbPIh2jmkUbLtq+SMoLoWzFHauYE1S?=
 =?us-ascii?Q?Fa0IzD/q932U6OiTJldHPm43gwyKQIvQ9CZw7a4kw0h3BN5SPX8XeUKFcE2s?=
 =?us-ascii?Q?BByFx4LqiuMgyDGRFNc0Y31hocDX5P10cvTLChp0DJM9Oge9zUQLVewdtPWE?=
 =?us-ascii?Q?aV9qK1Z3asn/tCbE8spPA9IqZ1X6HBkk/enirqkOdHDswtKk7YB85djUVA/t?=
 =?us-ascii?Q?MvO/UBGbJEA4S01p1VzWv32zwNAH8y18aFNPgboFHJvq2ZlccvAurYe8JpVC?=
 =?us-ascii?Q?ww49WyDjzg3UXtMDo9Qh+6qP2fdmZ7gK4S6TXQX6Uj0Esg1DsDrh0f/fwB4a?=
 =?us-ascii?Q?lJramx90B4QDgW7N4a+5NswMaTGsVkvXm3bk0DH/g/xl+zgaVvAYprUKqPDR?=
 =?us-ascii?Q?m4XXqjtRv0pH2MCDTPMgU+x8aOBKHHYDWrWGOfHlgcDpwXAGwbp8uyXnd1HJ?=
 =?us-ascii?Q?OXcy6LlfVcLz4tHZ/zLjZNUObU4aqy+7DAkeC9YSgYPdcLFZNvo9ArGvfyh8?=
 =?us-ascii?Q?h9Urk1r6aPUWFmtTXVboTQT8ng7t05+w5rZIexw/KWhH63N5HQQ19dhIxM0r?=
 =?us-ascii?Q?qqBnEHbXod9NBWAMZn9ij05N9yvkMc6OT3oACtwPESr8QY8o4LSmBklolcp/?=
 =?us-ascii?Q?/ZOyBoyDEhe2vKWYGuoq/XC624Ao+0THt2mQitLSte45XpUDEKvnOO6hExKe?=
 =?us-ascii?Q?7grHSElMO6atT49uVzsCotYmCRgYeleQ/9Cr+nWoge21QQustb7qK7+arIvh?=
 =?us-ascii?Q?NBagKc4yDBM4qZmu+Y9m6G3XogiBX3309ZQQqbGRXXgKY9QDBOmgIbxhTrfW?=
 =?us-ascii?Q?Q+PzdundUBNG/qeMxXm0946ESri7rpwew9rw9dvha5xXdcgjbJQIjULLisst?=
 =?us-ascii?Q?R8tpgzvM16GkVFP36vjCFsKOO1TfArny3ewIFagZuRtj0SFCeMo1COZsbsMK?=
 =?us-ascii?Q?zR/1Li0Vj1d0Fwj5KGpGCXPTmXtMsd0p98ojV1mQtEIFVp0rZOlSgPt38noM?=
 =?us-ascii?Q?mCdH/r+4G/uujBcRbUtNk1I7Huwd7KlRkvL64pKfqtIMlV0eNQR9oigJDT7H?=
 =?us-ascii?Q?uUs04TGQY1YrjrSw/vOV91HNW+NpYFPG9SrCiWYED1p6gkYXgX75iRAZ3sVt?=
 =?us-ascii?Q?ySgOdOlvrOIq7jxw8CRuxHFdHCcmW8OuKLR6VeX7E4FkXjPmsTUFpDhcqvos?=
 =?us-ascii?Q?5jRLI8qvz52nmCFtNRN+59OcmhGv53AuSofbL/lgoSTJlJjLeLDPm8ZhbfIQ?=
 =?us-ascii?Q?t+snj00gmFTqrpR1ysIQx/ST0I/EnTFCWarAWK9MyLBYGJVY1Wpc3NfFYVSv?=
 =?us-ascii?Q?9Q+lNSQrFn1DDHO1r8HcgWnFzSqK4+C5qVeJC6xqflcpD4OrUXsPvWMGH6jJ?=
 =?us-ascii?Q?vZdsRj3+nou4Dgixv15vYk6qvqzzhaReZAqg1Dsbw5Ke2GkSDhQIthK6A+8D?=
 =?us-ascii?Q?gzUz6f7b0Iz1FZz4JYYi8Pcm7uiczPbFeTttAXbdXooKbTS5FTII2Zfb/9Gu?=
 =?us-ascii?Q?AxW7Q2fELev/OJlPRXugVptOHJyiWDsEuGaqWl9jVnD5hUbQeKXdFRmffuoP?=
 =?us-ascii?Q?nlEPKCsKmwGiBlJPr5wVxBMfxX8DppUotlxb2FUcnClo9CB4W/OSAbe58nh2?=
 =?us-ascii?Q?bqZruwUpB14RSwzq4ivpagU=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 23aaec90-6f80-41aa-7ecd-08db507f13f5
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 11:18:13.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggNKC21hS0bRmp/Of4JTHUJUeYuE07y+JZwTA+BmZRsppJrRoh3HkKnIWcNpRBsOQAvX6CR8t/OY1JAOM6atvrenvU6CNZWId9h8FD1pLMA5C/xlK8L8nrFocDDggtSF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9627
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree file describing the Emtop SOM IMX8MM

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
index 000000000000..461e1ef5dcb4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
@@ -0,0 +1,261 @@
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
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
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
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck3: BUCK3 {
+				regulator-name = "BUCK3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <945000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <945000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <3600000>;
+			};
+		};
+	};
+};
+
+&iomuxc {
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
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
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
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
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

