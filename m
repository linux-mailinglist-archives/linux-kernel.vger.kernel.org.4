Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5675E9E56
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiIZJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiIZJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:50:49 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A96210062
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:50:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id BA80C2B06A16;
        Mon, 26 Sep 2022 05:50:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 26 Sep 2022 05:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664185835; x=1664193035; bh=Q5YqCB+bWv
        ZnM9/MP8ojAxE88SZk5mFeXFT7vJkPnOQ=; b=CbM+ffh8hGO/4EshyJBj+hQOby
        uSKuQbZ08yV/O7npvaPQjbriXKz7qwOJBEikhupb5sz0HlXEtWmHAHdOA4qf5RBY
        pfDNJ1VLYDnr70g9GdLd9IYldjQxT/Iq6J9hTa+K5/VWSkT5KChkQ0B9AibPm/8n
        7nfRE08jBYGvUlDqTzM12ThVEgQispAaoWewCio/6R1E8zGatUiJL1a+b5T66KIN
        rq7Gk7j+Mb5JHSO8r9EHWK6oOf4amJ1qF/YtwN0UF7wYp7CX8CMRTEhqe/ANmvXe
        f81xbiiXBtST8iwQWcPL1/9auidpuErFhQTpVnBYNBQpxN217qqrf3Gqq/FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664185835; x=1664193035; bh=Q5YqCB+bWvZnM9/MP8ojAxE88SZk
        5mFeXFT7vJkPnOQ=; b=cPnysf/P2PbQ+IH15wTtgZdBsVOpPnb2MQAnFYR//HLr
        0AtcpJNkLsq9mQwQeO0StKNYJ8NYvfjVmONFwBj+KE076TaUJsOMWsPV4Sx5OYD/
        hjLEVXsK94HIO89vQZZCSsDYXmrRS2NjtzyoQWC1gU2aA0xVHpl0OtKgOFAxfitT
        SXV7/exwbblPSjKAOl4+Wx4EvEMdGuaUmmTxpl/pX0QzUCWC6qwxy9GqumaZV1th
        uSI8hyrUNQS7ER9MT9IOAZUx1eNatyvuJn8MY+uHvs3iFzF0F3bDZD1rP2uNxpcf
        tyNVlUMI3dhfW0OBU6Ug6vm2Aw6DYXXdBv8q0BSZEw==
X-ME-Sender: <xms:6nUxY87En6rl5JtBuegrYVkuYyU3-SsDG1klILVdtAL6Qwdkf8M7_A>
    <xme:6nUxY977tYpT4xSW1ett0FDl09ghWQIlAFzl3xyO7crQB2rXhCSY2Z_0W_LC4_1iA
    tiIUVtOu2qn7sxu7J8>
X-ME-Received: <xmr:6nUxY7cJzjsH4MvX7DFh81T_6wT9FR0cWe1i0iFlKHQ-ZIBz0noGBnTuxkmZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6nUxYxL5C3_5Sf-v0pBL2lLWMha6XHNYSheIMrAReX6Ir_PDDc5nZg>
    <xmx:6nUxYwL9uk7F2dJOprwNmH-QHjyshXE5TmqygRW_2TebDZ25AJWT5w>
    <xmx:6nUxYywirP_MNHdMbw3JQf71HU-KaS1e7RhGNrcmmnLC8C1XxAOspA>
    <xmx:63UxY6qYHueW2DoYIPmZe-TsKLaxZoD5D2QROroXMgvC9MPpd2kLiSOmsB0>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Sep 2022 05:50:33 -0400 (EDT)
Date:   Mon, 26 Sep 2022 11:50:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>, Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 06/33] drm/connector: Rename legacy TV property
Message-ID: <20220926095031.vlwsw7willi36yd4@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-6-f733a0ed9f90@cerno.tech>
 <fa71ae1c-f9ca-167c-7993-b698ea3473a0@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wppcaqoyqh7rspqt"
Content-Disposition: inline
In-Reply-To: <fa71ae1c-f9ca-167c-7993-b698ea3473a0@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wppcaqoyqh7rspqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, Sep 23, 2022 at 10:19:08AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 22.09.22 um 16:25 schrieb Maxime Ripard:
> > The current tv_mode has driver-specific values that don't allow to
> > easily share code using it, either at the userspace or kernel level.
> >=20
> > Since we're going to introduce a new, generic, property that fit the
> > same purpose, let's rename this one to legacy_tv_mode to make it
> > obvious we should move away from it.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> It's not wrong, but 'legacy' is already overloaded with meaning. If you c=
an,
> maybe name it 'driver_tv_mode_property' or 'custom_tv_mode_property'
> instead.
>=20
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

I'd really like to point out that new drivers shouldn't be using this.
If we're using either of your proposals then writers might get the
impression that this is ok to us.

Would you prefer deprecated to legacy?

Maxime

--wppcaqoyqh7rspqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYzF15wAKCRDj7w1vZxhR
xXcKAP9L/I+uhmTIq76oVEB9ee7MilxBf4AgksOX/7k93P3lJAD/Q9YHrVicNYNH
d5hLg5xM8KI/DdLiQRhSunqAKaDeKAk=
=OLhV
-----END PGP SIGNATURE-----

--wppcaqoyqh7rspqt--
