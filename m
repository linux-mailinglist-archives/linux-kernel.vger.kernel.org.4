Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35B3735C39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjFSQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFSQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:36:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80110E;
        Mon, 19 Jun 2023 09:36:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 972DD5C01F3;
        Mon, 19 Jun 2023 12:36:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Jun 2023 12:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687192584; x=1687278984; bh=Uu
        hVo65gu7gMZTFNFSuRoYBhg4H4ij8B83s8y9DwSoA=; b=WrzKMLafCtsoOr8TEF
        alOpm0v0pDpH0tulTE81ND1k9YwYQLkX1AFJE69Mi+IWhrf3mTsL1TUVGJk5kqTs
        uQEvqkPnV5jt49pCLKr4FVjE1rZNRE8z+OsR0stwftsyxlWJwKSbWoUQQ1jYkojg
        MKGHNOfLIVVMFnKOh8zGDh5K0J0wpZvifONs2WV3BEuBFZyM/+PHwJMHOTjk+0sy
        KfxZpBOCcsJcjmobg7zg5X4ED+01zRDeMwqwUx/qMnr2JZ1nUwnVY4W/xejs/oNp
        0pH/5SDpY+rmPfHPrhiS3312dbuwr+t/Z1ork+eFEhe/OON6t2epLQ677J2KegT1
        Oo6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687192584; x=1687278984; bh=UuhVo65gu7gMZ
        TFNFSuRoYBhg4H4ij8B83s8y9DwSoA=; b=T16DgW7ruO4dpU16BHZHZeX4JGUL4
        Vqtcypt4muavFn51JwHBkPO1Sr/sD9MB0vQHGq3p25SeQ76m94qShzoxMI7iai2t
        GnM9fUJX+068jEPCTUPmaLoGeYA4vsmCmk6KklhpY2roRblaEJWi4ZCqE/3oTi+4
        h/j+u1kBSzi8NgpAMYkSltLsvbH6cc0MlQ2UT+DMMz0hq2C7yuvOlnT4blZaJnZ9
        uz5fBdjorRwpYXXCfXp4qBmyNaoZk2GDno+uBuulvBZJ73C7T4nbIMSG86N88ovA
        ma803FgEqqYcE+ktVjisxWWTPbVdn57eb2ihJEJWC5ZoQW4AtTC0BIdxg==
X-ME-Sender: <xms:B4SQZH8Y3g9jq5ms1UocppEEYCjYDD7vrRKQB6vzIdOIhD2Y7aNrhw>
    <xme:B4SQZDuknErB4-eDOjFcMWpc5WHnbkePy1styhEqRXNoLbrgcKtrviyC6UIJEWsP7
    lYdcqj-8Pc0ndP4K20>
X-ME-Received: <xmr:B4SQZFBHAwjbGEZchQZ31yfzQCbMYte9jQvuhuLV4hf3QdUN9vEJ5xkaQ084LdUD45PIHYf98BX9tXVPZlc1JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepledufeegudehveeljeeigfehtedvffehjedvjeevhfduueevheeuvedv
    veevueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:B4SQZDepGr4oIZrroO9_plbOyxtGKOmB3QkTWCFoy8wcXZIpnlpRmQ>
    <xmx:B4SQZMM6WdK4BzdYKklXXTqXx_iVVmRO4CiTqfLiWUq1h5ShaIXLPw>
    <xmx:B4SQZFnTc4GANHYU2twsTB33xulZ1QtWJPUebEt1CubDfGOL8qwXvw>
    <xmx:CISQZNED4Gu4sO9FYaiB5H5pCpE7I2_SkCeLzfn5-fWtbaRTFCOmVQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 12:36:22 -0400 (EDT)
Date:   Mon, 19 Jun 2023 18:36:19 +0200
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
Message-ID: <mdpeq63lziegp2pyp7a5fj6o2psvmm4mgeo354diq2u2j267vd@l63zrttiuvkk>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
 <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
 <87wn07zmxp.fsf@oltmanns.dev>
 <wnxjbbjfcnrg7ogwkfwbnldvyqbpt23b6mnrieb2zffooaojts@sudsbfjbjt64>
 <d40e94c4-9dab-4511-bd48-1d9081f4262a@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g7ta4xd7nex3465f"
Content-Disposition: inline
In-Reply-To: <d40e94c4-9dab-4511-bd48-1d9081f4262a@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g7ta4xd7nex3465f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 06:04:53PM +0200, Frank Oltmanns wrote:
> 15.06.2023 16:47:33 Maxime Ripard <maxime@cerno.tech>:
> > On Tue, Jun 13, 2023 at 12:17:06PM +0200, Frank Oltmanns wrote:
> >> Hi Maxime,
> >>
> >> I'll now only respond to one aspect of your mail, because it's the
> >> foundation for the whole behaviour.
> >>
> >> On 2023-06-13 at 11:10:08 +0200, Maxime Ripard <maxime@cerno.tech> wro=
te:
> >> [...]
> >>>>>> =E2=80=A6
> >>>>>
> >>>>> It doesn't really matter though. The output of that function must be
> >>>>> stable and must return the same set of factors and parent rate for a
> >>>>> given target rate.
> >>>>>
> >>>>
> >>>> I'm not sure if we're talking about the same thing here. Of course t=
he
> >>>> set of factors and parent rate for a given target rate will be diffe=
rent
> >>>> depending on the fact if we can or cannot adjust the parent rate,
> >>>> agreed?
> >>>
> >>> Yes, but here you also have a different behaviour in clk_round_rate()
> >>> and in clk_set_rate(), which isn't ok.
> >>>
> >>> Basically, clk_set_rate() + clk_get_rate() must be equal to
> >>> clk_round_rate().
> >>>
> >>> If you change if you look for parents depending on whether you're bei=
ng
> >>> called in clk_round_rate() and clk_set_rate(), then you're breaking t=
hat
> >>> expectation.
> >>>
> >>>> Let me compare my implementation to ccu_mp.
> >>>>
> >>>> ccu_mp_round_rate either calls the function ccu_mp_find_best or
> >>>> ccu_mp_find_best_with_parent_adj, depending on CLK_SET_RATE_PARENT.
> >>>
> >>> Yes, and it's fine: the flag is per-clock, and the output is the same
> >>> depending on whether we're being called by clk_round_rate() and
> >>> clk_set_rate().
> >>>
> >>
> >> The output is really not the same.
> >>
> >> ccu_mp_set_rate() always calls ccu_mp_find_best(). It never (!) consid=
ers
> >> changing the parent, independent of any flags.
> >>
> >> ccu_mp_round_rate() is calling ccu_mp_find_best() OR
> >> ccu_mp_find_best_with_parent_adj() depending on the flag.
> >>
> >> If I understand you correctly, you consider that a bug.
> >
> > No, sorry, you're right.
> >
> > clk_set_rate will call round_rate first, which will (possibly) pick up a
> > new parent, and by the time set_rate is called our parent will have been
> > changed already so we will just call find_best again considering only
> > that parent.
>=20
> Ok, no worries. That was my understanding, so your previous statement sha=
ttered my worldview. ;) That's why I may have seemed a bit alarmed.
>=20
> >
> > The set of factors and dividers should remain the same there, but I
> > don't think that's a concern.
>=20
> Ack. The output is stable when called with the same rate.
>=20
> > That leaves us with the rounding stuff, and the overall function
> > arguments. I like the structure of ccu_mp better, is there a reason to
> > deviate from it?
>=20
> I'm still pondering the rounding stuff. I'm just not sure why you are
> so relaxed about the fact that when calling round_rate with 449064000
> we get 449035712, but when we call get round_rate with 449035712 we
> get 449018181, and when we call round_rate with 449018181, we get
> 449018180.

I guess there's a couple of reasons:

  - You mentioned that you were going to fix the rate issue later :)

  - At the end of the day, it's not a huge offset and shouldn't cause
    any big trouble

> But ultimately, you have the final word, of course. But I need some
> time to be sure, that this does not become a problem in some cases.

Don't get me wrong, it should be fixed (and ideally, we should get some
unit tests to make sure that it doesn't behave that way). I don't think
it's urgent though, or that we introduce workarounds in one particular
clock type.

So we can definitely focus on the parent stuff first, and then get the
rate stuff figured out.

Maxime

--g7ta4xd7nex3465f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZJCEAwAKCRDj7w1vZxhR
xTLqAQClbbvPDJ2cdhcYv+Jv7TNenlGRGGQLG7tFj1lyWz4roQEA7AYDdNJQZ9t0
AlA5tZURWiLpemHC6+21q8YDv3Bp1g8=
=Zcgb
-----END PGP SIGNATURE-----

--g7ta4xd7nex3465f--
