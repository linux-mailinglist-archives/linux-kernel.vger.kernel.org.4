Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8424A697849
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjBOIgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjBOIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:36:14 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F72B282;
        Wed, 15 Feb 2023 00:36:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9EF9F5C0048;
        Wed, 15 Feb 2023 03:36:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 Feb 2023 03:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676450166; x=
        1676536566; bh=XZK5UkyE7CjtpojrYc2FgpvA+SYcUllXqaeA4EFayKM=; b=U
        kDor7El8E5FreYlWu+EXpGhMGbvNaaiKikFYEAEHodhtYXqzCYxw+65CWI6Qkpdv
        6qQ6UCJ3hT+s3xlwtGvuMZLJGyGLOKCZ3CWAJ98357IE89oDDJQG498TU60JuLf6
        ZrLZ7MVqlff5RaVQ2VaUnw/hWbxU2owRo5TIHAlb5OMhEEvumUUCqgutDUKFobed
        IBGn35g2/4AgBNHFHGZ7ihSfQJFz0wM6CRDK1ab8mVcWMH9N+qVBTRDEqiwnhNXi
        +YYNjub9l8trLcq0+5827hPO/KS8POenf9GTVbNVy5KzCzclyyINDqMQM5xSlZhX
        VBCwWMGrk/1Z+AGRsYEiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676450166; x=
        1676536566; bh=XZK5UkyE7CjtpojrYc2FgpvA+SYcUllXqaeA4EFayKM=; b=j
        muEYldVia/EtWXAwmldCFwla/BTG6gX75lJJcXi/0pJdi365aN/OtbJU+NRx/DVg
        7II/JlvgrRufjCXpaexxmiftmcu6KQGgYajm+yc2zPgyWxutf/xtfSeQQKUO0gYq
        G9qcR7EKP7NajVKAtt209fpEkOJV5er11lVMpglwKQ7AuSbGq4RDjwmHzRY5yllj
        rl87cJKlN+qYvdrH9jFk7Gkc2PJ35415himIaPCOOjK4gUbHckGaxpTX5CWc71vp
        sYloQGEMpzfHw2I08FQ6NZlu4slc0FixOYKirK3pH62xBEF4UnV77vXJmEkuo/IX
        WDgHyi4kuwS6C3bXTs7Og==
X-ME-Sender: <xms:dZnsY3Z7mMf5i0b1jWUQRUbs4Bng7vmSDv0P-Rdx-o_C31Dds_THxw>
    <xme:dZnsY2axlmfaZOtU1Gaws8kRLLHxVNZm671znzL29BwD1v2wjCfAYOPPEpLqnISwy
    1ddDazl_aOpu_p9tg8>
X-ME-Received: <xmr:dZnsY5-E83P8j8nMhh25Y0yT-ohlxRilKxtDaOyHaPb3uhQgGaTtOHPmp2D0IF5fo3Pd78aC_zQZRDAha-L1OeOJWPko_Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtudenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeelleefieelleetteefvdeikeeffeffvefhtdevgfehveduveehjedv
    vdeiledtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:dZnsY9q9TZGKLfq5OEGxYw0_uJu__l2YGUBBzkNEIutmZ_0JdmKJcQ>
    <xmx:dZnsYyp25wPyNICTeU4PA2oxON__90EhbEMbMokTrM958QWv6xpKyg>
    <xmx:dZnsYzSoVXmcnQt6dT07UWskI_6DvAxRWEcHjgOqvJyExjPGOJCQbw>
    <xmx:dpnsY2oC9v_OvQaA9SAxa3GcNHBuPP2nfJ5wRUl_xks48FLjZgZTcw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 03:36:05 -0500 (EST)
Date:   Wed, 15 Feb 2023 09:36:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     pelzi@flying-snail.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
Message-ID: <20230215083602.ecvtoqbku2gu2dy4@houat>
References: <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
 <20230210082936.qefzz4fsp3jpalvp@houat>
 <20230210094425.474cfba5@donnerap.cambridge.arm.com>
 <20230210100620.z6j7rvkiwyu7paij@houat>
 <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
 <20230213084329.ulckaigwd7dof37u@houat>
 <c3dda403-6963-040a-3827-443edf0a377a@flying-snail.de>
 <20230213091803.bxle6ly2sapodsbs@houat>
 <20230213115652.3ab4f25c@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230213115652.3ab4f25c@donnerap.cambridge.arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:56:52AM +0000, Andre Przywara wrote:
> On Mon, 13 Feb 2023 10:18:03 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
> > On Mon, Feb 13, 2023 at 09:49:55AM +0100, pelzi@flying-snail.de wrote:
> > > Am 13.02.23 um 09:43 schrieb Maxime Ripard: =20
> > > > On Fri, Feb 10, 2023 at 10:18:14AM +0000, Andre Przywara wrote: =20
> > > > > > > Not sure if you were actually arguing this, but the change I =
sketched
> > > > > > > above (interpreting 0 as 24MHz/1) is separate though, as the =
current
> > > > > > > default is "no DT property", and not 0. There is no input-deb=
ounce
> > > > > > > property user in the kernel tree at the moment, so we wouldn'=
t break
> > > > > > > anyone. The only thing that would change is if a downstream u=
ser was
> > > > > > > relying on "0" being interpreted as "skip the setup", which i=
sn't
> > > > > > > really documented and could be argued to be an implementation=
 detail.
> > > > > > >=20
> > > > > > > So I'd suggest to implement 0 as "lowest possible", and docum=
enting that
> > > > > > > and the 32KHz/1 default if no property is given. =20
> > > > > > Ah, my bad.
> > > > > >=20
> > > > > > There's another thing to consider: there's already a generic pe=
r-pin
> > > > > > input-debounce property in pinctrl.
> > > > > >=20
> > > > > > Since we can't control it per pin but per bank, we moved it to =
the
> > > > > > controller back then, but there's always been this (implicit)
> > > > > > expectation that it was behaving the same way.
> > > > > >=20
> > > > > > And the generic, per-pin, input-debounce documentation says:
> > > > > >  =20
> > > > > > > Takes the debounce time in usec as argument or 0 to disable d=
ebouncing =20
> > > > > > I agree that silently ignoring it is not great, but interpretin=
g 0 as
> > > > > > the lowest possible is breaking that behaviour which, I believe=
, is a
> > > > > > worse outcome. =20
> > > > > Is it really? If I understand the hardware manuals correctly, we =
cannot
> > > > > really turn that feature off, so isn't the lowest possible time p=
eriod (24
> > > > > MHz/1 at the moment) the closest we can get to "turn it off"? So
> > > > > implementing this would bring us actually closer to the documented
> > > > > behaviour? Or did I get the meaning of this time period wrong?
> > > > > At least that's my understanding of how it fixed Andreas' problem=
: 1=B5s
> > > > > is still not "off", but much better than the 31=B5s of the defaul=
t. The new
> > > > > 0 would then be 0.041=B5s. =20
> > > > My point was that the property we share the name (and should share =
the
> > > > semantics with) documents 0 as disabled. We would have a behavior t=
hat
> > > > doesn't disable it. It's inconsistent.
> > > >=20
> > > > The reason doesn't really matter, we would share the same name but =
have
> > > > a completely different behavior, this is super confusing to me. =20
> > >=20
> > > I got the point. As far as I can tell from the datasheet, it is not p=
ossible
> > > to actually switch off input-debounce. But as a debounce filter is ac=
tually
> > > a low-pass filter, setting the cut-off frequency as high as possible,
> > > appears to be the equivalent to switching it off. =20
> >=20
> > It's not really a matter of hardware here, it's a matter of driver
> > behavior vs generic behavior from the framework. The hardware obviously
> > influences the former, but it's marginal in that discussion.
> >=20
> > As that whole discussion shows, whether the frequency would be high
> > enough is application dependent, and thus we cannot just claim that it's
> > equivalent in all circumstances.
> >=20
> > Making such an assumption will just bite someone else down the road,
> > except this time we will have users (you, I'd assume) relying on that
> > behavior so we wouldn't be able to address it.
> >=20
> > But I also agree with the fact that doing nothing with 0 is bad UX and
> > confusing as well.
> >=20
> > I still think that we can address both by just erroring out on 0 /
> > printing an error message so that it's obvious that we can't support it,
> > and we wouldn't change the semantics of the property either.
> >=20
> > And then you can set the actual debouncing time you need instead of
> > "whatever" in the device tree.
>=20
> I am on the same page with regards to discouraging 0 as a proper value, a=
nd
> that we should warn if this is being used.

Great :)

> However I think we should at the same time try to still get as low as
> possible when 0 is specified.

It's still undefined behaviour though. It will be context dependent, and
if we ever encounter a bug at 1/24MHz, we'll change that value to
something else that might break other users that were relying on that
value.

> The debounce property uses microseconds as the unit, but even the AW
> hardware allows us to go lower than this. So we would leave that on
> the table, somewhat needlessly: input-debounce =3D <1> would give us
> 1333 ns, when the lowest possible is about 42 ns (1/24MHz).
>=20
> So what about the following:
> We document that 0 does not mean off, but tries to get as low as possible.

I still don't really like the fact that we're changing the semantics of
that property.

> If the driver sees 0, it issues a warning, but still tries to lower the
> debounce period as much as possible, and reports that, like:
> [1.2345678] 1c20800.pinctrl: cannot turn off debouncing, setting to 41.7 =
ns

I just thought about another thing that might be a solution: instead of
checking/enforcing the input-debounce value at probe time, we can do so
when the pin is configured.

That way, the pinctrl driver will load without affecting the system boot
too much, but we would still reject pin configurations whose bank are
using 0.

Actually configuring the debounce per bank each time is configured is
probably going to complexify the driver, so we could set it up in the
probe, and default to the lowest debouncing value if it's zero, but we
would still actively check for that value to not be 0 as soon as a pin
is configured which would effectively prevent anyone from using that
value. I think this would be a good compromise?

> Alternatively we use a different property name, if that is a concern. We
> could then use nanoseconds as a unit value, and then can error out on 0.

I mean, if that's a concern, we can also introduce an input-debounce-ns
property that is mutually exclusive with input-debounce, with both
erroring out on 0.

Maxime
