Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F165D5E5EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiIVJgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIVJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:36:19 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD378BCD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:36:17 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 237324000A;
        Thu, 22 Sep 2022 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663839376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3UZbUFLMgSY77Odqcq2d806tX5yHgFe2O1KsF+0D9E8=;
        b=m0WkdLUM8KvCsVpgsSZlDTQXT1zLGABp4WPf/YdvMmR/eeHsKkBj5cIQLRPeQS0fml+9rK
        XdDWQb2yZGWSV0+BqMdCuNc5JQlZenWVw2PAOfdKF/mIllYOG2OaeDhqwBkJILuPEwi7W7
        6HXIYBbg0TyUYSl/YV2XWgNLfSivL+bRNpGZzNfKyAyzcOF8//vn95hMIWy09EvONl3tww
        9z/3ikC4Gd2IzYQVVkcM2ABX2lrIcgQ5vfF3g7NSUSYD6sIjFdT9pGsjrfVCotSobDN2M7
        oqX2kqGyj+Yj6JKj1Jd9TsH6OKF/8fzsY/y8ilppCY5vvXPIm3dmuBUnignObw==
Date:   Thu, 22 Sep 2022 11:36:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Valentin Korenblit <vkorenblit@sequans.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Message-ID: <20220922113613.4d7273c8@xps-13>
In-Reply-To: <6b5a2b19-39c6-5116-60c2-d292ae2e7bae@sequans.com>
References: <202209210641.MziHAbW7-lkp@intel.com>
        <20220921104002.226ff3f6@xps-13>
        <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
        <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
        <20220921164720.6bbc56d5@xps-13>
        <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
        <20220921183807.241e2518@xps-13>
        <b7e5ebb4-0de8-4958-9bc4-fe06ec4c3635@www.fastmail.com>
        <6b5a2b19-39c6-5116-60c2-d292ae2e7bae@sequans.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

vkorenblit@sequans.com wrote on Thu, 22 Sep 2022 10:18:46 +0200:

> Hi Arnd, Miquel,
>=20
> On 9/21/22 22:01, Arnd Bergmann wrote:
> > On Wed, Sep 21, 2022, at 6:38 PM, Miquel Raynal wrote: =20
> >> arnd@arndb.de  wrote on Wed, 21 Sep 2022 17:49:11 +0200: =20
> >>> On Wed, Sep 21, 2022, at 4:47 PM, Miquel Raynal wrote:
> >>> - every architecture should provide readsq()/readsl()/readsw()/readsb=
()
> >>>    these days, regardless of CONFIG_GENERIC_IOMAP. If x86 does
> >>>    not have that, we should fix asm-generic/io.h. =20
> >> ARM does not seem to define readsq/writesq. Should it be fixed? =20
> > 64-bit Arm should get it from include/asm-generic/io.h. If it does
> > not, this should be fixed. 32-bit Arm obviously cannot define them
> > in a generic way. =20
>=20
> This is ok for 64-bit arm.
>=20
> > =20
> >>> - CONFIG_GENERIC_IOMAP just means an architecture uses the generic
> >>>    ioread32_rep() style wrapper around readsl()/insl(). On most
> >>>    architectures (not x86), insl() is implemented as a wrapper around
> >>>    readsl() itself, so readsl() and ioread32_rep() should be identica=
l. =20
> >> Ok. But if CONFIG_GENERIC_IOMAP=3Dn (ARM, aarch64, x86_64), =20
> > x86_64 has GENERIC_IOMAP=3Dy
> > =20
> >> ioread64_rep is then only defined if CONFIG_64BIT. As it is based
> >> on readsq/writesq() and those must be defined (as you said), I don't g=
et
> >> why the *64_rep() helpers are not defined in all cases. Maybe because =
no
> >> 32-bit system _should_ need them? But then compile testing gets more
> >> difficult. =20
> > Both readsq/writesq and ioread64_rep/iowrite64_rep must be defined
> > for 64-bit architectures and cannot be defined for 32-bit ones. =20
>=20
> So the first issue here is that they are not defined for x86_64
> (CONFIG_64BIT=3Dy).

I would say this is not very important as long as we could use
readsq/writesq() for the same purpose.

> >>> - For a FIFO, you cannot use readq() but have to use __raw_readq()
> >>>    to get the correct endianness. You cannot use this for an
> >>>    MMIO register with side-effects though, as this needs the byteswap
> >>>    and the barrier in readsl(). =20
> >> I'm not sure about the true definition of "FIFO" as you say. I guess
> >> you just mean reading from a BE device?
> >>
> >> In this case I guess we need the barrier+byteswap helpers. =20
> > The difference is that a register has a fixed length, and gets
> > accessed with a device specific endianness, which may have to
> > be swapped if the device and the CPU disagree.
> >
> > A FIFO register is what you use for transferring a stream of
> > bytes, such as reading a file system block from disk. The
> > first byte in the register corresponds to the first byte in
> > memory later, so there must not be any byteswap while copying
> > to/from memory. If the data itself is structured (i.e. an
> > on-disk inode or a network packet), then the byteswap will
> > happen if necessary while interpreting the data.
> > =20
> >> I don't think this is actually what we want. My understanding is
> >> (Valentin, please correct me if I'm wrong):
> >> - on ARM: we will always use 32-bit accesses
> >> - on aarch64: we may use either 32-bit or 64-bit accesses
> >> - on other architectures: we only want to compile test =20
>=20
> Correct, this was my initial idea. However, this driver should work
> with every architecture or do we limit the scope to arm/arm64/x86_64?

The driver should work on ARM and aarch64, I'm not aware of other
architectures with this IP.

The driver should compile when COMPILE_TEST=3Dy.

> >> I believe what Valentin wanted to achieve in the first place, was to
> >> use 64-bit accesses when relevant (otherwise it does not work). =20
> > The width is read from a device specific register at
> > runtime, it is not related to the architecture you are
> > running on, presumably this is hardwired during the
> > design of an SoC, based on the capabilities of the DMA
> > engine:

Well, yes, but in the mean time 64-bit DMA width will never be
used on 32-bit platforms.

> >          reg =3D readl_relaxed(cdns_ctrl->reg + CTRL_FEATURES);
> >          if (FIELD_GET(CTRL_FEATURES_DMA_DWITH64, reg))
> >                  cdns_ctrl->caps2.data_dma_width =3D 8;
> >          else
> >                  cdns_ctrl->caps2.data_dma_width =3D 4;
> >
> > This usually means the largest access that is valid for
> > reading from the FIFO, but usually smaller accesses work
> > as well, just slower. =20

Mmh, ok, that's interesting, thanks for the pointer.

But in the mean time I am only half satisfied, because we plan to do
twice more accesses than needed _just_ because of a the COMPILE_TEST
constraint.

> Thanks for all the info. I can check if consecutive smaller accesses
> trigger sdma_err interrupt. The datasheet only specifies: "if host sends =
an
> unsupported transaction to slave interface, the slave dma ignores
> this access and sets sdma_err flag in intr_status register.
>=20
> Valentin

Thanks,
Miqu=C3=A8l
