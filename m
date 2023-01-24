Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B153A679C22
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjAXOkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjAXOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:39:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54133AE;
        Tue, 24 Jan 2023 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674571196; x=1706107196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QYC/3AGiRj6sLnDRHA1FuZ9RfMd2Lv6xm2a4QznoPBo=;
  b=gewVi62oKZf9vbj0w8rwWkEsHdo7uk+sE8Hq4chPC+ircRGVwNDUf8j0
   HSRbVgE3jtG0NtgKRF1dtVasz0RGtykm9hUnBkFxt6F6D6Xf2MNgqMduw
   Wb2R27gzlX5bg3sKpOWf7UmVtGVxEUTUDFb9iIqVNFRj/ceVWgOQ3FIHV
   gJiWdtmh1apS/JPPSGd5JFexZnJYEcHNMvjwbgp6CQnMcTEYtRNncFjcs
   JeN+dqw1NUDbqYOMLitKJjcgqcTXWffqjlzxc7DLQ7N2FBFWRvQpJ5jUQ
   Nv7DOaHR4eDbRk5WDVjpBxm6b42fjKg98cJ30mW7g0+SFrTAbzoZSu2k3
   w==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669100400"; 
   d="asc'?scan'208";a="193633516"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2023 07:39:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 07:39:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 24 Jan 2023 07:39:42 -0700
Date:   Tue, 24 Jan 2023 14:39:19 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] arch_topology: Build cacheinfo from primary CPU
Message-ID: <Y8/tl999NQwbPL/R@wendy>
References: <20230104183033.755668-1-pierre.gondois@arm.com>
 <20230104183033.755668-7-pierre.gondois@arm.com>
 <CAMuHMdUjgxgOXf5He1x=PLn7MQTjZgFQUHj8JrwbyweT4uOALQ@mail.gmail.com>
 <20230124140420.4srnufcvamvff77v@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vk/U8mTs5k/Wt3P9"
Content-Disposition: inline
In-Reply-To: <20230124140420.4srnufcvamvff77v@bogus>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Vk/U8mTs5k/Wt3P9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 02:04:20PM +0000, Sudeep Holla wrote:
> Conor might help me remember the details.

And I can't shirk either since you know I just replied to Pierre!

> On Tue, Jan 24, 2023 at 02:50:16PM +0100, Geert Uytterhoeven wrote:

> > > @@ -840,6 +840,14 @@ void __init init_cpu_topology(void)
> > >                 reset_cpu_topology();
> > >                 return;
> > >         }
> > > +
> > > +       for_each_possible_cpu(cpu) {
> > > +               ret =3D fetch_cache_info(cpu);
> > > +               if (ret) {
> > > +                       pr_err("Early cacheinfo failed, ret =3D %d\n"=
, ret);
> >=20
> > This triggers on all my RV64 platforms (K210, Icicle, Starlight,
> > RZ/Five).
> >=20
> > This seems to be a respin of
> > https://lore.kernel.org/all/CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=3DSQ+X=
8w5Q4C_70g@mail.gmail.com
> > which had the same issue.
> >
>=20
> I need to recollect my memories reading all the thread, but even after the
> fixes there were few platforms that failed with so early allocation but w=
ere
> fine with initcalls. Are these such platforms or am I mixing up things he=
re ?
> Do you still see all the cacheinfo in the sysfs with initcalls that happen
> later in the boot ?

IIRC that stuff was failing back then because riscv calls
init_cpu_topology() far sooner in boot than arm64 does, and therefore
caused allocation failures. You made that warning go away in the below
patch by moving detect_cache_attributes() to update_siblings_masks(),
which both arches call later during boot IIRC:
https://lore.kernel.org/all/20220713133344.1201247-1-sudeep.holla@arm.com

Pierre's patch has added fetch_cache_info() to the problematic
init_cpu_topology() which is called before we can actually do any
allocation in smp_prepare_boot_cpu() or something like that.

That's what I get for only reviewing the patch that was specifically for
riscv, and not the rest of the series... D'oh.

This actually came up a few weeks ago, although I kinda considered the
reason it was triggered to be a bit bogus there, since that dmips property
is not (yet?) a valid property on RISC-V. The patch for that is here:
https://patchwork.kernel.org/project/linux-riscv/patch/20230105033705.39461=
30-1-leyfoon.tan@starfivetech.com/
I tried it on a PolarFire SoC (unfortunately not an Icicle, I just went
and bricked mine an hour ago) & it should be a fix for this problem too.

My suggested commit message for that is somewhat prophetic now that I
look back at it:
https://lore.kernel.org/all/Y7V4byskevAWKM3G@spud/

I'll ping Palmer about that patch I guess...

Cheers,
Conor.


--Vk/U8mTs5k/Wt3P9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8/tlgAKCRB4tDGHoIJi
0sDmAQC5A7U+zC3XFE9IoI8mjgdAUswG9Sc9F3KPSROMrGNuzAD/RYD2MWaKYUqC
sZ+0vgdr9ZaNFfw9F1XIgPCOYWjBcQ8=
=jqYz
-----END PGP SIGNATURE-----

--Vk/U8mTs5k/Wt3P9--
