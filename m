Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387C5EBE13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiI0JPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiI0JP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CDF87085
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1285B61765
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62047C4347C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664270125;
        bh=M1/4wJqCrkOQfvQemlkWLfjkMfjsvyHjywT/2LrKZJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kov5TjDPuO/mk0BhTOv32R/eR9MMAsqbGNhLlbZRAtiFhNKzHiRsgFtTRqE8gXSKt
         DzCYvqhN5ZhDZv1jlK/YjKe3vwh/HRSgPoBWCEzorzqKXE22embmfebR5WRJckoYDC
         44fBPosAa1yrWDp9UOsTyyw4FpW07vWmfp1cQ5WyW9yw3FWQforxzhFSIL3zGHyjxj
         TWrC0bAbtysD9FFLQh0t841F4uysEG9tOVYMXu5RtQalesH5eEsjk6VF8WUITY0ERS
         Ihg78UQU6ORzNxWWJLA+4XdvP2at5/2jC9QAaTOoIXfVcusluQ4fD8Uzbx0NJBeHGE
         +ELskQPQkwWCA==
Received: by mail-ot1-f54.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so5994730oth.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:15:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf2/HADoYH3FsDVSv/Q5s+l22UPMvxJtjIHG5l2G9eHILEEdl+rV
        xR+2crIF/Mn5tDT6c0rltZSSCEeHHVlROdIgUGw6YQ==
X-Google-Smtp-Source: AMsMyM4OQzOI3puAJ6TjfOL6qzmXAXkft3dUqDGCVgHoY21jy67H4xsGXoCtLOldoRkQCY2jvVLJTNiUJbcB2Irj5g0=
X-Received: by 2002:a05:6830:1650:b0:655:f763:a704 with SMTP id
 h16-20020a056830165000b00655f763a704mr11667850otr.73.1664270124410; Tue, 27
 Sep 2022 02:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org> <20220916122100.170016-8-srinivas.kandagatla@linaro.org>
In-Reply-To: <20220916122100.170016-8-srinivas.kandagatla@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Tue, 27 Sep 2022 14:45:13 +0530
X-Gmail-Original-Message-ID: <CAHLCerOfRaSbunddxodsFf+WWzSWMqJk3XWTtSJivNZ_m0vZuQ@mail.gmail.com>
Message-ID: <CAHLCerOfRaSbunddxodsFf+WWzSWMqJk3XWTtSJivNZ_m0vZuQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] nvmem: prefix all symbols with NVMEM_
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 5:51 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This unifies all NVMEM symbols. They follow one style now.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
>  arch/arm/configs/multi_v7_defconfig |  6 +++---
>  arch/arm/configs/qcom_defconfig     |  2 +-
>  arch/arm64/configs/defconfig        | 10 +++++-----
>  arch/mips/configs/ci20_defconfig    |  2 +-
>  drivers/cpufreq/Kconfig.arm         |  2 +-
>  drivers/nvmem/Kconfig               | 24 ++++++++++++------------
>  drivers/nvmem/Makefile              | 24 ++++++++++++------------
>  drivers/soc/mediatek/Kconfig        |  2 +-
>  drivers/thermal/qcom/Kconfig        |  2 +-
>  9 files changed, 37 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi=
_v7_defconfig
> index 12b35008571f..e52edcc8ec41 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1193,11 +1193,11 @@ CONFIG_TI_PIPE3=3Dy
>  CONFIG_TWL4030_USB=3Dm
>  CONFIG_RAS=3Dy
>  CONFIG_NVMEM_IMX_OCOTP=3Dy
> -CONFIG_QCOM_QFPROM=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dm
> +CONFIG_NVMEM_QCOM_QFPROM=3Dy
> +CONFIG_NVMEM_ROCKCHIP_EFUSE=3Dm
>  CONFIG_NVMEM_SUNXI_SID=3Dy
>  CONFIG_NVMEM_VF610_OCOTP=3Dy
> -CONFIG_MESON_MX_EFUSE=3Dm
> +CONFIG_NVMEM_MESON_MX_EFUSE=3Dm
>  CONFIG_NVMEM_RMEM=3Dm
>  CONFIG_FSI=3Dm
>  CONFIG_FSI_MASTER_GPIO=3Dm
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defc=
onfig
> index 8a59441701a8..fb8c03bd80d7 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -278,7 +278,7 @@ CONFIG_PHY_QCOM_QMP=3Dy
>  CONFIG_PHY_QCOM_USB_HS=3Dy
>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=3Dy
>  CONFIG_PHY_QCOM_USB_HSIC=3Dy
> -CONFIG_QCOM_QFPROM=3Dy
> +CONFIG_NVMEM_QCOM_QFPROM=3Dy
>  CONFIG_INTERCONNECT=3Dy
>  CONFIG_INTERCONNECT_QCOM=3Dy
>  CONFIG_INTERCONNECT_QCOM_MSM8974=3Dm
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d5b2d2dd4904..c6e82787cca3 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1236,12 +1236,12 @@ CONFIG_QCOM_L3_PMU=3Dy
>  CONFIG_HISI_PMU=3Dy
>  CONFIG_NVMEM_IMX_OCOTP=3Dy
>  CONFIG_NVMEM_IMX_OCOTP_SCU=3Dy
> -CONFIG_MTK_EFUSE=3Dy
> -CONFIG_QCOM_QFPROM=3Dy
> -CONFIG_ROCKCHIP_EFUSE=3Dy
> +CONFIG_NVMEM_MTK_EFUSE=3Dy
> +CONFIG_NVMEM_QCOM_QFPROM=3Dy
> +CONFIG_NVMEM_ROCKCHIP_EFUSE=3Dy
>  CONFIG_NVMEM_SUNXI_SID=3Dy
> -CONFIG_UNIPHIER_EFUSE=3Dy
> -CONFIG_MESON_EFUSE=3Dm
> +CONFIG_NVMEM_UNIPHIER_EFUSE=3Dy
> +CONFIG_NVMEM_MESON_EFUSE=3Dm
>  CONFIG_NVMEM_RMEM=3Dm
>  CONFIG_NVMEM_LAYERSCAPE_SFP=3Dm
>  CONFIG_FPGA=3Dy
> diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_de=
fconfig
> index cc69b215854e..e1b49f77414a 100644
> --- a/arch/mips/configs/ci20_defconfig
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -143,7 +143,7 @@ CONFIG_MEMORY=3Dy
>  CONFIG_JZ4780_NEMC=3Dy
>  CONFIG_PWM=3Dy
>  CONFIG_PWM_JZ4740=3Dm
> -CONFIG_JZ4780_EFUSE=3Dy
> +CONFIG_NVMEM_JZ4780_EFUSE=3Dy
>  CONFIG_JZ4770_PHY=3Dy
>  CONFIG_EXT4_FS=3Dy
>  # CONFIG_DNOTIFY is not set
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 954749afb5fe..82e5de1f6f8c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -153,7 +153,7 @@ config ARM_OMAP2PLUS_CPUFREQ
>  config ARM_QCOM_CPUFREQ_NVMEM
>         tristate "Qualcomm nvmem based CPUFreq"
>         depends on ARCH_QCOM
> -       depends on QCOM_QFPROM
> +       depends on NVMEM_QCOM_QFPROM
>         depends on QCOM_SMEM
>         select PM_OPP
>         help
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index bab8a29c9861..691375c13381 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -52,7 +52,7 @@ config NVMEM_IMX_OCOTP_SCU
>           This is a driver for the SCU On-Chip OTP Controller (OCOTP)
>           available on i.MX8 SoCs.
>
> -config JZ4780_EFUSE
> +config NVMEM_JZ4780_EFUSE
>         tristate "JZ4780 EFUSE Memory Support"
>         depends on MACH_INGENIC || COMPILE_TEST
>         depends on HAS_IOMEM
> @@ -96,7 +96,7 @@ config NVMEM_MXS_OCOTP
>           This driver can also be built as a module. If so, the module
>           will be called nvmem-mxs-ocotp.
>
> -config MTK_EFUSE
> +config NVMEM_MTK_EFUSE
>         tristate "Mediatek SoCs EFUSE support"
>         depends on ARCH_MEDIATEK || COMPILE_TEST
>         depends on HAS_IOMEM
> @@ -107,7 +107,7 @@ config MTK_EFUSE
>           This driver can also be built as a module. If so, the module
>           will be called efuse-mtk.
>
> -config MICROCHIP_OTPC
> +config NVMEM_MICROCHIP_OTPC
>         tristate "Microchip OTPC support"
>         depends on ARCH_AT91 || COMPILE_TEST
>         help
> @@ -126,7 +126,7 @@ config NVMEM_NINTENDO_OTP
>           This driver can also be built as a module. If so, the module
>           will be called nvmem-nintendo-otp.
>
> -config QCOM_QFPROM
> +config NVMEM_QCOM_QFPROM
>         tristate "QCOM QFPROM Support"
>         depends on ARCH_QCOM || COMPILE_TEST
>         depends on HAS_IOMEM
> @@ -145,7 +145,7 @@ config NVMEM_SPMI_SDAM
>           Qualcomm Technologies, Inc. PMICs. It provides the clients
>           an interface to read/write to the SDAM module's shared memory.
>
> -config ROCKCHIP_EFUSE
> +config NVMEM_ROCKCHIP_EFUSE
>         tristate "Rockchip eFuse Support"
>         depends on ARCH_ROCKCHIP || COMPILE_TEST
>         depends on HAS_IOMEM
> @@ -156,7 +156,7 @@ config ROCKCHIP_EFUSE
>           This driver can also be built as a module. If so, the module
>           will be called nvmem_rockchip_efuse.
>
> -config ROCKCHIP_OTP
> +config NVMEM_ROCKCHIP_OTP
>         tristate "Rockchip OTP controller support"
>         depends on ARCH_ROCKCHIP || COMPILE_TEST
>         depends on HAS_IOMEM
> @@ -199,7 +199,7 @@ config NVMEM_SUNXI_SID
>           This driver can also be built as a module. If so, the module
>           will be called nvmem_sunxi_sid.
>
> -config UNIPHIER_EFUSE
> +config NVMEM_UNIPHIER_EFUSE
>         tristate "UniPhier SoCs eFuse support"
>         depends on ARCH_UNIPHIER || COMPILE_TEST
>         depends on HAS_IOMEM
> @@ -221,7 +221,7 @@ config NVMEM_VF610_OCOTP
>           This driver can also be build as a module. If so, the module wi=
ll
>           be called nvmem-vf610-ocotp.
>
> -config MESON_EFUSE
> +config NVMEM_MESON_EFUSE
>         tristate "Amlogic Meson GX eFuse Support"
>         depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
>         help
> @@ -231,7 +231,7 @@ config MESON_EFUSE
>           This driver can also be built as a module. If so, the module
>           will be called nvmem_meson_efuse.
>
> -config MESON_MX_EFUSE
> +config NVMEM_MESON_MX_EFUSE
>         tristate "Amlogic Meson6/Meson8/Meson8b eFuse Support"
>         depends on ARCH_MESON || COMPILE_TEST
>         help
> @@ -251,13 +251,13 @@ config NVMEM_SNVS_LPGPR
>           This driver can also be built as a module. If so, the module
>           will be called nvmem-snvs-lpgpr.
>
> -config RAVE_SP_EEPROM
> +config NVMEM_RAVE_SP_EEPROM
>         tristate "Rave SP EEPROM Support"
>         depends on RAVE_SP_CORE
>         help
>           Say y here to enable Rave SP EEPROM support.
>
> -config SC27XX_EFUSE
> +config NVMEM_SC27XX_EFUSE
>         tristate "Spreadtrum SC27XX eFuse Support"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST
>         depends on HAS_IOMEM
> @@ -278,7 +278,7 @@ config NVMEM_ZYNQMP
>
>           If sure, say yes. If unsure, say no.
>
> -config SPRD_EFUSE
> +config NVMEM_SPRD_EFUSE
>         tristate "Spreadtrum SoC eFuse Support"
>         depends on ARCH_SPRD || COMPILE_TEST
>         depends on HAS_IOMEM
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 399f9972d45b..7ac988c6966e 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_NVMEM_IMX_OCOTP) +=3D nvmem-imx-ocotp.o
>  nvmem-imx-ocotp-y              :=3D imx-ocotp.o
>  obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)      +=3D nvmem-imx-ocotp-scu.o
>  nvmem-imx-ocotp-scu-y          :=3D imx-ocotp-scu.o
> -obj-$(CONFIG_JZ4780_EFUSE)             +=3D nvmem_jz4780_efuse.o
> +obj-$(CONFIG_NVMEM_JZ4780_EFUSE)               +=3D nvmem_jz4780_efuse.o
>  nvmem_jz4780_efuse-y           :=3D jz4780-efuse.o
>  obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)     +=3D nvmem_lpc18xx_eeprom.o
>  nvmem_lpc18xx_eeprom-y :=3D lpc18xx_eeprom.o
> @@ -25,37 +25,37 @@ obj-$(CONFIG_NVMEM_MXS_OCOTP)       +=3D nvmem-mxs-oc=
otp.o
>  nvmem-mxs-ocotp-y              :=3D mxs-ocotp.o
>  obj-$(CONFIG_NVMEM_NINTENDO_OTP)       +=3D nvmem-nintendo-otp.o
>  nvmem-nintendo-otp-y           :=3D nintendo-otp.o
> -obj-$(CONFIG_MTK_EFUSE)                +=3D nvmem_mtk-efuse.o
> +obj-$(CONFIG_NVMEM_MTK_EFUSE)          +=3D nvmem_mtk-efuse.o
>  nvmem_mtk-efuse-y              :=3D mtk-efuse.o
> -obj-$(CONFIG_QCOM_QFPROM)      +=3D nvmem_qfprom.o
> +obj-$(CONFIG_NVMEM_QCOM_QFPROM)        +=3D nvmem_qfprom.o
>  nvmem_qfprom-y                 :=3D qfprom.o
>  obj-$(CONFIG_NVMEM_SPMI_SDAM)  +=3D nvmem_qcom-spmi-sdam.o
>  nvmem_qcom-spmi-sdam-y         +=3D qcom-spmi-sdam.o
> -obj-$(CONFIG_ROCKCHIP_EFUSE)   +=3D nvmem_rockchip_efuse.o
> +obj-$(CONFIG_NVMEM_ROCKCHIP_EFUSE)     +=3D nvmem_rockchip_efuse.o
>  nvmem_rockchip_efuse-y         :=3D rockchip-efuse.o
> -obj-$(CONFIG_ROCKCHIP_OTP)     +=3D nvmem-rockchip-otp.o
> +obj-$(CONFIG_NVMEM_ROCKCHIP_OTP)       +=3D nvmem-rockchip-otp.o
>  nvmem-rockchip-otp-y           :=3D rockchip-otp.o
>  obj-$(CONFIG_NVMEM_SUNXI_SID)  +=3D nvmem_sunxi_sid.o
>  nvmem_stm32_romem-y            :=3D stm32-romem.o
>  obj-$(CONFIG_NVMEM_STM32_ROMEM) +=3D nvmem_stm32_romem.o
>  nvmem_sunxi_sid-y              :=3D sunxi_sid.o
> -obj-$(CONFIG_UNIPHIER_EFUSE)   +=3D nvmem-uniphier-efuse.o
> +obj-$(CONFIG_NVMEM_UNIPHIER_EFUSE)     +=3D nvmem-uniphier-efuse.o
>  nvmem-uniphier-efuse-y         :=3D uniphier-efuse.o
>  obj-$(CONFIG_NVMEM_VF610_OCOTP)        +=3D nvmem-vf610-ocotp.o
>  nvmem-vf610-ocotp-y            :=3D vf610-ocotp.o
> -obj-$(CONFIG_MESON_EFUSE)      +=3D nvmem_meson_efuse.o
> +obj-$(CONFIG_NVMEM_MESON_EFUSE)        +=3D nvmem_meson_efuse.o
>  nvmem_meson_efuse-y            :=3D meson-efuse.o
> -obj-$(CONFIG_MESON_MX_EFUSE)   +=3D nvmem_meson_mx_efuse.o
> +obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)     +=3D nvmem_meson_mx_efuse.o
>  nvmem_meson_mx_efuse-y         :=3D meson-mx-efuse.o
>  obj-$(CONFIG_NVMEM_SNVS_LPGPR) +=3D nvmem_snvs_lpgpr.o
>  nvmem_snvs_lpgpr-y             :=3D snvs_lpgpr.o
> -obj-$(CONFIG_RAVE_SP_EEPROM)   +=3D nvmem-rave-sp-eeprom.o
> +obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)     +=3D nvmem-rave-sp-eeprom.o
>  nvmem-rave-sp-eeprom-y         :=3D rave-sp-eeprom.o
> -obj-$(CONFIG_SC27XX_EFUSE)     +=3D nvmem-sc27xx-efuse.o
> +obj-$(CONFIG_NVMEM_SC27XX_EFUSE)       +=3D nvmem-sc27xx-efuse.o
>  nvmem-sc27xx-efuse-y           :=3D sc27xx-efuse.o
>  obj-$(CONFIG_NVMEM_ZYNQMP)     +=3D nvmem_zynqmp_nvmem.o
>  nvmem_zynqmp_nvmem-y           :=3D zynqmp_nvmem.o
> -obj-$(CONFIG_SPRD_EFUSE)       +=3D nvmem_sprd_efuse.o
> +obj-$(CONFIG_NVMEM_SPRD_EFUSE) +=3D nvmem_sprd_efuse.o
>  nvmem_sprd_efuse-y             :=3D sprd-efuse.o
>  obj-$(CONFIG_NVMEM_RMEM)       +=3D nvmem-rmem.o
>  nvmem-rmem-y                   :=3D rmem.o
> @@ -67,7 +67,7 @@ obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)     +=3D nvmem_sunplu=
s_ocotp.o
>  nvmem_sunplus_ocotp-y          :=3D sunplus-ocotp.o
>  obj-$(CONFIG_NVMEM_APPLE_EFUSES)       +=3D nvmem-apple-efuses.o
>  nvmem-apple-efuses-y           :=3D apple-efuses.o
> -obj-$(CONFIG_MICROCHIP_OTPC)   +=3D nvmem-microchip-otpc.o
> +obj-$(CONFIG_NVMEM_MICROCHIP_OTPC)     +=3D nvmem-microchip-otpc.o
>  nvmem-microchip-otpc-y         :=3D microchip-otpc.o
>  obj-$(CONFIG_NVMEM_U_BOOT_ENV) +=3D nvmem_u-boot-env.o
>  nvmem_u-boot-env-y             :=3D u-boot-env.o
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 3c3eedea35f7..9b44dc3d9dff 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -75,7 +75,7 @@ config MTK_MMSYS
>
>  config MTK_SVS
>         tristate "MediaTek Smart Voltage Scaling(SVS)"
> -       depends on MTK_EFUSE && NVMEM
> +       depends on NVMEM_MTK_EFUSE && NVMEM
>         help
>           The Smart Voltage Scaling(SVS) engine is a piece of hardware
>           which has several controllers(banks) for calculating suitable
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index bfd889422dd3..2c7f3f9a26eb 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config QCOM_TSENS
>         tristate "Qualcomm TSENS Temperature Alarm"
> -       depends on QCOM_QFPROM
> +       depends on NVMEM_QCOM_QFPROM
>         depends on ARCH_QCOM || COMPILE_TEST
>         help
>           This enables the thermal sysfs driver for the TSENS device. It =
shows
> --
> 2.25.1
>
