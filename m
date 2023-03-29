Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367C66CF3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC2T4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjC2T4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:56:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE0EE4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:56:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CF0D032002F9;
        Wed, 29 Mar 2023 15:56:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Mar 2023 15:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680119801; x=1680206201; bh=no
        XiJIPie8dV9ePTw+SFQsO0YQNm2CoaSAiwIsdQxWY=; b=dhX/CDGktLBJ59bws1
        SBd5MyUrWvJrFsBrVeAcOAIIOON8qZVFvlHWEupXGQ+QK9V6Shv8v1V06GUfSHbE
        REpoPWc4hpwXLYnOM2yBzg9XThL5e88JOKvyn9WDy86EkjsFXTKAtgocml/wELkK
        M8CbixMKVxgLW7vA+szzycquz6Kd6FuLzewgt+ej30+TL+hFaL4VAPztbJo44ELG
        hIrT8HCkNG+x+Ui+TalipT8H89pKukX3868zIlyVPPlm4MsNSEkpRC09R6iNAgsO
        kp9sbQfeWynd1hRnKNj77/HENaBHF1jwvncRUVngGBVjNo7YsbyZ4gzqPcXyKA6A
        Mkzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680119801; x=1680206201; bh=noXiJIPie8dV9
        ePTw+SFQsO0YQNm2CoaSAiwIsdQxWY=; b=VQflJgiYK2fuZdRhXHweK9JeB6Anm
        hA0vcz6up+MNKNHhh68F2kQF+/4NhFDnxiT7y6it/PctSKFwI66OC47kTVL+rts/
        978f/qKQdDK6xpgdhHhnZGB58lQ4ZBX3c/tGi0chGgBCgUlc1xW+jA9xiKvDOkVX
        wcXVZksgXC/665tWjAew2SBt9V8u70RWHWUyyCItLvNpSGiMiI1uOWyVihpZ8j03
        V1JWWsVcfBajs9O5xkKyRYURQLMkGTTgcwVGDeiFy4zOwNK7gtYYRxGq81mO1svf
        NI8SuXlIQXLDdEs/Sr5WSgkMI32fDtPDZhW44t6UtdTZJ6Kk1JzNkWvrw==
X-ME-Sender: <xms:-JckZPreUsTnw_QVHZp9gOewnoEeXGFrxnq2phyZsqeqRLyDFM_S5g>
    <xme:-JckZJqoC64_TFJePBjgzeQRZLoNywmyZGH23AGYEOuqLwAj7dZJK7Z9ydmeVayO9
    KIybdJYquTloxwXTZg>
X-ME-Received: <xmr:-JckZMN9yYVwFdC7NRsKsRT60YIjpGzXiAs_vY_60xNnrEcyocQ0dmkAqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheeh
    fffhvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-ZckZC4qb0zUDG1CSROAhpnm2N3QaW8m1t0xrzdddB8wR2-9obZXow>
    <xmx:-ZckZO4N5m00Z91caxn0OYmPuT_6dB_ThYi-0ir03NVvoYSuDRMSgQ>
    <xmx:-ZckZKhexjf47-Je1pfiLB-1ojxCMMHMCzj8j71uRrzLWgYjwgpmhA>
    <xmx:-ZckZHEye8DGUgO1iIYeMyQAfxVhnS_47QNV9vn28e-gTwXw1Urzmw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Mar 2023 15:56:40 -0400 (EDT)
Date:   Wed, 29 Mar 2023 21:56:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Roman Beranek <romanberanek@icloud.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from
 TCON0_DCLK_REG
Message-ID: <20230329195639.iep4rv5rcigu3gj2@penduick>
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <87wn356ni4.fsf@oltmanns.dev>
 <20230327202045.ceeqqwjug4ktxtsf@penduick>
 <87bkkc3bzc.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w77waeuhy2kubgq3"
Content-Disposition: inline
In-Reply-To: <87bkkc3bzc.fsf@oltmanns.dev>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w77waeuhy2kubgq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 28, 2023 at 09:28:19PM +0200, Frank Oltmanns wrote:
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -819,6 +819,34 @@ static void sun6i_dsi_encoder_disable(struct drm_enc=
oder *encoder)
>  	regulator_disable(dsi->regulator);
>  }
>=20
> +static bool sun6i_dsi_encoder_mode_fixup(
> +				   struct drm_encoder *encoder,
> +				   const struct drm_display_mode *mode,
> +				   struct drm_display_mode *adjusted_mode)

So, mode_fixup is kind of deprecated in favour of atomic_check

> +{
> +	if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_DSI) {
> +		/*
> +		 * For DSI the PLL rate has to respect the bits per pixel and
> +		 * number of lanes.
> +		 *
> +		 * According to the BSP code:
> +		 * PLL rate =3D DOTCLOCK * bpp / lanes
> +		 *
> +		 * Therefore, the clock has to be adjusted in order to set the
> +		 * correct PLL rate when actually setting the clock.
> +		 */
> +		struct sun6i_dsi *dsi =3D encoder_to_sun6i_dsi(encoder);
> +		struct mipi_dsi_device *device =3D dsi->device;
> +		u8 bpp =3D mipi_dsi_pixel_format_to_bpp(device->format);
> +		u8 lanes =3D device->lanes;
> +
> +		adjusted_mode->crtc_clock =3D mode->crtc_clock
> +				 * bpp / (lanes * SUN6I_DSI_TCON_DIV);

And that's visible to the userspace, so it's not where we should store
that value. I guess the best way to do something similar would be to
store it into crtc_state, and then reuse it there. But it starts to make
a lot of rather complicated code compared to your previous patch.

Maxime

--w77waeuhy2kubgq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZCSX9wAKCRDj7w1vZxhR
xaruAQCGPe9DdXyqjNQS1/luLCBVHVNEYdtb1P+8H83LWTX0FgEAswrnvVcJtuq+
lBULl/xcVsrxuFzib6ShMcSpHy9u6AM=
=LAf9
-----END PGP SIGNATURE-----

--w77waeuhy2kubgq3--
