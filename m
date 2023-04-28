Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BAE6F193E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjD1NVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjD1NVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9105D1BE4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C6CA63F0F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09487C433D2;
        Fri, 28 Apr 2023 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682688103;
        bh=cPKey0fNImM6OpCJgUFMsGvm9l8J52x5YEY48P86Ixo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HW8rEWaxhQyeVHKjHDuzPyfoxxdIk7Alia/qIJYfka0GN9ZeEFeMhtQw7oTnkwI8Q
         vkzsXldzKUsAUNFnF+5CM7SeoJkFy0zRGLaWc6e9IC7IIW963K3ppzg/bwyZHUGRwj
         7zFdgXG37msQRXv4oTjvoeAWOuHYKX8hCyo7jKuIhMeZCyphD9Cl13CpgIxrmi7uF3
         7sFEpKhwcDUbSvDr0LyR/Qu/ymEPqE93JwBK+GxXCipTynt6h1osjmmUV6zZwi2jtF
         Dn588xWBB6A1lqVUBiObveYo+So2Ta2kV5ciBjl3iyABtQ2cj6nOYyhWu43AKKlEPH
         FLtumTFO+RJNA==
Date:   Fri, 28 Apr 2023 14:21:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] regmap: force update_bits() to write to HW when reg
 is volatile
Message-ID: <643e5dd9-2d1f-4cc7-90e0-22e4a07ecd0f@sirena.org.uk>
References: <ZEtdJtlbmDCvZuAc@fedora>
 <14d81f72-ab34-4405-b826-b52636d2be18@sirena.org.uk>
 <f7cf3e43-c7bc-67ac-e9ea-e7a79bcd8a88@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oUyKV2P2dbUNSfFT"
Content-Disposition: inline
In-Reply-To: <f7cf3e43-c7bc-67ac-e9ea-e7a79bcd8a88@fi.rohmeurope.com>
X-Cookie: Love means nothing to a tennis player.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oUyKV2P2dbUNSfFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 12:36:51PM +0000, Vaittinen, Matti wrote:
> On 4/28/23 14:35, Mark Brown wrote:

> > I think you're looking for regmap_write_bits() here.

> Yes. Thanks for pointing this out to me. This is the functionality I=20
> searched for.

> However, my question really was if the regmap_update_bits() (and=20
> regmap_set_bits() / regmap_clear_bits()) should automatically work as=20
> regmap_write_bits() for volatile registers. I'll take your answer as=20
> "no" - and try to remember just use regmap_write_bits() with volatile=20
> registers which may require forcing writing the value even when it is=20
> not changed. Thanks!

Yeah, like you said in your commit there are cases where suppressing the
write is still useful - you might have some bits that are volatile and
some not or you might have something like a pattern where the hardware
can set bits and the host writes 1 to clear.  One common thing is to
have read only status bits mixed in with normal read/write bits.

--oUyKV2P2dbUNSfFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRLyGEACgkQJNaLcl1U
h9Bp/Qf+IDBE36zg5rBz2IDiKeS7ijBclPnbrQS6TDlvzo6NRrFygfLZohEN2sTi
JPAAkuuoabV8yHOFEXtk6ZOyEDxXh3UnwQAqLIzoB4bOZqvMk9Tl9/JhvvK5CLlQ
Xapaubzl4upWZi0lf9YcMvJhiAVHfe0tu/dhvhEmzfVN4l8WHFzkmNxBin2czHeB
p6eB9YE5lPK3o+dCl+OLZdBQgFpaakVUH2ma3b5goJsBHU+o9PAOfohijXr9xtgM
ezuYHCInr5RCYYd8O2aTURsamF4nfFvp5ICBGnt3XQAcp26c8dQzYtdPMev9aHAu
b5sLxISvM0awavRsORc8H7ZbTH//0Q==
=Qjed
-----END PGP SIGNATURE-----

--oUyKV2P2dbUNSfFT--
