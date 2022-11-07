Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0990A61F9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiKGQ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiKGQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:29:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B44D91DA65;
        Mon,  7 Nov 2022 08:27:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99C221FB;
        Mon,  7 Nov 2022 08:27:18 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32B153F534;
        Mon,  7 Nov 2022 08:26:57 -0800 (PST)
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
        Zhou Peng <eagle.zhou@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Martin Kepplinger <martink@posteo.de>,
        David Heidelberg <david@ixit.cz>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 16/23] arm64: dts: Update cache properties for qcom
Date:   Mon,  7 Nov 2022 16:57:09 +0100
Message-Id: <20221107155825.1644604-17-pierre.gondois@arm.com>
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

About msm8953.dtsi:
According to the Devicetree Specification v0.3,
s3.7.3 'Internal (L1) Cache Properties',
  cache-unified:
  If present, specifies the cache has a unified or-
  ganization. If not present, specifies that the
  cache has a Harvard architecture with separate
  caches for instructions and data.
Plus, the 'cache-level' property seems to be reserved to higher
cache levels (cf s3.8).

To describe a l1 data/instruction cache couple, no cache
information should be described. Remove the l1 cache nodes.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi  | 56 --------------------------
 arch/arm64/boot/dts/qcom/sc7180.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  9 +++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm6125.dtsi   |  2 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8150.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi   |  9 +++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  9 +++++
 11 files changed, 83 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 6b992a6d56c1..a07b7a45b9e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -42,13 +42,6 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU1: cpu@1 {
@@ -59,13 +52,6 @@ CPU1: cpu@1 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU2: cpu@2 {
@@ -76,13 +62,6 @@ CPU2: cpu@2 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU3: cpu@3 {
@@ -93,13 +72,6 @@ CPU3: cpu@3 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU4: cpu@100 {
@@ -110,13 +82,6 @@ CPU4: cpu@100 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU5: cpu@101 {
@@ -127,13 +92,6 @@ CPU5: cpu@101 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU6: cpu@102 {
@@ -144,13 +102,6 @@ CPU6: cpu@102 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		CPU7: cpu@103 {
@@ -161,13 +112,6 @@ CPU7: cpu@103 {
 			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&L2_1>;
 			#cooling-cells = <2>;
-
-			l1-icache {
-				compatible = "cache";
-			};
-			l1-dcache {
-				compatible = "cache";
-			};
 		};
 
 		cpu-map {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 58976a1ba06b..ecda96d19861 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -146,9 +146,11 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -171,6 +173,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -193,6 +196,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -215,6 +219,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -237,6 +242,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -259,6 +265,7 @@ &LITTLE_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -281,6 +288,7 @@ &BIG_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -303,6 +311,7 @@ &BIG_CPU_SLEEP_1
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 212580316d3e..2476e494a5a9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -180,9 +180,11 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -203,6 +205,7 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -223,6 +226,7 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -243,6 +247,7 @@ &LITTLE_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -263,6 +268,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -283,6 +289,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -303,6 +310,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -323,6 +331,7 @@ &BIG_CPU_SLEEP_1
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c32bcded2aef..8acb037d77a2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -188,9 +188,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -209,6 +211,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -227,6 +230,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -245,6 +249,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -263,6 +268,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -281,6 +287,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -299,6 +306,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -317,6 +325,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d761da47220d..52bccd705bee 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -209,9 +209,11 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -233,6 +235,7 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -254,6 +257,7 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -275,6 +279,7 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -296,6 +301,7 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -317,6 +323,7 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -338,6 +345,7 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -359,6 +367,7 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 1fe3fa3ad877..7768db00e698 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -45,6 +45,7 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 			};
 		};
 
@@ -84,6 +85,7 @@ CPU4: cpu@100 {
 			next-level-cache = <&L2_1>;
 			L2_1: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index c39de7d3ace0..b9e5de93bbda 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -50,9 +50,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -69,6 +71,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -85,6 +88,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -101,6 +105,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -117,6 +122,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -133,6 +139,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 
@@ -150,6 +157,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -166,6 +174,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index cef8c4f4f0ff..03168a47d007 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -60,9 +60,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -84,6 +86,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 
@@ -106,6 +109,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -127,6 +131,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -148,6 +153,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -169,6 +175,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -190,6 +197,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -211,6 +219,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a5b62cadb129..1cf3a569989d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -110,9 +110,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 					compatible = "cache";
+					cache-level = <3>;
 				};
 			};
 		};
@@ -134,6 +136,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -155,6 +158,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -176,6 +180,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -197,6 +202,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -218,6 +224,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 
@@ -240,6 +247,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
@@ -261,6 +269,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 				compatible = "cache";
+				cache-level = <2>;
 				next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a86d9ea93b9d..545bc1774f74 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -73,9 +73,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -92,6 +94,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -108,6 +111,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -124,6 +128,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -140,6 +145,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -156,6 +162,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 
@@ -173,6 +180,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -189,6 +197,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d32f08df743d..3292f5fbf44d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -53,9 +53,11 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 				L3_0: l3-cache {
 				      compatible = "cache";
+				      cache-level = <3>;
 				};
 			};
 		};
@@ -72,6 +74,7 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -88,6 +91,7 @@ CPU2: cpu@200 {
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -104,6 +108,7 @@ CPU3: cpu@300 {
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -120,6 +125,7 @@ CPU4: cpu@400 {
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -136,6 +142,7 @@ CPU5: cpu@500 {
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 
@@ -153,6 +160,7 @@ CPU6: cpu@600 {
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
@@ -169,6 +177,7 @@ CPU7: cpu@700 {
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
+			      cache-level = <2>;
 			      next-level-cache = <&L3_0>;
 			};
 		};
-- 
2.25.1

