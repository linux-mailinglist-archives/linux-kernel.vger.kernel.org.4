Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258664E205
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiLOTyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLOTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:54:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC52537E4;
        Thu, 15 Dec 2022 11:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276F761F0C;
        Thu, 15 Dec 2022 19:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECD6C433D2;
        Thu, 15 Dec 2022 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671134073;
        bh=ckwM35u8cerjGpaLFMeUOx5oE039VsBuJcmMfvvst9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5nG8iDiZZuL2LPrGytvdfukZKf6P+anpailBuQ2RRlomnbwKP+iuRcgbMAjDaSsZ
         v8H3ps4EkdRv2ZquX1bNFPrC8kaeco1orJN/B3yMplh3DxPMZ2HkNDGFARv0/Izfcj
         Vi16eeEnv9hEEqR+JxmkmSwNd/c/LmmivxUKsMfz58tumfW4VfNIpSXlTNKmzt7aek
         Cdx5IgGdeYC4LCL+D4DDrxnSUjbohaMSRunzR16AG08fp5JK9EEcixMZxdyCVH98qF
         c7QKZqBRNVW7aFNhbzk7vS/RonObdL3qV3FaR6fItN6zFcPlD+K2iNvI4nRGX/HeSv
         PkFUBafkFo9Zw==
Date:   Thu, 15 Dec 2022 19:54:19 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, palmer@dabbelt.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 6/6] soc: renesas: Add L2 cache management for RZ/Five
 SoC
Message-ID: <Y5t7a2oZ64McjSSn@dizzy>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221212115505.36770-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUCkCyLOXbQEJyc7S2F08=ftNtPcEztRN3JWJv_FPmAVw@mail.gmail.com>
 <CA+V-a8vD=SOb6gPOwdPUE=kHeqa+oo2L-rbaW8zGjvw7YyQsqg@mail.gmail.com>
 <CAMuHMdWX4Yd52=Jv8kABtn+1B1V=dC2iXVZ81gNZBWNu4hb_3w@mail.gmail.com>
 <CA+V-a8t3+zzQ4yPftsAa51rkMGHr45NhMO4_2WmZ9BGg0wuQvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6r5CB1uLC9RYX2o6"
Content-Disposition: inline
In-Reply-To: <CA+V-a8t3+zzQ4yPftsAa51rkMGHr45NhMO4_2WmZ9BGg0wuQvw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6r5CB1uLC9RYX2o6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2022 at 05:46:42PM +0000, Lad, Prabhakar wrote:
> Hi Geert,
>=20
> On Thu, Dec 15, 2022 at 11:10 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Prabhakar,
> >
> > On Thu, Dec 15, 2022 at 12:06 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, Dec 15, 2022 at 10:36 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > > > > external non-caching masters, such as DMA controllers. The access=
es
> > > > > from IOCP are coherent with D-Caches and L2 Cache.
> > > > >
> > > > > IOCP is a specification option and is disabled on the Renesas RZ/=
Five
> > > > > SoC due to this reason IP blocks using DMA will fail.
> > > > >
> > > > > The Andes AX45MP core has a Programmable Physical Memory Attribut=
es (PMA)
> > > > > block that allows dynamic adjustment of memory attributes in the =
runtime.
> > > > > It contains a configurable amount of PMA entries implemented as C=
SR
> > > > > registers to control the attributes of memory locations in intere=
st.
> > > > > Below are the memory attributes supported:
> > > > > * Device, Non-bufferable
> > > > > * Device, bufferable
> > > > > * Memory, Non-cacheable, Non-bufferable
> > > > > * Memory, Non-cacheable, Bufferable
> > > > > * Memory, Write-back, No-allocate
> > > > > * Memory, Write-back, Read-allocate
> > > > > * Memory, Write-back, Write-allocate
> > > > > * Memory, Write-back, Read and Write-allocate
> > > > >
> > > > > More info about PMA (section 10.3):
> > > > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
> > > > >
> > > > > As a workaround for SoCs with IOCP disabled CMO needs to be handl=
ed by
> > > > > software. Firstly OpenSBI configures the memory region as
> > > > > "Memory, Non-cacheable, Bufferable" and passes this region as a g=
lobal
> > > > > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > > > > allocations happen from this region and synchronization callbacks=
 are
> > > > > implemented to synchronize when doing DMA transactions.
> > > > >
> > > > > Example PMA region passes as a DT node from OpenSBI:
> > > > >     reserved-memory {
> > > > >         #address-cells =3D <2>;
> > > > >         #size-cells =3D <2>;
> > > > >         ranges;
> > > > >
> > > > >         pma_resv0@58000000 {
> > > > >             compatible =3D "shared-dma-pool";
> > > > >             reg =3D <0x0 0x58000000 0x0 0x08000000>;
> > > > >             no-map;
> > > > >             linux,dma-default;
> > > > >         };
> > > > >     };
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas=
=2Ecom>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > >  arch/riscv/include/asm/cacheflush.h       |   8 +
> > > > >  arch/riscv/include/asm/errata_list.h      |  28 ++-
> > > > >  drivers/soc/renesas/Kconfig               |   6 +
> > > > >  drivers/soc/renesas/Makefile              |   2 +
> > > > >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
> > > > >  drivers/soc/renesas/rzfive/Makefile       |   3 +
> > > > >  drivers/soc/renesas/rzfive/ax45mp_cache.c | 256 ++++++++++++++++=
++++++
> > > >
> > > > Given this touches arch/riscv/include/asm/, I don't think the
> > > > code belongs under drivers/soc/renesas/.
> > > >
> > > Ok. Do you have any suggestions on where you want me to put this code?
> >
> > As it plugs into core riscv functionality, I think it should be under
> > arch/riscv/.
> > if the RISC-V maintainers object to that, another option is
> > drivers/soc/andestech/ or (new) drivers/cache/
> >
> RISC-V maintainers had already made it clear to not to include vendor
> specific stuff in the arch/riscv folder, so I'll consider putting this
> into drivers/cache/ folder to sync with the bindings.
>=20
> Conor/Palmer - do you have any objections/suggestions?

I'm not its maintainer so sorta moot what I say, but having drivers in
arch/riscv makes little sense to me..
Putting stuff in drivers/cache does sound like a good idea since the
binding is going there too.

The SiFive ccache driver is in drivers/soc and it was suggested to me
this week that there's likely going to be a second SiFive cache driver
at some point in the near future. Plus Microchip are going to have to
add cache management stuff to the existing SiFive ccache driver.
Having them be their own thing makes sense in my mind - especially since
they're not tied to SoCs sold by Andes or SiFive.

I had a quick, and I mean *quick* look through other soc drivers to see
if there were any other cache controller drivers but nothing stood out
to me. Maybe someone else has more of a clue there. Ditto for misc, had
a look but nothing seemed obvious.

If we do do drivers/cache & move the SiFive stuff there too, someone
needs to look after it. I guess I can if noone else feels strongly
since I seem to be the Responsible Adult for the SiFive ones already?


--6r5CB1uLC9RYX2o6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5t7ZgAKCRB4tDGHoIJi
0rnuAP9U0I47Qq0z4SYHsxpLE2Y+u93t5qPUcXHSNlAx4Z7qGgD9HPx/YrpFO71+
sRuKb85le8iGHUV440lqpw1Yckpveg8=
=8usm
-----END PGP SIGNATURE-----

--6r5CB1uLC9RYX2o6--
