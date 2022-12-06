Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6A644055
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiLFJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiLFJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:50:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C7140AA;
        Tue,  6 Dec 2022 01:49:54 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so14290989pjm.2;
        Tue, 06 Dec 2022 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wE+Y9YKg27+j9ZwRsDEfAYfOT0+DAYDtUxA7ts0XIEs=;
        b=NSM5ggndPkqRsN5xzlfgpI1pKlPrUXy790lqSyNuUHmifHQgB4fshEnNz1GCS5XTut
         +/pgaHrZjVKmDIMxL0ndw2W4+Cg+gdvvFIRPIUKWSCfIN+UX0jrjh5Fj50g08DqnwplW
         p01Q5UxwQjMJzs4TIVh1V/YY0r3bb5AyHc4qxZeMFMc7hnvEIHa4Go41LzG0/aAzWeaw
         gfFxVzGRXOdrxgc8V4LKoeHjbppma+vzisbqDiD62/M5f+nf1OLBrMu5rkD92hBx2Wqd
         gnIFwyLLzS2Kz8IXtvFhhFChsrzol8LVKh+5P0i/OD0u/VQEGZDb14SjvPSmBYyARQmO
         B6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE+Y9YKg27+j9ZwRsDEfAYfOT0+DAYDtUxA7ts0XIEs=;
        b=5gFpE+iwAEynqCm9ait+mD+AL4iqhMrMBsitANePyd0Rxho4eKXiFANM4DxoUBa9+7
         v19yTdtrsdFF9A/DgR1chTqg3hEcd7BYe1uYWusAXzTv445/xvwko4Wv+M3mPH49pGLm
         diVYaFUB6OK1wr0UB8DJQ5vZ48AIjZkPuS7B+JE1j+uiKl8QtBUtdgTXRhKL6wVjCOxb
         1m4pkOkROE8mbYpg4QOclZDhiWQu7tgSFaLwSK98txyqSYWxxw0aU2oQeA7RtBVcQf0G
         NzX5yiz8YVFWmm9yc4t7IrOzk6DaQ9Ghm9OoQPGuOmGFYUD1codPWU+zdVm0rEWO3QRn
         hdlw==
X-Gm-Message-State: ANoB5pkXoSfg26abqE/Fs9NApZ34LyiZ9905rmmmLgOWm0PXW5dTSyen
        /UR1KDzKLdiGcaJM7gBp8bWszeqtO3o=
X-Google-Smtp-Source: AA0mqf7lDjbMpwp0z7KNChyrxwV938s/rltfy4lwKcANWM7ZOzolJRFzjvteZvezkKIPKtoiJlSLHw==
X-Received: by 2002:a17:902:e751:b0:189:80fe:b483 with SMTP id p17-20020a170902e75100b0018980feb483mr43641419plf.20.1670320194423;
        Tue, 06 Dec 2022 01:49:54 -0800 (PST)
Received: from debian.me (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a5a4100b00219396d795esm10552409pji.15.2022.12.06.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 01:49:53 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 70D6E10437E; Tue,  6 Dec 2022 16:49:50 +0700 (WIB)
Date:   Tue, 6 Dec 2022 16:49:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Robert Schlabbach <robert_s@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH -next] media: dvb/frontend.h: fix kernel-doc warnings
Message-ID: <Y48QPphds7q6b5Sc@debian.me>
References: <20221128054303.3124-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NJPqvbdg7uJRbd2o"
Content-Disposition: inline
In-Reply-To: <20221128054303.3124-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NJPqvbdg7uJRbd2o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2022 at 09:43:03PM -0800, Randy Dunlap wrote:
> scripts/kernel-doc spouts multiple warnings, so fix them:
>=20
> include/uapi/linux/dvb/frontend.h:399: warning: Enum value 'QAM_1024' not=
 described in enum 'fe_modulation'
> include/uapi/linux/dvb/frontend.h:399: warning: Enum value 'QAM_4096' not=
 described in enum 'fe_modulation'
> frontend.h:286: warning: contents before sections
> frontend.h:780: warning: missing initial short description on line:
>  * enum atscmh_rs_code_mode
>=20

These warnings are gone, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--NJPqvbdg7uJRbd2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY48QOQAKCRD2uYlJVVFO
o8IZAQC9Jp/HlCxYD1QwMWlpveelUltR/7GZe2BLiaFKmStTVwD/TuS3/X8dML++
InSz15yG8dOqofv7kqfA8EBT8i9PdAY=
=ZLQJ
-----END PGP SIGNATURE-----

--NJPqvbdg7uJRbd2o--
