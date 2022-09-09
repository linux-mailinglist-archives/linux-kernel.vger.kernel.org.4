Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603225B3A64
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiIIOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiIIODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:03:02 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4A1451C6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:01:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id B0EA22B0591B;
        Fri,  9 Sep 2022 10:01:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 09 Sep 2022 10:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1662732069; x=1662739269; bh=m8uWKdPqim
        TWOzbuWW9LjUIAMA5qm4azX49SLBOts+k=; b=YnzdqFanu76LTppWsnIK8yLtaw
        lPA9imn+DZMPpvmB+I+7lJ6Jtp5+Hpp/Tok4Syo0TZ+GIWgrmrIbPdzEP4csf+60
        UpEKybV/LKbOlJdebq8NtpHOX+q7UOoX+sClEWg/wr6povq2rrWI+ugq/sOCi5sZ
        xXq4KnkJMjk8hfkCCos2ghiXoM12HoF0kloEOtYmIVJ6ltnGXUKNF564vpDCPNZ8
        s3ORSfM8MEpwoQU39DDpbNTFwB5Y6PTP2jBZlZSeNbsxTCVjtqfLM5MdZpTnhTm0
        1aNFaQE+vAnk+ZlPCXOLfH3n3kaTBYCY1K1ZgQJMdDQ0emXorULHJv6IpDTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662732069; x=1662739269; bh=m8uWKdPqimTWOzbuWW9LjUIAMA5q
        m4azX49SLBOts+k=; b=UytRIGBeAIK3cYsdpEIIrN8FMBS+DdyAfw8Linj+rJgL
        g9vqVDLzMqf7z+Zq8GuX6nB76z8BX3FKfH+w0cZYcxf5Vz1m0pmqpzc3QIz1lW3i
        +qcJUgH8UYU/JZkQyJ+J0ILb8T/3YoB894efCxXtrvJD63y7GfgcmlpZQaGweQGA
        3eQ73GeIApaHjQjnZeXMJ6l+v13ZgTzTWY7kfviqp+zfyuG5zITuOFrJ7DO7a31p
        LGTFP167QAdPLgsgxgQNe88zlb9eOnmg96qLVG2u074AnI7rabwwsuOPnUoohp3d
        BjaoBlxQzhdosblojNXzRuwyvhSKAM638mnzlx7/7w==
X-ME-Sender: <xms:HUcbY1qT4kf-mTq2fLzQRaYzl9AUayFOIl0kpRAPDPE4ezb1dL-L8w>
    <xme:HUcbY3q1yVbTY68aHnr8xWgLWQ2NifWxNpAv2F6FOlAMWgmXE5VamBILHxPMGXevN
    _IGnIPLwdFJ29d9c7o>
X-ME-Received: <xmr:HUcbYyM5xjzmO3e3dtMoonVbYC1ch27-ZEspCcDtsSMffAErxYBzJgCFtjCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:HkcbYw4y40JUDqNYJ2TTJTgsJ4f-o9o3EZPSRODX5u_vtjccrEFEtg>
    <xmx:HkcbY06o4B69hhN80GOqN_IEEzN6bZfUaP6ctsZrDz9l9eV09pSOOw>
    <xmx:HkcbY4hZrEnQSH_qfGbJ9HkdECI_If740JoappUZ-WA_oiQJHLK6Cg>
    <xmx:JUcbY07qgZzJA_p9otXIwoarGt3HNeaPn6bgdqRlPR-XGkX3B4ktoodc5Z8>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Sep 2022 10:01:01 -0400 (EDT)
Date:   Fri, 9 Sep 2022 16:00:59 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 10/41] drm/modes: Add a function to generate analog
 display modes
Message-ID: <20220909140059.g57oihcmhuym62ei@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-459522d653a7@cerno.tech>
 <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
 <20220905133755.gcmmntg3wnecyqjq@houat>
 <10ce686a-d7c8-9ce4-3979-735ad8eab3b5@gmail.com>
 <20220907143421.4iopqwhp3yfircsh@houat>
 <dc1d9499-d4d5-1032-f39f-d4ac4cbb8412@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kc2bu6zgime3t2ko"
Content-Disposition: inline
In-Reply-To: <dc1d9499-d4d5-1032-f39f-d4ac4cbb8412@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kc2bu6zgime3t2ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 11:31:21PM +0200, Mateusz Kwiatkowski wrote:
> The "canonical" modelines (at least for vc4's VEC, see the notes below):
>=20
> - (vfp=3D=3D4, vsync=3D=3D6, vbp=3D=3D39) for 576i
> - (vfp=3D=3D7, vsync=3D=3D6, vbp=3D=3D32) for 480i
> - (vfp=3D=3D5, vsync=3D=3D6, vbp=3D=3D28) for 486i (full frame NTSC as or=
iginally specified)

It's not clear to me either how you come up with those timings?

Maxime

--kc2bu6zgime3t2ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxtHGwAKCRDj7w1vZxhR
xYMtAQC2BqS997PQeLRZyCLXvTlUXGBvB07pmDNLHPWzQICluwD9FWnB9aaQ3tLC
/OsNpUuYwh9XQJfUVrt4RcFvukTzXgc=
=jc5S
-----END PGP SIGNATURE-----

--kc2bu6zgime3t2ko--
