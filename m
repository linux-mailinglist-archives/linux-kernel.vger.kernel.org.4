Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A46BE1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCQHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjCQHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:33:49 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8839168A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:33:40 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CF54A1C0E45; Fri, 17 Mar 2023 08:33:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679038418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/USnkD21tOk/mNzvc6EzgZMBGT4MDY9VGR86oLWqmE=;
        b=hzeCKbtqHLgDBeN9zC/AdieGsJ1GHTqo8frsZMbNBEkMW8DtoMw24WWyYebGi1+pHoYpxs
        WvZXcoPu5q43o0Bl5FXV2U7AU6QnTy85j5qvVAMdzQKuxohFimT9E5W2hI1NifyyWrj16B
        hW4TL3UPPiYX4lZyw6JLUdHzyoZyp9g=
Date:   Fri, 17 Mar 2023 08:33:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     1000001101000 <systemalerts@jeremypeper.com>
Cc:     linux-kernel@vger.kernel.org, arnd@kernel.org,
        "Jeremy J . Peper" <jeremy@jeremypeper.com>
Subject: Re: [PATCH 1/3] set the correct driver for the i2c RTC
Message-ID: <ZBQX0i1QB11mXhQ8@duo.ucw.cz>
References: <20230316234009.2115005-1-user@earth>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pCJ/V5672q2ALyz1"
Content-Disposition: inline
In-Reply-To: <20230316234009.2115005-1-user@earth>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pCJ/V5672q2ALyz1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2023-03-16 18:40:07, 1000001101000 wrote:
> From: Jeremy J. Peper <jeremy@jeremypeper.com>

You probably should use this as a "From:" in the email, and need to
sign-off the patches.

Best regards,
								Pavel

> ---
>  arch/arm/mach-mv78xx0/buffalo-wxl-setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv=
78xx0/buffalo-wxl-setup.c
> index 383dc6eab..c3f6dc351 100644
> --- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> +++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> @@ -39,7 +39,7 @@ static struct mv_sata_platform_data db78x00_sata_data =
=3D {
>  };
> =20
>  static struct i2c_board_info __initdata db78x00_i2c_rtc =3D {
> -	I2C_BOARD_INFO("ds1338", 0x68),
> +	I2C_BOARD_INFO("rs5c372a", 0x32),
>  };
> =20
> =20

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--pCJ/V5672q2ALyz1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZBQX0gAKCRAw5/Bqldv6
8jL1AKC2ddpKiDNGmrGproStlPxJWf7BOwCfYVIwLZQM7mDmCOyCTxPIc6QP3U4=
=n1fP
-----END PGP SIGNATURE-----

--pCJ/V5672q2ALyz1--
