Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A255F94BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJJAFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiJJAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:04:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0786DF12;
        Sun,  9 Oct 2022 16:37:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MlyBv5JWLz4xGQ;
        Mon, 10 Oct 2022 09:58:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665356312;
        bh=Zmd4M0pft6qW+1a/dUW6NQbRLKg2VXy/zKDq88Xl5cQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dDE2WYkjV1XVtqYdTHnG7pxZTdl2GU+0qWjLwc3FutNAq803e+jMjjYVyyGxRhk2r
         OC8VcvzaWVS2uwDilWyfMhewzan1ZkGkaEd1ce6eyOJlbHCL8/mhVifDWxLcyUQ4XA
         RaSFgn52keIPnSnUD9LQJ0BRNioK2HvDVWUnlPfIyFPsBT1jTnMU6A06aKi6GMqnHY
         W8QS5lwXW2EV40NMiSjx3Xtx3EwQHimT2UqkIa1bB/hw9t5jamR8+40WD8uDKTpizR
         1zLs9SDLQ8D4F3TQUAccVhMkteNs1B8xRq969PQilTyyrW7BTWDF1XFHyqy635391R
         GEGXKjZMXsIjg==
Date:   Mon, 10 Oct 2022 09:58:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Michael Strauss <michael.strauss@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20221010095830.7408d993@canb.auug.org.au>
In-Reply-To: <20220831153742.48e0289b@canb.auug.org.au>
References: <20220831153742.48e0289b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e3rrY8i/qUnvbP0mQbiu8VV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e3rrY8i/qUnvbP0mQbiu8VV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 31 Aug 2022 15:37:42 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the amdgpu tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> drivers/gpu/drm/amd/display/dc/dc.h:848: warning: Function parameter or m=
ember 'lttpr_mode_override' not described in 'dc_debug_options'
>=20
> Introduced by commit
>=20
>   280f1884892f ("drm/amd/display: Add DC debug option to force LTTPR mode=
")

I am still seeing this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/e3rrY8i/qUnvbP0mQbiu8VV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNDUhYACgkQAVBC80lX
0GzzEQf+Mzt4TdXL29e5wTyOGwUPZiI7STiXmSlMguKH/yp/+vh64i8ZxT9Jrtdy
j+NTkqaUUoYEmpWj+o0o9OTEBbXfX0BLvOdbw6W9ZRv54UJxGfIMwfBmrpMmLGsc
rmad6o3UElUSGR4BbumUu93ndABpaop4LV1Fr8issrir7OkIx/pQuy/jPDlwsMZr
pD47ccSy0/KLjqVoVIrdoeIv1FAatEtB6ybstZ/ttDTdmXjyMT46uqe6Cyncg/qE
cYhJHRkGS6qw9s5KbJY6uOxP+rmVajQAPeAtD0l5B2dkHycEshBmDfnFylC1uUC2
3PixijnCDNLu5RVlLOwo+oGfWgGTjA==
=J2NY
-----END PGP SIGNATURE-----

--Sig_/e3rrY8i/qUnvbP0mQbiu8VV--
