Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979F646BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLHJMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiLHJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:11:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836B69A89;
        Thu,  8 Dec 2022 01:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17C16B821EB;
        Thu,  8 Dec 2022 09:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA6C433D6;
        Thu,  8 Dec 2022 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670490695;
        bh=iHuw0OUgQEvUcS8yre/beDpGKlTFd86E0mXrCaCurC0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fQXRN6ze54K7P1CzZ+rbMoKLJnC+MBmPo7bbo7IjavpNWUA5Y70dhXR+tZFdf0qcK
         PdsqBFtrkNnGraXcXJLTw0E1MRR/5OkXnuNk6hkJQMNukeVFoo9yVelsIlTF6Mn3yP
         FvA3U3xJKjjhNUHGCTJKbOd3N98zBI38M4CJA1LWdHHNmBGKSWk1Zf5Q+YjiRz74fi
         TYP3ltF1BwEDbttJh3K1Ke7XLDMQFC8Cr5IuWa/5zC/aZhO94XqNlK2h9poWyhrE63
         8DeDsvL0n4xdxYUVoulW5WtTOrPp7GyYByC1ojzzMxu+Raa+cShbRMCsT4Su9JWcbF
         0OInr/pHAZlGg==
Date:   Thu, 08 Dec 2022 10:09:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
CC:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_12/12=5D_riscv=3A_defconfig=3A_En?= =?US-ASCII?Q?able_the_Allwinner_D1_platform_and_drivers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221208090237.20572-13-samuel@sholland.org>
References: <20221208090237.20572-1-samuel@sholland.org> <20221208090237.20572-13-samuel@sholland.org>
Message-ID: <6D22D85D-EAD2-4778-89EF-86540EDCBD2D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 December 2022 10:02:37 GMT+01:00, Samuel Holland <samuel@sholland=2Eo=
rg> wrote:
>Now that several D1-based boards are supported, enable the platform in
>our defconfig=2E Build in the drivers which are necessary to boot, such a=
s
>the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
>and watchdog (which may be left enabled by the bootloader)=2E Other commo=
n
>onboard peripherals are enabled as modules=2E
>
>Acked-by: Palmer Dabbelt <palmer@rivosinc=2Ecom>

I'm more than happy if he's happy ;)

Acked-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>

>Reviewed-by: Guo Ren <guoren@kernel=2Eorg>
>Signed-off-by: Samuel Holland <samuel@sholland=2Eorg>
>---
>
>(no changes since v1)
>
> arch/riscv/configs/defconfig | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)
>
>diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>index 74ed7037314f=2E=2E368175560da9 100644
>--- a/arch/riscv/configs/defconfig
>+++ b/arch/riscv/configs/defconfig
>@@ -25,6 +25,7 @@ CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_EXPERT=3Dy
> # CONFIG_SYSFS_SYSCALL is not set
> CONFIG_PROFILING=3Dy
>+CONFIG_ARCH_SUNXI=3Dy
> CONFIG_SOC_MICROCHIP_POLARFIRE=3Dy
> CONFIG_SOC_SIFIVE=3Dy
> CONFIG_SOC_STARFIVE=3Dy
>@@ -119,8 +120,10 @@ CONFIG_VIRTIO_NET=3Dy
> CONFIG_MACB=3Dy
> CONFIG_E1000E=3Dy
> CONFIG_R8169=3Dy
>+CONFIG_STMMAC_ETH=3Dm
> CONFIG_MICROSEMI_PHY=3Dy
> CONFIG_INPUT_MOUSEDEV=3Dy
>+CONFIG_KEYBOARD_SUN4I_LRADC=3Dm
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_DW=3Dy
>@@ -128,14 +131,20 @@ CONFIG_SERIAL_OF_PLATFORM=3Dy
> CONFIG_VIRTIO_CONSOLE=3Dy
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_VIRTIO=3Dy
>+CONFIG_I2C_MV64XXX=3Dm
> CONFIG_SPI=3Dy
> CONFIG_SPI_SIFIVE=3Dy
>+CONFIG_SPI_SUN6I=3Dy
> # CONFIG_PTP_1588_CLOCK is not set
>-CONFIG_GPIOLIB=3Dy
> CONFIG_GPIO_SIFIVE=3Dy
>+CONFIG_WATCHDOG=3Dy
>+CONFIG_SUNXI_WATCHDOG=3Dy
>+CONFIG_REGULATOR=3Dy
>+CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> CONFIG_DRM=3Dm
> CONFIG_DRM_RADEON=3Dm
> CONFIG_DRM_NOUVEAU=3Dm
>+CONFIG_DRM_SUN4I=3Dm
> CONFIG_DRM_VIRTIO_GPU=3Dm
> CONFIG_FB=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>@@ -148,19 +157,30 @@ CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> CONFIG_USB_STORAGE=3Dy
> CONFIG_USB_UAS=3Dy
>+CONFIG_USB_MUSB_HDRC=3Dm
>+CONFIG_USB_MUSB_SUNXI=3Dm
>+CONFIG_NOP_USB_XCEIV=3Dm
> CONFIG_MMC=3Dy
> CONFIG_MMC_SDHCI=3Dy
> CONFIG_MMC_SDHCI_PLTFM=3Dy
> CONFIG_MMC_SDHCI_CADENCE=3Dy
> CONFIG_MMC_SPI=3Dy
>+CONFIG_MMC_SUNXI=3Dy
> CONFIG_RTC_CLASS=3Dy
>+CONFIG_RTC_DRV_SUN6I=3Dy
>+CONFIG_DMADEVICES=3Dy
>+CONFIG_DMA_SUN6I=3Dm
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_BALLOON=3Dy
> CONFIG_VIRTIO_INPUT=3Dy
> CONFIG_VIRTIO_MMIO=3Dy
>+CONFIG_SUN8I_DE2_CCU=3Dm
>+CONFIG_SUN50I_IOMMU=3Dy
> CONFIG_RPMSG_CHAR=3Dy
> CONFIG_RPMSG_CTRL=3Dy
> CONFIG_RPMSG_VIRTIO=3Dy
>+CONFIG_PHY_SUN4I_USB=3Dm
>+CONFIG_NVMEM_SUNXI_SID=3Dy
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
