Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1E5E9F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiIZK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiIZKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:24:44 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389624D838
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:18:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 509A82B06A11;
        Mon, 26 Sep 2022 06:17:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 26 Sep 2022 06:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664187438; x=1664194638; bh=rl9YQRMrLQ
        Jn6n80xCv8aYOf+VIHpMfcgzt7f7zjMaU=; b=iiiaYcTZ9qp70c+RGtu3oMk2bQ
        WP19OHHjsm9H+9BdRB7BKF/l+t2LpvuC9aA2U4r2rIXXTDcRi+VrBAgHkJciICSN
        Bnkx4HOz6KPeFUCRwNTxSXqZyDdqgG5iVc4j3m9Sk/8CIWlqV71w5kS3j4ZK52+2
        KNLUZwjhkMb6eEt3jjoNtTG7+PU/H6526hXP6bQ+PEgNOsd5JYKiMOwN9XDg5zqB
        oTDDAaiaOXFTyHa5ooZkgmRnBVeriZIb0vLZWTqgCOMejt9rt8JTAmEoYZz/ELIw
        VtgDrUlpCIgvNpvEU5v08/5g6xJDPoyfAjMfcdFOy+RobY/5E5tcDd/p+7hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664187438; x=1664194638; bh=rl9YQRMrLQJn6n80xCv8aYOf+VIH
        pMfcgzt7f7zjMaU=; b=r5zUfGaaAw67Am5QZUwRH9tW4S+orq5guCn5NBSQ2DFZ
        5R7CaDZdg1/bA/tvdX1mU0+byqe+H7OSwtHcRY8gc3+I4ctgoD6A5N9zMXFP6C7H
        Oy+MPxzU6TlBZ08XZf2t6XSowTTDpY48Eg/TvGiOkKDb1cbVarh82NXsK/DAT0c9
        NzbzwI8T0hqKexErAay6q4BS9TjT57OeiBnrkAI0+QUdBj2G7r9BDDMeS3+bHZPN
        4ytBRePtCHl4mTWfUPyJb4HQ8pXXI/RMGfFd72t7p+g4yKSrTFt/pjNBXKtCKWjv
        BGdTFT9mwT91ri6qZJegiLMBzN1JHvXDztyZDfkR1Q==
X-ME-Sender: <xms:LnwxYzgNEmlWSI-iRsLHKIz4RDfxDCN95Lg0eL-TBa-kica_ueMtrw>
    <xme:LnwxYwANJvypltOLJRxmn6KA3HTC6PqV6xGjd80tGPuewYSi7JUswggsxlUBVa5fl
    wzzidljZOx2NwpfFPM>
X-ME-Received: <xmr:LnwxYzHhQX_dk01wS-DnCS0tqvcLRpTPvOt7cSjErYwNexn3NtBtty1wZpCb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LnwxYwRUbrtzrvWyCAcSHposR4ZzgYU4nuOQoCW7hsSUN6S2deRXmg>
    <xmx:LnwxYwwiaRV9Yvlxpej_I2Fl6e4FHx7h2SnAJfsaERfQJIt_xqzFnA>
    <xmx:LnwxY27jUN7CWecX-f0oAUW-abJHdxLwmcNx7iw4z3dQynAbgviV1Q>
    <xmx:LnwxYxRbcCHjLPEee4BWMO5EAhVXZuHSZlrKQPQhZJ5lD8uRXCQ0JNaIy_Y>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Sep 2022 06:17:17 -0400 (EDT)
Date:   Mon, 26 Sep 2022 12:17:16 +0200
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
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 10/33] drm/modes: Add a function to generate analog
 display modes
Message-ID: <20220926101716.urehomr2lzv5pqln@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-f733a0ed9f90@cerno.tech>
 <72a8c3ce-ed03-0a77-fb92-eaa992eb86fe@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k7oktdtvp3ipcm7k"
Content-Disposition: inline
In-Reply-To: <72a8c3ce-ed03-0a77-fb92-eaa992eb86fe@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k7oktdtvp3ipcm7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 23, 2022 at 11:05:48AM +0200, Thomas Zimmermann wrote:
> > +	/* 63.556us * 13.5MHz =3D 858 pixels */
>=20
> I kind of get what the comment wants to tell me, but the units don't add =
up.

I'm not sure how it doesn't add up?

We have a frequency in Hz (equivalent to s^-1) and a duration in s, so
the result ends up with no dimension, which is to be expected for a
number of periods?

If you're talking about the comment itself, then NTSC mandates that a
line is 63.556us long. If we're using a pixel clock at 13.5 MHz, it
means that the period (=3D=3D pixel) is ~74ns, so we get 63556 / 74 =3D 858
pixels / line.

> I think you want to end up with 858 pixels/line =3D
>=20
>   13,5 pixels/second / (60/2I frame/second * 525 lines/frame)
>=20
> I: interlaced
>=20
> Maybe just remove the short comments and document that in a more meaningf=
ul
> place.

I guess this is where it's meaningful, we really want to hit that
target. BT601 also mandates it.

Maxime

--k7oktdtvp3ipcm7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYzF8KwAKCRDj7w1vZxhR
xV9fAQDnxZyqz39vGg64Oqr+zhaZZobk1gPiciVJ4v0EI/nzOgD/VaWQoS8Orsjk
80pHjJdXIU06FcXOaBvhX/eYS4k7mAo=
=RnOU
-----END PGP SIGNATURE-----

--k7oktdtvp3ipcm7k--
