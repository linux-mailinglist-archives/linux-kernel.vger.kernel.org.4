Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D972DD52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbjFMJK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjFMJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:10:24 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02C199E;
        Tue, 13 Jun 2023 02:10:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D95945C0130;
        Tue, 13 Jun 2023 05:10:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 13 Jun 2023 05:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686647410; x=1686733810; bh=Xx
        Dff4Fejz02X7WPEdonpnX6HhCRjCS9ZRoXoiSIgKM=; b=zYljGyA40vEtzOuHVf
        ksXiKEl6Z6fNyzHW+AyurKDEi/N2GTJBiWTRyJY4KdzVSWYRQyFyd/AgVZyHDv5A
        oAF4h/bZAeMdidm00M2+OvLtdmJMYfiRhoFBXY3QCE7SE9xRLCFoTURH/4GKp7Iy
        /0Le6uSV76kdRaWEqasNIwiPGxjtw67qgXcK1lbEy5Vkx6GqTwcC6eAqeA78jTFC
        EIMrNvbW+IphsQpKxpn6d2D8yzmPjeIf1MEY5xiwQTWvGz50gGCBuiZqzmMcGpkS
        EAykq6VYtFwhdH+3ZJQhbQnNk0w7QQ99ZpuFvSXmgNIK53sOrUY6PYyE6ZIJjwkj
        e8bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686647410; x=1686733810; bh=XxDff4Fejz02X
        7WPEdonpnX6HhCRjCS9ZRoXoiSIgKM=; b=Q6hOkeuRBRWQOfOeMmMDr2kVqXLbH
        Hj9/WYUKKFbrJ+p8/8BtEnrsf5SCtaWy7OLTGF2Q6XxDlO/k9rSy6LZBo7dV5IU5
        Ed5oNcP0aImXyYurxQxvg4slB0Z8YJtzFINXmRfM0LQDHPolTzliV2DK13IVdWeY
        E88n61ZURfBtEyUgurYEaU10H/CURueipxmEfi9GWCKjn3eVRCO8SL8/H8ImtWIt
        020SYnmRPYmLKWqtR8sTz9fdsqKE5v2No13mPLWVUURdsxwG2bRx+IMDvhqAsNXa
        d6sbK4Yt7PPGFnfAH/OebHw+fVEyGqe4zc4spJivD0p8TLQCj3bPUGGQg==
X-ME-Sender: <xms:cjKIZMacCepDtYMHUX5OL-6-BIjVP3RElm_n7p01ZnUccJk_Gy9GGA>
    <xme:cjKIZHbAb8tdwNGU_IDp2RO5mjk1j9VrFoRVqButg2Rn3D_O7IEIxWYkx_8yrrKdo
    bGucOt4mPUTg4IqlGk>
X-ME-Received: <xmr:cjKIZG9Op71aiBpCO3Q4pYRSVgnMXAhL2KaM_rKETzLFo4VbLoKwBe6QLv_wM5zUXH8u5pjE_N7sWC7yOuDu1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:cjKIZGqL6-XMWhHuRaY732JkUcJZZrAC4wKE99pQ5Gna0CWMU8p6DA>
    <xmx:cjKIZHpchzIkB6yMzgFGOTaVuIN4WJjfKkDfxpAR35mjmzeaBfBHyg>
    <xmx:cjKIZESYFq4yg-Ct1dyk_5pXxJprNi-yWXW8kMW8NbIrOEy6SL7JwA>
    <xmx:cjKIZEgBxhrvpmEWRU8dm1pdVecaKaj2ZP89t1I99rhodGezatbpeA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 05:10:09 -0400 (EDT)
Date:   Tue, 13 Jun 2023 11:10:08 +0200
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
Message-ID: <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6flo7htaj65edw6r"
Content-Disposition: inline
In-Reply-To: <87a5x41w5r.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6flo7htaj65edw6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 12, 2023 at 06:29:36PM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> I'm sorry that the following mail is a bit long. I'm not sure, there is
> some kind of misunderstanding/miscommunication somewhere, I'm just not
> sure, where. :)
>=20
> This mail is aiming at finding the exact points where we apparently go
> down different paths.
>=20
> On 2023-06-12 at 14:19:05 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Wed, Jun 07, 2023 at 09:39:35AM +0200, Frank Oltmanns wrote:
> >> Hi Maxime,
> >>
> >> On 2023-06-07 at 08:38:39 +0200, Maxime Ripard <maxime@cerno.tech> wro=
te:
> >> > [[PGP Signed Part:Undecided]]
> >> > On Mon, Jun 05, 2023 at 09:07:44PM +0200, Frank Oltmanns wrote:
> >> >> In case the CLK_SET_RATE_PARENT flag is set, consider using a diffe=
rent
> >> >> parent rate when determining a new rate.
> >> >>
> >> >> To find the best match for the requested rate, perform the following
> >> >> steps for each NKM combination:
> >> >>  - calculate the optimal parent rate,
> >> >>  - find the best parent rate that the parent clock actually supports
> >> >>  - use that parent rate to calculate the effective rate.
> >> >>
> >> >> In case the clk does not support setting the parent rate, use the s=
ame
> >> >> algorithm as before.
> >> >>
> >> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> >> ---
> >> >>  drivers/clk/sunxi-ng/ccu_nkm.c | 40 ++++++++++++++++++++++++++----=
----
> >> >>  1 file changed, 31 insertions(+), 9 deletions(-)
> >> >>
> >> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/=
ccu_nkm.c
> >> >> index a0978a50edae..c71e237226f2 100644
> >> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> >> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> >> >> @@ -16,10 +16,10 @@ struct _ccu_nkm {
> >> >>  	unsigned long	m, min_m, max_m;
> >> >>  };
> >> >>
> >> >> -static unsigned long ccu_nkm_find_best(unsigned long parent, unsig=
ned long rate,
> >> >> -				       struct _ccu_nkm *nkm)
> >> >> +static unsigned long ccu_nkm_find_best(unsigned long *parent, unsi=
gned long rate,
> >> >> +				       struct _ccu_nkm *nkm, struct clk_hw *parent_hw)
> >> >>  {
> >> >> -	unsigned long best_rate =3D 0;
> >> >> +	unsigned long best_rate =3D 0, best_parent_rate =3D 0, tmp_parent=
 =3D *parent;
> >> >>  	unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
> >> >>  	unsigned long _n, _k, _m;
> >> >>
> >> >> @@ -28,12 +28,29 @@ static unsigned long ccu_nkm_find_best(unsigned=
 long parent, unsigned long rate,
> >> >>  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
> >> >>  				unsigned long tmp_rate;
> >> >>
> >> >> -				tmp_rate =3D parent * _n * _k / _m;
> >> >> +				if (parent_hw) {
> >> >
> >> > NKM clocks always have a parent
> >> >
> >> > You should test if the CLK_SET_RATE_PARENT flag is set.
> >>
> >> ccu_nkm_find_best is called in the following two situations:
> >>  a. from ccu_nkm_set_rate when setting the rate
> >>  b. from ccu_nkm_round_rate when determining the rate
> >>
> >> In situation a. we never want ccu_nkm_find_best to try different parent
> >> rates because setting the parent rate is a done deal (at least that's =
my
> >> understanding).
> >>
> >> In situation b. we only want ccu_nkm_find_best to try different parent
> >> rates when, as you mentioned, the CLK_SET_RATE_PARENT flag is set.
> >
> > It doesn't really matter though. The output of that function must be
> > stable and must return the same set of factors and parent rate for a
> > given target rate.
> >
>=20
> I'm not sure if we're talking about the same thing here. Of course the
> set of factors and parent rate for a given target rate will be different
> depending on the fact if we can or cannot adjust the parent rate,
> agreed?

Yes, but here you also have a different behaviour in clk_round_rate()
and in clk_set_rate(), which isn't ok.

Basically, clk_set_rate() + clk_get_rate() must be equal to
clk_round_rate().

If you change if you look for parents depending on whether you're being
called in clk_round_rate() and clk_set_rate(), then you're breaking that
expectation.

> Let me compare my implementation to ccu_mp.
>=20
> ccu_mp_round_rate either calls the function ccu_mp_find_best or
> ccu_mp_find_best_with_parent_adj, depending on CLK_SET_RATE_PARENT.

Yes, and it's fine: the flag is per-clock, and the output is the same
depending on whether we're being called by clk_round_rate() and
clk_set_rate().

> I'm basically doing the same thing, but (!) ccu_nkm_find_best and
> ccu_nkm_find_best_with_parent_adj would be almost identical. Therefore,
> I opted to extend ccu_nkm_find_best to also support the parent
> adjustment. If you look at V2 of this patch, you will see that the only
> diffences are an if statement (if (parent_hw)) with two lines of code in
> the if's body and the fact that we need to store the best parent rate.
>=20
> If you prefer, I can split this into two separate functions like in
> ccu_mp. I think all the confusion is coming from the fact that I didn't.
> So apparently it was not a good idea to keep it as one function.
>=20
> Should I introduce ccu_nkm_find_best_with_parent_adj instead of using
> ccu_nkm_find_best for both cases?
>=20
> >
> > So you can call it as many times as you want, it doesn't really matter.
>=20
> Of course! What did I write that made you think, I thought otherwise?
>
> >
> >> So, what this patch does, it provides a NULL pointer as parent_hw when
> >> we don't want ccu_nkm_find_best to try alternative parent rates.
> >
> > At best, the argument is misleading then. You're not passing a pointer
> > to the parent, you're telling it whether it should look for other
> > parents or not. And it's not a pointer, it's a boolean.
>=20
> No, I'm using parent_hw and as a pointer a few lines below when calling
> clk_hw_round_rate. So I'd need a boolean AND a pointer. I always need
> the pointer if the boolean is true. I never need the pointer when the
> boolean is false. Therefore, I opted to choose to use the pointer for
> first being a boolean (in the if) and then being a pointer (when calling
> clk_hw_round_rate). This is the (hopefully easier to read) code from V2:
>=20
>         if (parent_hw) {
>                 tmp_parent =3D optimal_parent_rate(rate, _n, _k, _m);
>                 tmp_parent =3D clk_hw_round_rate(parent_hw, tmp_parent);
>         }

Again, that clock always has a parent. It's not the actual condition:
what you want to test is whether you want to forward the rate request to
the parent or not. So that condition is misleading.

> >> Is it ok if I add a comment to ccu_nkm_find_best that explains the
> >> function and explicitly also the parameters?
> >
> > Sure
>=20
> Done in V2.
>=20
> >
> >> I also thought about using two different functions for the two
> >> situations. I have no strong opinion which is better.
> >>
> >> However, I don't think we should hand over the flags to this function,
> >> because we'd still only need to provide the parent_hw if we want to
> >> find the optimal parent rate, so having two parametes for the same
> >> purpose seems redundant. Unless, there is a rule to not use NULL
> >> pointers.
> >
> > Again, the behaviour must be stable across all calling sites.
>=20
> No argument here.
>=20
> >
> >> >
> >> >> +					// We must round up the desired parent rate, because the
> >> >> +					// rounding down happens when calculating tmp_rate. If we
> >> >> +					// round down also here, we'd round down twice.
> >> >> +					unsigned long optimal_parent =3D
> >> >> +							(rate * _m + (_n * _k - 1)) / _n / _k;
> >> >
> >> > I assume the addition of n * k - 1 is to round up, but I'm not sure =
we
> >> > should hack around like that.
> >> >
> >> > You should compute the ideal parent rate for a given set of timings,=
 and
> >> > then just call round_rate on it. If the parent wants to round it one=
 way
> >> > or another, that's the parent concern.
> >>
> >> I admit that the comment explaining this is not doing the complexity of
> >> this issue any justice. Let me try to explain:
> >>
> >> Let's say for our panel the optimal rate for pll-mipi is 449064000. The
> >> best closest we can get is 449035712 with a parent rate of 217714285
> >> (n=3D11, k=3D3, m=3D16).
> >>
> >> Eventually, ccu_nkm_find_best is going to be called with 449035712 as
> >> the rate. If we don't round up, like I proposend, but instead calculat=
e:
> >>   optimal_parent =3D rate * m / n / k
> >> (which is, I think, what you you're proposing) leading to an optimal
> >> parent of 217714284 (!). We can't get 217714284 from the parent (we
> >> could get 217714285, but we're not asking for that) so the parent roun=
ds
> >> down.
> >>
> >> To make things worse, this story continues for the new "best rate" as
> >> well.
> >>
> >> In the end, ccu_nkm_find_best claims:
> >>  - the optimal rate for 449064000 is 449035712 (parent=3D217714285, n=
=3D11,
> >>    k=3D3, m=3D16)
> >>  - but ccu_nkm_find_best would claim that the optimal rate for 4490357=
12
> >>    is 449018181 (parent=3D235200000, n=3D7, k=3D3, m=3D11)
> >>  - and finally, the optimal rate for 449018181 is 449018180
> >>    (parent=3D213818181, n=3D7, k=3D3, m=3D10)
> >>
> >> This doesn't seem right to me.
> >>
> >> But you're also right, in that we can't just always round up. In a
> >> hypothetical example that we request a parent rate of 450000000. With
> >> rounding up, we'd get an optimal parent rate of 218181819 for n=3D11, =
k=3D3,
> >> m=3D16. And let's now further claim that the parent could provide exac=
tly
> >> that rate, we'd end up with a rate of 450000001. So, we'd overshoot,
> >> which (currently) is not acceptable.
> >>
> >> Hmm... I currently can't think of a clever way to solve this other than
> >> this:
> >>
> >>     optimal_parent =3D (rate * _m + (_n * _k - 1)) / _n / _k;
> >>     tmp_parent =3D clk_hw_round_rate(parent_hw, optimal_parent);
> >>     tmp_rate =3D tmp_parent * _n * _k / _m;
> >>     if (tmp_rate > rate) {
> >>         optimal_parent =3D rate * m / n / k
> >>         tmp_parent =3D clk_hw_round_rate(parent_hw, optimal_parent);
> >>         tmp_rate =3D tmp_parent * _n * _k / _m;
> >>     }
> >>     if (tmp_parent > optimal_parent)
> >>         continue;
> >>
> >> This seems ugly, but at least it should work in all cases. Any opinion=
s?
> >
> > Again, you shouldn't work around the issue.
> >
> > It's very simple really: you already computed the optimal parent rate,
>=20
> No. I didn't. My assumption is: If ccu_nkm_find_best is asked for the
> best rate for rate =3D 449035712, it should try to include 449035712 in
> its candidates, agreed?
>=20
> Example 1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rate=3D449035712, n=3D11, k=3D3, m=3D16:
> We should as for a parent rate of 217714285, because:
> 217714285 * 11 * 3 / 16 =3D 449035712
>=20
> How do we get from 449035712 to 217714285, you ask?
>=20
>       DIV_ROUND_UP(rate * m, n * k)

Why are we rounding up? I don't think the hardware will round up there.

> Do you agree that we should ask the parent for 217714285 in case we want
> a rate of 449035712 and we're currently evaluating the case n=3D11, k=3D3,
> m=3D16?
>=20
> We should not ask for a parent rate of 217714284, because:
> 217714284 * 11 * 3 / 16 =3D 449035710
>
> Example 2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> rate=3D500000000, n=3D11, k=3D3, m=3D16:
> Here we should not ask the parent for
>       DIV_ROUND_UP(rate * m, n * k)
> because that would be 242424243.
>=20
> 242424243 * 11 * 3 / 16 =3D 500000001
>=20
> We (the NKM clock, not the parent!) would overshoot (please see at the
> end of this mail, why (for now) I don't want to support overshooting in
> the NKM clock).
>=20
> Instead we should as for a parent rate of 242424242, because:
> 242424242 * 11 * 3 / 16 =3D 499999999
>=20
> In conclusion, there are cases, where we (the NKM clock) have to ask the
> parent for
>       DIV_ROUND_UP(rate * m, n * k)
> And there are also cases, where we have to ask the parent for
>       rate * m / (n * k)

I mean, I think you're overthinking this.

If you never round up and mimic how the hardware behaves, and test all
combination, then eventually you'll find the closest rate.

If you don't because the parent doesn't look for the closest rate, then
the parent should be changed too.

It really is that simple.

> This is what the code is trying to do. Maybe it's easier to look at V2
> because I extracted the calcultion of the optimal parent rate into a
> separate function hoping that this makes things clearer.
>=20
> Let me stress this: When calculating the optimal rate for the parent,
> I'm not making any assumptions here about how the PARENT clock rounds.
> In fact, I assume that the parent could be perfect and always provides
> the rate it is asked for. I only take into account how the nkm clock
> rounds.

At the very least, you assume that the parent rounding can be "wrong"
and try to work around that.

> > you ask the parent to compute whatever is closest to that optimal parent
> > rate.
> >
> > It's the parent responsibility now. It's the parent decision to figure
> > out what "the closest" means, if it can change rate, if it has any range
> > limitation, etc. You can't work around that.
> >
> > What you actually want there is the parent to actually provide the
> > closest rate, even if it means overshooting.
> >
>=20
> I want to ask the parent for a rate, that would actually result in the
> rate that nkm_find_best was asked for. Are you asking me to instead ask
> the parent for a rate that doesn't fit that criterion?

No. I'm asking to call clk_hw_round_rate(parent_hw, rate * m / (n * k))
and use whatever value it returned.

If it requires changing the parent clock to improve its round_rate
behaviour, then do that too.

> > That's fine, we have a flag
> > for that: CLK_(MUX|DIVIDER)_ROUND_CLOSEST. We just need to set it on the
> > parent and be done with it.
>=20
> This is a totally different issue.

Why?

> If you carefully look at ccu_mp, you will see that it would ignore
> cases when its parent had rounded up. ccu_nkm is no different.
> Teaching all of sunxi-ng's clocks to respect ROUND_CLOSEST is a
> totally different beast. For now, sunxi-ng always expects rounding
> down.

Then change that?

It doesn't look that bad to be honest, it's basically change the rate
comparison check by something like mux_is_better_rate() or
_is_best_div(). As far as I'm concerned, you can even do that only for
NKM and MP clocks if you don't want to change everything.

> I do not like mixing the two into one patchset. I hope that's a fair
> request? I tried to mix it and it was a nightmare! If you want, I can
> try tackling ROUND_CLOSEST afterwards. But I don't think it would help
> with this patchset, because we'd need to support both the ROUND_CLOSEST
> and ~ROUND_CLOSEST case. Covering one case seems already hard enough. :)

That's fair, but then remove the rate rounding handling entirely and
only deal with forwarding the rate to the parent if SET_RATE_PARENT is
set.

Maxime

--6flo7htaj65edw6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIgycAAKCRDj7w1vZxhR
xYmdAP9fSsAzKP7Mw4yA5CnMjsPNI6niprgbmTK02TaYx0n5/gEAzfcBCAE9C+/B
2O54l14ZoZjd3IrmRRszP0TVJT1XzQA=
=2Mam
-----END PGP SIGNATURE-----

--6flo7htaj65edw6r--
