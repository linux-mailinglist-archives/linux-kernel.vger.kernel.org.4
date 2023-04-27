Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC56F0305
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbjD0JFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbjD0JFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:05:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC95E48
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682586297; x=1714122297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H/3ifw4Me7ZLmwRnUHcz2Bf1iRNy/a2wlnlif9iRpDc=;
  b=cah3sDFBb5tTV9Mch1JmUFC33HXv1Y1cPd42PSxtXpQnI1bMsTk2vypb
   pnYvDmHJ06TMMm4fddRwpCoNjp7f31rSPeLA/48P88xtjAsfh5XrqEz+k
   1J/hE2Wof8DMj8FW0aE+AZEHzHba7rHNxDB1AjqcZtyk7dsNW2EhkR/Aj
   TooXs0CsSUTCoSADm6GMzUNLJMA4aNKJmVyzLqoE8ZHzqY7RMKJKrxN5S
   4U9raH+DissYJOJJleY4iPak76Y26ZRDdj7azWKcB05hVIAJgJxDQIX7J
   4K4/YHCvOYmJcNHGFt9oereBuyCTMluI1T9kz8QVfMPx4M/yiD4N8jthf
   g==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="asc'?scan'208";a="210933956"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 02:04:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 02:04:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Apr 2023 02:04:52 -0700
Date:   Thu, 27 Apr 2023 10:04:34 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Message-ID: <20230427-unveiling-kiwi-631e966f77cc@wendy>
References: <20230425120016.187010-1-cyy@cyyself.name>
 <tencent_63090269FF399AE30AC774848C344EF2F10A@qq.com>
 <20230426-porthole-wronged-d5a6a3b89596@spud>
 <6kjgearxffbnnq4bsqs7e3jz6efz436m6gb3zjh7cfi357oxlv@krxto6orxwwn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g9EKRzq+LmoI7/Xs"
Content-Disposition: inline
In-Reply-To: <6kjgearxffbnnq4bsqs7e3jz6efz436m6gb3zjh7cfi357oxlv@krxto6orxwwn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--g9EKRzq+LmoI7/Xs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 09:53:19AM +0200, Andrew Jones wrote:
> On Wed, Apr 26, 2023 at 07:54:39PM +0100, Conor Dooley wrote:
> > (+CC Drew)
> >=20
> > Hey Yangyu,
> >=20
> > One meta-level comment - can you submit this patch + my dt-bindings
> > patch as a v2?
> > Some comments below.
> >=20
> > On Tue, Apr 25, 2023 at 08:00:15PM +0800, Yangyu Chen wrote:
> > > According to RISC-V ISA specification, the ISA naming strings are case
> > > insensitive. The kernel docs require the riscv,isa string must be all
> > > lowercase to simplify parsing currently. However, this limitation is =
not
> > > consistent with RISC-V ISA Spec.
> >=20
> > Please remove the above and cite ACPI's case-insensitivity as the
> > rationale for this change.
> >=20
> > > This patch modifies the ISA string parser in the kernel to support
> > > case-insensitive ISA string parsing. It replaces `strncmp` with
> > > `strncasecmp`, replaces `islower` with `isalpha`, and wraps the
> > > dereferenced char in the parser with `tolower`.
> > >=20
> > > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > > ---
> > >  arch/riscv/kernel/cpu.c        |  6 ++++--
> > >  arch/riscv/kernel/cpufeature.c | 20 ++++++++++----------
> > >  2 files changed, 14 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > index 8400f0cc9704..531c76079b73 100644
> > > --- a/arch/riscv/kernel/cpu.c
> > > +++ b/arch/riscv/kernel/cpu.c
> > > @@ -4,6 +4,7 @@
> > >   */
> > > =20
> > >  #include <linux/cpu.h>
> > > +#include <linux/ctype.h>
> > >  #include <linux/init.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/of.h>
> > > @@ -41,7 +42,7 @@ int riscv_of_processor_hartid(struct device_node *n=
ode, unsigned long *hart)
> > >  		pr_warn("CPU with hartid=3D%lu has no \"riscv,isa\" property\n", *=
hart);
> > >  		return -ENODEV;
> > >  	}
> > > -	if (isa[0] !=3D 'r' || isa[1] !=3D 'v') {
> > > +	if (tolower(isa[0]) !=3D 'r' || tolower(isa[1]) !=3D 'v') {
> > >  		pr_warn("CPU with hartid=3D%lu has an invalid ISA of \"%s\"\n", *h=
art, isa);
> > >  		return -ENODEV;
> >=20
> > I don't understand why this is even here in the first place. I'd be
> > inclined to advocate for it's entire removal. Checking *only* that there
> > is an "rv" in that string seems pointless to me. If you're on a 64-bit
> > kernel and the node has riscv,isa =3D "rv32ima" it's gonna say it is ok=
ay?
> > Drew what do you think?
>=20
> It makes some sense to me as a garbage detector. It's unlikely the first
> two bytes will be "rv" if the string is random junk.

Preventing the input of absolute rubbish is dt-validate's job & if the dtb
itself has been corrupted somehow I suspect that we have bigger problems
than checking for "rv" will solve.

> also do a strlen(isa) >=3D 4 check first, though. of_property_read_string=
()
> will succeed even when the string is "".

I don't think that checking that there are at least 4 characters isn't
even sufficient. Either we should confirm that this is a valid riscv,isa
to run on (so rv##ima w/ ## matching the kernel) or not bother at all.

It's a different issue though, and I'd be inclined to revisit it in the
future when the ACPI stuff is in, along with perhaps the cleanup parts
of Heiko's series too.

--g9EKRzq+LmoI7/Xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEo6ogAKCRB4tDGHoIJi
0tBzAP9Gjrxk70KxyJ3D82eZXdg5mq4oq9mwEu5UuYkAARPQawD/U/mk5q1Wts6h
7VXEioB99Mb4kdKQojdZuCuYnvN6lAU=
=IMRq
-----END PGP SIGNATURE-----

--g9EKRzq+LmoI7/Xs--
