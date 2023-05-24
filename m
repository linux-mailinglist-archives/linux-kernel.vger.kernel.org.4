Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0070F407
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjEXKVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjEXKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:21:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07D0E47;
        Wed, 24 May 2023 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684923618; x=1716459618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/2s4Qnb05K6PsfiTfS/96AXNQs6QvNaT5gb/FneMc1g=;
  b=w7HHlCD6iTmFpk8AsAAQAWAYxNcPLZvJJkyFH0GtBLW37RSpcLmVlDYu
   doyrvxKTs60vJREL4SDlcBvUNHOeriqVJG1Xg4SpiAdUmHr+k+IuyE55x
   ckbOmzh69MMxAU0BsOxx3vHwQDVVhrK8nah+9rluemDeUfDI//ZquYDEr
   HbL5bR5S4vOHzsOuDe/RL97x7qL4LzZlpQbVTgEXE/AF4Q60APT4u+RIb
   8zqHB4coz25o4Sbr1PwE20nL1Qj/YqNA55xxkV5DZ7UBLOcIe872xIPTG
   ezkoyJmnOWtTmlIEFOVfGOATm7Fdk4iItgJRGqnKVIEzWPaZh5d4YlJBu
   g==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="asc'?scan'208";a="153681187"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 03:20:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 03:20:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 03:20:10 -0700
Date:   Wed, 24 May 2023 11:19:48 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     Torsten Duwe <duwe@lst.de>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <yanhong.wang@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Message-ID: <20230524-jittery-sway-41b578b24153@wendy>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
 <20230519-smokeless-guileless-2a71cae06509@wendy>
 <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
 <20230523-fondue-monotype-0c751a8f0c13@wendy>
 <20230523131006.46997d84@blackhole.lan>
 <20230523-saturate-axis-f46b78b7b82b@wendy>
 <38a9cb77-18b3-4daa-724b-9f2282f7d948@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dhsQSIulCPiX0eS/"
Content-Disposition: inline
In-Reply-To: <38a9cb77-18b3-4daa-724b-9f2282f7d948@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dhsQSIulCPiX0eS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 05:00:02PM +0800, Xingyu Wu wrote:
> On 2023/5/23 19:28, Conor Dooley wrote:
> > On Tue, May 23, 2023 at 01:10:06PM +0200, Torsten Duwe wrote:
> >> On Tue, 23 May 2023 09:28:39 +0100
> >> Conor Dooley <conor.dooley@microchip.com> wrote:
> >>=20
> >> > On Tue, May 23, 2023 at 10:56:43AM +0800, Xingyu Wu wrote:
> >> > > On 2023/5/19 22:16, Conor Dooley wrote:
> >> > > > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
> >> > > >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> >> > > >> [...]
> >>=20
> >> > > >> > +/* PLL clocks */
> >> > > >> > +#define JH7110_CLK_PLL0_OUT			0
> >> > > >> > +#define JH7110_CLK_PLL1_OUT			1
> >> > > >> > +#define JH7110_CLK_PLL2_OUT			2
> >> > > >>=20
> >> > > >> In U-Boot commit 58c9c60b Yanhong Wang added:
> >> > > >>=20
> >> > > >> +
> >> > > >> +#define JH7110_SYSCLK_PLL0_OUT                       190
> >> > > >> +#define JH7110_SYSCLK_PLL1_OUT                       191
> >> > > >> +#define JH7110_SYSCLK_PLL2_OUT                       192
> >> > > >> +
> >> > > >> +#define JH7110_SYSCLK_END                    193
> >> [...]
> >> > > > Ohh, that's not good.. If you pass the U-Boot dtb to Linux it
> >> > > > won't understand the numbering. The headers are part of the
> >> > > > dt-binding :/
> >>=20
> >> In fact, the clock index >=3D 190 makes linux hang on boot, waiting wi=
th
> >> EPROBE_DEFER for every device's clock, because the sysclk driver errors
> >> out with EINVAL (jh7110_sysclk_get()).
> >=20
> > Yup, that's about what I expected to happen.
> >=20
> >> > > Because PLL driver is separated from SYSCRG drivers in Linux, the
> >> > > numbering starts from 0. But in Uboot, the PLL driver is included
> >> > > in the SYSCRG driver, and the number follows the SYSCRG.
> >> >=20
> >> > Unfortunately, how you choose to construct your drivers has nothing =
to
> >> > do with this.
> >> > These defines/numbers appear in the dts and are part of the DT ABI.
> >> > The same dts is supposed to work for Linux & U-Boot.
> >>=20
> >> The JH7110 has 6 blocks of 64k iomem in that functional area:
> >> {SYS,STG,AON} x {CRG,SYSCON}. None of these has 190 clocks.
> >> The good news: the current DTS, as proposed here and in U-Boot master,
> >> provides nodes for all 6 entities. The bad news is that the clock
> >> assignments to those nodes and their numbering is messed up.
> >>=20
> >> AFAICT PLL{0,1,2} _are_ generated in SYS_SYSCON and thus U-Boot gets it
> >> wrong, in addition to the erroneous DTS.
> >=20
> > The numbers are kinda hocus-pocus anyway, they are just made up since t=
he
> > clock numbering usually isn't something with a nice TRM to go and
> > reference (unlike interrupts which usually are documented in that way).
> > It is very helpful to make them aligned some register/bit positions or,
> > but that is not required.
> > IOW U-Boot is not wrong per se to use 190 instead of 0, but it is wrong
> > to have different numbers in both places.
> >=20
> > It sounds like you're saying that (and I have not looked) the U-Boot dts
> > actually has structural difference w.r.t. what provides which clock?
> > If so, that'll need to be fixed independently of the numbering problem.
> >=20
> > Otherwise Xingyu & Yanhong should coordinate on which is the "correct"
> > way of doing things & do it in both places.
> >=20
>=20
> Oh, unfortunately, the 7110 can not support to mix the uboot dtb and linu=
x dtb up.

What does "cannot support" mean? It's normal and desirable for the same
dtb to be usable for both. The Linux kernel's dt-bindings are used for
multiple projects, not just Linux - it'd be silly for U-Boot, FreeBSD
etc etc to go off and each have their open set of (incompatible) bindings.

> If boot the Linux and should use the linux dtb instead of the uboot dtb.
> Because all clock ids and reset ids in Linux and Uboot are different incl=
ude
> PLL, and some modules can work in Linux but not in uboot.

What do you mean by "modules"? It is fine for either Linux or U-Boot to
not have drivers for particular peripherals - for example, there might
be no driver for your camera related bits in U-Boot, or for controlling
DRAM in Linux.

The description of the hardware should not change though, as the
hardware has not.

> I suggest to boot Linux with its own linux dtb.

I suggest to make sure that you can use the same dtb for both.

Thanks,
Conor.

--dhsQSIulCPiX0eS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG3kxAAKCRB4tDGHoIJi
0vx/AP4uwgyX8CyzdTKAP0tSNceXaoGQKaorE8a0F6KPCW4ZHAD+OmvcSLXrIWYy
MRDjVuoYxhZp+69Z/pvAj2zHmgWBkQo=
=y/ba
-----END PGP SIGNATURE-----

--dhsQSIulCPiX0eS/--
