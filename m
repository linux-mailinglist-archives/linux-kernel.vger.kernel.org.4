Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6624E6FD985
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjEJIfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjEJIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:34:31 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2047.outbound.protection.outlook.com [40.107.239.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4755C83E4;
        Wed, 10 May 2023 01:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIi86ohA4wF0xUk/+83HhkECQsGs242kyINmoRCWM32rUK9N667vq4fS/Wu5UAFbHqmVejj3bQukUB7lDveJC9MZ4D60MNk+9WRD7zPaKz127wcGtVjx3tkUCkRSKYCHLnWbvowhTxJiFyS9cqNY2R+ddHDImzheXQc953Qzpu5WI/QWAzhZhJDFhctOdsYJpijWJiPAhecBdon1b4Vg4q112nMZqMFFjCqBhkwF6SLoWIL80eYtaCL5E854Nhx/7Ia9qQfXcChgpGjxCaVdlttLToV+cshx8WLdU6/sdxWpRmOwA+V2mZYWlbC1GVtuqM5ESyHFA/eSF86JNzKkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jIP1yYZ3aqeWCeWupCDK1t9ahKQeoLmStiiARgvXC8=;
 b=C6rwk1Rfkmi7rzEPBMRanbNJcYk1UaACSlPt+i7ON+F9vyDI+pdJXqsaJzZ5+1kqdgOC+0AgRNSLrpHnkJ/1GvBtpX0yaPTwa2n+aB1Sdy72nDe63aKKpF+WgPZNZXM1wMnSVS75EhaQr6svcTpwC3XwFE0WW2BNYtp9U9jltg7zIIsX7YR87aIPXVjfqulVe2e8KY36f8TB0D1bU80o/MCw9JwwuG2mdKF+ueoLDQluHSddY8Z2Yc1esYbaLhTTFhbfUl9RCMJsrOZFId90H5uXMnnRS/7/zJCGTRra0tkFhtprUVB6eeYdqfMBLJrdZ/de83Sw6ree6aVPLtIH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNXPR01MB7204.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 08:32:53 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 08:32:53 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: dts: Add device tree for the Emtop SOM IMX8MM
Date:   Wed, 10 May 2023 14:02:29 +0530
Message-Id: <20230510083231.3692247-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNXPR01MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 63151062-8c93-48d8-5f19-08db5131259d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdDEavIlt9Rbg/fBUyu5mVrdDj8ZJYV7HYUgHbm/Te6LFvfUs2fMfkQPszGcdDR9viybfamtTDdfu17C8K+7jgMK1Et3oAsNSP0g+6prwVQbBNdhy6pILOMdOhN5JI/ENXjP5T8II48e7fCz7QRQWvMonjqxG9sD2s6Oo2+1bcS6W8M4WwbWoA2oYBucRV/VgKoNqWM5XSJZiFYMNs0EQg3+IWDUy2L///83BJ6NafKN6eaEaD3STzCe2/NoEFlIqZVpY4MJ+f66/Yd/nmsEkhri3YMdu4DWSmnJBJ9ruKrW6PIJAzMWZ/3e9aXkUSIe0TW4bI1zGMpQWO6zc0qb6mXgWw/Aw5/CdxX+aynd6PyXXAeajeHVtKa3b/jjCJ/n0nLnrbrE0IMfIPAVB2y0WiaDzuGpX8eNBEylIDHZiD1+3Ias6pRVGpCJ4sHYHU0chg+AXCibCMF+F6QerhDxq8NpNIZNBiQkNl533z9o9lBKFx6AhpFHoFkv2IeTIUeO4Xacuy5JZPa5u28qBrO6QIK3o9V3vMjI4sZy0BWN/aPAgwpZUg9XBVnXjIWwGATq+H8Oq2kxZPsoVfiEaFxpry4PRuVUyN+hcUQOZMv6o72sQ8UYFg+BhbwPiJrWDJKdcCEUr6N4oPBgDW8kNaQCag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39840400004)(396003)(346002)(451199021)(66946007)(66476007)(66556008)(83380400001)(2616005)(86362001)(38100700002)(38350700002)(54906003)(52116002)(6486002)(6666004)(186003)(6512007)(6506007)(36756003)(1076003)(478600001)(26005)(2906002)(316002)(4326008)(6916009)(8936002)(8676002)(5660300002)(7416002)(44832011)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQ+Rzwa4kM8+nJDtoa7HdEbkiU824SNFwzmwZ6kn6OCLlKSGRyyPLNYe6XBo?=
 =?us-ascii?Q?NZaG6voUnivLb7EiOmaZJiXe8Sz8AT9koJwH3MJ4Gk0MJVLJjdFaogN2TESC?=
 =?us-ascii?Q?xMUZrQwXy1UeSx/sMa2Cf7oGmb/336ZqvLWB73OjG0P1WJTVvrArmpwzogdG?=
 =?us-ascii?Q?4oRrXjHUyl3/j163QpJroDOgPC3ja0ZraGIPtHeq52T//xLjW5WW/DLn2MYt?=
 =?us-ascii?Q?RBnn9j0bLexeKYj/C/52HKqmcWrZFled5E6u/w4Q7WGwMwz5ROUIUEYLAIoc?=
 =?us-ascii?Q?ZQAIuH9G72NP5VcyIwGCrcgLeoFBo8//qrwk9afzCHeuIT/vbdX6brdYoMaF?=
 =?us-ascii?Q?Nvqfc/7t3Eys5BYzSPo+Ui+3rXZsQ+jz78zM3/puLWvRt1tUj9Lb4styldVi?=
 =?us-ascii?Q?kEWNgamsN5sZfuGalVPKFWC+ax3yCOeSqB6S+FDwmyEEJ0zw6uwn4/HvjVBu?=
 =?us-ascii?Q?tuJZV8RXH5G2XM8DhXog5dDQSz/+9vkmlK4ZACrdFlGah24c4pge2EWBCfa7?=
 =?us-ascii?Q?U7AQvm0EBOctFfcDguC5Pl/q9s2shsSPB4NP3OQvsaotYfRLv4hV4fRriPXx?=
 =?us-ascii?Q?2Gq9Eb0QCkdWFALm+Jj9L1hUTJeOgmW/bXQwbRdM+VhblD5rYfnBEcIt+bqB?=
 =?us-ascii?Q?CgwqE1QkQlmbdBBKKqGSYTJOcoS4W9rGv5Mwl34oPpbzNKS9utsgZYOsyRNF?=
 =?us-ascii?Q?ha30DEBvyOXQYGIrFqP1RCcwk8DIe8EYkV9mnexcyU6armLd+JCzU7Q/wC1S?=
 =?us-ascii?Q?5IaRn4TGS55h+uXjp7RZvxn7NJ7tGfvW812pCh09xsfBsllIqGt/AyqJlAqt?=
 =?us-ascii?Q?08/yAV9+QWA0HrbvWIeQvpsiR8UQdwIqMvhaLkE9plsw3FkGkq9fuRrfmV0f?=
 =?us-ascii?Q?E8FIKCaL6sHOFDDpKEpfPzJBIdLIMcpUIxFhN9UeKA3kNcNkiZMyRjAAj5ZQ?=
 =?us-ascii?Q?Fk5312o7Xyqf3lY+t+R7BxdJwBpF6Ttmg8hVQhWlnsOMVsEdUvLx7t2wCSOA?=
 =?us-ascii?Q?GQu0F2CgWq7dmQcEB069TVvR407nMNaE8p6qZJx9gI3YBiHrDtx5WA5SWvPi?=
 =?us-ascii?Q?MiOhLk7fZv/Md7ctLP1z3Nih/ytKUzKc9RefpLQ6S+au2YVgwKUBCe1HmKRA?=
 =?us-ascii?Q?qV5LR4Vz3eyjuYfhi5NuP6j+/JSLhweb/Wxe//0tjjjo++AbekgfUGRtEPZI?=
 =?us-ascii?Q?gRGhkU/svbihNKv5rqBDdQHYf/OMnW00MhEVmLWwzHs3g2lsabytKowjy4QC?=
 =?us-ascii?Q?N1IvTnuX7nrpl99eemHfdWYu+8J2oRspe+zhNZQlVkMWY4UyBuNGAhH6oyqn?=
 =?us-ascii?Q?u/5NMvJt4iI+u9iQO0//Iik2kuC/LDrDdEKfscuLOx3uO2ceYZf8IvSLmBFh?=
 =?us-ascii?Q?1lCBNYC+1F3S3nrfiTpBRX3YWU19jjZOEHcIfsBgAHxPVA8u3TDnwr1X3irR?=
 =?us-ascii?Q?DCYnx+zR8oADwfH/NALORRi3FnTakQhhgUlkd9KaXD7+sBj2lmdOC8C6Pd4v?=
 =?us-ascii?Q?igzFHhOn7zcEeXofsXgU7vCJPY6noxsc6fCGJ1say9T0Csf8hf1/TMhL5Brh?=
 =?us-ascii?Q?NcpR2uGJdroAjibCW6ZN3j/tBNA97eHXGxbrogGr3No4XwRX2MsyjA3cx4aI?=
 =?us-ascii?Q?YG5+8oJGjaE4UNVMR9XxcC0=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 63151062-8c93-48d8-5f19-08db5131259d
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:32:53.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UYlGlUcVQJNaZp1jXA7lKmh6CHdn0cmxahVqKyADmyaZpu3ird/LAYL4gWyXHy6idoLPS9LOKWSMocget+TfS1aTuHSbM1mNcTQbdwjad6dIAPb670KPdYxWf450XPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7204
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
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/imx8mm-emtop.dts | 261 ++++++++++++++++++
 2 files changed, 262 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop.dts

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

