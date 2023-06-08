Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3974E72787E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjFHHPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjFHHPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:15:36 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE219A4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:15:34 -0700 (PDT)
X-GND-Sasl: paul.kocialkowski@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686208533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1SM5qbVIiWN2i+E93Rs6pUO8P+WpXB4KlSYCZZICVY=;
        b=hiFnkWcMBREhi4rzWYlIx8VS0ZhTqTon6B+Noi/zM+uHZ7cDtj+O0K8AB3JJxvJ26Z8uTN
        4bcU8LgJzSgZAHWIsqODXe1na5oEEf2lOepgpbgZM0m8LbAKvkqcGmuVAJ94gQVLVXSFbG
        59/Th9CIbh3F+9NzfeNCKlk5tdqReXe/7eUlWG5iXeKlkB0Zq4fKoW9Su14syXMFdeH4cf
        bswq4vk8zlPJlw4kFmPx9VO2DmF5giUm4eJGRnhfqbtcjDn0B59PD9lo31iQJoEuD0x0ti
        ULo1/S2WZY6ruuYKJqHXuZlxjE2Q+bqkRC8uJK02tbhVFXMt7p0FSeGIQzcu8g==
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-GND-Sasl: paul.kocialkowski@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17678240013;
        Thu,  8 Jun 2023 07:15:30 +0000 (UTC)
Date:   Thu, 8 Jun 2023 09:15:29 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO
Message-ID: <ZIGAEZTJvq1GqFVD@aptenodytes>
References: <20230608024207.581401-1-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ukkutT5+Jm73cGF3"
Content-Disposition: inline
In-Reply-To: <20230608024207.581401-1-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ukkutT5+Jm73cGF3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 08 Jun 23, 10:42, Sui Jingfeng wrote:
> drm/logicvc driver is depend on REGMAP and REGMAP_MMIO, should select this
> two kconfig option, otherwise the driver failed to compile on platform
> without REGMAP_MMIO selected:
>=20
> ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/gpu/drm/logicvc/lo=
gicvc-drm.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:136: Module.symvers] Error 1
> make: *** [Makefile:1978: modpost] Error 2
>=20
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Thanks for the fix, looks good to me!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/gpu/drm/logicvc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kc=
onfig
> index fa7a88368809..1df22a852a23 100644
> --- a/drivers/gpu/drm/logicvc/Kconfig
> +++ b/drivers/gpu/drm/logicvc/Kconfig
> @@ -5,5 +5,7 @@ config DRM_LOGICVC
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_DMA_HELPER
>  	select DRM_GEM_DMA_HELPER
> +	select REGMAP
> +	select REGMAP_MMIO
>  	help
>  	  DRM display driver for the logiCVC programmable logic block from Xylon
> --=20
> 2.25.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--ukkutT5+Jm73cGF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmSBgBEACgkQ3cLmz3+f
v9F1bwf9H0Dd8yQTcM8xZG7Jj89ztiiVUgzIOqIcgvhUGaWzdPj0sNgMZ6tF9Od3
w9YuXfJ/wsR5SqUKo04fPM7hOSX7wrelEUewmv1ZHPtoChGRNFhJ2Bi/KaIaUHNM
jODo6rf7qbDHqTdleg5SJxTAnqSLZQhG20a1sw70pFJTsX6F6bAnG1AaXItSBcAr
2RL43t13UY2MVb4ntFb0YtKho0hPtfsFBLzZsjZfHC4Gv0ZO24eE0TaWWcrQFY7s
n+nYJ+U/ja6/UByiM60gH33zB6OLXfkI8B0TssJ7iVZnqTqsgyLS2rIgA6Nz+9Vt
QYre3y/v+7t4W/GKGMqg5g18vy3akQ==
=M1u4
-----END PGP SIGNATURE-----

--ukkutT5+Jm73cGF3--
