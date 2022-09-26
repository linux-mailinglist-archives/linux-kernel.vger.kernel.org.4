Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B3C5E9E85
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiIZKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiIZKBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:01:41 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31915FC4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:01:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id EF96E2B0682F;
        Mon, 26 Sep 2022 06:01:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 26 Sep 2022 06:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664186494; x=1664193694; bh=WCZmCAbKUP
        B8V/dy4D1u2e0awoL+XJkcSsRkdm6+wHI=; b=uDRU/N4HsyiNDw98y2Q/Bs1VP2
        iOm0QEY2ULuXESBq9q3/5ONB1kS6wfCiJ/KH+LB8sfBv4eWmQpndHAtPXPt9zD1x
        Jja1TbCtTQxJ3OCS6ZGu5+4zjjM8PLEe9xiY6RUNybMVub51j6B2tVm10glcJGmh
        ZGZlWP9gRQ66Ix5LW3YDsGSSrzGw25Y7A7uO5IMGl4qGlWkcsulLZiA4zSFmnmLh
        H9XIs8clIgTyhTwNQyv7L58dL/dSPHZphfWYMuvf9twjotVoraSj7ha02dMZeRlB
        w8JqVMt8DnnBq6jqC03xuKsglLxT+0fU47uv73psQdGu4O3QUHdXKnga5y3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664186494; x=1664193694; bh=WCZmCAbKUPB8V/dy4D1u2e0awoL+
        XJkcSsRkdm6+wHI=; b=Rug80Q+sMwxGaCBKoR9jTq3KVEOUjZqyG8wmAbICk/8y
        U7Qb8l9mipmoRtWHRpu0jk4KbgeqcepH/6cUBcLB6zIMAriAWceG9e9XlLkJhrzc
        Udv/NMuUXR8Gvwdy/qNx8l91X5rkvipJeG4B7qcJefayRPw/Oqfwtm2G5gsX7WD/
        Y3ioIKmJxSdjbc+Nyu65ipugqKeKiSxPbOLx0sO0e2s8GqX0y7NSG+JP1xXtipkq
        KvIdr6w49jjsBz7ZjFEqVzW4qUmRsffLEgBm1x36UHBKLIqivB+7B1+tOch6xZ11
        FNaGncWvlEeQIhpj5wNxgI3rJlPdut6hR3ytFwbqQw==
X-ME-Sender: <xms:fXgxY5mdo2kfVTZ0H8K4RmkdAQruihfTdqZxFowQpanMMgUwrX6kvg>
    <xme:fXgxY02sQzkLx6OD4lOEA4Nwem9HZs-4LKtXRBRzaDzV5_pMOowktPimCtlvN2FOQ
    LvM5CFR5oj_5PEZ1oc>
X-ME-Received: <xmr:fXgxY_ri-cIGor6hHugV8NJuzVelHO76BQLl3z6gcwf2qY9YDTu288EVpZkY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:fngxY5msrdWHVg1xIxjHF0u1zUZ5tvrhkwkubF0xshtSnCE_jn7QtQ>
    <xmx:fngxY323Uwtoh6YXZp8h4kBfOVCjEMI5VDk0aj3DPY3x6YFgbEetlA>
    <xmx:fngxY4sKohdqqPpob5hg3AExMcSGYS0P-dUl7R1gi0usdP2LhToMCQ>
    <xmx:fngxY3W09_EJXTf_SxnejTQX4auzwNfKkrHlS3B8ypz-DpseAPV0A6-F9YQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Sep 2022 06:01:33 -0400 (EDT)
Date:   Mon, 26 Sep 2022 12:01:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 09/33] drm/connector: Add TV standard property
Message-ID: <20220926100131.o5xtslzcmez5z2r3@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-9-f733a0ed9f90@cerno.tech>
 <80138f62-faec-5f7e-a8bd-235318a4e4c2@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gulwpck2gltavjpu"
Content-Disposition: inline
In-Reply-To: <80138f62-faec-5f7e-a8bd-235318a4e4c2@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gulwpck2gltavjpu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 24, 2022 at 05:52:29PM +0200, Noralf Tr=F8nnes wrote:
> Den 22.09.2022 16.25, skrev Maxime Ripard:
> > The TV mode property has been around for a while now to select and get =
the
> > current TV mode output on an analog TV connector.
> >=20
> > Despite that property name being generic, its content isn't and has been
> > driver-specific which makes it hard to build any generic behaviour on t=
op
> > of it, both in kernel and user-space.
> >=20
> > Let's create a new enum tv norm property, that can contain any of the
> > analog TV standards currently supported by kernel drivers. Each driver =
can
> > then pass in a bitmask of the modes it supports, and the property
> > creation function will filter out the modes not supported.
> >=20
> > We'll then be able to phase out the older tv mode property.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>
> Please can you add per patch changelogs, it's hard to review when I have
> to recall what might have happened with each patch. If you do it drm
> style and put in the commit message it should be easy enough to do.

I certainly don't want to start that discussion, but I'm really not a
fan of that format either. I'll do it for that series if you prefer.

> > +/**
> > + * enum drm_connector_tv_mode - Analog TV output mode
> > + *
> > + * This enum is used to indicate the TV output mode used on an analog =
TV
> > + * connector.
> > + *
> > + * WARNING: The values of this enum is uABI since they're exposed in t=
he
> > + * "TV mode" connector property.
> > + */
> > +enum drm_connector_tv_mode {
> > +	/**
> > +	 * @DRM_MODE_TV_MODE_NONE: Placeholder to not default on one
> > +	 * variant or the other when nothing is set.
> > +	 */
> > +	DRM_MODE_TV_MODE_NONE =3D 0,
>=20
> How is this supposed to be used?

It's not supposed to be used. It was a suggestion from Mateusz to avoid
to default to any standard when we don't initialize something. I don't
have any strong feeling about it, so I can drop it if you prefer.

Maxime

--gulwpck2gltavjpu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYzF4ewAKCRDj7w1vZxhR
xbZ+AP4xTTgpQpCXWXC6q7QOdRlNGR0Mnjaq7VCWTRYpDjbKxAD9F8HZA9VHM/b9
pZlXPcfdA5JuIglRNfLb9ooPZ9hiAw8=
=vOcp
-----END PGP SIGNATURE-----

--gulwpck2gltavjpu--
