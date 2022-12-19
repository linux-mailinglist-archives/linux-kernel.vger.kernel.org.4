Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE4650824
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLSHlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiLSHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:41:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7E32AC1;
        Sun, 18 Dec 2022 23:41:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so12112540pjr.3;
        Sun, 18 Dec 2022 23:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQXRyu6a6hdNWFaFM+lIaXBcIgFQDwtpyt8WeRchEz4=;
        b=olsK2UwfYzqPUKl+35ZdgZ6KcfrBuV5sAMP3WI8UpF9uZK6k18enKS0+gIulldpCyZ
         ipmjptU7vA/K4c5Zs/leYH0BgIwqvdtlVSds0md4cvbU9bfmUluSawoDJ2uByg8Hapdk
         oY91fcTzc55YDFwKOMNXa69hvipHyBBI5tTzFBsvUr00tDcPYTii7fPvIBEwRFtZnyFC
         UycYxdZDfztAsyRNTrlsNbcGHV80QYf3KUbfgkd8B83KNPxM0jGFS9Zilwk0H8NDCtu7
         M+6hr69Qk8vrsfP7efc24PwO+G2ZDH20AgHeWcEonFljEkvDIh/M07EQlu8YvPKxvcS5
         +nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQXRyu6a6hdNWFaFM+lIaXBcIgFQDwtpyt8WeRchEz4=;
        b=aAFtX2QfOiQfTO1JKE02+1uxhxmddutU7Sm+DSyYNrlV4CZRvYCStMS1c9dxfGtuvX
         LUdl3vWBUHWZyanHXKXELuZMwOR9VfMu3zRIRnPgQ2HEXfSlrOjGOTGHOInvI95NDIRY
         0dAWP8OCHvRZYxVldOsfLCs+BjlFFIJ0ZXwrTsesBNvtcB4VwcY4pE1l215n1khAzsrM
         NyO38c1q/IFlUduaeIBO7utuErvv9PKnJcmQqOutssI9aU9dS9fFcZUmBa5wsrUduGfP
         lSVNVWEGMObH09QilyucAvvhU9597qjRzJIao506co6lRx+PZKVLv4rIJLtkf6UoAVLU
         syIA==
X-Gm-Message-State: AFqh2kpx7eZruOVsAf4yT8+jdxQvKrtd3f2XiDCIuW86ZYVSgYb9Jgih
        lplVdgdwoX6hVQFfWGSOOoU=
X-Google-Smtp-Source: AMrXdXsAppBd6D3nooYBF1q37PXxGHJtkZzfPuBA2JrINR+dGNUn3yybFLypkoghJJfnbkC8gzj4Kw==
X-Received: by 2002:a17:90b:2747:b0:223:7513:adfd with SMTP id qi7-20020a17090b274700b002237513adfdmr15238189pjb.3.1671435671812;
        Sun, 18 Dec 2022 23:41:11 -0800 (PST)
Received: from debian.me (subs02-180-214-232-26.three.co.id. [180.214.232.26])
        by smtp.gmail.com with ESMTPSA id a23-20020a656417000000b0046ae5cfc3d5sm1376812pgv.61.2022.12.18.23.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:41:11 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DC09A10016D; Mon, 19 Dec 2022 14:41:07 +0700 (WIB)
Date:   Mon, 19 Dec 2022 14:41:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Li zeming <zeming@nfschina.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v4l2-core: v4l2-h264: check after increasing memory
 allocation
Message-ID: <Y6AVkwh+V/PjzIfK@debian.me>
References: <20221219033712.3270-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pKLsL9cNsnMmaJug"
Content-Disposition: inline
In-Reply-To: <20221219033712.3270-1-zeming@nfschina.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pKLsL9cNsnMmaJug
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 11:37:12AM +0800, Li zeming wrote:
> The pointer *out_str adds judgment and should help with program robustnes=
s.
>=20

Terminology: if[-else] blocks are conditionals, not judgements.

> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-cor=
e/v4l2-h264.c
> index 72bd64f65198..934aba539332 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -305,6 +305,8 @@ static const char *format_ref_list_p(const struct v4l=
2_h264_reflist_builder *bui
>  	int n =3D 0, i;
> =20
>  	*out_str =3D kmalloc(tmp_str_size, GFP_KERNEL);
> +	if (!*out_str)
> +		return NULL;

Why did you add the check beside robustness?

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--pKLsL9cNsnMmaJug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6AViwAKCRD2uYlJVVFO
o/t0AQCwcopw+TXZljE09jvLgDqqoeetJNthp3jE/EGMTsGsPgD/cBHqoyPpfbBn
ULgc5x/oOTjP9V3QOu9umw36f75TIAM=
=wTM6
-----END PGP SIGNATURE-----

--pKLsL9cNsnMmaJug--
