Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E98734164
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbjFQNku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjFQNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:40:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA719A2;
        Sat, 17 Jun 2023 06:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiyC7w9U4iaH8551lBoHzZWx6EzSjPjwLXU6o7NQnl/twx7/Mvq04jRc/h2xTBgqzCiYbae1csDU03/F8bjhsa8gQpVe4upDzBIn7RL0QYqwTfxq/hqlgCjWNApXp5IhZP747HJL47axHlhxO+hchW553p3Viz62CTDhDq8dOVrcQqgQIwV6TiSP8Xtw8id09K5jPtLNa+x6aDbKJxjVU5ONvWLCWPw5qovrzfzL3Ct7D7mBfT8hW6GUFxxoeTyKcTr7tnW8UerAA3RsKjZToT6h7VUfSAcZ8RvaFLjk/psjzVN0kSL/ArUBl95xJyDiGqlca8LuNu4jHtFdhLYL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCHwQV4LZv2EniRyjo8g0YEj14Kb6TdMXm9PFqa1UyU=;
 b=CWgGkYuECH6daelb11dl3fiX4VW7jmSzav4epUYOMHGKye+ZboOkG7If5VFo1be0DJR9Va/rDHIgx/EcQV9oMcUZfYiekHgXDqDIErxt4hn5PFIpy8h/AhcZB0YIkLnyoMTBAvl4To9I9iaPFvmTbPB62nN4pkXFdiOh+iyGaqb6JDxqjYGpp3g0fu3DXP4sWYJ+iSZXfgkdcpQ9Fm18EvWzp7IqYPl66FmUm7sdUOzqOy996WeAp90uo0V8SraalQsQDAyj/DMoYfvnTBpWZgQpfYax+gGoeUc1rxzRVRScM2XLEJpukioxjtEPAwCl9Jr2pHJz5hBXdIEP4hZgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCHwQV4LZv2EniRyjo8g0YEj14Kb6TdMXm9PFqa1UyU=;
 b=RnIBsLgk+GczW3y1gfWEaLL+kWI/WItzLIHR9qwSNJNYchS6ZfTSrBK19/IpMWbY9nyjj6DI69XvjLWvKms0SBKXY0QTC6AB0ErmQobgYiLga2HNSwclJQm/XOjg28Xn8KNP6TA9vMUVsid8XBCaodx215WufEYGNPkaBSd/n3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8220.eurprd04.prod.outlook.com (2603:10a6:10:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.33; Sat, 17 Jun
 2023 13:40:35 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 13:40:35 +0000
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
Subject: [PATCH v2 4/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Sat, 17 Jun 2023 16:40:09 +0300
Message-Id: <20230617134009.23042-5-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230617134009.23042-1-josua@solid-run.com>
References: <20230617134009.23042-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c22c65-d17d-4ac2-613e-08db6f386d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJrHaTD9MOMI4WyX9vW4NwQ6tXQStjpEXxtjR+Je/HTfxK6JGF/qckROJk1z6qizoEokJjF1XRthiJLchB7yUt2CvlmJHyDIv11LHeWsbdWMe+6W92zLuLwB5jz+zV+h312lL1wdjFIe+kcgCaramiluQqjWT8GeVLN/2joC9tMZ4I23dqQHIk4qxCzzsOzrdwQHcd0lXnCYMxM5aG/ayO7GwY9BoFReNqo8YvM+xu1zBRs/KyLysCmMx+9iU0wuRRDY3vcHFVCgXdeLo6Y0tuQHuHU5LuM5PR63fSe2nW4hFQa3PTQ7icolNNudbPiRavJP46gldgpN+OOcj810MDBwe6zes5iorPTA7D8NEYGAzb1zGNIuCmGOn9e4nFkGdoRM2ykSwgR8KMSoRoJDAtdPQradp+0qxdQaU8D15IZ8zYzSpng+9OUYy5UE0uICiO1s9Rlu5Y/BQ6k+hpxqD8f4+S9PrrysUUJQ3yqDxQkor3ZgFqRO23qamfkO5SS26Ku1it96Eqff1rG8c1cAhPCnWwnHzzSBzfhqLSfuh8ewxp6nhsVZjvmSNM9TpYzTA1uPcI0qf4rzw6EUUbRkJq08BGWXfulAwf55uAwnpTEJQUJ73dVFvoIznZSsA3PQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(396003)(366004)(346002)(451199021)(38100700002)(38350700002)(6486002)(6506007)(1076003)(83380400001)(26005)(186003)(2616005)(6512007)(7416002)(5660300002)(30864003)(8936002)(8676002)(41300700001)(2906002)(4326008)(36756003)(6666004)(478600001)(52116002)(66556008)(66476007)(66946007)(316002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BN0Rtbg7AfTVEgUauBsaZY1qbSwq4z7mVLdy37uH0JelyDAFf7v/ufRcN+Tt?=
 =?us-ascii?Q?NCDm7a/aj0plUhFs4AFpLUajVPHOC7UcbHS62YIbk1VJNA+tgnQw16cf1etG?=
 =?us-ascii?Q?73ajr+Q5+fw244nLbAzAXyquuLpkMalb/UygWc6/P1o/KfZDcKEpRQ17qFxN?=
 =?us-ascii?Q?Or1Lvw1j+c/RNvaIIcV6hrNpbNJTTyE4Wr2COLIa5fC5Nf4OSnApNWUP3DY1?=
 =?us-ascii?Q?G8cKGl+pY8U6KlycqSmwle5+6TVmRMFb2Hf0afW7Sv5ez8wybLFNM3VQyRKC?=
 =?us-ascii?Q?Wz7vB+3vI6DyDAh9xV1NMDB55kgEvyvKacQ9FqZS0NgxGNPtiU4SccD3tVSi?=
 =?us-ascii?Q?NDnZLAGfYSACmYG7Je4LV0CWAuTwOpm1p/aFQFtmVmxDPRvCVMGrhoMfOIyv?=
 =?us-ascii?Q?4EsSQIHC4lcvMVsi6lP8bWMHSNr3RsfZcsJBCy6wzrGUfOU+XEtok3yT1lS5?=
 =?us-ascii?Q?u7gOIBrz59IGgm/VIh0RA/Ev2frMsaVb3quyK7bLb5F+1bOsaE6OnGPeMM81?=
 =?us-ascii?Q?6nZ29LvjLqDbmWGg9cGuwLjntZ3FDGb78wPGzseBX44PuInsyEkEfmjyeAp7?=
 =?us-ascii?Q?ZrhulAn53E3tTAIWq2gGyQzXamAD5wMkMfQQeOPTCdwCLJn0Jah1WCrbxQCr?=
 =?us-ascii?Q?EvTSg3vRrvzxotBJIFQ6vFQydBQT9ncGFYgh1zQsSgMo7s5Koo0wTr2ZhkJX?=
 =?us-ascii?Q?i+MewEouClwsJRR0rBr3fuKDnlDl7xGhhLykE4npXPHNgH0mKPEmY45eHUP9?=
 =?us-ascii?Q?oD97DtPN8f0ZADBn38QmkHLmtuKXCY+Q2NspfIFq2emjYZMOnr3Jhbx/g8PI?=
 =?us-ascii?Q?sKTAlK93edk4Lao+/xu38wMQRmALBBjlK8u7JBSPvq7MciSfXNMdaksz1S9X?=
 =?us-ascii?Q?kvhnSQvU+4sWqugN4uFJGhG/DYng947i4OrTeIX3A0KGsDE4Jsz9L12wAl0a?=
 =?us-ascii?Q?BWiLLkmxDOLnsqbualjrCOg+WkfL5Hnf2Yz12hlncAFVNLIM07GOogSiOC4E?=
 =?us-ascii?Q?Qr7FutkYWmJmFy3rz5UhHMorlLTGKo+OSHmXf6q0XX79Jm1IzMyteld1UeZA?=
 =?us-ascii?Q?OY9Paoy5iIzxj1e3Fa1LjUWqf3FjCNftf5I5V6A1Y7lijDQnRHQNHPFE0tL3?=
 =?us-ascii?Q?MWcFdnbYH5icXFd8gCWtx8nQAgkyaOO6sihRVpsK4iPvJxfXQA8OnLDDQH2v?=
 =?us-ascii?Q?sfw6rsYf+69Lm/xS1Wu0S5IgIHiGkwCG1SK8fgkGffBmwqXJ7Om6zH6NZKbJ?=
 =?us-ascii?Q?EIL5uoe1x1ggaPFU36Td6rB+8GLUWWIij5e/fGs7cnvG3PyNAM4kYCdSklwe?=
 =?us-ascii?Q?GFR9BlQXhvJQeBhVyVPKjlKsxRJrqXPc45ymLcOoTo3qk8ecGHrDELh4KuOp?=
 =?us-ascii?Q?XTllj/EW/y1xOywPR7+WieUoE1IQZdHRYJ3n8uObJVe3ziDsEiXV4OAVS0Op?=
 =?us-ascii?Q?lkR9MpSxM1JuKqXZLBaQpsjreJ2xwNdEENsYhAC4xm1HUIVLyefEjnIxzzQL?=
 =?us-ascii?Q?7447E6zfMI36vAPsOk6Z72Rx1ym/VWtlR8ts6DytmD6Gk2Ti4U5WNmUCEOgl?=
 =?us-ascii?Q?O5h/bMblLeR8/0cNN3/Cv7rr1HTIZR+HtuveoHxc?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c22c65-d17d-4ac2-613e-08db6f386d91
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 13:40:35.1271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: da6NwRJxnpR4N1XsB0dkuqem+7SLMx2e2kLCNkwOYDtD4cpm7TSEz1vmFLR2TXnz/uEgy1RfPoPB84PKT7YK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8220
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

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 371 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  75 ++++
 3 files changed, 447 insertions(+)
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
index 000000000000..ae78740926e3
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
+			/* pcieclk: si53154@6b */
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
index 000000000000..723bb2263314
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -0,0 +1,75 @@
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
+		#address-cells = <1>;
+		#size-cells = <1>;
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

