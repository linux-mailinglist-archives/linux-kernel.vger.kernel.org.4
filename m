Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D659745B43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGCLhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:37:20 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9286B8;
        Mon,  3 Jul 2023 04:37:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F70A5C0318;
        Mon,  3 Jul 2023 07:37:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jul 2023 07:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688384238; x=1688470638; bh=6F
        GhhmRXoSlOTB/lM1bsSqDmlfwYny54Qvppyq5eXOc=; b=SIq2vErINz4Dv/7ikh
        q1n9lpCubM0avIVPYcv1DdF0jMeAP5tnTuNAcSnX1e39uVNplns/UGsJNd+Hvukp
        f9AX0fiEjiVqHt+JUGzEGc0ERen2hzXw5wAAjgVLA9TeVhEdz8XKfInCQTP4iLUm
        Objfb5LvNHEFoy+Gye3kNU4elR2h8Wfp6iMJmQ5hYM5pa5reLArZn8KCPJD+SKAT
        pNn7dc8+edtvr1tC4xKVlXSMtezhFVFb02cZvbcs+yaX8ZFhFMCii8DaDlTUuK4D
        O49RmPO3ZhmgGAvjoIazY8m3Lzv1FUzf5iIMQDXFI9tLPeCR0GurzuBzO8LhL7R4
        spEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688384238; x=1688470638; bh=6FGhhmRXoSlOT
        B/lM1bsSqDmlfwYny54Qvppyq5eXOc=; b=XV3moJlNqdLxir1yGjLCg16Snsu8K
        z0jdBjcV7fbboWJFqDMwoVODSnfnaOjYX9rcq5Gqq+A3lk5GqGP2vCzszkYO4VxV
        ItRJcZN0G1QbbConNS4Z6Lq1BOmPg9QhuejBI3eYwvVTf22HomW7OsuY8yUTtTNx
        qGq95gxT7Zk7H6DIEaPPdc90wE4O8+xviYCvJVQ3Iv0tO6kD2nJSabIRzor3Z6BG
        RuCxzmun8EI/OUKXC1EyKFZgVL9vdmCvUu4i6y9EiJnnSbYcWqxNtP0VlVvuJ/9c
        jNJEDPUIQi9HY01x0AoGQDdU43nWyiLiRcbivrgg/pPCKm1cB4pc/bQAw==
X-ME-Sender: <xms:7bKiZGwIuP1KnTfZYyCqLpwdbMeS--VaJzpp64q7ywpA4WNmZFTpcg>
    <xme:7bKiZCS6chKV2MLdmcxYZrhp1xBatJyAbCyw5KBeCYAldsr7YJ1XZYE1W_IAOj0cr
    Y20wWnv6JHvxMY3qFg>
X-ME-Received: <xmr:7bKiZIXxpbZknTEBA7B_rha9NcpxkTlV6SGHeVECB07cv9R8G9MO4biK1gVeKLsBvGVbHZe8D1A_x70-58TUxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeetkefg
    leefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:7bKiZMi_JB0mwRa1cCFSWFB6hGkej-wjC4GZ2PyLdPtHGMDUZiG9dQ>
    <xmx:7bKiZIAcl-XRoZQ7Vz7z5n60jqxI6LMrF1dH_W-4LP1Xuwq15J3zoQ>
    <xmx:7bKiZNK-2EtBbNQVXigBIERA5nK-en6j-pdDNf20alyvIHc3o8vBMQ>
    <xmx:7rKiZM7O_fPSSWdZ2fJXDBvogHT_q8s3rFrBkW4mxfALoM2wFlwlJg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jul 2023 07:37:17 -0400 (EDT)
Date:   Mon, 3 Jul 2023 13:37:15 +0200
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
Message-ID: <ryramlegltk3dayye2cy73s4el7wx5ye7o2okd5oboefrb6lrh@p7bzr2fohqa3>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
 <20230702-pll-mipi_set_rate_parent-v3-6-46dcb8aa9cbc@oltmanns.dev>
 <b7gnap57aajkbhbbcbgallvqjdc7nzppjjwnancgmm5ibmhdaq@cftau72qyjdu>
 <87fs65s6aj.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t2tjec4yx3o7pbhi"
Content-Disposition: inline
In-Reply-To: <87fs65s6aj.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t2tjec4yx3o7pbhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 11:17:24AM +0200, Frank Oltmanns wrote:
>=20
> On 2023-07-03 at 09:38:48 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Sun, Jul 02, 2023 at 07:55:25PM +0200, Frank Oltmanns wrote:
> >> When finding the best rate for a mux clock, consider rates that are
> >> higher than the requested rate by introducing a new clk_ops structure
> >> that uses the existing __clk_mux_determine_rate_closest function.
> >> Furthermore introduce an initialization macro that uses this new
> >> structure.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu_mux.c | 13 +++++++++++++
> >>  drivers/clk/sunxi-ng/ccu_mux.h | 17 +++++++++++++++++
> >>  2 files changed, 30 insertions(+)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu=
_mux.c
> >> index 8594d6a4addd..49a592bdeacf 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_mux.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> >> @@ -264,6 +264,19 @@ static unsigned long ccu_mux_recalc_rate(struct c=
lk_hw *hw,
> >>  					   parent_rate);
> >>  }
> >>
> >> +const struct clk_ops ccu_mux_closest_ops =3D {
> >> +	.disable	=3D ccu_mux_disable,
> >> +	.enable		=3D ccu_mux_enable,
> >> +	.is_enabled	=3D ccu_mux_is_enabled,
> >> +
> >> +	.get_parent	=3D ccu_mux_get_parent,
> >> +	.set_parent	=3D ccu_mux_set_parent,
> >> +
> >> +	.determine_rate	=3D __clk_mux_determine_rate_closest,
> >> +	.recalc_rate	=3D ccu_mux_recalc_rate,
> >> +};
> >> +EXPORT_SYMBOL_NS_GPL(ccu_mux_closest_ops, SUNXI_CCU);
> >> +
> >
> > This is also a bit inconsistent with the other clocks: most (all?) of
> > them will simply handle this through a flag, but this one requires a new
> > set of clk_ops as well?
> >
> > I think we should create our own wrapper here around
> > __clk_mux_determine_rate and either call
> > __clk_mux_determine_rate_closest or __clk_mux_determine_rate depending
> > on the state of the flags, or call __clk_mux_determine_rate_flags with
> > the proper flags set for our clock.
> >
> > The former is probably slightly simpler.
>=20
> Ok, I will address that in v4.
>=20
> >
> >>  const struct clk_ops ccu_mux_ops =3D {
> >>  	.disable	=3D ccu_mux_disable,
> >>  	.enable		=3D ccu_mux_enable,
> >> diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu=
_mux.h
> >> index 2c1811a445b0..c4ee14e43719 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_mux.h
> >> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
> >> @@ -46,6 +46,22 @@ struct ccu_mux {
> >>  	struct ccu_common	common;
> >>  };
> >>
> >> +#define SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(_struct, _name, _parent=
s, _table,	\
> >> +				     _reg, _shift, _width, _gate,	\
> >> +				     _flags)				\
> >> +	struct ccu_mux _struct =3D {					\
> >> +		.enable	=3D _gate,					\
> >> +		.mux	=3D _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),	\
> >> +		.common	=3D {						\
> >> +			.reg		=3D _reg,				\
> >> +			.hw.init	=3D CLK_HW_INIT_PARENTS(_name,	\
> >> +							      _parents, \
> >> +							      &ccu_mux_closest_ops, \
> >> +							      _flags),	\
> >> +			.features	=3D CCU_FEATURE_CLOSEST_RATE,	\
> >> +		}							\
> >> +	}
> >> +
> >
> > I'm fine with that one, but like we discussed on the NM (I think?) patch
> > already, this creates some clocks and macros that will use the feature
> > as a flag, and some will encode it into their name.
> >
> > Given that we need it here too, I'm really inclined to prefer what you
> > did there, and thus create a new macro for pll-video0 instead of
> > modifying the existing one.
>=20
> Ok. Just to be clear: What I did in this patch is fine and I should use
> the same approach for NM. Did I get that right?

Yes. Leave the NM macro as it is, and add a new _CLOSEST variant that
sets the flag like you did there.

Maxime

--t2tjec4yx3o7pbhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZKKy6wAKCRDj7w1vZxhR
xWHzAQCHI7e5XU7oDIjGLZEeYpCvt6wruqXLan5kivXIWISfJQD/TKym+WzEOy/4
twHIRYOF8Gp3SNjZedHn9SBu4f7FMwA=
=zM0z
-----END PGP SIGNATURE-----

--t2tjec4yx3o7pbhi--
