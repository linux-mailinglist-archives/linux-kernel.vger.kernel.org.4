Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3835169F468
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjBVMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjBVMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:20:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6244939BAA;
        Wed, 22 Feb 2023 04:19:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC26261338;
        Wed, 22 Feb 2023 12:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D750CC433EF;
        Wed, 22 Feb 2023 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677068270;
        bh=9GmlRFeLaq0xJqlHCBlxHmEflw/cjNCvQ8EomYvQCy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwiNeLZFsPjnrK4I+Cu2ffSonN5hQxzvPUEPiaLXEonn7wSrFU9RUcpneslt9wZDp
         d2jOWJQfQNjjWouQ/O0dtu0YQxZYBDTl2cIjd1IM+fnBntIOn3xoJeAh3LZHQ983cH
         cLQnRQFlH73ykE/SIXs0fjnJt6ArAeuPZVN7PWRUGvuyH8NyD1xkgLCk4SHLrktU0H
         JpMOwiWf1pvq4ul7ATU2wI9PMJ3Ox8QDapE26fFVLX4x2xjW8iGEpnuRUO3IooI0rZ
         U/E9SjSEshbI8TxP8VnWsikub+Ipciqm39stdS5OfZ8LLqA8HATdsG2+Mvo1O/mlqR
         ymUiXch60Q1PQ==
Date:   Wed, 22 Feb 2023 12:17:41 +0000
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
Message-ID: <Y/YH5eqUgZ53vwnc@sirena.org.uk>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-5-clamor95@gmail.com>
 <Y/VEUaOIE1mk1utt@sirena.org.uk>
 <CAPVz0n1kkXQDNhzFoa8xwqaFErNDTHSaqM07TDUHRPSnH+PvkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NGrKRoeMMLtTRJ90"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1kkXQDNhzFoa8xwqaFErNDTHSaqM07TDUHRPSnH+PvkQ@mail.gmail.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NGrKRoeMMLtTRJ90
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 10:00:58AM +0200, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 22 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 00:23 Mark Brown=
 <broonie@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:

> > It feels like this is complicated enough and looks like the
> > clocking is flexible enough that it might be easier to just have
> > a table of values or otherwise enumerate standard rates, seeing
> > the code I feel like I need to worry about what happens if we
> > pick a clock rate over 6MHz (the loop could give a value over
> > that), and it's not clear why we have the switch statement rather
> > than just starting at a multiple of 128 and looping an extra time.

> > I suspect there's going to be no meaningful downside for having
> > the clock held at over 3MHz on a tablet form factor, the usual
> > issue would be power consumption but between the larger battery
> > size you tend to have on a tablet and the power draw of the
> > screen if that's on it's likely to be into the noise practially
> > speaking.

> This is how downstream handled mclk rate for RT5631.

That doesn't mean it shouldn't be fixed or improved.

--NGrKRoeMMLtTRJ90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2B+QACgkQJNaLcl1U
h9AD1ggAgGEXkKHQTxxtVxDQMk02dT4bJ/dorByL9oNrnCr19ruII/5BBJ9hmnsw
J6iCIEvHYDaaFGATbUGWfKylQjgepRI6bTsnsOkpnvzlK6kn/tGxKBhZ5/sxWu+n
ngzW35tcAX9l66cPsi3J3TpACmNzlehJobYqPtPLCq8+GHwRjqCPp3MxlDKw35lA
46nf76vZCfp34GIZ9VqOni9GKvQjudaKcOUKu3xN3IjNQd+nKElWsWwLh8b7X4Ji
1LPnwP+Xhze3ow0OpoCPsJGN4Kz8INyKEqrOaWEIcq23N83FNX7l8huDzWNVFkEk
AygpzBLJacRRd1otNcxO7BxXYAE+TA==
=QGGQ
-----END PGP SIGNATURE-----

--NGrKRoeMMLtTRJ90--
