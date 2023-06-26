Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0E73E5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFZQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFZQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:50:13 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084E1B1;
        Mon, 26 Jun 2023 09:50:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4ED453200996;
        Mon, 26 Jun 2023 12:50:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Jun 2023 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687798210; x=1687884610; bh=uc
        Py9Z08T7ijcFZZufeshPLjrL+BVwngvheYN8Oakzw=; b=j/20MptmplyKB34SVX
        tBO+SdHi4itCwDViM8PRk3dHwkW8JA21kelZfFa4ySd7DZ7lsv2eSZKpHb9yBcEp
        sDAjk2JGHYZkX2e/yx4qdo0OR2grE2nMV1v0DoZ+0CgdjKDQGaEuAikOqVc3rOvo
        4V96P9vwMz58CbjQg9KG533ojaEryTe8YG1w1oQHLOCDO1Hs21tzDoNdZVewMPhE
        1hVdT5oQAJi9Z81vAXFZLkuUoLTzXaWntyOr3DzsP8aUUNMLrBFnRAgmzJZgnmGj
        Qxp8zoPnPm3Ey5wFRCfOeQvhCucEZgZzEJH7pgVsVISdFz2xh49KMu7gKemOmeSa
        eMkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687798210; x=1687884610; bh=ucPy9Z08T7ijc
        FZZufeshPLjrL+BVwngvheYN8Oakzw=; b=ZgJRcCHRtbA7V3wVIHwQY4Q6cFsjk
        WJA1FXLQyqu/GUQSg4iE9CAKfBFj/APedV20hlytPR+nhLC2GyCwR+wyR0f+qxsW
        Cz0PdGdTEOs/UTwKMinbRlD0INDUrjXjtZ3h3bueGxqpAcYtY52Ts3UZrn3M6U8M
        7Ys1VY/G4CGZTdkaJ+77PBqMClyaMmZHt4v+ptvfpY6LYgUQYmiAyL4TXisvo2KS
        quotaEKEkYchNe3wTxBDhYXGyjNkD0uw7WssOHRZYGJHRFSJV17qCUSrJzBV0a0e
        1myUVT1/djdZ0g78KXk97l3AT1ZlnjabvvLpBedztt1d5QgVaQtUiaf4A==
X-ME-Sender: <xms:wcGZZGiaH_sYIpFHhad3zdvFPMgaqUenKTC3hkEkCYjdAs4Yvejm9A>
    <xme:wcGZZHBKBCHlGLFOEcsijygBzA9migzvIR0Z1vAAJau5zY9Q0yJmmU5tY4GhmAdiV
    r8sykaE11x6Uu4B2YQ>
X-ME-Received: <xmr:wcGZZOGpVKD9G6eQyLfWfMZ3--U0oAn_P95Kn9NYWXaPtYOogLl2UcPX2xrUruaVALkA1lfk2M8NSAOda4XlZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wcGZZPTm-1IICZVMuQcstfeM8RBOzm86Fn6MEnMUeGVtC1cYpFTGnA>
    <xmx:wcGZZDxS9GMKZT1lZY2ZcQKDMlJc4MUSh2xZEzMl6z9_16tg7X11gg>
    <xmx:wcGZZN6HH2m4iec7IO1Jq4C442VXqLdF14FMcGG68xcLCjK_7QiweA>
    <xmx:wsGZZIrrQ52uUPAptBCy3rKYHhQqXwQXyYn-SOK9fHYKb5AgVYnefQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 12:50:09 -0400 (EDT)
Date:   Mon, 26 Jun 2023 18:50:00 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
Message-ID: <lagot6cwcgdmdel7ce73tbmiyfalrlt56l4rx2fi3ibpso37zi@y7rkhou4tclm>
References: <20230611090143.132257-1-frank@oltmanns.dev>
 <20230611090143.132257-2-frank@oltmanns.dev>
 <87edmh12s7.fsf@oltmanns.dev>
 <sfni3vehkhotsqrrirklhzrxzkcxzkq6nbtqokeab5if3jgm53@frh7z3iowsfe>
 <878rc7stuu.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5p73wr2fp7f5ue6"
Content-Disposition: inline
In-Reply-To: <878rc7stuu.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u5p73wr2fp7f5ue6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 12:45:45PM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> On 2023-06-12 at 14:31:21 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Mon, Jun 12, 2023 at 10:51:52AM +0200, Frank Oltmanns wrote:
> >> > @@ -28,12 +68,17 @@ static unsigned long ccu_nkm_find_best(unsigned =
long parent, unsigned long rate,
> >> >  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
> >>
> >> According to the manual M/N has to be <=3D 3. Therefore we need a
> >> different maximum value for the _m-for-loop:
> >>
> >>         unsigned long max_m =3D min(3 * _n, nkm->max_m);
> >>         for (_m =3D nkm->min_m; _m <=3D max_m; _m++) {
> >>
> >> I suggest that I add an optional member max_mn_ratio to the structs
> >> ccu_nkm and _ccu_nkm. Optional meaning: Ignore if 0.
> >
> > Which workload is affected by this restriction?
> >
>=20
> Firstly, the restriction increases the minimum rate that pll-mipi of the
> A64 SoC can use. The rate off pll-mipi is
>         pll-video0 * K * N / M
>=20
> The Allwinner's user manual ([1], p.94) states that the maximum ratio of
> M/N (note how numerator and denominator changed) is 3. So, looking back
> to the original formula, the N / M part can be at most 1/3. That
> effectively limits the minimum rate that pll-mipi can provide to
>         min(pll-video0) * 2 * 1 / 3
>=20
> The minimum rate of pll-video0 is 192 MHz, i.e., the minimum rate for
> pll-mipi becomes 128 MHz. Without the restriction, the minimum rate
> currently is 24 MHz. It is my (albeit limited) understanding, that is no
> real limitation because no panel would request such low rates. I should
> also mention that Allwinner states in the user manual ([1], p. 94) that
> the rate must be in the 500 MHz - 1.4 GHz range.
>=20
> Secondly, it decreases the number of options for M for all N <=3D 6.
> Therefore it reduces the number of meaningful NKM combinations from 275
> (without the restriction) to 238. (With meaningful combinations, I mean
> the combinations that result in a different rate for pll-mipi, e.g.,
> K=3D2, M=3D1, N=3D2 is the same as K=3D4, M=3D1, N=3D1). The consequence =
is that the
> precision of pll-mipi is slightly reduced. Note, however, that this loss
> of precision is more than offset by the option that pll-mipi can now
> "freely" choose its parent rate.
>=20
> In conclusion, I don't see any real world limitation that this
> restriction introduces.

If we want to go that way, I'd rather use a function that validates
whether or not the current set of parameter is valid.

That way, we can express pretty much any constraints without
special-casing the main structure too much.

Maxime

--u5p73wr2fp7f5ue6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZJnBuAAKCRDj7w1vZxhR
xb80AQCpuUfjRsZDj4oX2zh/hfNYEzytGHWy4prrDYI0zK6udgD/eFjJYhGo55Cz
pUxEKq7T3qrcxW6icqzfjmw8A+IR4gY=
=ApE4
-----END PGP SIGNATURE-----

--u5p73wr2fp7f5ue6--
