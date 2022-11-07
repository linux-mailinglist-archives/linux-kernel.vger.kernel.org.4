Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECF61F83C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiKGQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:04:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 594331115F;
        Mon,  7 Nov 2022 08:04:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EC39ED1;
        Mon,  7 Nov 2022 08:04:37 -0800 (PST)
Received: from pierre123.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AE9A3F534;
        Mon,  7 Nov 2022 08:04:15 -0800 (PST)
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
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Ming Qian <ming.qian@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        David Heidelberg <david@ixit.cz>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
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
Subject: [PATCH v2 00/23] Update cache properties for arm64 DTS
Date:   Mon,  7 Nov 2022 16:56:53 +0100
Message-Id: <20221107155825.1644604-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Update/Add patches for missed cache properties requiring to be
  updated for the following platforns: bcm, amazon, arm, exynos,
  freescale, marvell, mediatek, nvidia, socinext, tesla, ti.
  Missed cache properties were detected using Rob Herring's branch:
  https://github.com/robherring/dt-schema/tree/cache-rework
- v1 of exynos, tesla were merged.
- Updated wrong reference in commit message.
- Added received Rb/Acked-by.

Align arm64 DTS to the DeviceTree specification v0.3 regarding
cache properties. The patch-set mainly adds 'cache-level' or
'cache' compatibility properties.
For one qcom DTS, level 1 cache nodes are removed as they should
be in the cpu nodes.

On another node, it seems that the 'cache-unified' is under-used.
cache-unified:
  If present, specifies the cache has a unified or-
  ganization. If not present, specifies that the
  cache has a Harvard architecture with separate
  caches for instructions and data.
Only a few l2 cache nodes have this property, and in the absence
of [|d|i]-cache-size properties (or other), the cache is assumed to be
split.

The l2 cache of the Rockchip RK3308 platform is thus assumed to be
split:
l2: l2-cache {
	compatible = "cache";
	cache-level = <2>;
};
when the platform datasheet advertises a unified cache.

No modification/check was made to correct that due to the lack of
cache information for most platforms.

Pierre Gondois (23):
  arm64: dts: Update cache properties for amazon
  arm64: dts: Update cache properties for amd
  arm64: dts: Update cache properties for amlogic
  arm64: dts: Update cache properties for apm
  arm64: dts: Update cache properties for arm
  arm64: dts: Update cache properties for broadcom
  arm64: dts: Update cache properties for exynos
  arm64: dts: Update cache properties for freescale
  arm64: dts: Update cache properties for hisilicon
  arm64: dts: Update cache properties for lg
  arm64: dts: Update cache properties for marvell
  arm64: dts: Update cache properties for mediatek
  arm64: dts: Update cache properties for microchip
  arm64: dts: Update cache properties for nuvoton
  arm64: dts: Update cache properties for nvidia
  arm64: dts: Update cache properties for qcom
  arm64: dts: Update cache properties for realtek
  arm64: dts: Update cache properties for renesas
  arm64: dts: Update cache properties for rockchip
  arm64: dts: Update cache properties for socionext
  arm64: dts: Update cache properties for synaptics
  arm64: dts: Update cache properties for tesla
  arm64: dts: Update cache properties for ti

 arch/arm/boot/dts/bcm2711.dtsi                |  1 +
 arch/arm/boot/dts/bcm2837.dtsi                |  1 +
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi     |  4 ++
 arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi |  9 +++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  1 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  1 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi    |  4 ++
 arch/arm64/boot/dts/apm/apm-storm.dtsi        |  4 ++
 arch/arm64/boot/dts/arm/corstone1000.dtsi     |  1 +
 arch/arm64/boot/dts/arm/foundation-v8.dtsi    |  1 +
 arch/arm64/boot/dts/arm/juno-r1.dts           |  2 +
 arch/arm64/boot/dts/arm/juno-r2.dts           |  2 +
 arch/arm64/boot/dts/arm/juno.dts              |  2 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    |  1 +
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts |  1 +
 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |  1 +
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     |  1 +
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    |  1 +
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    |  1 +
 .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     |  1 +
 .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     |  1 +
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     |  1 +
 .../boot/dts/broadcom/northstar2/ns2.dtsi     |  1 +
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  4 ++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  4 ++
 arch/arm64/boot/dts/exynos/exynos7.dtsi       |  2 +
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  1 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  1 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  1 +
 .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |  4 ++
 .../arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  4 ++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  8 +++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi    |  1 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  1 +
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |  2 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  1 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  1 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  2 +
 arch/arm64/boot/dts/freescale/s32v234.dtsi    |  2 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |  2 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |  2 +
 arch/arm64/boot/dts/hisilicon/hip05.dtsi      |  4 ++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi      |  4 ++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi      | 16 ++++++
 arch/arm64/boot/dts/lg/lg1312.dtsi            |  1 +
 arch/arm64/boot/dts/lg/lg1313.dtsi            |  1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi |  1 +
 .../boot/dts/marvell/armada-ap806-dual.dtsi   |  2 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ++
 .../boot/dts/marvell/armada-ap807-quad.dtsi   |  4 ++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  3 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  3 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  1 +
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 15 +++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 33 +++++++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 56 -------------------
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  9 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |  2 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  9 +++
 arch/arm64/boot/dts/realtek/rtd1293.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd1295.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd1296.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd1395.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi      |  2 +
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  1 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  1 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  1 +
 .../boot/dts/socionext/uniphier-ld11.dtsi     |  1 +
 .../boot/dts/socionext/uniphier-ld20.dtsi     |  2 +
 .../boot/dts/socionext/uniphier-pxs3.dtsi     |  1 +
 arch/arm64/boot/dts/synaptics/berlin4ct.dtsi  |  1 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  2 +
 arch/arm64/boot/dts/ti/k3-am625.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi         |  1 +
 arch/arm64/boot/dts/ti/k3-am642.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-am654.dtsi          |  2 +
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |  1 +
 98 files changed, 299 insertions(+), 56 deletions(-)

-- 
2.25.1

