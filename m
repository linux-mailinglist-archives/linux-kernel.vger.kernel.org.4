Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC472FAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbjFNKbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244377AbjFNKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:30:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2352D75;
        Wed, 14 Jun 2023 03:28:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A40AF32009F0;
        Wed, 14 Jun 2023 06:28:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Jun 2023 06:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686738498; x=1686824898; bh=ZC
        OUyt2yTF9x4FgWIQpwXhgoxss/OYhX4Xfp8kmzJBc=; b=guYsAd3fpIJyaf1wnX
        OMgz2zWhoMC1pTGt07uVpJGxan5ur6GEq3JERg0eZtkXrTp3CUVQ47DilYqKYg6o
        MyJbK44rzVOU2808LKQEgWv+m3HRY/pYzp2rAZSGUZxNl8YJMKbFZCkYlPB8B92W
        VI/jxcT6g+Ro0V16RQQagdUqjrqdkHdR+XtVrC+C0u81vCNquxDKne1PocuI+Y71
        YCOSKqmmwNwkoZFsBxfencfFgWRrQH/x3pIF5xfFSMlZzZO34X7E9Mt4J+YdP40c
        UuNytT7EbAALC+e/GwfBglfS4Pu86nuWlBuuQsATzNcGTKDSIQohOmuDQIX4AWKF
        giWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686738498; x=1686824898; bh=ZCOUyt2yTF9x4
        FgWIQpwXhgoxss/OYhX4Xfp8kmzJBc=; b=LpNwAyqzfXhnOwPbRR76rDm1kvFUY
        f8mBuUOga6MapZonnBq8bJQYco9En3mr0HGqordQKjDi5+yofxzgp0Z5Rjqkf9Rs
        ewAWSMyHHvHesHJbiQZR6VIRK1EDzve6PjaINqsY8H2MSvu7kbS1kzwPBP88fdZX
        NVEONEkBOOjiOUdKejKSlwOXmMM0rk1aXd2YFtNtqCLqQWn8Ursn0LGaYALgWG7z
        yOVz72R4kHZWngy3NtGNibSOgYi1Qi7s0gPKQFvHu5dGYLQHYD/KOQYCp+z+sp3O
        v4NNdqqDf7SPNxb3Xay95QFn89kN+htLSucmrjTLd3JkbQppTZNjESgMQ==
X-ME-Sender: <xms:QZaJZABdDs-VczzLc_x-FeyIJGLC2egjBVq-qRtPRGhOXukkIyilFg>
    <xme:QZaJZCi1oRTrWQQhORi2r7FNo4Esf-XO12yl2XjgVaJsBb99ax9qpIMjx7v5KzgFZ
    -S0r6NDLrfIhn6QKkk>
X-ME-Received: <xmr:QZaJZDlq3Ll-n8-e54IfQ78FYawoCkiS-4zWCFimfYWngZAVYxy0NqeqarRaxQR6UVMajPxuMUSQydLPi_Tj6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QZaJZGzct8n9AxmadmX_jBwytlWfIbvglaGNoOgBCji_PmsCCZKKTA>
    <xmx:QZaJZFSmJSvt9agrRjA_kZQ5ztED_XwVL6gBGCn6ufsEHz9o3q4MAg>
    <xmx:QZaJZBbmzeDokvZkO03X-vxSN7O8odWis-5JyG4mJYJPAKBL1U5yXA>
    <xmx:QpaJZGTZAonh0DPgqmfa5YQvyapmhh21Uuh-dMnuyWpfS7l81mD8WQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jun 2023 06:28:17 -0400 (EDT)
Date:   Wed, 14 Jun 2023 12:28:14 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@aculab.com>, kernel@collabora.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: composite: Fix handling of high clock rates
Message-ID: <6nihw4k2vdtmjpvbei5ahb7cmtmuyi2w5m4pwhjrmdqi2yp7v6@vdpg5kwa7trl>
References: <20230526171057.66876-1-sebastian.reichel@collabora.com>
 <20230526171057.66876-2-sebastian.reichel@collabora.com>
 <2f3328c4be9db6feef2cc662ede70f92.sboyd@kernel.org>
 <7s2xdk43a2lhyezgj6bbwxaekbtgym2rin7t432m4pos4j6v74@qaxm3htjak4a>
 <86d58c6b131028a71964a0bcb135f01f.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rvbzj4d27cgjtg4p"
Content-Disposition: inline
In-Reply-To: <86d58c6b131028a71964a0bcb135f01f.sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rvbzj4d27cgjtg4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 11:25:12AM -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2023-06-13 05:14:25)
> > On Mon, Jun 12, 2023 at 05:10:35PM -0700, Stephen Boyd wrote:
> > > Quoting Sebastian Reichel (2023-05-26 10:10:56)
> > > > diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composit=
e.c
> > > > index edfa94641bbf..66759fe28fad 100644
> > > > --- a/drivers/clk/clk-composite.c
> > > > +++ b/drivers/clk/clk-composite.c
> > > > @@ -119,7 +119,10 @@ static int clk_composite_determine_rate(struct=
 clk_hw *hw,
> > > >                         if (ret)
> > > >                                 continue;
> > > > =20
> > > > -                       rate_diff =3D abs(req->rate - tmp_req.rate);
> > > > +                       if (req->rate >=3D tmp_req.rate)
> > > > +                               rate_diff =3D req->rate - tmp_req.r=
ate;
> > > > +                       else
> > > > +                               rate_diff =3D tmp_req.rate - req->r=
ate;
> > >=20
> > > This problem is widespread
> > >=20
> > >  $ git grep abs\(.*- -- drivers/clk/ | wc -l
> > >  52
> > >=20
> > > so we may have a bigger problem here. Maybe some sort of coccinelle
> > > script or smatch checker can be written to look for abs() usage with =
an
> > > unsigned long type or a subtraction expression. This may also be worse
> > > after converting drivers to clk_hw_forward_rate_request() and
> > > clk_hw_init_rate_request() because those set the rate to ULONG_MAX.
> > > +Maxime for that as an FYI.
> >=20
> > We set max_rate to ULONG_MAX in those functions, and I don't think we
> > have a lot of driver that will call clk_round_rate on the max rate, so
> > we should be somewhat ok?
>=20
> Good point. I haven't looked to see if any drivers are using the
> max_rate directly. Hopefully they aren't.

I had a quick grep for 'req->max_rate' under drivers/clk and there's no
driver using abs on that field.

Maxime

--rvbzj4d27cgjtg4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZImWPgAKCRDj7w1vZxhR
xWqqAQDtRJu+7X2t9w8kMiWSgFzQ9bh/myP2kVaGllLA7Ryp4gEA8nCo9oZhnPp0
paQV2Ot+629yys6nYCty3z7AzXB2Jw4=
=Dq2e
-----END PGP SIGNATURE-----

--rvbzj4d27cgjtg4p--
