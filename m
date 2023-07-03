Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2B7455F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGCHZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGCHZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:25:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72FAD1;
        Mon,  3 Jul 2023 00:24:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2685D5C01CE;
        Mon,  3 Jul 2023 03:24:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jul 2023 03:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688369096; x=1688455496; bh=H0
        Xy0Yu9X8vLIsYJbRHAAja9rOoKpIDhO3QwL7Cj2wA=; b=XL6HzDf6k9S+zqSW/4
        ev8StrgTGxYnq0JRQ6srPjcMVEMIojgLvBz2oc5cIZfTIzu0mlLPE50hF/xfH6jW
        Losxn9ZlLkUefEkEd0EP/NRh7OZUpIdtrUeP/mxtqcGEFtZ5ZbcEX0LOj146cmtQ
        wor0SzqfzDnAiZ4x0TKvWWO3olGjFYYzOZiS6lGEjNHuQN/n5bQB4Qki/ICv/mPx
        1gpO45Bk6Ie+XlXgl+05UhNr2q3ehxyJ8+q/exbu32ye2SdcG/amVmU22GwkjZVp
        DyI2b09i1tVICQsGGFVyTPRbeaCG1jXAx327va+X5hLjdtyhii+e1pNBiCfI7bvd
        hJYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688369096; x=1688455496; bh=H0Xy0Yu9X8vLI
        sYJbRHAAja9rOoKpIDhO3QwL7Cj2wA=; b=nm7EgyZzXA6Xcbmoav6ghTTG4zmIG
        hNJK50QLkt3IQVtsd2ZO30JTahW+I9Ltg+R8Ps54Un3Lif7Fg+23jQ6blvUXoDhQ
        xQ0FFhpp1gRfIPLXTy/SdaKEcJD29kOZV9T/1jKzOsI27ZDIgxI6BmoSCAdD+knE
        sIM0W4WxPXCS4MroYSmK2MJ31EamOQGEloYFapFN7yYtIGGMI2GAEvv5/1gdN2Mx
        Kt/OpHVKhn0ZqKSGUL8wJ14hiqsdcU0E7q8Rl+RiWkvh1icSgMifVmeP3JLi3hNL
        JwSzye4+9AFTLaTdiOrITH30rCy+td6nCDv1hb9i2tz4W5OlmonilSGLg==
X-ME-Sender: <xms:x3eiZAqAF9_hPvDJ0PCEGXOniImScQqp2b-2NwaLd46Y4Zgod4n5NA>
    <xme:x3eiZGqcOBciNzmASe5zV4nGuylbAe19jdvh-wZ73PhWvMCP-jJL4QTrTdM-sxSNY
    DjNH70D15ojVyWWKB8>
X-ME-Received: <xmr:x3eiZFMtutQZ5bkAVHUZUpEZVmsAhP3-oh8eRHSKZuMVJ4FAFvets9NF-UwrJd9YBOjU5l2oHmASjgKUCcme-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:x3eiZH5KZd9w0hCiZ8OX7VYjSQT7zcv8Li6qE1EfeIhyas0xp0upGg>
    <xmx:x3eiZP6veUurCJdRfo3MKGs-foSU579-68sNxTSKP-5jCLDr51sMYw>
    <xmx:x3eiZHi__Hm8K8rAYQLZ3OFhsDX-FP1zSNZMSF05s3km57Qn4cIEyg>
    <xmx:yHeiZMw9xKzvGUvBW6GL7WHfewieBFStoieQVB03kev271V6XoQtgA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 03:24:55 -0400 (EDT)
Date:   Mon, 3 Jul 2023 09:24:53 +0200
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
Subject: Re: [PATCH v3 4/8] clk: sunxi-ng: nm: Support finding closest rate
Message-ID: <i3vd7aetybulocuxzs3qnymc2o375bc6bbihnvzqbwt2kf6d5l@cohvb7vxl6q2>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-4-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gplpri55xzlqeca"
Content-Disposition: inline
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-4-46dcb8aa9cbc@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5gplpri55xzlqeca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 02, 2023 at 07:55:23PM +0200, Frank Oltmanns wrote:
> Incorporate a new function, ccu_nm_find_best_closest, that selects the
> closest possible rate instead of the closest rate that is less than the
> requested rate. Utilizing rational_best_approximation has the additional
> effect of boosting performance in clock rate selection.
>=20
> In cases where the CCU_FEATURE_CLOSEST_RATE flag is set, use
> ccu_nm_find_best_closest instead of the original ccu_nm_find_best
> function.
>=20
> Extend the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX to allow
> selecting additional features and update all usages of the macro with no
> additional flags set.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c |  6 ++++--
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c   |  3 ++-
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c  |  6 ++++--
>  drivers/clk/sunxi-ng/ccu_nm.c         | 23 +++++++++++++++++++++--
>  drivers/clk/sunxi-ng/ccu_nm.h         |  6 ++++--
>  5 files changed, 35 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
> index a139a5c438d4..ebfab1fdbb96 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -80,7 +80,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_vid=
eo0_clk, "pll-video0",
>  						297000000,	/* frac rate 1 */
>  						BIT(31),	/* gate */
>  						BIT(28),	/* lock */
> -						CLK_SET_RATE_UNGATE);
> +						CLK_SET_RATE_UNGATE,
> +						0);		/* features */
> =20
>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
>  					"osc24M", 0x018,
> @@ -143,7 +144,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_v=
ideo1_clk, "pll-video1",
>  						297000000,	/* frac rate 1 */
>  						BIT(31),	/* gate */
>  						BIT(28),	/* lock */
> -						CLK_SET_RATE_UNGATE);
> +						CLK_SET_RATE_UNGATE,
> +						0);		/* features */
> =20
>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
>  					"osc24M", 0x038,
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/c=
cu-sun8i-h3.c
> index bfebe8dbbe65..1e2669648a24 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -76,7 +76,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_vid=
eo_clk, "pll-video",
>  						297000000, /* frac rate 1 */
>  						BIT(31),   /* gate */
>  						BIT(28),   /* lock */
> -						CLK_SET_RATE_UNGATE);
> +						CLK_SET_RATE_UNGATE,
> +						0);        /* features */
> =20
>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
>  					"osc24M", 0x0018,
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-r40.c
> index 31eca0d3bc1e..63907b86ce06 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> @@ -82,7 +82,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_vid=
eo0_clk, "pll-video0",
>  						297000000,  /* frac rate 1 */
>  						BIT(31),    /* gate */
>  						BIT(28),    /* lock */
> -						CLK_SET_RATE_UNGATE);
> +						CLK_SET_RATE_UNGATE,
> +						0);         /* features */
> =20
>  /* TODO: The result of N/M is required to be in [8, 25] range. */
>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
> @@ -169,7 +170,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_v=
ideo1_clk, "pll-video1",
>  						297000000,  /* frac rate 1 */
>  						BIT(31),    /* gate */
>  						BIT(28),    /* lock */
> -						CLK_SET_RATE_UNGATE);
> +						CLK_SET_RATE_UNGATE,
> +						0);         /* features */
> =20
>  static struct ccu_nkm pll_sata_clk =3D {
>  	.enable		=3D BIT(31),
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> index c1fd11542c45..97d8d9e3255c 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -6,6 +6,7 @@
> =20
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> +#include <linux/rational.h>
> =20
>  #include "ccu_frac.h"
>  #include "ccu_gate.h"
> @@ -56,6 +57,18 @@ static unsigned long ccu_nm_find_best(unsigned long pa=
rent, unsigned long rate,
>  	return best_rate;
>  }
> =20
> +static unsigned long ccu_nm_find_best_closest(unsigned long parent, unsi=
gned long rate,
> +				      struct _ccu_nm *nm)
> +{
> +	unsigned long best_rate =3D 0;
> +
> +	rational_best_approximation(rate, parent, nm->max_n, nm->max_m, &nm->n,=
 &nm->m);
> +
> +	best_rate =3D ccu_nm_calc_rate(parent, nm->n, nm->m);
> +
> +	return best_rate;
> +}
> +
>  static void ccu_nm_disable(struct clk_hw *hw)
>  {
>  	struct ccu_nm *nm =3D hw_to_ccu_nm(hw);
> @@ -159,7 +172,10 @@ static long ccu_nm_round_rate(struct clk_hw *hw, uns=
igned long rate,
>  	_nm.min_m =3D 1;
>  	_nm.max_m =3D nm->m.max ?: 1 << nm->m.width;
> =20
> -	rate =3D ccu_nm_find_best(*parent_rate, rate, &_nm);
> +	if (nm->common.features & CCU_FEATURE_CLOSEST_RATE)
> +		rate =3D ccu_nm_find_best_closest(*parent_rate, rate, &_nm);
> +	else
> +		rate =3D ccu_nm_find_best(*parent_rate, rate, &_nm);

So this ends up creating a completely different path and algo for the
"closest" case, and I'm not super comfortable with that.

I think you can simplify this a bit by creating a comparison function
that will take two rates and a set of flags and will behave differently
depending on whether CCU_FEATURE_CLOSEST_RATE is set, like
mux_is_better_rate is doing for example.

You'll also avoid code duplication that way that can be shown a bit in
you subsequent patches.

> =20
>  	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /=3D nm->fixed_post_div;
> @@ -210,7 +226,10 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsign=
ed long rate,
>  					   &_nm.m, &_nm.n);
>  	} else {
>  		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
> -		ccu_nm_find_best(parent_rate, rate, &_nm);
> +		if (nm->common.features & CCU_FEATURE_CLOSEST_RATE)
> +			ccu_nm_find_best_closest(parent_rate, rate, &_nm);
> +		else
> +			ccu_nm_find_best(parent_rate, rate, &_nm);
>  	}
> =20
>  	spin_lock_irqsave(nm->common.lock, flags);
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
> index 2904e67f05a8..a3825c4e8d42 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nm.h
> @@ -116,7 +116,8 @@ struct ccu_nm {
>  						 _frac_en, _frac_sel,	\
>  						 _frac_rate_0,		\
>  						 _frac_rate_1,		\
> -						 _gate, _lock, _flags)	\
> +						 _gate, _lock, _flags,	\
> +						 _features)		\
>  	struct ccu_nm _struct =3D {					\
>  		.enable		=3D _gate,				\
>  		.lock		=3D _lock,				\
> @@ -129,7 +130,8 @@ struct ccu_nm {
>  		.max_rate	=3D _max_rate,				\
>  		.common		=3D {					\
>  			.reg		=3D _reg,				\
> -			.features	=3D CCU_FEATURE_FRACTIONAL,	\
> +			.features	=3D CCU_FEATURE_FRACTIONAL |	\
> +					  _features,	\

It's a bit odd to me that some features are set by the macro function,
and some are passed as an argument. I'm fine with either but we
shouldn't allow both.

It looks like (for NM clocks at least) we would only need the round
closest flag for pll-video0, so we could maybe just add a new variant of
the macro which will also reduce the changes in that patch.

Maxime

--5gplpri55xzlqeca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKJ3xQAKCRDj7w1vZxhR
xVCAAQCmGK4SJTQ2i8fvU9APHrYf48nQoiKTmT23j4Ne8f21HgD+KXH4vzVbWCsB
DkOMXMXqCF3DsKB7KKUJdCjoiUsbFAs=
=opIG
-----END PGP SIGNATURE-----

--5gplpri55xzlqeca--
