Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7A25ECD45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiI0T4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiI0T4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:56:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19C1FCC5;
        Tue, 27 Sep 2022 12:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EFA1B81D55;
        Tue, 27 Sep 2022 19:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1097AC433D6;
        Tue, 27 Sep 2022 19:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664308559;
        bh=EF7wmptVLAJkpup0OcLZZFmmWTKTxo8+yH58pvODRKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3PZekIjaNG0TswF2/wEU4dzt9BwBZffWPpFeJdFR2vnp6qbAHB/ZcaTEQJZPscpd
         c0S4VnfTToe+BGKjBtdVEjf0G/IwJ1sNZIa+Q6lCtImXBnwsErgmgXhwVJS4xHIUru
         i9zCNd0t523+oni0uwR/a7QNd0OQYR0+93wtsYeza9AuqyUeiEbQpWvS3AbXu671+Q
         SusgD8tNL4CTKkCv4xd/5bMDX7hX7qjfyhiGNa3PsdlSYsfSrYJOAuyxHoKOAlyEwd
         pvoLEuXfDt1ZYyroxYM+bfEQkoRN5QOGqU8qVjmm23rc9O7hrqDXKlVFXFgIYe1R0x
         O0hCx19siZDSw==
Date:   Tue, 27 Sep 2022 20:55:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm-stable tree with the bitmap
 tree
Message-ID: <YzNVSkwN1miK4xmB@sirena.org.uk>
References: <20220927192650.516143-1-broonie@kernel.org>
 <YzNRIep0dLbT2HGr@yury-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="coEENREKAlvo84zQ"
Content-Disposition: inline
In-Reply-To: <YzNRIep0dLbT2HGr@yury-laptop>
X-Cookie: Vote anarchist.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--coEENREKAlvo84zQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 12:38:09PM -0700, Yury Norov wrote:
> On Tue, Sep 27, 2022 at 08:26:49PM +0100, broonie@kernel.org wrote:

> >=20
> >   97848c10f9f8a ("lib/bitmap: remove bitmap_ord_to_pos")
> >=20
> > from the bitmap tree and commit:
> >=20
> >   3e061d924fe9c ("lib/nodemask: optimize node_random for nodemask with =
single NUMA node")
> >=20
> > from the mm-stable tree.
>=20
> The fix is correct. I sent the updated patch to Stephen, and
> apparently had to CC you. Thanks.

Normally it's Stephen, but he's off most of this week so I'm trying
provide some cover.

--coEENREKAlvo84zQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMzVUkACgkQJNaLcl1U
h9CVYgf/QUbH83rX9EpXEiBU8VlvMwfffinvv2YYZazmapumygHqXMsrk6BssPCM
SkkjZ+movqsKMwwAxKu7ohhvzqhF0V7VMI07Luqs5QQQ3N7VDphxsQtN3BrZV4Gq
YQcv1estpl5MUqPmj3szcMG+3ouJEn37u+mU96v2u+Cb2fFnqsuw+DdLGDKBryLY
oSeEs3U8GarCC/+N+9FPHuadRD0NB1g73HzLBSVTMBiwHMGlCFZyruwY4CuZB7qT
bJWPChmkYuB3wYdcO9tjlrZ2UmxrYeYzRZJ3om1Ej8bNYwTS2o62muk3maVr+I1H
jvxZkw4MfdSB02AyicEZLxpkkADwFg==
=ptWL
-----END PGP SIGNATURE-----

--coEENREKAlvo84zQ--
