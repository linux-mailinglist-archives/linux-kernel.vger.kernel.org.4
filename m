Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA76616BF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjAHQh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjAHQhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:37:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613EE02B;
        Sun,  8 Jan 2023 08:37:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A0660CF0;
        Sun,  8 Jan 2023 16:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE04C433D2;
        Sun,  8 Jan 2023 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673195872;
        bh=fO7WILHy96bpYmLsV6EJE8l8P4rzMoGtSglPfFWyyZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkpmXJUec77Ct4qyTRMxHlDFF912yQ8lHfjCoQghpfy7WP4XnsBdrZrB0LOdBzNNU
         iKiQ9UuSLIyorj5ft5hlChk7sLsSPxjkA+h7lLTLMq3yeMgoeti5TTJNj4rdnahJub
         lChKxbRMuP1jzVHieuv5QYRi8U10UL+ss760XU7g04Icrhgf68nZl/wm9w7SEkLVxc
         Yh3l7CdSAceHD6MW3JafVfEnktt+8t2lR2kgAihYVrmFWscIVulDhGPRHETZLhItEE
         4E7OXFAkXBu4heTWKLybIRU4sk7yFS7hKMWHAW3jThmCklimFULQThZ9MhjWXqY9Dm
         R3pLWgiTGQF0g==
Date:   Sun, 8 Jan 2023 16:37:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using
 function pointers for cache management
Message-ID: <Y7rxWau/WrRmjaDX@spud>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
 <Y7iu0RC9jgWh7hfJ@spud>
 <fb3b34ae-e35e-4dc2-a8f4-19984a2f58a8@app.fastmail.com>
 <Y7nwgEs3n8kzPq5X@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Uo+3eNsq3cPFx1XC"
Content-Disposition: inline
In-Reply-To: <Y7nwgEs3n8kzPq5X@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uo+3eNsq3cPFx1XC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2023 at 10:21:52PM +0000, Conor Dooley wrote:
> On Sat, Jan 07, 2023 at 10:52:55PM +0100, Arnd Bergmann wrote:
> > On Sat, Jan 7, 2023, at 00:29, Conor Dooley wrote:
> > > On Fri, Jan 06, 2023 at 11:31:33PM +0100, Arnd Bergmann wrote:
> > >> On Fri, Jan 6, 2023, at 19:55, Prabhakar wrote:
> > >> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >> > +struct riscv_cache_ops zicbom_cmo_ops =3D {
> > >> > +	.clean_range =3D &zicbom_cmo_clean_range,
> > >> > +	.inv_range =3D &zicbom_cmo_inval_range,
> > >> > +	.flush_range =3D &zicbom_cmo_flush_range,
> > >> > +};
> > >> > +#else
> > >> > +struct riscv_cache_ops zicbom_cmo_ops =3D {
> > >> > +	.clean_range =3D NULL,
> > >> > +	.inv_range =3D NULL,
> > >> > +	.flush_range =3D NULL,
> > >> > +	.riscv_dma_noncoherent_cmo_ops =3D NULL,
> > >> > +};
> > >> > +#endif
> > >> > +EXPORT_SYMBOL(zicbom_cmo_ops);
> > >>=20
> > >> Same here: If the ZICBOM ISA is disabled, nothing should
> > >> reference zicbom_cmo_ops.
> > >
> > >> Also, since ZICBOM is a standard
> > >> extension, I think it makes sense to always have it enabled,
> > >> at least whenever noncoherent DMA is supported, that way
> > >> it can be the default that gets used in the absence of any
> > >> nonstandard cache controller.
> > >
> > > While I think of it, this is not possible as Zicbom requires toolchain
> > > support whereas the alternative methods for non-coherent DMA do not.
> >=20
> > Ah, I see. Would it be possible to use the same .long trick
> > as in the other ones though? Something like
> >=20
> > #if CONFIG_AS_VERSION >=3D 23600 /* or whichever version */
>=20
>=20
> >      /* proper inline asm */
> > #else
> >      /* .long hack */
> > #endif
> >=20
> > That way everyone can use it, and the hack would automatically
> > go away in a few years after linux requires a newer toolchain.
>=20
> > Alternatively, the entire noncoherent-dma support could be
> > made to depend on whichever toolchain introduced Zicbom.
>=20
> Ehh, I don't think that's a great idea. It'd require far too recent a
> toolchain IMO.
>=20
> Ideally, in my opinion, we'd just do something like what Drew has
> proposed for Zicboz, negating the need for a check at all:
> https://lore.kernel.org/linux-riscv/20221027130247.31634-4-ajones@ventana=
micro.com/
>=20
> Been waiting for that to be re-spun and Palmer to accept it before doing
> the same thing for Zicbom. At present we have this in the arch Kconfig:
>=20
> config TOOLCHAIN_HAS_ZICBOM
> 	bool
> 	default y
> 	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zicbom)
> 	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zicbom)
> 	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23800
>=20
> config RISCV_ISA_ZICBOM
> 	bool "Zicbom extension support for non-coherent DMA operation"
> 	depends on TOOLCHAIN_HAS_ZICBOM
>=20
> The linker version check is entirely due to the linker having issues if
> it sees zicbom in the ISA string in object files.
>=20
> I'd been intending to do that for Zicbom anyway, so I guess I'll just go
> do it & Prabhakar can attach it to his v7..

Should pop up here in a few minutes..
https://lore.kernel.org/linux-riscv/20230108163356.3063839-1-conor@kernel.o=
rg/

Hopefully that both works & makes life easier. Certainly from a CI
coverage point of view, relaxing toolchain requirements makes *my* life
easier!


--Uo+3eNsq3cPFx1XC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7rxWQAKCRB4tDGHoIJi
0ryGAQCWKOi3NHzJDMDfxuTDnh3ne6XEYr/c/TROBg8/5hibCAEA46nbu1SNDiOk
LTkEJviTUBDND7tJdI8BwpGvy0eD0Q8=
=KtoJ
-----END PGP SIGNATURE-----

--Uo+3eNsq3cPFx1XC--
