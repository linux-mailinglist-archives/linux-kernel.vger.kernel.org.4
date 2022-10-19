Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D1B604106
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJSKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiJSKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:33:58 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C4FF243
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:13:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 6B4202B066A9;
        Wed, 19 Oct 2022 04:48:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 19 Oct 2022 04:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666169312; x=1666176512; bh=Ym8zZTCcZM
        zDkoxIUNvTcvnh7J9PJfm+nGlRN8I2SxQ=; b=KdU04RhNsUNkm2Ekd02vnAdG07
        tgQJvehh/pQMoaC2BYJaJhqOndgA0RVVs60zjvklb5ud//6MAh+5cEf/3N1ZCTms
        w70cg+INzGALjJjKpj8Q3N+eWAHkdxAQDwTKePnpNWVwDc9fMrq2Kwyept6NgNYi
        LMZAzdvRAsr4EC4UEIDxxUC5def1KJzPo8LDRRdC7nGkysExG0s+2vMVd94rdjtH
        ntzi+f0ogMuhMJ4bAsaTiTa74vGZPiIV7enMqt8VvAcX0l+wAUJ7xbHW7ehELAVW
        FpD/Rqyi+keHr5MKIkKcP/8rZ6tFlnadvyjTwX2lPxpemWdw7UUCBYHt3G0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666169312; x=1666176512; bh=Ym8zZTCcZMzDkoxIUNvTcvnh7J9P
        Jfm+nGlRN8I2SxQ=; b=oMiOuzOTzEKTCBLSUX9G9jAuJ0oL9iSUbS0lBpkLluDO
        G25DWW7P+vlVfWITSXdNkEtBSEnhkOpnaNoUFtpi/zZz+xIotzCh3TVrqT2FpXZM
        n5Mlbj7qJFM14/mzcVR/8aZkVO60RRhZLIs2fmkaWe+bzxZjacEtcl2trlxT/91Z
        yOF5QuG9hZ485rh/IixlOViOF7eiTRwA93qRKMoxLPlb8VXxt62uFGKrLwBpjsT5
        DtDW96WCgcE4pUVgCFaUgFBMc8jNMlCIjPSovYoNKQp61X71CpvNnTljSfWYeCoX
        1xiPn5gsYzNLl0twj72w+AvbFkPh7ZLwTxhd6mvBIA==
X-ME-Sender: <xms:37lPY10L48qsNQf8cigEXMCh63T-4Qrauz6OrSAwbMkDgJsotu0oQw>
    <xme:37lPY8GAk8Yrn9nhkbcJ0fuH5dvV7lMQxS0XIfF6IqxWqHAAY5NNXE0k22YiesOOe
    3Qw5-oLoV6fr1TbBSA>
X-ME-Received: <xmr:37lPY16Qxxm2kamca44NGJWysw8YaFUYrXRunOl1iLmbqx0K7sdSzvIEEbKO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:37lPYy1YOCVMKTWiKtOyaLSIl6-tuTDy6T01UTzY8sXuJv2DDezlig>
    <xmx:37lPY4G99QMwBes8dy5IOJq0uoHoxPvnEURw3tdELseUPQQDOIv5iQ>
    <xmx:37lPYz8ytonyL8GI2KznAKP92qjUaGiEBsAUYid98vJDAQ4KrXlPdw>
    <xmx:4LlPYzmGtI1pqyp6Nsfm5F54pl7efHZUWVsLW-ZfN3r7vgZ88GeH6cYD9uc>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Oct 2022 04:48:30 -0400 (EDT)
Date:   Wed, 19 Oct 2022 10:48:28 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Emma Anholt <emma@anholt.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v5 12/22] drm/connector: Add a function to lookup a TV
 mode by its name
Message-ID: <20221019084828.muy46td63bkyewxk@houat>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-12-d841cc64fe4b@cerno.tech>
 <7dcf479c-8ac7-ed47-8587-30268684373c@tronnes.org>
 <20221018093353.pt4vset6o2ldxrbs@houat>
 <e3b98674-5a9e-16f3-4741-ffea43e05cc8@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g2rjpzd2ixg3ehrv"
Content-Disposition: inline
In-Reply-To: <e3b98674-5a9e-16f3-4741-ffea43e05cc8@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g2rjpzd2ixg3ehrv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 02:29:00PM +0200, Noralf Tr=F8nnes wrote:
>=20
>=20
> Den 18.10.2022 11.33, skrev Maxime Ripard:
> > On Mon, Oct 17, 2022 at 12:44:45PM +0200, Noralf Tr=F8nnes wrote:
> >> Den 13.10.2022 15.18, skrev Maxime Ripard:
> >>> As part of the command line parsing rework coming in the next patches,
> >>> we'll need to lookup drm_connector_tv_mode values by their name, alre=
ady
> >>> defined in drm_tv_mode_enum_list.
> >>>
> >>> In order to avoid any code duplication, let's do a function that will
> >>> perform a lookup of a TV mode name and return its value.
> >>>
> >>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >>> ---
> >>>  drivers/gpu/drm/drm_connector.c | 24 ++++++++++++++++++++++++
> >>>  include/drm/drm_connector.h     |  2 ++
> >>>  2 files changed, 26 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_co=
nnector.c
> >>> index 820f4c730b38..30611c616435 100644
> >>> --- a/drivers/gpu/drm/drm_connector.c
> >>> +++ b/drivers/gpu/drm/drm_connector.c
> >>> @@ -991,6 +991,30 @@ static const struct drm_prop_enum_list drm_tv_mo=
de_enum_list[] =3D {
> >>>  };
> >>>  DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
> >>> =20
> >>> +/**
> >>> + * drm_get_tv_mode_from_name - Translates a TV mode name into its en=
um value
> >>> + * @name: TV Mode name we want to convert
> >>> + * @len: Length of @name
> >>> + *
> >>> + * Translates @name into an enum drm_connector_tv_mode.
> >>> + *
> >>> + * Returns: the enum value on success, a negative errno otherwise.
> >>> + */
> >>> +int drm_get_tv_mode_from_name(const char *name, size_t len)
> >>
> >> Do we really need to pass in length here? item->name has to always be
> >> NUL terminated otherwise things would break elsewhere, so it shouldn't
> >> be necessary AFAICS.
> >=20
> > The only user so far is the command-line parsing code, and we might very
> > well have an option after the tv_mode, something like
> > 720x480i,tv_mode=3DNTSC,rotate=3D180
> >=20
> > In this case, we won't get a NULL-terminated name.
>
> My point is that item->name will always be NUL terminated so strcmp()
> will never look past that.

Right, but we don't have the guarantee that strlen(item->name) <
strlen(name), and we could thus just access after the end of our name

Maxime

--g2rjpzd2ixg3ehrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY0+53AAKCRDj7w1vZxhR
xUn4AQD1YdJVV8PGLA4yBe9MrG2aLgZBCDneKyxSLZYf8GnuFgD9Ge0Zu9QrzbOB
RiI/MSBbWywUR77Xoz/dlZ4jRTTDKAc=
=L35j
-----END PGP SIGNATURE-----

--g2rjpzd2ixg3ehrv--
