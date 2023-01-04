Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738AB65DAF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjADRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbjADRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:08:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E0113F5D;
        Wed,  4 Jan 2023 09:08:10 -0800 (PST)
Received: from mercury (dyndsl-085-016-198-046.ewe-ip-backbone.de [85.16.198.46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 859F26602C47;
        Wed,  4 Jan 2023 17:08:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672852088;
        bh=lmwv+XzzktDTWq1Kr388hqTnxr0aFQF0m/DEo/weZG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6p0FYd98aQNOvCOwOkBj0KQ2y+MuC3j586/RziM4EGREiImJxcNITnRkTEEb1VU8
         U/BOMe5fsuOzTZtpdc+PmPRuutkiagwP9hqaL5XUaOH6mLDjPp/dl123aZQQJ8rqte
         ZcFHTnZ7XgHZmS803G44RaaX+B+7yjzD3hmgtbTpPalCUWsKyROJOZMYXlwjnUZSKP
         +KuAFigrBD37qrUPsuzxuOmX87R46ez8IkANJFZbqC7PdtEXDJIiQZxbOmypaqbt0d
         NBuGrlvR6GIyKVYIDc9Zu/tztZ0PVDtraLf9o27UR2TrFKPew8dzt5p+G3GkigGwzP
         nsx29Qrycxj8w==
Received: by mercury (Postfix, from userid 1000)
        id 461411060772; Wed,  4 Jan 2023 18:08:06 +0100 (CET)
Date:   Wed, 4 Jan 2023 18:08:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>
Subject: Re: [RFC PATCH 19/25] kvx: power: scall poweroff driver
Message-ID: <20230104170806.jrb6qnoyk6buzvg5@mercury.elektranox.org>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-20-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uq66y7ogcsufp33e"
Content-Disposition: inline
In-Reply-To: <20230103164359.24347-20-ysionneau@kalray.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uq66y7ogcsufp33e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 03, 2023 at 05:43:53PM +0100, Yann Sionneau wrote:
> Add a driver to poweroff the Coolidge SoC
> when running under Qemu, ISS or when
> the debugger (jtag-runner) runs on PL0
> to catch the scall.

line length of 41 characters is quite short.

> CC: Sebastian Reichel <sre@kernel.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-pm@vger.kernel.org
> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
>  drivers/power/reset/kvx-scall-poweroff.c | 53 ++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 drivers/power/reset/kvx-scall-poweroff.c
>=20
> diff --git a/drivers/power/reset/kvx-scall-poweroff.c b/drivers/power/res=
et/kvx-scall-poweroff.c
> new file mode 100644
> index 000000000000..586d93fbcaed
> --- /dev/null
> +++ b/drivers/power/reset/kvx-scall-poweroff.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2017 - 2022 Kalray Inc.
> + * Author(s): Clement Leger
> + */
> +
> +#include <linux/pm.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define SCALL_NUM_EXIT	"0xfff"
> +
> +static void kvx_scall_poweroff(void)
> +{
> +	register int status asm("r0") =3D 0;
> +
> +	asm volatile ("scall " SCALL_NUM_EXIT "\n\t;;"
> +		      : /* out */
> +		      : "r"(status));
> +
> +	unreachable();
> +}
> +
> +static int kvx_scall_poweroff_probe(struct platform_device *pdev)
> +{
> +	pm_power_off =3D kvx_scall_poweroff;
> +
> +	return 0;
> +}

Please use devm_register_power_off_handler().

-- Sebastian

> +static int kvx_scall_poweroff_remove(struct platform_device *pdev)
> +{
> +	if (pm_power_off =3D=3D kvx_scall_poweroff)
> +		pm_power_off =3D NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id kvx_scall_poweroff_of_match[] =3D {
> +	{ .compatible =3D "kalray,kvx-scall-poweroff" },
> +	{}
> +};
> +
> +static struct platform_driver kvx_scall_poweroff_driver =3D {
> +	.probe =3D kvx_scall_poweroff_probe,
> +	.remove =3D kvx_scall_poweroff_remove,
> +	.driver =3D {
> +		.name =3D "kvx-scall-poweroff",
> +		.of_match_table =3D kvx_scall_poweroff_of_match,
> +	},
> +};
> +module_platform_driver(kvx_scall_poweroff_driver);
> --=20
> 2.37.2
>=20
>=20
>=20
>=20
>=20

--uq66y7ogcsufp33e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmO1smUACgkQ2O7X88g7
+pqgzg//d3Xremg6XYAx7LO05CGbscipl+LZlHCgESkUNjRgsh+B4wkHwa/YFK9v
3CRp+z8Xdl+hpiFyNlWOjhbWW+gKz6LMDkIcnRyXXvp8kH2CXrNQBKiIzNNnnGot
nOHtd8tmvuUhpvKYmQq5ZIfdAPFkRP4MX6/SbGIP89fUtz8d4remh1yeFeOh8jFB
3oN2yi/HnY1xKue0WH0PUGCg+fSHbfXXF9jyb52CUkQ20LwE6FzTYTe6GGgFfPYc
tk2DFMnt8JqoId2aVWzpjkoHab1fQKb0qPR2KLfbH/9DAbo6/P2ZFe20tQMe3YaC
wbiPaM1W18kqb3QhRTwUddo3XPRO57UxelJt37h3h+l0O1BYTFIwnFYg31aODFCW
j9lUKAh/+kepNmcha4FXgnLtFzUiQt7zH1kDdnrKBc0LT+cxfsklEE8fRV+IRgSl
tOFHBtAPQUq20NlnSlavVMUD8zgOSlZXiR/fEt993BtRrk/DtgWeOCMIPR5FlN9I
yjRAjXfEMsw5pZJOLBqgGiNwIi5eZGE24BRv2GTuRnQF0LU4YL3uGNAHJEDpb0zR
EjuMgMzOwSb4k49DZ5uymqD5T2PZ7Xh+A+/olncZAGDkeq4B6k+gDCFaPQtHfvrv
LwGQusmHZciEHpfg4Q9f87iCi/z13VUVelaKWTTXl6hgrOHlzn8=
=GMph
-----END PGP SIGNATURE-----

--uq66y7ogcsufp33e--
