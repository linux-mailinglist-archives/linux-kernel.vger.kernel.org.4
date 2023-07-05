Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E5748A17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjGER03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGER00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:26:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A2171A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:26:25 -0700 (PDT)
Received: from mercury (dyndsl-091-248-215-132.ewe-ip-backbone.de [91.248.215.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0EA5B6606FB0;
        Wed,  5 Jul 2023 18:26:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688577984;
        bh=FrjxF0tq2gTfYH4rLlBC/3ka72K8oEIodpxjy7bQsp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWbyDRVPvnE9wpAW8dDxKdMZ4F1jNvqntz5egr4KlycDmyBz21KYebYJnDGLV5pt+
         Ps2FDROdgfArh2W3GchSNpT/9qP7SP77C+qXpYGZc1QBS2XNnF7iWzVLQ0LZHo3FS7
         Ha9KUBPufoC3A9MdyL0HJV9dKa7viOo8GnreAUOR3o9WTtR2d1INPM/B6NslP6DxHc
         g84dXktQvYi/rF/yBMdoOfUUkJ8phIP8418TMfb465+NFQEpMBxpTGyqe2ANHvOwgS
         JjRbkx5QW2C741PoH5ubkDDh/FQLl0hDnZScduYemVN0xh/xon+J3t463gFf2RbmjE
         YJq3NNfs6H1Lg==
Received: by mercury (Postfix, from userid 1000)
        id C7594106146A; Wed,  5 Jul 2023 19:26:21 +0200 (CEST)
Date:   Wed, 5 Jul 2023 19:26:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lee Jones <lee@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rk808: Make MFD_RK8XX tristate
Message-ID: <20230705172621.iyg5tis5sfxekbqi@mercury.elektranox.org>
References: <d132363fc9228473e9e652b70a3761b94de32d70.1688475844.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2zwyd53z6ewu4ln"
Content-Disposition: inline
In-Reply-To: <d132363fc9228473e9e652b70a3761b94de32d70.1688475844.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2zwyd53z6ewu4ln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 04, 2023 at 03:07:48PM +0200, Geert Uytterhoeven wrote:
> There is no reason for MFD_RK8XX to be bool, all drivers that depend on
> it, or that select it, are tristate.
>=20
> Fixes: c20e8c5b1203af37 ("mfd: rk808: Split into core and i2c")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, LGTM.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6f5b259a6d6a0b9d..f6b519eaaa710e71 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1197,7 +1197,7 @@ config MFD_RC5T583
>  	  different functionality of the device.
> =20
>  config MFD_RK8XX
> -	bool
> +	tristate
>  	select MFD_CORE
> =20
>  config MFD_RK8XX_I2C
> --=20
> 2.34.1
>=20

--p2zwyd53z6ewu4ln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSlp6wACgkQ2O7X88g7
+pr0PQ/+MQYjyvQhRDIMkDMDbjd0Fawh/wLBAzyqgYng0sJHxKXqwVt+FBssz1v3
uRuhhhd0MX5PbcvGwzteWYYpcquKKJChoXsQmq3gzrtFA1X6620sk1nl+f/Mg9SP
t79BI49pbaShD7sOlR8dEK6mkGjDMNTUYm4hjiF1v6IvQ1ViQtMJfCrnAQklsnh5
ex2gy/0birMKKJd59UhV5pwPNZEun1+6iJ9pNONqK9eD3iwYEj5jEV66TRtdgpiC
dCDH9paiW0DUcOpRQPxn2APpDoHz8RYtVzHwfVpwuGfq+4L9pBQNJqrPqr1EfhAg
b6mYc8PCLsoB7hsg0BLKnrQPemNQapcQwDl1xT3/GMGUBPyoi/zC+8VwdJKiNdJu
8e74LfG93GaLLtdMJ+1K4Ruo+Xpe/0C/Q6uU9b2SZsD8dBtXDEt9nLyqDSVkdCYM
mzVZnA/+mc7neGwsgajp+9UXZmUIEqcPq+HKMinSKK6OmFuMAjp39NmqhR1xMYCW
tS70Xf/+FFmGkltXufKZha88w3nKDT8LUxhMOqJc8cK5tzusJGVEfehlUYWJskuP
E0s+ubp5S0r8De586V+Dd62sX7pqJ6FQmeLAVmHp3bhtcHjrHBN8Alfj9Yx1uxbV
RMhNs/cXvcrHyZ3qy20Sj/vOV03nCRGHq/9l1R2GBmkN0XPl9Ew=
=2/JM
-----END PGP SIGNATURE-----

--p2zwyd53z6ewu4ln--
