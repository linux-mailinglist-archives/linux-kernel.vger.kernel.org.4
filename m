Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564FC745B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGCLgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCLgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:36:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E520E3;
        Mon,  3 Jul 2023 04:36:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 573C55C00C9;
        Mon,  3 Jul 2023 07:36:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Jul 2023 07:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688384200; x=1688470600; bh=gC
        PCTITGz5GM2YGJzWq430teYe6K7ggXS69sZLriT6Y=; b=UD5WEj07kq+jJdbb6u
        4ITYqBYoYS8WRtPU/6GItkw2B7D1ABgPVbUVvgslxk2DKU4Ne73D3G66PamakVC6
        qqrMTDJp6u3xW0tQ42AlOBQ6gXWqTcrkEqkfWpZLlPWiKS2KiY+4vI3mwwii9YO/
        j6IhpFpoVpBn39oEhfV2uofHTYGzKNxfBGmAVQ/k/q6D7xWBETzEdkQkMMpVoX13
        iocG4gXHhQLuvSVCh4kpfej5ndxILrJnMe3k3sLYsjojo5XSydRWMK5Nwwb4YbCv
        rQmnrtIDFcRYSPxsE8yKvs5ho8RMBiXfwTNMZdJKQ3dYEHctXzWiEKLUm4XgIm+K
        8iPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688384200; x=1688470600; bh=gCPCTITGz5GM2
        YGJzWq430teYe6K7ggXS69sZLriT6Y=; b=WpGmTmfzj6tBKM0iXGSIEI67DZwMz
        o2pmh3gyl/ZNo/J/NfDuYErUSojQyvqeu3qGpCyqhtPCohDEN6DeoMLuZxhcvjmv
        I950bgMd2zigOa2dShioQv2eSJPhm77a2NFQgsKozan0dHMB+QHD8j22ANTe6nBm
        lwXDXnMAh4VreIR224yUFtlkDfcnr9SeVPecGPtkm8aBInu9zaLFoGiiasaaapj/
        HbhYqYvmgIh1QqdJcG1x6TLrT25fJx2bbqbk9tk4iTLYKvWgvzpz2p0Iw+jouRZw
        2ONSomKDzSjOT7N+TTMCBvqNQdXVx4uEThm/iQr0q4twZetZaVYNInm0w==
X-ME-Sender: <xms:xrKiZJ3EWOj888g59jDs_bDGiezsC68ab1WcaoBpd5CL7dUCWTzjKA>
    <xme:xrKiZAHhIl1LyBu9yyVCio50FO-Mk2E0UXtmg7jKGOkcxt9tHaxLj2cTXoyivOX3K
    xTfef3yNvDY3NUA0Mc>
X-ME-Received: <xmr:xrKiZJ4LTUBlsE92sz9gQ-TgfMTeqZ9oVMAmZ3eGp1eGIIctqK76-rid3t3O5LyDGVEgj1Z-9ceC-G-lVx8usQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeetkefg
    leefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:x7KiZG1SyZfK1-t6hFDGatW3cMTFtw_cCHf79rk1FJ26QvHHxpb7Uw>
    <xmx:x7KiZMHKhT84G0bWe3uRZDSiDaedmnmti36uepaBXwQ_1f5fIkamgA>
    <xmx:x7KiZH9W8wg_33ql68uK3dAadZfZr3MY7RMiGkAozIiIpP5JxrZdww>
    <xmx:yLKiZE-PaPyVUGmKPVkBFgZacxUN2cEzjCkGJZG6tSKZSD5FBpIa-w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 07:36:38 -0400 (EDT)
Date:   Mon, 3 Jul 2023 13:36:36 +0200
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
Message-ID: <3ikbk67av3j2drphpwncbvfzbd6jw4ytcdri2sn3tmnsny4r5h@db3uxmavz6n2>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc@oltmanns.dev>
 <87wmzhsbu0.fsf@oltmanns.dev>
 <zvxviyera3zxe2ro5ej52vz2o2vrinu6zo7osddojbys4tuqhd@3f2okcbpf5jr>
 <87jzvhs740.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gegykcvgx7vzvvkm"
Content-Disposition: inline
In-Reply-To: <87jzvhs740.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gegykcvgx7vzvvkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 10:59:43AM +0200, Frank Oltmanns wrote:
>=20
> On 2023-07-03 at 09:25:59 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Mon, Jul 03, 2023 at 09:17:43AM +0200, Frank Oltmanns wrote:
> >>
> >> On 2023-07-02 at 19:55:24 +0200, Frank Oltmanns <frank@oltmanns.dev> w=
rote:
> >> > When finding the best rate for a NKM clock, consider rates that are
> >> > higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag=
 is
> >> > set.
> >> >
> >> > Accommodate ccu_mux_helper_determine_rate to this change.
> >> >
> >> > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> > ---
> >> >  drivers/clk/sunxi-ng/ccu_mux.c | 23 +++++++++++++++-----
> >> >  drivers/clk/sunxi-ng/ccu_nkm.c | 48 +++++++++++++++++++++++++++++++=
-----------
> >> >  2 files changed, 54 insertions(+), 17 deletions(-)
> >> >
> >> > diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/c=
cu_mux.c
> >> > index 1d557e323169..8594d6a4addd 100644
> >> > --- a/drivers/clk/sunxi-ng/ccu_mux.c
> >> > +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> >> > @@ -113,7 +113,7 @@ int ccu_mux_helper_determine_rate(struct ccu_com=
mon *common,
> >> >  	}
> >> >
> >> >  	for (i =3D 0; i < clk_hw_get_num_parents(hw); i++) {
> >> > -		unsigned long tmp_rate, parent_rate;
> >> > +		unsigned long tmp_rate, parent_rate, best_diff =3D ULONG_MAX;
> >> >  		struct clk_hw *parent;
> >> >
> >> >  		parent =3D clk_hw_get_parent_by_index(hw, i);
> >> > @@ -139,10 +139,23 @@ int ccu_mux_helper_determine_rate(struct ccu_c=
ommon *common,
> >> >  			goto out;
> >> >  		}
> >> >
> >> > -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> >> > -			best_rate =3D tmp_rate;
> >> > -			best_parent_rate =3D parent_rate;
> >> > -			best_parent =3D parent;
> >> > +		if (common->features & CCU_FEATURE_CLOSEST_RATE) {
> >> > +			unsigned long tmp_diff =3D req->rate > tmp_rate ?
> >> > +						 req->rate - tmp_rate :
> >> > +						 tmp_rate - req->rate;
> >> > +
> >> > +			if (tmp_diff < best_diff) {
> >> > +				best_rate =3D tmp_rate;
> >> > +				best_parent_rate =3D parent_rate;
> >> > +				best_parent =3D parent;
> >> > +				best_diff =3D tmp_diff;
> >> > +			}
> >> > +		} else {
> >> > +			if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> >> > +				best_rate =3D tmp_rate;
> >> > +				best_parent_rate =3D parent_rate;
> >> > +				best_parent =3D parent;
> >> > +			}
> >> >  		}
> >> >  	}
> >> >
> >> > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/c=
cu_nkm.c
> >> > index d83843e69c25..36d9e987e4d8 100644
> >> > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> >> > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> >> > @@ -18,9 +18,11 @@ struct _ccu_nkm {
> >> >  };
> >> >
> >> >  static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned lon=
g *parent, unsigned long rate,
> >> > -						       struct _ccu_nkm *nkm, struct clk_hw *phw)
> >> > +						       struct _ccu_nkm *nkm, struct clk_hw *phw,
> >> > +						       unsigned long features)
> >> >  {
> >> > -	unsigned long best_rate =3D 0, best_parent_rate =3D *parent, tmp_p=
arent =3D *parent;
> >> > +	unsigned long best_rate =3D 0, best_parent_rate =3D 0, tmp_parent =
=3D *parent;
> >> > +	unsigned long best_diff =3D ULONG_MAX;
> >> >  	unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
> >> >  	unsigned long _n, _k, _m;
> >> >
> >> > @@ -28,16 +30,26 @@ static unsigned long ccu_nkm_find_best_with_pare=
nt_adj(unsigned long *parent, un
> >> >  		for (_n =3D nkm->min_n; _n <=3D nkm->max_n; _n++) {
> >> >  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
> >> >  				unsigned long tmp_rate;
> >> > +				unsigned long tmp_diff;
> >> >
> >> >  				tmp_parent =3D clk_hw_round_rate(phw, rate * _m / (_n * _k));
> >> >
> >> >  				tmp_rate =3D tmp_parent * _n * _k / _m;
> >> > -				if (tmp_rate > rate)
> >> > -					continue;
> >> >
> >> > -				if ((rate - tmp_rate) < (rate - best_rate)) {
> >> > +				if (features & CCU_FEATURE_CLOSEST_RATE) {
> >> > +					tmp_diff =3D rate > tmp_rate ?
> >> > +						   rate - tmp_rate :
> >> > +						   tmp_rate - rate;
> >> > +				} else {
> >> > +					if (tmp_rate > rate)
> >> > +						continue;
> >> > +					tmp_diff =3D rate - tmp_diff;
> >>
> >> Sorry, this should of course be tmp_diff =3D rate - tmp_rate. I'll fix
> >> that in v4. Also I'll do tests on my phone where
> >> CCU_FEATURE_CLOSEST_RATE is not set (i.e., without PATCH 8), so see if
> >> it replicates the old behaviour. I'll also look into adding kunit test=
s,
> >> so that this doesn't happen again. I'm not sure if this is feasible, b=
ut
> >> I'll ask here for advise, if/when I encounter obstacles.
> >
> > While this would obviously be great, I don't think we have the
> > infrastructure just yet to allow to easily add kunit tests for entire
> > clocks.
>=20
> I think, clk_test.c provides a good blueprint. I tried to do that for
> clk-fractional-divider [1], but Stephen wanted to go a different route,
> so I dropped it. You could look at clk_fd_test_init() in [1]. A similar
> approach might work for the sunxi-ng clocks. I don't see any real
> blockers, but maybe that's me being naive.

The main issue will be probing and mocking. Those clocks are meant to be
probed through the device tree and expect to have underlying registers
accessible.

We would need some way to mock / prevent any register access, while
still registering a clock with its device tree node, parent, etc. for
the tests to be meaningful. And that's not going to be an easy thing to
do :)

Maxime

--gegykcvgx7vzvvkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKKyxAAKCRDj7w1vZxhR
xV/lAQDhvphlvWpOwfrzo0B9hdjf3WpLvcLri3WR/earG6778QD+MDIjfM9bpfqo
pt2yxU9b6TJVfjAZY2uEWLuuBiW9TwA=
=lP/K
-----END PGP SIGNATURE-----

--gegykcvgx7vzvvkm--
