Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627BC6026F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJRIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:32:00 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCB1C8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:32:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6B89B2B06866;
        Tue, 18 Oct 2022 04:31:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 18 Oct 2022 04:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666081915; x=1666089115; bh=fVI2EJnVlp
        jbITRfhf/MEDKDIYqZ83EHW+uFvYqJ3GE=; b=E/oS9DyWhA8g58HLIuCEAdjp+3
        t+kXUNNmuvVW4gCFTX4uansKgdcI0z1od/7hZp2owj39fURNiT13fB47gkmtn3CJ
        2H2C4LDxzVpImC14E5MiwhaFrP/wzx0Zu6aWSo8vnz6ZiWDuTzIf7mPSafcjIjL7
        Ktt68vaMOaL1Kas6E5aO6d4LP7+lFw8cRiOqNGQ3Ck9TjNIGleczD4KO4Y16ATdN
        sp/ePs2Cxw97s3Eiok74y0erQQ34oFh1UGuDHwcy17gmgBVPIBuw4DUrHqNzS+ar
        dGgnm7RqzlAZVuXIWgZCjwAOse8HIxhDma/q9bVSzJFrtJEPU0+B2qfcoqfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666081915; x=1666089115; bh=fVI2EJnVlpjbITRfhf/MEDKDIYqZ
        83EHW+uFvYqJ3GE=; b=epm9K8FSvMhkC5qc+KzKqUBNaO6dGHyYD3uVRcM+AfSC
        DQBGTJwzntTrsvr9uPrUGuWUjd0kBwTiB7h73aMrJmvShW1KtQzk3qA5CMlu3UJ6
        re2xV5ugJXQEII1HodNUDxsnFaQk7bAUK7K66sg4a+gjWX9R/ZejWdxCimSSqYqm
        6QatFQOrHIKqRE7Qm7uB77oKaS+dx/V9Gh5wqIfrIkPBteGluP+B60oBLht7/9rQ
        7cCBygs54841y6xJ1O8yAye2mw90tr2EOGp6fYbN5VA9ebIJ6C+7vG+1lPuCYK9/
        Ugc+txHMO0LDiAjWoEy7aqQHW0V3BnalWAoLOA/+6A==
X-ME-Sender: <xms:emROY46iy60goFrr_WU2zHsL9iuc399b7JhJODl0-LgksKAMSNTkcw>
    <xme:emROY57mnTp_3ENJZ8OzX0xtCU67J4FOTM3VAdL5AaO4kupPv__bkOI2R59aE_brX
    hCZtUfG-FNzTAksq_o>
X-ME-Received: <xmr:emROY3d9dWcAzYHBLjYTAdJNGT4GClAW81v9347IhMA51V5iLYMj3p-idlvT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeluddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:emROY9LBVry6aKrA2NlwwP8wDSRg7PDiELeB6DYc4Gds3rw9XRoR1w>
    <xmx:emROY8L27ihIBZ4gnvlia-DXnfdfA_eN5iKOAOL9U6b_pHaaBPg2RQ>
    <xmx:emROY-z4L1c83o5TN_73-0SbD7iixLdy2H6Hz8SbNhRW99CwE2zKgg>
    <xmx:e2ROY2o2vgyykG5PFglEXmdAutCaV1CBZNCRvmLRTqHCgXcMUXkOxWVRiJg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 04:31:54 -0400 (EDT)
Date:   Tue, 18 Oct 2022 10:31:53 +0200
From:   Maxime Ripard <maxime@cerno.tech>
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
Message-ID: <20221018083153.okkqpd5ccfrnwdj3@houat>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-21-d841cc64fe4b@cerno.tech>
 <93bf9fcc-c645-b042-011f-8f1fc957af48@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gs7goob5irll63bf"
Content-Disposition: inline
In-Reply-To: <93bf9fcc-c645-b042-011f-8f1fc957af48@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gs7goob5irll63bf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 16, 2022 at 09:46:49PM +0200, Mateusz Kwiatkowski wrote:
> @@ -308,14 +324,15 @@ static const struct vc4_vec_tv_mode vc4_vec_tv_mode=
s[] =3D {
>  };
> =20
>  static inline const struct vc4_vec_tv_mode *
> -vc4_vec_tv_mode_lookup(unsigned int mode)
> +vc4_vec_tv_mode_lookup(unsigned int mode, u16 htotal)
>  {
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(vc4_vec_tv_modes); i++) {
>  		const struct vc4_vec_tv_mode *tv_mode =3D &vc4_vec_tv_modes[i];
> =20
> -		if (tv_mode->mode =3D=3D mode)
> +		if (tv_mode->mode =3D=3D mode &&
> +		    tv_mode->expected_htotal =3D=3D htotal)
>  			return tv_mode;

Is there any reason we're not using the refresh rate to filter this? It
seems more natural to me.

Maxime

--gs7goob5irll63bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY05keQAKCRDj7w1vZxhR
xaoGAP9HmWvEP2iOcoDGqog26qg7gWYMxwwOjWfwgHtgcV81kQEAx9tCz7NmGbD4
TRrl+IN8yZd5ByEPUAc0V6js5M4u6w8=
=0Z/k
-----END PGP SIGNATURE-----

--gs7goob5irll63bf--
