Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52246E0A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjDMJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjDMJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:37:13 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2DA9029;
        Thu, 13 Apr 2023 02:37:12 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DC35E1C0AB2; Thu, 13 Apr 2023 11:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681378630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wrW6YGw8zbV9hu3HkqEIo4AIU6igjIAt3TgYcW6MwI=;
        b=a8IIaAFL4FqtpWf6HBY2PxrERchI+NaIFKt20D9iP7ZjXhFcy5S+4trQTkqsMW9tJwn8lk
        cHVLYR2eZXFvrsgof+dq+Gz7m7F2IRf/0fnUeRQULozJszHWfHsLjp0RgCngEwlHHYAoGj
        h/Hf0q7pP/stqUI/8MkkTs3bIMihvbg=
Date:   Thu, 13 Apr 2023 11:37:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        phone-devel@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: Re: Motorola Droid 4 -- Stopping charger when battery is full
Message-ID: <ZDfNRogC4ruBE4Xy@duo.ucw.cz>
References: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
 <ef4409b2-abd8-0eac-f66e-6858c3358cc1@gmail.com>
 <20230309071443.GF7501@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CsuhVVL0901ty7WX"
Content-Disposition: inline
In-Reply-To: <20230309071443.GF7501@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CsuhVVL0901ty7WX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [230307 14:10]:
> > Also, some guys have concerns about charging (and keeping it charged) @=
4.35,
> > because of the possibly reduced battery life.
>=20
> Yes for devices connected to a charger for long periods the battery will
> bloat up within some weeks or months. This happens easily when using a
> lapdock for example.
>=20
> A simple and safe solution here might be that we allow charging up to
> 4.35V only once when the charger is connected. Then we let the voltage
> decrease to 4.2V (or whatever known good maintenance voltage) if the
> charger stays connected.

Optimum solution would be user specifying "I want battery full
tommorow at 8am" and doing the right thing.

> For folks wanting to force the charge voltage higher we have the sysfs
> interface.

Yep, we just need to make sure it is usable for this.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--CsuhVVL0901ty7WX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfNRgAKCRAw5/Bqldv6
8rHTAJ47T4HAPVY9l4k4nX7luvp4XtaSZQCguz3x4BEbsKm8f0ZDhRxxbHDDKXk=
=vAab
-----END PGP SIGNATURE-----

--CsuhVVL0901ty7WX--
