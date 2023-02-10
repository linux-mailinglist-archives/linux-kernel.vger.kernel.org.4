Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C6691A09
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjBJI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjBJI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:29:44 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FFF38653;
        Fri, 10 Feb 2023 00:29:42 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AD7F95C00E4;
        Fri, 10 Feb 2023 03:29:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 10 Feb 2023 03:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1676017780; x=1676104180; bh=uiCqwTBEe0
        viYok2ufMUsJ+Af16OiXAcjw4HpacnMW8=; b=CdqPoCjRjHWyCt876eRW7jlDxI
        Uu1x/7QDk31H0wd7iGPfTDiT6iZTVxbJ7jcHvoJgVzniIsfiaR2XbCKXdQhz2+Bz
        yMvrK3cqSxmtso9E6i+qP/D8XgZS1/bDkmmxFsEN9nsLaFEJd1DZZ2FS8gmYURyx
        luDHBvhPMO/+0qbsILTUlcWoRXJYeRmigmAnRNc3kFh3mLzl6b7f+5qHpP9Q+lx4
        6hTZ+X68BxlWtYqXeVTc1LewfYdpUi16BKloI5u4tzni0G7wU7vdSw3Xn65Vfi2y
        /ibVkOB2DE4iFkH+/5G3VQJz3/5vE8hemNk4nJqVHOfVJ4ojR+8nsodaam5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676017780; x=1676104180; bh=uiCqwTBEe0viYok2ufMUsJ+Af16O
        iXAcjw4HpacnMW8=; b=q1oILHirAjf/5bseLhy6ayhC17Y8jgiwf5VaZiV3D11C
        bykVUmLjB7bD9cZUNU9uLfzuo6bzivWv0W9884ctvsSgCvL6npffip9YfWstrccD
        9+gzmOtwidOF+RnRFgkhQSL+tECUpGiJtRf2ukkeNZ6dKoZ0hjFktXtWyMak7Wjw
        81+4WWowjwhWiT/C69qdFbX3cE5vt1VC3EZ0mJp4+XdtwL+7lt3oTtjQctDlJ8u3
        r8TXHebWQ2JntmPZ2wSQZOGTCHUM7VcIJ1/SsBsbrWUdCN5lXWaK+bnMd6B0F3Ii
        ndQZRPlsFotHrvBbKg2YdrUFif9S4XW44XMIy93TAw==
X-ME-Sender: <xms:cwDmY-5wwv-8qWHlTbLIJ2YybO6v8LiAFkeZ5TbuuykS-fRNDrRBrQ>
    <xme:cwDmY34Fnl6SYM4fxrbRomAuxPEK0Rs6S_Lvix9e8x1oan_OGRXAWKtI7_l8iH6e7
    39Bso7cVxpxixWbTco>
X-ME-Received: <xmr:cwDmY9fiv41Kis3OVoe36JAIhjVxnZfvlDQRn1tRn1LQb58byoMvQYy9GHVuGqjeeD5M4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehgedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfeg
    udffffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cwDmY7IrmJWCbPG6dElEm1mJ47CTqc3zAG2P8Zb_9CAAkuVRKZAy4w>
    <xmx:cwDmYyJLaEnvEDC6-MH3Py79FNY4XGMNo-yAkuRtQA-cT4-EgkCB4A>
    <xmx:cwDmY8wlJzVJMytapZgW9i53wqW8Sp0X103aieDA1J9BxdpcnkCRnQ>
    <xmx:dADmYy6aGPaSxQgtI488ULeJ1kCAuThA_NOt0uj6eEnTw_ixRk_Sdw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Feb 2023 03:29:39 -0500 (EST)
Date:   Fri, 10 Feb 2023 09:29:36 +0100
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
Message-ID: <20230210082936.qefzz4fsp3jpalvp@houat>
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
 <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
 <20230209202952.673d5a60@slackpad.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nragrb2jbk2zyfl"
Content-Disposition: inline
In-Reply-To: <20230209202952.673d5a60@slackpad.lan>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3nragrb2jbk2zyfl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2023 at 08:29:52PM +0000, Andre Przywara wrote:
> > >>   &pio {
> > >> +	/* 1=EF=BF=BDs debounce filter on both IRQ banks */
> > > Is that supposed to be <micro> in UTF-8? It seems to have got lost in
> > > translation, or is that just me?
> > O yes, the Greek character slipped into the comment.
> > >> +	input-debounce =3D <1 1>;
> > > As mentioned above, I am not so sure this is generic enough to put it
> > > here for PA. And what is the significance of "1 us", in particular? Is
> > > that just the smallest value? =20
> >=20
> > Yes indeed it's a bit more complicated than I feel it needs to be. The
> > configuration is taken as microseconds and translated into the best
> > matching clock and divider by the driver. However, 0 is not translated
> > to the lowest divider of the high speed clock as would be logical if
> > you ask for zero microseconds, but to "leave at default". The default
> > of the board is 0 in the register, translating to lowest divider on the
> > _low_ speed clock.
>=20
> I'd say the "if (!debounce) continue;" code is just to defend against
> the division by zero, which would be the next statement to execute.
>=20
> We might want to change that to interpret 0 as "lowest possible", which
> would be 24MHz/1. Please feel free to send a patch in this regard, and
> CC: Maxime, to get some input on that idea.

I never had any complaint on that part either, so the default looks sane
to me.

If some board needs a higher debouncing rate, then we should obviously
set it up in the device tree of that board, but changing it for every
user also introduces the risk of breaking other boards that actually
require a lower debouncing frequency.

And any default is always going to be debated, there's one, it seems to
create little controversy, it seems to work in most case, I'd just stick
with it.

> > To me this is mindboggling.
> >=20
> > If you want to keep IRQ bank A as it is today and switch off the
> > definitely unnecessary (and _potentially_ IRQ eating) debounce off
> > for bank G only, I'd suggest the following setting:
> >=20
> >  =A0=A0=A0 input-debounce =3D <31 1>;
>=20
> It should be documented that the effective default is 31, I guess the
> binding is the right place.

Yeah, if the documentation is lacking, we should definitely improve it.

Maxime

--3nragrb2jbk2zyfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY+YAawAKCRDj7w1vZxhR
xYg7AP0ckcuX2nOcAZ6OY/Rg9KQEpnr6I19NX9UOSX+nlSREVgD+JSHvch+fVoZk
53OrNbFnFVJH7IBNYSyVW1yqOhvuoA4=
=eFLj
-----END PGP SIGNATURE-----

--3nragrb2jbk2zyfl--
