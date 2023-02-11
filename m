Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2029B6934E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 00:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBKXNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 18:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBKXNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 18:13:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE64F16303;
        Sat, 11 Feb 2023 15:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BDEBB80064;
        Sat, 11 Feb 2023 23:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA9DC4339C;
        Sat, 11 Feb 2023 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676157217;
        bh=y5kaCLM1NcAVq1JUjJMedwgWfbxerTHH5u6jIxnlh+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTmv90nIfc/t2kHg1QLgayGQxHRqPtwIt9PS8Z5wRyInWmES3KAzDGb7FD4xo0213
         e0nZupur2O1lVELT1ymgmGcle6N1etRwZlmWuqUk7wFIqlNY03P2qWGRfVCD+HcUip
         LeQiv+NcQ2B/0iB3wB1u5jRSYkgj4zKe/zOqTjdNK8AQmqLsb0nPUq2LV834smgBqK
         nIrS6dNoW51PDTosz98kuNs+uLxD3loe79UHygxdQYFIBya/6QBJtHDmBIpmOnb2jB
         eOHC/AQ4lrbF0q2vejkxMa33rDALoEUJtCzEbRfMJBS1rh3C78N38qWNkldCql4+6p
         +eyl0P1sT5Pcw==
Date:   Sat, 11 Feb 2023 23:13:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH -next] spi: spidev: fix a recursive locking error
Message-ID: <Y+ghH6yUARqinhuJ@sirena.org.uk>
References: <20230116144149.305560-1-brgl@bgdev.pl>
 <167395356741.524535.13729434862127399808.b4-ty@kernel.org>
 <Y+exzSwy1UJQCUKg@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gfpYWqG9KgsG0r0L"
Content-Disposition: inline
In-Reply-To: <Y+exzSwy1UJQCUKg@francesco-nb.int.toradex.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gfpYWqG9KgsG0r0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 11, 2023 at 04:18:37PM +0100, Francesco Dolcini wrote:

> Any plan to have this fix sent to Linus for v6.2? The reason for asking
> is that because of this bug our whole test infrastructure crashes
> preventing the normal testing we normally do on mainline kernel (that is
> also how this issue was spotted in the first place).

I already did.

--gfpYWqG9KgsG0r0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPoIR4ACgkQJNaLcl1U
h9C5jgf/ePPLCvgY2pc9i/gFk31lDVpyu68cP2JiSfI2OooLJrYd0P1H7Rep3jnl
fvCLk2C6JKW23vB7rVoFNk6WDUV+XTdCehh9nyYP52XTTVT/6IVkNH7/umjGnZFh
W+laHFXBX35czfY7VtKcmTsU0CnhC6DmrRoYaXSFmajhyboaGqOm7V37662HAEZ7
eRGJfQooeCR3NPB90YWEFBhkTvZRJopNJTD/hTK//70jGGrWu+4zJ3HOeIU0FWtP
hVuo6c0Axoon94FFSf7PPw2Xx0uyH/0tUeFfOPOPbHsHf2yvGZMzHcSK7jm2h4KH
7UWYzjWVmtN6JqVPK6/osRzmHAH31w==
=y7cP
-----END PGP SIGNATURE-----

--gfpYWqG9KgsG0r0L--
