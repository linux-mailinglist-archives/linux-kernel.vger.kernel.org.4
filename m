Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76661F04F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiKGKWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiKGKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:21:52 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6459186FA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:21:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 837442B066A3;
        Mon,  7 Nov 2022 05:21:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 05:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1667816489; x=1667823689; bh=FPdyzqNkno
        LZUhP2W9zx3qRXwxsEZhxJnbsWmIM7q9s=; b=QVI4ViUBH4YxPOA9lWnWL9ptlQ
        GzRJxm3akv7pRgn4Lgu2Namq5G2UgGuhr9akyfG1ibYTg/mOYCBey2O27HwtXzvU
        orXMBjgj/epbf44fS+bnCzEzoezNxNm237lfNVF2mrHPo3p5iZxCeWGZpu6CISNw
        0hM/f8jZGGBqq+z2C7wTsjzg6m+9zcOEDVjrZkBiRoExNrEonn4BM5UboOUBDITN
        3t2QGTLrLJlhadHKF71aXvYVPLpw6Yc7snW6P0bTuwZ/IfMigaB0GbCD1iVAC2nt
        9f3OJS0DpyCeKNxTdQtNTFBhj5x0VG63oNUSiZ+bVNajNeyh4wvO1KJElE9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667816489; x=1667823689; bh=FPdyzqNknoLZUhP2W9zx3qRXwxsE
        ZhxJnbsWmIM7q9s=; b=Ycq6u79xpleK9NLFkmSSE+vWJdz187ocPqXnvzaL4lVc
        hVjDHXA1VlnPmkCp2KrG1j7LWaA+zdKj/0IF6L11OEPNw3ikKa3Z4BOsroFgu/To
        s2hePi98JUu3mTp6S1DaLIOPStmWZwu/vzIQz1O+UB3WBkFq2PtbKlTjdZUZ6rBh
        rbnf4vyKD7O26USrGkwlN3aDb60xYab0yha0JWtiXJE8LdoaHqCWJrWDy/D1reM+
        rRbv0ZLLFbN6l351CyzLIyuNYb/0zwInMSEu+fyxhMUYW+9PEulNyPJVmYiYX5Nf
        RDcV4Ut9dVpzbC7Nec4nxUHeRG0MXCI77r3AGPRysw==
X-ME-Sender: <xms:KNxoY-LOL3K8mIhCu1PvK_DUqG3Ox93ebaLYUBL_xhwGxxUwlDVC8g>
    <xme:KNxoY2I-iI5tTmWS4pywux6iVjFkwgFcLcjyqcHED2pPkD4b3IbYfzBaGalx7WHgC
    3V0_QBTkUTFJaG-egs>
X-ME-Received: <xmr:KNxoY-vzxo3ZS7ES3vZ5uAQkdqLgXnqsysG43KBuNd6WEJEKkeWimf1n9s4Qk4IjP-Y3PU_V-IlqhPHk7Fl-cUARYIJnLTssWYjKDEuSkK5TzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfegudff
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:KNxoYzZpYghNfsHMr75aKnd1oHUp-emFPZXtErk1JfBJe3AtS_2zqw>
    <xmx:KNxoY1YUeQqJ3jmeSCjWEiddeq-ZtB-gW-A-9ZqNX3TcF_-KR8Wlxg>
    <xmx:KNxoY_CIARJZUE2TpmxcTEUNn7HoZzBYZCx7G5wJf0t79CZH6ZXLqw>
    <xmx:KdxoY77WqKgMcr1Xk39cnQVxWIXUiu3X_6QVZjhd-1gl9P5w6Z0KF1uUmcg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 05:21:27 -0500 (EST)
Date:   Mon, 7 Nov 2022 11:21:26 +0100
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
Subject: Re: [PATCH v6 16/23] drm/probe-helper: Provide a TV get_modes helper
Message-ID: <20221107102126.klxrvfe34e6uriyx@houat>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-16-e7792734108f@cerno.tech>
 <842076aa-8d7c-96d6-ba46-d0e66dacd2df@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7sshpbvkpms7fjp"
Content-Disposition: inline
In-Reply-To: <842076aa-8d7c-96d6-ba46-d0e66dacd2df@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7sshpbvkpms7fjp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Noralf,

I'll leave aside your comments on the code, since we'll use your implementa=
tion.

On Sun, Nov 06, 2022 at 05:33:48PM +0100, Noralf Tr=F8nnes wrote:
> Den 26.10.2022 17.33, skrev maxime@cerno.tech:
> > +
> > +	if (cmdline->tv_mode_specified)
> > +		default_mode =3D cmdline->tv_mode;
>=20
> I realised that we don't verify tv_mode coming from the command line,
> not here and not in the reset helper. Should we do that? A driver should
> be programmed defensively to handle an illegal/unsupported value, but it
> doesn't feel right to allow an illegal enum value coming through the
> core/helpers.

I don't think we can end up with an invalid value here if it's been
specified.

We parse the command line through drm_mode_parse_tv_mode() (introduced
in patch 13 "drm/modes: Introduce the tv_mode property as a command-line
option") that will pick the tv mode part of the command line, and call
drm_get_tv_mode_from_name() using it.

drm_get_tv_mode_from_name() will return a EINVAL if it's not a value we
expect, and mode->tv_mode is only set on success. And AFAIK, there's no
other path that will set tv_mode.

Maxime

--t7sshpbvkpms7fjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY2jcJgAKCRDj7w1vZxhR
xTwHAQC3meOlTapYDR/63QvLmjaN9u6WScoxy8cWAwXD3hmNkgEAnvQ95bgKGP7Z
6DzZToq4NJzBkDndagj4GbAu2CUSwAk=
=3B0s
-----END PGP SIGNATURE-----

--t7sshpbvkpms7fjp--
