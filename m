Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE5640347
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiLBJZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiLBJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:25:35 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E361E3;
        Fri,  2 Dec 2022 01:25:33 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DD5671C09FE; Fri,  2 Dec 2022 10:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669973131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eN/M3VFir9/Er0HKbCX2QJULPmPCZJVKZYJsRXCiqME=;
        b=NbJ8si1POoI7gqgOEk8vRyw/czdZeW5eTXG85BmKdpehvzsa4ALHEYFyEG52a76CnsD89/
        FXq9KTikHGopROX+4Nl5B+9vHq8gM0fRc2V0MO859uLwJ2R3VH/HexTI5e95CJ4Qu9wKlL
        32Jyftnr8j2ucovOmqj1/ArUiHpKRB8=
Date:   Fri, 2 Dec 2022 10:25:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Message-ID: <Y4nEi1Q1iEYFdkht@duo.ucw.cz>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz>
 <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
 <20221130191905.GA2631320-robh@kernel.org>
 <Y4eufPCzKbfp9k3z@duo.ucw.cz>
 <CAL_JsqK6+Yyn29QNV2tjUM-zm9WbuW57Jb=LKmqCLXHmvEoJYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ll8oqkCr+kIaxupW"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK6+Yyn29QNV2tjUM-zm9WbuW57Jb=LKmqCLXHmvEoJYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ll8oqkCr+kIaxupW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > So far, the documentation states that "label" is deprecated, and us=
ers
> > > > should replace it with "function" and "color".
> > >
> > > 'function' is what activity/operation the LED is associated with. It =
is
> > > a fixed set of strings which s/w may use. It is a replacement for
> > > 'linux,default-trigger'.
> > >
> > > 'label' is what is printed next to the LED for a human to read. 'labe=
l'
> > > can be anything and the OS shouldn't care what it is.
> >
> > Unfortunately, no.
>=20
> That's why I said 'shouldn't care', not 'doesn't care'.
>=20
> 'label' is also not just an LED property. It's used elsewhere, but
> unfortunately the LED subsystem makes more use of it than it perhaps
> should.
>=20
> > We use label as a path in /sys/class/leds.
>=20
> Yes, or node name if no label. That's still not really caring what the
> value of label is. At least the kernel doesn't. A well behaved
> userspace wouldn't either and doesn't for most classes.

A well behaved userspace needs that to tell what kind of LED it is. It
is important to tell keyboard backlight from HDD activity LED and from
fllash on back camera for example.

> > And it looks like integer
> > "function" is not really adequate for describing what LED does. There
> > are too many LEDs and not enough integers, and it is common to have
> > same function ("activity") on multiple devices ("wifi", "mmc", "eth").
>=20
> Whatever the problems are, 'label' is not the solution.
>=20
> There is a way to associate leds with devices. 'trigger-source'
> IIRC.

Neither is trigger-source a solution.

Can we have linux,sysfs-path or something?

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ll8oqkCr+kIaxupW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY4nEiwAKCRAw5/Bqldv6
8sLHAJ9mdtKAHeFl8I9YQNzZ0x7r/prTjACgnKZpSbkzl0S7r9tqGBdV4pisN7k=
=tVtK
-----END PGP SIGNATURE-----

--ll8oqkCr+kIaxupW--
