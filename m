Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC946690B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjAMIYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240957AbjAMIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:22:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F1D36318;
        Fri, 13 Jan 2023 00:21:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso26330092pjt.0;
        Fri, 13 Jan 2023 00:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S8uxZaw+263Bn0UMT6QDLzZFaa+PGnK5wQK0PuqYfRc=;
        b=oEav7ZlFN4KG9ykOjglGPhsoNmPA/Ric1ZR8uGiUtyoVjimuPO4SQhbclRX8W1Yuzy
         NUF2/5CmnOEsm7W5sXtlxKZfdie51kwmxPPu277L+MHLAzRyua/k7I7syffi4JxkMvEw
         98KLvT80GS/39ozAog1tCaos875S5wStgpyWgLoXnKErfm+vxLFq2N2Rd/ley0GBl4ve
         eKIKOusRegIbiev7P9YMeDJj3NryM1mZww1nYbHe2IRPFaE/NTmTUxbngw/8Lj/7RnE6
         PQEAOcR40rSeO9ZSVMKd8jIPpBy1VwPvmH/bcqTLSqrd94DlxiyrrYNKSjGbbT5Z12pP
         li/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8uxZaw+263Bn0UMT6QDLzZFaa+PGnK5wQK0PuqYfRc=;
        b=G/v38VsbnvpRzPwy5dYfMJiQkFnaD8A9Y3dogzYzYT7k/THaihk83Hrcmd8s7XCeD6
         0b4JkS/cEBbO1jUEHVDQD5cOduphvE18aoEJRwxgpe6IOxrbAm5v+oZC0A5i4Q1w3i/K
         fiugL/dvjjtuqvHrAs2Ny2pnXcT8hOrTbwLYwemecenru6Q0RU4ntA5Eh2qvZ55NQ7d5
         T9hGWBxF70qsnMBrpYHa4SSP3V71wd1iEoYDiZuaCB0NE2rww+3T9e85umiuPjDc5xiO
         ZHlUE8uWH5kxmjPGNnsXFUkSN0WgIvh1rrTVq51M11rKEfb3CO4lwpN/n3PewbQ2PTIe
         tIjg==
X-Gm-Message-State: AFqh2kqtEEXjSPocjAyxzkWF9pOguJFAKaaM/laj9hcpeiR+JN2znTeD
        pelfumrcxGbiJ+GDvVcyxBs=
X-Google-Smtp-Source: AMrXdXsSKNVjJ8TOCltmeO24kHeUvxjMy0Eg2UYACQOEKR6GEKueqMPlYZKuaKS8Hzu4V062/Iz7zA==
X-Received: by 2002:a05:6a20:4287:b0:b6:4270:6dfc with SMTP id o7-20020a056a20428700b000b642706dfcmr14315065pzj.6.1673598077894;
        Fri, 13 Jan 2023 00:21:17 -0800 (PST)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id t2-20020aa79462000000b00582a224e738sm13129188pfq.63.2023.01.13.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:21:16 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 50C74104A90; Fri, 13 Jan 2023 15:21:13 +0700 (WIB)
Date:   Fri, 13 Jan 2023 15:21:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/scripts/gdb: add necessary make scripts_gdb step
Message-ID: <Y8EUeB8tbpNVcn71@debian.me>
References: <20230112-documentation-gdb-v1-1-09ab556e9124@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwejcGOrhPQxbZsw"
Content-Disposition: inline
In-Reply-To: <20230112-documentation-gdb-v1-1-09ab556e9124@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hwejcGOrhPQxbZsw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 05:09:25PM +0100, Jakob Koschel wrote:
> In order to debug the kernel successfully with gdb you need to run
> 'make scripts_gdb' nowadays.
>=20
> This was changed with the following commit:
>=20
> Commit 67274c083438340ad16c ("scripts/gdb: delay generation of gdb
> constants.py")
>=20
> In order to have a complete guide for beginners this remark
> should be added to the offial documentation.
>=20

What about below?

```
Since commit <commit>, debugging kernel requires gdb scripts to be built
with "make scripts_gdb" first. Reflect this requirement in the
"Debugging kernel and modules via gdb" documentation.
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--hwejcGOrhPQxbZsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8EUcwAKCRD2uYlJVVFO
o8KOAQDFahicLgQeG6tN4jL//Zy8aMjTQhlQg8Jr6mD5huP8cwEAqJR8hUNA4AXb
VCclsTttygURIsWd9m/7S2O10ALhUQ8=
=KOrE
-----END PGP SIGNATURE-----

--hwejcGOrhPQxbZsw--
