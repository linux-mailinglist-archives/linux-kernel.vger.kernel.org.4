Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F3666C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbjALIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjALIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:33:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49274101DD;
        Thu, 12 Jan 2023 00:33:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D79BFEC;
        Thu, 12 Jan 2023 00:34:31 -0800 (PST)
Received: from [192.168.1.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 467BD3F71A;
        Thu, 12 Jan 2023 00:33:46 -0800 (PST)
Message-ID: <464eb7c6-2195-ff14-298a-d5f7fa09a3e6@arm.com>
Date:   Thu, 12 Jan 2023 09:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v2 00/23] Update cache properties for arm64 DTS
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
Content-Language: en-US
In-Reply-To: <20221107155825.1644604-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(subset of the cc list for the Texas Instruments patch)
Hello,
Just a reminder in case the following patch was forgotten:
    arm64: dts: Update cache properties for ti

Regards,
Pierre

On 11/7/22 16:56, Pierre Gondois wrote:
> v2:
> - Update/Add patches for missed cache properties requiring to be
>    updated for the following platforns: bcm, amazon, arm, exynos,
>    freescale, marvell, mediatek, nvidia, socinext, tesla, ti.
>    Missed cache properties were detected using Rob Herring's branch:
>    https://github.com/robherring/dt-schema/tree/cache-rework
> - v1 of exynos, tesla were merged.
> - Updated wrong reference in commit message.
> - Added received Rb/Acked-by.
> 
> Align arm64 DTS to the DeviceTree specification v0.3 regarding
> cache properties. The patch-set mainly adds 'cache-level' or
> 'cache' compatibility properties.
> For one qcom DTS, level 1 cache nodes are removed as they should
> be in the cpu nodes.
> 
> On another node, it seems that the 'cache-unified' is under-used.
> cache-unified:
>    If present, specifies the cache has a unified or-
>    ganization. If not present, specifies that the
>    cache has a Harvard architecture with separate
>    caches for instructions and data.
> Only a few l2 cache nodes have this property, and in the absence
> of [|d|i]-cache-size properties (or other), the cache is assumed to be
> split.
> 
> The l2 cache of the Rockchip RK3308 platform is thus assumed to be
> split:
> l2: l2-cache {
> 	compatible = "cache";
> 	cache-level = <2>;
> };
> when the platform datasheet advertises a unified cache.
> 
> No modification/check was made to correct that due to the lack of
> cache information for most platforms.
> 
> Pierre Gondois (23):
>    arm64: dts: Update cache properties for amazon
>    arm64: dts: Update cache properties for amd
>    arm64: dts: Update cache properties for amlogic
>    arm64: dts: Update cache properties for apm
>    arm64: dts: Update cache properties for arm
>    arm64: dts: Update cache properties for broadcom
>    arm64: dts: Update cache properties for exynos
>    arm64: dts: Update cache properties for freescale
>    arm64: dts: Update cache properties for hisilicon
>    arm64: dts: Update cache properties for lg
>    arm64: dts: Update cache properties for marvell
>    arm64: dts: Update cache properties for mediatek
>    arm64: dts: Update cache properties for microchip
>    arm64: dts: Update cache properties for nuvoton
>    arm64: dts: Update cache properties for nvidia
>    arm64: dts: Update cache properties for qcom
>    arm64: dts: Update cache properties for realtek
>    arm64: dts: Update cache properties for renesas
>    arm64: dts: Update cache properties for rockchip
>    arm64: dts: Update cache properties for socionext
>    arm64: dts: Update cache properties for synaptics
>    arm64: dts: Update cache properties for tesla
>    arm64: dts: Update cache properties for ti
> 
>   arch/arm/boot/dts/bcm2711.dtsi                |  1 +
>   arch/arm/boot/dts/bcm2837.dtsi                |  1 +
>   arch/arm64/boot/dts/amazon/alpine-v3.dtsi     |  4 ++
>   arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi |  9 +++
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  1 +
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  1 +
>   arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  1 +
>   arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  1 +
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  1 +
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  1 +
>   arch/arm64/boot/dts/apm/apm-shadowcat.dtsi    |  4 ++
>   arch/arm64/boot/dts/apm/apm-storm.dtsi        |  4 ++
>   arch/arm64/boot/dts/arm/corstone1000.dtsi     |  1 +
>   arch/arm64/boot/dts/arm/foundation-v8.dtsi    |  1 +
>   arch/arm64/boot/dts/arm/juno-r1.dts           |  2 +
>   arch/arm64/boot/dts/arm/juno-r2.dts           |  2 +
>   arch/arm64/boot/dts/arm/juno.dts              |  2 +
>   arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    |  1 +
>   .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts |  1 +
>   .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     |  1 +
>   .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     |  1 +
>   .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    |  1 +
>   .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    |  1 +
>   .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     |  1 +
>   .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     |  1 +
>   .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     |  1 +
>   .../boot/dts/broadcom/northstar2/ns2.dtsi     |  1 +
>   .../boot/dts/broadcom/stingray/stingray.dtsi  |  4 ++
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  4 ++
>   arch/arm64/boot/dts/exynos/exynos7.dtsi       |  2 +
>   .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  1 +
>   .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  1 +
>   .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  1 +
>   .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |  4 ++
>   .../arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  4 ++
>   .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  8 +++
>   arch/arm64/boot/dts/freescale/imx8dxl.dtsi    |  1 +
>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  1 +
>   arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  1 +
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  1 +
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  1 +
>   arch/arm64/boot/dts/freescale/imx8qm.dtsi     |  2 +
>   arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  1 +
>   arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  1 +
>   arch/arm64/boot/dts/freescale/s32g2.dtsi      |  2 +
>   arch/arm64/boot/dts/freescale/s32v234.dtsi    |  2 +
>   arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |  2 +
>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |  2 +
>   arch/arm64/boot/dts/hisilicon/hip05.dtsi      |  4 ++
>   arch/arm64/boot/dts/hisilicon/hip06.dtsi      |  4 ++
>   arch/arm64/boot/dts/hisilicon/hip07.dtsi      | 16 ++++++
>   arch/arm64/boot/dts/lg/lg1312.dtsi            |  1 +
>   arch/arm64/boot/dts/lg/lg1313.dtsi            |  1 +
>   arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi |  1 +
>   .../boot/dts/marvell/armada-ap806-dual.dtsi   |  2 +
>   .../boot/dts/marvell/armada-ap806-quad.dtsi   |  4 ++
>   .../boot/dts/marvell/armada-ap807-quad.dtsi   |  4 ++
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  3 +
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  3 +
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +
>   arch/arm64/boot/dts/microchip/sparx5.dtsi     |  1 +
>   .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  1 +
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 15 +++++
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  1 +
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 33 +++++++++++
>   arch/arm64/boot/dts/qcom/msm8953.dtsi         | 56 -------------------
>   arch/arm64/boot/dts/qcom/sc7180.dtsi          |  9 +++
>   arch/arm64/boot/dts/qcom/sc7280.dtsi          |  9 +++
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  9 +++
>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  9 +++
>   arch/arm64/boot/dts/qcom/sm6125.dtsi          |  2 +
>   arch/arm64/boot/dts/qcom/sm6350.dtsi          |  9 +++
>   arch/arm64/boot/dts/qcom/sm8150.dtsi          |  9 +++
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  9 +++
>   arch/arm64/boot/dts/qcom/sm8350.dtsi          |  9 +++
>   arch/arm64/boot/dts/qcom/sm8450.dtsi          |  9 +++
>   arch/arm64/boot/dts/realtek/rtd1293.dtsi      |  1 +
>   arch/arm64/boot/dts/realtek/rtd1295.dtsi      |  1 +
>   arch/arm64/boot/dts/realtek/rtd1296.dtsi      |  1 +
>   arch/arm64/boot/dts/realtek/rtd1395.dtsi      |  1 +
>   arch/arm64/boot/dts/realtek/rtd16xx.dtsi      |  2 +
>   arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  1 +
>   arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  1 +
>   arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  1 +
>   arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  1 +
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  1 +
>   .../boot/dts/socionext/uniphier-ld11.dtsi     |  1 +
>   .../boot/dts/socionext/uniphier-ld20.dtsi     |  2 +
>   .../boot/dts/socionext/uniphier-pxs3.dtsi     |  1 +
>   arch/arm64/boot/dts/synaptics/berlin4ct.dtsi  |  1 +
>   arch/arm64/boot/dts/tesla/fsd.dtsi            |  2 +
>   arch/arm64/boot/dts/ti/k3-am625.dtsi          |  1 +
>   arch/arm64/boot/dts/ti/k3-am62a7.dtsi         |  1 +
>   arch/arm64/boot/dts/ti/k3-am642.dtsi          |  1 +
>   arch/arm64/boot/dts/ti/k3-am654.dtsi          |  2 +
>   arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  1 +
>   arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  1 +
>   arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |  1 +
>   98 files changed, 299 insertions(+), 56 deletions(-)
> 
