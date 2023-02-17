Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9202369A2DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBQAMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBQAMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:12:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493CE3A860;
        Thu, 16 Feb 2023 16:12:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2325B824B7;
        Fri, 17 Feb 2023 00:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C56C433EF;
        Fri, 17 Feb 2023 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676592730;
        bh=901s5sqkjUBs2YT2kwpAqnITH7jdp8CUol6MbZ6UOJw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VBTjfEBFjejcJM37X/s0CFwO5iiuTHTv9PrHChhqbYhDSboXEFBbyWjh27wGZO5UI
         jRbEggm9uH796J0siFEmH0bOYjFSUP+ZmDFj34qNlutm1FYFD8j6ObejwHjoVAaSdu
         EgF2fN2BX9CCEcikrQ7hnqsbDjvQ4CwzjZ1htLFtKqd+ArXj1O5vmuUf7LpTdeZv2f
         K3Z7RNg9QBrnzUutA4lzRz4CXNkJg7sKJBJHLqkXZDDjjkwIi/iCnX8umkxqorSezq
         tReTJSkA1ngWkVafXnupbYFHY6EAhfdCNvp2gf2BGPjblHteU5unCvEvH8VlNYtpy8
         XOx48YXWHAaYA==
Date:   Fri, 17 Feb 2023 00:12:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the spi tree with the i2c tree
Message-ID: <Y+7GVqNu2ED2xhhR@sirena.org.uk>
References: <20230216113035.3050871a@canb.auug.org.au>
 <Y+6IcubsNszRK/59@imac101>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2BGgAH1LYWBFZ2B"
Content-Disposition: inline
In-Reply-To: <Y+6IcubsNszRK/59@imac101>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h2BGgAH1LYWBFZ2B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 08:48:02PM +0100, Alain Volmat wrote:
> Hi,
>=20
> sorry for the mistake.  I should have made a serie with those
> 2 patches in order to avoid this conflict.  Sorry about that.
> I know now for a next case.

This sort of trivial add/add change is generally not a problem,
it's just good for the people sending the trees to be aware.

--h2BGgAH1LYWBFZ2B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuxlUACgkQJNaLcl1U
h9CqGgf/UuTFY1JXdmgx4nRr/ZQ+LGvSPJa3lfWaLJVpTdCswZSsO/imVlht7WtC
dTQJGvzNmDkdq2wh/GcZPlkZjCtJrt80XQqrNuNRGRYz/7K9UDw2fnefH234rfAS
IPr9hnOeWzaHOirKSNI5JSmUs6ROh9oOxHDFnLAPBIvpv9o2fOq+LvyDupc6t+/4
+q/UAwkEAhfSlm7OI7LDOq0aDdbljYsZ62WnbW1Et56D+BSAidSRgPACy9fDDgy7
nT16ryhhzUryUBauNpuFmJ1OeMKFiG0lY/rBDx2gkVk63WCuaiXiNIUCwmfPb9+q
b8azATYQbv6CCZFdZyBqhqcLp0YhBw==
=5yH+
-----END PGP SIGNATURE-----

--h2BGgAH1LYWBFZ2B--
