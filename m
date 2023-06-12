Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD172C3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjFLMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjFLMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:19:12 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BC8F;
        Mon, 12 Jun 2023 05:19:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E1145C017C;
        Mon, 12 Jun 2023 08:19:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 12 Jun 2023 08:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686572348; x=1686658748; bh=0D
        oQciBN3VlYhgiS5cMmE54STTMQXVrhpUKmr0F5Rm0=; b=DYgAoAxBm4R8+/qxpt
        GLQ4uuNKIcf4FQAZ+PgUs4Fhn15l/ssuPXX2qGNvdqDR7Rqt/2jSj0XLSzbPq4VU
        qvA5SoecGp71BQSA1q0ZovySLBHwtf8EcwZ5jIkyzet25x/rd1VQku4HuHbmbjhn
        SUHdf7+xrj+qpjwqaMzdg5W71ecN/P5MF7AAxilPBHS2RXQSCIGznzfTPQyQT1hT
        MhRgDef3eg240+RvC27cd1lgFZmdW7OImhSc1lu6sd6PV23e77DOY+g543+MlyJX
        a6XB5iacIguMguszpiDQ0DXod17PDAQQZbQzw1d5MEA8xUL+C5ywUk59iYOl0uHN
        HgHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686572348; x=1686658748; bh=0DoQciBN3VlYh
        giS5cMmE54STTMQXVrhpUKmr0F5Rm0=; b=lQbZ8Q6Pzn8SA5G+dhqWt7m9bvZcT
        eIiKz8cTmgF6Xc/rbSzTAo2fPiyzHwD4UECfjey4Q/FBhZzP6kxDtN4Mo6aA0bqM
        TFTRks/tFKtXovDWrKfwOChTCdzrJj53BRTaSioDVMF/OSQDPVhJ+xdQpN26xbGa
        uA2+HS5Iyu2o7aVbCWnE6SMUpCByYj6g5wD3wFHZx/UJuAR8sbSnEqram6Zt+bpG
        +bTikpJf1yWXZVJ4TqIglBh8PxTmYeIZPDWAbMEZ6XS2Szkm3omIRY4KbvjFAJl3
        8Gqe5NkOCnII2rPyczkAr3S77mS5VFh0/munXGP1ijZE9kZvI85c1p2ZQ==
X-ME-Sender: <xms:Ow2HZAp9MSsuqdvLr0vSs9Bn_DMLHZkPyAP0dfcNxAQ9GB2co461Ww>
    <xme:Ow2HZGpVlxM7GQrFBWAyJzDkb_cwINVz3AC0mh52ID129aGFmDKkWE_GaNhgqwt4k
    CNeNJfqc40tesIcVV4>
X-ME-Received: <xmr:Ow2HZFPyRO-OG98D5WMDt1Yogpfwe5lYprC91dm2iA4cEpmAP7MTi1gEarpFnt2y_9MEEHCSx7ZSMGmWrtStwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Ow2HZH4reXUeVWThFZLVI4-SeCMBkAR72Fcf5SB-O1tBb6pgxbiWQQ>
    <xmx:Ow2HZP58FnqixmxPxkvZCfME7pQtHlkUH0yMb0R81dlfbU5T4vAojg>
    <xmx:Ow2HZHgI7i7b-gUYkU9expxu9ITXgleRf4RkY2X_RFPJwLGJixpZow>
    <xmx:PA2HZMxKLqDF8Wd6d2R2JTwpdDnyYTweTsR-i6NEgapKkNCxqhyPLg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 08:19:07 -0400 (EDT)
Date:   Mon, 12 Jun 2023 14:19:05 +0200
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
Subject: Re: [PATCH 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
Message-ID: <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewqo76xruqzoduop"
Content-Disposition: inline
In-Reply-To: <875y7y1f0d.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ewqo76xruqzoduop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 09:39:35AM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> On 2023-06-07 at 08:38:39 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Mon, Jun 05, 2023 at 09:07:44PM +0200, Frank Oltmanns wrote:
> >> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
> >> parent rate when determining a new rate.
> >>
> >> To find the best match for the requested rate, perform the following
> >> steps for each NKM combination:
> >>  - calculate the optimal parent rate,
> >>  - find the best parent rate that the parent clock actually supports
> >>  - use that parent rate to calculate the effective rate.
> >>
> >> In case the clk does not support setting the parent rate, use the same
> >> algorithm as before.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu_nkm.c | 40 ++++++++++++++++++++++++++--------
> >>  1 file changed, 31 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu=
_nkm.c
> >> index a0978a50edae..c71e237226f2 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> >> @@ -16,10 +16,10 @@ struct _ccu_nkm {
> >>  	unsigned long	m, min_m, max_m;
> >>  };
> >>
> >> -static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned=
 long rate,
> >> -				       struct _ccu_nkm *nkm)
> >> +static unsigned long ccu_nkm_find_best(unsigned long *parent, unsigne=
d long rate,
> >> +				       struct _ccu_nkm *nkm, struct clk_hw *parent_hw)
> >>  {
> >> -	unsigned long best_rate =3D 0;
> >> +	unsigned long best_rate =3D 0, best_parent_rate =3D 0, tmp_parent =
=3D *parent;
> >>  	unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
> >>  	unsigned long _n, _k, _m;
> >>
> >> @@ -28,12 +28,29 @@ static unsigned long ccu_nkm_find_best(unsigned lo=
ng parent, unsigned long rate,
> >>  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
> >>  				unsigned long tmp_rate;
> >>
> >> -				tmp_rate =3D parent * _n * _k / _m;
> >> +				if (parent_hw) {
> >
> > NKM clocks always have a parent
> >
> > You should test if the CLK_SET_RATE_PARENT flag is set.
>=20
> ccu_nkm_find_best is called in the following two situations:
>  a. from ccu_nkm_set_rate when setting the rate
>  b. from ccu_nkm_round_rate when determining the rate
>=20
> In situation a. we never want ccu_nkm_find_best to try different parent
> rates because setting the parent rate is a done deal (at least that's my
> understanding).
>=20
> In situation b. we only want ccu_nkm_find_best to try different parent
> rates when, as you mentioned, the CLK_SET_RATE_PARENT flag is set.

It doesn't really matter though. The output of that function must be
stable and must return the same set of factors and parent rate for a
given target rate.

So you can call it as many times as you want, it doesn't really matter.

> So, what this patch does, it provides a NULL pointer as parent_hw when
> we don't want ccu_nkm_find_best to try alternative parent rates.

At best, the argument is misleading then. You're not passing a pointer
to the parent, you're telling it whether it should look for other
parents or not. And it's not a pointer, it's a boolean.

> Is it ok if I add a comment to ccu_nkm_find_best that explains the
> function and explicitly also the parameters?

Sure

> I also thought about using two different functions for the two
> situations. I have no strong opinion which is better.
>=20
> However, I don't think we should hand over the flags to this function,
> because we'd still only need to provide the parent_hw if we want to
> find the optimal parent rate, so having two parametes for the same
> purpose seems redundant. Unless, there is a rule to not use NULL
> pointers.

Again, the behaviour must be stable across all calling sites.

> >
> >> +					// We must round up the desired parent rate, because the
> >> +					// rounding down happens when calculating tmp_rate. If we
> >> +					// round down also here, we'd round down twice.
> >> +					unsigned long optimal_parent =3D
> >> +							(rate * _m + (_n * _k - 1)) / _n / _k;
> >
> > I assume the addition of n * k - 1 is to round up, but I'm not sure we
> > should hack around like that.
> >
> > You should compute the ideal parent rate for a given set of timings, and
> > then just call round_rate on it. If the parent wants to round it one way
> > or another, that's the parent concern.
>=20
> I admit that the comment explaining this is not doing the complexity of
> this issue any justice. Let me try to explain:
>=20
> Let's say for our panel the optimal rate for pll-mipi is 449064000. The
> best closest we can get is 449035712 with a parent rate of 217714285
> (n=3D11, k=3D3, m=3D16).
>=20
> Eventually, ccu_nkm_find_best is going to be called with 449035712 as
> the rate. If we don't round up, like I proposend, but instead calculate:
>   optimal_parent =3D rate * m / n / k
> (which is, I think, what you you're proposing) leading to an optimal
> parent of 217714284 (!). We can't get 217714284 from the parent (we
> could get 217714285, but we're not asking for that) so the parent rounds
> down.
>=20
> To make things worse, this story continues for the new "best rate" as
> well.
>=20
> In the end, ccu_nkm_find_best claims:
>  - the optimal rate for 449064000 is 449035712 (parent=3D217714285, n=3D1=
1,
>    k=3D3, m=3D16)
>  - but ccu_nkm_find_best would claim that the optimal rate for 449035712
>    is 449018181 (parent=3D235200000, n=3D7, k=3D3, m=3D11)
>  - and finally, the optimal rate for 449018181 is 449018180
>    (parent=3D213818181, n=3D7, k=3D3, m=3D10)
>=20
> This doesn't seem right to me.
>=20
> But you're also right, in that we can't just always round up. In a
> hypothetical example that we request a parent rate of 450000000. With
> rounding up, we'd get an optimal parent rate of 218181819 for n=3D11, k=
=3D3,
> m=3D16. And let's now further claim that the parent could provide exactly
> that rate, we'd end up with a rate of 450000001. So, we'd overshoot,
> which (currently) is not acceptable.
>=20
> Hmm... I currently can't think of a clever way to solve this other than
> this:
>=20
>     optimal_parent =3D (rate * _m + (_n * _k - 1)) / _n / _k;
>     tmp_parent =3D clk_hw_round_rate(parent_hw, optimal_parent);
>     tmp_rate =3D tmp_parent * _n * _k / _m;
>     if (tmp_rate > rate) {
>         optimal_parent =3D rate * m / n / k
>         tmp_parent =3D clk_hw_round_rate(parent_hw, optimal_parent);
>         tmp_rate =3D tmp_parent * _n * _k / _m;
>     }
>     if (tmp_parent > optimal_parent)
>         continue;
>=20
> This seems ugly, but at least it should work in all cases. Any opinions?

Again, you shouldn't work around the issue.

It's very simple really: you already computed the optimal parent rate,
you ask the parent to compute whatever is closest to that optimal parent
rate.

It's the parent responsibility now. It's the parent decision to figure
out what "the closest" means, if it can change rate, if it has any range
limitation, etc. You can't work around that.

What you actually want there is the parent to actually provide the
closest rate, even if it means overshooting. That's fine, we have a flag
for that: CLK_(MUX|DIVIDER)_ROUND_CLOSEST. We just need to set it on the
parent and be done with it.

Maxime

--ewqo76xruqzoduop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIcNOAAKCRDj7w1vZxhR
xYwOAP9dhvoHhy6yorQXLvTbpuXa+NqMXxFKcE4OlTMaJfnnKgD9GDb3X+024tBw
suArvrgmBFZQmQMpdcypFxYMx2WX1Ak=
=/ihT
-----END PGP SIGNATURE-----

--ewqo76xruqzoduop--
