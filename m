Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A45660A4A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjAFX3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjAFX3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:29:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B568CD0A;
        Fri,  6 Jan 2023 15:29:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF6B61F9E;
        Fri,  6 Jan 2023 23:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDE8C433F1;
        Fri,  6 Jan 2023 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673047767;
        bh=lwfSS0TgVuKSvxQOB/bNeAFUOiWtAHKnU5ZnPUUTNEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULdwoj/gG2DPRAGGJsQ3OqOTh9Enpy6KWAhHuyXwQ9Fdu2fEwDf74kkhjpuMqXqgu
         /PkdkXEW2V6/f+KQivQFkow/YQEfq7O7bzv+pPzQHvg5dmjmn1/V9Yh8zrobOlRCpF
         thu9X2dG5ul/lcEvLObRvWedWq7GI64cgp47X8dmeoAHJFNQb98Zi84N/vy/WRe9RW
         MK9887gUerXGBByoJX4Oo1X0A3+a/KG7GQhc2WF0iMAVW0TNYCWIh7RJTCYU3BLgvg
         3YsV5ejs5uWIu6nNw80w3D9FwG+gKOghpvK9vLBiZeIKht6yUxFv1MGUitLSpLUorz
         s/t41KtAuuv2A==
Date:   Fri, 6 Jan 2023 23:29:21 +0000
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
Message-ID: <Y7iu0RC9jgWh7hfJ@spud>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OpZnInV74VOFB1Cb"
Content-Disposition: inline
In-Reply-To: <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OpZnInV74VOFB1Cb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2023 at 11:31:33PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 6, 2023, at 19:55, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +struct riscv_cache_ops zicbom_cmo_ops =3D {
> > +	.clean_range =3D &zicbom_cmo_clean_range,
> > +	.inv_range =3D &zicbom_cmo_inval_range,
> > +	.flush_range =3D &zicbom_cmo_flush_range,
> > +};
> > +#else
> > +struct riscv_cache_ops zicbom_cmo_ops =3D {
> > +	.clean_range =3D NULL,
> > +	.inv_range =3D NULL,
> > +	.flush_range =3D NULL,
> > +	.riscv_dma_noncoherent_cmo_ops =3D NULL,
> > +};
> > +#endif
> > +EXPORT_SYMBOL(zicbom_cmo_ops);
>=20
> Same here: If the ZICBOM ISA is disabled, nothing should
> reference zicbom_cmo_ops.

> Also, since ZICBOM is a standard
> extension, I think it makes sense to always have it enabled,
> at least whenever noncoherent DMA is supported, that way
> it can be the default that gets used in the absence of any
> nonstandard cache controller.

While I think of it, this is not possible as Zicbom requires toolchain
support whereas the alternative methods for non-coherent DMA do not.

Thanks,
Conor.


--OpZnInV74VOFB1Cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7iu0AAKCRB4tDGHoIJi
0lKnAPwP9GjTSF/p2NWFDVeTSbVY5BU7VIVCG30YMppNdquBvQEAtC4SemaEoAHM
I5qlKNDdbS2X3qEHRE9DcLDTqdRtMA0=
=ztwi
-----END PGP SIGNATURE-----

--OpZnInV74VOFB1Cb--
