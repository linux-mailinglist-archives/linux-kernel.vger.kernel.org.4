Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA44745599
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGCGr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGCGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:47:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F9E42;
        Sun,  2 Jul 2023 23:47:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A7535C0323;
        Mon,  3 Jul 2023 02:47:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 03 Jul 2023 02:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688366867; x=1688453267; bh=yh
        YIlwrlNmx9cPyTtHkCkT6NyvSnAi/Qkx6nM4nFrF4=; b=YdxQ0sYKUecOor8lkD
        6Y1cUg0pUMTXj/vitN1iFilMbKHJTzh5tMeiWYfqf4wkkYhd8O93FyNNMVBOOYQR
        nxc7Lnt+MKfi3Wpu9yjKTTLvROkTZQG7hfW+V2Y2ikdSnGrd1AcycpkaU/PKu8Vq
        uU1SqmXaxrVhahKjJBrr8oAxMkCyF0qule2WOB9JOdEywH5l5FhGnSjrZegcvrck
        JlMFTyTv0tR6u9MQq3dGUYQw6nPLXRP4j3UDiX3ZNSxc26ClI7BbNc2uC6FL7/sX
        +MtCFryogPR7BjmoSyWSYdey9kiklW4NmALOBXzbBa1+MIOav9V7kWWqFciWGsEy
        qc3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688366867; x=1688453267; bh=yhYIlwrlNmx9c
        PyTtHkCkT6NyvSnAi/Qkx6nM4nFrF4=; b=RHkxiFvVzeyR1NQXCoy4yTo0AnAjw
        1E51EW6CR6NGD3LE6a5da4PDnq+vkyoUMmBugs1GhgqZ+mK0dRGWpab5ApjG4tY/
        tmqqw8tiDV84t8kt261WnYWI7ONEYysTH6ZDa/fOxHUWkqxi/wouBOwCeHUrnPmG
        XJmcY+pKACF/hitqaZcHQnAgYfuOP6QiDN57INQKXx+Kr7rkq4AwwINFrdWGHdAQ
        y4gf9S8ky5mDrCxMVR6MOpa9g3jlzWDro1Cns17Plm7heAwraVYvxSSIUwjW8lxV
        TPTH6xfoVCjk+apJ+kgp8cNwWw/W2U+tbeqy8Xs9s3qojcl/TODY7pEUw==
X-ME-Sender: <xms:Em-iZB4VJnDg6ip8qvjs9_r0o3hWIKpY9Amkt0HoIThKkJN4V0eBlg>
    <xme:Em-iZO4Nzrr0b6xcW7Fv12rxLa58jp1RTr0YnRXnEMzvQ3CLVP-nmgNhcRlGrUXGs
    vnMFGt-DS_VBxsG9rY>
X-ME-Received: <xmr:Em-iZIcaCN1gjssa1hjd-aDXcECm2YtyeRSu3hIzZaDpEXn0cpnYgFtf-g2d1c7kcjbWP2JRQSv5HQx_CYg6hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Em-iZKIBoC9lX5EGKDyPD9xzv6N7yonigFJviUnflxjZv7l_WJyNZQ>
    <xmx:Em-iZFICNELvebND7meK204ttdvMaDxAref3LD3vBlie7CO0cRq4bQ>
    <xmx:Em-iZDxFuargu3e92O0B51kfI5JSBmvyJdGkIh02hwUZwnovHmZcvA>
    <xmx:E2-iZCDNx5S6eJE6AlvudjiUzjGj7NwzpXJLKlJtw8BEVlx8GsSH_Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 02:47:45 -0400 (EDT)
Date:   Mon, 3 Jul 2023 08:47:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] clk: sunxi-ng: nkm: consider alternative parent
 rates when determining rate
Message-ID: <uxa7smoywmh75pzmpipdqbctbza6gjlqke3v7j4ijpfc3k4jul@dcxwsiajoomb>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-1-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="crtkwlzzyg5ufkfz"
Content-Disposition: inline
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-1-46dcb8aa9cbc@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--crtkwlzzyg5ufkfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 02, 2023 at 07:55:20PM +0200, Frank Oltmanns wrote:
> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
> parent rate when determining a new rate.
>=20
> To find the best match for the requested rate, perform the following
> steps for each NKM combination:
>  - calculate the optimal parent rate,
>  - find the best parent rate that the parent clock actually supports
>  - use that parent rate to calculate the effective rate.
>=20
> In case the clk does not support setting the parent rate, use the same
> algorithm as before.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 48 ++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nk=
m.c
> index a0978a50edae..d83843e69c25 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -6,6 +6,7 @@
> =20
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> +#include <linux/math.h>
> =20
>  #include "ccu_gate.h"
>  #include "ccu_nkm.h"
> @@ -16,6 +17,44 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
>
> +static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned long *pa=
rent, unsigned long rate,
> +						       struct _ccu_nkm *nkm, struct clk_hw *phw)

The usual order in that driver (and Linux in general) would make the
clk_hw and nkm structure pointers first, and then the parent rate and
rate.

But something looks off to me: ccu_nkm_find_best_with_parent_adj takes a
pointer to the parent rate which makes sense since we're going to modify
it.

> +{
> +	unsigned long best_rate =3D 0, best_parent_rate =3D *parent, tmp_parent=
 =3D *parent;
> +	unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
> +	unsigned long _n, _k, _m;
> +
> +	for (_k =3D nkm->min_k; _k <=3D nkm->max_k; _k++) {
> +		for (_n =3D nkm->min_n; _n <=3D nkm->max_n; _n++) {
> +			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
> +				unsigned long tmp_rate;
> +
> +				tmp_parent =3D clk_hw_round_rate(phw, rate * _m / (_n * _k));
> +
> +				tmp_rate =3D tmp_parent * _n * _k / _m;
> +				if (tmp_rate > rate)
> +					continue;
> +
> +				if ((rate - tmp_rate) < (rate - best_rate)) {
> +					best_rate =3D tmp_rate;
> +					best_parent_rate =3D tmp_parent;
> +					best_n =3D _n;
> +					best_k =3D _k;
> +					best_m =3D _m;
> +				}
> +			}
> +		}
> +	}
> +
> +	nkm->n =3D best_n;
> +	nkm->k =3D best_k;
> +	nkm->m =3D best_m;
> +
> +	*parent =3D best_parent_rate;
> +
> +	return best_rate;
> +}
> +
>  static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned lo=
ng rate,
>  				       struct _ccu_nkm *nkm)

You haven't modified ccu_nkm_find_best though, and it still takes the
parent rate value.

>  {
> @@ -106,7 +145,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_h=
w *hw,
>  }
> =20
>  static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> -					struct clk_hw *hw,
> +					struct clk_hw *parent_hw,

(This should be another patch)

>  					unsigned long *parent_rate,
>  					unsigned long rate,
>  					void *data)
> @@ -124,7 +163,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_m=
ux_internal *mux,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *=3D nkm->fixed_post_div;
> =20
> -	rate =3D ccu_nkm_find_best(*parent_rate, rate, &_nkm);

parent_rate is a pointer, we were dereferencing it to pass its value to
ccu_nkm_find_best. All good so far.

> +	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
> +		rate =3D ccu_nkm_find_best(*parent_rate, rate, &_nkm);

Still passing by value

> +	else
> +		rate =3D ccu_nkm_find_best_with_parent_adj(parent_rate, rate, &_nkm, p=
arent_hw);

And passing the pointer there since it takes a pointer. Still good.

> =20
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /=3D nkm->fixed_post_div;
> @@ -159,7 +201,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsign=
ed long rate,
>  	_nkm.min_m =3D 1;
>  	_nkm.max_m =3D nkm->m.max ?: 1 << nkm->m.width;
> =20
> -	ccu_nkm_find_best(parent_rate, rate, &_nkm);
> +	ccu_nkm_find_best(&parent_rate, rate, &_nkm);

But here, we're passing a pointer to parent_rate to ccu_nkm_find_best,
while it's still supposed to take it by value?

Maxime

--crtkwlzzyg5ufkfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKJvDwAKCRDj7w1vZxhR
xTN7AQCLvDQbFJ/1zc3WcpwSgbfhRvIVtquRM80f05ahwnLJMQEAuHzzzqfWFsfi
PojksszR0ap9F1b/QbIqhSgaoXjQfAA=
=XoMd
-----END PGP SIGNATURE-----

--crtkwlzzyg5ufkfz--
