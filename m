Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609C72546D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjFGGit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjFGGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:38:46 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C0410C3;
        Tue,  6 Jun 2023 23:38:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 819F432006F5;
        Wed,  7 Jun 2023 02:38:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Jun 2023 02:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686119923; x=1686206323; bh=l0
        vXXY95syvCk1Dxy+Bo5t1mcRUMYlKrndUydypu8sI=; b=GJHiQ0c3OhGsZx8SlD
        uTXfcMnULlyNjrLA0NC9ey8gQfsFcrTDJW5hVrJLW3n0e6AkLS+aYHEZZpsUoKXg
        TwRysqEmLbj1cnjYcIbqXzuRTL+VACG2C3RGmEmzp+hKKekmlc5DXT5TEgrpg2CW
        3W/Hs/pgWq2EYKLDgWYOhha+JUFfAY3RCO/QGLNCG5D/bXyzIcFDw9dNgZkJ9nN9
        c1kn0NJG6H2JbD+57DkKH5A+27HzCQFLzUBU0v+6pLwkRnCzoTVlOjoqCjp9x6Uu
        u6xLNjhCtxlXQqwHTFXyN2m7UxzKNA/EZUM0Eii64JdcEIFzXUpOUbWEnD+aMd5h
        V4vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686119923; x=1686206323; bh=l0vXXY95syvCk
        1Dxy+Bo5t1mcRUMYlKrndUydypu8sI=; b=M9mAnHYHjrlZmI9833eqLN1sdIMqY
        qqmdqcg8D5TmVN06BDSp4nk76U2hXz8Ti7jwLW0wDwThGt23dLeFFTSncrvdFEGl
        eHyh9KM/X+2/yeSS3DRSOK6T/PbcT/0BJo2Te8FjjYR+vuZes3QHMLzl1CAgHsZd
        GMRta+wsRTrsXaDDwi7J99R8wPWjjJpQXieJYhWHLOsOFsVRwq1R+jbPk5GxO6ej
        2r6NvUlGHWiBPUmCm2fyUVGBRDMWwgstm50++X0X24tXy1pZu9/x8vK7FQ1rt0oH
        6YqjMYKSljFafWULdyfU8OOAnLBysMQB6y7CFFDns3mEndWz7Va0xGqyw==
X-ME-Sender: <xms:8iWAZGUbnh_H6-Bq5D19fjuGrgXRJns04CVTG9VAm-bXsScEklq-GA>
    <xme:8iWAZCmEAKIjq50d8hA39KOCaKiibsbJzv41FAZ4do4wgbtXUJu6zmBqGXEhqBzMl
    Xs9ur6wWIGAsVkwzkM>
X-ME-Received: <xmr:8iWAZKZzIcyTqUYmA6go58ahuoLSVOZcJAHypnagGfslZwpsuGbcpEyKYilEWATCDRcplh1n9pRizwVBPsbEdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtfedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8iWAZNXNEM5xZIz_7xay0oWm82X4SWSqSfwszVYB6ZMUE5j3aoEQTw>
    <xmx:8iWAZAnGtIh6PdoQ1hNNcynrPw6e6Fa2roF6-IHdV06WsCkX-L578w>
    <xmx:8iWAZCcEF36piLPPj-8snJt1C3I_BDGWHL_q8WakY3T1QfZYMV4PBg>
    <xmx:8yWAZJfs7Mttgt9ACKom2onP7SddJGiFeiYaJo4VlII8QB9cFCJm5g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 02:38:41 -0400 (EDT)
Date:   Wed, 7 Jun 2023 08:38:39 +0200
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
Message-ID: <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fnkspghtkneaqrxj"
Content-Disposition: inline
In-Reply-To: <20230605190745.366882-2-frank@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fnkspghtkneaqrxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 09:07:44PM +0200, Frank Oltmanns wrote:
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
>  drivers/clk/sunxi-ng/ccu_nkm.c | 40 ++++++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nk=
m.c
> index a0978a50edae..c71e237226f2 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -16,10 +16,10 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
> =20
> -static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned lo=
ng rate,
> -				       struct _ccu_nkm *nkm)
> +static unsigned long ccu_nkm_find_best(unsigned long *parent, unsigned l=
ong rate,
> +				       struct _ccu_nkm *nkm, struct clk_hw *parent_hw)
>  {
> -	unsigned long best_rate =3D 0;
> +	unsigned long best_rate =3D 0, best_parent_rate =3D 0, tmp_parent =3D *=
parent;
>  	unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
>  	unsigned long _n, _k, _m;
> =20
> @@ -28,12 +28,29 @@ static unsigned long ccu_nkm_find_best(unsigned long =
parent, unsigned long rate,
>  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
>  				unsigned long tmp_rate;
> =20
> -				tmp_rate =3D parent * _n * _k / _m;
> +				if (parent_hw) {

NKM clocks always have a parent

You should test if the CLK_SET_RATE_PARENT flag is set.

> +					// We must round up the desired parent rate, because the
> +					// rounding down happens when calculating tmp_rate. If we
> +					// round down also here, we'd round down twice.
> +					unsigned long optimal_parent =3D
> +							(rate * _m + (_n * _k - 1)) / _n / _k;

I assume the addition of n * k - 1 is to round up, but I'm not sure we
should hack around like that.

You should compute the ideal parent rate for a given set of timings, and
then just call round_rate on it. If the parent wants to round it one way
or another, that's the parent concern.

Maxime

--fnkspghtkneaqrxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIAl7wAKCRDj7w1vZxhR
xerlAQDWr/yez5kV9pcQ2Kr1uzw/lNbRaL9QI9UVILrM/4qy1wD9Hl/9uc6F2Lkh
OeHo+WolA+trnRWUCbw5TGyF2XUgPwk=
=SKoZ
-----END PGP SIGNATURE-----

--fnkspghtkneaqrxj--
