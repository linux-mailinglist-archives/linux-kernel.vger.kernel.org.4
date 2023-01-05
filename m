Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43F65E896
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjAEKD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjAEKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:03:04 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD3E1573B;
        Thu,  5 Jan 2023 02:02:19 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2EF42E000E;
        Thu,  5 Jan 2023 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672912937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZFL3qyTfHdN27paTVk6oqvr7A5Y7FRlExyKi8NGY5A=;
        b=o4lTnWDk/szT4G1LfYqkSGS/fTFhsasemGRIT4uKl+cIl4ndNTOnOPODlQma6sxBn/SJdb
        08+0rToEL+FASQlNczHSf/1WUG4hz1DtEu1/DU8vNgmtk0j5WnhFdrDWpsV8huqsTBk0yj
        npDIoEJCvzLHraUFlV4XvQCDsYlPVStQSiRFFF+4M+DF9w6rdTjjVHFSR89IwCoKn6rf6F
        t5MiJ5qpno8DJMczerKiyshDJ1lcuwEWPhxtGQREq5kdu5s0hShD3qicJ9CwhNAfRkZHP3
        zE0pbq8+87tEUeKEmscQ5nfAPD1HNcLYZ88iZFFp5HT/egQnJgo8z/7T+viUYw==
Date:   Thu, 5 Jan 2023 11:02:12 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] media: cedrus: Make SRAM section claiming optional
Message-ID: <Y7agJBFqcvqyLNhK@aptenodytes>
References: <20221231164628.19688-1-samuel@sholland.org>
 <20221231164628.19688-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8/6s3dcqSbgka7v/"
Content-Disposition: inline
In-Reply-To: <20221231164628.19688-4-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8/6s3dcqSbgka7v/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Sat 31 Dec 22, 10:46, Samuel Holland wrote:
> The video engine in the D1 family of SoCs does not have a switchable
> SRAM section. Allow the driver to probe even when the SRAM section
> reference is missing.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Looks good, I've also just checked that calling sunxi_sram_release with no
reference to the SRAM held is fine (maybe a word about it in the commit log
would be nice, but probably not worth making a v2 just for that).

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>=20
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index fa86a658fdc6..11e859617932 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -257,7 +257,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  	}
> =20
>  	ret =3D sunxi_sram_claim(dev->dev);
> -	if (ret) {
> +	if (ret && ret !=3D -ENOENT) {
>  		dev_err(dev->dev, "Failed to claim SRAM\n");
> =20
>  		goto err_mem;
> --=20
> 2.37.4
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--8/6s3dcqSbgka7v/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmO2oCQACgkQ3cLmz3+f
v9GdzQf7BBo2ZY1agypl/4WFck7Oxw+wz2H294juvEYfBbZWII+esDVDHiBUiZaw
+iQVeT7ZGMum5E0Mvg+oaLduGhB271eZKHNY/YnEM3NHlwwUvy9TUJhR0iuKrX1H
rLf4NGQrmXAfBVnrnlW2ROIC3kz9DcRwC/busmLyMk025CMM54AlmY0Y8XaiMThq
ic6BTgL9b8a17lwg5G66A9OMNB8ee4WCfssFQ7kriVmFH644tTgtrFS8azGBCsI1
cxA7JGvZJWuJEm9L8PDMDvOm3IAC0djIgJ9gqkbJdCaJqW9H5c6iJBoFOJID6g2l
1SmqmlYcNehm79PXDFiAc9Xpq+Brfw==
=2Hd+
-----END PGP SIGNATURE-----

--8/6s3dcqSbgka7v/--
