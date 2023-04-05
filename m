Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7905F6D7A60
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbjDEKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjDEKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE14C20;
        Wed,  5 Apr 2023 03:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A97763CA0;
        Wed,  5 Apr 2023 10:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE13C433D2;
        Wed,  5 Apr 2023 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680691946;
        bh=NFRpILb73SbXaqiAYsKtilbT82AouxOyjWQbgbTHezs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnYIJ5Ar3+7sS99S55DFY6IBTnOyKAQxvj8tmXpSFEJ822wruQow62yrmM7Xpkj5m
         fRq+tYuuarRJh46WQxH4roDT3GYkRtyo5KDmHhoKU0KWBJXK4kMnBT793JQIjnM4yo
         ZwZTRrOBLoOPkCmrUhaaf8Um6WytBYRszsq/jRjkumMgKN4IiNmrDJgw1Ipi7RfZkX
         u74vNyWMYYwrjW1k2bNH3jnsiLPaVeABlhyVyrfrdaQqw6hbCs1h66XMH8NNM1ddhb
         402AqjJ7tq5c9iB59DNpyd1K/Q3Iy2h6WciigcDJS9WnYR1O+sYtQ/8/EW8lxQvovQ
         b+vAxvqbwncGQ==
Date:   Wed, 5 Apr 2023 11:52:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v2 2/3] regulator: da9063: implement basic XVP setter
Message-ID: <35202b81-abd6-4e0b-b2ad-a385cbb3979d@sirena.org.uk>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
 <20230403-da9063-disable-unused-v2-2-2f1bd2a2434a@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RCHnR4IsBmgTcBdi"
Content-Disposition: inline
In-Reply-To: <20230403-da9063-disable-unused-v2-2-2f1bd2a2434a@skidata.com>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RCHnR4IsBmgTcBdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 07:29:08AM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
>=20
> Allow to en- and disable voltage monitoring from the device tree.
> Consider that the da9063 only monitors UV *and* OV together, so both
> must be en- or disabled.

I have no idea what a "basic XVP setter" is and this isn't super
enlightening.  Is VP supposed to mean voltage protection or something?

> +	/* make sure that both UV/OV protections are either enabled or disabled=
 */
> +	if (uv_l->prot !=3D ov_l->prot || uv_l->err !=3D ov_l->err || uv_l->war=
n !=3D ov_l->warn) {
> +		dev_err(config->dev, "%s: regulator-uv-X-microvolt !=3D regulator-ov-X=
-microvolt\n",
> +			regl->desc.name);
> +		return -EINVAL;

I'm not sure that a user is going to figure out that this refers to the
protection levels, there's no hint as to what the X might be and the
error suggests that both the under and over voltage protection limits
must be have the same value, not just both be provided.

--RCHnR4IsBmgTcBdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQtUuIACgkQJNaLcl1U
h9AsoAf+KvtAxc8Zw7X+DUeCMbRgu7dC4di4jW4yUNhLH2DRMEo9/jBLgRh2vO64
5ySVz2O/jMvoyAKyJarrFtlEpncvCnFeiodAHH/8hNFYNJ8Wi3uiW5CzhEpmxMQ5
43yLej97NrhwFh381TO3iUjgqWfcvMWUq/Kb8bxHSZJPvT4vUzJXD5kAXs8LxVx9
0pkXk+GJyVEbKrVLlbryx9NC0NUArxASTq9sKolZuYJvGc6+/UJ8rmVmpdxVdVFV
vHSkXgiKxPoQ34I+6q+0jgGuKPowL3pxGr+qFU9e7YiEEeQKMPj243h15O2Yy8cO
qac8PhwJdq+3ZhHoflXF0K7uf6IMhw==
=tCLj
-----END PGP SIGNATURE-----

--RCHnR4IsBmgTcBdi--
