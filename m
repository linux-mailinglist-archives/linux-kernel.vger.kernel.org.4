Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C150678E87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjAXCtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAXCtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:49:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2083F3B0ED;
        Mon, 23 Jan 2023 18:49:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o13so13519839pjg.2;
        Mon, 23 Jan 2023 18:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10WRUmnlj92TgdMfMl0OkfHOZQo7PKllqvBEDgwMaoA=;
        b=qNN4n8fCMBr5mvxuvA51fnuENMgCADH5ZAipGXnDeMF9zliNUcHKkIyn7BFxvQPqiB
         uS67h4ikyIowvds75hFlraj92iDgnvpu8+zkBMlbUtNqCjzF0qFuC37eC7NyrxwfQn5w
         9JWkS/xOHvl55A7OcgKmCYsYIZSTbZKW4eRTjeNF01JpuOpFdhfBnaqkBGbOoIGiANgm
         xdoZiRJphWTJyihHbPeoGP4LVKaViP+B2OOgtYy7OP61BsaVKa9Wa/OowARrhNTOLaDq
         qefHuoMcJD8RH1BGI2PPejfhw4ky3eAuqU1FPAXwZmETSY8kBxFM85xlVNFT1md9bcH/
         rAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10WRUmnlj92TgdMfMl0OkfHOZQo7PKllqvBEDgwMaoA=;
        b=5h2aYzyV4IuCZDifyQNeShHX3A9IbNvhZYcayUiM1XvZf/koq0ogHA832L+BU9RtBJ
         L9eJY4W97i9+zhp+qSy48A5rjXw5ux2HZ3dCnC9jh0xyxrg+R8gkq1Zyg7Z9jSdcdMRi
         Ek6JGEM1G17o8kWo+cEiS8z9ROdq4IYASgQUvJNNWVfhyXBb3DILvbs3S251fmkIGRki
         b/rKa+NphhhQ0fmYmjrMFkRCutyLdJIH7T+Q4qSRjdc8hYP5BYnZ+kDWd21vt43kLZOe
         MpO8Kmo7xct3+khZSkQ33WEdNtZD4taN0D3bvM4l8fVpP99Bl5FCdk/OLkI6Gnkf2fVz
         zojQ==
X-Gm-Message-State: AO0yUKVQYxkn2BMWaUwCVRSSXez659R99lrvDptBt952wAwRJlpK/tOL
        ADeiEZDWcvMeRcslFgHSst2B1gI2rnPJGQ==
X-Google-Smtp-Source: AK7set9m3IjRxZKzuMrXof+Y/DSDaTkyiy2DMLr/kJ4OZeoXNLwjzGA63X1gGjYDio4iKgOvqRWBOw==
X-Received: by 2002:a17:903:2310:b0:196:119e:810c with SMTP id d16-20020a170903231000b00196119e810cmr1431370plh.0.1674528547605;
        Mon, 23 Jan 2023 18:49:07 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id d24-20020a170902aa9800b00194bda5fe5asm410305plr.115.2023.01.23.18.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 18:49:05 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B1414105170; Tue, 24 Jan 2023 09:49:02 +0700 (WIB)
Date:   Tue, 24 Jan 2023 09:49:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Diederik de Haas <didi.debian@cknow.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module.h: Fix full name of the GPL
Message-ID: <Y89HHtQQ4/pvsOut@debian.me>
References: <20230122193443.60267-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BA5YW9TKzNjuM13A"
Content-Disposition: inline
In-Reply-To: <20230122193443.60267-1-didi.debian@cknow.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BA5YW9TKzNjuM13A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2023 at 08:34:43PM +0100, Diederik de Haas wrote:
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

No patch description, really?

> ---
>  include/linux/module.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8c5909c0076c..329fa0b56642 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -186,14 +186,14 @@ extern void cleanup_module(void);
>   * The following license idents are currently accepted as indicating free
>   * software modules
>   *
> - *	"GPL"				[GNU Public License v2]
> - *	"GPL v2"			[GNU Public License v2]
> - *	"GPL and additional rights"	[GNU Public License v2 rights and more]
> - *	"Dual BSD/GPL"			[GNU Public License v2
> + *	"GPL"				[GNU General Public License v2]
> + *	"GPL v2"			[GNU General Public License v2]
> + *	"GPL and additional rights"	[GNU General Public License v2 rights and=
 more]
> + *	"Dual BSD/GPL"			[GNU General Public License v2
>   *					 or BSD license choice]
> - *	"Dual MIT/GPL"			[GNU Public License v2
> + *	"Dual MIT/GPL"			[GNU General Public License v2
>   *					 or MIT license choice]
> - *	"Dual MPL/GPL"			[GNU Public License v2
> + *	"Dual MPL/GPL"			[GNU General Public License v2
>   *					 or Mozilla license choice]
>   *
>   * The following other idents are available

Why did you do that? Maybe as justification for your other GPL name expansi=
on
fix patches?=20

Anyway, let's see what Linus thinks.

--=20
An old man doll... just what I always wanted! - Clara

--BA5YW9TKzNjuM13A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY89HFwAKCRD2uYlJVVFO
o+bKAQCTx68iwlMjlC99zL4xr0lf5527j1ubdYlcXKFVxXKVAwEAwWAHN+VAV+VQ
GqB6/d6IrpQygRPKuwg3IjCfnaMRHAQ=
=o/dX
-----END PGP SIGNATURE-----

--BA5YW9TKzNjuM13A--
