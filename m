Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4D605ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJTL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiJTL3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:29:13 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3517D86D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:29:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 56D682B066CD;
        Thu, 20 Oct 2022 07:29:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Oct 2022 07:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666265343; x=1666272543; bh=mdSqh/jM6E
        5ZN6DIJNykgL+eED2DQJpEotJl8P+3p8Y=; b=Ox8ZAEZApN4HynE8SjcUtqfjEm
        sEhezjAJ4BVRlsnxOh2ipZmbBmtVKZurVTzyr0oD304ytmxqGLBFeczJf3uK/fDM
        xyN4ZY3YGzL31LcxGhm8QpF0YzIhDDzc38m5GzYH/ajRe03bbeMFX/vr9EJJd1Sk
        /zYPtXkDjE+8ChQbta/PpM2V/ijnr/JFriFPfhwK/MFkdlBfKDEedpQhjwNZnywj
        j9i3JbTiuO0ND2mX1396ajlhExAVGjeiMCnf5d7W/vyQAQsZUVjtL1csp+uK6ETP
        OKcJglEKV6DdrJvfbey01a+PJtOE1Hw6nlNHgA0+DHOhinXcjUvfyFAty7IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666265343; x=1666272543; bh=mdSqh/jM6E5ZN6DIJNykgL+eED2D
        QJpEotJl8P+3p8Y=; b=AcVfWBS4hegsRfUao6g1lIQfrzDSeor9U4oFalJ+Bs6Z
        XDVLvLPGVUoottaXUBBjxWIzSeTdl7UqP8csZ3phUGOXG/HJ8ThvkgAGlHfq8TQW
        SidUsKVJYLL4Kk3iPYcvXm252fznSGAOSD+HYm13zCbAk3AGp7abpVMYF/xfuChG
        Z4XdVDSgEga6H0R+Gx0SjpB2NeOzSqkl8nk5R0v0x060A3SHTNGTZ04Vvruwar7C
        0hvMZ/VyPkZhPFcSO5IsdKpLyXgume7hIv8DJLLjxFf/1rF55AwZ/CxVZPPKWC7q
        vW17SLe+k0JpyfH1Opu042gyv3CJK7Gy43cU+MzKqQ==
X-ME-Sender: <xms:_jBRYyBH_FfmuOpsaIRsHTlIvMK4HRjs_x4a-pw75k9tnUv7MEfK4A>
    <xme:_jBRY8gkx7cPDfxs2mX8RFUxtD2B_nFNjUqs6reqWbcpQbv9r3PFy2iN_jAO3pd_2
    5BZ-HzjQ3JsHtyG0Qg>
X-ME-Received: <xmr:_jBRY1mxlnrNMrpL_jc1lfhapovyapPyKzEe8p2zwveRgHVS99rg8KaRO1P8Fvxs9cHRP-Sg9-BrjDr_cLMLMCxBU06pj-VDvFXgBQsOHHz8xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeliedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeeijeeifffgfedvieeihf
    duffdvleelffejkedufedvffelkeefieektdfhteelhfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:_jBRYwzlboYrZF7MlEpdOmoREm59h5d5HCmf6lGxFPt5vWvcmSI58w>
    <xmx:_jBRY3QSVKpltD_y6fDj4po4FJeTpDUvCSxdcktRHOs2Z0F_Bub-Fw>
    <xmx:_jBRY7avNirHWNwHP6X9OuzLrT0InOwaqjrYE8Sw1t5Vcs0EW_dPlQ>
    <xmx:_zBRY_y8SoJT5iMsvyZdgUVB3i4bjFpnwBAu8sEjFylJeo6DG4hmWS-3hRY>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Oct 2022 07:29:02 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Thu, 20 Oct 2022 13:29:00 +0200
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
Message-ID: <20221020112900.dps2zyn4ftefgi3x@houat>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-12-d841cc64fe4b@cerno.tech>
 <7dcf479c-8ac7-ed47-8587-30268684373c@tronnes.org>
 <20221018093353.pt4vset6o2ldxrbs@houat>
 <e3b98674-5a9e-16f3-4741-ffea43e05cc8@tronnes.org>
 <20221019084828.muy46td63bkyewxk@houat>
 <694facef-00bc-6b59-7c44-d68c7ca0c40f@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u7iy4fry6poy23d7"
Content-Disposition: inline
In-Reply-To: <694facef-00bc-6b59-7c44-d68c7ca0c40f@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u7iy4fry6poy23d7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Noralf,

On Wed, Oct 19, 2022 at 12:43:19PM +0200, Noralf Tr=F8nnes wrote:
>=20
>=20
> Den 19.10.2022 10.48, skrev Maxime Ripard:
> > On Tue, Oct 18, 2022 at 02:29:00PM +0200, Noralf Tr=F8nnes wrote:
> >>
> >>
> >> Den 18.10.2022 11.33, skrev Maxime Ripard:
> >>> On Mon, Oct 17, 2022 at 12:44:45PM +0200, Noralf Tr=F8nnes wrote:
> >>>> Den 13.10.2022 15.18, skrev Maxime Ripard:
> >>>>> As part of the command line parsing rework coming in the next patch=
es,
> >>>>> we'll need to lookup drm_connector_tv_mode values by their name, al=
ready
> >>>>> defined in drm_tv_mode_enum_list.
> >>>>>
> >>>>> In order to avoid any code duplication, let's do a function that wi=
ll
> >>>>> perform a lookup of a TV mode name and return its value.
> >>>>>
> >>>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >>>>> ---
> >>>>>  drivers/gpu/drm/drm_connector.c | 24 ++++++++++++++++++++++++
> >>>>>  include/drm/drm_connector.h     |  2 ++
> >>>>>  2 files changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_=
connector.c
> >>>>> index 820f4c730b38..30611c616435 100644
> >>>>> --- a/drivers/gpu/drm/drm_connector.c
> >>>>> +++ b/drivers/gpu/drm/drm_connector.c
> >>>>> @@ -991,6 +991,30 @@ static const struct drm_prop_enum_list drm_tv_=
mode_enum_list[] =3D {
> >>>>>  };
> >>>>>  DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
> >>>>> =20
> >>>>> +/**
> >>>>> + * drm_get_tv_mode_from_name - Translates a TV mode name into its =
enum value
> >>>>> + * @name: TV Mode name we want to convert
> >>>>> + * @len: Length of @name
> >>>>> + *
> >>>>> + * Translates @name into an enum drm_connector_tv_mode.
> >>>>> + *
> >>>>> + * Returns: the enum value on success, a negative errno otherwise.
> >>>>> + */
> >>>>> +int drm_get_tv_mode_from_name(const char *name, size_t len)
> >>>>
> >>>> Do we really need to pass in length here? item->name has to always be
> >>>> NUL terminated otherwise things would break elsewhere, so it shouldn=
't
> >>>> be necessary AFAICS.
> >>>
> >>> The only user so far is the command-line parsing code, and we might v=
ery
> >>> well have an option after the tv_mode, something like
> >>> 720x480i,tv_mode=3DNTSC,rotate=3D180
> >>>
> >>> In this case, we won't get a NULL-terminated name.
> >>
> >> My point is that item->name will always be NUL terminated so strcmp()
> >> will never look past that.
> >=20
> > Right, but we don't have the guarantee that strlen(item->name) <
> > strlen(name), and we could thus just access after the end of our name
> >=20
>=20
> Ok, using the length limiting str funtions is the safe thing to do, so
> len needs to stay. But I don't get the 'strlen(item->name) =3D=3D len'
> check. strncmp() will stop when it reaches a NUL in either string so no
> need for the length check?

Yeah, but if the cmdline is truncated, we'll pass a shorter len than
strlen(item->name), and it will consider the string as equal.

For example strncmp("NTS", "NTSC", strlen("NTS"))) =3D=3D 0, while it obvio=
usly
isn't for us.

> Anyways:
>=20
> Reviewed-by: Noralf Tr=F8nnes <noralf@tronnes.org>

Thanks!
Maxime

--u7iy4fry6poy23d7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY1Ew/AAKCRDj7w1vZxhR
xRcOAQD4kMUrFpaggVUGDdw8lFZHCgfZHGc0linsJEA++8ypNAD/Z2SqzMPMeFZX
12rXh06m+wXI2OX4uZ0EETbo3eIKRww=
=pf41
-----END PGP SIGNATURE-----

--u7iy4fry6poy23d7--
