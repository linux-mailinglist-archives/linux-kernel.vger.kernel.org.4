Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BC734F03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjFSJCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjFSJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:02:29 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A143B4;
        Mon, 19 Jun 2023 02:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/H6+no8KA/lZXM4xh9eFngZEj8GkvUEHsy+z1xt31Rf+BhSsN9CoFs5ZMkorTOIzsiQdwgThlOJOuvla1wyumsIzyjoRcRI/T9nDCC/xzntX+KqPrezxUmd5MIgQxtEw5fuWHFhjJBGCd7qPrm1mPcV9blnQYHhrYDPLkTTmPIxWPwojItRkmp1uZnLb1p/U6wKX/UPdIqtDM8mz9bgcYWznFZ+E9jxzuym2NspWXF1BGI68Atk+wwZ6EJ/stxgokRxwIebrtoUKbrXO+cvUxhkGtFc0N9u9y5Hpi1sGQOheqTmKMAezKDZNcQ4ryoFZrKbnyEVpelzrux7nTlo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN5vmTSHzIVh/4jQdKDEKhXvvXz8l/fey99lgcDJBqM=;
 b=UoCKjenIkIJxKf+PS+DhX2vkjIW8OAZwuetAo4YPE9xOO2WuVhArkp6DI5jQMBkRe0XK9w68/c2rRudDwzi1RnozbHQ73clDh1LsVkclykJX/SUfbN1vAIOZRCJGnb8zr7q24U03qKWmYV+Mfetrg2M7AzWNtZ8tYPME3sn3Jk/HJYrgh0SrpIRLEJA8YCpriKIrbvvb4I7H76NzXMuhC9GFcWteql4RDPN8ayhqPpP+kCuCDRI+WlOp5N+QSLuXITBvDxGyXZ38P8aXtzBS+qeLIH145QubMe1EMLCyF/1TUmlM16DzDwnxEtfM38vyAFZOTnIFjF++iCHu5bKY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN5vmTSHzIVh/4jQdKDEKhXvvXz8l/fey99lgcDJBqM=;
 b=H8BPmp9070lmHlOW5aoMCd2wyc+7H5ibfoC3jSW0fCXg0SFPEHcfuVT2VhrOpf/NbZvNYrk7tkwulpHIKP7Xbyok//OL0Tam6Sn1v+83hN2hI2WToB+zUSez5cIb9VaxVwrH1T1logIdaPvO4TJhTu2HOg7vk5nxQXjIsHO63Cg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 09:02:21 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:02:21 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 4/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Mon, 19 Jun 2023 12:00:26 +0300
Message-Id: <20230619090026.22713-5-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230619090026.22713-1-josua@solid-run.com>
References: <20230619090026.22713-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: a7199539-1fef-4eda-d4bc-08db70a3e414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDaQsnzsAou9K/H+mHLoPuy4rfSx/SDxqhzd6r4fuhW5JkocYJsvjjQo0BCMQ5J+Tp6N1p6UGVy6X6RUhtRLlU4o0ratg7VzDCjeC8aoqE8gWYm9RrxDrXkJDVLxtlR4xM7a8JNyv+kDPBYC0ebs6rTVGol8IwYwbqbxA7FI/9YRwrOF19ydM+e4rmRXfU0pIJ38wHCkwni7gHtmHntZYQdX9tbVArK0PuC0c+IOxZKlc5tctqm2OXTAtUjhhleQqAA2+NeIkAitjsTFzjXLhMbyIJOD25I9Kje0U0YLJKz6AfWuCGDYq/Buv65I9vza0Y+YrkV4Aqwm7zBPRxZbCRL4h/h5UkQc39ZvD+GOiOD16jxThmPnmsNlXgao1Fw3tMX6iOW4tQHIwQrP3TGrfWAIsdSD3EC8O0+yo8gxumI4XWk8cWjrDwLzycH+h6hEkhig/2U0a6TQTeJ7rby9VD7U514IfoZgatgYtdg8nEuJb4Z84kfdJUNJzyKLtHrBP4D/5/uH8S1alb8XlmtgB01mOh9Q1JH3EhLdB/b0s49w60pr/gICFphzPdHf6e+B0EODDZW+SY0sUledZjMGPL5OcR72emSbjzwoxfGeRoeO0XDpVQwzifZVXYPya1tu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(136003)(396003)(346002)(376002)(451199021)(478600001)(6486002)(1076003)(6506007)(52116002)(7416002)(5660300002)(86362001)(30864003)(2906002)(36756003)(4326008)(54906003)(8936002)(8676002)(41300700001)(66556008)(66476007)(66946007)(316002)(83380400001)(2616005)(38350700002)(38100700002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VC3NBZXkIkYhk58uEV8I4qATgQUpjcMbKnaouqArrZLhOai2r5jm8n7Uf2Vq?=
 =?us-ascii?Q?4TO7lXHGFCV/DsDOQ+nW48scXJDzN/BgU0ZTREa+l2CvorsIjHGiYP2Qxmhj?=
 =?us-ascii?Q?XG1lpDaP5dmSWyxXdINocxTI30afgFFMNc8CZR9wBLaTPZ7bkEnDI4UyWd8T?=
 =?us-ascii?Q?KJnKhTNeq9gJ9Hurtgr5Fe+7VzUVDXOXw40x3hgibTRgrZGDqWHHCP3uLSAW?=
 =?us-ascii?Q?HiWtktUxaTjsPPTShptt2AzSxW5ybswekDFYkdD56pBrWhKmKUVtJQ3Opi8w?=
 =?us-ascii?Q?YH7QyhipOoKhWum7fHsY1YUJBN7qeBJk7Q5Ztejm09nEqtXOmDpQAXo169Ls?=
 =?us-ascii?Q?wqVrhcLcfUjAmrwrDIvbWAsQ258bcflLcAJybHaaIJApqIc5wIzx9mNFBmpm?=
 =?us-ascii?Q?kZx+n1AL1madgoqPqGaqPyEmm7Hy+WfsdEl3zcLTLfqC6A2CCLc+l33rBreN?=
 =?us-ascii?Q?x7bT4ScamXPSxus+/y4W4y3oxwxzQTaVST8pdQoh/0+ktfArK2EgmOcp8WZl?=
 =?us-ascii?Q?HkLsvFQ46npcuoYC8NRYQV40Y9D3NpuAU47m1KPEGjeegjj0luoi+EhZvXTG?=
 =?us-ascii?Q?CToZg3OzbPa19oZ3D22vWubMbFXSpww4DCGAJnPbBzsSpOhfMxzueOHjCxuX?=
 =?us-ascii?Q?7SaQPJqWii2nGNJFcw9ZDKZS4FjiiCHZDKR0ErcYCxj4DoGVCQ/LxL69s27I?=
 =?us-ascii?Q?KKt5sWrQMy1Z06VW5bUb0KL62OBOiquldceMa8W/urIdkTeZ/K0SdiejC+zV?=
 =?us-ascii?Q?R5stnZT2vyi1gP7ZIxE2ylMwptzpWmDFwzSqr3AC7mhStE5MSU4nait/K2mz?=
 =?us-ascii?Q?65zJADjipdHfdUC3OBTkfQhz7tCRop4RXFqcV267KSO0A8RdJ4TNmNaWIxjM?=
 =?us-ascii?Q?jrHzB6F6euwpLzr2RSPn98tVaa3pUvFrMpsbDVlk8kYqNjHWyuuYeRiJGNtk?=
 =?us-ascii?Q?lR4Knq7kSxyhAVap8IWr++JDLMh5znIEzIWg5CX/ycqrwDoQgi30IyrVkSbF?=
 =?us-ascii?Q?Gx9VFPaXqnfcc7iOJdhyRNHmu2pCjnXqH7nSM5wr/D4p+b42p03SoGr/4TqZ?=
 =?us-ascii?Q?4+2nKmcbJY/sjovTKJfF7EeknW1trVIkFcDLxKS+Q489+va3pl0gvscXj2b6?=
 =?us-ascii?Q?g6EaRYq1yhpX+UR17FK5ROqGiOoAHJC8aKp/URvPv2bO1zug//GbW/nCjJor?=
 =?us-ascii?Q?m4Uv9oQveKpZrpovpUDMKO22v5Mapdz9R9LQVSNX6vsrDZItk+miPWiJI7cB?=
 =?us-ascii?Q?grlSHr3wXfiUPWpijavFBShFC+tBZybElpAEbEaO7BYs6yZdtO47/uEF571K?=
 =?us-ascii?Q?7vwgXTBhedV70cfqqNhkW1sMgRwB71Z9xq0c44z/AsumAi+84Bb7/zRVZhNk?=
 =?us-ascii?Q?TZhvBpWwU6McDJGOTk8UVf9GN4lxeyas9UxgMrH/j8KQOX3kngVXUL7+hax0?=
 =?us-ascii?Q?iKhNi1O+ICiVWCqs3haKE7IjpZVFwjCOhXUIk8gl1lInCuJmUrq0yTvaKKz+?=
 =?us-ascii?Q?hENDKFGYf4wkWwhhPEVRV1A7FMhXlCZ2mB5Wp7qLmH0wi7BMx4yIeVjDpe9p?=
 =?us-ascii?Q?uk61LtPfIiLuZJeBhjZTSNigrkCNrVpTfaN1yrWD?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7199539-1fef-4eda-d4bc-08db70a3e414
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:02:21.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxQsCAGaWe0PjKDCjqZug9SQkzpP+Y1nSdGvoyCnWwaA/diGk7f/0Db2N+OT7aFyz7X2ldMF76UfNvVhHP1GBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SolidRun LX2162A System on Module (SoM), and the
Clearfog evaluation board.

The SoM has few software-controllable features:
- AR8035 Ethernet PHY
- eMMC
- SPI Flash
- fan controller
- various eeproms

The Clearfog evaluation board provides:
- microSD connector
- USB-A
- 2x 10Gbps SFP+
- 2x 25Gbps SFP+ with a retimer
- 8x 2.5Gbps RJ45
- 2x mPCI (assembly option / disables 2xRJ45)

The 8x RJ45 ports are connected with an 8-port PHY: Marvell 88E2580
supporting up to 5Gbps, while SoC and magnetics are limited to 2.5Gbps.

However 2500 speed is untested due to documentation and drivier
limitations. To avoid confusion the phy nodes have been explicitly
limited to 1000 for now.

The PCI nodes are disabled, but explicitly added to mark that this board
can have pci.
It is expected that the bootloader will patch the status property
"okay" and disable 2x RJ45 ports, according to active serdes configuration.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
V1 -> V2: reordered "compatible" and "reg" properties
V1 -> V2: replaced chip-specific DT node names with generic ones
V1 -> V2: removed dead code from fspi node
V2 -> V3: dropped deprecated address-cells, address-size props from flash node

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 371 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  73 ++++
 3 files changed, 445 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index ef7d17aef58f..b4fb5044d1c7 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-clearfog.dtb
 
 fsl-ls1028a-qds-13bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-13bb.dtbo
 fsl-ls1028a-qds-65bb-dtbs := fsl-ls1028a-qds.dtb fsl-ls1028a-qds-65bb.dtbo
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
new file mode 100644
index 000000000000..57d8c93bfc57
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2162A Clearfog
+//
+// Copyright 2023 Josua Mayer <josua@solid-run.com>
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+#include "fsl-lx2162a-sr-som.dtsi"
+
+/ {
+	model = "SolidRun LX2162A Clearfog";
+	compatible = "solidrun,lx2162a-clearfog", "solidrun,lx2162a-som", "fsl,lx2160a";
+
+	aliases {
+		crypto = &crypto;
+		i2c0 = &i2c0;
+		i2c1 = &i2c2;
+		i2c2 = &i2c4;
+		i2c3 = &sfp_i2c0;
+		i2c4 = &sfp_i2c1;
+		i2c5 = &sfp_i2c2;
+		i2c6 = &sfp_i2c3;
+		i2c7 = &mpcie1_i2c;
+		i2c8 = &mpcie0_i2c;
+		i2c9 = &pcieclk_i2c;
+		mmc0 = &esdhc0;
+		mmc1 = &esdhc1;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_sfp_at: led-sfp-at {
+			gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* PROC_IRQ5 */
+			default-state = "off";
+		};
+		led_sfp_ab: led-sfp-ab {
+			gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>; /* PROC_IRQ11 */
+			default-state = "off";
+		};
+		led_sfp_bt: led-sfp-bt {
+			gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>; /* EVT1_B */
+			default-state = "off";
+		};
+		led_sfp_bb: led-sfp-bb {
+			gpios = <&gpio2 14 GPIO_ACTIVE_HIGH>; /* EVT2_B */
+			default-state = "off";
+		};
+	};
+
+	sfp_at: sfp-at {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c0>;
+		mod-def0-gpios = <&gpio2 16 GPIO_ACTIVE_LOW>; /* EVT4_B */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_ab: sfp-ab {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c1>;
+		mod-def0-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>; /* PROC_IRQ1 */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_bt: sfp-bt {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c2>;
+		mod-def0-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>; /* PROC_IRQ10 */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_bb: sfp-bb {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c3>;
+		mod-def0-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>; /* EVT3_B */
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	/* retimer@18 */
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		sfp_i2c0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		sfp_i2c1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		sfp_i2c2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		sfp_i2c3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		mpcie1_i2c: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		mpcie0_i2c: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		pcieclk_i2c: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			/* clock-controller@6b */
+		};
+	};
+};
+
+&dpmac3 {
+	sfp = <&sfp_at>;
+	managed = "in-band-status";
+	phys = <&serdes_1 7>;
+};
+
+&dpmac4 {
+	sfp = <&sfp_ab>;
+	managed = "in-band-status";
+	phys = <&serdes_1 6>;
+};
+
+&dpmac5 {
+	sfp = <&sfp_bt>;
+	managed = "in-band-status";
+	phys = <&serdes_1 5>;
+};
+
+&dpmac6 {
+	sfp = <&sfp_bb>;
+	managed = "in-band-status";
+	phys = <&serdes_1 4>;
+};
+
+&dpmac11 {
+	status = "okay";
+	phys = <&serdes_2 0>;
+	phy-handle = <&ethernet_phy2>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac12 {
+	status = "okay";
+	phys = <&serdes_2 1>;
+	phy-handle = <&ethernet_phy0>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac13 {
+	status = "okay";
+	phys = <&serdes_2 6>;
+	phy-handle = <&ethernet_phy5>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac14 {
+	status = "okay";
+	phys = <&serdes_2 7>;
+	phy-handle = <&ethernet_phy7>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac15 {
+	status = "okay";
+	phys = <&serdes_2 4>;
+	phy-handle = <&ethernet_phy3>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac16 {
+	status = "okay";
+	phys = <&serdes_2 5>;
+	phy-handle = <&ethernet_phy1>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac17 {
+	/* override connection to on-SoM phy */
+	/delete-property/ phy-handle;
+	/delete-property/ phy-connection-type;
+
+	status = "okay";
+	phys = <&serdes_2 2>;
+	phy-handle = <&ethernet_phy4>;
+	phy-connection-type = "sgmii";
+};
+
+&dpmac18 {
+	status = "okay";
+	phys = <&serdes_2 3>;
+	phy-handle = <&ethernet_phy6>;
+	phy-connection-type = "sgmii";
+};
+
+&emdio1 {
+	/*
+	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
+	 * It competes for WRIOP MAC17, and no connector has been wired.
+	 */
+	/delete-node/ ethernet-phy@1;
+
+	ethernet_phy0: ethernet-phy@8 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <8>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy1: ethernet-phy@9 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <9>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy2: ethernet-phy@10 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <10>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy3: ethernet-phy@11 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <11>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy4: ethernet-phy@12 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <12>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy5: ethernet-phy@13 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <13>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy6: ethernet-phy@14 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <14>;
+		max-speed = <1000>;
+	};
+
+	ethernet_phy7: ethernet-phy@15 {
+		compatible = "ethernet-phy-ieee802.3-c45";
+		reg = <15>;
+		max-speed = <1000>;
+	};
+};
+
+&esdhc0 {
+	status = "okay";
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+};
+
+&pcie3 {
+	status = "disabled";
+};
+
+&pcie4 {
+	status = "disabled";
+};
+
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio4 {
+	status = "okay";
+};
+
+&pcs_mdio5 {
+	status = "okay";
+};
+
+&pcs_mdio6 {
+	status = "okay";
+};
+
+&pcs_mdio11 {
+	status = "okay";
+};
+
+&pcs_mdio12 {
+	status = "okay";
+};
+
+&pcs_mdio13 {
+	status = "okay";
+};
+
+&pcs_mdio14 {
+	status = "okay";
+};
+
+&pcs_mdio15 {
+	status = "okay";
+};
+
+&pcs_mdio16 {
+	status = "okay";
+};
+
+&pcs_mdio17 {
+	status = "okay";
+};
+
+&pcs_mdio18 {
+	status = "okay";
+};
+
+&serdes_1 {
+	status = "okay";
+};
+
+&serdes_2 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
new file mode 100644
index 000000000000..ac3f9bc60265
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2162A-SOM
+//
+// Copyright 2021 Rabeeh Khoury <rabeeh@solid-run.com>
+// Copyright 2023 Josua Mayer <josua@solid-run.com>
+
+&crypto {
+	status = "okay";
+};
+
+&dpmac17 {
+	phy-handle = <&ethernet_phy0>;
+	phy-connection-type = "rgmii-id";
+};
+
+&emdio1 {
+	status = "okay";
+
+	ethernet_phy0: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+&esdhc1 {
+	status = "okay";
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+};
+
+&fspi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
+		spi-rx-bus-width = <8>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	ddr_spd: eeprom@51 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x51>;
+		read-only;
+	};
+
+	config_eeprom: eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	variable_eeprom: eeprom@54 {
+		compatible = "st,24c2048", "atmel,24c2048";
+		reg = <0x54>;
+	};
+};
-- 
2.35.3

