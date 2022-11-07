Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA061EFDB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKGKCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiKGKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:02:15 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61333183BB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:02:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5E2002B05B05;
        Mon,  7 Nov 2022 05:02:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Nov 2022 05:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1667815325; x=1667822525; bh=EGvXLw4tRF
        +bUdJCRxzWOerhFrvg00IBqmpmi1s4Rko=; b=kN/K/+W+W/ddU3QqI3ZX6Ox4n7
        hInbfU7nv34ZqYeEP1iavLM2uHeJ6PDDL/mxfMAyR60NSrhSxazmFL47+oYwfek/
        Crq8bE3W7yZMEQVDdiCVyDmAsipb/NDmwdOGN/NyFwDLEZgYkIFlqCU8teEadQhS
        tynepdw72go4ZuzCmcZJXOHwpTPFnjqTQzhJ8HoIiUppJVNUtR+Fb4qouWZBg7Va
        j93rprz/Xqy3t+a4iyJhasrpj+NUD1tSeqJE7tcLTMLj48qG9ZKMZ4swJ/fvRm0s
        3bkwk32DY9P13xcfwnlqIqUhwsdc6arn7o01ul+dL1eiDRY+DYjdZwSOUrhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667815325; x=1667822525; bh=EGvXLw4tRF+bUdJCRxzWOerhFrvg
        00IBqmpmi1s4Rko=; b=QhxLDcYjSyGZek0t+w5u2aOw8DT/wHPi6TG8ksD7c2Os
        7L3aYI0hLCB1J3z7bOFhbhAKRr1XH9YSBmIbbqFOBGTuQicnZsClPwa2PabOgxNa
        0mCSomQ+JHC1T3VfAjedV7goZjMFRM/EAybIjztr4/YMREwnxiV44TRcDaqABBHW
        L34EF2Joga00w6om+FXHKJcARzSDhwY5hGqYcLxML13C1hrV89tZYWk0MpYFmx4M
        4bPd7HbeAMF6u//IHTI/EKkGHEUU6CCTRCz0drNymYdIYZ5KLSXzFfPRrBdpq5xv
        wgAduEqlXnVAG2YeiU7F5xosd7FERyBlv35VtKMl7w==
X-ME-Sender: <xms:nNdoY6W19wdQMLVel4ediy0uouq05huRiSTxdTY4m3_4By5jLHirXQ>
    <xme:nNdoY2mxvMPkxBX_8gJUrwiWEvwSoWkKFyfbtoWeg2DQSgIdFSeVCLAbzpsF-iqTx
    mqpj5QTArkYxWYaSLs>
X-ME-Received: <xmr:nNdoY-Y36HCri3tXywSVPcXLZFo0LHq6vbTWCg1iZWXFGIUiMc7bECifcFTOadXfmrDvGkPLNSXg8QhZM6oWiMPJPS8AQygXpRaXtKmDo6Hg9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepieehffffvefgiedthfeiieeutdfgffekhfehgfehgfeiuddutdfftdekffeh
    heevnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:nNdoYxXdA_YniTlEhmDbNZ6WqA-tqPZYWh2Hsq-xSM1ukwLyqRTsuw>
    <xmx:nNdoY0nE5Xm_Mcqm_XyETuxAGcxcZWZTSXzESyTIUzhrVslVCIThng>
    <xmx:nNdoY2fFYBcr9GzyX7PwTDuvlRQno8ijFvdIajzctp2ZNu79oONE-w>
    <xmx:nddoY4G4EHTOkzsJYmUDJIsl9Fx2bs977k7rh4qBmJfYsPrmFTAIHQ0YKys>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 05:02:04 -0500 (EST)
Date:   Mon, 7 Nov 2022 11:02:02 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Karol Herbst <kherbst@redhat.com>, Emma Anholt <emma@anholt.net>,
        Ben Skeggs <bskeggs@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, linux-sunxi@lists.linux.dev,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 10/23] drm/modes: Fill drm_cmdline mode from named
 modes
Message-ID: <20221107100202.mv6b4uewzgpj2mf4@houat>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-10-e7792734108f@cerno.tech>
 <fa1e7635-ffd6-bf01-77aa-4016f31554e1@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3igasrhfxn453up"
Content-Disposition: inline
In-Reply-To: <fa1e7635-ffd6-bf01-77aa-4016f31554e1@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3igasrhfxn453up
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 06, 2022 at 02:04:56PM +0100, Noralf Tr=F8nnes wrote:
>=20
>=20
> Den 26.10.2022 17.33, skrev maxime@cerno.tech:
> > The current code to deal with named modes will only set the mode name, =
and
> > then it's up to drivers to try to match that name to whatever mode or
> > configuration they see fit.
> >=20
>=20
> I couldn't find any driver that does that, all I could find that cares
> about named modes are drm_client. Did I miss something here?

sun4i at least does it:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/sun4i/sun4i_=
tv.c#L292

I'm not aware of any other driver relying on named modes though.

> Apart from that:
>=20
> Reviewed-by: Noralf Tr=F8nnes <noralf@tronnes.org>

Thanks!
Maxime

--y3igasrhfxn453up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY2jXmgAKCRDj7w1vZxhR
xbFeAP9qPjF1vwW8JaPeSCTHChhS2FnOIGUmcNPxtQgaD+eqWgD+PuirHPq1OF1i
g6XJzb8JOxNS7dRxptuSpZXP2iFvPA4=
=1+Ik
-----END PGP SIGNATURE-----

--y3igasrhfxn453up--
