Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1F6A4CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjB0VBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjB0VBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:01:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1C427483
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADF48B80DA3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B0FC433EF;
        Mon, 27 Feb 2023 21:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677531667;
        bh=vGzqWKAExMZQ/GcvpwIKYpWEF52012oNQ54ZXtBHx+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWwFTpUQ9PzaaSdLXpMWQzuI2UaidLxxvgfp/Rg8cmDPffqO647NmmjuSaDDMleUA
         UcFYcbXhlvdugAMg6E+Ph5U24UwpyCvZkGuz6+HXxNq3OaPvsYapEE7TEPfkLRj31D
         X0X+PXTEhu794MmZtYZTLAvxxl2s2UO8IZaPTY1NMWbxMEpl4KU1TdyWIHYNe0DznN
         9VlPkZAbUPETbJZWTbPc9Q0AViaMNHECKGYyFAqlbj5vkQ86e+2XIM25vL7kcDDNdr
         pa+V/ShQsM9u2LeJOGbB+/CKgmHXR9FqFHzyJJN9jmZFaxkNWtr0kZc/jTAln3k8dy
         X4iunYHgt4TRQ==
Date:   Mon, 27 Feb 2023 21:01:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Duc Anh Le <lub.the.studio@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add HP OMEN 16-n0xxx into DMI table
Message-ID: <Y/0aD0pnhCGPcK5D@sirena.org.uk>
References: <20230227201250.5752-1-lub.the.studio@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XO0IoLLY93cLBSti"
Content-Disposition: inline
In-Reply-To: <20230227201250.5752-1-lub.the.studio@gmail.com>
X-Cookie: On the eighth day, God created FORTRAN.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XO0IoLLY93cLBSti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 09:12:50PM +0100, Duc Anh Le wrote:
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.

--XO0IoLLY93cLBSti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP9Gg4ACgkQJNaLcl1U
h9DOTQf+JT4QWzXXoY8grQiwxAedM5tc4GYzJos9RcEbC1wR2K/m2e3zD7zNKw8l
KTNHHYoW8Uqz68rSMPlQPr+tlcqDVtGnsu96fEhSP1K7JGu33niNdWc0x7K/5pZw
tci+UMjACDe7xm6qevZzbpstvyCVPjhyarPki9wwvKZn8XJLiE6VXx312O4s4xPs
mmZX2iOhpXvsUea6jNqlz69Y/h19zX4ClQ2hadTOzc6Mamj2abYHK8cBFSwvfavp
BGyRe/TQ1FRYpmyzEL2bH/1E41e/ZpKZy/av5UUS/GpbGcDHNcEvkWQCf0wfXwlC
pQHoYMf4F6Yc2CAYkiYfXZFjXYl1Rg==
=Yfau
-----END PGP SIGNATURE-----

--XO0IoLLY93cLBSti--
