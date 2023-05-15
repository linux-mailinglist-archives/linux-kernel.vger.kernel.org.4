Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC4A70411B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjEOWtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjEOWtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:49:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73FD2EB;
        Mon, 15 May 2023 15:49:40 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B75E66031CE;
        Mon, 15 May 2023 23:49:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684190979;
        bh=cUOBGtMqBnVICL8/rpjyNFDo++WGvSZAvBD6cIIiFlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjiCURQP1mfWIQDOB/fRLYu4w7+Ua4kBADtbxrD8tIByakm+d+7t+2s6DKZwtgt6z
         tVUlIK63NOU0iBt7hidcy91ZlbotjS4zw/DouMOlX9fvH0/ZTpnSE4H4hF3hYFKln/
         iyrvNJSol6ZogyZwG7tFQZVfpIfyJ23fawEuj9djT+Bh91/sf0XivBXGL5eNeEVzfl
         InEjaNSkZkT1L5zJjiDRXlZN1Dr5igPvNdipiLnQwAaOq8x81iSaGoigZyUGkCbU8Z
         zQU1q2f4VlNwzDabf5njUPDGtDcDOIXqfS+zYDyGwOSFCWdam5d+vVU4hhca/aJooU
         UZJUqQbP/dltg==
Received: by mercury (Postfix, from userid 1000)
        id A09FF1060F7F; Tue, 16 May 2023 00:49:36 +0200 (CEST)
Date:   Tue, 16 May 2023 00:49:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     void0red <void0red@gmail.com>
Cc:     angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] power: supply: mt6360: add a check of
 devm_work_autocancel in mt6360_charger_probe
Message-ID: <20230515224936.kbb275kre6ulasmm@mercury.elektranox.org>
References: <20230227031410.893593-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5qewv2dhagmv6xn"
Content-Disposition: inline
In-Reply-To: <20230227031410.893593-1-void0red@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5qewv2dhagmv6xn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 27, 2023 at 11:14:10AM +0800, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
>=20
> devm_work_autocancel may fails, add a check and return early.
>=20
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---

Thanks, queued to my fixes branch with Fixes tag added.

-- Sebastian

>  drivers/power/supply/mt6360_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply=
/mt6360_charger.c
> index 92e48e3a4..1305cba61 100644
> --- a/drivers/power/supply/mt6360_charger.c
> +++ b/drivers/power/supply/mt6360_charger.c
> @@ -796,7 +796,9 @@ static int mt6360_charger_probe(struct platform_devic=
e *pdev)
>  	mci->vinovp =3D 6500000;
>  	mutex_init(&mci->chgdet_lock);
>  	platform_set_drvdata(pdev, mci);
> -	devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
> +	ret =3D devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrd=
et_work);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
> =20
>  	ret =3D device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt"=
, &mci->vinovp);
>  	if (ret)
> --=20
> 2.34.1
>=20

--e5qewv2dhagmv6xn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRitwAACgkQ2O7X88g7
+pr/GQ//R5PP1j4DGfjnPOhBcBq5rCmy5rRw4mYwN8f7ldkAFNm327FtA1IBvGQk
q4doC1b1DPb2INU0HfNmd2f5bw69hJQBLdYaZLnALELcvKhg1Rx+R/s+9Vx/wDP1
+8I5EO61l9kzzw5CR8iPo3pIYC8VS5qoW8O8D2KF75L5pKYYgsvtAL1EbrpARR7X
xS2BATKDf8o+cnyX6+/uNyhm7Kwv2HJfmVH1/SqOxMxcW/VQPkf8dcJDwSCfodga
CQgS9Ex4Mnj5Tf0STRYBseHgH/bxdzueS3G0zlXsuBPo02ADfi/5b2WnNmzNgke3
Q5eRnCFIwaKTjI8x7TBYD1jcNc1x799/c26fUSb8qS1vQpDvw+g3P26yf+JjR5+R
GMwrp7pTsWjeoq8B2T0vnp9HEmk7q1Axwn2fZYQg+CCROnn692JiUGvTjgSWZPay
euw+yZXVje5JdCtOBQABHYb53xCUwMudzHyO4GbT3B5Iy0bkhJNhHAMp2mkozXFi
vMRwwAbTplG9mRYT7GLXQxrhxMN6yjWTfQq1sBQ19SqDowA6tShuTd8/kwP54xG1
DIC7bafpGgxU7acFPftdnZb8ifVIm6opZHdEXecqK9FQH49k/XDmc6LTOPaKhoDU
vLLCTvT3o55DDxYzL8t0psZxZR0psAtMQXyIMoMpcs0zDMbTLj8=
=uuij
-----END PGP SIGNATURE-----

--e5qewv2dhagmv6xn--
