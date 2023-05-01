Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADF96F2E76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 06:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjEAEg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 00:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjEAEgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 00:36:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFCEE79
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 21:36:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52079a12451so1318181a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 21:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682915813; x=1685507813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FJ838k1C5SRQ1QpV0bbphF5iaPyZZZtQhPRQozOF0E=;
        b=F4EB75vdxlyBg6SiDCxwOFFk0jHoIqsKC2teM5GNnn++1DACxQXC7cXmCsLFgfZhTj
         KYPjg3DTWK86sw/T257HeoOj38YOWktSytjNIWrJdw6eIl6JWB2wFv24oXQ8gDRPUaB9
         JQfVdC169ZqjJmEq+UkDOjM1i4p+atA1L+loY9E+uGXjebBp9o0AbaYDWCd21K7rhV0m
         dxF83Gi+GeKA7Lo9nS6Qp8XWGQdxkbLXG0X0BnhWv6h0S1GhHiC+uzSzMiQpiC0jhqAQ
         hnjEbvPeiEq2QJNsrh20TB/7DgLChQhj8iv8jtrPciemzQJTABbXU5hKjHrlUbfG7fvK
         M5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682915813; x=1685507813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FJ838k1C5SRQ1QpV0bbphF5iaPyZZZtQhPRQozOF0E=;
        b=W1O575mtkFnlH3t8D/czr5dJnGMGfEUppJmNH0Mt1FntxZK5zhiJ9B1+R8P0LMJcfZ
         kE31dmnUJWWkWjLLY9ZLr6CGu1vBqC11iWlwqdDnAfB00lbyS2lG6VhsC1hUUwg9Bs7C
         ZhUyolvSSOD+jpBri2rmXlixuVtVdfSIPid0p++Wd5njNtOOxg3orPZQgVC/+5I9A1Jz
         b3foiOXwUBmuSR+HtWR0A3gqJ4iyH3q573Qeoy0smzBQY2iy7s3fvp8WX+VIbA8nBZPD
         8SHrr6RaoKq5KleR2rGNtaPw+oyEv145Xe+xBq+9hczsVKBJ/PtGdlB0QSoSKsILG7zS
         LyRA==
X-Gm-Message-State: AC+VfDx1DHwCDVye6FxG2NZsAcb5ualvea1RLPEorqyyhGQaGM8huBdr
        MhiTEVnHd+0WWwMoiAo55YE=
X-Google-Smtp-Source: ACHHUZ49A3xDD6h5SJXvoZmv6tt7PFayV/qkvPMH1okiMRZdcD5LOro7oWQinZDqAooNTW9iUU4ZzA==
X-Received: by 2002:a05:6a20:6a1e:b0:d7:3b62:3cf with SMTP id p30-20020a056a206a1e00b000d73b6203cfmr15224013pzk.54.1682915813043;
        Sun, 30 Apr 2023 21:36:53 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-46.three.co.id. [116.206.28.46])
        by smtp.gmail.com with ESMTPSA id k128-20020a632486000000b00502ecc282e2sm16723810pgk.5.2023.04.30.21.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 21:36:52 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7E4CF10695F; Mon,  1 May 2023 11:36:49 +0700 (WIB)
Date:   Mon, 1 May 2023 11:36:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Linux ALSA Subsystem Development 
        <alsa-devel@alsa-project.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: linux-6.4 alsa sound broken
Message-ID: <ZE9B4avbDtIXOu4O@debian.me>
References: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LJ2qQOdS72n8ceav"
Content-Disposition: inline
In-Reply-To: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LJ2qQOdS72n8ceav
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2023 at 11:59:12AM +0800, Jeff Chua wrote:
> Latest git pull from Linus's tree ... playing a simple sound file will
> resulted in a lot of echo.
>=20
> Running on Lenovo X1 with ..
> 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High
> Definition Audio Controller (rev 01)
>=20
> I've bisected and reverted the following patch fixed the problem.
>=20
> commit 9f656705c5faa18afb26d922cfc64f9fd103c38d

Thanks for the regression report. However, where is your dmesg and/or ALSA =
log
when the regression occurs? What is the playback test file?

FYI, 9f656705c5faa1 ("ALSA: pcm: rewrite snd_pcm_playback_silence()") is
originated as [1/2] of patch series that pokes around the auto-silencer. The
other patch ([2/2]) got NAKed since autofilling buffer should have been don=
e in
alsa-lib (still to be discussed) [1].

Anyway, I'm adding this to regzbot:

#regzbot ^introduced 9f656705c5faa1
#regzbot title Much echoing when playing sound files on Intel Alder Lake PC=
H-P Audio Controller

Thanks.

[1]: https://lore.kernel.org/all/bb342e84-b468-8adc-6688-88da2c857da1@perex=
=2Ecz/

--=20
An old man doll... just what I always wanted! - Clara

--LJ2qQOdS72n8ceav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZE9B3QAKCRD2uYlJVVFO
oybmAP9qZl6m3BGfCju4IYA/iNDLxZpCPY+PPR5V6jt2I12r0gEAiduhNNevDzK/
ts24tNhoskNd+rPICIYUV6L02qtfBwI=
=IYeY
-----END PGP SIGNATURE-----

--LJ2qQOdS72n8ceav--
