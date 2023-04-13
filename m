Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052006E0753
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDMHGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMHGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:06:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D36146B9;
        Thu, 13 Apr 2023 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681369604; x=1712905604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hnm+qNASwOYDuG5+oouWNRN2g8HpLaKpYCGdfHgO0rk=;
  b=CMs4VdRmeSZXp/m0t3Bltpi1dAT6X/iKywPUjm84p3SRakkFhMtLy+Go
   UYOCqjXv/qTiKmuBev+84Rvdv7nvyF1HgNdlqEg5OcI/VUYLqrmdJlBma
   ePRvtKcfbhD8QuAIhc4tiGrOUm+fW7WSBB1mOzcHuzL2k1VQQWIVlX687
   8h23WtmKyr721bL8VIwpB5SCG97tAQMIIHSf3zg0FzP0EWFN2rEX1ZztM
   gZP58rnt9/4t8IUM3gwrdzD772zFKsATsyBn16c5DhApJGkJAwEUQxY1X
   xNMBVUkguRP2RcYXkt+Dvoyq+I2847dPYGe19WH4D0UKptsWgxEiJ0f2M
   A==;
X-IronPort-AV: E=Sophos;i="5.98,339,1673938800"; 
   d="asc'?scan'208";a="206289796"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 00:06:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 00:06:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 00:06:38 -0700
Date:   Thu, 13 Apr 2023 08:06:23 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
CC:     Prabhakar <prabhakar.csengg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        <linux-riscv@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 5/7] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
Message-ID: <20230413-aorta-unheated-c9bb35411fb2@wendy>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412110900.69738-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412-cheddar-prune-5ce03ccf5581@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="68CN9R7A95sqqPd1"
Content-Disposition: inline
In-Reply-To: <20230412-cheddar-prune-5ce03ccf5581@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--68CN9R7A95sqqPd1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 09:25:34PM +0100, Conor Dooley wrote:
> On Wed, Apr 12, 2023 at 12:08:58PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >=20
> > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > external non-caching masters, such as DMA controllers. The accesses
> > from IOCP are coherent with D-Caches and L2 Cache.
> >=20
> > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > SoC due to this reason IP blocks using DMA will fail.
> >=20
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PM=
A)
> > block that allows dynamic adjustment of memory attributes in the runtim=
e.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
> > Below are the memory attributes supported:
> > * Device, Non-bufferable
> > * Device, bufferable
> > * Memory, Non-cacheable, Non-bufferable
> > * Memory, Non-cacheable, Bufferable
> > * Memory, Write-back, No-allocate
> > * Memory, Write-back, Read-allocate
> > * Memory, Write-back, Write-allocate
> > * Memory, Write-back, Read and Write-allocate
> >=20
> > More info about PMA (section 10.3):
> > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-=
Datasheet.pdf
> >=20
> > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > software. Firstly OpenSBI configures the memory region as
> > "Memory, Non-cacheable, Bufferable" and passes this region as a global
> > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > allocations happen from this region and synchronization callbacks are
> > implemented to synchronize when doing DMA transactions.
> >=20
> > Example PMA region passes as a DT node from OpenSBI:
> >     reserved-memory {
> >         #address-cells =3D <2>;
> >         #size-cells =3D <2>;
> >         ranges;
> >=20
> >         pma_resv0@58000000 {
> >             compatible =3D "shared-dma-pool";
> >             reg =3D <0x0 0x58000000 0x0 0x08000000>;
> >             no-map;
> >             linux,dma-default;
> >         };
> >     };
> >=20
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v7 -> v8
> > * Dropped function pointer usage
> > * Now exporting the functions for clean/inval/flush
> > * Switched to using early_initcall instead of arch_initcall
> > * Dropped entry for "include/cache" from MAINTAINERS
> > * Dropped dependency of RISCV on AX45MP_L2_CACHE
> > * Returning error in case of cache line mismatch
>=20
> > * Renamed clean/inval/flush functions
>=20
> I kinda screwed you with that request given Hellwig's NAK on the
> function pointer based stuff. Ah well, I prefer matching the proposed
> naming of the dma core to what RVI chose for the instructions.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I suppose this will need a resubmission once Arnd's stuff gets applied,
> but I would like to see it have a run through the build bots etc.

So apparently my build bot did actually run against this series?
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D739109

To be quite honest, I am not sure at all how it managed to apply the
series w/ Arnd's pre-reqs. Perhaps it has achieved some from of
sentience. There's a build failure for 32-bit that appeared on the final
patch, but is not really its fault:
=2E./arch/riscv/mm/dma-noncoherent.c: Assembler messages:
=2E./arch/riscv/mm/dma-noncoherent.c:104: Error: unrecognized opcode `sd s0=
,0(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:105: Error: unrecognized opcode `sd ra=
,8(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:110: Error: unrecognized opcode `ld ra=
,8(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:111: Error: unrecognized opcode `ld s0=
,0(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:111: Error: unrecognized opcode `sd s0=
,0(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:112: Error: unrecognized opcode `sd ra=
,8(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:117: Error: unrecognized opcode `ld ra=
,8(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:118: Error: unrecognized opcode `ld s0=
,0(sp)'
=2E./arch/riscv/mm/pmem.c: Assembler messages:
=2E./arch/riscv/mm/pmem.c:98: Error: unrecognized opcode `sd s0,0(sp)'
=2E./arch/riscv/mm/pmem.c:99: Error: unrecognized opcode `sd ra,8(sp)'
=2E./arch/riscv/mm/pmem.c:104: Error: unrecognized opcode `ld ra,8(sp)'
=2E./arch/riscv/mm/pmem.c:105: Error: unrecognized opcode `ld s0,0(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:138: Error: unrecognized opcode `sd s0=
,0(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:139: Error: unrecognized opcode `sd ra=
,8(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:144: Error: unrecognized opcode `ld ra=
,8(sp)'
=2E./arch/riscv/mm/dma-noncoherent.c:145: Error: unrecognized opcode `ld s0=
,0(sp)'
=2E./arch/riscv/mm/pmem.c:104: Error: unrecognized opcode `sd s0,0(sp)'
=2E./arch/riscv/mm/pmem.c:105: Error: unrecognized opcode `sd ra,8(sp)'
=2E./arch/riscv/mm/pmem.c:110: Error: unrecognized opcode `ld ra,8(sp)'
=2E./arch/riscv/mm/pmem.c:111: Error: unrecognized opcode `ld s0,0(sp)'
=2E./arch/riscv/mm/pmem.c:110: Error: attempt to move .org backwards
=2E./arch/riscv/mm/pmem.c:116: Error: attempt to move .org backwards
=2E./arch/riscv/mm/dma-noncoherent.c:116: Error: attempt to move .org backw=
ards
=2E./arch/riscv/mm/dma-noncoherent.c:123: Error: attempt to move .org backw=
ards
=2E./arch/riscv/mm/dma-noncoherent.c:150: Error: attempt to move .org backw=
ards
make[4]: *** [../scripts/Makefile.build:252: arch/riscv/mm/pmem.o] Error 1
make[4]: *** [../scripts/Makefile.build:252: arch/riscv/mm/dma-noncoherent.=
o] Error 1
make[4]: Target 'arch/riscv/mm/' not remade because of errors.
make[3]: *** [../scripts/Makefile.build:494: arch/riscv/mm] Error 2
make[3]: Target 'arch/riscv/' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:494: arch/riscv] Error 2

The simplest solution may to just be making the erratum depend on 64BIT?

Cheers,
Conor.


--68CN9R7A95sqqPd1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDep4wAKCRB4tDGHoIJi
0qzwAQCB//mAhLekJ/xXPUikaPY7lpNzWjR54lGI6mPu5J5JBwD/c3JyhxdH2BFo
n1Ax2ohRvR94ujh/Sjv4bRM0v8qTtAg=
=ymq9
-----END PGP SIGNATURE-----

--68CN9R7A95sqqPd1--
