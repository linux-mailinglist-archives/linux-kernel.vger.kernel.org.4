Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE456639747
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKZQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKZQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:40:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E310B0;
        Sat, 26 Nov 2022 08:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E0EBB811A5;
        Sat, 26 Nov 2022 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A760C433C1;
        Sat, 26 Nov 2022 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669480819;
        bh=Pa3Y5KRHXDuBV0XzpglGLK+WqEjfFv1FPSHeySc4JiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rkef6pO16iSuVP19EeHnXTPDm7+zULE+myvXv7MwSkETBggxOvm7WCj7u9Omb/cWO
         OXxF2N1WNjgLtGdR1SKu0NXGNICULv6CxyBe7KXaZTWz/DMA+62FQ9Az3z++GVXkzM
         htieYmG+gOoVJfGeJEUPJE3yq3iE5fuT2y5eXsCom1+JPxZ9p5F1mgWIHvQi8SjMAH
         XTXqH1E/To7fAE7/CnjUmeFeLyFHYagUg13dZf9gECycYryGUTFughOswsal9gpkxt
         iww1dFJWB5jqC5FrAHu1KpjFlwukTUyqPbZxrpjW4FT0WXhYvheD9HgoQlsL4mRtvb
         4WZZPUOD0KBIg==
Date:   Sat, 26 Nov 2022 16:40:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>, palmer@dabbelt.com
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1
 platform and drivers
Message-ID: <Y4JBa52o4Yemv/uj@spud>
References: <20221125234656.47306-1-samuel@sholland.org>
 <20221125234656.47306-13-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125234656.47306-13-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:46:56PM -0600, Samuel Holland wrote:
> Now that several D1-based boards are supported, enable the platform in
> our defconfig. Build in the drivers which are necessary to boot, such as
> the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
> and watchdog (which may be left enabled by the bootloader).

All of that looks good.

> Other common
> onboard peripherals are enabled as modules.

This I am not sure about though. I'll leave that to Palmer since I'm
pretty sure it was him that said it, but I thought the plan was only
turning on stuff required to boot to a console & things that are
generally useful rather than enabling modules for everyone's "random"
drivers. Palmer?

> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> (no changes since v1)
> 
>  arch/riscv/configs/defconfig | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 05fd5fcf24f9..8dfe0550c0e6 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -25,6 +25,7 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
>  CONFIG_PROFILING=y
> +CONFIG_ARCH_SUNXI=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_STARFIVE=y
> @@ -118,22 +119,31 @@ CONFIG_VIRTIO_NET=y
>  CONFIG_MACB=y
>  CONFIG_E1000E=y
>  CONFIG_R8169=y
> +CONFIG_STMMAC_ETH=m
>  CONFIG_MICROSEMI_PHY=y
>  CONFIG_INPUT_MOUSEDEV=y
> +CONFIG_KEYBOARD_SUN4I_LRADC=m
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> +CONFIG_I2C_MV64XXX=m
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
> +CONFIG_SPI_SUN6I=y
>  # CONFIG_PTP_1588_CLOCK is not set
> -CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SIFIVE=y
> +CONFIG_WATCHDOG=y
> +CONFIG_SUNXI_WATCHDOG=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
>  CONFIG_DRM_NOUVEAU=m
> +CONFIG_DRM_SUN4I=m
>  CONFIG_DRM_VIRTIO_GPU=m
>  CONFIG_FB=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> @@ -146,19 +156,30 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_USB_MUSB_HDRC=m
> +CONFIG_USB_MUSB_SUNXI=m
> +CONFIG_NOP_USB_XCEIV=m
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_CADENCE=y
>  CONFIG_MMC_SPI=y
> +CONFIG_MMC_SUNXI=y
>  CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_SUN6I=y
> +CONFIG_DMADEVICES=y
> +CONFIG_DMA_SUN6I=m
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
>  CONFIG_VIRTIO_MMIO=y
> +CONFIG_SUN8I_DE2_CCU=m
> +CONFIG_SUN50I_IOMMU=y
>  CONFIG_RPMSG_CHAR=y
>  CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
> +CONFIG_PHY_SUN4I_USB=m
> +CONFIG_NVMEM_SUNXI_SID=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_EXT4_FS_SECURITY=y
> -- 
> 2.37.4
> 
