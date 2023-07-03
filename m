Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D87453AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 03:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGCBop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 21:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCBoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 21:44:44 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ACB180;
        Sun,  2 Jul 2023 18:44:43 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b09276ed49so3690492fac.1;
        Sun, 02 Jul 2023 18:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688348682; x=1690940682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzvLGBb78WzT+NSXATynEClqZXzX48pg1vFx3CiBNYw=;
        b=EgfQCxBpZeraUfHkaZIv/3KUueE10YsB3st6/N9VVUHmBpXGlkF1oMQbJs7jId7Vn4
         oXw66Ml4aGrmkLNX/ILmhBDoErj723nIVkc0wt8tUB8QH4xSoaWsURmkWh7cQrme+MWh
         L5+v2D6TAc1+aXrxr9m9FEjp0cNq+FQoG75b9JPW3j7pSikxjHv8Govg86Tdv4uksxPF
         /Z28fJZuasPG8EQtp+UN9EWMjVp6zbRxxWMASruETO83731OAPT1ESwh7H+zIu6S3emB
         w+mJE63Cpd3UsZBK7H7SA1QrRSjquYIOKUoIO1TdPsAOmyfWFiqQz2DSTRleQft502au
         0K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688348682; x=1690940682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzvLGBb78WzT+NSXATynEClqZXzX48pg1vFx3CiBNYw=;
        b=Bie7Lk8BweLgUGxqvpoyyoe786+Of5buQM/zySHr+yzQhOVXFouFVGyGt+Ov+P2CZj
         4gHdzYSs19B3luNhP7cgl6SOVZ6zWmuxp5afaxzs9MLVW6QOb9tm84fdVaqSKjaPDJBt
         0fCkZAMRKfnuPmBhS8daiTl6R+ivK8HzAApU9SEYPdmr/0Tk7HDHDN8XuMjAhWwsEfUd
         uqIN9X86XXTGEm37LIp4/p7PizNLun6TJP2Bhkpg+lkNk2hYUzMF9KO1mSvBNjNsjuN1
         leytiM3Cq1fhrvyA5P3uWXBc1hmTWFx+VH2z5FgtH/jU0rZPRgUhWMHyU0K/y0f0po70
         wiXw==
X-Gm-Message-State: ABy/qLYVAsw/qu4rSJCBvbA5qS5Wzrc1ivt1TTlIj3vXfqfgawED90U5
        kw5XoHTIrkrpfrWOg2GyKoU=
X-Google-Smtp-Source: ACHHUZ5EH/LbCpjfBuPbXJECS5srDN10ZuIVDwU5oqq/fJO2xypvld6QtyYlm1yVBzDX95ceWp2qew==
X-Received: by 2002:a05:6870:332a:b0:1b0:39bc:857b with SMTP id x42-20020a056870332a00b001b039bc857bmr9803374oae.16.1688348682285;
        Sun, 02 Jul 2023 18:44:42 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h18-20020a63f912000000b0051b36aee4f6sm13686167pgi.83.2023.07.02.18.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 18:44:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A0FF381BD580; Mon,  3 Jul 2023 08:44:37 +0700 (WIB)
Date:   Mon, 3 Jul 2023 08:44:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>
Cc:     linux-kbuild@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Linux Regressions <regressions@list.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
Message-ID: <ZKIoBVzrjZ+Ybxy9@debian.me>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DuHJI7yAepGavJ2H"
Content-Disposition: inline
In-Reply-To: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DuHJI7yAepGavJ2H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 06:36:12PM +0200, Mirsad Goran Todorovac wrote:
> Hi,
>=20
> After new git pull the kernel in Torvalds tree with default debug config
> failed to boot with error that occurs prior to mounting filesystems, so t=
here
> is no log safe for the screenshot(s) here:
>=20
> [1] https://domac.alu.unizg.hr/~mtodorov/linux/crashes/2023-07-02/
>=20
> Bisect shows the first bad commit is 2d47c6956ab3 (v6.4-rc2-1-g2d47c6956a=
b3):
>=20
> # good: [98be618ad03010b1173fc3c35f6cbb4447ee2b07] Merge tag 'Smack-for-6=
=2E5' of https://github.com/cschaufler/smack-next
> git bisect good 98be618ad03010b1173fc3c35f6cbb4447ee2b07
> # bad: [f4a0659f823e5a828ea2f45b4849ea8e2dd2984c] drm/i2c: tda998x: Repla=
ce all non-returning strlcpy with strscpy
> git bisect bad f4a0659f823e5a828ea2f45b4849ea8e2dd2984c
> .
> .
> .
> # bad: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BO=
UNDS on GCC
> git bisect bad 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c
> # first bad commit: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tig=
hten UBSAN_BOUNDS on GCC
>=20
> The architecture is Ubuntu 22.04 with lshw and config give in the attachm=
ent.

Can you show early kernel log (something like dmesg)?

Anyway, I'm adding it to regzbot:

#regzbot ^introduced: 2d47c6956ab3c8
#regzbot title: Linux kernel fails to boot due to UBSAN_BOUNDS tightening

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DuHJI7yAepGavJ2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKIoBQAKCRD2uYlJVVFO
o+n+AP0YhOC9dhrJZyu3ew0uQ0GImT1B+MAHP1QZiPylXfmiewD/V1rq7c7o5O8O
MtlmxjtW/mpWiqQR2avMzL8LQRFGWAc=
=8ZVa
-----END PGP SIGNATURE-----

--DuHJI7yAepGavJ2H--
