Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6861F89D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiKGQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiKGQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:12:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5001820375;
        Mon,  7 Nov 2022 08:12:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EFEE139F;
        Mon,  7 Nov 2022 08:13:02 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 328D33F534;
        Mon,  7 Nov 2022 08:12:41 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        William Zhang <william.zhang@broadcom.com>,
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
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Ming Qian <ming.qian@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, Li Jun <jun.li@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        David Heidelberg <david@ixit.cz>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Wei Fang <wei.fang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Vidya Sagar <vidyas@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Andi Shyti <andi@etezian.org>, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 06/23] arm64: dts: Update cache properties for broadcom
Date:   Mon,  7 Nov 2022 16:56:59 +0100
Message-Id: <20221107155825.1644604-7-pierre.gondois@arm.com>
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
Acked-by: William Zhang <william.zhang@broadcom.com>
---
 arch/arm/boot/dts/bcm2711.dtsi                      | 1 +
 arch/arm/boot/dts/bcm2837.dtsi                      | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi   | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi   | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 1 +
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++++
 11 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 941c4d16791b..c6104149f959 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -536,6 +536,7 @@ cpu3: cpu@3 {
 		 */
 		l2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>; // 1MiB(size)/64(line-size)=16384ways/16-way set
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 5dbdebc46259..b352ac784af6 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -115,6 +115,7 @@ cpu3: cpu@3 {
 		 */
 		l2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x80000>;
 			cache-line-size = <64>;
 			cache-sets = <512>; // 512KiB(size)/64(line-size)=8192ways/16-way set
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index dac9d3b4e91d..996412ed52a0 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -63,6 +63,7 @@ cpu3: cpu@3 {
 
 		l2: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
index 3d016c2ce675..d5bc31980f03 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
@@ -51,6 +51,7 @@ B53_3: cpu@3 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
index 04de96bd0a03..6f805266d3c9 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
@@ -35,6 +35,7 @@ B53_1: cpu@1 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
index 13629702f70b..b982249b80a2 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
@@ -51,6 +51,7 @@ B53_3: cpu@3 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
index c3e6197be808..a996d436e977 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
@@ -51,6 +51,7 @@ B53_3: cpu@3 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
index 0bce6497219f..62c530d4b103 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
@@ -35,6 +35,7 @@ B53_1: cpu@1 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
index 29a880c6c858..ba3d5a98ccbc 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -50,6 +50,7 @@ B53_3: cpu@3 {
 		};
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index fda97c47f4e9..18cdbc20f03f 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -79,6 +79,7 @@ A57_3: cpu@3 {
 
 		CLUSTER0_L2: l2-cache@0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 8f8c25e51194..e05901abe957 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -108,18 +108,22 @@ cpu@301 {
 
 		CLUSTER0_L2: l2-cache@0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		CLUSTER1_L2: l2-cache@100 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		CLUSTER2_L2: l2-cache@200 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		CLUSTER3_L2: l2-cache@300 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.25.1

