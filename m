Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B76C7E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCXNHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCXNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:07:06 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72882213F;
        Fri, 24 Mar 2023 06:07:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7F0E41C0E0F; Fri, 24 Mar 2023 14:07:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679663222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewQDzGm+t2NXNO9AbFYlq1fjj1R033V1nKRDmhqg/as=;
        b=gr/5ouitw1mix4WCQYdxVyuJvoVtGD6GzE86tmnR0XYOuuhh0ITWxembhzlsxebIpdmIon
        pRPcTYXrDu2D0HeUz9jx6hcftc+BI/QYXqq/fj6PCgRLUgCxJkSdFaxK2ew+dsbay18JZr
        eFal8kNvIcChVroFJdoblMq0gyOFZsU=
Date:   Fri, 24 Mar 2023 14:07:02 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: max597x: Add support for max597x
Message-ID: <ZB2gdvgFR4ZTIegA@duo.ucw.cz>
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
 <20230323194550.1914725-2-Naresh.Solanki@9elements.com>
 <d6463018-ebdf-30b2-ce0e-f2b5198847f1@wanadoo.fr>
 <688423c6-ba98-002c-efe5-7b0997d6af73@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KvhWOlauSwJvaynd"
Content-Disposition: inline
In-Reply-To: <688423c6-ba98-002c-efe5-7b0997d6af73@9elements.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KvhWOlauSwJvaynd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +++ b/drivers/leds/Kconfig
> > > @@ -590,6 +590,17 @@ config LEDS_ADP5520
> > > =A0=A0=A0=A0=A0=A0=A0 To compile this driver as a module, choose M he=
re: the
> > > module will
> > > =A0=A0=A0=A0=A0=A0=A0 be called leds-adp5520.
> > > +config LEDS_MAX597X
> > > +=A0=A0=A0 tristate "LED Support for Maxim 597x"
> > > +=A0=A0=A0 depends on LEDS_CLASS
> > > +=A0=A0=A0 depends on MFD_MAX597X
> > > +=A0=A0=A0 help
> > > +=A0=A0=A0=A0=A0 This option enables support for the Maxim 597x smart=
 switch
> > > indication LEDs
> > > +=A0=A0=A0=A0=A0 via the I2C bus.
> > > +
> > > +=A0=A0=A0=A0=A0 To compile this driver as a module, choose M here: t=
he module will
> > > +=A0=A0=A0=A0=A0 be called max597x-led.
> >=20
> > leds-max597x?
> As per struct max597x_led_driver, driver name is max597x-led

Please test the modular build and double check the module name.

BR,
									Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--KvhWOlauSwJvaynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZB2gdgAKCRAw5/Bqldv6
8qT1AJ4rZ5oeqfJ7mfKo5Zr4u6ashkHcIACgiT8fhIHSmdSMSkC2LAzbtcm4VUI=
=wIV7
-----END PGP SIGNATURE-----

--KvhWOlauSwJvaynd--
