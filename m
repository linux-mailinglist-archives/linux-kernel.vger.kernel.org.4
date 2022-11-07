Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB061F8BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiKGQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiKGQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:15:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AF312737;
        Mon,  7 Nov 2022 08:15:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D94ED1;
        Mon,  7 Nov 2022 08:15:51 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2B393F534;
        Mon,  7 Nov 2022 08:15:29 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chester Lin <clin@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>, Li Jun <jun.li@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Martin Kepplinger <martink@posteo.de>,
        David Heidelberg <david@ixit.cz>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Vidya Sagar <vidyas@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 08/23] arm64: dts: Update cache properties for freescale
Date:   Mon,  7 Nov 2022 16:57:01 +0100
Message-Id: <20221107155825.1644604-9-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107155825.1644604-1-pierre.gondois@arm.com>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DeviceTree Specification v0.3 specifies that the cache node
'compatible' and 'cache-level' properties are 'required'. Cf.
s3.8 Multi-level and Shared Cache Nodes
The 'cache-unified' property should be present if one of the
properties for unified cache is present ('cache-size', ...).

Update the Device Trees accordingly.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi     | 1 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi      | 1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi      | 1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi      | 1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 1 +
 arch/arm64/boot/dts/freescale/imx8qm.dtsi      | 2 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi     | 1 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi     | 1 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi       | 2 ++
 arch/arm64/boot/dts/freescale/s32v234.dtsi     | 2 ++
 16 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index ac1c3a7e5f7a..1b33cabb4e14 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -46,6 +46,7 @@ cpu1: cpu@1 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 704f72caddd3..b9fd24cdc919 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -84,6 +84,7 @@ cpu3: cpu@3 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 3d9e29824bb2..a01e3cfec77f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -79,6 +79,7 @@ cpu3: cpu@3 {
 
 		l2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index a2cadf757148..1e5d76c4d83d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -95,18 +95,22 @@ cpu7: cpu@301 {
 
 	cluster0_l2: l2-cache0 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	cluster1_l2: l2-cache1 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	cluster2_l2: l2-cache2 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	cluster3_l2: l2-cache3 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	CPU_PW20: cpu-pw20 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index c3dc38188c17..c12c86915ec8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -95,18 +95,22 @@ cpu7: cpu@301 {
 
 	cluster0_l2: l2-cache0 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	cluster1_l2: l2-cache1 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	cluster2_l2: l2-cache2 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	cluster3_l2: l2-cache3 {
 		compatible = "cache";
+		cache-level = <2>;
 	};
 
 	CPU_PW20: cpu-pw20 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 8c76d86cb756..50c19e8405d5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -300,6 +300,7 @@ cpu701: cpu@701 {
 
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -308,6 +309,7 @@ cluster0_l2: l2-cache0 {
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -316,6 +318,7 @@ cluster1_l2: l2-cache1 {
 
 		cluster2_l2: l2-cache2 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -324,6 +327,7 @@ cluster2_l2: l2-cache2 {
 
 		cluster3_l2: l2-cache3 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -332,6 +336,7 @@ cluster3_l2: l2-cache3 {
 
 		cluster4_l2: l2-cache4 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -340,6 +345,7 @@ cluster4_l2: l2-cache4 {
 
 		cluster5_l2: l2-cache5 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -348,6 +354,7 @@ cluster5_l2: l2-cache5 {
 
 		cluster6_l2: l2-cache6 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -356,6 +363,7 @@ cluster6_l2: l2-cache6 {
 
 		cluster7_l2: l2-cache7 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 5ddbda0b4def..9a7965a694a2 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -59,6 +59,7 @@ A35_1: cpu@1 {
 
 		A35_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index dabd94dc30c4..149b7af5349d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -139,6 +139,7 @@ A53_3: cpu@3 {
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ad0b99adf691..12cc1a6c50c2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -139,6 +139,7 @@ A53_3: cpu@3 {
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index bb916a0948a8..e2a9ddbe4d40 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -123,6 +123,7 @@ A53_3: cpu@3 {
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-level = <2>;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 19eaa523564d..1b7e7ac2750a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -179,6 +179,7 @@ A53_3: cpu@3 {
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index c9c2b6536233..41ce8336f29e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -136,6 +136,7 @@ A72_1: cpu@101 {
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
@@ -144,6 +145,7 @@ A53_L2: l2-cache0 {
 		A72_L2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index f4ea18bb95ab..85c0b1d2bac5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -127,6 +127,7 @@ A35_3: cpu@3 {
 		A35_L2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 06ce5f19aa8a..32193a43ff49 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -51,6 +51,7 @@ A35_1: cpu@1 {
 
 		A35_L2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 824d401e7a2c..d8c82da88ca0 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -52,10 +52,12 @@ cpu3: cpu@101 {
 
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
index ba0b5305d481..3e306218d533 100644
--- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
@@ -61,10 +61,12 @@ cpu3: cpu@101 {
 
 		cluster0_l2_cache: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		cluster1_l2_cache: l2-cache1 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.25.1

