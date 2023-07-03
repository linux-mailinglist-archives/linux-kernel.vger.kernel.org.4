Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20153745638
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGCHiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGCHiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:38:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5EEC1;
        Mon,  3 Jul 2023 00:38:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E67DC5C031A;
        Mon,  3 Jul 2023 03:38:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Jul 2023 03:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688369930; x=1688456330; bh=k0
        LaDAb48FB0BYS1E8TEQR4dsp8mGlbiWW81yfDkHCw=; b=mvjiZmHgQXm5BDVBRT
        tgLvfIc3Oesmxeu0XNV/GKB400iYPkX2I5RS798HmwFKrXjUNw7TJqqI+dDkD2nd
        66J5H0g0P/6hA/T7WoylPesE9kXAv7Hn7H5FC4jlmHNgapaMjLLvH2TVsOGoHekS
        TQbj7Tcbx6hpwc8Z78b/CQfxNaXgFlm6HVG8tydIZjNjCRk7LQy2yNYCkFR96ky6
        ZlbcZ3ka8VhTrujZ9iZ/fhE0nDVRzOxidjE/KNmdh6O9/cmJHdr08075/xSSxeoZ
        W1DZVhHeJkm+mrljtRROhMc4QXGKzdKG6yCQ/nE774K1Utm/Cd4d3IB/y9nAqD2I
        7dSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688369930; x=1688456330; bh=k0LaDAb48FB0B
        YS1E8TEQR4dsp8mGlbiWW81yfDkHCw=; b=Ce7zMkfPFWDqoWxf7AkyjMNWyhTYg
        5VD/n97hJdQgiwzJKIUBH4wvla0QNZUF7OvzTGWqaIBYQWtFkBKp2QFysXqcfk79
        vFXumi3qzx7dqDP5FhAkTl/2GLkNsW9gLYWRbmn5VL71rMyNm2iXXDl0uVy3t92X
        n219wTHuUSRWMCaIWMv5GlBVqjGw5MU4wtggQRylBk15ftbLc5Pn+8yhj9VC1qtu
        Irfdm2o6LX7rLzZfYKV6AeZmlQ7BE0TCNn+VsetUTcUMJQHRHWG1RUp3oHGKagxG
        LQalvVYEmR/Nhf5WnbwVkOMVsFYmpV/hkD5q0xqcGMsATdCHibTQwb5Rw==
X-ME-Sender: <xms:CnuiZLmuvdIdCSKAambpaVw5JZptsX39f2pB7UN8yZ65TIZ3fGc5fg>
    <xme:CnuiZO22P-4hfu4NkpvgRQqIeke69wE7NnY53tLD4a9WOAjmb8BOIvzwi56nMzCu5
    qVYqq958_zMhzpvygA>
X-ME-Received: <xmr:CnuiZBopVs8QAEAPnAGcNDDuYAiOWD9IHNZS9nB0NLtBvt9IzZ_LE9LZu1QVZeiYMhgW6K7dWDR5x4ZUHgNQ9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:CnuiZDlIeGVDuu2yo6nO1nXn1gDbxd0q9SHTpgcDolgD897RiAD07w>
    <xmx:CnuiZJ266YPz8nqpuOrrNR_AEFxwox3u25xuUx3sDoXi4SSpIupnpg>
    <xmx:CnuiZCsf0Nf7BhGh3oyyJ2LF1Pr6kndmgaf700B7Y39_eDgI9zNCPA>
    <xmx:CnuiZCsuWFGMJIo6Kw9pxBtyYBXAxdFDEVSvkIZKnoPbdFaov8qBfQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 03:38:49 -0400 (EDT)
Date:   Mon, 3 Jul 2023 09:38:48 +0200
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
Subject: Re: [PATCH v3 6/8] clk: sunxi-ng: mux: Support finding closest rate
Message-ID: <b7gnap57aajkbhbbcbgallvqjdc7nzppjjwnancgmm5ibmhdaq@cftau72qyjdu>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-6-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wsqxsxlujfkioer"
Content-Disposition: inline
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-6-46dcb8aa9cbc@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wsqxsxlujfkioer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 07:55:25PM +0200, Frank Oltmanns wrote:
> When finding the best rate for a mux clock, consider rates that are
> higher than the requested rate by introducing a new clk_ops structure
> that uses the existing __clk_mux_determine_rate_closest function.
> Furthermore introduce an initialization macro that uses this new
> structure.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_mux.c | 13 +++++++++++++
>  drivers/clk/sunxi-ng/ccu_mux.h | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mu=
x.c
> index 8594d6a4addd..49a592bdeacf 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -264,6 +264,19 @@ static unsigned long ccu_mux_recalc_rate(struct clk_=
hw *hw,
>  					   parent_rate);
>  }
> =20
> +const struct clk_ops ccu_mux_closest_ops =3D {
> +	.disable	=3D ccu_mux_disable,
> +	.enable		=3D ccu_mux_enable,
> +	.is_enabled	=3D ccu_mux_is_enabled,
> +
> +	.get_parent	=3D ccu_mux_get_parent,
> +	.set_parent	=3D ccu_mux_set_parent,
> +
> +	.determine_rate	=3D __clk_mux_determine_rate_closest,
> +	.recalc_rate	=3D ccu_mux_recalc_rate,
> +};
> +EXPORT_SYMBOL_NS_GPL(ccu_mux_closest_ops, SUNXI_CCU);
> +

This is also a bit inconsistent with the other clocks: most (all?) of
them will simply handle this through a flag, but this one requires a new
set of clk_ops as well?

I think we should create our own wrapper here around
__clk_mux_determine_rate and either call
__clk_mux_determine_rate_closest or __clk_mux_determine_rate depending
on the state of the flags, or call __clk_mux_determine_rate_flags with
the proper flags set for our clock.

The former is probably slightly simpler.

>  const struct clk_ops ccu_mux_ops =3D {
>  	.disable	=3D ccu_mux_disable,
>  	.enable		=3D ccu_mux_enable,
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mu=
x.h
> index 2c1811a445b0..c4ee14e43719 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.h
> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
> @@ -46,6 +46,22 @@ struct ccu_mux {
>  	struct ccu_common	common;
>  };
> =20
> +#define SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(_struct, _name, _parents, =
_table,	\
> +				     _reg, _shift, _width, _gate,	\
> +				     _flags)				\
> +	struct ccu_mux _struct =3D {					\
> +		.enable	=3D _gate,					\
> +		.mux	=3D _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),	\
> +		.common	=3D {						\
> +			.reg		=3D _reg,				\
> +			.hw.init	=3D CLK_HW_INIT_PARENTS(_name,	\
> +							      _parents, \
> +							      &ccu_mux_closest_ops, \
> +							      _flags),	\
> +			.features	=3D CCU_FEATURE_CLOSEST_RATE,	\
> +		}							\
> +	}
> +

I'm fine with that one, but like we discussed on the NM (I think?) patch
already, this creates some clocks and macros that will use the feature
as a flag, and some will encode it into their name.

Given that we need it here too, I'm really inclined to prefer what you
did there, and thus create a new macro for pll-video0 instead of
modifying the existing one.

Maxime

--7wsqxsxlujfkioer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKJ7CAAKCRDj7w1vZxhR
xX23AP9Gl3oPNcojRTw1oRa+afqZNM7B+cSe67xYnUYlA4vjVgD9GkW8rquZxUuO
0FrevYyTHNypFJAxk4AUScA3gapkoQQ=
=hog7
-----END PGP SIGNATURE-----

--7wsqxsxlujfkioer--
