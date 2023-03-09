Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2D6B1FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCIJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCIJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:15:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9F769DF;
        Thu,  9 Mar 2023 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678353318; x=1709889318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2T70OKG7KgIEMwaSO0d7AReWE5H9q7hJM3GfzyRu8mY=;
  b=icJ7HdNRZE1wAF+mvOFyRI0ykgz8ikJHn0uc5BedtLwmI82UW/PdTo1E
   cuc3hx9eyFqNookEgiJP6esbu4q270jjAo668NnlGz0e2CyQpYPovlawl
   iu7disYXb0cyU72B8+RIJha6HQlAg5b/RbrwejnIRYCNDrobU4AjJu/F2
   YtGpomjwVOfnYEfpFNM12KxWkqkbjaRM6UU6anMpjc178O2nzWSoCPMmw
   FHamj0BUYKKv6WKS3NReqwvCIy2gEsKIImFQJS1RJPLZq4CzYLf8aT0Uf
   FnpXFIGDMBs5XapAvWu8OyT5hpbsIMQm+eqzXsdVjzXpTjTlCUJcffQHO
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,245,1673938800"; 
   d="asc'?scan'208";a="203992667"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2023 02:15:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Mar 2023 02:15:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 9 Mar 2023 02:15:15 -0700
Date:   Thu, 9 Mar 2023 09:14:46 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Conor Dooley <conor@kernel.org>, <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <frowand.list@gmail.com>,
        <robh+dt@kernel.org>, <mick@ics.forth.gr>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <Valentina.FernandezAlanis@microchip.com>,
        <Daire.McNamara@microchip.com>
Subject: Re: RISC-V reserved memory problems
Message-ID: <3ffac9cc-ffb2-4e16-ad18-ff1ed4b6289f@spud>
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com>
 <Y9wytv5KSt1ca+td@spud>
 <ZAchb/DfbIh+qaE4@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="McODTL91jRNtt7ou"
Content-Disposition: inline
In-Reply-To: <ZAchb/DfbIh+qaE4@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--McODTL91jRNtt7ou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 01:35:11PM +0200, Mike Rapoport wrote:
> Hi Conor,
>=20
> Sorry for the delay, somehow this slipped between the cracks.

No worries.

> On Thu, Feb 02, 2023 at 10:01:26PM +0000, Conor Dooley wrote:
> > Hullo Palmer, Mike & whoever else may read this,
> >=20
> > Just reviving this thread from a little while ago as I have been in the
> > area again recently...
>=20
> TBH, I didn't really dig deep into the issues,

I only preserved most of the context here to point out that it wasn't an
isolated issue, the top-down/bottom-up bit is the main part that I was
interested in. The others are fixed, or workaround-able without
"harming" anyone else.

> but the thought I had was
> what if DT was mapped via fixmap until the setup_vm_final() and then it
> would be possible to call DT methods early.

=46rom my memory, this would be more along the lines of what arm64 does.
I'll give it a shot and see how it goes. I figure it'll take me some
time!

> Could be I'm shooting in the dark :)

A pointer on where to start is helpful, even if it is "rewrite a bunch
of stuff".

Cheers,
Conor.

> > On Tue, Aug 16, 2022 at 08:41:05PM +0000, Conor.Dooley@microchip.com wr=
ote:
> > > Hey all,
> > > We've run into a bit of a problem with reserved memory on PolarFire, =
or
> > > more accurately a pair of problems that seem to have opposite fixes.
> > >=20
> > > The first of these problems is triggered when trying to implement a
> > > remoteproc driver. To get the reserved memory buffer, remoteproc
> > > does an of_reserved_mem_lookup(), something like:
> > >=20
> > > 	np =3D of_parse_phandle(pdev->of_node, "memory-region", 0);
> > > 	if (!np)
> > > 		return -EINVAL;
> > >=20
> > > 	rmem =3D of_reserved_mem_lookup(np);
> > > 	if (!rmem)
> > > 		return -EINVAL;
> > >=20
> > > of_reserved_mem_lookup() then uses reserved_mem[i].name to try and fi=
nd
> > > a match - but this was triggering kernel panics for us. We did some
> > > debugging and found that the name string's pointer was pointing to an
> > > address in the 0x4000_0000 range. The minimum reproduction for this
> > > crash is attached - it hacks in some print_reserved_mem()s into
> > > setup_vm_final() around a tlb flush so you can see the before/after.
> > > (You'll need a reserved memory node in your dts to replicate)
> > >=20
> > > The output is like so, with the same crash as in the remoteproc drive=
r:
> > >=20
> > > [    0.000000] Linux version 6.0.0-rc1-00001-g0d9d6953d834 (conor@wen=
dy) (riscv64-unknown-linux-gnu-gcc (g5964b5cd727) 11.1.0, GNU ld (GNU Binut=
ils) 2.37) #1 SMP Tue Aug 16 13:42:09 IST 2022
> >=20
> > [...]
> >=20
> > > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill=
 the idle task! ]---
> > >=20
> > > We traced this back to early_init_fdt_scan_reserved_mem() in
> > > setup_bootmem() - moving it later back up the boot sequence to
> > > after the dt has been remapped etc has fixed the problem for us.
> > >=20
> > > The least movement to get it working is attached, and also pushed
> > > here: git.kernel.org/conor/c/1735589baefc
> >=20
> > This one is fixed now, as of commit 50e63dd8ed92 ("riscv: fix reserved
> > memory setup").
> >=20
> > > The second problem is a bit more complicated to explain - but we
> > > found the solution conflicted with the remoteproc fix as we had
> > > to move early_init_fdt_scan_reserved_mem() _earlier_ in the boot
> > > process to solve this one.
> > >=20
> > > We want to have a node in our devicetree that contains some memory
> > > that is non-cached & marked as reserved-memory. Maybe we have just
> > > missed something, but from what we've seen:
> > > - the really early setup looks at the dtb, picks the highest bit
> > >    of memory and puts the dtb etc there so it can start using it
> > > - early_init_fdt_scan_reserved_mem() is then called, which figures
> > >    out if memory is reserved or not.
> > >=20
> > > Unfortunately, the highest bit of memory is the non-cached bit so
> > > everything falls over, but we can avoid this by moving the call to
> > > early_init_fdt_scan_reserved_mem() above the dtb memblock alloc that
> > > takes place right before it in setup_bootmem().
> > >=20
> > > Obviously, both of these changes are moving the function call in
> > > opposite directions and we can only really do one of them. We are not
> > > sure if what we are doing with the non-cached reserved-memory section
> > > is just not permitted & cannot work - or if this is something that
> > > was overlooked for RISC-V specifically and works for other archs.
> >=20
> > We ended up working around this one by making sure that U-Boot loaded
> > the dtb to somewhere that would be inside the kernel's memory map, thus
> > avoiding the remapping in the first place.
> >=20
> > We did run into another problem recently though, and 50e63dd8ed92 is
> > kinda at fault for it.
> > This particular issue was encountered with a devicetree where the
> > top-most memory region was entirely reserved & was not observed prior
> > to my fix for the first issue.
> >=20
> > On RISC-V, the boot sequence is something like:
> > 	setup_bootmem();
> > 	setup_vm_final();
> > 	unflatten_device_tree();
> > 	early_init_fdt_scan_reserved_mem();
> >=20
> > Whereas, before my patch it used to be (give-or-take):
> > 	setup_bootmem();
> > 	early_init_fdt_scan_reserved_mem();
> > 	setup_vm_final();
> > 	unflatten_device_tree();
> >=20
> > The difference being that we used to have scanned the reserved memory
> > regions before calling setup_vm_final() & therefore know which regions
> > we cannot use. As a reminder, calling early_init_fdt_scan_reserved_mem()
> > before we've got the dt in a proper virtual memory address will cause
> > the kernel to panic if it tries to read a reserved memory node's label.
> >=20
> > As we are now calling setup_vm_final() *before* we know what the
> > reserved memory regions are & as RISC-V allocates memblocks from the top
> > down, the allocations in setup_vm_final() will be done in the highest
> > memory region.
> > When early_init_fdt_scan_reserved_mem() then tries to reserve the
> > entirety of that top-most memory region, the reservation fails as part
> > of this region has already been allocated.
> > In the scenario where I found this bug, that top-most region is non-
> > cached memory & the kernel ends up panicking.
> > The memblock debug code made this pretty easy to spot, otherwise I'd
> > probably have spent more than just a few hours trying to figure out why
> > it was panicking!
> >=20
> > My "this needs to be fixed today" solution for this problem was calling
> > memblock_set_bottom_up(true) in setup_bootmem() & that's what we are
> > going to carry downstream for now.
> >=20
> > I haven't tested it (yet) but I suspect that it would also fix our
> > problem of the dtb being remapped into a non-cached region of memory
> > that we would later go on to reserve too. Non-cached being an issue
> > mainly due to the panicking, but failing to reserve (and using!) memory
> > regions that are meant to be reserved is very far from ideal even when
> > they are memory that the kernel can actually use.
> >=20
> > I have no idea if that is an acceptable solution for upstream though, so
> > I guess this is me putting out feelers as to whether this is something I
> > should send a patch to do *OR* if this is another sign of the issues
> > that you (Mike, Palmer) mentioned in the past.
> > If it isn't an acceptable solution, I'm not really too sure how to
> > proceed!
> >=20
> > Cheers,
> > Conor.
> >=20
>=20
>=20
>=20
> --=20
> Sincerely yours,
> Mike.
>=20

--McODTL91jRNtt7ou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAmjfAAKCRB4tDGHoIJi
0tFdAQDHopmrSHySTTwn2q2HqhgTs5Nkor5VHzHgmHIgT+UsqAEA9GT6SanTju8R
HcLHCyzJA2EVc9QwCQU6dC9CLwSYJQw=
=F8lV
-----END PGP SIGNATURE-----

--McODTL91jRNtt7ou--
