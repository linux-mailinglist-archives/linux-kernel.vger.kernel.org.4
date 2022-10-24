Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C936098A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJXDSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJXDST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:18:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C67976577
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:15:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b11so1041917pjp.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbngZZcoSCG0fJlFW1rE9Wmi/NeV6JY9aiQpj2nFf58=;
        b=m08E3eUp1hqJIoFx2LtjY0uKWF2WyfWN0kjzWstmU6wI4/KTZu58YKUs5QVx+cjTTx
         Z0jMr7Sj5WKc57ZyMq2WUbZ/1R6cB46O4FY5KSltGlaCapPr0TfR9rO4eHyGO2pemF0K
         kf5n1SAxA9ydBdof/GvajY02kV48SaV4ZcZNoLanPppvF+q123jDXsW/vmheSSnbS0Lh
         ikf7jvlrUwa1TOydQyf5+25saYLpx10Z8ZFdqNt1NzvufehByZQsaHHadZHdxvchc1we
         Bi87zUcWY3ElnchBKamm1IUwnUTJpUWcMwd7V9kzSTW6VNZSho5Yz4DZv+VHL7Duol6B
         kaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbngZZcoSCG0fJlFW1rE9Wmi/NeV6JY9aiQpj2nFf58=;
        b=4ycA57MtScVpTy2YfhODG47ZMI0DyX6ekk0v3ARW0OPGGVgamqrg/8zIOPxspig17W
         eikRWjfulXbXyx6k5nbM7fqMoSwcsXPjHvGJz2aRboQwssOsjp0xX3nEJxOUuhDa1XBk
         thLpeM7uXgVaxoP5K3ROPicDp3mWHxnKy/fwL7in5j6uZ1F1uSA20TJZeaQBnOBHoeDU
         w7rxqUZ+kSW8YM3OPqt4pvoG3/VhEUEk30wRxSDSBMR7DmudFrvhkc/ooMUZYs7l0GtF
         KGDsyGDG1j1V6wPdkB1FhtjuT4v2bV9HUfArnGkvipt2KLRt9S1xJUeLdLBLVfezGCN3
         rgjA==
X-Gm-Message-State: ACrzQf0W8AzsJcssjH/w0xPLQ18qAHmaoS4+tl65voLumfnju4XbjdgY
        2rX7+r7IMZM1WwHgHYP93Io=
X-Google-Smtp-Source: AMsMyM5FN3i0fXqxHo7XhBWcloLUQyW2EcovEivECpboSu0lSGoRQeOPlHxVNUvBTrrp1uSZRIk1OA==
X-Received: by 2002:a17:902:bc46:b0:186:a8a8:e9d9 with SMTP id t6-20020a170902bc4600b00186a8a8e9d9mr3205488plz.13.1666581351480;
        Sun, 23 Oct 2022 20:15:51 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id ot18-20020a17090b3b5200b002008d0e5cb5sm3300779pjb.47.2022.10.23.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 20:15:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 82D96103B1A; Mon, 24 Oct 2022 10:15:48 +0700 (WIB)
Date:   Mon, 24 Oct 2022 10:15:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     uroshm <uroshm@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        micky_ching@realsil.com.cn
Subject: Re: Fixing rts5208 driver code style
Message-ID: <Y1YDZH50yYyhPDow@debian.me>
References: <3dbf8c82-9e07-5b9f-e969-4a7cd83e4d9e@komputer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8m0FXoPQvXWlTEpH"
Content-Disposition: inline
In-Reply-To: <3dbf8c82-9e07-5b9f-e969-4a7cd83e4d9e@komputer>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8m0FXoPQvXWlTEpH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 23, 2022 at 03:32:31PM -0400, uroshm wrote:
>=20
> diff --git a/drivers/staging/rts5208/general.c
> b/drivers/staging/rts5208/general.c
> index 0f912b011064..4694593af4d9 100644
> --- a/drivers/staging/rts5208/general.c
> +++ b/drivers/staging/rts5208/general.c
> @@ -9,7 +9,7 @@
>   *   Micky Ching (micky_ching@realsil.com.cn)
>   */
>=20
> -#include "general.h"
> + #include "general.h"
>=20
>  int bit1cnt_long(u32 data)
>  {
>=20
>=20
> Signed-off-by: Uros Milojkovic <uroshm@gmail.com>
>=20

"Strong fishy" smelled (patch corrupted, no description, improper patch
subject).

Please see Documentation/process/{email-clients,submitting-patches}.rst
for how to properly submit patches.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--8m0FXoPQvXWlTEpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1YDYAAKCRD2uYlJVVFO
o+dwAP97+iXZgFIRmsHvQ/SNT3q6O0pYNBrv3VJWfZoCsGRBrgEA98Vl5ssUTbJu
uxuogtCRP9r/QSI7T4kZXZI9A13vxgY=
=eWOT
-----END PGP SIGNATURE-----

--8m0FXoPQvXWlTEpH--
