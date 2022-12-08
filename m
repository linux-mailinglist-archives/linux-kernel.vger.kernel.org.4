Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6146470BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLHNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLHNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:23:53 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1667BC03;
        Thu,  8 Dec 2022 05:23:52 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 54AD940009;
        Thu,  8 Dec 2022 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670505830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwHKoO8RqRbDHdIh2HtTogVbNLJEMKgbOzQRa4vVfEs=;
        b=nNUc44NhtNWbajrgohS0Wr1SuTlTglT8HMVq3BzGid2zwj0CvsgeOQumPg5mg5p3vIjCnA
        1VGsB8MCBP92oOkR5g+zmn9SDbrQTmqdy3Om5V+F+lwHOmwbQt579wQ+2BmwUTWSXknOOi
        DMziAb4f+TNmhq8sl6oQKC8qDfNsipyfFWHrUQJ2Xp560rltCw0K9O09bI5Bi5ckRIuiw1
        3oey8x8CcXC13BLVarWiObxmSGycKv6FjHGWT7y+BzaAJRnAbdDmAFgeAAtIAq3EQ8+Pbz
        SZjTaF5BHYOcJPXqvSpyjZzqyrNjaAlgX7VSps9Wcf8t8vqKqPFy4JfEDGPWfQ==
Date:   Thu, 8 Dec 2022 14:23:47 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mchehab@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] staging: media: Remove surplus dev_err() when
 using platform_get_irq()
Message-ID: <Y5HlY1tuqLBJqFHE@aptenodytes>
References: <20221129012923.111691-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w5lRKAfW1cxqulwg"
Content-Disposition: inline
In-Reply-To: <20221129012923.111691-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5lRKAfW1cxqulwg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 29 Nov 22, 09:29, Yang Li wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
>=20
> ./drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c:390:2-9: line 390 is =
redundant because platform_get_irq() already prints an error
>=20
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3274
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for the fix!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Paul

> ---
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c b/drivers/=
staging/media/sunxi/sun6i-isp/sun6i_isp.c
> index 7b7947509b69..a6e813ff413a 100644
> --- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> +++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> @@ -387,7 +387,6 @@ static int sun6i_isp_resources_setup(struct sun6i_isp=
_device *isp_dev,
> =20
>  	irq =3D platform_get_irq(platform_dev, 0);
>  	if (irq < 0) {
> -		dev_err(dev, "failed to get interrupt\n");
>  		ret =3D -ENXIO;
>  		goto error_clock_rate_exclusive;
>  	}
> --=20
> 2.20.1.7.g153144c
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--w5lRKAfW1cxqulwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmOR5WMACgkQ3cLmz3+f
v9F+ggf7BckTVRt4YCzD1uAr6kDTr02r2Kh/3bjNcb6r3rS445PTOHRAS+kkwfmM
YYQE1dl/B+2Un8M2P0n4SAsKQ5CEZz0PDgFgEJxZ4D3J1aFatXu09Kest58JaBHF
MbsyHyLZwOtTUlfSH2/Kx28BGGOXigPG1YuKfGI75ClBKqWtpVzF7cBKEyH1T/vL
ISVKdqs/HWjXwTB2pJgsB5NjqThMiZqI90YB0Vhjlz+RUWSDVdJIpGxCo2vKTs9Y
9kYWyoIKnUqFcx3A3d4Iid4kRNlBw3Qy69Rt3GKgUVKrTW2yj5nnsww7AcFl4USR
Qg6BoOQiFC8QLQh08ntAUf5AAet9Sg==
=rMsZ
-----END PGP SIGNATURE-----

--w5lRKAfW1cxqulwg--
