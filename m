Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8941074562F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGCHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGCHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:33:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD404CC;
        Mon,  3 Jul 2023 00:33:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 54C165C01DE;
        Mon,  3 Jul 2023 03:33:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Jul 2023 03:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688369618; x=1688456018; bh=J8
        flT4uVwabCGQeQmBFkpV16dPIUdp4ZLz6nwezejdw=; b=T0MWScLTzpFcrejycr
        kvRVo8BePOpUwszcGM5KaDPNKfVn5VXVo+5CJeJtdxBkiwcjzqlz1GMBJ8/l5nvS
        eHLRnL3tTWgX1ddT5Y5f96dNo9ZdZ2hp+F15sGa/MtiUMj+RzoVDSC7r+IWuE0Kx
        a7OnZOonq4TLp5ST2La6aRGOHMaf/HN00iudcQcCRKIiTWr222pZxJJs7WLLAs7A
        UpFXU0k4D/7IwO3QMcXvYcOWd2SX2DJxrQimAOZag1JXtfQb6FqCOgCgOS3IrZCs
        VfRY3MnSZ9K4A7ZZfYvjngqI2dsUqUV4qTgO9OrHYaumP/C5aTp4+lrBPR+R4bK6
        dqYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688369618; x=1688456018; bh=J8flT4uVwabCG
        QeQmBFkpV16dPIUdp4ZLz6nwezejdw=; b=Sb7Ype4TPScCOigmMRlteOWq1esYz
        fVXZL0hrTj0t6TzO1x/OD/588IIOJhvjqSsHrqU46OUG/SyCH0myxRHkhwagnkJs
        KYP94O55C3I+bPJPHNut19abhWoJx2d0kQE37jpKhyMyw5fMi9frkcXqfjU8suZA
        lg26TohbrOaoNq8r9OD5Zq9rqVGilHtR7RXe8rRqzyjXd4yyRlE3dol252kyr/tl
        cWUtjbui2qKjrhol7gNhljh3l1tPWP2MzTm2Gs0O/WMql3bh1jON19/f17NxX9gr
        0eMs5O39aPa0BaHjfKcCqpmp20wjEIwfB7MZDRVCCPETcWepHkqbjtsHg==
X-ME-Sender: <xms:0nmiZB8Kol-3sh7Zs2wbgyYgnMM3_LTE4ZZh-DUpsas3dPTOUzpthg>
    <xme:0nmiZFtFoMvLfQuh13W-bnwjO4zJWDrrxAtlln8CXuZjZfuIe_ZFdxpjQ7fSS8_kI
    M423N7dQf-tWLNK9EI>
X-ME-Received: <xmr:0nmiZPCh0YKF1TgAdGI3gvKd-Bm7vfElRGOwrSwPKM-eqSiBM6CmFKeUZKQzDUUhWXx4dHjNi-pA49U_m3lG2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0nmiZFf_4rjFoWLhMmwIUuA_ABqyo4uSxJm9eDdAxRvhUAOEd51BrQ>
    <xmx:0nmiZGOmhrwDaC67JBmt09YUOJEDdxndVVbAExyrsqhF28e1Ns9Meg>
    <xmx:0nmiZHlm_PyNmh3iSZ4x7pur2Rl-agXBbUDuXhfX7CJBdNQ4_Tk2BA>
    <xmx:0nmiZHGXvwDI8CWeUU6rjJ4whkdXRtxSfLMXPe_OcykgeYTUBavzRg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 03:33:37 -0400 (EDT)
Date:   Mon, 3 Jul 2023 09:33:35 +0200
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
Subject: Re: [PATCH v3 5/8] clk: sunxi-ng: nkm: Support finding closest rate
Message-ID: <bdsz257w7jsm6ll6asi3cc422seqek7atkuz6ij6e7xiykhtrs@uotz2efqjaks>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ejboz6oq3z7jtb3u"
Content-Disposition: inline
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ejboz6oq3z7jtb3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 07:55:24PM +0200, Frank Oltmanns wrote:
> When finding the best rate for a NKM clock, consider rates that are
> higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
> set.
>=20
> Accommodate ccu_mux_helper_determine_rate to this change.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_mux.c | 23 +++++++++++++++-----
>  drivers/clk/sunxi-ng/ccu_nkm.c | 48 +++++++++++++++++++++++++++++++-----=
------
>  2 files changed, 54 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mu=
x.c
> index 1d557e323169..8594d6a4addd 100644
> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> @@ -113,7 +113,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *=
common,
>  	}
> =20
>  	for (i =3D 0; i < clk_hw_get_num_parents(hw); i++) {
> -		unsigned long tmp_rate, parent_rate;
> +		unsigned long tmp_rate, parent_rate, best_diff =3D ULONG_MAX;
>  		struct clk_hw *parent;
> =20
>  		parent =3D clk_hw_get_parent_by_index(hw, i);
> @@ -139,10 +139,23 @@ int ccu_mux_helper_determine_rate(struct ccu_common=
 *common,
>  			goto out;
>  		}
> =20
> -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> -			best_rate =3D tmp_rate;
> -			best_parent_rate =3D parent_rate;
> -			best_parent =3D parent;
> +		if (common->features & CCU_FEATURE_CLOSEST_RATE) {
> +			unsigned long tmp_diff =3D req->rate > tmp_rate ?
> +						 req->rate - tmp_rate :
> +						 tmp_rate - req->rate;
> +
> +			if (tmp_diff < best_diff) {
> +				best_rate =3D tmp_rate;
> +				best_parent_rate =3D parent_rate;
> +				best_parent =3D parent;
> +				best_diff =3D tmp_diff;
> +			}
> +		} else {
> +			if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> +				best_rate =3D tmp_rate;
> +				best_parent_rate =3D parent_rate;
> +				best_parent =3D parent;
> +			}
>  		}
>  	}

Like I said in the previous patch, I think we could do something like:

bool ccu_is_better_rate(struct ccu_common *common,
     			unsigned long target_rate,
			unsigned long current_rate,
			unsigned long best_rate)
{
	if (common->features & CCU_FEATURE_CLOSEST_RATE)
		return abs(current_rate - target_rate) < abs(best_rate - target_rate);

	return current_rate <=3D target_rate && current_rate > best_rate;
}

Then, the code above would look like:

if (ccu_is_better_rate(common, req->rate, tmp_rate, best_rate)) {
	best_rate =3D tmp_rate;
	best_parent_rate =3D parent_rate;
	best_parent =3D parent;
}

It's simpler, and we can share it easily between drivers.
Maxime

--ejboz6oq3z7jtb3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKJ5zwAKCRDj7w1vZxhR
xdGRAQCfdSMP0AmxDYNOFCwEyrvdngVMFpzQiw2Gv4Ylt8jloQD9H+OntEHbw5su
pLfUl0NLhCH+MeIH67M6dKsWNVwEsws=
=V/JR
-----END PGP SIGNATURE-----

--ejboz6oq3z7jtb3u--
