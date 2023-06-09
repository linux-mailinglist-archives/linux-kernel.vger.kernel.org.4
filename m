Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C335872A6CA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjFIXhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFIXhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:37:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6491BE4;
        Fri,  9 Jun 2023 16:37:04 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2272A6606E97;
        Sat, 10 Jun 2023 00:37:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686353823;
        bh=rerBhfdBx0PDQHgVWkdYCkE9CpCyDdB+5HtthB+KSHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcErX0+qWR1QbayaLj8+AIhbVe3zisI+Z9CVdl6aRiwxtA+R+92rDoeR6WwaeKB8x
         UizGJutbqXdZc66zsWK7/dKHElwvHvGYuUqG/eqgnhUQsAP0mUdBRqUREZL77IGhJ8
         Zfky/7l4ckHYZepkZGdWHv0tprMhT+SB0XU5JeC+dOsGhGW1Jkr3e9xZWk97ZJOUCF
         A5Z4T8wuXKwaAqJwNt3c7SHjMP5q3LscU8TpLKtn4c2PwdeH8t+MNcHtmbDxuUtnkV
         n1uT8QMxaUzlqrnqfmmI9K5ffxNpPMiFy0qSvwIS4VZFvnHG8lMJgKxSVuzHO5Ds4v
         CshkE0lEKQ/hA==
Received: by mercury (Postfix, from userid 1000)
        id BAA311061184; Sat, 10 Jun 2023 01:36:59 +0200 (CEST)
Date:   Sat, 10 Jun 2023 01:36:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH 2/2] power: reset: at91-reset: add sysfs interface to the
 power on reason
Message-ID: <20230609233659.tduea4ls5raaf76e@mercury.elektranox.org>
References: <20230609143912.849995-1-miquel.raynal@bootlin.com>
 <20230609143912.849995-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="go2oi2cf3km2tgoq"
Content-Disposition: inline
In-Reply-To: <20230609143912.849995-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--go2oi2cf3km2tgoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 09, 2023 at 04:39:12PM +0200, Miquel Raynal wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Introduce a list of generic reset sources and use them to export the
> power on reason through sysfs. Update the ABI documentation to describe
> this new interface.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [Miquel Raynal: Follow-up on Kamel's work, 4 years later]
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../testing/sysfs-platform-power-on-reason    | 10 +++++
>  drivers/power/reset/at91-reset.c              | 42 +++++++++++++------
>  include/linux/power/power_on_reason.h         | 19 +++++++++
>  3 files changed, 59 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-rea=
son
>  create mode 100644 include/linux/power/power_on_reason.h
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-power-on-reason b/D=
ocumentation/ABI/testing/sysfs-platform-power-on-reason
> new file mode 100644
> index 000000000000..12020d017543
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-power-on-reason
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/platform/.../power_on_reason
> +Date:		October 2019
> +KernelVersion:	5.4

That needs to be updated :)

> +Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> +Description:	This file shows system power on reason. Possible sources ar=
e:
> +		General system power-on, RTC wakeup, watchdog timeout, software
> +		reset, user pressed reset button, CPU clock failure, oscillator
> +		failure, low power mode exit, unknown.
> +
> +		The file is read only.

This should list the exact strings generated by the kernel. They are
ABI. Also it should be mentioned, that the list might be extended in
the future.

> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c

[...]

> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/=
power_on_reason.h
> new file mode 100644
> index 000000000000..4b92eb0519c4
> --- /dev/null
> +++ b/include/linux/power/power_on_reason.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
> + */
> +
> +#ifndef POWER_ON_REASON_H
> +#define POWER_ON_REASON_H
> +
> +#define POWER_ON_REASON_GENERAL "general"

What's the difference between "general" and "unknown"?

> +#define POWER_ON_REASON_RTC "RTC wakeup"
> +#define POWER_ON_REASON_WATCHDOG "watchdog timeout"
> +#define POWER_ON_REASON_SOFTWARE "software"

"software reset"

> +#define POWER_ON_REASON_USER "user"

user is quite confusing. This should be something like

#define POWER_ON_REASON_RST_BTN "reset button"

> +#define POWER_ON_REASON_CPU_FAIL "CPU clock failure"

POWER_ON_REASON_CPU_CLK_FAIL

> +#define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
> +#define POWER_ON_REASON_LOW_POWER "low power exit"

when is this reported?

> +#define POWER_ON_REASON_UNKNOWN "unknown"
> +
> +#endif /* POWER_ON_REASON_H */

Greetings,

-- Sebastian

--go2oi2cf3km2tgoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSDt5gACgkQ2O7X88g7
+poqyxAAglUk7rJHfWfLQ//weA/l1ReEJ7Nyf2ijitYaFFMyoFnmq/wZuQhWp7Eh
8IwUrrAY/LZIPFOar9uz0jXOYzTELwkoiAYwTFdRvSFW2tFnNfdHYzX1ftutE39E
XUZSytW70KbdJFKIJEd0A1gR+mKlSoRj8r6jPWHKeGHijBZaDIwpCXmQdRsjNmnc
N+ky3hSJHo8hCdpS4YlDE+FL2ghxYWWK6KjOzNsqUSElu6IYUdzzlmL+hawpXWwd
7GKb/Ie7MVzWkdID18NEztcdf3lNnbItr8exnIovCk3DeU5xMfAT1f9Z+tJtuxY9
7ksJkevf7hApgu97EZsa2Khb3eQ+QFb7BFJaDEJXf3iwFG+hUj5aa40O1KhI5AYn
liUbUqSbWshZ7tUf429msyNBWfHR+xYuBQXGHiNS2tI60/mjTE9HyuuDg488Dcjv
2WtraBKOoGbpHjYIfZXcaDlaCK0ktJD9i4hypUN7a9d/rMrZgKHHqju44FKqtUa8
RYKYIv5PC50m9eUU1cd3KWh3rhja/zD/gPl9V8D5OXLI1XiQ+TBiozeQZja9Kkow
Vw0BePJO88SQzzGqESlXZpYgzRl9BEwBg1k8fZCyNweslj11vptnQ1HSxhU3La/O
5hAcmf0NvH/64ZxuNjifNGm2sOpsuYYz41X2v+IxRrjZfm9u538=
=o6+/
-----END PGP SIGNATURE-----

--go2oi2cf3km2tgoq--
