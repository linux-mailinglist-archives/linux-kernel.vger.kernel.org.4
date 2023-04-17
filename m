Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5815B6E47D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDQMc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDQMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:32:57 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6797176A2;
        Mon, 17 Apr 2023 05:32:38 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3B0F91C0AAC; Mon, 17 Apr 2023 14:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681734757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1NeQx7djer6NRM3T3dun5t+CH8TGUfLxCoRrKQn84eo=;
        b=of6IjzfQDUSKXx93Gs7Km/iwE51OR7T8p4icXc7H9I9+H3iyuGwXgifwvJV5JV2/BcNcsv
        5F7UnH3WdPth0Ah3bDUUswjZpet37juEW75mY32vQOPaPrOORVW/PKRONyE6FIIoxCOAix
        nss/fZs5FI0FaG35f8ENLhVu2zWHUWw=
Date:   Mon, 17 Apr 2023 14:32:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <ZD08ZGY/iHGgKHhx@duo.ucw.cz>
References: <20230414055341.335456-1-andreas@kemnade.info>
 <20230414055341.335456-3-andreas@kemnade.info>
 <ZDlEsNZ3pTlfxkAz@duo.ucw.cz>
 <20230415000533.534ea99b@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TRwALHgnVOKfWzYO"
Content-Disposition: inline
In-Reply-To: <20230415000533.534ea99b@aktux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TRwALHgnVOKfWzYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +config LEDS_BD2606MVV
> > > +	tristate "LED driver for BD2606MVV"
> > > +	depends on LEDS_CLASS
> > > +	depends on I2C
> > > +	select REGMAP_I2C
> > > +	help
> > > +	  This option enables support for BD2606MVV LED driver chips
> > > +	  accessed via the I2C bus. It supports setting brightness, with
> > > +	  the limitiation that there are groups of two channels sharing
> > > +	  a brightness setting, but not the on/off setting.
> > > + =20
> >=20
> > This driver can be used as a module...

And I was pointing this out before...

BR,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--TRwALHgnVOKfWzYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZD08ZAAKCRAw5/Bqldv6
8q4YAJ4lZ+bORnRziYkwuTxQqFsFCwAm7QCfQ73x66AtHMYkvcsE1GGowEr7HTs=
=uF4Q
-----END PGP SIGNATURE-----

--TRwALHgnVOKfWzYO--
