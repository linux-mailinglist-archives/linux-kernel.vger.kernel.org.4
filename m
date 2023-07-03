Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7371674576C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGCIfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjGCIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:35:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D8E43;
        Mon,  3 Jul 2023 01:35:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BD6425C02D7;
        Mon,  3 Jul 2023 04:35:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Jul 2023 04:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688373305; x=1688459705; bh=xU
        mciYr10XqrxcawzB9I1x9ubgQnQxfIYfaGPiRwOUI=; b=LkDPMnu3aFxXfoHi4k
        vc2UzWdqzzpmnHoIXKflpyPhYqnkOFAsPhanrPwEas7O+zgMRZgdsbABn1Hsq+gZ
        ABIZvMqXV2Km1m4fSnNZDmIAzp5v2JCGmZBjgepFc/4w2K/gxORO2XVuSBIBl//Y
        21kLNLbbrzRcUia5kW5njfKVp+5o4czrqlYafUqCzXgivT3SknAyAHG1N8SYVl/7
        gbUZTrTmJMuwjfjPtjWVMqU/xiAKvAgeaWFl0kUNpRMYvz9onMqSYTP1QFGTfh4T
        djOIY5BQkhr6BCNG+zCjyFCVcvDxQ3jVF9STS2dAovATvvsE/zen9N78GE09gsdr
        O5aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688373305; x=1688459705; bh=xUmciYr10Xqrx
        cawzB9I1x9ubgQnQxfIYfaGPiRwOUI=; b=QHumdifPVafKqnqHRzmWV6ZFWK1wM
        R6KhA1xPmZEflMDmU5hPndLTeFgVRpg0ZhGKMj9wZxu31Du+HC/DpcXSk389psy7
        cKo5J0JxHTWnuZIrm/PMDZKB+EEvq7ByyXH6mIjrWleAIDNucRed0A7vq7Q1EheS
        uRmXTMNn0Vxtt/LXF3hv98OpkUWV/VjC4MksNjKJTKDXLs5nkQP7YsmghMia4uDT
        xn5iPavlXEmFlJolwu1eF85PVFFNNyRjhwmPqUSlHV4NaJo3+ChPWP53TQNvV8nv
        +J1XN/T53kHSJdXcNDyDkJv6B9b5vukotBB8LTWFC6b3JEiSRKmDpXqwQ==
X-ME-Sender: <xms:OYiiZDi1zNCtwzIqJV2iMbz4lqLSpdSbxP75Ab3CZsHhlmPZD2h3sg>
    <xme:OYiiZACVj7kYdqA9RTjGowDYpwKZhUpZ_Pq4MBFCXkE8r6nzBtUCDaYoe3E-Mg5Ku
    u3PMksxdFTEcuY0G8E>
X-ME-Received: <xmr:OYiiZDHJYFUI7NPuL6meOPuTGOdlMPK01jxUYx0R9R2FO0DcBtadfRl3t4O-Q2H2p6oeAz9UvljjouksuoZwEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffvfevuffkhfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhephffhhedtkedtjeeuleethfejledtffffjeehffduhfdvhffhledukeekgffh
    hfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:OYiiZAQcB4vBF2dHJUjB3f6HYzu8p9YVrx12zj97KH4_FZFhqJVtjg>
    <xmx:OYiiZAxKJh2lPg7YpUZMPfOFCu_I7-eZPtXnjd0-tQjrpXZQfo4DCA>
    <xmx:OYiiZG7ryvswF_KZSiWB47GkgzjqwpE0hUGRGmVQMeh5x9r5yMJyYA>
    <xmx:OYiiZFp3I1FycdmqP7Nzd3MfHwEY-cdhpQFeDzPY1p2r9wpS8OXOyw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 04:35:04 -0400 (EDT)
Date:   Mon, 3 Jul 2023 09:25:59 +0200
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
Message-ID: <zvxviyera3zxe2ro5ej52vz2o2vrinu6zo7osddojbys4tuqhd@3f2okcbpf5jr>
From:   Maxime Ripard <maxime@cerno.tech>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc@oltmanns.dev>
 <87wmzhsbu0.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vstofkqfz34ty6ly"
Content-Disposition: inline
In-Reply-To: <87wmzhsbu0.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vstofkqfz34ty6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 09:17:43AM +0200, Frank Oltmanns wrote:
>=20
> On 2023-07-02 at 19:55:24 +0200, Frank Oltmanns <frank@oltmanns.dev> wrot=
e:
> > When finding the best rate for a NKM clock, consider rates that are
> > higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
> > set.
> >
> > Accommodate ccu_mux_helper_determine_rate to this change.
> >
> > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> > ---
> >  drivers/clk/sunxi-ng/ccu_mux.c | 23 +++++++++++++++-----
> >  drivers/clk/sunxi-ng/ccu_nkm.c | 48 +++++++++++++++++++++++++++++++---=
--------
> >  2 files changed, 54 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_=
mux.c
> > index 1d557e323169..8594d6a4addd 100644
> > --- a/drivers/clk/sunxi-ng/ccu_mux.c
> > +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> > @@ -113,7 +113,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common=
 *common,
> >  	}
> >
> >  	for (i =3D 0; i < clk_hw_get_num_parents(hw); i++) {
> > -		unsigned long tmp_rate, parent_rate;
> > +		unsigned long tmp_rate, parent_rate, best_diff =3D ULONG_MAX;
> >  		struct clk_hw *parent;
> >
> >  		parent =3D clk_hw_get_parent_by_index(hw, i);
> > @@ -139,10 +139,23 @@ int ccu_mux_helper_determine_rate(struct ccu_comm=
on *common,
> >  			goto out;
> >  		}
> >
> > -		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> > -			best_rate =3D tmp_rate;
> > -			best_parent_rate =3D parent_rate;
> > -			best_parent =3D parent;
> > +		if (common->features & CCU_FEATURE_CLOSEST_RATE) {
> > +			unsigned long tmp_diff =3D req->rate > tmp_rate ?
> > +						 req->rate - tmp_rate :
> > +						 tmp_rate - req->rate;
> > +
> > +			if (tmp_diff < best_diff) {
> > +				best_rate =3D tmp_rate;
> > +				best_parent_rate =3D parent_rate;
> > +				best_parent =3D parent;
> > +				best_diff =3D tmp_diff;
> > +			}
> > +		} else {
> > +			if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
> > +				best_rate =3D tmp_rate;
> > +				best_parent_rate =3D parent_rate;
> > +				best_parent =3D parent;
> > +			}
> >  		}
> >  	}
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_=
nkm.c
> > index d83843e69c25..36d9e987e4d8 100644
> > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > @@ -18,9 +18,11 @@ struct _ccu_nkm {
> >  };
> >
> >  static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned long *=
parent, unsigned long rate,
> > -						       struct _ccu_nkm *nkm, struct clk_hw *phw)
> > +						       struct _ccu_nkm *nkm, struct clk_hw *phw,
> > +						       unsigned long features)
> >  {
> > -	unsigned long best_rate =3D 0, best_parent_rate =3D *parent, tmp_pare=
nt =3D *parent;
> > +	unsigned long best_rate =3D 0, best_parent_rate =3D 0, tmp_parent =3D=
 *parent;
> > +	unsigned long best_diff =3D ULONG_MAX;
> >  	unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
> >  	unsigned long _n, _k, _m;
> >
> > @@ -28,16 +30,26 @@ static unsigned long ccu_nkm_find_best_with_parent_=
adj(unsigned long *parent, un
> >  		for (_n =3D nkm->min_n; _n <=3D nkm->max_n; _n++) {
> >  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
> >  				unsigned long tmp_rate;
> > +				unsigned long tmp_diff;
> >
> >  				tmp_parent =3D clk_hw_round_rate(phw, rate * _m / (_n * _k));
> >
> >  				tmp_rate =3D tmp_parent * _n * _k / _m;
> > -				if (tmp_rate > rate)
> > -					continue;
> >
> > -				if ((rate - tmp_rate) < (rate - best_rate)) {
> > +				if (features & CCU_FEATURE_CLOSEST_RATE) {
> > +					tmp_diff =3D rate > tmp_rate ?
> > +						   rate - tmp_rate :
> > +						   tmp_rate - rate;
> > +				} else {
> > +					if (tmp_rate > rate)
> > +						continue;
> > +					tmp_diff =3D rate - tmp_diff;
>=20
> Sorry, this should of course be tmp_diff =3D rate - tmp_rate. I'll fix
> that in v4. Also I'll do tests on my phone where
> CCU_FEATURE_CLOSEST_RATE is not set (i.e., without PATCH 8), so see if
> it replicates the old behaviour. I'll also look into adding kunit tests,
> so that this doesn't happen again. I'm not sure if this is feasible, but
> I'll ask here for advise, if/when I encounter obstacles.

While this would obviously be great, I don't think we have the
infrastructure just yet to allow to easily add kunit tests for entire
clocks.

Maxime

--vstofkqfz34ty6ly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKJ4BwAKCRDj7w1vZxhR
xT/EAQCAf+wzsG4PBtQDf9TUqpzI61mOL0/7PFIInvCwhd3hjAD/apsd946lQXsb
lqSSwED7GsHO1pZfkFY7qO5BQ8IyXQk=
=vCWb
-----END PGP SIGNATURE-----

--vstofkqfz34ty6ly--
