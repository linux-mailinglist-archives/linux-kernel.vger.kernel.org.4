Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6E60286C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJRJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJRJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:34:04 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA2AE846
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:34:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id EAE112B06818;
        Tue, 18 Oct 2022 05:33:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 05:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666085636; x=
        1666092836; bh=m28wxnmpSj23GfJ8mguF+RJIPvACWR84C4m9tbBSs2o=; b=h
        TJ3XFHJn+A8AI/ROPkt+sIqGY3kA4wSIJQT4tHkHl+eM5Yfcjt6X7MYAIUr7Abas
        QlFe4tD6eLZR/VbYzPHxfb+mmQH0VGNqwYSwV55YB9bcLtz9qxFOwi+BOde3q9ZL
        WdyVIaCLx1fnmBze8W9xAi0Xv9M2vR2QswXYasftU70eL5G8ZfZ8+hpqiwgPBj3H
        zWNl5CCgBqV4/lI9o9tIFZT1qgjc8Pd+gffFcHNDISfRVCglOWOLAfXGbTEbRPHa
        Yz24wplENATRxJGBJBtfQnc7xW25Q8+KWoVVjAMvG2CUhQpR0EOOqAfh4FLpp1cX
        5yqaqwrN0S2MK9P/SNs2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666085636; x=
        1666092836; bh=m28wxnmpSj23GfJ8mguF+RJIPvACWR84C4m9tbBSs2o=; b=C
        5vPZsR4g/v/XssSsF5UxPaTyZ5O744YcQyhklPLOetbH0yOlm0PCjh/iY9EZAJ7V
        uV1SXQOu4CUug0AgTmJ/2n1SCC+FiOjwNU3KptPZNHLSFmFP+8iV5lLytvRIUGet
        rm3PKGYW8OeqKYNn1TEkhD/N2isE6ds71ZBkQxifTbeGuWIRkEVk9UXVoR30F2Oj
        /sS8v3YS+KgU4lbjlS5aVXX6eC3gIVIM5iMgDzUe9o/irGu1tn9AAF/Rb3EzIPMM
        KRBA13tpcwrQwVfkPIv8up+9rplog66fg2VIZD8/j785WDx8QoZg38fgIKAMaVCE
        j3Kt7kvbfUNsxFzFQk3RA==
X-ME-Sender: <xms:A3NOY95eeuFlDtiXSd2HrgE85y8GqJmS-uQzUlFg1W2eqOCqjp_BKg>
    <xme:A3NOY6708zJtmRk4V9UAXdHNs8tZhS1ylzZ9_LPNnb0SRp6ZTjIVvtaIEsSs3rO0E
    Pqd7SXsQaag2VqpTFA>
X-ME-Received: <xmr:A3NOY0fae0uVaJ1UzSmyFv1i8G1BkH14Mj-mYvsxa-8778Yi3-eBZbfnGEeX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeluddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepleelfeeileelteetfedvieekfeefffevhfdtvefgheevudevheejvddv
    ieeltdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:A3NOY2ImL3oAvGPDqk3mhpaFWs5EcG4v-6NNxYq5KwhG_8Mhk8FqXw>
    <xmx:A3NOYxIoK_2l01GHo2u3j-yabTPEaxvxxS66qSJ0Pno0VCAZe_RdEA>
    <xmx:A3NOY_zX3p7YYO0k9S7NWgf64pymTdTf0j475KvkelKtvWwSlMG_RA>
    <xmx:BHNOY7rCCVuSX-xwJHsXrJ7QI3T3--uNZV0KkEr0FJdIrGwcgv-bEJjia5c>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 05:33:55 -0400 (EDT)
Date:   Tue, 18 Oct 2022 11:33:53 +0200
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
Message-ID: <20221018093353.pt4vset6o2ldxrbs@houat>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-12-d841cc64fe4b@cerno.tech>
 <7dcf479c-8ac7-ed47-8587-30268684373c@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7dcf479c-8ac7-ed47-8587-30268684373c@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 12:44:45PM +0200, Noralf Tr=F8nnes wrote:
> Den 13.10.2022 15.18, skrev Maxime Ripard:
> > As part of the command line parsing rework coming in the next patches,
> > we'll need to lookup drm_connector_tv_mode values by their name, already
> > defined in drm_tv_mode_enum_list.
> >=20
> > In order to avoid any code duplication, let's do a function that will
> > perform a lookup of a TV mode name and return its value.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/gpu/drm/drm_connector.c | 24 ++++++++++++++++++++++++
> >  include/drm/drm_connector.h     |  2 ++
> >  2 files changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_conn=
ector.c
> > index 820f4c730b38..30611c616435 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -991,6 +991,30 @@ static const struct drm_prop_enum_list drm_tv_mode=
_enum_list[] =3D {
> >  };
> >  DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
> > =20
> > +/**
> > + * drm_get_tv_mode_from_name - Translates a TV mode name into its enum=
 value
> > + * @name: TV Mode name we want to convert
> > + * @len: Length of @name
> > + *
> > + * Translates @name into an enum drm_connector_tv_mode.
> > + *
> > + * Returns: the enum value on success, a negative errno otherwise.
> > + */
> > +int drm_get_tv_mode_from_name(const char *name, size_t len)
>=20
> Do we really need to pass in length here? item->name has to always be
> NUL terminated otherwise things would break elsewhere, so it shouldn't
> be necessary AFAICS.

The only user so far is the command-line parsing code, and we might very
well have an option after the tv_mode, something like
720x480i,tv_mode=3DNTSC,rotate=3D180

In this case, we won't get a NULL-terminated name.

Maxime
