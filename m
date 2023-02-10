Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED0691C41
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjBJKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjBJKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:06:27 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81599212B;
        Fri, 10 Feb 2023 02:06:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B25FB5C017F;
        Fri, 10 Feb 2023 05:06:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 Feb 2023 05:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1676023584; x=1676109984; bh=v4XDh8PM5t
        Dnz8mIeCYu/IW0nOTb8snlg/3tdK26gH0=; b=QnNw1uViaW+9bjW7xaHnJYXBh6
        yLzWlWbhv5mnsOlNDF2sOScqyZMfcW7Gi2G7ZVgeDAU+sY7JRD7CDx8tqaXFwHM1
        tWCI0vCqJ69l/jRo0DNmr76MdUa/cpxWQ01W6BaEjX3l3zUg7cbAaFsjKA/kXkwm
        DeBaZKz9HrhgBrHlw8N2sZZ5FqYlyrnxgNEV8eq3F5CX5r4xhkeSyF430IeJAJNQ
        ZgEjvQ5/yK0w/TMC8AzxIZ0YvPSQfk6b289ikQAqviVq4aKDIcTIOvs5sQ6Q9RMf
        OpcnQVRT69Zf965SvUcvk70LJCiwl3L048QSKI4eOefx1wQUjVWXQbmkFImg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676023584; x=1676109984; bh=v4XDh8PM5tDnz8mIeCYu/IW0nOTb
        8snlg/3tdK26gH0=; b=pbJkq/eOZdp8GouBxGfYJqUuMTzi9TeRCe8fL86B6vbr
        UXAC//eySK1LMAKcLqX+wTc/JqsIdDEeExUZ0V0zqngEKIQtK+pnnPq9PlpAvsGM
        p+trjMzNa5nJEyVd61loyDGgASFv+t2RIKKX9qDbVIEhI7CYA7/MiBFfKKlVG5p/
        lyshuurRG8YeiLlWmVdoq1bjfNf8LH7+sxam8NArMzL5mQ8Xtyf6ZWQRWTVW9Aw6
        +7MIWwFx3kdUJLCApAE7lU+kqLoPsmEdvC8I8rM6IlnPsjXG/J395R8cBDUpsNTT
        XdE+XoAzPkWpnbMaRAWr+C4jLqCazmMqZfhgbGgDZA==
X-ME-Sender: <xms:HxfmY2wIe7mrROdR33-K3rE-KWbFcyyNo4Cty9CxHebN16BsDfH6mQ>
    <xme:HxfmYyS6eTaT5BSCxLFK-PD6BtSDTc2XxMUwvziQa_vjo1kn5b1-y-ZcLHLKxfy-u
    N1yqYBVKTQNHnqFDJg>
X-ME-Received: <xmr:HxfmY4XxoFeKhIZroy1xKkLM4WIs0Py6eOkCMRgLAklp-S2AWjq4XkW_qlJA3kUlN-lxZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:HxfmY8i_Ayp5CjKerLoRLOs-AePWIVgwDBcQYne6DN32Qh__iefQwA>
    <xmx:HxfmY4Aciro5h3zQiBaEP5Wh8Fzs33sWGLNN8H4jmjPmDfRnQC1ugQ>
    <xmx:HxfmY9K-T0kee8Ry5GvbWYNzCKvfmF-9UOtPRFNcJ_H6sNvPpsgGFw>
    <xmx:IBfmY6zImKOja7p9ceC7C1mVD2mY_9NyjJsyh7hiT2IFkVYnmezzaQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Feb 2023 05:06:22 -0500 (EST)
Date:   Fri, 10 Feb 2023 11:06:20 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Andreas Feldner <andreas@feldner-bv.de>,
        Andreas Feldner <pelzi@flying-snail.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
Message-ID: <20230210100620.z6j7rvkiwyu7paij@houat>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
 <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
 <20230210082936.qefzz4fsp3jpalvp@houat>
 <20230210094425.474cfba5@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dptlal3vq5nbftml"
Content-Disposition: inline
In-Reply-To: <20230210094425.474cfba5@donnerap.cambridge.arm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dptlal3vq5nbftml
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2023 at 09:44:25AM +0000, Andre Przywara wrote:
> On Fri, 10 Feb 2023 09:29:36 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> Hi Maxime,
>=20
> thanks for the reply!
>=20
> > On Thu, Feb 09, 2023 at 08:29:52PM +0000, Andre Przywara wrote:
> > > > >>   &pio {
> > > > >> +	/* 1=EF=BF=BDs debounce filter on both IRQ banks */ =20
> > > > > Is that supposed to be <micro> in UTF-8? It seems to have got los=
t in
> > > > > translation, or is that just me? =20
> > > > O yes, the Greek character slipped into the comment. =20
> > > > >> +	input-debounce =3D <1 1>; =20
> > > > > As mentioned above, I am not so sure this is generic enough to pu=
t it
> > > > > here for PA. And what is the significance of "1 us", in particula=
r? Is
> > > > > that just the smallest value?   =20
> > > >=20
> > > > Yes indeed it's a bit more complicated than I feel it needs to be. =
The
> > > > configuration is taken as microseconds and translated into the best
> > > > matching clock and divider by the driver. However, 0 is not transla=
ted
> > > > to the lowest divider of the high speed clock as would be logical if
> > > > you ask for zero microseconds, but to "leave at default". The defau=
lt
> > > > of the board is 0 in the register, translating to lowest divider on=
 the
> > > > _low_ speed clock. =20
> > >=20
> > > I'd say the "if (!debounce) continue;" code is just to defend against
> > > the division by zero, which would be the next statement to execute.
> > >=20
> > > We might want to change that to interpret 0 as "lowest possible", whi=
ch
> > > would be 24MHz/1. Please feel free to send a patch in this regard, and
> > > CC: Maxime, to get some input on that idea. =20
> >=20
> > I never had any complaint on that part either, so the default looks sane
> > to me.
> >=20
> > If some board needs a higher debouncing rate, then we should obviously
> > set it up in the device tree of that board, but changing it for every
> > user also introduces the risk of breaking other boards that actually
> > require a lower debouncing frequency.
>=20
> Yeah, we definitely should keep the default at 32KHz/1, as this is also
> the hardware reset value.
>=20
> Not sure if you were actually arguing this, but the change I sketched
> above (interpreting 0 as 24MHz/1) is separate though, as the current
> default is "no DT property", and not 0. There is no input-debounce
> property user in the kernel tree at the moment, so we wouldn't break
> anyone. The only thing that would change is if a downstream user was
> relying on "0" being interpreted as "skip the setup", which isn't
> really documented and could be argued to be an implementation detail.
>=20
> So I'd suggest to implement 0 as "lowest possible", and documenting that
> and the 32KHz/1 default if no property is given.

Ah, my bad.

There's another thing to consider: there's already a generic per-pin
input-debounce property in pinctrl.

Since we can't control it per pin but per bank, we moved it to the
controller back then, but there's always been this (implicit)
expectation that it was behaving the same way.

And the generic, per-pin, input-debounce documentation says:

> Takes the debounce time in usec as argument or 0 to disable debouncing

I agree that silently ignoring it is not great, but interpreting 0 as
the lowest possible is breaking that behaviour which, I believe, is a
worse outcome.

So I'm not sure what's the best course of action here. Rejecting the
configuration entirely would prevent the entire pinctrl driver from
probing which sounds really bad. Maybe we could just print an error that
we rejected it to make it more obvious?

Maxime

--dptlal3vq5nbftml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY+YXFwAKCRDj7w1vZxhR
xTFrAQCdGF3qrNAzaAFjIUXOhNcaohzIyQtoXdUESrPe4GjXMAD+JilJvMPYMQ5m
AXTNk41unbUwC1kxQEaZheLAV9LBHgg=
=iTHV
-----END PGP SIGNATURE-----

--dptlal3vq5nbftml--
