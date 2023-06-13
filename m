Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84E72EAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjFMSQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjFMSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5731AA;
        Tue, 13 Jun 2023 11:16:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011D3633B7;
        Tue, 13 Jun 2023 18:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B2FC433D9;
        Tue, 13 Jun 2023 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686680173;
        bh=3nta5h6vskHXP6e963+cgsjeVqvnWSz8FUDMtyHszeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZdjtdg681LkZlBV7iFB/NhtWhAMuqITDTNRQi77W2BPa6bg1tPBeFiTxFyWlF46E
         wIYEd39GRCYxSweANY3G68LRRkBPwubGORUWW+zj6gPTQDvbICIQ7kmyegmFZFwY3J
         fCBU/ty9NQsoVYzjmUzQi0UYgSFWIxdPE5j6FXl+QIhiXWN8zBhdEKlx2hylIsImJr
         cudRsJ79SvaB3b68gUreZXFcQarSbC5Xuv9YP4sre8xT/9WdwBBPNlhc6RNDelpzvm
         jgAOU1yOL9739iL2AM2FcsbL9+TmZ8j2eL9/uO09p8Gdfae7VJ+CXjduDK9/wu9xwz
         xnI9W7uvUA9Qw==
Date:   Tue, 13 Jun 2023 19:16:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Manikandan Muralidharan <manikandan.m@microchip.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, sam@ravnborg.org,
        bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH 5/9] drm: atmel-hlcdc: add compatible string check for
 XLCDC and HLCDC
Message-ID: <20230613-unvocal-employed-aff3cf92d60a@spud>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-6-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nLQwW+t8SA8oYufo"
Content-Disposition: inline
In-Reply-To: <20230613070426.467389-6-manikandan.m@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nLQwW+t8SA8oYufo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 12:34:22PM +0530, Manikandan Muralidharan wrote:
> From: Durai Manickam KR <durai.manickamkr@microchip.com>
>=20
> Add compatible string check to differentiate XLCDC and HLCDC code
> within the atmel-hlcdc driver files.
>=20
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 7 +++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 1 +
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_dc.c
> index d7ad828e9e8c..fbbd2592efc7 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -761,6 +761,13 @@ static int atmel_hlcdc_dc_load(struct drm_device *de=
v)
>  	if (!dc)
>  		return -ENOMEM;
> =20
> +	/* SAM9X7 supports XLCDC */
> +	if (!strcmp(match->compatible, "microchip,sam9x7-xlcdc"))
> +		dc->is_xlcdc =3D true;
> +	else
> +		/* Other SoC's that supports HLCDC IP */

Should this be "Other SoCs that do not support HLCDC IP"?

> +		dc->is_xlcdc =3D false;
> +
>  	dc->desc =3D match->data;
>  	dc->hlcdc =3D dev_get_drvdata(dev->dev->parent);
>  	dev->dev_private =3D dc;
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_dc.h
> index aed1742b3665..804e4d476f2b 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -451,6 +451,7 @@ struct atmel_hlcdc_dc {
>  		u32 imr;
>  		struct drm_atomic_state *state;
>  	} suspend;
> +	bool is_xlcdc;
>  };
> =20
>  extern struct atmel_hlcdc_formats atmel_hlcdc_plane_rgb_formats;
> --=20
> 2.25.1
>=20

--nLQwW+t8SA8oYufo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIiyZgAKCRB4tDGHoIJi
0uODAP9H+hIVPJhxyu0rBvxNfNf8xPG/zVLhpX+gT6U3ob1cmAEAlAT79psmRyV5
QEhTZmaMUl3xGZF/7M2oLmN1ke+UlwE=
=MOtr
-----END PGP SIGNATURE-----

--nLQwW+t8SA8oYufo--
