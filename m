Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAABD5F8B4D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJIMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJIMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:42:47 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D4D2E681;
        Sun,  9 Oct 2022 05:42:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so8272570pgb.13;
        Sun, 09 Oct 2022 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OLqkk8/7TR7bcVpCw07PeB/AEHPG8uMPNz4yLkdUC0=;
        b=D5Ct5XYeRJf8KqSlA79lx6ZoBHRS87zyEcdDZEzSz6LhBBNmx694oQfENUfLSJKK9r
         rcGMHDbYfQpYnp0jaEicsbtv2ynsNhuyC/w778dGgfAAqFGEsC7ib2ORma0mew+1FvEm
         ZlXUwsiLqVgeUCF54cvnl1IUkqqWi42wCWyc0OMxuO8WGx6vl/XnZRYiJop5C9Ltez9S
         /HhCHRWjRj/IgEIjDtdeOW0p48AZp9/3xLfBzS8kOjllu6Gdo803OUVI9URo/Vo6bQx0
         TIRsOLIf94KAaFjcjaxSvaZRUWoHE8le1QLQYtntJPFBjyufrtuvQm8vf17rrZzSx4N6
         jsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OLqkk8/7TR7bcVpCw07PeB/AEHPG8uMPNz4yLkdUC0=;
        b=sBcAdTKsvJVNSNzUQN02sMLFn/E0/X/5vEkkVj+TNQIO+mlWCpgDyTK+gPUCmUcuUv
         UhrErIyxSGAVTX0phwbu3RkVuQ+U/HLHrGpCQdlqJYTBQJCLRcM8AHVjQWOP8RdLBRhK
         Jz/VznYm2nDJXMZEeNskhRkeylNp88ZVa6LHrIZcLrl0TjCHsrd7BtnZxn0M0uEBI3OI
         d254u+uR++TE22wom9OC5fVyoG6/WV35p3DEU9CZUA3ty6BetWOqDI9Tn9aoWRT7PjwR
         C9ggzNmlR1pEe0exUWJEA90EDsNz1N/gFmcXDYUzC755An8M2IRlzi4Ubql7x6ckVkeO
         VKnw==
X-Gm-Message-State: ACrzQf0jEPhAyUXnowVWS1xpr+TiUDUT9ioZWSAaviJylzW8Rn4zp3YK
        7hkxK763XuotEs+YJFu0ko8=
X-Google-Smtp-Source: AMsMyM73OUboZjqeQR6HfjGWD4U6YNPZ3ecayau6gTg4ME2ViEYnV3zK8tJSYWjIa0MnHdRyKNfQDQ==
X-Received: by 2002:a63:6909:0:b0:41c:9f4f:a63c with SMTP id e9-20020a636909000000b0041c9f4fa63cmr12958871pgc.76.1665319365996;
        Sun, 09 Oct 2022 05:42:45 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902a40200b001750792f20asm4643851plq.238.2022.10.09.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 05:42:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E15061039BF; Sun,  9 Oct 2022 19:42:41 +0700 (WIB)
Date:   Sun, 9 Oct 2022 19:42:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        giovanni.cabiddu@intel.com, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] crypto: qat - fix spelling typo in comment
Message-ID: <Y0LBwe4/K2hnchRC@debian.me>
References: <20221009091519.3152948-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FF6OHtQv1OVujNNT"
Content-Disposition: inline
In-Reply-To: <20221009091519.3152948-1-13667453960@163.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FF6OHtQv1OVujNNT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 09, 2022 at 05:15:19PM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>=20
> Fix spelling typo in comment.
>=20

What comment are you referring? I have to see the actual diff below.

Anyways, for similar typofixes patches, you need to describe what words
you are correcting and where you do the fix.

Also, if you send the patch from a different address than From: line
in the patch, you need to have Signed-off-by for the sender address.

> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/crypto/qat/qat_common/adf_transport_access_macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/qat/qat_common/adf_transport_access_macros.h =
b/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
> index 3b6b0267bbec..d3667dbd9826 100644
> --- a/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
> +++ b/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
> @@ -37,7 +37,7 @@
>  #define ADF_SIZE_TO_RING_SIZE_IN_BYTES(SIZE) ((1 << (SIZE - 1)) << 7)
>  #define ADF_RING_SIZE_IN_BYTES_TO_SIZE(SIZE) ((1 << (SIZE - 1)) >> 7)
> =20
> -/* Minimum ring bufer size for memory allocation */
> +/* Minimum ring buffer size for memory allocation */
>  #define ADF_RING_SIZE_BYTES_MIN(SIZE) \
>  	((SIZE < ADF_SIZE_TO_RING_SIZE_IN_BYTES(ADF_RING_SIZE_4K)) ? \
>  		ADF_SIZE_TO_RING_SIZE_IN_BYTES(ADF_RING_SIZE_4K) : SIZE)
=20
Oh, you refer to comment for ADF_RING_SIZE_BYTES_MIN() macro.
The patch does s/bufer/buffer/.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FF6OHtQv1OVujNNT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0LBuwAKCRD2uYlJVVFO
o3aFAP9y3fTmuQN/W+GzjlLzAAHPgHIU2nnTRWW2oB5BrrZWhAD+OIqszJ8iFlg7
GEHhezJNyBZOyYJCVvFXL9yOr3uWRwY=
=MU34
-----END PGP SIGNATURE-----

--FF6OHtQv1OVujNNT--
