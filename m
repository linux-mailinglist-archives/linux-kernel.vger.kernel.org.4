Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED30D735D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjFSSF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:05:54 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EB1B6;
        Mon, 19 Jun 2023 11:05:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7B4433200986;
        Mon, 19 Jun 2023 14:05:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 19 Jun 2023 14:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687197948; x=1687284348; bh=el
        QaRNZVxlUq2csY8D9qNeou1zsE9u4oPia1Dl5rJUY=; b=GAEURsyK8cNf0fMYRW
        vfT4g/XFGExFv3uBSysBhyC4arNrGlmj+H/2mjo5g97WHfleidSdOLEnUxN1vJX+
        XRSQIPcLLRg5pmQEcL2r0zWixM7fIzs9PQJAbkMKYrkZQWHkfdzW0J44aDJUoJL6
        TZS6GW1JSTUS75Q5JNT7T42LFokcU06NiRZs2EgObr+BKG4PUH5RlCuATxpkUnb4
        fpBvjsFX0Fpiw+Uw8UPH9aZNz3S+7TxOHJVNZt0u1Ghl/FznxhQH5SonG3fVe4yl
        hN6aQaZX+2KU6TBwtuej42Ggw2xhlAmCSynB0v+WN6hf0VFbvPkNIGaNnAEV4xlX
        blQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687197948; x=1687284348; bh=elQaRNZVxlUq2
        csY8D9qNeou1zsE9u4oPia1Dl5rJUY=; b=SuCsOF9GM9dgnsdFJXWMHoXwMEmHO
        H88qAUBxZXv5tcIHZiN/CgmrqZGA3QOidUbc3WKJfCdvr7JDf22pWhUW8wcMj1j9
        7VNX0/B6MNxPhccUqVuiOgMjuTv35BVk+Z7OlEjWwrUl7nGAFQnYunljttTWITwg
        DKtpTqfPnN4G+FpC4EgEoD0VWYLEjgV9BQa+E7cu26nZJNgLalmMDRJqtjqXo3Z4
        ysXVPcxePfH/RPzFybcNyeomzDhjuk1mTqye1cDWepUY1fPKJKACsh+8p676euOH
        kpTt5YI39A/JKqxw1kyOMp5lauXyWKMmY3MwleYvgg7QGw2M56lU5FdUg==
X-ME-Sender: <xms:-piQZC-Sb1nj8YV10lNK-DdJYDwzXtVoIBOF3C7y7Pvjhi7snSCwew>
    <xme:-piQZCuUIR8OepTR0qXTEN2uFii8wwWR57GK7ixqcrH94HqtqFys96JBtpj4GqFmH
    QQkKJLGWy3RY2OCVag>
X-ME-Received: <xmr:-piQZIAQb0WyFfqA6SiVHa_N2DCXmlPiF2Ywfb6tdd7KPYcaBZ3lGt7Hty3MKMQHahBp6chozJ2_uyYaZ2shRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptdfgudekieeguefhleehfedthffggeefgfduueeihfeuueelkeevtedv
    iedtvdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:-piQZKdyANQCjlfvC15_hiRBxwLH6BEMK4Y6FyTRBzc3IslCEiNDbQ>
    <xmx:-piQZHOfamvmiQrrU2zEM-FkSjlQajYV7xRYXNnZ9cIgN5SzG9_5gQ>
    <xmx:-piQZEnSkcBdn0a_8AexsHv7VZZKyxGdasmKcTbPLxbp5wJFSTCV1Q>
    <xmx:_JiQZIH00wufb4N7gDttWPr0n32bTamPtYrgnLjRw1exojLCKY20bA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 14:05:46 -0400 (EDT)
Date:   Mon, 19 Jun 2023 20:05:44 +0200
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
Message-ID: <yj6ss64s7p2uaslodj5zklrwhegz54bgh4l4wmldv6cccggepz@yombds4hij3c>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
 <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
 <87bkhbhnol.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wprkehaddrchdknb"
Content-Disposition: inline
In-Reply-To: <87bkhbhnol.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wprkehaddrchdknb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 10:16:26AM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> the essence of my following ramblings:
>  - I do think it is reasonable that nkm is asking its parent for the
>    rate that nkm actually needs from said parent to fulfill the request.
>  - I don't think nkm should make assumptions about the rounding
>    behaviour of the parent.

I guess we agree :)

And I would go even further and say that we shouldn't make *any*
assumption about the behaviour of the parent.

> The reason is, that I want to prevent users of ccu_nkm from making
> mistakes when defining their clocks (which includes the parent of their
> nkm clock).
>
> Please read below the details on why I think that.
>
> [...]
>
> >> No. I didn't. My assumption is: If ccu_nkm_find_best is asked for the
> >> best rate for rate =3D 449035712, it should try to include 449035712 in
> >> its candidates, agreed?
> >>
> >> Example 1:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> rate=3D449035712, n=3D11, k=3D3, m=3D16:
> >> We should as for a parent rate of 217714285, because:
> >> 217714285 * 11 * 3 / 16 =3D 449035712
> >>
> >> How do we get from 449035712 to 217714285, you ask?
> >>
> >>       DIV_ROUND_UP(rate * m, n * k)
> >
> > Why are we rounding up? I don't think the hardware will round up there.
>=20
> Being a "software guy" it is also my understanding that the hardware
> does not round up here (or round down for that matter).

That's my understanding as well.

> But anyway, my concern is the rate's representation *in software*. The
> clk drivers are using unsigned long to represent the actual rate. This
> is not a lossless representation. In other words, the value (i.e. the
> software representation) of that rate is, of course, a "lie". The
> hardware clock is running at some rate that is hopefully close to what
> we represent in software, but still it's an abstraction.
>=20
> For example, the user (e.g. in my example a panel) asks us for a rate
> that is represented in softwares as 449035712. Given the values n=3D11,
> k=3D3, m=3D16, we can *only* represent this value in software if the pare=
nt
> gives us a rate that is represented in software as 217714285. Therefore,
> I think it is reasonable to ask the parent for that rate (217714285).

I somewhat agree, but I still don't think it's worth rounding up.

If we don't round up (and assuming the parent itself won't round the
clock), we end up with a rate of 449035710 using the dividers you
mentioned. It's a .0000005% deviation (I hope I didn't screw up the
number of 0s). It's negligible for all practical purposes, and it's not
worth making the code inconsistent and eyebrow raising.

> >> Do you agree that we should ask the parent for 217714285 in case we wa=
nt
> >> a rate of 449035712 and we're currently evaluating the case n=3D11, k=
=3D3,
> >> m=3D16?
> >>
> >> We should not ask for a parent rate of 217714284, because:
> >> 217714284 * 11 * 3 / 16 =3D 449035710
> >>
> >> Example 2:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> rate=3D500000000, n=3D11, k=3D3, m=3D16:
> >> Here we should not ask the parent for
> >>       DIV_ROUND_UP(rate * m, n * k)
> >> because that would be 242424243.
> >>
> >> 242424243 * 11 * 3 / 16 =3D 500000001
> >>
> >> We (the NKM clock, not the parent!) would overshoot (please see at the
> >> end of this mail, why (for now) I don't want to support overshooting in
> >> the NKM clock).
> >>
> >> Instead we should as for a parent rate of 242424242, because:
> >> 242424242 * 11 * 3 / 16 =3D 499999999
> >>
> >> In conclusion, there are cases, where we (the NKM clock) have to ask t=
he
> >> parent for
> >>       DIV_ROUND_UP(rate * m, n * k)
> >> And there are also cases, where we have to ask the parent for
> >>       rate * m / (n * k)
> >
> > I mean, I think you're overthinking this.
> >
> > If you never round up and mimic how the hardware behaves, and test all
> > combination, then eventually you'll find the closest rate.
> >
> > If you don't because the parent doesn't look for the closest rate, then
> > the parent should be changed too.
> >
> > It really is that simple.
> >
> >> This is what the code is trying to do. Maybe it's easier to look at V2
> >> because I extracted the calcultion of the optimal parent rate into a
> >> separate function hoping that this makes things clearer.
> >>
> >> Let me stress this: When calculating the optimal rate for the parent,
> >> I'm not making any assumptions here about how the PARENT clock rounds.
> >> In fact, I assume that the parent could be perfect and always provides
> >> the rate it is asked for. I only take into account how the nkm clock
> >> rounds.
> >
> > At the very least, you assume that the parent rounding can be "wrong"
> > and try to work around that.
>=20
> No. I'm not assuming anything about the parent. But I *know* that if we
> (nkm) want to get a rate that is represented in softwares as 449035712
> and given the values n=3D11, k=3D3, m=3D16, we (nkm) must get the rate fr=
om
> the parent that the parent represents in software as 217714285, because
> I know that we (nkm) calculate *our* (nkm) rate using
>     parent * n * k / m
>=20
> So if (!) we want to give the user the rate that they ask for, why not
> ask the parent for the rate that we need (217714285)?
>=20
> I admit that I'm making assumptions here. My assumptions are that we
>  a. want to at least try to give the user what they asked for
>  b. without making assumptions about the parent's behaviour.
>=20
> Those assumptions could of course be wrong, but, honestly, I would find
> that confusing.

I guess my point leans more towards the "social" side than the
mathematical one. If I followed you so far, the precision you expect to
gain is in the <1Hz range (and I've been in sick leave for a while, so
sorry if I didn't before). The rate is in the 100MHz range.

So the precision gain is pretty much nothing. Sure, it's closer from a
mathematical standpoint. But there's zero benefit from it.

However, it comes at the cost of a code that is definitely more
complicated (or less naive, depending on how you look at it I guess :))
and will be harder to figure out for someone that jumps into the driver.

So the trade-off doesn't really make fixing it worth it to me.

> >> > you ask the parent to compute whatever is closest to that optimal pa=
rent
> >> > rate.
> >> >
> >> > It's the parent responsibility now. It's the parent decision to figu=
re
> >> > out what "the closest" means, if it can change rate, if it has any r=
ange
> >> > limitation, etc. You can't work around that.
> >> >
> >> > What you actually want there is the parent to actually provide the
> >> > closest rate, even if it means overshooting.
> >> >
> >>
> >> I want to ask the parent for a rate, that would actually result in the
> >> rate that nkm_find_best was asked for. Are you asking me to instead ask
> >> the parent for a rate that doesn't fit that criterion?
> >
> > No. I'm asking to call clk_hw_round_rate(parent_hw, rate * m / (n * k))
> > and use whatever value it returned.
> >
> > If it requires changing the parent clock to improve its round_rate
> > behaviour, then do that too.
> >
>=20
> Hmmm... Okay. So you *are* saying, that I should make changes to the
> parent so that we do not need to request the exact rate we want from the
> parent. But I really don't understand why.

No, sorry. I initially thought that you were working around "divider"
rounding issue (as opposed to integer like you mentionned above) with
the parent not providing its optimal rate, and you adjusting based on
that offset.

> As I wrote above, I'm not making any assumptions of how and if the
> parent rounds. My code is rounding *prior* to asking the parent. Your
> proposal on the other hand *requires* changing the parent to round
> closest where mine does not.
>=20
> My concern is, that we could then end up with the situation that someone
> defines an nkm clock in their SoC which has CLK_SET_RATE_PARENT set, but
> does not set the ROUND_CLOSEST flag on the parent, because it's not
> immediately apparent why they should do that.

It's going to happen, and probably happens at the moment already,
because not only the NKM clocks are affected, but virtually all of them,
and most don't use ROUND_CLOSEST.

And to some extent, it's fine. We would handle it like any other bug: if
we ever encounter one, we'll write a fix, backport it to stable and all
will be fine.

You can't figure out all the use-cases we'll require in the future
anyway.

> Let's assume that hypothetical board were the A64, the nkm clock were pll=
-mipi,
> and the parent were pll-video0 and we "forget" to set ROUND_CLOSEST on
> pll-video0:
>=20
> When pll-mipi nkm clock is asked via determine_rate() for a rate of
> 449064000 it would return 449035712 and a parent rate of 217714285
> (using n=3D11, k=3D3, m=3D16, but those details aren't returned by
> determine_rate()).
>=20
> Eventually, determine_rate() will be called again, but this time for a
> rate of 449035712. The user already knows that we can provide that,
> because we told them (see previous paragraph). But since we're
> truncating when calculating the rate that we'd like the parent to
> provide, we end up asking the parent for 217714284 when we actually need
> it to provide 217714285. So we now *require* the parent to find the
> closest and additionally we must *hope* that the parent is incapable of
> providing the rate that we asked for.

I mean... yeah. It's what abstraction is all about. For all we know, the
parent to pll-mipi could be a crystal that can't change its frequency
and we should deal with that. Or it could be an ideal clock that always
returns the rate you ask for. Or a firmware clock that behaves like an
ideal clock but lies about it :)

It's that clock responsibility to do its best to provide the rate we ask
for.

And if we need to make it behave better, then it's fine too. So your
example is indeed true, but it's more of a case of "let's send another
patch" rather than trying to figure out all possible cases and try to
figure things out accordingly. Because you won't be able to figure out
all possible cases for the current SoCs and the next ones, and the
workloads that people are going to run on those SoCs anyway.

> >> If you carefully look at ccu_mp, you will see that it would ignore
> >> cases when its parent had rounded up. ccu_nkm is no different.
> >> Teaching all of sunxi-ng's clocks to respect ROUND_CLOSEST is a
> >> totally different beast. For now, sunxi-ng always expects rounding
> >> down.
> >
> > Then change that?
>=20
> You told me that both over- and undershooting are fine when
> determining the rate, *but also* "it's a bit context specific which one
> we should favour. If we were to do anything, it would be to support both
> and let the clock driver select which behaviour it wants." (see
> https://lore.kernel.org/all/flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwf=
iuznk@eewnnut5mvsq/)
>=20
> So, I can't just change NKM's parent's default behavior (which is an NM
> clock in my case), because, if I understand correctly, I would have to
> introduce a "ROUND_CLOSEST" flag for NM clocks.

Sure

> But then I feel like I would have to document somewhere that when
> setting CLK_SET_RATE_PARENT for an NKM clock, that the parent clock
> needs to ROUND_CLOSEST, in order to avoid drifting away from the
> requested rate in the successive calls that are made to
> ccu_nkm_determine_rate(), which I tried to explain above and in previous
> messages.

That's kind of what I meant too. Whether "drifting away" is an issue is
context specific too. for some clocks it just doesn't matter. Nobody
ever complained that the register clock of the MMC controller was
drifting away, because it doesn't affect the system in the slightest.

The video clock tree (and possibly others) will be affected though, and
we'll indeed need to add that flag. But we're doing it all the time (and
sometimes get it wrong) for things like which clocks should be left
enabled for example.

> Instead we could introduce the following function, like I suggested in
> V2 of this patchset. The advantage is that it both *documents* the
> dilemma for developers of ccu_nkm and also *avoids* it for users of
> ccu_nkm.
>=20
> static unsigned long optimal_parent_rate(unsigned long rate, unsigned lon=
g n,
> 				 unsigned long k, unsigned long m)
> {
> 	unsigned long _rate, parent;
>=20
> 	// We must first try to find the desired parent rate that is rounded up,=
 because there are
> 	// cases where truncating makes us miss the requested rate.
> 	// E.g. rate=3D449035712, n=3D11, k=3D3, m=3D16
> 	// When truncating, we'd get parent=3D217714284 and calculating the rate=
 from that would give
> 	// us 449035710. When rounding up, we get parent=3D217714285 which would=
 give us the requested
> 	// rate of 449035712.
> 	parent =3D DIV_ROUND_UP(rate * m, n * k);
>=20
> 	// But there are other cases, where rounding up the parent gives us a to=
o high rate.
> 	// Therefore, we need to check for this case and, if necessary, truncate=
 the parent rate
> 	// instead of rounding up.
> 	_rate =3D parent * n * k / m;
> 	if (_rate > rate)
> 		parent =3D rate * m / (n * k);
> 	return parent;
> }
>=20
> And then we ask the parent for that optimal parent rate we just
> calculated. I feel like that's an easy thing to do.

We're back to the trade-off I was mentioning earlier. I'm not against it
on principle. However, if it's not absolutely required, then I don't
think it's a good idea to merge it.

Especially if it's to workaround a parent flag missing. A clock flag
patch is easy to read, write, understand, review, merge and maintain.
It's basically a nop to merge provided the commit log is decent enough.

That function is none of those things.

Maxime

--wprkehaddrchdknb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZJCY+AAKCRDj7w1vZxhR
xYPGAQDqaPGRRdu92BOGsrqSfDX6VPP28nVp2Y/Ji2VE56LAwAEA2BAxuGYnB+Kd
hQagMPrGDx93QjNJzmt/M0ALoZa40wc=
=Gwwl
-----END PGP SIGNATURE-----

--wprkehaddrchdknb--
