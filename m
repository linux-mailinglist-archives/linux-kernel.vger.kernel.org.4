Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E77968F365
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjBHQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjBHQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:40:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563514DE2C;
        Wed,  8 Feb 2023 08:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D682261718;
        Wed,  8 Feb 2023 16:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C217C433EF;
        Wed,  8 Feb 2023 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874394;
        bh=k2WDmJefTVbmF4UtYjVTRVt38vEfq5VHOD9s78R7eyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rm1BIDwVjM+vtyitHjo1e7C/8O3osDSw3ddUWkl4Wx2bC5t9PAYPPNOMyPOnhDGBE
         x0/ntl8Z+mYIwUFJ4SJYgRaphWg6Yt4w739Gu/lXfntdZ6JeZX0Y+rfAbGvNs2ZHt8
         st0eJcGbt8o4IXvW5Pd80HgnuHqj+dz7ZtRrgPBzs0UpJBQvPfkACmHMCJmVksp2u1
         7j+OBIBzFLzMDdGcGKQCjlEbr0xBVw1CpjWop+Te/iJBfsS4i7ncKglT5iTBbI8VBo
         HOM9qBR39AlYqQf2ZmUflFWYvSQAKch5roLODmzzrvB8D8QMKelVKI/xJc21XFfhdD
         dus+tchf6H0SA==
Date:   Wed, 8 Feb 2023 16:39:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH mm-unstable v1 04/26] arm/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Message-ID: <Y+PQUMwH4AZSVpjb@sirena.org.uk>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-5-david@redhat.com>
 <Y+GcDFMNHw2cdDN1@sirena.org.uk>
 <39fd91e3-c93b-23c6-afc6-cbe473bb0ca9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W0tQR/5xWRekS1hu"
Content-Disposition: inline
In-Reply-To: <39fd91e3-c93b-23c6-afc6-cbe473bb0ca9@redhat.com>
X-Cookie: Walk softly and carry a megawatt laser.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W0tQR/5xWRekS1hu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 03:12:06PM +0100, David Hildenbrand wrote:
> On 07.02.23 01:32, Mark Brown wrote:

> > Today's -next (and at least back to Friday, older logs are unclear - I
> > only noticed -next issues today) fails to NFS boot on an AT91SAM9G20-EK
> > (an old ARMv5 platform) with multi_v5_defconfig, a bisect appears to
> > point to this patch (20aae9eff5acd8f5 in today's -next) as the culprit.

> It's been in -next for quite a while, thanks for the report!

Yeah, there's been some other things obscuring the issue.

> Could you give the following a test?
>=20
>=20
> From 8c4bdbd9862f85782d5919d044c172b584063e83 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 8 Feb 2023 15:08:01 +0100
> Subject: [PATCH] arm/mm: Fix swp type masking in __swp_entry()
>=20
> We're masking with the number of type bits instead of the type mask, which
> is obviously wrong.

Tested-by: Mark Brown <broonie@kernel.org>

but note that I had to manually apply it, though it's pretty trivial so
I probably applied the right thing.

--W0tQR/5xWRekS1hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPj0FAACgkQJNaLcl1U
h9C7hQf/VKRwP16M1jInUqUdUtyzPdvalnHTpasxKVZ8Sy0U3jwXMqNUqmnpEOSO
UB3Q8audVEzRc8pj92dk3jilZBDPHyP58UUKRsjkrZVz22Q2/R16FcjaLrdlwNlj
GWMfEWv5OKYPHaxP4W/VX0sXzS0XMTuulvAF1BOQRlOAS3L3jYsYUtzI2pkzJm1G
64ICND0ZQRerzQmdQd6oO2tVhymhv8Y1LPY4TT0HikINGVpwwCJoOiocmstgqqGW
uE+M+XJ9Lp/p78SIjfccjF1rdCWlc5MJJLS/qZzYnm6OnkKMOlBAUX9bwqvyrvE9
quDK6fshhrFo/uJ5YVAQnAEuDKLv9g==
=rC9E
-----END PGP SIGNATURE-----

--W0tQR/5xWRekS1hu--
