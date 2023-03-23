Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A46C661E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCWLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCWLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:06:33 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA32DE63;
        Thu, 23 Mar 2023 04:06:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 336311C0E45; Thu, 23 Mar 2023 12:06:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679569588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHWvB2BCrhNpAxUENSUrqYP89+RL/RBUZ+NXm8frba8=;
        b=CI3SgRLIYP4QJzssz6eJ0C4AV++fiYbDZC+7RtL4sed/LIeaP8rO8ao3fuSkUxSEod93bl
        WkIuNBZAOeL6YLS7aZ5Ej4/ApvOJOD7WC74YbyZwdXTJbhlqFlshoHWf3stuGGiKxKOsxq
        Mtp3Wtgln32v7JmdkNKu5rptqFhWfaA=
Date:   Thu, 23 Mar 2023 12:06:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: mt6370: correct config name to select in
 LEDS_MT6370_RGB
Message-ID: <ZBwys8kLg7NLOk+K@duo.ucw.cz>
References: <20230323105410.10396-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KU4ZDhGjr3zhG3Ut"
Content-Disposition: inline
In-Reply-To: <20230323105410.10396-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KU4ZDhGjr3zhG3Ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Commit 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink
> type LED Indicator support") introduces the config LEDS_MT6370_RGB, which
> selects the non-existing config LINEAR_RANGE. As the driver includes
> linux/linear_range.h, it is a safe guess that the config actually intends
> to select LINEAR_RANGES, which provides the library implementation for the
> function prototypes defined in the linear_range header file.
>=20
> Correct this naming confusion in the LEDS_MT6370_RGB config
> definition.

Looks good.

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
								Pavel

> +++ b/drivers/leds/rgb/Kconfig
> @@ -29,7 +29,7 @@ config LEDS_QCOM_LPG
>  config LEDS_MT6370_RGB
>  	tristate "LED Support for MediaTek MT6370 PMIC"
>  	depends on MFD_MT6370
> -	select LINEAR_RANGE
> +	select LINEAR_RANGES
>  	help
>  	  Say Y here to enable support for MT6370_RGB LED device.
>  	  In MT6370, there are four channel current-sink LED drivers that

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--KU4ZDhGjr3zhG3Ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBwyswAKCRAw5/Bqldv6
8p70AJ4wG0X7vNDkIlEkRZpej3qqEwtKRwCfeojFwxU3iZ9i2lM6bi5RIKSSfrc=
=+rk9
-----END PGP SIGNATURE-----

--KU4ZDhGjr3zhG3Ut--
