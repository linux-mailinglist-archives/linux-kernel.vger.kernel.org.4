Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A63743521
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjF3Gek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjF3Ge3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:34:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B21199E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688106867; x=1719642867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WSIQqLvb2+/sUh6WEvq/CXC6xJpvh4r2DJzZW3eU28=;
  b=AeGiXIZvQmcm6kqcsQ6aFSD+tKlPuQCWxk9UtFb1Vme9VerpkaGsnADc
   vn1lKZjSRy7lAjtH2WbV4Y/hQm1qLyT4H7nowKmHfM9ScZpGGOUXYFUV9
   KdnIthe3xseAjiTe+pq9ChC+HbVDNygRYD54DvDCgomNCZjTkBQYd95Ly
   iavcDuI3dZxHq0sd2Q8lkjv/ilgqFLccOZeLVKZI2whsQ+KbysvPa52io
   NEA4YHV3ys0upZ8u9OTcBuiXRwkajEld/0fK71wEeFkLPo8guUUxPTmrZ
   w3NLnJpUHDmap7jClCmaKOar86wgeW0uqnBYF4InQdIKImRvtxbjkRKhc
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="asc'?scan'208";a="233041245"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 23:34:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 23:34:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 23:34:24 -0700
Date:   Fri, 30 Jun 2023 07:33:55 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <ajones@ventanamicro.com>,
        <sunilvl@ventanamicro.com>, <heiko.stuebner@vrull.eu>,
        <apatel@ventanamicro.com>, <evan@rivosinc.com>,
        <greentime.hu@sifive.com>, <leyfoon.tan@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: BUG_ON() for no cpu nodes in setup_smp
Message-ID: <20230630-tightrope-clatter-6eed9875a76f@wendy>
References: <20230629105839.1160895-1-suagrfillet@gmail.com>
 <20230629-maverick-kelp-17327f04482a@wendy>
 <0787532c-4520-6d01-c50c-63df207f570c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b/dkXq258KlMHHb5"
Content-Disposition: inline
In-Reply-To: <0787532c-4520-6d01-c50c-63df207f570c@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--b/dkXq258KlMHHb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Jun 30, 2023 at 11:02:18AM +0800, Song Shuai wrote:
> =E5=9C=A8 2023/6/29 20:33, Conor Dooley =E5=86=99=E9=81=93:
> > On Thu, Jun 29, 2023 at 06:58:39PM +0800, Song Shuai wrote:
> > > When booting with ACPI tables, the tiny devictree created by
> > > EFI Stub doesn't provide cpu nodes.
> >=20
>=20
> "When only the ACPI tables are passed to kernel, the tiny..."
> That seems more accurate. We can use "acpi=3D" kernel
> parameter to manually enable/disable ACPI.
>=20
> > What are the conditions that are required to reproduce this issue?
> > When booting with ACPI, why is acpi_disabled true?
> > In my naivety, that seems like a bigger problem to address. >
>=20
> Actually, I appended the "acpi=3Doff" to kernel cmdline for testing the "=
off"
> option. That would set acpi_disabled as true.

Yeah, I figured it was intentionally misconfiguration of your kernel,
given that you've tested other niche conditions and reported bugs, just
was not clear from your commit message whether this was a real bugTM
that should be fixed, or some sort of "you booted a kernel that can't be
used on this system".

> > > That's unclear, so bug for no cpu nodes before
> > > of_parse_and_init_cpus().
> >=20
> > What is unclear? That the reason for the BUG() was that there were no
> > cpu nodes, since it could also be that there were CPU nodes but they
> > were disabled etc?
>=20
> The BUG() in of_parse_and_init_cpus() indicates there was no boot cpu fou=
nd
> in the devicetree , not there were no cpu nodes in the devices.
> That's the "unclear" I mean.

Yup, please put that in the commit message so that people don't have to
figure out your intent ;)

> > Or, better yet, move the whole thing into of_parse_and_init_cpus() in
> > the first place? You could drop most of the comment in the process,
> > since I think the details of how you hit this problem would likely not
> > be helpful to anyone that hit it under different conditions.

> ok, I'll apply these comments if you're ok with my replies.

Yup, thanks!

--b/dkXq258KlMHHb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ53TwAKCRB4tDGHoIJi
0iT0AQDEE78wXiDe+YaX++QhWnHTqv8BlF6Rj4+iQGYrk70/fQD/R3SVLgqmER+C
5ugD+ASSeOvI1+0WWT5ZjkQppaybagQ=
=LWeE
-----END PGP SIGNATURE-----

--b/dkXq258KlMHHb5--
