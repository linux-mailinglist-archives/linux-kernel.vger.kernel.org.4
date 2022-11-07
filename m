Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222C261FA13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiKGQiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGQiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:38:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 244B9CDA;
        Mon,  7 Nov 2022 08:38:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F14141FB;
        Mon,  7 Nov 2022 08:38:21 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C69D73F534;
        Mon,  7 Nov 2022 08:38:00 -0800 (PST)
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
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
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
        David Heidelberg <david@ixit.cz>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>, Wei Fang <wei.fang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
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
        Arjun K V <arjun.kv@samsung.com>, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 23/23] arm64: dts: Update cache properties for ti
Date:   Mon,  7 Nov 2022 16:57:16 +0100
Message-Id: <20221107155825.1644604-24-pierre.gondois@arm.com>
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
 arch/arm64/boot/dts/ti/k3-am625.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am642.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-am654.dtsi  | 2 ++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi  | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi | 1 +
 7 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index 887f31c23fef..7d7e5a1673a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -95,6 +95,7 @@ cpu3: cpu@3 {
 
 	L2_0: l2-cache0 {
 		compatible = "cache";
+		cache-unified;
 		cache-level = <2>;
 		cache-size = <0x40000>;
 		cache-line-size = <64>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
index 331d89fda29d..9734549851c0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
@@ -95,6 +95,7 @@ cpu3: cpu@3 {
 
 	L2_0: l2-cache0 {
 		compatible = "cache";
+		cache-unified;
 		cache-level = <2>;
 		cache-size = <0x40000>;
 		cache-line-size = <64>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642.dtsi b/arch/arm64/boot/dts/ti/k3-am642.dtsi
index 8a76f4821b11..7a6eedea3aae 100644
--- a/arch/arm64/boot/dts/ti/k3-am642.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642.dtsi
@@ -58,6 +58,7 @@ cpu1: cpu@1 {
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x40000>;
 		cache-line-size = <64>;
 		cache-sets = <256>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
index a89257900047..4cc329b271ac 100644
--- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
@@ -93,6 +93,7 @@ cpu3: cpu@101 {
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x80000>;
 		cache-line-size = <64>;
 		cache-sets = <512>;
@@ -102,6 +103,7 @@ L2_0: l2-cache0 {
 	L2_1: l2-cache1 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x80000>;
 		cache-line-size = <64>;
 		cache-sets = <512>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index b6da0454cc5b..d74f86b0f622 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -84,6 +84,7 @@ cpu1: cpu@1 {
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
 		cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 0e23886c9fd1..6975cae644d9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -86,6 +86,7 @@ cpu1: cpu@1 {
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
+		cache-unified;
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
 		cache-sets = <1024>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
index 7b930a85a29d..78295ee0fee5 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -69,6 +69,7 @@ cpu1: cpu@1 {
 
 	L2_0: l2-cache0 {
 		compatible = "cache";
+		cache-unified;
 		cache-level = <2>;
 		cache-size = <0x100000>;
 		cache-line-size = <64>;
-- 
2.25.1

