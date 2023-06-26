Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7073E5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjFZQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjFZQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:46:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90E6E6F;
        Mon, 26 Jun 2023 09:46:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CF8103200907;
        Mon, 26 Jun 2023 12:46:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 26 Jun 2023 12:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687797996; x=1687884396; bh=M0
        QZH2Qh6kSv3lUq/2O/xETbbTPi4QR2yFh8SDElxNQ=; b=FOilOjoEKRIntqH3FP
        GAah2CR9wnR9L88Z4xDPuMR5YlUjD22C6lmddMUWcYlaA1gYBGsOCnOFRU/fJHal
        O+u/o6K8tBxpXPRUJe2DX3ClgbF1XKxwWyYkC3MWuBoLe7h/v18BAa45+mtl5oLO
        EXFIr3uIyQwmuBI0Re64mtN91xwfuyFnHl+nZfFSXKAiLbiltmmti68RFS/qEGwg
        jnL5zRmfsRGltUpTihpwCKoRSLDw1caMj0DCLiSBh0RYed/bufgDgVPjlp6qoFqW
        TIMkInkHmWAuY7PKcQvEyd/uBwwaWyKokGDj7nKgAN9stv3qTVMuqRefm1Xy5vfe
        m+Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687797996; x=1687884396; bh=M0QZH2Qh6kSv3
        lUq/2O/xETbbTPi4QR2yFh8SDElxNQ=; b=A/7QCmbcrIYjQdMDeJv7lP4IENkf1
        bYutr9c9OC9W2OucRumSc8vm2I5AI3wX8v78KJyoLIme/Iqv8OT4RPouddk+B3lD
        Ul4jJy+ghksLCpa8fev26MkmwjpUwpS15CCPpPWMwDgGvZFbjWXwJkWdDXWbi82p
        lsulmLf9sgjbQPInVeilDDsZFjZYrAKq6xFVOzlsi9DUSA6drXqA2b0BIqk5sZuZ
        tVEgbt+31nJhnl4tRSR4v1UsC9qAkYbJK8rsYajQY0ZjCtboZch1LDwItAFSf3Ho
        3Ha6e1lK48I/IPnhcuM+WTSeNdUdOdQSw7218A8M8CMsfcYc9TD9IEOEg==
X-ME-Sender: <xms:68CZZFeuMxb_UhyWetAIhbEvzylnyMYGMDiEMEYZlOponE7XvWBtZA>
    <xme:68CZZDOBzVS4F_YOdBeLJO5LhTOltNa4Mo04SzeiYKWbRZ1cLFl7GrmdzDUJXPhGI
    Ui1fl0Wp2Bh0XVbTUk>
X-ME-Received: <xmr:68CZZOgs-AmnbMRXlgoiqvKDPsrEuSnPe39XNi_4oeBIzEA4CyakAoLU2MDU5LJoFIcq2Tl8Cp0mbP0KJVuafw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptdfgudekieeguefhleehfedthffggeefgfduueeihfeuueelkeevtedv
    iedtvdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:68CZZO_6xhHY6y2HBmry2CWtQuhmqcoQ6ir0tErIy9LBMMfwPgPZwQ>
    <xmx:68CZZBtWwym_D50Dc9IwpiH4RTcqqW5O_qCIQnk9IJyimFH1ToOJEg>
    <xmx:68CZZNGHUpMLVAaAsWQZbP5Z70EceOQXqS_U598JGvAXpD64gJshmA>
    <xmx:7MCZZCml59XzaG79hSznTWGc2vr9pcNf4fsaeN2XOXOkvPJ5rLjSng>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 12:46:34 -0400 (EDT)
Date:   Mon, 26 Jun 2023 18:45:56 +0200
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
Message-ID: <5bsjar6mtljdipmntc37lkje3icee64s776u4ug5ains5qjqm3@sux2lnpzcm5c>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
 <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
 <87bkhbhnol.fsf@oltmanns.dev>
 <yj6ss64s7p2uaslodj5zklrwhegz54bgh4l4wmldv6cccggepz@yombds4hij3c>
 <87jzvyotlc.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4mut7bznth3bkdm2"
Content-Disposition: inline
In-Reply-To: <87jzvyotlc.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4mut7bznth3bkdm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 08:51:27PM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> thank you for your detailed response. I really appreciate it!
>=20
> On 2023-06-19 at 20:05:44 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Mon, Jun 19, 2023 at 10:16:26AM +0200, Frank Oltmanns wrote:
> >> Hi Maxime,
> >>
> >> the essence of my following ramblings:
> >>  - I do think it is reasonable that nkm is asking its parent for the
> >>    rate that nkm actually needs from said parent to fulfill the reques=
t.
> >>  - I don't think nkm should make assumptions about the rounding
> >>    behaviour of the parent.
> >
> > I guess we agree :)
> >
> > And I would go even further and say that we shouldn't make *any*
> > assumption about the behaviour of the parent.
> >
> >> The reason is, that I want to prevent users of ccu_nkm from making
> >> mistakes when defining their clocks (which includes the parent of their
> >> nkm clock).
> >>
> >> Please read below the details on why I think that.
> >>
> >> [...]
> >>
> >> >> No. I didn't. My assumption is: If ccu_nkm_find_best is asked for t=
he
> >> >> best rate for rate =3D 449035712, it should try to include 44903571=
2 in
> >> >> its candidates, agreed?
> >> >>
> >> >> Example 1:
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> rate=3D449035712, n=3D11, k=3D3, m=3D16:
> >> >> We should as for a parent rate of 217714285, because:
> >> >> 217714285 * 11 * 3 / 16 =3D 449035712
> >> >>
> >> >> How do we get from 449035712 to 217714285, you ask?
> >> >>
> >> >>       DIV_ROUND_UP(rate * m, n * k)
> >> >
> >> > Why are we rounding up? I don't think the hardware will round up the=
re.
> >>
> >> Being a "software guy" it is also my understanding that the hardware
> >> does not round up here (or round down for that matter).
> >
> > That's my understanding as well.
> >
> >> But anyway, my concern is the rate's representation *in software*. The
> >> clk drivers are using unsigned long to represent the actual rate. This
> >> is not a lossless representation. In other words, the value (i.e. the
> >> software representation) of that rate is, of course, a "lie". The
> >> hardware clock is running at some rate that is hopefully close to what
> >> we represent in software, but still it's an abstraction.
> >>
> >> For example, the user (e.g. in my example a panel) asks us for a rate
> >> that is represented in softwares as 449035712. Given the values n=3D11,
> >> k=3D3, m=3D16, we can *only* represent this value in software if the p=
arent
> >> gives us a rate that is represented in software as 217714285. Therefor=
e,
> >> I think it is reasonable to ask the parent for that rate (217714285).
> >
> > I somewhat agree, but I still don't think it's worth rounding up.
> >
> > If we don't round up (and assuming the parent itself won't round the
> > clock), we end up with a rate of 449035710 using the dividers you
> > mentioned. It's a .0000005% deviation (I hope I didn't screw up the
> > number of 0s). It's negligible for all practical purposes, and it's not
> > worth making the code inconsistent and eyebrow raising.
> >
> >> >> Do you agree that we should ask the parent for 217714285 in case we=
 want
> >> >> a rate of 449035712 and we're currently evaluating the case n=3D11,=
 k=3D3,
> >> >> m=3D16?
> >> >>
> >> >> We should not ask for a parent rate of 217714284, because:
> >> >> 217714284 * 11 * 3 / 16 =3D 449035710
> >> >>
> >> >> Example 2:
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> rate=3D500000000, n=3D11, k=3D3, m=3D16:
> >> >> Here we should not ask the parent for
> >> >>       DIV_ROUND_UP(rate * m, n * k)
> >> >> because that would be 242424243.
> >> >>
> >> >> 242424243 * 11 * 3 / 16 =3D 500000001
> >> >>
> >> >> We (the NKM clock, not the parent!) would overshoot (please see at =
the
> >> >> end of this mail, why (for now) I don't want to support overshootin=
g in
> >> >> the NKM clock).
> >> >>
> >> >> Instead we should as for a parent rate of 242424242, because:
> >> >> 242424242 * 11 * 3 / 16 =3D 499999999
> >> >>
> >> >> In conclusion, there are cases, where we (the NKM clock) have to as=
k the
> >> >> parent for
> >> >>       DIV_ROUND_UP(rate * m, n * k)
> >> >> And there are also cases, where we have to ask the parent for
> >> >>       rate * m / (n * k)
> >> >
> >> > I mean, I think you're overthinking this.
> >> >
> >> > If you never round up and mimic how the hardware behaves, and test a=
ll
> >> > combination, then eventually you'll find the closest rate.
> >> >
> >> > If you don't because the parent doesn't look for the closest rate, t=
hen
> >> > the parent should be changed too.
> >> >
> >> > It really is that simple.
> >> >
> >> >> This is what the code is trying to do. Maybe it's easier to look at=
 V2
> >> >> because I extracted the calcultion of the optimal parent rate into a
> >> >> separate function hoping that this makes things clearer.
> >> >>
> >> >> Let me stress this: When calculating the optimal rate for the paren=
t,
> >> >> I'm not making any assumptions here about how the PARENT clock roun=
ds.
> >> >> In fact, I assume that the parent could be perfect and always provi=
des
> >> >> the rate it is asked for. I only take into account how the nkm clock
> >> >> rounds.
> >> >
> >> > At the very least, you assume that the parent rounding can be "wrong"
> >> > and try to work around that.
> >>
> >> No. I'm not assuming anything about the parent. But I *know* that if we
> >> (nkm) want to get a rate that is represented in softwares as 449035712
> >> and given the values n=3D11, k=3D3, m=3D16, we (nkm) must get the rate=
 from
> >> the parent that the parent represents in software as 217714285, because
> >> I know that we (nkm) calculate *our* (nkm) rate using
> >>     parent * n * k / m
> >>
> >> So if (!) we want to give the user the rate that they ask for, why not
> >> ask the parent for the rate that we need (217714285)?
> >>
> >> I admit that I'm making assumptions here. My assumptions are that we
> >>  a. want to at least try to give the user what they asked for
> >>  b. without making assumptions about the parent's behaviour.
> >>
> >> Those assumptions could of course be wrong, but, honestly, I would find
> >> that confusing.
> >
> > I guess my point leans more towards the "social" side than the
> > mathematical one. If I followed you so far, the precision you expect to
> > gain is in the <1Hz range
>=20
> Ok, just for the sake of correctness: Actually, I'm concerned with the
> fact what happens, if someone "forgets" or doesn't know they have to set
> the flag and what happens when calling round rate.

I understand your concern, but unfortunately, there's no real way to
defend against that. You could make the same point about the parent
clock being wrong, the critical clocks not being flagged properly, etc.

At the end of the day, the clock drivers have to be properly defined to
behave properly.

We have to trust it.

> Because then in the end we get 449018180 instead of 449035712. That's
> more than 1 Hz. But anyway, I understand your point that a gain of
> precision of the approximately 0,004% is not worth the additional
> code. (Actually, I don't know how precise the clocks are, but I'd
> guess it could easily be lower than 99,996%.)
>=20
> > (and I've been in sick leave for a while, so sorry if I didn't
> > before).
>=20
> I hope you feel better.

I do, thanks for asking :)

> > The rate is in the 100MHz range.
> >
> > So the precision gain is pretty much nothing. Sure, it's closer from a
> > mathematical standpoint. But there's zero benefit from it.
> >
> > However, it comes at the cost of a code that is definitely more
> > complicated (or less naive, depending on how you look at it I guess :))
> > and will be harder to figure out for someone that jumps into the driver.
> >
> > So the trade-off doesn't really make fixing it worth it to me.
> >
>=20
> Ok, understood.
>=20
> >
> >> >> > you ask the parent to compute whatever is closest to that optimal=
 parent
> >> >> > rate.
> >> >> >
> >> >> > It's the parent responsibility now. It's the parent decision to f=
igure
> >> >> > out what "the closest" means, if it can change rate, if it has an=
y range
> >> >> > limitation, etc. You can't work around that.
> >> >> >
> >> >> > What you actually want there is the parent to actually provide the
> >> >> > closest rate, even if it means overshooting.
> >> >> >
> >> >>
> >> >> I want to ask the parent for a rate, that would actually result in =
the
> >> >> rate that nkm_find_best was asked for. Are you asking me to instead=
 ask
> >> >> the parent for a rate that doesn't fit that criterion?
> >> >
> >> > No. I'm asking to call clk_hw_round_rate(parent_hw, rate * m / (n * =
k))
> >> > and use whatever value it returned.
> >> >
> >> > If it requires changing the parent clock to improve its round_rate
> >> > behaviour, then do that too.
> >> >
> >>
> >> Hmmm... Okay. So you *are* saying, that I should make changes to the
> >> parent so that we do not need to request the exact rate we want from t=
he
> >> parent. But I really don't understand why.
> >
> > No, sorry. I initially thought that you were working around "divider"
> > rounding issue (as opposed to integer like you mentionned above) with
> > the parent not providing its optimal rate, and you adjusting based on
> > that offset.
> >
> >> As I wrote above, I'm not making any assumptions of how and if the
> >> parent rounds. My code is rounding *prior* to asking the parent. Your
> >> proposal on the other hand *requires* changing the parent to round
> >> closest where mine does not.
> >>
> >> My concern is, that we could then end up with the situation that someo=
ne
> >> defines an nkm clock in their SoC which has CLK_SET_RATE_PARENT set, b=
ut
> >> does not set the ROUND_CLOSEST flag on the parent, because it's not
> >> immediately apparent why they should do that.
> >
> > It's going to happen, and probably happens at the moment already,
> > because not only the NKM clocks are affected, but virtually all of them,
> > and most don't use ROUND_CLOSEST.
> >
> > And to some extent, it's fine. We would handle it like any other bug: if
> > we ever encounter one, we'll write a fix, backport it to stable and all
> > will be fine.
>=20
> Ok, understood.
>=20
> >
> > You can't figure out all the use-cases we'll require in the future
> > anyway.
>=20
> Well, that much is certain. :)
>=20
> >
> >> Let's assume that hypothetical board were the A64, the nkm clock were =
pll-mipi,
> >> and the parent were pll-video0 and we "forget" to set ROUND_CLOSEST on
> >> pll-video0:
> >>
> >> When pll-mipi nkm clock is asked via determine_rate() for a rate of
> >> 449064000 it would return 449035712 and a parent rate of 217714285
> >> (using n=3D11, k=3D3, m=3D16, but those details aren't returned by
> >> determine_rate()).
> >>
> >> Eventually, determine_rate() will be called again, but this time for a
> >> rate of 449035712. The user already knows that we can provide that,
> >> because we told them (see previous paragraph). But since we're
> >> truncating when calculating the rate that we'd like the parent to
> >> provide, we end up asking the parent for 217714284 when we actually ne=
ed
> >> it to provide 217714285. So we now *require* the parent to find the
> >> closest and additionally we must *hope* that the parent is incapable of
> >> providing the rate that we asked for.
> >
> > I mean... yeah. It's what abstraction is all about. For all we know, the
> > parent to pll-mipi could be a crystal that can't change its frequency
> > and we should deal with that. Or it could be an ideal clock that always
> > returns the rate you ask for. Or a firmware clock that behaves like an
> > ideal clock but lies about it :)
> >
> > It's that clock responsibility to do its best to provide the rate we ask
> > for.
> >
> > And if we need to make it behave better, then it's fine too. So your
> > example is indeed true, but it's more of a case of "let's send another
> > patch" rather than trying to figure out all possible cases and try to
> > figure things out accordingly. Because you won't be able to figure out
> > all possible cases for the current SoCs and the next ones, and the
> > workloads that people are going to run on those SoCs anyway.
> >
> >> >> If you carefully look at ccu_mp, you will see that it would ignore
> >> >> cases when its parent had rounded up. ccu_nkm is no different.
> >> >> Teaching all of sunxi-ng's clocks to respect ROUND_CLOSEST is a
> >> >> totally different beast. For now, sunxi-ng always expects rounding
> >> >> down.
> >> >
> >> > Then change that?
> >>
> >> You told me that both over- and undershooting are fine when
> >> determining the rate, *but also* "it's a bit context specific which one
> >> we should favour. If we were to do anything, it would be to support bo=
th
> >> and let the clock driver select which behaviour it wants." (see
> >> https://lore.kernel.org/all/flngzi4henkzcpzwdexencdkw77h52g3nduup7pwct=
pwfiuznk@eewnnut5mvsq/)
> >>
> >> So, I can't just change NKM's parent's default behavior (which is an NM
> >> clock in my case), because, if I understand correctly, I would have to
> >> introduce a "ROUND_CLOSEST" flag for NM clocks.
> >
> > Sure
> >
> >> But then I feel like I would have to document somewhere that when
> >> setting CLK_SET_RATE_PARENT for an NKM clock, that the parent clock
> >> needs to ROUND_CLOSEST, in order to avoid drifting away from the
> >> requested rate in the successive calls that are made to
> >> ccu_nkm_determine_rate(), which I tried to explain above and in previo=
us
> >> messages.
> >
> > That's kind of what I meant too. Whether "drifting away" is an issue is
> > context specific too. for some clocks it just doesn't matter. Nobody
> > ever complained that the register clock of the MMC controller was
> > drifting away, because it doesn't affect the system in the slightest.
> >
> > The video clock tree (and possibly others) will be affected though, and
> > we'll indeed need to add that flag. But we're doing it all the time (and
> > sometimes get it wrong) for things like which clocks should be left
> > enabled for example.
> >
> >> Instead we could introduce the following function, like I suggested in
> >> V2 of this patchset. The advantage is that it both *documents* the
> >> dilemma for developers of ccu_nkm and also *avoids* it for users of
> >> ccu_nkm.
> >>
> >> static unsigned long optimal_parent_rate(unsigned long rate, unsigned =
long n,
> >> 				 unsigned long k, unsigned long m)
> >> {
> >> 	unsigned long _rate, parent;
> >>
> >> 	// We must first try to find the desired parent rate that is rounded =
up, because there are
> >> 	// cases where truncating makes us miss the requested rate.
> >> 	// E.g. rate=3D449035712, n=3D11, k=3D3, m=3D16
> >> 	// When truncating, we'd get parent=3D217714284 and calculating the r=
ate from that would give
> >> 	// us 449035710. When rounding up, we get parent=3D217714285 which wo=
uld give us the requested
> >> 	// rate of 449035712.
> >> 	parent =3D DIV_ROUND_UP(rate * m, n * k);
> >>
> >> 	// But there are other cases, where rounding up the parent gives us a=
 too high rate.
> >> 	// Therefore, we need to check for this case and, if necessary, trunc=
ate the parent rate
> >> 	// instead of rounding up.
> >> 	_rate =3D parent * n * k / m;
> >> 	if (_rate > rate)
> >> 		parent =3D rate * m / (n * k);
> >> 	return parent;
> >> }
> >>
> >> And then we ask the parent for that optimal parent rate we just
> >> calculated. I feel like that's an easy thing to do.
> >
> > We're back to the trade-off I was mentioning earlier. I'm not against it
> > on principle. However, if it's not absolutely required, then I don't
> > think it's a good idea to merge it.
> >
> > Especially if it's to workaround a parent flag missing. A clock flag
> > patch is easy to read, write, understand, review, merge and maintain.
> > It's basically a nop to merge provided the commit log is decent enough.
> >
> > That function is none of those things.
> >
>=20
> Ok, thank you for all the explanations! I now feel, we have a common
> understanding and that's great.
>=20
> I will proceed with preparing a V3 of this patchset, that will also
> introduce CCU_FEATURE_CLOSEST_RATE and an implementation for ccu_nm,
> ccu_nkm and the necessary updates on the (combined) mux clocks and
> divisor clocks. The flag will be used in pll-video0 of the A64 and all
> of its descendents.
>=20
> That version will also have a separate function
> ccu_nkm_find_best_with_parent_adj, so that it's more similar to the
> implementation of e.g. ccu_mp.

Awesome, thanks

Maxime

--4mut7bznth3bkdm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZJnAvwAKCRDj7w1vZxhR
xUXHAQD4L38JbuKn9AXwqE57G1ox4tx1tdz3wMuJ66qHUfeRogEAy1cgmNEK6jMf
ZMVxjts9WnNukMVR3hFE0XXkCVT31QY=
=s9H+
-----END PGP SIGNATURE-----

--4mut7bznth3bkdm2--
