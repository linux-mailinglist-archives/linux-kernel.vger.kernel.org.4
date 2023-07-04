Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE3374665D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGDAI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGDAI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:08:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB818C;
        Mon,  3 Jul 2023 17:08:25 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 206486606F8B;
        Tue,  4 Jul 2023 01:08:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688429304;
        bh=4JJwPVhJWceI5BnfKOE1UA/iozYb0TFlvK3DvXPQdv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXlvX5z8i01tDprqMzJ9pazJglUVgXhfbgVgJNqju0KuvNFVx7KmEl3iDRF16Oe0m
         Zmal4jYRHUqiI8CS9QA571sxdn140uc6Ft6BWeHLGAmUahLz2yVd5cn0E+r3BXv1s6
         PaQmy5SvbnfxtJPKV7fMW4bjyYXUfK6tzRuz/vLKaUwd+ouPkZPQ/DokIP2qbGYA6c
         DVGIM/b6OBpr+kc/jFgIbGXX2ncqgTROAvBNHiat8YQ2Gty8kM/EHHc7Tocbcr5RHB
         fmvQYfzmcQeZdLOjzpoYAGHevCxDsvcSP/wWISx5H7Rn8uhQe84JhCqDAcjxf7keSa
         OKLtkuJtwtfrA==
Received: by mercury (Postfix, from userid 1000)
        id EE77A1061814; Tue,  4 Jul 2023 02:08:21 +0200 (CEST)
Date:   Tue, 4 Jul 2023 02:08:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] input: cpcap-pwrbutton: remove initial kernel-doc
 notation
Message-ID: <20230704000821.z3tx4chw7x6pn6nq@mercury.elektranox.org>
References: <20230703230005.14877-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjpcjgpcgqhqdsir"
Content-Disposition: inline
In-Reply-To: <20230703230005.14877-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjpcjgpcgqhqdsir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 03, 2023 at 04:00:05PM -0700, Randy Dunlap wrote:
> Change the beginning "/**" in the file to "/*" since it is not a
> kernel-doc comment. This prevents a kernel-doc warning:
>=20
> drivers/input/misc/cpcap-pwrbutton.c:2: warning: This comment starts with=
 '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kerne=
l-doc.rst
>  * CPCAP Power Button Input Driver
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/input/misc/cpcap-pwrbutton.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff -- a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap=
-pwrbutton.c
> --- a/drivers/input/misc/cpcap-pwrbutton.c
> +++ b/drivers/input/misc/cpcap-pwrbutton.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * CPCAP Power Button Input Driver
>   *
>   * Copyright (C) 2017 Sebastian Reichel <sre@kernel.org>

--kjpcjgpcgqhqdsir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSjYvIACgkQ2O7X88g7
+poRKg//ftyAjaih1EVZqXdpDbCI7iqT7gTIuIhCQ8ji2rdcmYT2mPW5n5qtEu2C
4O8FkwsHTqpmzelbK1l3AlyUeHwPBjzUGRmZq8RiRGNudGvU1z41qzDRDKQhnftM
3MyKLvWLiGUEQeGla9LDBrCgXz38Y6kUU+NJ3grJySzwCSNubNMGgdwSXXZqOqvQ
RQKZp5hF8rjuCpsmKdoCVoWLlUfgh3oKfER1Zc8tH+YMFVvkoSs3AsgfTFtQf7I/
krz5ARlUICpO0B2EnN86DMkNcRZYXkpIbMEMIVfC2eRFyeOpETg6UvILQLkgkFka
6dZ8TGE1TuJARzl5xMYJgoZkmsuoeU6PH8vAknczFc5Xkkb/RewyATg9x2n5PW1V
xN/ep247lzEA+ow75Gf7Izj8FlO8NXaU3S79gKx+k7yRA4D5ywQpmNfNAecelZLY
pdxIsYvZOTexAbLd4h3vKLyVXrp+RSzj9scQaXWXekp1L211ATDebaR6Dsa9Hi3i
/I5GYkPExvHTrDY1NQQ5quDLSl5MCu1J2byb2PRZU47LMapKYOiYKzuY6u3EMizR
rkItnSR4EJYnPiu95qeo9UvAa34pmKlgXov7qJUEDQ0s/lsklD5w716cNG61s1JZ
D0uGCzxeFlgkRvusWCbYd5ZP8XkGGoT97n8El101RtTFM10fqf4=
=NANQ
-----END PGP SIGNATURE-----

--kjpcjgpcgqhqdsir--
