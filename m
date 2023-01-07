Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB0661204
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 23:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjAGWWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 17:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjAGWWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 17:22:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829E1181F;
        Sat,  7 Jan 2023 14:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D2B60BCB;
        Sat,  7 Jan 2023 22:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F77C433D2;
        Sat,  7 Jan 2023 22:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673130118;
        bh=PiDekM/SMRsMOKh2h1xaaJ+LnnT+/grSKCgTvgHsl1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vb2K7A+rHO9P3ICGMHyIN5P0UCTgP0QX/GYeQnKSVy4VTkeV7vAflTFmB/ligLYeN
         InpxaSFlIkdCBtTI8TjQgxq7EbnoUHylguttF6ItTXv04spS+QF5/gjbICMZH6N0l2
         dR/QFLQNeDF9W1dGpqDHbnCwz7F1gKiKM3Xdc08zOdzl6k5Lt8hI8T9lt6Z2vqUJ0i
         tP01T1SSaswaz6li6J82FA5RyNlcmHkonOIoaD3O24jKLPOs0UZuzty13REeA8yjqG
         UTkoE0Zs283AIHSZtoZ/EUVRAZA6Yd+sg1/zuvKuSbATKTySlz7wbH8NnKNhxp8jQH
         qXOVj/FAF1VRw==
Date:   Sat, 7 Jan 2023 22:21:52 +0000
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
Message-ID: <Y7nwgEs3n8kzPq5X@spud>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
 <Y7iu0RC9jgWh7hfJ@spud>
 <fb3b34ae-e35e-4dc2-a8f4-19984a2f58a8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wPdXWhj8wEQMz5ZG"
Content-Disposition: inline
In-Reply-To: <fb3b34ae-e35e-4dc2-a8f4-19984a2f58a8@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wPdXWhj8wEQMz5ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2023 at 10:52:55PM +0100, Arnd Bergmann wrote:
> On Sat, Jan 7, 2023, at 00:29, Conor Dooley wrote:
> > On Fri, Jan 06, 2023 at 11:31:33PM +0100, Arnd Bergmann wrote:
> >> On Fri, Jan 6, 2023, at 19:55, Prabhakar wrote:
> >> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> > +struct riscv_cache_ops zicbom_cmo_ops =3D {
> >> > +	.clean_range =3D &zicbom_cmo_clean_range,
> >> > +	.inv_range =3D &zicbom_cmo_inval_range,
> >> > +	.flush_range =3D &zicbom_cmo_flush_range,
> >> > +};
> >> > +#else
> >> > +struct riscv_cache_ops zicbom_cmo_ops =3D {
> >> > +	.clean_range =3D NULL,
> >> > +	.inv_range =3D NULL,
> >> > +	.flush_range =3D NULL,
> >> > +	.riscv_dma_noncoherent_cmo_ops =3D NULL,
> >> > +};
> >> > +#endif
> >> > +EXPORT_SYMBOL(zicbom_cmo_ops);
> >>=20
> >> Same here: If the ZICBOM ISA is disabled, nothing should
> >> reference zicbom_cmo_ops.
> >
> >> Also, since ZICBOM is a standard
> >> extension, I think it makes sense to always have it enabled,
> >> at least whenever noncoherent DMA is supported, that way
> >> it can be the default that gets used in the absence of any
> >> nonstandard cache controller.
> >
> > While I think of it, this is not possible as Zicbom requires toolchain
> > support whereas the alternative methods for non-coherent DMA do not.
>=20
> Ah, I see. Would it be possible to use the same .long trick
> as in the other ones though? Something like
>=20
> #if CONFIG_AS_VERSION >=3D 23600 /* or whichever version */


>      /* proper inline asm */
> #else
>      /* .long hack */
> #endif
>=20
> That way everyone can use it, and the hack would automatically
> go away in a few years after linux requires a newer toolchain.

> Alternatively, the entire noncoherent-dma support could be
> made to depend on whichever toolchain introduced Zicbom.

Ehh, I don't think that's a great idea. It'd require far too recent a
toolchain IMO.

Ideally, in my opinion, we'd just do something like what Drew has
proposed for Zicboz, negating the need for a check at all:
https://lore.kernel.org/linux-riscv/20221027130247.31634-4-ajones@ventanami=
cro.com/

Been waiting for that to be re-spun and Palmer to accept it before doing
the same thing for Zicbom. At present we have this in the arch Kconfig:

config TOOLCHAIN_HAS_ZICBOM
	bool
	default y
	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zicbom)
	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zicbom)
	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 23800

config RISCV_ISA_ZICBOM
	bool "Zicbom extension support for non-coherent DMA operation"
	depends on TOOLCHAIN_HAS_ZICBOM

The linker version check is entirely due to the linker having issues if
it sees zicbom in the ISA string in object files.

I'd been intending to do that for Zicbom anyway, so I guess I'll just go
do it & Prabhakar can attach it to his v7..

Thanks,
Conor.


--wPdXWhj8wEQMz5ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7nwgAAKCRB4tDGHoIJi
0knOAQD/AxXaV4xpsQxTE+igjsO7v2ITKUJoibgZqFqyuxZRHwEAlQbeOIbKC6Qc
8Zq/AaT9dL2pwKITsgEjv/2IEYLx7Qo=
=ZbEQ
-----END PGP SIGNATURE-----

--wPdXWhj8wEQMz5ZG--
