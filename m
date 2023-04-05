Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7A6D7F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbjDEObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbjDEObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:31:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED2C1;
        Wed,  5 Apr 2023 07:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8C762685;
        Wed,  5 Apr 2023 14:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCAC4339B;
        Wed,  5 Apr 2023 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680705092;
        bh=zSAJvHpnJ4t5+N5rlPStNtw8kt3Pvqahl38JBpYY8G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UA05BQCDFOlATRVQf6u1KpRp0bUorSfIjan7xcEWrovcLCtG6gNGf4096NaaFpr2s
         /NErwGnTgYtFy7ZdM1i3tquxq7hjpC7wmlV/TgnIJRKIV1zF9lu4CP5c8oe5KWAPHQ
         77r0V/i0nWcoazrEjCoyt7/BUVuUxRkvmgtkAr2FDL554YVLCeL8LL8MAUxVvd56xW
         HSEjZG/XTAXMZ8qANPYHf87Ju78DBpuPGv0tiGZtDTnsJuQVELo9YGtEi7XFG0cTuO
         7prRmTBPrYhuaCNo5CQeQaue1Clx1elgq7OvAyjF9XJ8U7qcdmsWp05Vs6w78hkng0
         eI+P4ShYUl+zQ==
Date:   Wed, 5 Apr 2023 15:31:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>, Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 13/23] RISC-V: cpufeature: Add ACPI support in
 riscv_fill_hwcap()
Message-ID: <20230405-compel-slinky-2fe11b4bf0b3@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-14-sunilvl@ventanamicro.com>
 <20230404-promotion-scarce-7c69ff7e5f99@spud>
 <ZC15LqYqLzmiVdcr@sunil-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G5/7scijW3x9IuES"
Content-Disposition: inline
In-Reply-To: <ZC15LqYqLzmiVdcr@sunil-laptop>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G5/7scijW3x9IuES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 07:05:42PM +0530, Sunil V L wrote:
> On Tue, Apr 04, 2023 at 09:57:19PM +0100, Conor Dooley wrote:
> > On Tue, Apr 04, 2023 at 11:50:27PM +0530, Sunil V L wrote:
> > > On ACPI based systems, the information about the hart
> > > like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
> > > Enable filling up hwcap structure based on the information in RHCT.
> > >=20
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >  arch/riscv/kernel/cpufeature.c | 39 ++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 35 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 63e56ce04162..5d2065b937e5 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -6,6 +6,7 @@
> > >   * Copyright (C) 2017 SiFive
> > >   */
> > > =20
> > > +#include <linux/acpi.h>
> > >  #include <linux/bitmap.h>
> > >  #include <linux/ctype.h>
> > >  #include <linux/libfdt.h>
> > > @@ -13,6 +14,8 @@
> > >  #include <linux/memory.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <asm/acpi.h>
> > >  #include <asm/alternative.h>
> > >  #include <asm/cacheflush.h>
> > >  #include <asm/errata_list.h>
> > > @@ -91,6 +94,9 @@ void __init riscv_fill_hwcap(void)
> > >  	char print_str[NUM_ALPHA_EXTS + 1];
> > >  	int i, j, rc;
> > >  	unsigned long isa2hwcap[26] =3D {0};
> > > +	struct acpi_table_header *rhct;
> > > +	acpi_status status;
> > > +	unsigned int cpu;
> > > =20
> > >  	isa2hwcap['i' - 'a'] =3D COMPAT_HWCAP_ISA_I;
> > >  	isa2hwcap['m' - 'a'] =3D COMPAT_HWCAP_ISA_M;
> > > @@ -103,14 +109,36 @@ void __init riscv_fill_hwcap(void)
> > > =20
> > >  	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
> > > =20
> > > -	for_each_of_cpu_node(node) {
> > > +	if (!acpi_disabled) {
> > > +		status =3D acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> > > +		if (ACPI_FAILURE(status))
> > > +			return;
> > > +	}
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > >  		unsigned long this_hwcap =3D 0;
> > >  		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
> > >  		const char *temp;
> > > =20
> > > -		if (of_property_read_string(node, "riscv,isa", &isa)) {
> > > -			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
> > > -			continue;
> > > +		if (acpi_disabled) {
> > > +			node =3D of_cpu_device_node_get(cpu);
> > > +			if (node) {
> > > +				rc =3D of_property_read_string(node, "riscv,isa", &isa);
> >=20
> > Hmm, after digging in the previous patch, I think this is actually not
> > possible to fail? We already validated it when setting up the mask of
> > possible cpus, but I think leaving the error handling here makes things
> > a lot more obvious.
> >=20
> Yeah, do you prefer to merge these patches again since only in this
> patch, we change the loop to for_each_possible_cpu() from
> for_each_of_cpu_node() which actually makes riscv_of_processor_hartid()
> not useful?

Yah, all 3 of us mistakenly thought that that was an unrelated cleanup
on the last revision, but clearly it is not.
Squash it back IMO, sorry for my part in the extra work generated.

Cheers,
Conor.

>=20
> > I'd swear I gave you a (conditional) R-b on v3 though, no?
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--G5/7scijW3x9IuES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC2GOAAKCRB4tDGHoIJi
0rnsAP0cgFLWkLbUrSntzAuLfoBAltCrodxxTLrayMe+WsSAOgEA0umoMwKzM2ox
W+uIW/1axAfQExBp1IRIgO1BnHHRKAE=
=CYcq
-----END PGP SIGNATURE-----

--G5/7scijW3x9IuES--
