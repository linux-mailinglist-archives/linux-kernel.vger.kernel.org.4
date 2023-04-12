Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA846DFFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDLUZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDLUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B7127;
        Wed, 12 Apr 2023 13:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AB0D6253E;
        Wed, 12 Apr 2023 20:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0ECC433EF;
        Wed, 12 Apr 2023 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331141;
        bh=MYt26nkMk28C8Dep5RjxXwR1W/oFQn7l+oHGVIFlZrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIXflFpsGkpR0OsTqPXnYJ3jEyzp4CyaUC0F17h/h2qpKogGafmajc3Efp9cCxjc7
         r9kCtDkUJRJ0QyYdQtowC8oBOHy/NAE0w0qHoIEhtg4G9AQ6sqrlkkawCR9KxaHDVI
         t8e98AOwR8ghHEKpS+a8FdJiLvvY97MlN+EjgPMPJyMuGdxY60PDQy1/N0xPtmrS7d
         SymnKgWYhW2yFVhGpzh1IxMSSFlBck5WEnY7Nm34Bqn4Ny/Nz7zEp+tGSSIZp46C09
         iUwQru+J9GFXbBvzjXPS26HXpS7ZckldhtTeg9Epu1BZN0vjlC4yAL1MEgN0W2vwPx
         pT1VYON/dk/Eg==
Date:   Wed, 12 Apr 2023 21:25:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 5/7] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
Message-ID: <20230412-cheddar-prune-5ce03ccf5581@spud>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412110900.69738-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Iciv3G30UNRrqpwP"
Content-Disposition: inline
In-Reply-To: <20230412110900.69738-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Iciv3G30UNRrqpwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 12:08:58PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> I/O Coherence Port (IOCP) provides an AXI interface for connecting
> external non-caching masters, such as DMA controllers. The accesses
> from IOCP are coherent with D-Caches and L2 Cache.
>=20
> IOCP is a specification option and is disabled on the Renesas RZ/Five
> SoC due to this reason IP blocks using DMA will fail.
>=20
> The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> block that allows dynamic adjustment of memory attributes in the runtime.
> It contains a configurable amount of PMA entries implemented as CSR
> registers to control the attributes of memory locations in interest.
> Below are the memory attributes supported:
> * Device, Non-bufferable
> * Device, bufferable
> * Memory, Non-cacheable, Non-bufferable
> * Memory, Non-cacheable, Bufferable
> * Memory, Write-back, No-allocate
> * Memory, Write-back, Read-allocate
> * Memory, Write-back, Write-allocate
> * Memory, Write-back, Read and Write-allocate
>=20
> More info about PMA (section 10.3):
> Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Da=
tasheet.pdf
>=20
> As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> software. Firstly OpenSBI configures the memory region as
> "Memory, Non-cacheable, Bufferable" and passes this region as a global
> shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> allocations happen from this region and synchronization callbacks are
> implemented to synchronize when doing DMA transactions.
>=20
> Example PMA region passes as a DT node from OpenSBI:
>     reserved-memory {
>         #address-cells =3D <2>;
>         #size-cells =3D <2>;
>         ranges;
>=20
>         pma_resv0@58000000 {
>             compatible =3D "shared-dma-pool";
>             reg =3D <0x0 0x58000000 0x0 0x08000000>;
>             no-map;
>             linux,dma-default;
>         };
>     };
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v7 -> v8
> * Dropped function pointer usage
> * Now exporting the functions for clean/inval/flush
> * Switched to using early_initcall instead of arch_initcall
> * Dropped entry for "include/cache" from MAINTAINERS
> * Dropped dependency of RISCV on AX45MP_L2_CACHE
> * Returning error in case of cache line mismatch

> * Renamed clean/inval/flush functions

I kinda screwed you with that request given Hellwig's NAK on the
function pointer based stuff. Ah well, I prefer matching the proposed
naming of the dma core to what RVI chose for the instructions.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I suppose this will need a resubmission once Arnd's stuff gets applied,
but I would like to see it have a run through the build bots etc.

Cheers,
Conor.

--Iciv3G30UNRrqpwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDcTvgAKCRB4tDGHoIJi
0jm2AP0YgQJnFST7Z3utDHv2NJyppFGo3WLAjdFhiQwZ0kuywQEAiJ7v4SpH6NxH
kzbHISM+zZS6r9HK80VLYHDzthtNOQI=
=LAzK
-----END PGP SIGNATURE-----

--Iciv3G30UNRrqpwP--
