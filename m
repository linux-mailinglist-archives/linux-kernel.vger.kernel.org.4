Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A872774A5DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGFVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F4DD;
        Thu,  6 Jul 2023 14:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2CFA61052;
        Thu,  6 Jul 2023 21:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11377C433C8;
        Thu,  6 Jul 2023 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688678701;
        bh=wFBJjL01JkwrFBXA69HbPyIA/y0xO2goAfgnFqefEiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EO9SU7i/rFNLXCFTbe3iRJtZQyPn866KlmHbuT86Q/XmVh96IHhEkOwPL3kOfljAL
         idGS56400oc8KFIoODdnAgYosIxMxCAd+Ss242bW3tCDkI5JgYI9s4kwkte9X8KLSH
         8ND4vy0cDLl/8vFVJxAshq5hpSVi9ePJpbiHwJ07cKIr+Z1jCEfM0TQ+ppJ4aZZpN4
         in6xL7eiBriTYiXiCeoD+jo7jPjew9SVHbKT8sQqohE1ZnaUhvSWCqG9LED4bjGnSi
         LQoGS4nWas29Fn71/qOMtQDlUeHNSKrZL/KbxW7LsNvnLa8qN8E1jqv5yH3S6QJbOX
         DD+JFQaYm/2gQ==
Date:   Thu, 6 Jul 2023 22:24:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, evan@rivosinc.com,
        heiko@sntech.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/3] RISC-V: Add T-Head 0.7.1 vector extension to hwprobe
Message-ID: <20230706-endorphin-choice-bd9da1f0bf84@spud>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
 <20230706-unwed-aeration-d8c7b71eac5e@spud>
 <ZKcddDAbpdCtRevP@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R8TeG8muzB31dp1x"
Content-Disposition: inline
In-Reply-To: <ZKcddDAbpdCtRevP@ghost>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R8TeG8muzB31dp1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

On Thu, Jul 06, 2023 at 01:00:52PM -0700, Charlie Jenkins wrote:
> On Thu, Jul 06, 2023 at 06:38:17PM +0100, Conor Dooley wrote:
> > On Wed, Jul 05, 2023 at 08:30:18PM -0700, Charlie Jenkins wrote:
> > > Using vendor extensions in hwprobe, add the ability to query if the
> > > 0.7.1 vector extension is available. It is determined to be available
> > > only if the kernel is compiled with vector support,
> >=20
> > > and the user is
> > > using the c906.
> >=20
> > Heh, unfortunately your patch doesn't apply this limitation.
> >=20
> > I'm not really sure where this series is intended to sit in relation to
> > Heiko's series that adds support for the actual T-Head vector stuff:
> > https://lore.kernel.org/linux-riscv/20230622231305.631331-1-heiko@sntec=
h.de/
> >=20
> > Is this intended to complement that? If so, these patches don't really
> > seem to integrate with it (and have some of the same flaws unfortunately
> > as that series does).
> >=20
> > Firstly, to my knowledge, all T-Head cpu cores report 0 for impid &
> > archid. Stefan pointed out:
> > 	C906 supports t-head/0.7.1 vectors as a configuration option.  The C90=
6 in
> > 	the D1 and BL808 has vectors, the recently announced CV1800B has one C=
906
> > 	with vectors and one without, and I vaguely remember seeing a chip wit=
h only
> > 	a non-vector C906.
> > =09
> > 	C908 (announced, no manual yet) claims V 1.0 support.  Presumably it w=
ill
> > 	not support 0.7.1.
> > =09
> > 	C910 (exists on evaluation boards) lacks vector support.
> > =09
> > 	C920 (TH1520, SG2042, etc) has 0.7.1 support, at least superficially
> > 	compatible with C906-with-vectors.  Hopefully we can share errata.
> > =09
> > 	This probably needs to be handled as an orthogonal "xtheadv" or "v0p7p=
1"
> > 	extension in whatever replaces riscv,isa.
> >=20
> > This makes an approach that does anything w/ their vector implementation
> > not discernible based on the m*id CSRs. IMO, the only way to make this
> > stuff work properly is to detect based on a DT or ACPI property whether
> > this stuff is supported on a given core.
> >=20
> > Since the approach just cannot work, I don't have any detailed comments
> > to make, just a few small ones below.
> >
>=20
> It would be beneficial to use Heiko's vector support patch. I can look
> into using that. The main purpose of this patch is to propose a method
> of vendor extension support and since T-Head has hardware I have used=20
> their hardware as an example of how to implement vendor extensions.=20
> That is the reason for the kind of awkward patch segmentation.

Just to be clear, you *need* to do something on top of Heiko's patches,
but with an adaptation for how you actually get the information as to
whether the device supports the extension. It makes no sense to tell
userspace that this "flavour" of V is present, if using it is going to
be problematic, as the kernel doesn't actually support it.

As I have pointed out above, while you might have a D1 with a c906 that
does have vector, other T-Head cores that respond identically to
mvendorid/marchid/mimpid may not.

For anything you do, please do it on top of my series adding a new
mechanism for parsing this information:
https://lore.kernel.org/all/20230703-repayment-vocalist-e4f3eeac2b2a@wendy/

If you have not already, you should coordinate with Heiko about what to
do here, before taking over the series he submitted.

> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/Kconfig.vendor                       | 11 +++++++++++
> > >  arch/riscv/include/asm/extensions.h             | 16 ++++++++++++++++
> > >  arch/riscv/kernel/sys_riscv.c                   | 20 +++++++++++++++=
+++++
> > >  arch/riscv/vendor_extensions/Makefile           |  2 ++
> > >  arch/riscv/vendor_extensions/thead/Makefile     |  8 ++++++++
> > >  arch/riscv/vendor_extensions/thead/extensions.c | 24 +++++++++++++++=
+++++++++
> > >  6 files changed, 81 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > > index 213ac3e6fed5..b8b9d15153eb 100644
> > > --- a/arch/riscv/Kconfig.vendor
> > > +++ b/arch/riscv/Kconfig.vendor
> > > @@ -1,3 +1,14 @@
> > >  menu "Vendor extensions selection"
> > > =20
> > > +config VENDOR_EXTENSIONS_THEAD
> > > +	bool "T-HEAD vendor extensions"
> >=20
> > > +	depends on RISCV_ALTERNATIVE
> >=20
> > Why do you need this?
> >=20
> Thanks for pointing that out, I meant to remove that.
> > > +	default n
> > > +	help
> > > +	  All T-HEAD vendor extensions Kconfig depend on this Kconfig. Disa=
bling
> > > +	  this Kconfig will disable all T-HEAD vendor extensions. Please sa=
y "Y"
> > > +	  here if your platform uses T-HEAD vendor extensions.
> >=20
> > I don't really like this Kconfig entry. We should just use the one in
> > Kconfig.errata that enables the actual vector stuff.
> >=20
> The purpose of this is to support more than just the T-Head vector
> extension. The vector extension is just the vendor extension I selected
> to support first. The purpose of this file is for all vendors to have
> their own Kconfig entries to enable the vector extension which I didn't
> feel that it properly fit into the errata.

Hopefully there will be no other vendors that decide to implement
v0.7.1! We probably do need to re-do how our menus look, although I
question whether adding yet another file (we have Kconfig.socs...) is
the right thing to do.


> > > diff --git a/arch/riscv/vendor_extensions/Makefile b/arch/riscv/vendo=
r_extensions/Makefile
> > > index e815895e9372..38c3e80469fd 100644
> > > --- a/arch/riscv/vendor_extensions/Makefile
> > > +++ b/arch/riscv/vendor_extensions/Makefile
> > > @@ -1,3 +1,5 @@
> > >  ifdef CONFIG_RELOCATABLE
> > >  KBUILD_CFLAGS +=3D -fno-pie
> > >  endif
> >=20
> > Again, why do you need this, or...

> This file is properly filled out in the next patch in the series but I
> wanted to break it up. I saw this in the errata Makefiles so I assumed
> it would be needed here.

Ye, you shouldn't...

> > > +
> > > +obj-$(CONFIG_VENDOR_EXTENSIONS_THEAD) +=3D thead/
> > > diff --git a/arch/riscv/vendor_extensions/thead/Makefile b/arch/riscv=
/vendor_extensions/thead/Makefile
> > > new file mode 100644
> > > index 000000000000..7cf43c629b66
> > > --- /dev/null
> > > +++ b/arch/riscv/vendor_extensions/thead/Makefile
> > > @@ -0,0 +1,8 @@
> > > +ifdef CONFIG_FTRACE
> > > +CFLAGS_REMOVE_extensions.o =3D $(CC_FLAGS_FTRACE)
> > > +endif
> > > +ifdef CONFIG_KASAN
> > > +KASAN_SANITIZE_extensions.o :=3D n
> > > +endif
> >=20
> > ...any of this? Not saying you don't, but I think it should be explaine=
d.
> >=20
> Same reasoning as above, I can remove it if it's not needed.

Ditto.

> > > +
> > > +obj-y +=3D extensions.o
> > > diff --git a/arch/riscv/vendor_extensions/thead/extensions.c b/arch/r=
iscv/vendor_extensions/thead/extensions.c
> > > new file mode 100644
> > > index 000000000000..a177501bc99c
> > > --- /dev/null
> > > +++ b/arch/riscv/vendor_extensions/thead/extensions.c
> > > @@ -0,0 +1,24 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2023 by Rivos Inc.
> > > + */
> > > +
> > > +#include <asm/extensions.h>
> > > +
> > > +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe =
*pair,
> > > +		  const struct cpumask *cpus)
> > > +{
> > > +	pair->value =3D 0;
> > > +	switch (pair->key) {
> > > +	case THEAD_ISA_EXT0:
> > > +#ifdef CONFIG_RISCV_ISA_V
> >=20
> > As pointed out by Remi, this doesn't work either.
> > You should not claim this is supported, just because V is, you also need
> > the support for their vector "flavour" from Heiko's series.

> The thought process was that it should only matter if they care about
> V. However since they are different versions of V I could see it being
> better to not depend on the same config.=20

Yeah, you unfortunately cannot use that kconfig symbol for this purpose,
they are incompatible after all. You probably need to use some interface
like riscv_isa_extension_available() that supports the vendor flavour of
this stuff. I've given no more thought to how that should look though
than the time it took to type this out. I'd be down to collaborate on
something in that neck of the woods, once things settle down after -rc1
& I've written a patch for dealing with extensions that have multiple
subsets in the extension detection code.

Perhaps Palmer or someone at Rivos could give you a rundown of the
vector incompatibility stuff on a platform with a shorter response
time than email ;)

Cheers,
Conor.

> > > +		if (marchid =3D=3D 0 && mimpid =3D=3D 0)
> > > +			pair->value |=3D THEAD_ISA_EXT0_V0_7_1;
> > > +#endif
> > > +		break;
> > > +	default:
> > > +		return -1;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > >=20
> > > --=20
> > > 2.41.0
> > >=20
>=20
>=20

--R8TeG8muzB31dp1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKcxKAAKCRB4tDGHoIJi
0h0OAQD/oDMfPOi9zjoAb7OitXO8GNgak798YbqN4ieY1O5DhAD/bDpG2nt3nt0U
XfYj4keJ5gh4oQw7A+fslm2uu872lQc=
=+7XP
-----END PGP SIGNATURE-----

--R8TeG8muzB31dp1x--
