Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E206940A9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBMJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMJSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:18:09 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8BEC4F;
        Mon, 13 Feb 2023 01:18:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7A2063200893;
        Mon, 13 Feb 2023 04:18:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 13 Feb 2023 04:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676279886; x=
        1676366286; bh=Eysr3UtHr3VtG3fm3bUaTYUgWFQmZNOhdveZFGzL2Y0=; b=T
        t0BK/PG/lFLXNMFaUlK2DnfAzbxGre6D7oMregD7+VwEEYKx/AlqwjKJ6NwXpkdL
        3Vr/A673V81gNbZKC59YjvGvbK540rxqriV0KKoH5HlKdHI+PCGtwyBvfpGh2NKd
        MjV7URWH+JeD33F4rYvnqGAFbNBQDb5G5C6CQr8bL2sEv4LViN8OORUtSwvMPGwc
        cEFV9ZRFqaah3WDKEnTUJrn1/oOi+Pz9YjbvN8QYEbtGgTJ0q3E2kSeJ3P8mNIAv
        hFbQ1SAVkgqo8k+BCxlYFnFbSiCt5R6mUd0yqK6T2t2MRED6CKXnU1dikB98J5Px
        W12N8JXsqY7U4kdrBCTcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676279886; x=
        1676366286; bh=Eysr3UtHr3VtG3fm3bUaTYUgWFQmZNOhdveZFGzL2Y0=; b=P
        2lDrD09gRGyViU74Ze1i8X0wHG9KbSg5TQ9zCIlRqbr1EwBBRJ64BnLEp7vTAMfL
        S+DeRAGpXEYua/yVnSRr2IVtPNQUJcVA+kSmHR7qLcxy0gDnSG/pQ7IcZVTrpCbP
        E1Q3M+iGM/q2sM3QnwyOtpdamb+w6iB/EjLCyDhrxPSC82NDKT4wOdwjvAfG2hbU
        oiSgrlsWIeBa7uSerTVHBHJwiUrwI5VqUvh/MpxIsuEUB6eNFSl366b/49ehiLn6
        3jYQpd8ETewnJL1DdRu5uGfdixC6087kgdah8YItPr2DdkWH0z+lMgQEi65uMxTV
        0R7PgKnDmMz2zKCnEkFkQ==
X-ME-Sender: <xms:TQDqYz4PtHRKAD2lN5GBBmSZ4kJnpRx9am8rEuZLi59IXt7F-JSJKQ>
    <xme:TQDqY45Neo_Injqya6GY63SlL6a7Zun2tQCgkfHVdaNdDY6QEh6WI6VXG40kBOwoT
    deUBsJvMOAOGPBZxD8>
X-ME-Received: <xmr:TQDqY6fxCJNpQrjfR7QOprp_fmtVRAL2Doj3uv4o3gU1PTfptK1_0AF-b9lfo9P4DhkuaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiudcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthhqredttddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelleefieelleetteefvdeikeeffeffvefhtdevgfehveduveehjedvvdeiledt
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TQDqY0JawoB2OXlJgdHKl--x7SiP8r-TGK6lhC8f8-huQuYmqzvdhg>
    <xmx:TQDqY3J-8xz8YuTb1PB5jeaWGYJ1AEG0Zms_z6m3g1FSEV5R9uJTrQ>
    <xmx:TQDqY9zeRQWdgrTCsrnxJh3Zcaw5E-NOWierd_Qv5FGl1259DCfTkA>
    <xmx:TgDqY_IS2wcJQHSfGgasmqCNClqkQZdogVzTfSAdWwQc95sDCNGSsA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 04:18:04 -0500 (EST)
Date:   Mon, 13 Feb 2023 10:18:03 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     pelzi@flying-snail.de
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
Message-ID: <20230213091803.bxle6ly2sapodsbs@houat>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
 <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
 <20230210082936.qefzz4fsp3jpalvp@houat>
 <20230210094425.474cfba5@donnerap.cambridge.arm.com>
 <20230210100620.z6j7rvkiwyu7paij@houat>
 <20230210101814.2d36ae57@donnerap.cambridge.arm.com>
 <20230213084329.ulckaigwd7dof37u@houat>
 <c3dda403-6963-040a-3827-443edf0a377a@flying-snail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c3dda403-6963-040a-3827-443edf0a377a@flying-snail.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:49:55AM +0100, pelzi@flying-snail.de wrote:
> Am 13.02.23 um 09:43 schrieb Maxime Ripard:
> > On Fri, Feb 10, 2023 at 10:18:14AM +0000, Andre Przywara wrote:
> > > > > Not sure if you were actually arguing this, but the change I sket=
ched
> > > > > above (interpreting 0 as 24MHz/1) is separate though, as the curr=
ent
> > > > > default is "no DT property", and not 0. There is no input-debounce
> > > > > property user in the kernel tree at the moment, so we wouldn't br=
eak
> > > > > anyone. The only thing that would change is if a downstream user =
was
> > > > > relying on "0" being interpreted as "skip the setup", which isn't
> > > > > really documented and could be argued to be an implementation det=
ail.
> > > > >=20
> > > > > So I'd suggest to implement 0 as "lowest possible", and documenti=
ng that
> > > > > and the 32KHz/1 default if no property is given.
> > > > Ah, my bad.
> > > >=20
> > > > There's another thing to consider: there's already a generic per-pin
> > > > input-debounce property in pinctrl.
> > > >=20
> > > > Since we can't control it per pin but per bank, we moved it to the
> > > > controller back then, but there's always been this (implicit)
> > > > expectation that it was behaving the same way.
> > > >=20
> > > > And the generic, per-pin, input-debounce documentation says:
> > > >=20
> > > > > Takes the debounce time in usec as argument or 0 to disable debou=
ncing
> > > > I agree that silently ignoring it is not great, but interpreting 0 =
as
> > > > the lowest possible is breaking that behaviour which, I believe, is=
 a
> > > > worse outcome.
> > > Is it really? If I understand the hardware manuals correctly, we cann=
ot
> > > really turn that feature off, so isn't the lowest possible time perio=
d (24
> > > MHz/1 at the moment) the closest we can get to "turn it off"? So
> > > implementing this would bring us actually closer to the documented
> > > behaviour? Or did I get the meaning of this time period wrong?
> > > At least that's my understanding of how it fixed Andreas' problem: 1=
=B5s
> > > is still not "off", but much better than the 31=B5s of the default. T=
he new
> > > 0 would then be 0.041=B5s.
> > My point was that the property we share the name (and should share the
> > semantics with) documents 0 as disabled. We would have a behavior that
> > doesn't disable it. It's inconsistent.
> >=20
> > The reason doesn't really matter, we would share the same name but have
> > a completely different behavior, this is super confusing to me.
>=20
> I got the point. As far as I can tell from the datasheet, it is not possi=
ble
> to actually switch off input-debounce. But as a debounce filter is actual=
ly
> a low-pass filter, setting the cut-off frequency as high as possible,
> appears to be the equivalent to switching it off.

It's not really a matter of hardware here, it's a matter of driver
behavior vs generic behavior from the framework. The hardware obviously
influences the former, but it's marginal in that discussion.

As that whole discussion shows, whether the frequency would be high
enough is application dependent, and thus we cannot just claim that it's
equivalent in all circumstances.

Making such an assumption will just bite someone else down the road,
except this time we will have users (you, I'd assume) relying on that
behavior so we wouldn't be able to address it.

But I also agree with the fact that doing nothing with 0 is bad UX and
confusing as well.

I still think that we can address both by just erroring out on 0 /
printing an error message so that it's obvious that we can't support it,
and we wouldn't change the semantics of the property either.

And then you can set the actual debouncing time you need instead of
"whatever" in the device tree.

Maxime
