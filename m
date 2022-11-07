Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1986861F890
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiKGQLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiKGQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:11:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4C7B2019C;
        Mon,  7 Nov 2022 08:11:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B33D113E;
        Mon,  7 Nov 2022 08:11:37 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 105343F534;
        Mon,  7 Nov 2022 08:11:15 -0800 (PST)
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
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>, Li Jun <jun.li@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        David Heidelberg <david@ixit.cz>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
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
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 05/23] arm64: dts: Update cache properties for arm
Date:   Mon,  7 Nov 2022 16:56:58 +0100
Message-Id: <20221107155825.1644604-6-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/arm/corstone1000.dtsi            | 1 +
 arch/arm64/boot/dts/arm/foundation-v8.dtsi           | 1 +
 arch/arm64/boot/dts/arm/juno-r1.dts                  | 2 ++
 arch/arm64/boot/dts/arm/juno-r2.dts                  | 2 ++
 arch/arm64/boot/dts/arm/juno.dts                     | 2 ++
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts           | 1 +
 arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 1 +
 7 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/corstone1000.dtsi b/arch/arm64/boot/dts/arm/corstone1000.dtsi
index 4e46826f883a..21f1f952e985 100644
--- a/arch/arm64/boot/dts/arm/corstone1000.dtsi
+++ b/arch/arm64/boot/dts/arm/corstone1000.dtsi
@@ -53,6 +53,7 @@ gic: interrupt-controller@1c000000 {
 
 	L2_0: l2-cache0 {
 		compatible = "cache";
+		cache-unified;
 		cache-level = <2>;
 		cache-size = <0x80000>;
 		cache-line-size = <64>;
diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
index 83e3e7e3984f..c8bd23b1a7ba 100644
--- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
+++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
@@ -58,6 +58,7 @@ cpu3: cpu@3 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 6451c62146fd..1d90eeebb37d 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -189,6 +189,7 @@ A53_3: cpu@103 {
 
 		A57_L2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
@@ -197,6 +198,7 @@ A57_L2: l2-cache0 {
 
 		A53_L2: l2-cache1 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index 438cd1ff4bd0..d2ada69b0a43 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -195,6 +195,7 @@ A53_3: cpu@103 {
 
 		A72_L2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
@@ -203,6 +204,7 @@ A72_L2: l2-cache0 {
 
 		A53_L2: l2-cache1 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index cf4a58211399..5e48a01a5b9f 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -194,6 +194,7 @@ A53_3: cpu@103 {
 
 		A57_L2: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
 			cache-sets = <2048>;
@@ -202,6 +203,7 @@ A57_L2: l2-cache0 {
 
 		A53_L2: l2-cache1 {
 			compatible = "cache";
+			cache-unified;
 			cache-size = <0x100000>;
 			cache-line-size = <64>;
 			cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
index 258991ad7cc0..ef68f5aae7dd 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
@@ -71,6 +71,7 @@ cpu@3 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index 5b6d9d8e934d..796cd7d02eb5 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -57,6 +57,7 @@ cpu@1 {
 
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.25.1

