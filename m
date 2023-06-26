Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7173E0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFZNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFZNfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:35:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC41B7;
        Mon, 26 Jun 2023 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687786519; x=1719322519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gAk31+J9YDPOueH0IlItj567Vy4tDOh+GRCSBbZlyFo=;
  b=rLBdiBM7WS8aFvP2Yt86aZGioFnyTTrHpKNzhvonecILns4mxcz3Tm1E
   hS1/AfFrYCl4xMvHtPiMHzJPErIDbKPBnbBzR+fZRHIF1zCJZjLRgUbgf
   KdyBB8OkPxF3kYdT+Y4WePRCbmMQBWKpRa/BSCz/5HzCp3X5x0whUmmOf
   adavmal1wdsmt6tA/YYE3kZhaOO+OG9MNBSouvfvLzKTCv6SwmasKbbnH
   UOG0mcgZZeFVvdE6iKtmdiQHEie3+Q2SdWpXR2ixGTPhYsWvaKo2jqM8U
   ybtt6G0MUgfuWpk/hbJM4Gy5mm9zcUjmhS9+nDewykocgC6n0vklSqn46
   w==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="asc'?scan'208";a="220545498"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 06:35:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 06:35:15 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 06:35:11 -0700
Date:   Mon, 26 Jun 2023 14:34:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor@kernel.org>, <suagrfillet@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <ajones@ventanamicro.com>,
        <alexghiti@rivosinc.com>, <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, <rppt@kernel.org>,
        <samuel@sholland.org>, <panqinglin2020@iscas.ac.cn>,
        <anup@brainfault.org>, <xianting.tian@linux.alibaba.com>,
        <anshuman.khandual@arm.com>, <heiko@sntech.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH V1 1/3] Revert "RISC-V: mark hibernation as nonportable"
Message-ID: <20230626-mousy-latter-ad8088de089f@wendy>
References: <20230625-obstinate-grimy-b765a1d3d741@spud>
 <mhng-57d088de-b527-4f19-89f5-fec31a6df475@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7iJUOqLUsa8DucKl"
Content-Disposition: inline
In-Reply-To: <mhng-57d088de-b527-4f19-89f5-fec31a6df475@palmer-ri-x1c9a>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7iJUOqLUsa8DucKl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 03:36:06PM -0700, Palmer Dabbelt wrote:
> On Sun, 25 Jun 2023 15:15:14 PDT (-0700), Conor Dooley wrote:
> > On Sun, Jun 25, 2023 at 11:09:21PM +0800, Song Shuai wrote:
> > > =E5=9C=A8 2023/6/25 22:18, Conor Dooley =E5=86=99=E9=81=93:
> > > > On Sun, Jun 25, 2023 at 10:09:29PM +0800, Song Shuai wrote:
> > > > > This reverts commit ed309ce522185583b163bd0c74f0d9f299fe1826.
> > > > > > > With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages
> > > for the
> > > > > linear mapping") reverted, the MIN_MEMBLOCK_ADDR points the kernel
> > > > > load address which was placed at a PMD boundary.
> > > > > > And firmware always
> > > > > correctly mark resident memory, or memory protected with PMP as
> > > > > per the devicetree specification and/or the UEFI specification.
> > > > > But this is not true? The versions of OpenSBI that you mention
> > > in your
> > > > cover letter do not do this.
> > > > Please explain.
> > > >
> > >=20
> > > At this time, OpenSbi [v0.8,v1.3) and edk2(RiscVVirt) indeed don't ob=
ey the
> > > DT/UEFI spec. This statement is excerpted from "Reserved memory for r=
esident
> > > firmware" part from the upcoming riscv/boot.rst. It isn't accurate fo=
r now.
> > > How about deleting this one?
> >=20
> > It is incorrect, so it will need to be removed, yes.
> > Unfortunately writing a doc does not fix the existing implementations :(
> >=20
> > > Actually with 3335068f8721 reverted, the change of MIN_MEMBLOCK_ADDR =
can
> > > avoid the mapping of firmware memory, I will make it clear in the next
> > > version.
> >=20
> > To be honest, I'd like to see this revert as the final commit in a
> > series that deals with the problem by actually reserving the regions,
> > rather than a set of reverts that go back to how we were.
> > I was hoping that someone who cares about hibernation support would be
> > interested in working on that - *cough* starfive *cough*, although maybe
> > they just fixed their OpenSBI and moved on.
> > If there were no volunteers, my intention was to add a firmware erratum
> > that would probe the SBI implementation & version IDs, and add a firmwa=
re
> > erratum that'd parse the DT for the offending regions and reserve them.
>=20
> Is there any actual use case for hibernation on these boards?  Maybe it's
> simpler to just add a "reserved regions actually work" sort of property a=
nd
> then have new firmware set it -- that way we can avoid sorting through all
> the old stuff nobody cares about and just get on with fixing the stuff
> people use.

What is "old stuff nobody cares about"? The first version of OpenSBI with
the fix shipped only the other day, so effectively all current stuff has
this problem. Certainly everything shipping from vendors at the moment
has the problem, and probably whatever downstream, custom versions of
OpenSBI also have it.

Also, the problem isn't just limited to hibernation apparently. I
think it was mentioned in the cover letter that according to Rob,
without being marked as no-map we could also see speculative access &
potentially some of the memory debugging stuff walking these regions.

I'm not sure how you'd intend communicating "reserved regions actually
work", I figure you mean via DT?
I don't really see the benefit of adding a property for those who are
behaving, if we can detect the versions of the one relevant SBI
implementation that are broken at runtime. DT hat on, even less so.
Perhaps I am missing your point, and there's another angle (like trying
to per firmware code)?


--7iJUOqLUsa8DucKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJmT8wAKCRB4tDGHoIJi
0nbBAQDsaa4oVZHw4/VcABPnn1PmcHFVf2ixtBkkcs7MEQgihAEA9G41AYagonFJ
Rw49Is8T58eY/wNITs9UkwFkoh+Khw4=
=Vgxt
-----END PGP SIGNATURE-----

--7iJUOqLUsa8DucKl--
