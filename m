Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB65A69521B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjBMUne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjBMUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:43:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13FB11678;
        Mon, 13 Feb 2023 12:43:23 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6DE406602158;
        Mon, 13 Feb 2023 20:43:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676321002;
        bh=fDlbvUHgZ2o7uES7FSGsaM7fflx5SBe/1baNqJbzXLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mA34D1hLFpx3gKU0fsx3h7xQhpfOVWc4/JrsprdZonVfMECcKWb2/tiL0ZmhLLvkf
         ++OGhwNziqWB+KcrUji7lWphTuPQFLzDUK4gFC1a2TJBA3alKhmPt+3o1B/GDXwJWe
         xnpNIujksVk+mseiSp0q8S048eUnpvGypJ8EZA6Zpc3gIHo+lL45chbRaTJzzEgDqA
         teSiVH/8tALURYMEaq8+vvHhvr7oAe52k0YSRZ1lkJ6Bp5RBY8VjkL/ZuySPBtP0Is
         HzBxokxF45gUbfZL4WLGJBBVktBCBgB3oegt7/TIgybs/8eHgw/N35A+hUg3kpkY65
         BGPsiRUJVvsng==
Received: by mercury (Postfix, from userid 1000)
        id 4FA721060961; Mon, 13 Feb 2023 21:43:20 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:43:20 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     ChiaEn Wu <chiaen_wu@richtek.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: rt9467: Fix spelling mistake
 "attache" -> "attach"
Message-ID: <20230213204320.3izngcqy4gpnn4oa@mercury.elektranox.org>
References: <20230206091742.45977-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocofjycqlrsrefpq"
Content-Disposition: inline
In-Reply-To: <20230206091742.45977-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ocofjycqlrsrefpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 06, 2023 at 09:17:42AM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/rt9467-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply=
/rt9467-charger.c
> index 96ad0d7d3af4..73f744a3155d 100644
> --- a/drivers/power/supply/rt9467-charger.c
> +++ b/drivers/power/supply/rt9467-charger.c
> @@ -970,7 +970,7 @@ static irqreturn_t rt9467_usb_state_handler(int irq, =
void *priv)
> =20
>  	ret =3D rt9467_report_usb_state(data);
>  	if (ret) {
> -		dev_err(data->dev, "Failed to report attache type (%d)\n", ret);
> +		dev_err(data->dev, "Failed to report attach type (%d)\n", ret);
>  		return IRQ_NONE;
>  	}
> =20
> --=20
> 2.30.2
>=20

--ocofjycqlrsrefpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqoOcACgkQ2O7X88g7
+pq4jA/+NQHkObTrWjMPEHdEpsIdt1ZFwpRlDTYP+uHSbobnSFQERLCW/mSpY7HF
z1Pv2gZJ6jo5R6dDCjL6kJ+txtNb8LxBAt3IItAYkkgkbt5bC7d9ep822g3SGMQj
LRmIs3KW/pCXaHLtxnX+8Gp74PCKysflQX3Xh6IZ0DeaeAmqyNzkjzBFZexXY+0e
0ZfAvU2eLGg7VZHcmh3NAGwNeNR1q5VtBOO5OzH1IbbIrH41dLJFYHawqDOWb7KY
ASNeKZQxR/c/a2B+8DXPf+akBMpXtWBBF8wi+rBCRmzvQU0UaBgPfxTl46/wqio3
qV0oOkpC4gYWu6wQcwlSnWVcP0T672qrXtHSIdpftK4ts11GaegZGzNxB9a7Y7W3
NS6zxBFYhgGumjYl3ineHt2aZ3/tS48igK3j7kUKZzquFyLhA+G5Oeuem3XwHqWH
ZQm/RGyge8QbkY17G/UL/4+NbaBpSlVP7JCGbrEVINAVsH9k1WVxosIgAHdgB71X
MOvC+1Jh2Sr3br+077qRsp2a9PQnZFJN9YuTAflMeeyBqQIJgPnCVypn0WAMVTwR
bAPIyUQzCuSrMGQCbg8ITfDNut98RZpBqC/4gT/4dEckkAqIyblUqoIr0iJiqSU2
SHl8LnzC50h3IQfJDzNwF0nFEBlQ5UKIzayDn0uTtTq6wiGA6iw=
=SZKJ
-----END PGP SIGNATURE-----

--ocofjycqlrsrefpq--
