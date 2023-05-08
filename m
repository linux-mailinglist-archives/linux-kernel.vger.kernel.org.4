Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62DF6FB54D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjEHQh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjEHQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0B96E9A;
        Mon,  8 May 2023 09:37:35 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 773B5660563B;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=vcmfL6fa26+uv3p8sjY6y3BGVWfx6diz9FJorLd91Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N69ZAaKWBmsLvDqXuNkVnTsY6dpRIw2R70zrj5+H7T5ZI+pxE3yP+OnYDGF5/TXGP
         53xFA8MR0ArfnMxh9+XCbdZDFUoKnLG9V4R2bZ/kSLeEC5k/J6ZvzzyUyEHjXLv47p
         d739UGLhQBpD/imjD1ZcBk4fvduiaD0iSWHuAqE0/Lzh7eHVchP7Nnj2IObvUveg49
         6TgjQOAVt2FbAT+jtRFAwk7mewb7hmrA3MD+YuyebeiY8zwIORQc1Uf2t3pOv6ahzc
         HztJbjR3mu0i6bRGmkxJKtnZ6KvZEdbBBf6QJEIzDgkXkdJSCo11ATgGP45FKQTP/G
         eAv7Csm8Qk7Yw==
Received: by mercury (Postfix, from userid 1000)
        id CE5011067062; Mon,  8 May 2023 14:43:59 +0200 (CEST)
Date:   Mon, 8 May 2023 14:43:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: rk817: Simplify an error message
Message-ID: <20230508124359.hl7kwixxforqexnl@mercury.elektranox.org>
References: <a9c0820c5af6b315ef3b3c2fd8d7be44008b0086.1681577370.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lq2ocncfggcksedr"
Content-Disposition: inline
In-Reply-To: <a9c0820c5af6b315ef3b3c2fd8d7be44008b0086.1681577370.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lq2ocncfggcksedr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 15, 2023 at 06:49:55PM +0200, Christophe JAILLET wrote:
> dev_err_probe() already display the error code. There is no need to
> duplicate it explicitly in the error message.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 1a2143641e66..8328bcea1a29 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1134,7 +1134,7 @@ static int rk817_charger_probe(struct platform_devi=
ce *pdev)
>  					    &bat_info);
>  	if (ret) {
>  		return dev_err_probe(dev, ret,
> -				     "Unable to get battery info: %d\n", ret);
> +				     "Unable to get battery info\n");
>  	}
> =20
>  	if ((bat_info->charge_full_design_uah <=3D 0) ||
> --=20
> 2.34.1
>=20

--lq2ocncfggcksedr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY7o8ACgkQ2O7X88g7
+prG9hAAmn4pxl5HZ4OqQt18Tgu7ZNPcNtFpreppljXLJ6rPXcfSUk4mz9SlYhG4
s+ck3MZY+gGfYRQD03zzymgsmTs6kmx6Tt+G3g3wb/QhjRfn3ltJfJWdP3DAJGyC
XzQ7bfX3d4q+m8GQlLDBJgvjHrOCzsGOkI8iixEr+909kSkPYcfszQ9dBWfd/qj6
DMedjPrTOAsjKyAnbSqmnSCBw8lERFwjRZrdI5S7ii3eCmMuOhe01FkDaVRPlfX/
s845/VzJyhHTxTcoYx6V6jY6FgKqsXzMJn5HUYm0QdkVAI3pHDUhHapZz7+yDQg5
xRLOUvzhbHX6si5QHTiIFhaxvZW7QdILfuMOj/30PHITb0aanmZc9mNEctKGwdX8
ywOd4eGfrTBaF1HPGQXb+29h0JHSQ0znMMC/eCs2R3rDphu3rK7Zkx27poSUMw6C
V5A5PAy9plyvmOSXyR2PiQhYvVw/XXeU9OIlsi4w7pWIA7bnZuI+HNKz9KaEuqIT
LQWZivk7aMBHQjzoy5e1qnLRdubvsyEuQt469G2vci7J6gFUpc2ucaAUDMk/0aDQ
ARtbyZiU4+qyZbhawrCetQy0x2gBQ0eDxDNfuAnvAAbe2j/5L2bF1HMD51t5izYX
/jGyVpq5yfZ1lHx0BeStBJWOBPeVeQjBomCpveTPPYzq5RQtC9k=
=TBBs
-----END PGP SIGNATURE-----

--lq2ocncfggcksedr--
