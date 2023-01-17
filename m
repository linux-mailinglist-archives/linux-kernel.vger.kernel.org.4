Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDD66E2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjAQP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAQP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:59:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9009317151
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:59:26 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HFQxRq012451;
        Tue, 17 Jan 2023 15:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=FLId3gsnu4449la05HKVYAJxsmFIEeQ4EhK9tRB6qus=;
 b=JQ6sKxEksjj0/8VTv0EdnwYZvtvLuhsLDEygmlvWCX6H609ogXtmrNago4hskpOdhPsC
 ySF3dCRK2NlfrRMClkV/JJyUD8N0216twZYKVN0yWtCfxL3K+7czoE3a9ZxZsDPEdkcj
 57WrgorhyL8hrJPxZTJ5jpM07GrDGJevPAds329cjFiX2SgMOFKo54GfPZdvD22Z14Z4
 p548HwLX9TI0qaHKuiMezh4uOAOhwLYy8trpb9GZLuvFpz501kNEmG6YNMmgMlZj54VB
 6szqec5sc35Knd0z/FF4SMlB4YqicxjbxhGDJveGAtiS5b5RPZ0tzg373HvytPsC5Asf +A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3npgdkew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:59:04 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HFwuTF018842
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:58:56 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 07:58:55 -0800
Date:   Tue, 17 Jan 2023 07:58:54 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>, <kernel@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: defconfig: Enable missing configs for
 mt8192-asurada
Message-ID: <20230117155854.GE2350793@hu-bjorande-lv.qualcomm.com>
References: <20230112151238.1930126-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112151238.1930126-1-nfraprado@collabora.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B2jU0AH4s9nhUt74sNKGhpiM6ddgn-iQ
X-Proofpoint-ORIG-GUID: B2jU0AH4s9nhUt74sNKGhpiM6ddgn-iQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_07,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=821 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170129
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:12:38AM -0500, Nícolas F. R. A. Prado wrote:
> Enable missing configs in the arm64 defconfig to get all devices probing
> on mt8192-asurada based machines.
> 
> The devices enabled are: MediaTek Bluetooth USB controller, MediaTek
> PCIe Gen3 MAC controller, MT7921E wireless adapter, Elan I2C Trackpad,
> MediaTek SPI NOR flash controller, Mediatek SPMI Controller, ChromeOS EC
> regulators, MT6315 PMIC, MediaTek Video Codec, MT8192 sound cards,
> ChromeOS EC rpmsg communication, all MT8192 clocks.
> 
> Support for DMA Restricted Pool is also enabled since it is used by the
> WiFi card on this platform.
> 
> REGULATOR_CROS_EC is enabled as builtin since it powers the MMC
> controller for the SD card, making it required for booting on some
> setups.

I presume this implies that there's no ramdisk to carry these additional
modules?

> 
> By enabling the support for all of this platform's devices on the
> defconfig we make it effortless to test the relevant hardware both by
> developers as well as CI systems like KernelCI.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  arch/arm64/configs/defconfig | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f3053e7018fe..4e806d8068f6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -196,6 +196,7 @@ CONFIG_BT_HIDP=m
>  CONFIG_BT_LEDS=y
>  # CONFIG_BT_DEBUGFS is not set
>  CONFIG_BT_HCIBTUSB=m
> +CONFIG_BT_HCIBTUSB_MTK=y
>  CONFIG_BT_HCIUART=m
>  CONFIG_BT_HCIUART_LL=y
>  CONFIG_BT_HCIUART_BCM=y
> @@ -231,6 +232,7 @@ CONFIG_PCIE_ALTERA_MSI=y
>  CONFIG_PCI_HOST_THUNDER_PEM=y
>  CONFIG_PCI_HOST_THUNDER_ECAM=y
>  CONFIG_PCIE_ROCKCHIP_HOST=m
> +CONFIG_PCIE_MEDIATEK_GEN3=m
>  CONFIG_PCIE_BRCMSTB=m
>  CONFIG_PCI_IMX6=y
>  CONFIG_PCI_LAYERSCAPE=y
> @@ -403,6 +405,7 @@ CONFIG_BRCMFMAC=m
>  CONFIG_MWIFIEX=m
>  CONFIG_MWIFIEX_SDIO=m
>  CONFIG_MWIFIEX_PCIE=m
> +CONFIG_MT7921E=m
>  CONFIG_WL18XX=m
>  CONFIG_WLCORE_SDIO=m
>  CONFIG_INPUT_EVDEV=y
> @@ -411,6 +414,7 @@ CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_SNVS_PWRKEY=m
>  CONFIG_KEYBOARD_IMX_SC_KEY=m
>  CONFIG_KEYBOARD_CROS_EC=y
> +CONFIG_MOUSE_ELAN_I2C=m
>  CONFIG_INPUT_TOUCHSCREEN=y
>  CONFIG_TOUCHSCREEN_ATMEL_MXT=m
>  CONFIG_TOUCHSCREEN_GOODIX=m
> @@ -513,6 +517,7 @@ CONFIG_SPI_FSL_DSPI=y
>  CONFIG_SPI_MESON_SPICC=m
>  CONFIG_SPI_MESON_SPIFC=m
>  CONFIG_SPI_MT65XX=y
> +CONFIG_SPI_MTK_NOR=m
>  CONFIG_SPI_ORION=y
>  CONFIG_SPI_PL022=y
>  CONFIG_SPI_ROCKCHIP=y
> @@ -528,6 +533,7 @@ CONFIG_SPI_TEGRA210_QUAD=m
>  CONFIG_SPI_TEGRA114=m
>  CONFIG_SPI_SPIDEV=m
>  CONFIG_SPMI=y
> +CONFIG_SPMI_MTK_PMIF=m
>  CONFIG_PINCTRL_MAX77620=y
>  CONFIG_PINCTRL_SINGLE=y
>  CONFIG_PINCTRL_OWL=y
> @@ -674,6 +680,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_AXP20X=y
>  CONFIG_REGULATOR_BD718XX=y
>  CONFIG_REGULATOR_BD9571MWV=y
> +CONFIG_REGULATOR_CROS_EC=y
>  CONFIG_REGULATOR_FAN53555=y
>  CONFIG_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_HI6421V530=y
> @@ -681,6 +688,7 @@ CONFIG_REGULATOR_HI655X=y
>  CONFIG_REGULATOR_MAX77620=y
>  CONFIG_REGULATOR_MAX8973=y
>  CONFIG_REGULATOR_MP8859=y
> +CONFIG_REGULATOR_MT6315=m
>  CONFIG_REGULATOR_MT6358=y
>  CONFIG_REGULATOR_MT6359=y
>  CONFIG_REGULATOR_MT6360=y
> @@ -714,6 +722,7 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
>  CONFIG_SDR_PLATFORM_DRIVERS=y
>  CONFIG_V4L_MEM2MEM_DRIVERS=y
>  CONFIG_VIDEO_MEDIATEK_JPEG=m
> +CONFIG_VIDEO_MEDIATEK_VCODEC=m
>  CONFIG_VIDEO_QCOM_CAMSS=m
>  CONFIG_VIDEO_QCOM_VENUS=m
>  CONFIG_VIDEO_RCAR_ISP=m
> @@ -827,6 +836,8 @@ CONFIG_SND_SOC_IMX_AUDMIX=m
>  CONFIG_SND_SOC_MT8183=m
>  CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m
>  CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
> +CONFIG_SND_SOC_MT8192=m
> +CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
>  CONFIG_SND_MESON_AXG_SOUND_CARD=m
>  CONFIG_SND_MESON_GX_SOUND_CARD=m
>  CONFIG_SND_SOC_QCOM=m
> @@ -1070,6 +1081,7 @@ CONFIG_VIDEO_MAX96712=m
>  CONFIG_CHROME_PLATFORMS=y
>  CONFIG_CROS_EC=y
>  CONFIG_CROS_EC_I2C=y
> +CONFIG_CROS_EC_RPMSG=m
>  CONFIG_CROS_EC_SPI=y
>  CONFIG_CROS_EC_CHARDEV=m
>  CONFIG_COMMON_CLK_RK808=y
> @@ -1092,6 +1104,18 @@ CONFIG_CLK_IMX8QXP=y
>  CONFIG_CLK_IMX8ULP=y
>  CONFIG_CLK_IMX93=y
>  CONFIG_TI_SCI_CLK=y
> +CONFIG_COMMON_CLK_MT8192_AUDSYS=y
> +CONFIG_COMMON_CLK_MT8192_CAMSYS=y
> +CONFIG_COMMON_CLK_MT8192_IMGSYS=y
> +CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
> +CONFIG_COMMON_CLK_MT8192_IPESYS=y
> +CONFIG_COMMON_CLK_MT8192_MDPSYS=y
> +CONFIG_COMMON_CLK_MT8192_MFGCFG=y
> +CONFIG_COMMON_CLK_MT8192_MMSYS=y
> +CONFIG_COMMON_CLK_MT8192_MSDC=y
> +CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
> +CONFIG_COMMON_CLK_MT8192_VDECSYS=y
> +CONFIG_COMMON_CLK_MT8192_VENCSYS=y

Are all these clock drivers needed in order to reach a ramdisk, with
working uart, where further kernel modules could be loaded?

>  CONFIG_COMMON_CLK_QCOM=y
>  CONFIG_QCOM_A53PLL=y
>  CONFIG_QCOM_CLK_APCS_MSM8916=y
> @@ -1398,6 +1422,7 @@ CONFIG_CRYPTO_DEV_HISI_SEC2=m
>  CONFIG_CRYPTO_DEV_HISI_ZIP=m
>  CONFIG_CRYPTO_DEV_HISI_HPRE=m
>  CONFIG_CRYPTO_DEV_HISI_TRNG=m
> +CONFIG_DMA_RESTRICTED_POOL=y

As this would alter the behavior of other platforms and devices, could
we please carry this in a patch of its own to aid bisection?

Thanks,
Bjorn

>  CONFIG_CMA_SIZE_MBYTES=32
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_KERNEL=y
> -- 
> 2.39.0
> 
