Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D362F409
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbiKRLwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiKRLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:52:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D219922F2;
        Fri, 18 Nov 2022 03:52:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A957562480;
        Fri, 18 Nov 2022 11:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDFFC433C1;
        Fri, 18 Nov 2022 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668772319;
        bh=6b1fLl1K09GMrIMYkajYzfJYue4jcVgXsRIZjrazmmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nV06tCzwQGmpkomlbQxV4TD7b2kWyXQF12e422RJMC6Y6ECwba5fh3GT/0k/vFAWI
         PR866c6pyY/dRM2qogrmNfD2fqL8zMT1c2wfilNR0tLguVcTJ4tOwCBpo4qXfq1ARo
         qCJVcgX3bvPpSntzPlMwQGjfgtb0A43o2u2LfVNGa7xAql3TEbqAwqACPFPjy4K1GD
         MNz7jnYutRZGBoGUvXHqUay7P2T4kT/WJ5wApZT0MyOUyXR0MIu0Jh6Qg1qvL9Y4Cu
         Q4EXZA8zBV2vfip3raE3VI3AtW9AA+jx9o4ePMG6fKt9D1u0R6pkCRGbK09NDcq9FI
         THXyT6WBclyUA==
Date:   Fri, 18 Nov 2022 11:51:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Message-ID: <Y3dx1rx8mXR7vRX9@sirena.org.uk>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
 <5123090e11da67e57fb00984445ece2f@walle.cc>
 <Y3ZflHI6CYfaGIbn@sirena.org.uk>
 <bbe25d96e892e8cfd3f0da5d6755be22@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DPwIp4kLu/z6kaBr"
Content-Disposition: inline
In-Reply-To: <bbe25d96e892e8cfd3f0da5d6755be22@walle.cc>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DPwIp4kLu/z6kaBr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2022 at 05:30:29PM +0100, Michael Walle wrote:
> Am 2022-11-17 17:21, schrieb Mark Brown:

> > It's probably useful to provide a query function in the regmap
> > API for generic regmap users like this.

> Now I'm confused. Last time, I've proposed that, there was push
> back from you:
> https://lore.kernel.org/linux-gpio/20210430151908.GC5981@sirena.org.uk/

> That being said, I'd prefer to have such a query API :)

Now we have a generic user which cares about the distinction.

--DPwIp4kLu/z6kaBr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3cdUACgkQJNaLcl1U
h9C6pwf/ZGZCi5c5OHwGOR2phSgQVgE+wGj6HCl9HVhILx2xe70XG8LgJiH/YC1t
G2X1GetoBR2VAIedj11RpAc6Rhv2pIl1bGr3tLhIT2xLgpe5dFTiko/ez90IsgK4
wEFGxQbcvapbFSPt5/CoppVlzT+mvTYkm9t/Uk8PvVGhOzQOvrW14fHKsC1UWD/I
gnjfwHSPUfOi3s2ZnbMJ8xdKfk4EKlfvfQBrodKyU+ogeqVEf1n55p1480892RSX
kzObNr0V7T5sRPEKxp2YOrwTRnx6NsDTjEQ4Vb256MeDpczTaJgAjkEGjPkdw/86
NKQ6bDldLVwZwA9f7McTj3fgZ28G1Q==
=I5YC
-----END PGP SIGNATURE-----

--DPwIp4kLu/z6kaBr--
