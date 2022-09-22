Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF25E659F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiIVOb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiIVObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:31:23 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3319FF393D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:31:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id C17A62B059FF;
        Thu, 22 Sep 2022 10:31:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 10:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1663857076; x=1663864276; bh=PSbckky/vf
        b6Oou4WEkAhmKsf55tE8D3S2rXFHNq4Mc=; b=HGoqwoZvN5V1Bba2VsSkL1rKHB
        zzHhgOFiEXIYie2ux3QVC5bRMjRCIRoo7saBpWhfLLKG1PCfTaMqbHlqAyth8t9f
        erVN4v1oVDLfBp8Yt0AkPWINC+O/4Ez3k8QOcaIq6dcMvQIBM+nsloTbaw8Yg865
        Vb6s4bdVeBQZoZd+TPFsU9G2XdcWhixNlH03VlQqODYZuvTuN8mgkThLziL80p2H
        d8sA1eGCmVSVtrBaP8YB9VcCZEYVVQ07/y5iK7NoPjzWr02NlTD3cLSVToi3NaNf
        u6yi5g3xw1KIPRRx+PTpY9hH88rQw2K/byZ2NRbALvQt3sJYGh1fIygKC+KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663857076; x=1663864276; bh=PSbckky/vfb6Oou4WEkAhmKsf55t
        E8D3S2rXFHNq4Mc=; b=EqRicMT6rXUrxACQB7sJ7Vn98PONe7nvEhPFjWYmJY3m
        x3wJ+RifaVHBdCFgoGCEirF0HUMh8x9e41uvIDPpxHWhDGheapsFWg4g8+mRw7sS
        mZJpcuf+q4Bai0e16oQxM7Z9nnXjd3bt31T/VbHDGhiz5oniIAgxOJFftX2WSzIf
        2YakhiYuv2OSw3JNIIb1Ex0J+KtNhahBVvQetXtF3EMPYhEGeGH1eF7/4RWEaDov
        C3PYwKcu5lY7eW8hrXe/M9f9rxY17GV9fOmVMQvWwmkgkr+w2kzXcWjXfR1D9Dkf
        eUivdGbaz9UJTCQlxvwle4WpB6nqI9kaD61+zGzCkQ==
X-ME-Sender: <xms:tHEsY0P8MIR-y_shJ-dBS2WnOnT8geuXjN8qp_CabMuKUDqjUaQ77w>
    <xme:tHEsY6-2OTtPFAS5rG53ypbgppqlJvUPCpQDehpWpQA1PvBYy2ZR9FOB4o8hAjMsU
    J1MUmzt27M-czrHILc>
X-ME-Received: <xmr:tHEsY7RaaDSBL28ABWcivoHWziI6snsJXiZ5TyqIy2WYuTxKl0sUHDhmmTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeljeeugfegveetleevkeetffegudevieetieeugeeugeeivddtjeejvdef
    feetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:tHEsY8vCvwx2DZ256SxSgp_intgabWEygnDecU5FyNZKQybbzkkfmA>
    <xmx:tHEsY8cWEJAiXAGcc3ToVFo3EMPl-4kBUNfV8h80zA_Xe_adsa4tZA>
    <xmx:tHEsYw0Zq92dWuHSoJs34d6okYPvG74ERNbB5383o2rpawMnzHBdJQ>
    <xmx:tHEsYx_NBJib2gwM_4xIH3jNFjHKllkRDEyvqroL8YHIhHuP78gSPY4YXEw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 10:31:14 -0400 (EDT)
Date:   Thu, 22 Sep 2022 16:31:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
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
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 00/33] drm: Analog TV Improvements
Message-ID: <20220922143112.urvqqdino6zqqbsu@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gei6k2mhrbbihx2s"
Content-Disposition: inline
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gei6k2mhrbbihx2s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 22, 2022 at 04:25:17PM +0200, Maxime Ripard wrote:
> Here's a series aiming at improving the command line named modes support,
> and more importantly how we deal with all the analog TV variants.
>=20
> The named modes support were initially introduced to allow to specify the
> analog TV mode to be used.
>=20
> However, this was causing multiple issues:
>=20
>   * The mode name parsed on the command line was passed directly to the
>     driver, which had to figure out which mode it was suppose to match;
>=20
>   * Figuring that out wasn't really easy, since the video=3D argument or =
what
>     the userspace might not even have a name in the first place, but
>     instead could have passed a mode with the same timings;
>=20
>   * The fallback to matching on the timings was mostly working as long as
>     we were supporting one 525 lines (most likely NSTC) and one 625 lines
>     (PAL), but couldn't differentiate between two modes with the same
>     timings (NTSC vs PAL-M vs NSTC-J for example);
>=20
>   * There was also some overlap with the tv mode property registered by
>     drm_mode_create_tv_properties(), but named modes weren't interacting
>     with that property at all.
>=20
>   * Even though that property was generic, its possible values were
>     specific to each drivers, which made some generic support difficult.
>=20
> Thus, I chose to tackle in multiple steps:
>=20
>   * A new TV mode property was introduced, with generic values, each driv=
er
>     reporting through a bitmask what standard it supports to the userspac=
e;
>=20
>   * This option was added to the command line parsing code to be able to
>     specify it on the kernel command line, and new atomic_check and reset
>     helpers were created to integrate properly into atomic KMS;
>=20
>   * The named mode parsing code is now creating a proper display mode for
>     the given named mode, and the TV standard will thus be part of the
>     connector state;
>=20
>   * Two drivers were converted and tested for now (vc4 and sun4i), with
>     some backward compatibility code to translate the old TV mode to the
>     new TV mode;
>=20
> Unit tests were created along the way.
>=20
> One can switch from NTSC to PAL now using (on vc4)
>=20
> modetest -M vc4  -s 53:720x480i -w 53:'TV mode':1 # NTSC
> modetest -M vc4  -s 53:720x576i -w 53:'TV mode':4 # PAL
>=20
> Let me know what you think,
> Maxime
>=20
> To: David Airlie <airlied@linux.ie>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: Emma Anholt <emma@anholt.net>
> To: Jani Nikula <jani.nikula@linux.intel.com>
> To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> To: Rodrigo Vivi <rodrigo.vivi@intel.com>
> To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> To: Ben Skeggs <bskeggs@redhat.com>
> To: Karol Herbst <kherbst@redhat.com>
> To: Lyude Paul <lyude@redhat.com>
> To: Chen-Yu Tsai <wens@csie.org>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Samuel Holland <samuel@sholland.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
> Cc: "Noralf Tr=F8nnes" <noralf@tronnes.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Dom Cobley <dom@raspberrypi.com>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> ---
> Changes in v3:
> - Applied some of the fixes to vc4 and sun4i
> - Renamed the old TV mode property to legacy_mode
> - Fixed a bunch of bisection errors
> - Removed most of the redundant TV modes
> - Added a new None TV mode to not fall back on NTSC by mistake
> - Fixed the mode generation function to match better what is expected
> - Added some logging to the mode generation function
> - Split the improvements to the named mode parsing logic into separate pa=
tches
> - Added more checks to the TV atomic_check helper
> - Link to v2: https://lore.kernel.org/dri-devel/20220728-rpi-analog-tv-pr=
operties-v2-0-459522d653a7@cerno.tech/

Sorry, this is obviously the v3...

Maxime

--gei6k2mhrbbihx2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYyxxsAAKCRDj7w1vZxhR
xTkfAP9I//dgydbADcLgZF9kVBixM1r07WIE9jCMphXvmq+M6wEAtmc47sVQX/IN
TCKBLIqKTj6E21CFHFgGQefJ8rXkqQo=
=oVDB
-----END PGP SIGNATURE-----

--gei6k2mhrbbihx2s--
