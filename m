Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED869EA05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBUWXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBUWXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:23:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25461EBD1;
        Tue, 21 Feb 2023 14:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69674611EA;
        Tue, 21 Feb 2023 22:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AF7C433EF;
        Tue, 21 Feb 2023 22:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677018196;
        bh=m4xd55FJZ2TFrfhomdp1xq42bgvOVIIPvxwzKIFHpqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCoMWGucPwXtiWdo75mO0tuuTUAqauh3L7tVCTsdGBJFuFB0dUV62jsLgSirb42GP
         QLSVWSCbNXE7HRdneHZj73PltQIr4NxcpIEKre2V9us7O4YNdhnQorIfGIlOSATfBt
         pins3t/rfECz9Pk+IACulJ7DhTEfwbWFa+HJAhQCNV92YzSRlchDaATmvQyK2wKslC
         XBDrVpsgHPYxPsF9p8njDWhYA16Lu8YZY1sG/kgr6t6W6HC0dh6aLMPobyCtKJaa0W
         DhO+vOO9SLFWl42jsr+KtF25bxQLjzH90vvyW4mJ4FP6IODXxd1zyttNxIF0UsUEFA
         JpZyb1/BB97AA==
Date:   Tue, 21 Feb 2023 22:23:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 04/10] ASoC: tegra: Support RT5631 by machine driver
Message-ID: <Y/VEUaOIE1mk1utt@sirena.org.uk>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tOijhv7Qqz92bCVE"
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-5-clamor95@gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tOijhv7Qqz92bCVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 08:32:05PM +0200, Svyatoslav Ryhel wrote:

> Add Realtek ALC5631/RT5631 codec support to the Tegra ASoC machine driver.
> The RT5631 codec is found on devices like ASUS Transformer TF201, TF700T
> and other Tegra-based Android tablets.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>

Your signoff should be last if you're the one sending this.

> +static unsigned int tegra_machine_mclk_rate_6mhz(unsigned int srate)
> +{
> +	unsigned int mclk;
> +
> +	switch (srate) {
> +	case 64000:
> +	case 88200:
> +	case 96000:
> +		mclk =3D 128 * srate;
> +		break;
> +	default:
> +		mclk =3D 256 * srate;
> +		break;
> +	}
> +	/* FIXME: Codec only requires >=3D 3MHz if OSR=3D=3D0 */
> +	while (mclk < 6000000)
> +		mclk *=3D 2;

It feels like this is complicated enough and looks like the
clocking is flexible enough that it might be easier to just have
a table of values or otherwise enumerate standard rates, seeing
the code I feel like I need to worry about what happens if we
pick a clock rate over 6MHz (the loop could give a value over
that), and it's not clear why we have the switch statement rather
than just starting at a multiple of 128 and looping an extra time.

I suspect there's going to be no meaningful downside for having
the clock held at over 3MHz on a tablet form factor, the usual
issue would be power consumption but between the larger battery
size you tend to have on a tablet and the power draw of the
screen if that's on it's likely to be into the noise practially
speaking.

--tOijhv7Qqz92bCVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP1RFEACgkQJNaLcl1U
h9DpVAf+M2ffAYNVaX4PwMJKysdDwMn46T5Tf1y5pjJ3FoZjeN7IGuqSZ3iXo1WT
ms1bDTeUvHNIIUkUj90R9j5az1vTLboWFwsQRSQmkPkhkE/pD/R9skhgEh0Z0Kb0
zkXVEjEjtPddDwC8enKFqDqvNrcegZV9pOna2z21aG+Ao66HPQtayfuC8FblBS3m
2vFLIM5zMvuBgyeuSB++5pqcCZAdli4nDxijZT7+wlqesNVsjqDX+V0kClN3lfoK
nEpUH6u4MMmtcude37chUrPP0KKW/+h0dfgh3QG5C956xi8D9zo86q9q7B95MMPO
v4a40jcUysWb/dQcogit1e2we4NNYw==
=sbPL
-----END PGP SIGNATURE-----

--tOijhv7Qqz92bCVE--
