Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602656A6A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCAJys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCAJyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:54:44 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13338654;
        Wed,  1 Mar 2023 01:54:42 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 438FB1C0AAC; Wed,  1 Mar 2023 10:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1677664481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QKT6wb7BlXOwHMF9uI9nO6U2s8HyW2fE3pemJt622E=;
        b=YwvpDAeAVhxeKk+ow+MO8KpW0FsjCy/hzx6UW9ldrWgY6334ZkLBd1UY2PzeY3Z6Dxy8ac
        bJqj4BBhT2skKnCxa9JAJlh9I07LV8VX1uE3JlWYvoMOcCLJv+8dsQqKfaDXrBsH2ub9Mn
        MzrDedZTo+bQZxrpJkkWrXKiqLKIHzo=
Date:   Wed, 1 Mar 2023 10:54:41 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee@kernel.org>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/2] leds: add aw20xx driver
Message-ID: <Y/8g4QfOJhjc4WMb@amd.ucw.cz>
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
 <Y/5xBGFC3b9Chdtb@duo.ucw.cz>
 <Y/8TTRtoFMJhMWV1@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="goqUx+bIZeqxo/gA"
Content-Disposition: inline
In-Reply-To: <Y/8TTRtoFMJhMWV1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--goqUx+bIZeqxo/gA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +config LEDS_AW200XX
> > > +	tristate "LED support for Awinic AW20036/AW20054/AW20072"
> > > +	depends on LEDS_CLASS
> > > +	depends on I2C
> > > +	help
> > > +	  This option enables support for the AW20036/AW20054/AW20072 LED d=
river.
> > > +	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
> > > +	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> > > +	  3 pattern controllers for auto breathing or group dimming control.
> >=20
> > I'm afraid this should be handled as a display, not as an array of
> > individual LEDs.
>=20
> Just for my own information, where do we draw the line on this?

Not sure.

> Is 4x4 okay?  How about 6x6?

I'd say "As soon as it is 2-dimensional". Even 3x2 array is a display.

If the LEDs are independend, and it makes sense to display disk
activity on one and CPU activity on second... that's for LED
subsystem.

When userspace needs to know where are the LEDs spatially located, and
when you start putting synchronized animations over the LEDs... well,
then maybe that's a display.

6x9 is definitely a display. We won't put 1920x1080 phone display into
drivers/leds just because it is OLED...

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--goqUx+bIZeqxo/gA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/8g4QAKCRAw5/Bqldv6
8rn/AJwJKp+LFn7p0CTmoaCYrBHRmH9mcgCfRz4lkROBbFHq5QhMvcz1xOmoiDI=
=MGxO
-----END PGP SIGNATURE-----

--goqUx+bIZeqxo/gA--
