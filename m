Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B816D5F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjDDLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjDDLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8E62D55;
        Tue,  4 Apr 2023 04:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 328A363249;
        Tue,  4 Apr 2023 11:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4705C433EF;
        Tue,  4 Apr 2023 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680608626;
        bh=fmitKTP2A3EWk9XNz45pHfPah45MND6OQgw32mAKPK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmWSH+xkn42whE3uwo+NxSvbjzShE03vIDpxCtTA78dr+/n0W95kp8iWCkrlyNOb7
         B1yxRmg9NkVVHR8vsJBijC2mPdp+ecp3IJ0zNhcnchr+ljfKLB84irzKnbKWc49qtP
         m7Q/lVa31qkZ0VyNyJNf0ItXWr3mbdztwQSBk9+MDmp4SVQBEifvwWOQ1E6MNgWYt7
         J9Qu2egqXSy8rf+i1kzLDDC+/bj1cb9Axb1macmxXjfB0JOlGhYCNilbxIh60CuNny
         B0xaEXILNn7P1CX8/LkKCLLVZG3vpdAV5Drn+bGQ+PYZ0byKH4a+63d3DwHl1mYbSF
         KXZ5gyFefXovQ==
Date:   Tue, 4 Apr 2023 12:43:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: =?iso-8859-1?Q?omap-?=
 =?iso-8859-1?Q?mcpdm=3A_use=A0devm=5Fplatform=5Fioremap=5Fresource=5Fbyna?=
 =?iso-8859-1?Q?me=28=29?=
Message-ID: <328d0920-7dd2-4ee5-9b22-3f86dd31ed4d@sirena.org.uk>
References: <202303221411117451283@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zd9rlODtJ73APuoC"
Content-Disposition: inline
In-Reply-To: <202303221411117451283@zte.com.cn>
X-Cookie: Keep your laws off my body!
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zd9rlODtJ73APuoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 02:11:11PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource_byname(), as this is exactly what
> this function does.

This doesn't apply against current code, please check and resend.

--zd9rlODtJ73APuoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQsDWwACgkQJNaLcl1U
h9Crrgf/RStkN13yC5YhXkKomKmWTO6FB9f7QLIZLemvCbBNJhwL8aDs9Fp78bXe
j6LJxCBEeMZRJqn8EaS9pMWj7QTR1lKjN9rkJXl4rx7uJ3TzL6O32jbkypQPNhKr
GyeeogaxaFFfTzkMVkbImL4xacllrVowZES2oEopEXI1KrNvHp2fQKv4gLjo2sw0
z/BCsrqyVL1POM675Nrsi4f/E6WBFi0gmkQw1gKYiRC6oK8X0G5po0z/lsZgRb3o
cnrub1qB9+uyWdUCgcwEC8MbEOI+8F3xJAErppy2tGpYnXOv60cPyLVQj8hqvVBB
aPkuqztkLLb2ET1mwdD3M4YzaS8XAA==
=Iyzs
-----END PGP SIGNATURE-----

--zd9rlODtJ73APuoC--
