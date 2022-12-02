Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA8640250
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiLBIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiLBIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:36:06 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0FC3FD3;
        Fri,  2 Dec 2022 00:34:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669970069; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NgtWSF4877or8VUSFEbYKgCJE7v7r6fMA8Y2tfuOhjzTsPe16g5y84jeQrrHye30rwh8OsT72z3hPk/Z/GZ2teMCYXkm9PEPFqyTC8Ah7WuQiIcbxqJyfuAnhJYwnyzh90uisa8McLSYw/7uTBT9xre7IOtv6Qj6YNhWOEVtsNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669970069; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Bb/2sdCTtx4lJG/AtrjSyYbXRs5Y+VwRBAhs9A9oZqw=; 
        b=AGfljpSdkc1zAYxfKZnaNOi61nXu3pGYykN/gitp8IVueTgqhSCWyIqg46U6nY20sIlOK/b/nl27gyNlIh+uxLLWHPbPwbzi+Mge0HdjXIhKUlEvZ4L2SBEr7Gxxu2F3M7rMsiaxE10YkHrLC17maUbG8ZCzlKGbneKKcahIKlw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669970069;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=Bb/2sdCTtx4lJG/AtrjSyYbXRs5Y+VwRBAhs9A9oZqw=;
        b=g2Bvw/BwoXZ7egBpBTRgnc9WUdAJ+SOen8MVZHWPCWdMQk818KBieLtNwHiE6KiA
        FlyUwUjf7RukYk5RRmajMR1QKvMZnxVLacnJNQqCuasGx1Orw/C8M8e90raC9h3Wl3e
        6np07gChYH87U20q83v3SigF9yPVnIjR/BN9ZhmU=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669970067473948.4031125749295; Fri, 2 Dec 2022 00:34:27 -0800 (PST)
Message-ID: <8685fd07e7abd6ed5b0321d9d9ba3abc5a8db2fc.camel@icenowy.me>
Subject: Re: [PATCH v2 12/12] riscv: defconfig: Enable the Allwinner D1
 platform and drivers
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Guo Ren <guoren@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
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
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Date:   Fri, 02 Dec 2022 16:34:20 +0800
In-Reply-To: <CAJF2gTTOKPAqazF5w03NBzxMW7MGpoCn7vvdj=RabGrzp5WVZQ@mail.gmail.com>
References: <20221125234656.47306-1-samuel@sholland.org>
         <20221125234656.47306-13-samuel@sholland.org>
         <CAJF2gTTOKPAqazF5w03NBzxMW7MGpoCn7vvdj=RabGrzp5WVZQ@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-26=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 08:24 +0800=EF=BC=
=8CGuo Ren=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Nov 26, 2022 at 7:47 AM Samuel Holland <samuel@sholland.org>
> wrote:
> >=20
> > Now that several D1-based boards are supported, enable the platform
> > in
> > our defconfig. Build in the drivers which are necessary to boot,
> > such as
> > the pinctrl, MMC, RTC (which provides critical clocks), SPI (for
> > flash),
> > and watchdog (which may be left enabled by the bootloader). Other
> > common
> > onboard peripherals are enabled as modules.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >=20
> > (no changes since v1)
> >=20
> > =C2=A0arch/riscv/configs/defconfig | 23 ++++++++++++++++++++++-
> > =C2=A01 file changed, 22 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/riscv/configs/defconfig
> > b/arch/riscv/configs/defconfig
> > index 05fd5fcf24f9..8dfe0550c0e6 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -25,6 +25,7 @@ CONFIG_BLK_DEV_INITRD=3Dy
> > =C2=A0CONFIG_EXPERT=3Dy
> > =C2=A0# CONFIG_SYSFS_SYSCALL is not set
> > =C2=A0CONFIG_PROFILING=3Dy
> > +CONFIG_ARCH_SUNXI=3Dy
> > =C2=A0CONFIG_SOC_MICROCHIP_POLARFIRE=3Dy
> > =C2=A0CONFIG_SOC_SIFIVE=3Dy
> > =C2=A0CONFIG_SOC_STARFIVE=3Dy
> > @@ -118,22 +119,31 @@ CONFIG_VIRTIO_NET=3Dy
> > =C2=A0CONFIG_MACB=3Dy
> > =C2=A0CONFIG_E1000E=3Dy
> > =C2=A0CONFIG_R8169=3Dy
> > +CONFIG_STMMAC_ETH=3Dm
> > =C2=A0CONFIG_MICROSEMI_PHY=3Dy
> > =C2=A0CONFIG_INPUT_MOUSEDEV=3Dy
> > +CONFIG_KEYBOARD_SUN4I_LRADC=3Dm
> > =C2=A0CONFIG_SERIAL_8250=3Dy
> > =C2=A0CONFIG_SERIAL_8250_CONSOLE=3Dy
> > +CONFIG_SERIAL_8250_DW=3Dy
> > =C2=A0CONFIG_SERIAL_OF_PLATFORM=3Dy
> > =C2=A0CONFIG_VIRTIO_CONSOLE=3Dy
> > =C2=A0CONFIG_HW_RANDOM=3Dy
> > =C2=A0CONFIG_HW_RANDOM_VIRTIO=3Dy
> > +CONFIG_I2C_MV64XXX=3Dm
> > =C2=A0CONFIG_SPI=3Dy
> > =C2=A0CONFIG_SPI_SIFIVE=3Dy
> > +CONFIG_SPI_SUN6I=3Dy
> > =C2=A0# CONFIG_PTP_1588_CLOCK is not set
> > -CONFIG_GPIOLIB=3Dy
> > =C2=A0CONFIG_GPIO_SIFIVE=3Dy
> > +CONFIG_WATCHDOG=3Dy
> > +CONFIG_SUNXI_WATCHDOG=3Dy
> > +CONFIG_REGULATOR=3Dy
> > +CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> > =C2=A0CONFIG_DRM=3Dm
> > =C2=A0CONFIG_DRM_RADEON=3Dm
> > =C2=A0CONFIG_DRM_NOUVEAU=3Dm
> > +CONFIG_DRM_SUN4I=3Dm
> > =C2=A0CONFIG_DRM_VIRTIO_GPU=3Dm
> > =C2=A0CONFIG_FB=3Dy
> > =C2=A0CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> > @@ -146,19 +156,30 @@ CONFIG_USB_OHCI_HCD=3Dy
> > =C2=A0CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> > =C2=A0CONFIG_USB_STORAGE=3Dy
> > =C2=A0CONFIG_USB_UAS=3Dy
> > +CONFIG_USB_MUSB_HDRC=3Dm
> > +CONFIG_USB_MUSB_SUNXI=3Dm
> > +CONFIG_NOP_USB_XCEIV=3Dm
> > =C2=A0CONFIG_MMC=3Dy
> > =C2=A0CONFIG_MMC_SDHCI=3Dy
> > =C2=A0CONFIG_MMC_SDHCI_PLTFM=3Dy
> > =C2=A0CONFIG_MMC_SDHCI_CADENCE=3Dy
> > =C2=A0CONFIG_MMC_SPI=3Dy
> > +CONFIG_MMC_SUNXI=3Dy
> > =C2=A0CONFIG_RTC_CLASS=3Dy
> > +CONFIG_RTC_DRV_SUN6I=3Dy
> > +CONFIG_DMADEVICES=3Dy
> > +CONFIG_DMA_SUN6I=3Dm
> > =C2=A0CONFIG_VIRTIO_PCI=3Dy
> > =C2=A0CONFIG_VIRTIO_BALLOON=3Dy
> > =C2=A0CONFIG_VIRTIO_INPUT=3Dy
> > =C2=A0CONFIG_VIRTIO_MMIO=3Dy
> > +CONFIG_SUN8I_DE2_CCU=3Dm
> > +CONFIG_SUN50I_IOMMU=3Dy
> Do we need IOMMU?

It's utilized by some peripherals, e.g. the display engine.

>=20
> Others:
> Reviewed-by: Guo Ren <guoren@kernel.org>
>=20
> > =C2=A0CONFIG_RPMSG_CHAR=3Dy
> > =C2=A0CONFIG_RPMSG_CTRL=3Dy
> > =C2=A0CONFIG_RPMSG_VIRTIO=3Dy
> > +CONFIG_PHY_SUN4I_USB=3Dm
> > +CONFIG_NVMEM_SUNXI_SID=3Dy
> > =C2=A0CONFIG_EXT4_FS=3Dy
> > =C2=A0CONFIG_EXT4_FS_POSIX_ACL=3Dy
> > =C2=A0CONFIG_EXT4_FS_SECURITY=3Dy
> > --
> > 2.37.4
> >=20
>=20
>=20

