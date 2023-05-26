Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB1712687
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbjEZMXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjEZMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:23:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD6D8;
        Fri, 26 May 2023 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685103815; x=1716639815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0p4xIBGqTuIaskXSeOSjiy9vfxUe/NL9WXqetZ8YJw=;
  b=tKk6dTcW8YY3WrAIv+qjBhvhb2lFKZLGN8+CnbKuwj7vFoPq1QtFowg2
   WedgYbr1X8ChoNFIGWTAL2aArrvAeSmhvj+n4lI31JXSxFzF9RoiCfRP2
   JNoTv53Ob7qX4eVTevEa8ISEXeZgzQwiPuwgOGaZijXa3nWc/8BMF9skD
   7Ir3VmW5ggC0MaIqqTtasYLi8H55CwAIKhkfvLzgdZbIJ09wMZb+gv6mo
   iMZVm+uD/ErAptPOCNE8ZcKBwBd3gXV4dI0u88g49GKQ7cKaz2FojXq1s
   YVVYyq2kKx4/ONKu4AoDotwzn4IWgDihpYJRviV0i4wXOQ7YJux6m9ujJ
   A==;
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="asc'?scan'208";a="215611840"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2023 05:23:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 26 May 2023 05:23:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 26 May 2023 05:23:30 -0700
Date:   Fri, 26 May 2023 13:23:07 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Torsten Duwe <duwe@lst.de>
CC:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <yanhong.wang@starfivetech.com>,
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
Message-ID: <20230526-unwashed-musty-dee883f1d6a7@wendy>
References: <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
 <20230519-smokeless-guileless-2a71cae06509@wendy>
 <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
 <20230523-fondue-monotype-0c751a8f0c13@wendy>
 <20230523131006.46997d84@blackhole.lan>
 <20230523-saturate-axis-f46b78b7b82b@wendy>
 <38a9cb77-18b3-4daa-724b-9f2282f7d948@starfivetech.com>
 <20230524-jittery-sway-41b578b24153@wendy>
 <20230526093432.4682eab8@blackhole.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RTLt+oLiwQtApFlh"
Content-Disposition: inline
In-Reply-To: <20230526093432.4682eab8@blackhole.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RTLt+oLiwQtApFlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 09:34:32AM +0200, Torsten Duwe wrote:
> On Wed, 24 May 2023 11:19:48 +0100
> Conor Dooley <conor.dooley@microchip.com> wrote:
>=20
> > On Wed, May 24, 2023 at 05:00:02PM +0800, Xingyu Wu wrote:
> > > On 2023/5/23 19:28, Conor Dooley wrote:
> > > > On Tue, May 23, 2023 at 01:10:06PM +0200, Torsten Duwe wrote:
> > > >> On Tue, 23 May 2023 09:28:39 +0100
> > > >> Conor Dooley <conor.dooley@microchip.com> wrote:
> > > >>=20
> > > >> > On Tue, May 23, 2023 at 10:56:43AM +0800, Xingyu Wu wrote:
> > > >> > > On 2023/5/19 22:16, Conor Dooley wrote:
> > > >> > > > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe
> > > >> > > > wrote:
> > > >> > > >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> [...]
>=20
> > > >> > > Because PLL driver is separated from SYSCRG drivers in
> > > >> > > Linux, the numbering starts from 0. But in Uboot, the PLL
> > > >> > > driver is included in the SYSCRG driver, and the number
> > > >> > > follows the SYSCRG.
> > > >> >=20
> > > >> > Unfortunately, how you choose to construct your drivers has
> > > >> > nothing to do with this.
>=20
> Exactly. As I wrote (quote below), the PLLx frequencies are controlled
> by the I/O block SYS_SYSCON (starting there at offset 0x18), according
> to the public datasheets. All(?) other clocks are derived from those in
> the *_CRG units. That *is* the hardware to be described, in *the* (one
> and only!) DT. U-Boot, and any OS, are free to reorganise their driver
> framework around that, but the hardware description is quite clear.

The dt-binding that is in this series specifies that the pll clock
controller is a child of the syscon:
https://lore.kernel.org/linux-riscv/20230512022036.97987-1-xingyu.wu@starfi=
vetech.com/T/#Z2e.:..:20230512022036.97987-6-xingyu.wu::40starfivetech.com:=
1soc:starfive:starfive::2cjh7110-syscon.yaml

That seems correct to me & U-Boot's devicetree is not compliant.

> > > >> > These defines/numbers appear in the dts and are part of the DT
> > > >> > ABI. The same dts is supposed to work for Linux & U-Boot.
> > > >>=20
> > > >> The JH7110 has 6 blocks of 64k iomem in that functional area:
> > > >> {SYS,STG,AON} x {CRG,SYSCON}. None of these has 190 clocks.
> > > >> The good news: the current DTS, as proposed here and in U-Boot
> > > >> master, provides nodes for all 6 entities. The bad news is that
> > > >> the clock assignments to those nodes and their numbering is
> > > >> messed up.
> > > >>=20
> > > >> AFAICT PLL{0,1,2} _are_ generated in SYS_SYSCON and thus U-Boot
> > > >> gets it wrong, in addition to the erroneous DTS.
> > > >=20
> > > > The numbers are kinda hocus-pocus anyway, they are just made up
> > > > since the clock numbering usually isn't something with a nice TRM
> > > > to go and reference (unlike interrupts which usually are
> > > > documented in that way). It is very helpful to make them aligned
> > > > some register/bit positions or, but that is not required.
> > > > IOW U-Boot is not wrong per se to use 190 instead of 0, but it is
> > > > wrong to have different numbers in both places.
>=20
> U-Boot reuses the Common Clock Framework from Linux, and I'm not sure
> whether the clock IDs need to be unique in order for the appropriate
> clock to be found.

Unique within the clock controller, otherwise it is impossible to tell
the difference between <&cctrl 1> and <&cctrl 1> apart! (The same
follows even with increased #clock-cells, something must be unique).
That's besides the point of this particular issue though.

> But that would be the only restriction, if it
> applies. Even then, each driver could register a clock with its own,
> arbitrarily chosen base offset with the CCF, so each CRG unit could
> still have its own clocks enumerated starting with 0 in the DTB.
>=20
> > > > It sounds like you're saying that (and I have not looked) the
> > > > U-Boot dts actually has structural difference w.r.t. what
> > > > provides which clock? If so, that'll need to be fixed
> > > > independently of the numbering problem.
>=20
> > >=20
> > > Oh, unfortunately, the 7110 can not support to mix the uboot dtb
> > > and linux dtb up.
> >=20
> > What does "cannot support" mean? It's normal and desirable for the
>=20
> IMHO "desirable" is too weak.

Yeah, agreed. I just don't like being prescriptive about what happens in
projects that I do not maintain things for I guess.

> > same dtb to be usable for both. The Linux kernel's dt-bindings are
> > used for multiple projects, not just Linux - it'd be silly for
> > U-Boot, FreeBSD etc etc to go off and each have their open set of
> > (incompatible) bindings.
> >=20
> > > If boot the Linux and should use the linux dtb instead of the uboot
> > > dtb. Because all clock ids and reset ids in Linux and Uboot are
> > > different include PLL, and some modules can work in Linux but not
> > > in uboot.
> [...]
> >=20
> > > I suggest to boot Linux with its own linux dtb.
>=20
> This is a fragile band-aid, to be used only as a last resort. It
> creates more problems than it solves. Your DTB will then match your
> kernel, but whether it describes the actual hardware is a game of
> chance. Doesn't the VisionFive2 have an RPi connector... ?
>=20
> One of the IMO few valid use cases of adding a DTB to the kernel
> at boot is OpenWRT, when you build an OS Image for a particular piece
> of hardware you have at hand.
>=20
> > I suggest to make sure that you can use the same dtb for both.
>=20
> Interestingly enough, U-Boot already has the PLL driver in a separate
> file. I have a half-baked patch here that moves the sys_syscon DT
> matching into that file...

If you have patches that fix the devicetree & drivers in U-Boot, please
post them. I don't really care at all which set of arbitrary numbers are
chosen (as long as there is one and one only) but it looks like U-Boot's
devicetree has an incorrect description of the clock controllers.

Thanks,
Conor.

--RTLt+oLiwQtApFlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHCkqwAKCRB4tDGHoIJi
0vdkAP43YzMMBIOP4qCklag39nbgwA7LSz09sTVxhoohdmu7wQEA5hXKARvXO2uQ
B83EN/ygq00FWZGY0aFccStWog1ZRw8=
=W4DW
-----END PGP SIGNATURE-----

--RTLt+oLiwQtApFlh--
