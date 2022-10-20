Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADF6064AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJTPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJTPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:34:31 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9512D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:34:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BCB6958039A;
        Thu, 20 Oct 2022 11:34:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 20 Oct 2022 11:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666280062; x=1666287262; bh=3EC38JLBV/
        PLmHLFVDQamunw9mnwftMBA2gVQlmDDS0=; b=lp4tPjWdUXUsj4FdQCgTEF2673
        79sLM7SXIy9tMxQfIpY0HXtLJcnbz7yQPJZcgKGkVbFYS5nEpcgDDNgSSOReVOrX
        DBtvQIB9T5YsOWjA40kxaK8HwvbXP/19pmLx5ahJeXTGXbPnB3t7o5iVdo6Qdtuz
        fYEbhoD1/F0074UlmNud1QXho0T7mD/0BGs/wI3/OiHH5RNcM8ypeZih9ZFEY9HG
        bA5Gzjy+bPDp/ltdBHXFXk8ybWafu/DNkRqf11YUvl+0UkgVsOGigsVAGYbZvA3s
        HX5xFRdVkC7B6lUl/wCH7D+0euMoRyIafuoflXxoiaVRC+tIkcuZK4OCm2pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666280062; x=1666287262; bh=3EC38JLBV/PLmHLFVDQamunw9mnw
        ftMBA2gVQlmDDS0=; b=Hc20HQPvxLuT8kc82oNwFiqq3Tvfkgcgww9yuBSk/wz8
        d3kqHJdOcpWcrSLM8Pdtn5GlsvZqvfrLN1weYqYJDlvrzGnOELYEIYkuMvE++npe
        PrVoU4ALDPQL8NWf1OrCxcLaBJzahFgn2XDum9kyyuwc088RISZQlQKPxHoiiV19
        qciercWO0+Fe/+R3eQQbnBaNbaSvb3zif3KiYLHOv33c8qD7zjvnQVT8jKp1S1Ny
        lK14RW8tNK9qxo97QQ8bGVJQocw5xGnqWaFZNkpKTMYacNcwFY0I6QVQ6mOvJQlA
        QVbL28793tYmz7lCTjhajWy1ptCIitrsaShpn18DSw==
X-ME-Sender: <xms:fWpRYxcyVm0QkjF8aI0kOt3O2AQPWy4xPlfe8nrJE10d20cWUyKXyg>
    <xme:fWpRY_MZ3mXNlXsK4rjInZoXy6hSO_cX9P_5vEfurEb1-mlo-hvYelcVz0r_Bk-B1
    dp4z44rNHVRvdzzQkY>
X-ME-Received: <xmr:fWpRY6i2RYg1OM0-jdTqxSGcOh8CsPy_Q0ST_kXH2z9b5ZC8h6hXuQsaMAsYbN7gWYk_Yz0uFBNnq3VmkymBz-BeZjYPvrE8WrqjAIiMnsjPZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeliedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpedtjeevtdfhvdeiueetfe
    euvefftdegtdeutdejvdeujeevueetfeeuuefgtdduheenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:fWpRY68hjf81tqkMUcsjWTbdTyvtd20Q4rRtPWRGa2vrxZyWXPp1tQ>
    <xmx:fWpRY9tV8qbLYJhGrf2fBSkPExTg-QHef34Q7PnNMi-tqs6FDRGs5Q>
    <xmx:fWpRY5HsG191_xZpDt4nAYhTlA3kDqCVDS0J7MlNkPfAuWa10EkyZg>
    <xmx:fmpRY_P2lTLodaRIgX7JIXLhIOcBuqv_2ZT9C8IbqlunNScsyuSCKQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Oct 2022 11:34:20 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Thu, 20 Oct 2022 17:34:19 +0200
To:     kfyatek+publicgit@gmail.com
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
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] drm/vc4: vec: Add support for PAL-60
Message-ID: <20221020153419.po5jnl3fbt6pv7iq@houat>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-21-d841cc64fe4b@cerno.tech>
 <93bf9fcc-c645-b042-011f-8f1fc957af48@gmail.com>
 <20221018083153.okkqpd5ccfrnwdj3@houat>
 <0afdeda7-558e-647f-ef28-1fcd80807c1b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jk2rhlye3btfhqb5"
Content-Disposition: inline
In-Reply-To: <0afdeda7-558e-647f-ef28-1fcd80807c1b@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jk2rhlye3btfhqb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 18, 2022 at 10:57:04PM +0200, Mateusz Kwiatkowski wrote:
> Hi Maxime,
>=20
> W dniu 18.10.2022 o 10:31, Maxime Ripard pisze:
> > Hi,
> >
> > On Sun, Oct 16, 2022 at 09:46:49PM +0200, Mateusz Kwiatkowski wrote:
> >> @@ -308,14 +324,15 @@ static const struct vc4_vec_tv_mode vc4_vec_tv_m=
odes[] =3D {
> >>  };
> >> =20
> >>  static inline const struct vc4_vec_tv_mode *
> >> -vc4_vec_tv_mode_lookup(unsigned int mode)
> >> +vc4_vec_tv_mode_lookup(unsigned int mode, u16 htotal)
> >>  {
> >>  	unsigned int i;
> >> =20
> >>  	for (i =3D 0; i < ARRAY_SIZE(vc4_vec_tv_modes); i++) {
> >>  		const struct vc4_vec_tv_mode *tv_mode =3D &vc4_vec_tv_modes[i];
> >> =20
> >> -		if (tv_mode->mode =3D=3D mode)
> >> +		if (tv_mode->mode =3D=3D mode &&
> >> +		    tv_mode->expected_htotal =3D=3D htotal)
> >>  			return tv_mode;
> >
> > Is there any reason we're not using the refresh rate to filter this? It
> > seems more natural to me.
>=20
> Let me give you an example first.
>=20
> There are actually two ways to configure PAL-60-ish mode on VC4/VEC:
>=20
> a) Modeline 13.5 720 734 798 858 480 487 493 525 Interlace, standard regi=
sters
>    set to VEC_CONFIG0_PAL_M_STD, custom frequency enabled and set to 0x2a=
098acb;
>    Setting the standard registers to "PAL-M" puts the VEC in true 59.94 H=
z mode,
>    so the video timings are identical as for NTSC (or PAL-M), and the cus=
tom
>    frequency makes the color subcarrier compatible with regular PAL recei=
vers.
>    This is the "true" PAL-60, thanks to the true System M timings.

That's the one I would expect, and I assume we could just do that by
selecting the 480i mode + PAL TV Mode property, right?

> a) Modeline 13.5 720 740 804 864 480 486 492 525 Interlace, standards reg=
isters
>    set to VEC_CONFIG0_PAL with standard frequency; This is a "fake" PAL-6=
0 mode,
>    the refresh rate is actually ~59.524 Hz. Most "NTSC" sets will be able=
 to
>    sync with this mode no problem, but the VEC is actually operating in i=
ts
>    50 Hz mode - it's just the "premature" vertical sync signal causes it =
to
>    output something that is similar to the 525-line system, however stric=
tly
>    speaking non-standard due to lower horizontal sync frequency.

But it's not really clear to me why we should support both.

> This comes down to the fact that:
>=20
> - When VEC's standard registers are set to VEC_CONFIG0_NTSC_STD or
>   VEC_CONFIG0_PAL_M_STD, it operates in the "CCIR System M" mode, expects=
 htotal
>   to be exactly 858 pixels (and it will generate horizontal sync pulse ev=
ery 858
>   pixels on its own regardless of what comes out of the PV - so there wil=
l be
>   garbage on screen if you set it to anything else), and vtotal to be 525=
 lines.
>   It will not accept vtotal that's any higher (it will generate its own v=
ertical
>   sync as demanded by System M if not triggered by the PV), but it can be=
 lower
>   - resulting in modes that are non-standard, but otherwise valid.
>=20
> - Likewise, when the registers are set to VEC_CONFIG0_PAL_BDGHI_STD,
>   VEC_CONFIG0_PAL_N_STD or VEC_CONFIG0_SECAM_STD (SECAM is a bit special,=
 but
>   that's irrelevant here), it operates in the "CCIR System B/D/G/H/I/N" m=
ode,
>   and likewise, expects htotal to be exactly 864 pixels (garbage on screen
>   otherwise), vtotal limit is 625 lines, etc.
>=20
> Checking for the refresh rate would only work for standard-compliant mode=
s and
> have the potential of completely breaking on any custom modes. Conversely,
> checking for htotal aligns perfectly with the limitations of the hardware=
, and
> allows the user to set any modeline that the hardware is able to output w=
ith
> any level of sanity.

OK

Thanks!
Maxime

--jk2rhlye3btfhqb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY1FqegAKCRDj7w1vZxhR
xTCZAQD8HrGLfHSNXMRBGaCdaJ3+FZli1x2KR4n2E+Ou17V3dAD/VuPxqeIQn8hs
8D5czhazALn5yqYpBwT4VrLe/TjHiwo=
=GDVy
-----END PGP SIGNATURE-----

--jk2rhlye3btfhqb5--
