Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9E6B2436
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCIMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCIMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:33:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C1712873;
        Thu,  9 Mar 2023 04:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678365189; x=1709901189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/V0cEBZl4mwfLUDTheLkgp8EgxUGKm7HOLNFDHmou0=;
  b=pcq3/UA2itGdIkMkpfN/4/XGm7EVynl8O5x47UdF4MI+tsrwSGg/vo2c
   hIFFLTE2eNmhpLcwPzHJpRfbj8y5k8tzyqkWHxNyyxzZCzpUXjO8J+HZH
   1ibejZltXVUoHjdPAXaezDNdgjeFQwq53JUA+yY2riSetqy5nmMlpHJt3
   wk9einue/fB2m1DgUyI712SXODH4Pc6LZo5YP9hnAEhMUf9dgZeDVrU9a
   RrP2T8yCZ6bOwlhc8LtoCgj/6X4EJzrIjvqDXbhgH9+D5mvqUL6OKb9uJ
   dUlnIkIdvet+MgcTXqIlSBN5wuC2YQ3OJ7QvDZJWSWJRIjdooMFjiKc+O
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673938800"; 
   d="asc'?scan'208";a="215519697"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2023 05:33:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Mar 2023 05:33:07 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 9 Mar 2023 05:33:05 -0700
Date:   Thu, 9 Mar 2023 12:32:36 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <frowand.list@gmail.com>,
        <robh+dt@kernel.org>, <mick@ics.forth.gr>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Valentina.FernandezAlanis@microchip.com>,
        <Daire.McNamara@microchip.com>
Subject: Re: RISC-V reserved memory problems
Message-ID: <ababa7ca-68c6-4d1c-9179-10376999d367@spud>
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com>
 <fadac048-c648-6493-3f1c-1877692180c8@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D9AVMx1vkdavINVt"
Content-Disposition: inline
In-Reply-To: <fadac048-c648-6493-3f1c-1877692180c8@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--D9AVMx1vkdavINVt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 11:30:07AM +0100, Alexandre Ghiti wrote:
> Hi Conor,

Hey Alex!

> On 8/16/22 22:41, Conor.Dooley@microchip.com wrote:
> > Hey all,
> > We've run into a bit of a problem with reserved memory on PolarFire, or
> > more accurately a pair of problems that seem to have opposite fixes.
> >=20
> > The first of these problems is triggered when trying to implement a
> > remoteproc driver. To get the reserved memory buffer, remoteproc
> > does an of_reserved_mem_lookup(), something like:
> >=20
> > 	np =3D of_parse_phandle(pdev->of_node, "memory-region", 0);
> > 	if (!np)
> > 		return -EINVAL;
> >=20
> > 	rmem =3D of_reserved_mem_lookup(np);
> > 	if (!rmem)
> > 		return -EINVAL;
> >=20
> > of_reserved_mem_lookup() then uses reserved_mem[i].name to try and find
> > a match - but this was triggering kernel panics for us. We did some
> > debugging and found that the name string's pointer was pointing to an
> > address in the 0x4000_0000 range. The minimum reproduction for this
>=20
>=20
> 0x4000_0000 corresponds to DTB_EARLY_BASE_VA: this is the address that is
> used to map the dtb before we can access it using the linear mapping.
>=20
>=20
> > crash is attached - it hacks in some print_reserved_mem()s into
> > setup_vm_final() around a tlb flush so you can see the before/after.
> > (You'll need a reserved memory node in your dts to replicate)
> >=20
> > The output is like so, with the same crash as in the remoteproc driver:
> >=20
> > [    0.000000] Linux version 6.0.0-rc1-00001-g0d9d6953d834 (conor@wendy=
) (riscv64-unknown-linux-gnu-gcc (g5964b5cd727) 11.1.0, GNU ld (GNU Binutil=
s) 2.37) #1 SMP Tue Aug 16 13:42:09 IST 2022
> > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> > [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> > [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 (option=
s '115200n8')
> > [    0.000000] printk: bootconsole [ns16550a0] enabled
> > [    0.000000] printk: debug: skip boot console de-registration.
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] before flush
> > [    0.000000] OF: reserved mem: debug name is fabricbuf@ae000000
> > [    0.000000] after flush
> > [    0.000000] Unable to handle kernel paging request at virtual addres=
s 00000000401c31ac
>=20
>=20
> You take the trap here because the mapping for the dtb does not exist in
> swapper_pg_dir, but you don't need this mapping anymore as you can access
> the device tree through the linear mapping now.
>=20
> I would say that: you build your kernel with CONFIG_BUILTIN_DTB

I do not have any "NONPORTABLE" options selected.

> and then you
> don't call early_init_dt_verify which resets initial_boot_params to the
> linear mapping address (it was initially set to 0x4000_0000 in parse_dtb).
> If that's the case, does the following fix your issue?

I dunno, I don't hit this issue anymore as of 50e63dd8ed92 ("riscv: fix
reserved memory setup"). That might not be the right fix in the grand
scheme of things, but it solved problems that both I and others were
hitting.

> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 376d2827e736..2b09f0bd8432 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -276,6 +276,7 @@ void __init setup_arch(char **cmdline_p)
> =A0=A0=A0=A0=A0=A0=A0 efi_init();
> =A0=A0=A0=A0=A0=A0=A0 paging_init();
> =A0#if IS_ENABLED(CONFIG_BUILTIN_DTB)
> +=A0=A0=A0=A0=A0=A0 initial_boot_params =3D __va(XIP_FIXUP(dtb_early_pa));
> =A0=A0=A0=A0=A0=A0=A0 unflatten_and_copy_device_tree();
> =A0#else
> =A0=A0=A0=A0=A0=A0=A0 if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_p=
a))))

I'll try and allocate some time for looking at this next week, got some
items on my todo list first. I doubt it'll help me cos I have not get
that option set, but I can go and test reserved memory stuff for systems
that do use it (I have a k210).

> > [    0.000000] Oops [#1]
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00001-=
g0d9d6953d834 #1
> > [    0.000000] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> > [    0.000000] epc : string+0x4a/0xea
> > [    0.000000]  ra : vsnprintf+0x1e4/0x336
> > [    0.000000] epc : ffffffff80335ea0 ra : ffffffff80338936 sp : ffffff=
ff81203be0
> > [    0.000000]  gp : ffffffff812e0a98 tp : ffffffff8120de40 t0 : 000000=
0000000000
> > [    0.000000]  t1 : ffffffff81203e28 t2 : 7265736572203a46 s0 : ffffff=
ff81203c20
> > [    0.000000]  s1 : ffffffff81203e28 a0 : ffffffff81203d22 a1 : 000000=
0000000000
> > [    0.000000]  a2 : ffffffff81203d08 a3 : 0000000081203d21 a4 : ffffff=
ffffffffff
> > [    0.000000]  a5 : 00000000401c31ac a6 : ffff0a00ffffff04 a7 : ffffff=
ffffffffff
> > [    0.000000]  s2 : ffffffff81203d08 s3 : ffffffff81203d00 s4 : 000000=
0000000008
> > [    0.000000]  s5 : ffffffff000000ff s6 : 0000000000ffffff s7 : 000000=
00ffffff00
> > [    0.000000]  s8 : ffffffff80d9821a s9 : ffffffff81203d22 s10: 000000=
0000000002
> > [    0.000000]  s11: ffffffff80d9821c t3 : ffffffff812f3617 t4 : ffffff=
ff812f3617
> > [    0.000000]  t5 : ffffffff812f3618 t6 : ffffffff81203d08
> > [    0.000000] status: 0000000200000100 badaddr: 00000000401c31ac cause=
: 000000000000000d
> > [    0.000000] [<ffffffff80338936>] vsnprintf+0x1e4/0x336
> > [    0.000000] [<ffffffff80055ae2>] vprintk_store+0xf6/0x344
> > [    0.000000] [<ffffffff80055d86>] vprintk_emit+0x56/0x192
> > [    0.000000] [<ffffffff80055ed8>] vprintk_default+0x16/0x1e
> > [    0.000000] [<ffffffff800563d2>] vprintk+0x72/0x80
> > [    0.000000] [<ffffffff806813b2>] _printk+0x36/0x50
> > [    0.000000] [<ffffffff8068af48>] print_reserved_mem+0x1c/0x24
> > [    0.000000] [<ffffffff808057ec>] paging_init+0x528/0x5bc
> > [    0.000000] [<ffffffff808031ae>] setup_arch+0xd0/0x592
> > [    0.000000] [<ffffffff8080070e>] start_kernel+0x82/0x73c
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle t=
ask!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill t=
he idle task! ]---
> >=20
> > We traced this back to early_init_fdt_scan_reserved_mem() in
> > setup_bootmem() - moving it later back up the boot sequence to
> > after the dt has been remapped etc has fixed the problem for us.
> >=20
> > The least movement to get it working is attached, and also pushed
> > here: git.kernel.org/conor/c/1735589baefc
> >=20
> > The second problem is a bit more complicated to explain - but we
> > found the solution conflicted with the remoteproc fix as we had
> > to move early_init_fdt_scan_reserved_mem() _earlier_ in the boot
> > process to solve this one.
> >=20
> > We want to have a node in our devicetree that contains some memory
> > that is non-cached & marked as reserved-memory. Maybe we have just
> > missed something, but from what we've seen:
> > - the really early setup looks at the dtb, picks the highest bit
> >     of memory and puts the dtb etc there so it can start using it
> > - early_init_fdt_scan_reserved_mem() is then called, which figures
> >     out if memory is reserved or not.
> >=20
> > Unfortunately, the highest bit of memory is the non-cached bit so
> > everything falls over, but we can avoid this by moving the call to
> > early_init_fdt_scan_reserved_mem() above the dtb memblock alloc that
> > takes place right before it in setup_bootmem().
>=20
>=20
> And then I suppose the allocations you are mentioning happen in
> unflatten_XXX, so parsing the device tree for reserved memory nodes before
> this should do the trick. Does the following fix your second issue?

Again, I'll have to look at this.
To give you a quick answer, I believe it is the create_pgd_mapping()
stuff in setup_vm_final() actually.
I'm not super sure about this particular bit of the issue, but in the
email I sent more recently that expands on these issues (that Mike
replied to the other day) the similar issue that I saw the allocations
in reserved memory were inside paging_init().

> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2b09f0bd8432..94b3d049fe9d 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -277,14 +277,15 @@ void __init setup_arch(char **cmdline_p)
> =A0=A0=A0=A0=A0=A0=A0 paging_init();
> =A0#if IS_ENABLED(CONFIG_BUILTIN_DTB)
> =A0=A0=A0=A0=A0=A0=A0 initial_boot_params =3D __va(XIP_FIXUP(dtb_early_pa=
));
> +=A0=A0=A0=A0=A0=A0 early_init_fdt_scan_reserved_mem();
> =A0=A0=A0=A0=A0=A0=A0 unflatten_and_copy_device_tree();
> =A0#else
> -=A0=A0=A0=A0=A0=A0 if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)=
)))
> +=A0=A0=A0=A0=A0=A0 if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)=
))) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 early_init_fdt_scan_reserved_=
mem();
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unflatten_device_tree();

Previously, this was problematic (doing the scan before unflattening).
I moved the scan to the earliest possible place that I could call it
without issues.
I'll get back to you...

> -=A0=A0=A0=A0=A0=A0 else
> +=A0=A0=A0=A0=A0=A0 } else
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("No DTB found in ker=
nel mappings\n");
> =A0#endif
> -=A0=A0=A0=A0=A0=A0 early_init_fdt_scan_reserved_mem();
> =A0=A0=A0=A0=A0=A0=A0 misc_mem_init();
>=20
> =A0=A0=A0=A0=A0=A0=A0 init_resources();
>=20
>=20
>=20
> >=20
> > Obviously, both of these changes are moving the function call in
> > opposite directions and we can only really do one of them. We are not
> > sure if what we are doing with the non-cached reserved-memory section
> > is just not permitted & cannot work - or if this is something that
> > was overlooked for RISC-V specifically and works for other archs.
> >=20
> > It does seem like the first issue is a real bug, and I am happy to
> > submit the patch for that whenever - but having two problems with
> > opposite fixes seemed as if there was something else lurking that we
> > just don't have enough understanding to detect.
> >=20
> > Any help would be great!
> >=20
> > Thanks,
> > Conor.
> >=20
>=20
> Even if that does not fix your issue, the first patch is necessary as it
> fixes initial_boot_params.

Sure, send a patch (with a nice commit message please, so that I don't
have to remember the whole process to review it!!) as my brain has long
since swapped out the nitty gritty of the unflattening -> scanning
process.

Thanks Alex!

Conor.

--D9AVMx1vkdavINVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAnR5AAKCRB4tDGHoIJi
0nd6AP9aKgJF6ZiRxDYTiFjoBjGvPICDi+XYXbGwQU7I1Blb0wEArb3aVt5GJKWv
6ckBjMCoW9rpjjNTxl/1Bdp0Myy+wQU=
=6lBC
-----END PGP SIGNATURE-----

--D9AVMx1vkdavINVt--
