Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4062061F3A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiKGMqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiKGMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:46:10 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DEB1C40F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:46:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 0478A2B05E55;
        Mon,  7 Nov 2022 07:45:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 07:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1667825159; x=1667832359; bh=aCBuDDCTfo
        ZSnelYeWWd5jAjRGm3SKR/gWkf1WzFlvA=; b=fe7Qh9ENKhkuZt9/GPDNxJ2scx
        spfqCPnmow5kVNVn7V2ZlyYoKqvXQnb5h25X/K6mxkPeTobwsbGdqUauJBjeXsEx
        rTjZZoxdBoWYC9oG0wnuFbBRgAoo/Y7C243KlPg481Cy+LlCwB78WfBjm6eNFjgg
        U+Ir/pdrUbm/OxyzaI22gfdkbc4ctncUR5FXTsqDvTZchDF5l5NNGgOjdEZ16YnN
        tTZao2/Zw8vYM+j3omW0ZUQfaZtI+aoc6CPEFUQFSHdXmSKHAaZrfh4ZhDaU9Poz
        /Qr4QCnghkjW7G3qtuR9dJwX2RmrQLmW7ntQBQJJThHI5Bmmo5NSrVtxoS4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667825159; x=1667832359; bh=aCBuDDCTfoZSnelYeWWd5jAjRGm3
        SKR/gWkf1WzFlvA=; b=WDiQgo7382zLJ7uJNNFLZLHgcRrYTi04F+A1Z1aIm60d
        IBxa39Lm0Y3HwsMbX45LSO5jr+II3UEjxpEqShWShLZgzAvnixfeJZVq07ZKkJWQ
        Y23yt/ZUeLIhSdNYJd9d0nlj5yza1LGU6svN6VqOMaJvpGBrLVDXco/u3pmJi7at
        m6WNMu+lUl6ovua3FyeL45ByNoue/i5/f9BBc9pa4BWxd5VsKhFj4cy80ssvIxin
        WTnk4Uc6wxGcVcQ4CKnBxc+r/XlgYR2Si8S5xTvAKnwFuHpAtdovqdT/h5fA1U9D
        66yluk5/ZPl0/0nNbbAVHJOH8vMAm57K/3cSyCk19A==
X-ME-Sender: <xms:B_5oYxkTIy0mUMSyflhpl-mdCCNyibVd3eazm0pZBLRP_rPNPov2Vw>
    <xme:B_5oY82zGUwsWi7FzVvIMVn48Y1y3YBjkNcuzAo2t-nJTH-MdmZFEjn4etMl1wuw4
    JV0ObuyEa0xCadNnb0>
X-ME-Received: <xmr:B_5oY3oU2PyTUy9263HAMn28QauzhYHEhwEZOYdG2hkB3_T4762eKBGZFASoTCi0cYMfqOtiSO3l6_IXQnkbbd4u12T_i5uhX14-u3_3al9iug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfegudff
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:B_5oYxnAwbs-rpo9JxYvy04EEIaYKD_7caxej8M_yUIO41NUaNyywg>
    <xmx:B_5oY_0EZQVwlGHQNt4aZsSAPHDFLo9A_TY5aX1zYiwMKX0QEvt5kA>
    <xmx:B_5oYwsKoY7uH4jol05JvJcq3VW9Jm8-yuMzJEbFUYWimjlAWdp2sA>
    <xmx:B_5oY_WpqNFwAF1Lpco9OJA9gAHe8906jiN45KaADSPPMNpCq-06s6BhuSc>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 07:45:58 -0500 (EST)
Date:   Mon, 7 Nov 2022 13:45:56 +0100
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
Message-ID: <20221107124556.nu6brodxdolh36w2@houat>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-16-e7792734108f@cerno.tech>
 <842076aa-8d7c-96d6-ba46-d0e66dacd2df@tronnes.org>
 <20221107102126.klxrvfe34e6uriyx@houat>
 <813ebf68-a7f4-441f-d0d6-f63fd923a479@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ottaxywmq5yqznvz"
Content-Disposition: inline
In-Reply-To: <813ebf68-a7f4-441f-d0d6-f63fd923a479@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ottaxywmq5yqznvz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 12:29:28PM +0100, Noralf Tr=F8nnes wrote:
>=20
>=20
> Den 07.11.2022 11.21, skrev Maxime Ripard:
> > Hi Noralf,
> >=20
> > I'll leave aside your comments on the code, since we'll use your implem=
entation.
> >=20
> > On Sun, Nov 06, 2022 at 05:33:48PM +0100, Noralf Tr=F8nnes wrote:
> >> Den 26.10.2022 17.33, skrev maxime@cerno.tech:
> >>> +
> >>> +	if (cmdline->tv_mode_specified)
> >>> +		default_mode =3D cmdline->tv_mode;
> >>
> >> I realised that we don't verify tv_mode coming from the command line,
> >> not here and not in the reset helper. Should we do that? A driver shou=
ld
> >> be programmed defensively to handle an illegal/unsupported value, but =
it
> >> doesn't feel right to allow an illegal enum value coming through the
> >> core/helpers.
> >=20
> > I don't think we can end up with an invalid value here if it's been
> > specified.
> >=20
> > We parse the command line through drm_mode_parse_tv_mode() (introduced
> > in patch 13 "drm/modes: Introduce the tv_mode property as a command-line
> > option") that will pick the tv mode part of the command line, and call
> > drm_get_tv_mode_from_name() using it.
> >=20
> > drm_get_tv_mode_from_name() will return a EINVAL if it's not a value we
> > expect, and mode->tv_mode is only set on success. And AFAIK, there's no
> > other path that will set tv_mode.
> >=20
>=20
> I see now that illegal was the wrong word, but if the driver only
> supports ntsc, the user can still set tv_mode=3DPAL right? And that's an
> unsupported value that the driver can't fulfill, so it errors out. But
> then again maybe that's just how it is, we can also set a display mode
> that the driver can't handle, so this is no different in that respect.
> Yeah, my argument lost some of its strength here :)

I don't think we can handle this better, really. Falling back to NTSC in
that case would really be a stretch: it's a different mode, with a
different TV mode, etc.

It's an even bigger stretch than picking another mode I guess, and like
you said we're not doing that if the mode isn't supported

Maxime

--ottaxywmq5yqznvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY2j+BAAKCRDj7w1vZxhR
xb/7AQCG07KDDgc9kKjA6n8S2OhuHBoykKN7GTSWoyw+kpRAagEAnEdqeUL2OIq4
HN0taVCbFlrBNSZhsZTGM0XTfAsy6Qo=
=S84X
-----END PGP SIGNATURE-----

--ottaxywmq5yqznvz--
