Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B74731BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbjFOOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345089AbjFOOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:47:34 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DF297B;
        Thu, 15 Jun 2023 07:47:24 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DD6CD5C0110;
        Thu, 15 Jun 2023 10:47:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Jun 2023 10:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686840443; x=1686926843; bh=L5
        CucTn2nK/6ilWkZCkYXAEXi37p54TLgVd4NqLySVs=; b=MrHyT4BAxtK6OrVF3/
        NLgBLROkQsxwyC23Tz7wnZH7MfI0SqdzZDAoETPyuKL6DFN0JwUjfClpf2nTwe0h
        +HxlGW4hQm9fqEQrFCagN96GIqMaZdrolBgD+hgOxdNDYogWLbvp6IxKFOP1SCvy
        PRP8CwgQVsnGmz8g3PfZ0oOtsy9tt9nAnrhg05ffaY9f34qUjzoqv8V9vzxtEdm+
        9blvB6bf28rf2iLsqbwXlTm4ROZPas5SNVCowjaNd+4rL30VwwUsXGnY2GPF455A
        AxMMs3qBo+RXe8VliJ00RbjCr7jaK128GdbrG8W0gHScK07Y8fxWBDEgh1nVCB4s
        V4Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686840443; x=1686926843; bh=L5CucTn2nK/6i
        lWkZCkYXAEXi37p54TLgVd4NqLySVs=; b=krLNryTD7nnL8EQElM93RdreP4Km6
        SF8iXucPHaZGs6uaPqsYFHXvj/nvkNsmEri4NyGQP+Y3SeRFEDJKOzEyiflsnhcY
        1Uuho+PrWrRvhoDcqD9JptrWxDd6WRkjjfSaLrb43Ze8NvX5nvtDB6mGXJMaJbl/
        JkKcduFxuOf/GuI2L/Z1roABSJXZ814ouZzjD792yvO73jw/qc+5L+Pn01QSQccU
        m1eBk9YWeRuS/VS+gP6ssGa4hiemh2ScG+qVfMdddEpLV6TqOQkggDS4iMPcOYj/
        RNQ9XfGgDrf1tJHZzmbQQOlN8nJXY0pDIMd/9Xq7jqcmHCbW5yITmJRZw==
X-ME-Sender: <xms:eiSLZFoOopYwLzscePzl9mf9itXamZV4tIKmpE2teCqenh6j6wwYfg>
    <xme:eiSLZHoU00qYSZjXtcR8aGGx1asLgMR5qo9cTiNmg7RFxnAAoat4OXGMXUbSqCxsU
    v5tWnB7ZK7bPcDjORw>
X-ME-Received: <xmr:eiSLZCOsHSSYNF9iwE5P-zlLD2QAU6d06HJUco4POSnoobQT1Ohg8ww3WS2WpIso1dBIKjd_aqVZn_J4lRLZgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffvvefukffhfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefhhfehtdektdejueeltefhjeeltdffffejheffudfhvdfhhfeludekkefg
    hffhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:eySLZA4pcVjxOqQTLtJPI8yzRNxn15GIOeL4PHrCOr5ZrxyHQ2m0hQ>
    <xmx:eySLZE7TPIyQ2HDe4GTwjbSw7jDAn3wW8DNAskD1zUqZMLQNyDTc-A>
    <xmx:eySLZIiojEx9wSGlaS26Rg6RDw7WboxOFSSPHf-bE2Fdv3fJ-T4Eow>
    <xmx:eySLZBzV1qRwU7Hq-EhjqWNANLkdy3_j6GsOOcaKGWnnEQJ77drqXg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 10:47:22 -0400 (EDT)
Date:   Tue, 13 Jun 2023 17:30:06 +0200
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
Message-ID: <wnxjbbjfcnrg7ogwkfwbnldvyqbpt23b6mnrieb2zffooaojts@sudsbfjbjt64>
From:   Maxime Ripard <maxime@cerno.tech>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
 <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
 <87wn07zmxp.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cghg4gjbgxgwxw55"
Content-Disposition: inline
In-Reply-To: <87wn07zmxp.fsf@oltmanns.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cghg4gjbgxgwxw55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 12:17:06PM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> I'll now only respond to one aspect of your mail, because it's the
> foundation for the whole behaviour.
>=20
> On 2023-06-13 at 11:10:08 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [...]
> >> >> ccu_nkm_find_best is called in the following two situations:
> >> >>  a. from ccu_nkm_set_rate when setting the rate
> >> >>  b. from ccu_nkm_round_rate when determining the rate
> >> >>
> >> >> In situation a. we never want ccu_nkm_find_best to try different pa=
rent
> >> >> rates because setting the parent rate is a done deal (at least that=
's my
> >> >> understanding).
> >> >>
> >> >> In situation b. we only want ccu_nkm_find_best to try different par=
ent
> >> >> rates when, as you mentioned, the CLK_SET_RATE_PARENT flag is set.
> >> >
> >> > It doesn't really matter though. The output of that function must be
> >> > stable and must return the same set of factors and parent rate for a
> >> > given target rate.
> >> >
> >>
> >> I'm not sure if we're talking about the same thing here. Of course the
> >> set of factors and parent rate for a given target rate will be differe=
nt
> >> depending on the fact if we can or cannot adjust the parent rate,
> >> agreed?
> >
> > Yes, but here you also have a different behaviour in clk_round_rate()
> > and in clk_set_rate(), which isn't ok.
> >
> > Basically, clk_set_rate() + clk_get_rate() must be equal to
> > clk_round_rate().
> >
> > If you change if you look for parents depending on whether you're being
> > called in clk_round_rate() and clk_set_rate(), then you're breaking that
> > expectation.
> >
> >> Let me compare my implementation to ccu_mp.
> >>
> >> ccu_mp_round_rate either calls the function ccu_mp_find_best or
> >> ccu_mp_find_best_with_parent_adj, depending on CLK_SET_RATE_PARENT.
> >
> > Yes, and it's fine: the flag is per-clock, and the output is the same
> > depending on whether we're being called by clk_round_rate() and
> > clk_set_rate().
> >
>=20
> The output is really not the same.
>=20
> ccu_mp_set_rate() always calls ccu_mp_find_best(). It never (!) considers
> changing the parent, independent of any flags.
>=20
> ccu_mp_round_rate() is calling ccu_mp_find_best() OR
> ccu_mp_find_best_with_parent_adj() depending on the flag.
>=20
> If I understand you correctly, you consider that a bug.

No, sorry, you're right.

clk_set_rate will call round_rate first, which will (possibly) pick up a
new parent, and by the time set_rate is called our parent will have been
changed already so we will just call find_best again considering only
that parent.

The set of factors and dividers should remain the same there, but I
don't think that's a concern.

That leaves us with the rounding stuff, and the overall function
arguments. I like the structure of ccu_mp better, is there a reason to
deviate from it?

Maxime

--cghg4gjbgxgwxw55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIiLeQAKCRDj7w1vZxhR
xZwOAP0V27baWBPmfpGaKZQrnd/GOqaGcGGZZuCPI3ZDiH4lzAD/RqTkEXmNCeP+
vkcuc67x9IsePwvMFq3jBor1njpnVgc=
=84G2
-----END PGP SIGNATURE-----

--cghg4gjbgxgwxw55--
