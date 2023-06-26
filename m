Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCE73EBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjFZUef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFZUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:34:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BEA1A2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1469B60F18
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2E3C433C0;
        Mon, 26 Jun 2023 20:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687811669;
        bh=ISmdUkrKULCJCFTkPXJstD36z/Ol6+a+XD6GmTrJ0hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTomys7hl8SzPESX2Q1yZS+c0t4HNU1KFDJJYOqv3uNFQkRi1XOBXeQQaJzMFjd48
         05Adq+J66LpNyYfmTDdgzmE0o3OtP8UY1dCHn6qZ9shmFupGQWoPAJsnUEeXh4mdOR
         XB6IoAgZCf96uS4EhMtYFRMRIV3AXPAbMBS5/yoQvF3pxl64WnJFdqy175+E/VR2nh
         k3fFitMguY/l4+ZpL1cEIDQfN+NXMCF4zsHP5i4MSPqXSzh9Oh1oxqTM7xjohBJ0CK
         nFh0aTivx9kS14Pc2m8hJuUfZ2TkfShfnFxpfzAjSKrwivmH3Boa1ZXm9nVyDF2S0B
         yrA9xi0vYW2Kw==
Date:   Mon, 26 Jun 2023 21:34:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230626-nature-seventh-6102e17bb4be@spud>
References: <20230623222353.3742384-1-evan@rivosinc.com>
 <20230624-mortally-parking-68f6bc1dd5ee@spud>
 <CALs-HstvXcwBa+h0u4mz_Pjm-bNd=9DX49Xy-=Fq0t3ECmAi2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ThNQzj7TlCUVJnph"
Content-Disposition: inline
In-Reply-To: <CALs-HstvXcwBa+h0u4mz_Pjm-bNd=9DX49Xy-=Fq0t3ECmAi2w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ThNQzj7TlCUVJnph
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 12:25:42PM -0700, Evan Green wrote:
> On Fri, Jun 23, 2023 at 5:12=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Fri, Jun 23, 2023 at 03:23:53PM -0700, Evan Green wrote:
> > > In /proc/cpuinfo, most of the information we show for each processor =
is
> > > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> > > compatible, and the mmu size. But the ISA string gets filtered throug=
h a
> > > lowest common denominator mask, so that if one CPU is missing an ISA
> > > extension, no CPUs will show it.
> > >
> > > Now that we track the ISA extensions for each hart, let's report ISA
> > > extension info accurately per-hart in /proc/cpuinfo.
> >
> > No, you can't do this as it breaks the assumptions of userspace that
> > this shows the set supported across all harts.
> > Sorry, but NAK.

> My hope was that we were still early enough that no production systems
> existed (yet) that actually had different ISA extensions in the set we
> track, and therefore usermode would have been unable to make those
> assumptions at this point. If such a system exists, and I don't know
> if it does or not, then I agree it's too late to make a change like
> this.

You should put this information into your commit messages & not just
hope that people understand your intent.
Userspace does actually make these assumptions already, see for example
this Google "cpu features" repo:
https://github.com/google/cpu_features/tree/main
To be quite honest, I really dislike the fragility of what they have
implemented - with only one of the reasons being they made the mistake
of assuming homogeneity.

There's got to be a line somewhere for what constitutes buggy userspace
and what's a regression. Up to Palmer I suppose as to what constitutes
which.

> I thought I'd put this out here and see if someone could point at such
> a system; but if not it'd be great to keep /proc/cpuinfo accurate and
> consistent with hwprobe (which does return accurate per-hart ISA
> extension info).

Just another nail in the coffin for a bad interface :)
There are apparently some mixed c906 chips that support vector on one
core and not the other - although it is thead vector which is not
supported upstream yet...

Other than that, SiFive stuff technically can be mixed - rv64imac &
rv64imafdc on a bunch of the older stuff. I don't think anyone actually
runs those sort of configurations on them though.

--ThNQzj7TlCUVJnph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJn2UAAKCRB4tDGHoIJi
0pskAP9yYAMoQpZtM2yirifXI40NwXG+IUQu+cgL6UmPh9EW2wD/Z827GT2WKF1f
hGcH5gWmZgcxkEy40e2oUyNZf5rwnwM=
=+W66
-----END PGP SIGNATURE-----

--ThNQzj7TlCUVJnph--
