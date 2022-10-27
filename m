Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F3860F6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiJ0L6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiJ0L6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:58:36 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FCB62913
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:58:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 9AD912B066FE;
        Thu, 27 Oct 2022 07:58:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Oct 2022 07:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666871907; x=1666879107; bh=QyApW52GGW
        OGnMQtvgaWWVm3IOEOZXDwE9lLItGdiLY=; b=uF//YRP5AA3BkLmQtb+sTcWpgH
        hk2HTy6BCO6QZu5obOUiI2weB0GqkqU7EYohbQTg1XdfrOGCYkVJi+p3vOUopU6I
        JTXI5dP21OTXqJRlGU/wvVC5PBPw4hYaL2AFhxYgnFTDv36LLn4rA7ytqFXb3zAk
        bt+FmImAVzuTI2sHRcVQRCv/XjSppxGquUVmshtTICQWRRE3m9az2fp8SqKScgPK
        TUaI0dfU29NYrX6H/9nIbVVx2ljADhJWJ5B6VvyFLDHVXCDe2q5n3d2htKFfJmAI
        ItI5qfAu65peUdI4fxjyHl+8YesnAPhZ0KQiGuVQ6WsmAbm8bItIXBigIHYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666871907; x=1666879107; bh=QyApW52GGWOGnMQtvgaWWVm3IOEO
        ZXDwE9lLItGdiLY=; b=X5KOnyeXpFpd9UUPBhTooylt8Bn5VnVl9lyj1OWBqdOT
        3eMOeTk76m/uJpIUSNpx/gKUJuCsu4oMVW+2w5uu53DfcAi2dyotu5NiSwMA7zF2
        kDpC9DrK+wT9QK/xPGF7J879cPUWSeP+ovy4NIXMMqQrF0uuI+vuw03DlVAz7TQS
        pt3dbB5A7FyhUe6nG3yGWQ9spnihyotU/dXSS9/Fo8475Urre+4o7TjnCZnzYvrs
        r73sucWl8RuMrSovYvdUOJfNWjeLek2qCEnfjkR9btgZ9nKZXlS5g5npQPNqoM5K
        h/RVHWs+mq0A+Pr7hQTRzfRHGu5MGs5r3H83s45SOQ==
X-ME-Sender: <xms:YXJaY5aeFRYAWvn_4boyMSlPUMtPRCncsfebLkPn-Q6m5CfNW_PJ0g>
    <xme:YXJaYwZm7WHUZ4VCxlOov8hTtv0A79G-cWt5Dgj26gKfHMnZOFkle9XMXBTCpmV6o
    -apSjI4Tjvh0SFXhos>
X-ME-Received: <xmr:YXJaY78spjTKUkqs_2fU1bkX399-R_60g_EZ6HLN9UCDvHmIwN8L37fqeEg548BrgWVS4NSVYcLiMFanpKixKS1DHe8BG4VTiYPaVutHF9KOyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdelkeejiedufedvhfeiffetlefhiedvleeigfeiuefghfdvleeiffejieeg
    teejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:YXJaY3oT7N2gwDsAC1XZ1-G64qxNS5TDU0IhUOr3L6R5DA9tlNkU0Q>
    <xmx:YXJaY0qrv5MIkv2IOYl7VbFqVH1wOBiT10oOQPp3y8ziLhtfYLWm-w>
    <xmx:YXJaY9QGn7FLTnwi69GrZCaqdXa_U_jeDlCBaFaWM1_9ltDBvk0OFw>
    <xmx:Y3JaY3J6VznhmYf_WAgBsElkAILibCXMtkm06H7V9vua4BwAYxwq7gGAKZo>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Oct 2022 07:58:24 -0400 (EDT)
Date:   Thu, 27 Oct 2022 13:58:22 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
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
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 22/23] drm/vc4: vec: Add support for more analog TV
 standards
Message-ID: <20221027115822.5vd3fqlcpy4gfq5v@houat>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-22-e7792734108f@cerno.tech>
 <e9b8ebf6-8781-0c55-5dd5-9f5077bd6b93@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ysfbxxbxsmqctfb3"
Content-Disposition: inline
In-Reply-To: <e9b8ebf6-8781-0c55-5dd5-9f5077bd6b93@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ysfbxxbxsmqctfb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 27, 2022 at 12:32:50AM +0200, Mateusz Kwiatkowski wrote:
> I've seen that you've incorporated my PAL60 patch. Thanks!
>=20
> I still yet need to test your v6 changes, but looking at this code with j=
ust my
> mental static analysis, it seems to me that the vc4_vec_encoder_atomic_ch=
eck()
> should have the tv_mode validation. I should've added it to the PAL60 pat=
ch,
> but it somehow slipped my mind then.
>=20
> Anyway, I mentioned it previously here:
> https://lore.kernel.org/dri-devel/0f2beec2-ae8e-5579-f0b6-a73d9dae1af4@gm=
ail.com/
>=20
> It would look something like this, inside vc4_vec_encoder_atomic_check():
>=20
> +	const struct vc4_vec_tv_mode *tv_mode =3D
> +		vc4_vec_tv_mode_lookup(conn_state->tv.mode);
> +
> +	if (!tv_mode)
> +		return -EINVAL;
>=20
> Without this, it's possible to set e.g. 480i mode and SECAM, which will f=
ail -
> but with the current version it will only fail in vc4_vec_encoder_enable(=
),
> which cannot return an error, and in my experience that causes a rather l=
engthy
> lockup.

ACK, I'll add it.

> But, like I said, I still need to actually test that with this version.
>
> Anyway, I was also thinking about adding support for the more "exotic"
> non-standard modes. NTSC-50 is, unfortunately, impossible with VEC, but
> PAL-N-60 and PAL-M-50 should work. The necessary vc4_vec_tv_modes entries=
 would
> look something like:
>=20
> @@ -325,12 +325,28 @@ static const struct vc4_vec_tv_mode vc4_vec_tv_mode=
s[] =3D {
>  		.config0 =3D VEC_CONFIG0_PAL_M_STD,
>  		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
>  	},
> +	{
> +		/* PAL-M-50 */
> +		.mode =3D DRM_MODE_TV_MODE_PAL,
> +		.expected_htotal =3D 864,
> +		.config0 =3D VEC_CONFIG0_PAL_BDGHI_STD,
> +		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,
> +		.custom_freq =3D 0x21e6efe3,
> +	},
>  	{
>  		.mode =3D DRM_MODE_TV_MODE_PAL_N,
>  		.expected_htotal =3D 864,
>  		.config0 =3D VEC_CONFIG0_PAL_N_STD,
>  		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS,
>  	},
> +	{
> +		/* PAL-N-60 */
> +		.mode =3D DRM_MODE_TV_MODE_PAL_N,
> +		.expected_htotal =3D 858,
> +		.config0 =3D VEC_CONFIG0_PAL_M_STD,
> +		.config1 =3D VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,
> +		.custom_freq =3D 0x21f69446,
> +	},
>  	{
>  		.mode =3D DRM_MODE_TV_MODE_SECAM,
>  		.expected_htotal =3D 864,
>=20
> I'm not sure if we actually want to add that. The two arguments for doing=
 so
> I can think of is 1. it should work, so "why not", 2. it means that more =
modes
> will result in _some_ kind of a valid signal, rather than erroring out, w=
hich
> is always a plus in my book. I can also think of a hypothetical use case,=
 like
> someone in South America with an old PAL-N-only set that would neverthele=
ss
> still sync at 60 Hz (perhaps with the help of messing with vertical hold =
knob),
> who would like to play retro games at 60 Hz in color.
>=20
> But on the other hand, I admit that this scenario is likely a stretch and=
 the
> number of people who would actually use it is probably close to the prove=
rbial
> two ;) So it's your call, I'm just leaving those settings here just in ca=
se.

This series is already pretty massive and is difficult to merge, so I'd
rather avoid to add new stuff in at every version. The changes look easy
enough to be a follow-up patch, so I'd prefer to do it that way.

Maxime

--ysfbxxbxsmqctfb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY1pyXgAKCRDj7w1vZxhR
xUhMAP0XpvpKwMyQUT0qv5zm8wU1Oj1FqnHhCXeuVVO8jcNQEQEA3oyfkhXsxwGB
0XwSRrhGDf0kHcwS9XXqBCQFEgMYgww=
=04yJ
-----END PGP SIGNATURE-----

--ysfbxxbxsmqctfb3--
