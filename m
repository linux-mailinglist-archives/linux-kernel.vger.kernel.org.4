Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB7664D30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjAJUWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjAJUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:22:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244817E37
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:22:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87983B81981
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 20:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FF0C433D2;
        Tue, 10 Jan 2023 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673382125;
        bh=9EGHZOb2GDNsDgmyNNhgiMq88KY2ZtPaE3rt9uNDuaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYFPAW67K5ZWu8/aDzox6CkWb38sLQQeAPhNjIRNoYFt6+TEcmSoK9E6XVAnDhFe2
         ODjw6CqXeAvScwhX9afNrRuUeL3ZcxXuChLed89nMEourriKry5QE6i/wHt8G0w5+E
         tjbssRJn7AyFn39tlVpVGBzVUILBMwvzlRSXSz3tuFXl+XZiu8Bp7hMNHVkrownedI
         13ZaeZb1qrUo8INIVIcNkcIaXLX5ZiWLPfEBzjMzhmQIIbHR5rGrsdtzeh55TRyA5y
         /BB4YnJSpU/Y5/LpdJi8SuR8kTXh4WNJOYU+HpyVw2R9zBaIqQS41kdcmGxAhOLXpU
         r1N78z1zYP7Aw==
Date:   Tue, 10 Jan 2023 20:22:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <Y73I6H+X+qswIst0@spud>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
 <20230109193624.iiuguwgimpn7zbyw@orel>
 <6638291f6a3c463994919ba0a875472c@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aEr+ayiT2Lg3RrOQ"
Content-Disposition: inline
In-Reply-To: <6638291f6a3c463994919ba0a875472c@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aEr+ayiT2Lg3RrOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey JeeHeng,

On Tue, Jan 10, 2023 at 08:37:01AM +0000, JeeHeng Sia wrote:
> > From: Andrew Jones <ajones@ventanamicro.com>
> > On Mon, Jan 09, 2023 at 02:24:07PM +0800, Sia Jee Heng wrote:

> > > +/* Helper parameters that help us to restore the image.
> >=20
> > Separate line for /*
> ok

I'm not sure why this one struct has an actual description that
resembles kerneldoc, when nothing else does - but why not make it
actually kerneldoc, as you're almost there as things stand:
https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enume=
ration-documentation

> > > + * @hartid: To make sure same boot_cpu executing the hibernate/resto=
re
> > code.
> > > + * @saved_satp: Original page table used by the hibernated image.
> > > + * @restore_cpu_addr: The kernel's image address to restore the CPU
> > context.

^^ also your mail client is doing some really odd things wrapping wise.

> > > +static unsigned long temp_pgtable_map_pmd(pmd_t *pmdp, unsigned
> > long vaddr, pgprot_t prot)
> > > +{
> > > +	uintptr_t pmd_idx =3D pmd_index(vaddr);
> > > +	pte_t *ptep;
> > > +
> > > +	if (pmd_none(pmdp[pmd_idx])) {
> > > +		ptep =3D (pte_t *) get_safe_page(GFP_ATOMIC);
> >=20
> > No space between cast and function. Same comment for following function=
s.
> > I thought checkpatch complained about that.
> Ok. But it is weird that checkpatch doesn't report the issue.

It does:
20:08:17 conor /stuff/linux$ ./scripts/checkpatch.pl --strict --terse -g HE=
AD~3..HEAD
7481f133eb0310496742c27d15a20fdd2c499d29:97: CHECK: Alignment should match =
open parenthesis
[...]
7481f133eb0310496742c27d15a20fdd2c499d29:370: CHECK: No space is necessary =
after a cast
[...]
7481f133eb0310496742c27d15a20fdd2c499d29:460: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:467: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:475: CHECK: Blank lines aren't nec=
essary after an open brace '{'
7481f133eb0310496742c27d15a20fdd2c499d29:480: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:487: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:499: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:506: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:518: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:525: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:577: CHECK: No space is necessary =
after a cast
7481f133eb0310496742c27d15a20fdd2c499d29:591: CHECK: Alignment should match=
 open parenthesis
7481f133eb0310496742c27d15a20fdd2c499d29:596: CHECK: Alignment should match=
 open parenthesis
total: 0 errors, 1 warnings, 21 checks, 545 lines checked

The patchwork automation seems to have ignored this patchset for some
reason. It was stuck on a patchset for some reason and this one may
have got skipped when I tried to sort that out.
Ordinarily, you'd see it complaining about these sorts of things.

Thanks,
Conor.


--aEr+ayiT2Lg3RrOQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY73I6AAKCRB4tDGHoIJi
0uevAQD0LL1+O9o932YhX5juJyehF24SF3kLO4FCJ3sYy9aDtQEAg6ulenxst/zo
EdNpMSk5NMwkh5uZhQU8Mk4yIIB5CQU=
=JgxJ
-----END PGP SIGNATURE-----

--aEr+ayiT2Lg3RrOQ--
