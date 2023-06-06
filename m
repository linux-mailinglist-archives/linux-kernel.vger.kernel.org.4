Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D04D7241D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjFFMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjFFMO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:14:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969D210C3;
        Tue,  6 Jun 2023 05:14:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so1669853b3a.1;
        Tue, 06 Jun 2023 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686053695; x=1688645695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZxsPxahs9NKr8hMwSFGfW9sJdI4zT80Uq7gZVXkfhQ=;
        b=VkyY/6GpsS0zZSqL8bdeycfxo8QJTbFqmuF9AhB0dniioo0238NhSkK0ERbNUEzscD
         vj9jAWdHhFDTm5eMyg63JM5F3Er89ow/LH4F2fCkb5mGbLQ14DIjD4ACM7ySWiKUxJmh
         Yy8RGCYzs1nd/0Y/HDP3aV+MaLhOjQqJVnGpfpv5MdTyGtoIOXpuQMTKEcbQgmB5N9Nj
         CDSoTZWFHgD0MYKlkStRhs+NukShEU1JTMCjgpFC5ZyZgE4wp3o94lMvci8lQrxeJZsd
         t/l4gOJu6wG7iTOgzDIOvE48js1NyWSEeTIK4drBzoVa6K099ulj7b3bb3ZpKciwqP/5
         iGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053695; x=1688645695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZxsPxahs9NKr8hMwSFGfW9sJdI4zT80Uq7gZVXkfhQ=;
        b=Tjv1+vLV2cn3TDfXFoNNGAEscK2m9tKZg7ADKyL2rz61AalneyJcmvlxXwGMzvsq+f
         kFf8x/A7nojj/SibQ40DMPUdzGLOlFZULrDKKwKfgAR+2gimRjzSKVFCdFj/NvMeQOqV
         a8Jt4BkyqdElfhWikSXOea4ojCyksmja/AXV8HP2KpbhAd+0Ul4veS4PzVyiAcuHXQts
         5aGad40xn06gtO9oJ2WYxxG2HzfhXv/IXUK78qKHUNvJE9H5H9k5e9Zaq8KE9d8npr9G
         Crcw7wZMkW4Ke0tYdDJTKr3qJE01Z+CMVR8jEOVVuJbC1j7H3RkJi73WktZ0dprfo5PA
         9Z4Q==
X-Gm-Message-State: AC+VfDy1R+8AHoTo9h2i3Rz0eTfsKVzEYAiXk9i2TKDj18mPhREB+Y3t
        B2GX6alRQaLRTFdPpofCru0=
X-Google-Smtp-Source: ACHHUZ6Q7Oq40/JLIFZzXaEegZg6sXRcaOL2YrC8ZQMtLRVCeYKJK5SqLyeTZ9FFNOwV13uTttxC7Q==
X-Received: by 2002:a05:6a00:a82:b0:647:e45f:1a4c with SMTP id b2-20020a056a000a8200b00647e45f1a4cmr522595pfl.11.1686053694900;
        Tue, 06 Jun 2023 05:14:54 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id x19-20020a056a00271300b0063d2cd02d69sm6773163pfv.54.2023.06.06.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:14:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5F0B2106A3A; Tue,  6 Jun 2023 19:14:51 +0700 (WIB)
Date:   Tue, 6 Jun 2023 19:14:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        James Morris <jmorris@intercode.com.au>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH] crypto: md4: Fix checkpatch issues
Message-ID: <ZH8jO0FO2QJ7eGBV@debian.me>
References: <20230606112610.98149-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ba/Z41R8rl9t+wTp"
Content-Disposition: inline
In-Reply-To: <20230606112610.98149-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ba/Z41R8rl9t+wTp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 01:26:10PM +0200, Franziska Naepelt wrote:
> The following checkpatch issues have been fixed:
> - WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> - ERROR: space required after that ',' (ctx:VxV)
> - ERROR: space prohibited after that open square bracket '['
> - WARNING: space prohibited between function name and open parenthesis '('
> - ERROR: code indent should use tabs where possible

Again, please split up into one patch per fixes, as a patch series.

>=20
> not fixed:
> - ERROR: space required after that ',' (ctx:VxV)
> in lines: 64, 65, 66 have not ben fixed due to readability

Can you clearly explain why do you skip #define ROUNDx macros?

> -/*=20
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
>   * Cryptographic API.
>   *
>   * MD4 Message Digest Algorithm (RFC1320).

What about removing the license boilerplate text below (and thus convert
to SPDX)? Personally, I prefer having a SPDX conversion series for crypto/
directory instead.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ba/Z41R8rl9t+wTp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZH8jOAAKCRD2uYlJVVFO
o00BAP9UG2AFI4DVm8DvY97Ml59CFiyeX1FPrNTc5SOzYbrMqAEAqS0rkoBnJn6o
NtT32bb8/U3dleJsqZ01PleqrLephwk=
=lzaw
-----END PGP SIGNATURE-----

--ba/Z41R8rl9t+wTp--
