Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D275A61F9AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiKGQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiKGQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:28:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0800221E33;
        Mon,  7 Nov 2022 08:25:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0A5323A;
        Mon,  7 Nov 2022 08:25:49 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 768343F534;
        Mon,  7 Nov 2022 08:25:28 -0800 (PST)
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
        Peng Fan <peng.fan@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, Li Jun <jun.li@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Joy Zou <joy.zou@nxp.com>, David Heidelberg <david@ixit.cz>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Wei Fang <wei.fang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Vidya Sagar <vidyas@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Bharat Uppal <bharat.uppal@samsung.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 15/23] arm64: dts: Update cache properties for nvidia
Date:   Mon,  7 Nov 2022 16:57:08 +0100
Message-Id: <20221107155825.1644604-16-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 15 +++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 33 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 41f3a7e188d0..ed2a534dcfd6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -3029,36 +3029,51 @@ core1 {
 		};
 
 		l2c_0: l2-cache0 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_1: l2-cache1 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_2: l2-cache2 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l2c_3: l2-cache3 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <2>;
 			next-level-cache = <&l3c>;
 		};
 
 		l3c: l3-cache {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <4194304>;
 			cache-line-size = <64>;
+			cache-level = <3>;
 			cache-sets = <4096>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 724e87450605..9474b0da0a3e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -2005,6 +2005,7 @@ CPU_SLEEP: cpu-sleep {
 
 		L2: l2-cache {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 0170bfa8a467..583c12444124 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2905,117 +2905,150 @@ core3 {
 		};
 
 		l2c0_0: l2-cache00 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_1: l2-cache01 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_2: l2-cache02 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c0_3: l2-cache03 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c0>;
 		};
 
 		l2c1_0: l2-cache10 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_1: l2-cache11 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_2: l2-cache12 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c1_3: l2-cache13 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c1>;
 		};
 
 		l2c2_0: l2-cache20 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_1: l2-cache21 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_2: l2-cache22 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l2c2_3: l2-cache23 {
+			compatible = "cache";
 			cache-size = <262144>;
 			cache-line-size = <64>;
 			cache-sets = <512>;
 			cache-unified;
+			cache-level = <2>;
 			next-level-cache = <&l3c2>;
 		};
 
 		l3c0: l3-cache0 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 
 		l3c1: l3-cache1 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 
 		l3c2: l3-cache2 {
+			compatible = "cache";
+			cache-unified;
 			cache-size = <2097152>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
+			cache-level = <3>;
 		};
 	};
 
-- 
2.25.1

