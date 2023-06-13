Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2B372E294
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjFMMOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjFMMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:14:33 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCBFB4;
        Tue, 13 Jun 2023 05:14:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 44512320091E;
        Tue, 13 Jun 2023 08:14:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 13 Jun 2023 08:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686658467; x=1686744867; bh=v4
        2YMf0yNUZaTnlv4RtlO9P3NL8urmHA6A2lQ634HEU=; b=ad6xbJBv0MwKg4Qrai
        OF7MgHam88c2EyG/0qJ3ZkSZTSNOuP4aI0NWiEiRFTtNNsrUAPV6ARYbzdWJmjxm
        1B1XYSs588JdxyPaeZga7o6BOFqNxwFw4nR39S8K/UeWkAw1wT9w+CY/X7L8+Bdw
        VFhbZwa8QLSEYDNYTQj1Po4iih8iVChK44A+1afLSoREYPxIOo7CU3m7fQRI8h9G
        6BeHRMtQN5ar7t8wqHNa2guxjy2QvuUHvTs41J39B5GMIQXhQIfrIPLbtptVJ8Ob
        GoNhawVav/YSN4EjDRkm33erzshI1aINfqRsQ5hPIz68hqc/3IjiQKzZiebDL4f3
        tW7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686658467; x=1686744867; bh=v42YMf0yNUZaT
        nlv4RtlO9P3NL8urmHA6A2lQ634HEU=; b=R75d6fAJ3amWnEZWUbbL5N5nO2juw
        yp26Dk2x7MCnT7qpnWHgNF9uYrJupJhwF3vJ8QM8FooM04OvLEx4VAqFl2QtgZyj
        Mk+dZj0Uq0faw2C7yiIOvW5GMwtXoN/SxLneB8wHVetutRm9fny2xMK1noIhFZVx
        aoA42D/8KIsDlVvTkcc5zCUqZxMQ1AyqPf3XvkOOhisoQDsZ/n9DiciUdLqpEWHZ
        fHSOwzxOz9iDz8rNx+nnZdHADh4r87g2yftOR+A7RxtKztMR4uiHmgs5vAiTjK1V
        uMs8aDRUNfvylWtixusj60qv+7L5zOVGm+n4FqF/jXY/lREVZXDFqvoVg==
X-ME-Sender: <xms:o12IZGgnXkcnv-V5f36FH1Sos3rj_h6pWIlWq840WXgmcXm5NMD1ng>
    <xme:o12IZHBTVMbf6yJYiwozzPJmGFUn_XhPJ00oFhJbxPEZoj4XAEO7S963U81pCqpzY
    gmtRvH9e7xRBdym-Ho>
X-ME-Received: <xmr:o12IZOF-fjfY47NzEf266iBjOsOhIo-HP9nRVLH4blsv8sGRuZQR0rX6q0E0dEd31xEPu8JEpCmFbKxsupHRhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:o12IZPSXKaGAXW3w8uI4i1aUsjSZlLjzYU-HYUvomu8zISrdBucwbw>
    <xmx:o12IZDyvbuZHnFRrGB6zCeCYlvn8y07NGT3HxykA53AdBkDOVeWrkw>
    <xmx:o12IZN4gx6IbyB8KFMKG2QgO7sMqkc9iWQ7vg0H6j5IaNs8sgf0L_g>
    <xmx:o12IZKyZOcW2R1_CMZp4_qbsXNyhc5L7vGCoskOgOTwt-l0B3loHEg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 08:14:27 -0400 (EDT)
Date:   Tue, 13 Jun 2023 14:14:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@aculab.com>, kernel@collabora.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: composite: Fix handling of high clock rates
Message-ID: <7s2xdk43a2lhyezgj6bbwxaekbtgym2rin7t432m4pos4j6v74@qaxm3htjak4a>
References: <20230526171057.66876-1-sebastian.reichel@collabora.com>
 <20230526171057.66876-2-sebastian.reichel@collabora.com>
 <2f3328c4be9db6feef2cc662ede70f92.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xknyxj2353a63nj6"
Content-Disposition: inline
In-Reply-To: <2f3328c4be9db6feef2cc662ede70f92.sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xknyxj2353a63nj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 05:10:35PM -0700, Stephen Boyd wrote:
> Quoting Sebastian Reichel (2023-05-26 10:10:56)
> > ULONG_MAX is used by a few drivers to figure out the highest available
> > clock rate via clk_round_rate(clk, ULONG_MAX). Since abs() takes a
> > signed value as input, the current logic effectively calculates with
> > ULONG_MAX =3D -1, which results in the worst parent clock being chosen
> > instead of the best one.
> >=20
> > For example on Rockchip RK3588 the eMMC driver tries to figure out
> > the highest available clock rate. There are three parent clocks
> > available resulting in the following rate diffs with the existing
> > logic:
> >=20
> > GPLL:   abs(18446744073709551615 - 1188000000) =3D 1188000001
> > CPLL:   abs(18446744073709551615 - 1500000000) =3D 1500000001
> > XIN24M: abs(18446744073709551615 -   24000000) =3D   24000001
>=20
> I had to read the abs() macro to understand this and also look at the
> types for 'req->rate' and 'tmp_req.rate' (both are unsigned long) to
> understand what's going on. I'm not sure I'd say that abs() takes the
> input as a signed value. Instead, it converts the input to a signed type
> to figure out if it should negate the value or not. The problem is the
> subtraction result is larger than can fit in a signed long long on a
> 64-bit machine, so we can't use the macro at all if the type is unsigned
> long and the sign bit is set.
>=20
> >=20
> > As a result the clock framework will promote a maximum supported
> > clock rate of 24 MHz, even though 1.5GHz are possible. With the
> > updated logic any casting between signed and unsigned is avoided
> > and the numbers look like this instead:
> >=20
> > GPLL:   18446744073709551615 - 1188000000 =3D 18446744072521551615
> > CPLL:   18446744073709551615 - 1500000000 =3D 18446744072209551615
> > XIN24M: 18446744073709551615 -   24000000 =3D 18446744073685551615
> >=20
> > As a result the parent with the highest acceptable rate is chosen
> > instead of the parent clock with the lowest one.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 49502408007b ("mmc: sdhci-of-dwcmshc: properly determine max clo=
ck on Rockchip")
> > Tested-by: Christopher Obbard <chris.obbard@collabora.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/clk/clk-composite.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> > index edfa94641bbf..66759fe28fad 100644
> > --- a/drivers/clk/clk-composite.c
> > +++ b/drivers/clk/clk-composite.c
> > @@ -119,7 +119,10 @@ static int clk_composite_determine_rate(struct clk=
_hw *hw,
> >                         if (ret)
> >                                 continue;
> > =20
> > -                       rate_diff =3D abs(req->rate - tmp_req.rate);
> > +                       if (req->rate >=3D tmp_req.rate)
> > +                               rate_diff =3D req->rate - tmp_req.rate;
> > +                       else
> > +                               rate_diff =3D tmp_req.rate - req->rate;
>=20
> This problem is widespread
>=20
>  $ git grep abs\(.*- -- drivers/clk/ | wc -l
>  52
>=20
> so we may have a bigger problem here. Maybe some sort of coccinelle
> script or smatch checker can be written to look for abs() usage with an
> unsigned long type or a subtraction expression. This may also be worse
> after converting drivers to clk_hw_forward_rate_request() and
> clk_hw_init_rate_request() because those set the rate to ULONG_MAX.
> +Maxime for that as an FYI.

We set max_rate to ULONG_MAX in those functions, and I don't think we
have a lot of driver that will call clk_round_rate on the max rate, so
we should be somewhat ok?

> Maybe we need an abs_diff() macro instead, that checks the type and on
> CONFIG_64BIT uses a conditional like above, but if it is a smaller type
> then it just uses abs() on the expression because it knows the
> difference will fit in the signed type conversion. I see that such a
> macro exists in some drm driver, so maybe it can be promoted to
> linux/math.h and then every grep hit above can use this macro instead.
> Care to take that on?
>=20
> Either way, I've applied this to clk-fixes as it is a regression. I'm
> just worried that this problem is more extensive.

Yeah, that construct is pretty much everywhere, including in the core :/

Maxime

--xknyxj2353a63nj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIhdoQAKCRDj7w1vZxhR
xU5bAP9g7Tee5vJITJfE+Ar+pEw/9kcbIf86Je/pPgxBQ9p6QQD/VfCaShlIUjQe
fGnC8mqsu1vU1OCltzoWRjv51iAQegw=
=mwAH
-----END PGP SIGNATURE-----

--xknyxj2353a63nj6--
