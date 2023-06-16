Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1768D732F75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbjFPLIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjFPLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:08:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5A10E3;
        Fri, 16 Jun 2023 04:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlOoP79zpul0XoQI9V54aZ2ZaNH62yQu8OPFcGvVHGCux4iL/wZGoXkdNmY3NO2i/3eLSPEqwUGR54cGSbfK9qmpfEJDEzg0cob67vKWAZhmMA0X5SDM7/I/pLJ1d37cjtSMhCipQqgpQSnUF/Rl9LATGhvDybPH5hhYptnLtTnrk6eZjSRQFzlVJblnHrjctE1NzogRmeC57YMjj7hbho8h/FB1C6X1Of2i3fKFrCNtxzfZtfrm37qgwq8wWZUvSAj34EbThwK9bIqHg9WRmR5Pmdppqd6UMrZ+AH5xzjOKRMcpswmLfmugq/YdCw7xc8feQsge/91cKKhGTcauSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTXBUSz9EVqkFtZMMowSDeC+6gxcqd+Q1cbsUiHycMo=;
 b=jN+x/mr9hUcmMHbaKNVh+m1NI31/40eqQAVKRymkTUSncV2svdf5fQiD/asqIcId7M6fvc8EIJ/IzflsyQIymsb5N0WletVGQRYFN2G83sue1RutdYTvY1+LHdc+4IfUjRH7uDcorQd2oXn+p/T/GTup4SzysrxLQPniR375LjAx/ZFgOWX5spmSkdjVSSUromrTFHpNoD4UQY1IiEsNkwA5W8lWgQ0/0wcBIv6R2XqLnqnSnJ7ZHTjdZ6K+gj+hNdZGvUSrTOzTEdCAOyYgj+cTsqN7cwjbiSv9tAKlOndCj7eDOvFy6oFol1Rrd6/8/HZLDvWe2f+ScxIKBJlGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTXBUSz9EVqkFtZMMowSDeC+6gxcqd+Q1cbsUiHycMo=;
 b=ALeVWWxWED65CULO8OSHn7HEf8EXduJKozActbuD+oLdvTqb3gFEpV7pQisBRlgcI8JVDs14dhkVpg26OUFfs/5c8dZX2bO1jbK82sCSGZMZE/PX7KMat/52wJ1kY6dJFdhZIikrbOmDfV6tZ/wXDXse2fCgrBw4adMN6WKx7IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAXPR04MB9491.eurprd04.prod.outlook.com (2603:10a6:102:2c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:06:35 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 11:06:35 +0000
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
Subject: [PATCH 3/3] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Fri, 16 Jun 2023 14:06:10 +0300
Message-Id: <20230616110610.32173-4-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616110610.32173-1-josua@solid-run.com>
References: <20230616110610.32173-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PAXPR04MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f42d39f-9332-447f-703c-08db6e59bfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIZdzAS/3z5lZGUHHDVjeFY1t9UZbBywcjXGr4M2UAjiCbso/A0vLky0YZm61STo1J6QdRXkSEmb64Pnl76CKGLtxIzZ8rMk4kOKS0obb1V06k2nCr1wUMOp0LDrl3EAgB05Qc/MeCRbObX8/dsegxuJe8ABuRNrc2VTsw3B1JvQ3a/GLXH1Nfnbgj6v/rAw26YPglQmMVupxoeuphUWmMRCwtbm22pn3nv2cBaBfAug+8G1aFKsLJkZrWB16F3l3EmlKpaw/2EL4pWN1bRM41oCku/wPGetBX/WmP/3FdiImwjUQXHzIqnGTlt2shFKWtxF49ESC9ZssczSvblqmE3oA4Pd/RE4I/erwuV3r1wqEL4DaD9jrnGI9GsNDk5Z0E7OP6/091xyEc4viKIVvO2S1DXQ9eAf8iJgXkVLPtcs5htg/Jiw7f8TAkDPJ7fc/gob8RrtJftrG463uv30uIE2TWXDV+MHru3hB2L+KXVe57KOyHocZWoAtY6BiyL04koQzmhCIvT81zF7FqfhiqVdMdi4577F+yre8AA4ANkOFmLQDC6N5+yxoQhGwDTZ1JYoHJHRNgo9Tz/z5NbDOzjISrdPTuH9NYtrNAmGj8gUW5nXar0Mq5eS3fNyuwLL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(136003)(376002)(346002)(396003)(451199021)(478600001)(86362001)(52116002)(6486002)(6666004)(316002)(41300700001)(38100700002)(38350700002)(83380400001)(66556008)(66946007)(4326008)(66476007)(8676002)(8936002)(2906002)(30864003)(5660300002)(186003)(54906003)(6512007)(26005)(6506007)(1076003)(2616005)(36756003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsx79AlFVQL4wIJ0RrDckAGg05Z8vJ3RdwuGrvyrI727pYyQr1z7XuWQXUaq?=
 =?us-ascii?Q?tgNL7e0zzdpTbaOoMc7kcH5hSOlok03p4cQ5YOjXOBopfmdepl5kpnhJpbez?=
 =?us-ascii?Q?77KnIg6SjIvrnnTEQnFsRXcUYI4DbQJ0cBy+tPoQCUuwLeqIq0+S+y26fOwo?=
 =?us-ascii?Q?mhr62IX0RiihOtOSoAllHTLXNplJ7LdSkMg9+OTRnOJ1Ye+dchiAJPnbQ4eI?=
 =?us-ascii?Q?dhyylQ3vT73BzHY0FvDfO3WpwYeHrmZ+RzJsVN0iXx4uYxw53ocrfw8xwADN?=
 =?us-ascii?Q?8K3SV+LhWKxzarHlhDmCoNlk17RdUJZPqFPyBgUqJqTtT3EuOACbHEvogXnE?=
 =?us-ascii?Q?a2OvABIFRQ+HhPu8l3PXjFsIjoGZbY2LTJ3+UzwBHdipZBeEGWEYEyyw5eaY?=
 =?us-ascii?Q?pGFsiZVmY6Gsn3CqapPCVIN7sz745YDviTTDZyHeslIloCBKIsbqPGiDmE+Z?=
 =?us-ascii?Q?liSOUW1VhOHWkK6ycqY5UGLij0DvN11NJo6XlK15SN1L3cyQa4NX2tNDsPa0?=
 =?us-ascii?Q?V5j4Wy+6qMa3az+DPUOUn9lNzATrHZORbSz8oB/YdH7Sec8q0lMAJt7O2vCF?=
 =?us-ascii?Q?xXp7SNzs/EkbYMguZdggrDtbJC3xQiNwOc2j2VKSjaC70/7cT4S0aX+udQYq?=
 =?us-ascii?Q?x4QHBttB29lxGlYhFMRmhm6Te/YiheKfrTS5HkpQhNM5c29yGaNP6w96pTDP?=
 =?us-ascii?Q?A0e0VCCm7iP8ZIvxFJEPqQMCEN8Icdayji7PzzdjMk+FDCu/HBv6SKOhNYrR?=
 =?us-ascii?Q?9ZvO4ZvbLHG7Ick4CiMfbqUodtrZXP8X+2T4fd0XttU9EzAsc8ZlC69V8egj?=
 =?us-ascii?Q?o+XpmVUTYcX9Dd4oSauz6+zbmQJpcJVM/nfG6exjgskhkyZ7ZYMJ9o9FB/Gj?=
 =?us-ascii?Q?1DmjIyZV0rvqZGIWGc4oZSt/xto06l2bzCae+5PMi33147llaFq70tSjNEq4?=
 =?us-ascii?Q?fuAeh/6iQ4kfIv/ESmC9Pl2NAVihbylZ8F0RU6uAxlsliEZoAq+RvVVsd7Vc?=
 =?us-ascii?Q?bZQp8+rkCqa30BEuVnaM7RfWZXxiFggKsGRE9HoF6oN7tzM+BK5626jCsIKn?=
 =?us-ascii?Q?Rn8J1A2NGf3mD+7+omwwwEDpNrm1Os65NqLrobuOMRFTxVsTMb9HplMedJ50?=
 =?us-ascii?Q?V/nCgE2CWOXIpuF83vSi+tZpdd5a5wLKkIs+PhyZcLKkYDlzFoRqOZqVAyay?=
 =?us-ascii?Q?Be1e655zf2VWpJ+iEvKMCnLGB6cqu8ma1gS0FoDB+gsFkCCsASCR14nHhsbh?=
 =?us-ascii?Q?3xqTXj0QtKNdOmnrV6d+rbvHl4e5jXu7AIPwXa7J22wVDB+4GOxJAUkybx4j?=
 =?us-ascii?Q?VnIo1UXD46WKfWOXwjfFwUfZhFTgaa2HQ3wD4Z7+kZGWUxHwUxi8GpOmnW80?=
 =?us-ascii?Q?RZvDTlWUuN6jllLNI3gSITgUFV7/+qZM/5J0N5+aZwBNdtkvBZyHpns9Izlk?=
 =?us-ascii?Q?SIMhItdNfWON0qJFE6ssteynewVW6fuA1eR6myg2T9qzKRhM4VkQWtmRlVyX?=
 =?us-ascii?Q?uCz+srWEfWZvyYzHumlJIfWTsUnzO/Yy2HSAWeyw18ioPBhS/hgwc/Jo6gvq?=
 =?us-ascii?Q?a5DQYG6mjPdJ3kX8/Uwev2D1IOVAuEy48THjY/mw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f42d39f-9332-447f-703c-08db6e59bfa2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:06:35.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTaZEvT0WIUe+I/KIEQDxt4o6rBngQ/B/pP/1uOIKOMKfHUpBnS7Fe1GKNO1uBqAv4ERDIIxRPvwoCTbRlQLRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9491
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
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
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 369 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  78 ++++
 3 files changed, 448 insertions(+)
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
index 000000000000..550693b74e19
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -0,0 +1,369 @@
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
+	compatible = "solidrun,clearfog", "solidrun,lx2162a-som", "fsl,lx2160a";
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
+		mod-def0-gpio = <&gpio2 16 GPIO_ACTIVE_LOW>; /* EVT4_B */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_ab: sfp-ab {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c1>;
+		mod-def0-gpio = <&gpio2 1 GPIO_ACTIVE_LOW>; /* PROC_IRQ1 */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_bt: sfp-bt {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c2>;
+		mod-def0-gpio = <&gpio2 10 GPIO_ACTIVE_LOW>; /* PROC_IRQ10 */
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp_bb: sfp-bb {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_i2c3>;
+		mod-def0-gpio = <&gpio2 15 GPIO_ACTIVE_LOW>; /* EVT3_B */
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&i2c2 {
+	/* retimer: ds250df410@18 */
+
+	i2c-switch@70 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
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
+	i2c-switch@71 {
+		compatible = "nxp,pca9546";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
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
+	phy-connection-type = "rgmii";
+};
+
+&dpmac12 {
+	status = "okay";
+	phys = <&serdes_2 1>;
+	phy-handle = <&ethernet_phy0>;
+	phy-connection-type = "rgmii";
+};
+
+&dpmac13 {
+	status = "okay";
+	phys = <&serdes_2 6>;
+	phy-handle = <&ethernet_phy5>;
+	phy-connection-type = "rgmii";
+};
+
+&dpmac14 {
+	status = "okay";
+	phys = <&serdes_2 7>;
+	phy-handle = <&ethernet_phy7>;
+	phy-connection-type = "rgmii";
+};
+
+&dpmac15 {
+	status = "okay";
+	phys = <&serdes_2 4>;
+	phy-handle = <&ethernet_phy3>;
+	phy-connection-type = "rgmii";
+};
+
+&dpmac16 {
+	status = "okay";
+	phys = <&serdes_2 5>;
+	phy-handle = <&ethernet_phy1>;
+	phy-connection-type = "rgmii";
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
+	phy-connection-type = "rgmii";
+};
+
+&dpmac18 {
+	status = "okay";
+	phys = <&serdes_2 3>;
+	phy-handle = <&ethernet_phy6>;
+	phy-connection-type = "rgmii";
+};
+
+&emdio1 {
+	/*
+	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
+	 * It competes for WRIOP MAC17, and no connector has been wired.
+	 */
+	/delete-node/ ethernet-phy@1;
+
+	ethernet_phy0: mv88e2580@8 {
+		reg = <8>;
+		compatible = "ethernet-phy-ieee802.3-c45";
+		max-speed = <1000>;
+	};
+
+	ethernet_phy1: mv88e2580@9 {
+		reg = <9>;
+		compatible = "ethernet-phy-ieee802.3-c45";
+		max-speed = <1000>;
+	};
+
+	ethernet_phy2: mv88e2580@a {
+		reg = <10>;
+		compatible = "ethernet-phy-ieee802.3-c45";
+		max-speed = <1000>;
+	};
+
+	ethernet_phy3: mv88e2580@b {
+		reg = <11>;
+		compatible = "ethernet-phy-ieee802.3-c45";
+		max-speed = <1000>;
+	};
+
+	ethernet_phy4: mv88e2580@c {
+		reg = <12>;
+		compatible = "ethernet-phy-ieee802.3-c45";
+		max-speed = <1000>;
+	};
+
+	ethernet_phy5: mv88e2580@d {
+		reg = <13>;
+		compatible = "ethernet-phy-ieee802.3-c45";
+		max-speed = <1000>;
+	};
+
+	ethernet_phy6: mv88e2580@e {
+		reg = <14>;
+		compatible = "ethernet-phy-ieee802.3-c45";
+		max-speed = <1000>;
+	};
+
+	ethernet_phy7: mv88e2580@f {
+		reg = <15>;
+		compatible = "ethernet-phy-ieee802.3-c45";
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
index 000000000000..49e03b6600d6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -0,0 +1,78 @@
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
+		compatible = "m25p80", "jedec,spi-nor";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
+		spi-rx-bus-width = <8>;
+		// spi-tx-bus-width = <8>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+		cooling-min-state = <0>;
+		cooling-max-state = <9>;
+		#cooling-cells = <2>;
+	};
+
+	ddr_spd: eeprom@51 {
+		reg = <0x57>;
+		compatible = "st,24c02", "atmel,24c02";
+		read-only;
+	};
+
+	config_eeprom: eeprom@57 {
+		reg = <0x57>;
+		compatible = "st,24c02", "atmel,24c02";
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	variable_eeprom: eeprom@54 {
+		reg = <0x54>;
+		compatible = "st,24c2048", "atmel,24c2048";
+	};
+};
-- 
2.35.3

