Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571376A6132
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjB1VYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1VYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:24:23 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290412A980;
        Tue, 28 Feb 2023 13:24:22 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E4CA61C0AAC; Tue, 28 Feb 2023 22:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1677619460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pWD6ZeYFIYvH//e/pkgpvZfcQJ4lYjf96QUJgDvmhps=;
        b=daFj2yjRjjN0yLclTCBUQNcmiJZt21YagP4wAcxFmvVo2A1DRrU4GSEpby3qcyRRqwfADD
        jJX8QRMl+Hk00Oqocle09H5NJhT32shiKXTy8URvS2tvMo9Qp//WQWAIBXH+2YWhU4l0wy
        tny4uGvNGt+v50ynjW8uBDX+yK1Y2+Q=
Date:   Tue, 28 Feb 2023 22:24:20 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] leds: add aw20xx driver
Message-ID: <Y/5xBGFC3b9Chdtb@duo.ucw.cz>
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yqFx/tuBXH7Ed1K6"
Content-Disposition: inline
In-Reply-To: <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yqFx/tuBXH7Ed1K6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +config LEDS_AW200XX
> +	tristate "LED support for Awinic AW20036/AW20054/AW20072"
> +	depends on LEDS_CLASS
> +	depends on I2C
> +	help
> +	  This option enables support for the AW20036/AW20054/AW20072 LED drive=
r.
> +	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
> +	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> +	  3 pattern controllers for auto breathing or group dimming control.

I'm afraid this should be handled as a display, not as an array of
individual LEDs.

Plus RGB LEDs should certainly be handled using multicolor class.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--yqFx/tuBXH7Ed1K6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/5xBAAKCRAw5/Bqldv6
8iusAJ4g4J6T5/z1iCQn6XszVGyaUKNAoQCfWq34vmWBIrFEnY60KQT+gSLncwA=
=pvVt
-----END PGP SIGNATURE-----

--yqFx/tuBXH7Ed1K6--
