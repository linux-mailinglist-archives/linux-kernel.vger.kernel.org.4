Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8951C69890C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 01:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBPAGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 19:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:06:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F41244B4;
        Wed, 15 Feb 2023 16:06:05 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E80C1660206C;
        Thu, 16 Feb 2023 00:06:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676505964;
        bh=KEfpZq7IdD+eaPUgdu9g3gUwaWmdEspQ5sy9QxFoAlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UguVS4qENdalJFN5bZ1Mf9T6pVUwznfFp0KJGxPeuRQY2peo6F04LgbwelRB0WkAW
         pYbVYHXcmX5Zn67WJCvw0aOIEaVQ7BNqHg5wQvrzGdDEbC0jqt+D6jX2TUITbia9Mj
         1AGJIABlr2s89n8RigXQ6DXwxWT9of7G4MiDrYXQQMLMG0S8/+d62ts+xBQkDJ9vNv
         pe5tXQTXwXaSk83zl7Rx8mNm8AmnsghTvc98KHhd6AT3Yte9mxsxBU4LluOALlkYzy
         ZA1/9tREJ3s4fpONoYIxvAAFJBXe9thPZyF+kt3AUkWlSqu55i8mjJWiRgKB3Lqesl
         dDsFSL0TG+mhQ==
Received: by mercury (Postfix, from userid 1000)
        id 80FB710603FE; Thu, 16 Feb 2023 01:06:01 +0100 (CET)
Date:   Thu, 16 Feb 2023 01:06:01 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: leds: explicitly include linux/leds.h
Message-ID: <20230216000601.u76o7mow7m3pgre5@mercury.elektranox.org>
References: <20230215-power_supply-leds-pm-v1-1-fa79f846b04d@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="si27b542cyafcae4"
Content-Disposition: inline
In-Reply-To: <20230215-power_supply-leds-pm-v1-1-fa79f846b04d@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--si27b542cyafcae4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 15, 2023 at 01:12:55AM +0000, Thomas Wei=DFschuh wrote:
> Instead of relying on an accidental, transitive inclusion of linux/leds.h
> use it directly.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_leds.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/sup=
ply/power_supply_leds.c
> index d69880cc3593..702bf83f6e6d 100644
> --- a/drivers/power/supply/power_supply_leds.c
> +++ b/drivers/power/supply/power_supply_leds.c
> @@ -13,6 +13,7 @@
>  #include <linux/device.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> +#include <linux/leds.h>
> =20
>  #include "power_supply.h"
> =20
>=20
> ---
> base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
> change-id: 20230215-power_supply-leds-pm-b32236dfb4df
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--si27b542cyafcae4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPtc2kACgkQ2O7X88g7
+ppdBQ/+Kj6TGSUe+3AwCMitfCkF3/9gR2RjR5JksfG+aUKEETR2GbN4mwqIDpe/
VoYLN06D0ZL35Few7VK/KHFiIYxbXWM4sNFlzaQNJ5Nlt0DejlnxwTN0myzkkTsX
CTgTPD7wtBGRwA5bDw05cdNijWzCwROKhRHr5OjM2XMF51xGlhSWZFXFCYdKSZfw
v1NqYyfOwMmgc541T8v5C5ey093ih3Z36sDq1eZK4Ykpa/JXk+bIytekWsBPgYMP
sRRfrNCHNKqThQYOVMprHV+mcGm3Gn4uSqVT/HuHj5te0Zeo5jGKGddaRWxImvkd
TTb8wb8wmbF7Qy/qnbbpHlzBdB1WKHK/wYqPRKi0cxzwmREyAcHWfBbSsBvvfCF6
1fTnJnxUvjYL6Hxox6+WQrfzmlgPxxbsErhotehBgHl32buPFhc1c/2s9MX+Pl41
II87AnF1VblXTZCG0+QuYHkeclArpjN7eQVZnRXL/kDaia1FvaaF4OT9insJOqtl
70v9iUs1ItwLeI7Znb3SOT4f2nw36taT5/dCRqU60gp6kelO/Lk5mPwJdio2OLCP
8o1HmwdDC+qQzlLBE7tHTPO6X2QsyYam99xl2mhotNvRTlwhOutaOS8WsGqTfQNb
2b9W29vzFRaG2nIIj9OU6MApgVlmLJIpyXUQ0cyz26IQ7GG7kdM=
=YYe4
-----END PGP SIGNATURE-----

--si27b542cyafcae4--
