Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67993656E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiL0T0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiL0TZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:25:39 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78017DF95;
        Tue, 27 Dec 2022 11:24:50 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 23C611C09DB; Tue, 27 Dec 2022 20:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1672169088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRdFPAZ2x1cj1DjHYXyX9E2GgRFTovoAriXBGfubkg4=;
        b=in1gHuA+v2uM45+1ROOvdmMWqmypiE2BXaMWhDraIlZkrgfEPm+f70T2b+4H7zfmp7ue/l
        dX7itYr2Eb91NBCDUFx/RwZ+tuqxNmvtJ3PY6ZcaUrYDV+Onn/JkYnuWGS8+2lvATgWqVr
        vih7/K529QrLrGV0wzzhM/PlBbHvcN8=
Date:   Tue, 27 Dec 2022 20:24:47 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     icenowy@aosc.xyz, martijn@brixit.nl, megous@megous.com,
        kernel list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, megi@xff.cz
Subject: Re: gc2145 camera driver (front camera on PinePhone)
Message-ID: <Y6tGfxrq/Mh1JoA9@duo.ucw.cz>
References: <20220822180531.GA27226@duo.ucw.cz>
 <20220908073634.GA1761437@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pRRYJmJLH5z0bIH6"
Content-Disposition: inline
In-Reply-To: <20220908073634.GA1761437@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pRRYJmJLH5z0bIH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> we are also using the GC2145 sensor but in a CSI based environment.
>=20
> We are in contact with GalaxyCore and following discussions we had with t=
hem
> and data they provided us with, we've made a driver for that, supporting =
for
> the time being 3 different resolutions via the CSI interface.
>=20
> The driver is available on the STMicroelectronics STM32 github [1].
>=20
> If you are ok with that, we could go further upstreaming it while testing=
/adding
> features necessary for the PinePhone.
>=20
> [1]
> https://github.com/STMicroelectronics/linux/blob/v5.15-stm32mp/drivers/me=
dia/i2c/gc2145.c

Ok, so it looks like I'm quite busy with other projects. If you have a
time, anything in the upstream is likely better than nothing at all.

But you may still want to take a look at my submission (which is
Megi's code), it seemed it had less magic numbers..

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--pRRYJmJLH5z0bIH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY6tGfwAKCRAw5/Bqldv6
8nfzAKCGsA99cekbMlkR+fZ7e7R59/rOqQCfXgXkW7SYeVTWXfUAWd0NNuLGRac=
=H+fL
-----END PGP SIGNATURE-----

--pRRYJmJLH5z0bIH6--
