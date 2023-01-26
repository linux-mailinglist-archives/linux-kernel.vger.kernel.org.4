Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59667CD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjAZOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjAZOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:03:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF71126DD;
        Thu, 26 Jan 2023 06:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4671AB81BEA;
        Thu, 26 Jan 2023 14:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CA9C433D2;
        Thu, 26 Jan 2023 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674741819;
        bh=XFAbkKczz3+vE6lYAyx7yD6xSlpObyC5TMkTWoIuhAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2DcAfVA+WAdLstmscrckFhOGZ5QUSDK040SfeFG+csk1tOA3gVraDr4vd0PhbUZ8
         3arOgtwV0V7+N7SeohQXCYNWUrYDrWssHwwlaPR4yGF3p/pIBVGQeL1fpXZlC+o4/E
         53cipUURYP76keojquLPmbOAK6Kmpl2NWZ2HZxl1mjYuMu0QO0SZl0/07FouXzfB++
         tiCghX0h+IevcKu6itYm/nmHZTS4a3Qc6wLHxly3KoRzm0SC2f6byJzIGqln4kVNls
         s7Vty1Af5JzM1T4LCXU6Q6yLee9t0zuYdKcWrjkzJQBaC1gpnl//s8P6FNQfkKC0Zo
         fyoWsE5DDA8hg==
Date:   Thu, 26 Jan 2023 14:03:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Wolfram Sang <wsa@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l56: fix DT probe
Message-ID: <Y9KIN7GerLd4ziw0@sirena.org.uk>
References: <20230126135552.3625887-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/kMxXhANnbSaD4Sh"
Content-Disposition: inline
In-Reply-To: <20230126135552.3625887-1-arnd@kernel.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/kMxXhANnbSaD4Sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2023 at 02:55:29PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> While looking through legacy platform data users, I noticed that
> this one could never be used with DT based probing as the
> platform_data structure gets overwritten directly after it
> is initialized.
>=20
> There have never been any boards defining the platform_data in
> the mainline kernel either, so this driver so far only worked
> with patched kernels.

Or there is no mandatory properties/platform data and the
defaults are fine for most systems (which is a common case).

--/kMxXhANnbSaD4Sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPSiDYACgkQJNaLcl1U
h9BGGQf/TmJrEJHbdrJ/VUHGDohENM3/hBKqq91KIQ+9c/SMW3FrprCItWsdeZwJ
a2vHCpn65dwHzDWVg3SxRFEFaaCQncgPW/H+uicMq8RVuFh9CufTMOAwpP4AobUW
dxn0BMyu+bLqeC9/PSFo/TiixsqMVmb724ETP9QFzVl4sLnFQ753/ejmgsHnu/gW
vEqw/RJOOjTIZlrAvso99yymE/NDQsNXw2vo8XPyNYowRnHBtKqkYBhP16qcps3t
6eB02jpiMr8ggPig4sNjafe2aqWvOzVFI6goWvZEHdw4QtNM2+C7U658etEgBpOM
L6koux7hs7dDBBjIlHoIqJ86CAiyaw==
=eCk5
-----END PGP SIGNATURE-----

--/kMxXhANnbSaD4Sh--
