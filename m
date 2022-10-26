Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E460E2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiJZNxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiJZNwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:52:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484F107ABF;
        Wed, 26 Oct 2022 06:52:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BC11E5C00B2;
        Wed, 26 Oct 2022 09:52:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 26 Oct 2022 09:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666792337; x=1666878737; bh=RKb3JKVHP8
        tdzTHQi2dg6DBpxBDezcjBmxhlPuMoABU=; b=InNLBB2R+RRoTTQRJV28pqenb+
        bcGAyLgT6DioT8GP9+7Tku2mYdbGHfQeeinOt8bEva+GCDYOrzYCdA4F27vmlzL7
        t1O19PDbB5iX6zrT9b+bnHtvbjimqTBSy1bcIaxucHlmHHx8oBzHxdc4oJakjY3L
        vkyAfWXAQU/Kq75XAmfX3cfcFAgJiViOQsRT1EWsPFMZHNhVBasW4dGTT0Yrb7uK
        XkbvUbNPGqwcbImicFybIEBWy9UzFb5j03Db2ZG2hrd4Yn7MvyNZ1IrFPPuwAD5X
        zocRZR6uX/kDxSFiwLVzwPdsLa+d46Ebq6Tqok3awsa0mtXtQ5h5by/m3kaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666792337; x=1666878737; bh=RKb3JKVHP8tdzTHQi2dg6DBpxBDe
        zcjBmxhlPuMoABU=; b=MPYJtOADYhYr1Vja+m1ZxET6e1qkDeE/++z1ygOvs5wi
        hiWyWrsV3UrbQbrxzW8+yc+g8OjNvPEzeyIi1zAecVIcMjbXpUeNFK5TBHf2h5KX
        napgwNk4k6gE4VBJDFf2dZjHQvklqOvrCJ+Stm8bS5/Ps8lyxQDe7PRpKIrD0cPk
        ZDaHDO8440WiEfI8tCXxRCgq/2bPGj4oO+cNHFyMLaksUs288RBOtluE60pywJvt
        ZknZxzIsZShZG4i+yuqEmCOOyOUUl9k9kdAbjFCRtWs4Ro3MdSYZLmuU9XXXQ59a
        k4edBaVsd/vb8Piv4ll/ClujB2BLUTw4KgOcvvV3tg==
X-ME-Sender: <xms:kTtZY9JZ9TiQa-dpELOcOFDJEs19l4UD8WySqEfB-bY9veekKv7ojA>
    <xme:kTtZY5IGuOATEmgR03enp4vE_TmUdqpusymQetwDM8eW6WL3Wpz1hnrisZ4VAA1D4
    v_cTo14BFPe4QqMPFw>
X-ME-Received: <xmr:kTtZY1tQOqYlu7d8IGWUf-sgrzFxpABjS7npRXd76TuI468QfFZPSKMdFLr40TR0rs56snydSdATvW-mYvTZYwOVKEeZfgF2_Z0b43ym36_pUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpehmrgigihhm
    vgestggvrhhnohdrthgvtghhnecuggftrfgrthhtvghrnheptdejvedthfdvieeuteefue
    evffdtgedtuedtjedvueejveeuteefueeugfdtudehnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kTtZY-ZkzW3pvBh0CwZu0_V0MQk3VG_w_JKNPKjsdeROxqhWmn9dTw>
    <xmx:kTtZY0ZeZv1pYbApem-tt-Mcl7aq5eLTtU-0q_p5kx5VdUCmrwPE8Q>
    <xmx:kTtZYyCkt_qC2YhtxhoMIBsNOuXpt-Bs1_0IfI9ZyD7wG25sF9r6gA>
    <xmx:kTtZY6MFWmpjsISNacYeDsuG9b0DMl9Tx7x8n_lOVKwv_admvJ2xeQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 09:52:17 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Wed, 26 Oct 2022 15:52:15 +0200
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: Warn if we register a mux without determine_rate
Message-ID: <20221026135215.nqndtcb2unxqwwux@houat>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
 <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
 <20221026020800.38AC8C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hk6tkezha7y2a7h"
Content-Disposition: inline
In-Reply-To: <20221026020800.38AC8C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2hk6tkezha7y2a7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 25, 2022 at 07:07:58PM -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2022-10-18 06:52:59)
> > The determine_rate hook allows to select the proper parent and its rate
> > for a given clock configuration. On another hand, set_parent is there to
> > change the parent of a mux.
> >=20
> > Some clocks provide a set_parent hook but don't implement
> > determine_rate. In such a case, set_parent is pretty much useless since
> > the clock framework will always assume the current parent is to be used,
> > and we will thus never change it.
> >=20
> > This situation can be solved in two ways:
> >   - either we don't need to change the parent, and we thus shouldn't
> >     implement set_parent;
> >   - or we don't want to change the parent, in this case we should set
> >     CLK_SET_RATE_NO_REPARENT;
> >   - or we're missing a determine_rate implementation.
> >=20
> > The latter is probably just an oversight from the driver's author, and
> > we should thus raise their awareness about the fact that the current
> > state of the driver is confusing.
>=20
> There is another case which is a leaf clk that is a mux where you only
> expect clk_set_parent() to be used, and not clk_set_rate(). This use
> case is odd though, so I'm not sure how much we care.
>=20
> >=20
> > It's not clear at this point how many drivers are affected though, so
> > let's make it a warning instead of an error for now.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/clk/clk.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 57b83665e5c3..11c41d987ff4 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3700,6 +3700,11 @@ static int __clk_core_init(struct clk_core *core)
> >                 goto out;
> >         }
> > =20
> > +       /* TODO: Promote to an error */
>=20
> The documentation should be updated in this patch (see the table of
> hardware characteristics in Documentation/driver-api/clk.rst).
>=20
> > +       if (core->ops->set_parent && !core->ops->determine_rate)
> > +               pr_warn("%s: %s must implement .set_parent & .determine=
_rate\n",
>=20
> You can grep for it:
>=20
>  $ git grep -W 'struct clk_ops .*=3D'

TIL about -W. It's awesome, thanks

> but I'm fairly certain a coccinelle script can detect most of these
> because clk_ops are usually statically defined (although not always).
>=20
> Either way I already see that 'owl_comp_div_ops' will trigger this
> warning. And 'at91sam9x5_smd_ops' looks even more likely. Given that I'm
> not super keen on applying this patch.

It's the reason why I didn't return an error at first, I wanted to
report that it's invalid and let to drivers the chance to be fixed
still.

Should I take your above comment as you'd rather have the affected
drivers fixed in this patch and we then return an error, or is it that
you don't want that patch at all?

Maxime

--2hk6tkezha7y2a7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY1k7jwAKCRDj7w1vZxhR
xf1jAQDGrQExtcQimUytmP89Y4KieiUjk5eWKtH+Tc60q99DIQD/XOKsfZo7EMit
QwCGZzOoO70UzhoKF8IZvt0ilYs/Hw4=
=MBW4
-----END PGP SIGNATURE-----

--2hk6tkezha7y2a7h--
