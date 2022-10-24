Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6858060986E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJXDE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJXDEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:04:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC8811453;
        Sun, 23 Oct 2022 20:04:46 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y4so7421665plb.2;
        Sun, 23 Oct 2022 20:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8qeZMvOxiwOAkzS5A81naYZa4/kimVXnTgTuHv+nGI=;
        b=oQd9UYHhiDqkqm5/Zc/uYEpCWSQbAmgiUE2690Eju87ixMRFMPrCP69gZigjjWH58o
         p8mt1HH7zOLOTExa9BYSJzygKaZF58pl0FeCfHCn1K3M9PPIDDaPKqRp+vvyjXAl/IAo
         JYf8d3Ipg6ssH7e/AF60iMbArTtg59dkcyw/8SkWzb2FnvrH9mFkVgVrXpGthT61jkcW
         vjnGXVERAhS9uGB0vf4kvLnFPNC1ekEj6oKtS6bCbLQUQii3l5/wT4Iq/uh+sgG9nLsd
         PBtc1O7QwN8BasQFhNy9lDSWQHOzCAmtW+NJtl55WOaMrO32tR0dpf18dk7x+ZQKFkmt
         jP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8qeZMvOxiwOAkzS5A81naYZa4/kimVXnTgTuHv+nGI=;
        b=EKBysc2rUB0R5kb6VsVM0S0spgv+puA4y1Og0MUqakdJV45aE5ieekeNim+I2JQo6n
         yL1Zqnug9ER9NRPKGCKd7+WsxlIRWRN02GyreTpxaTP8zWlJwQBCm0cPWnMgv1H3q45h
         Lp/mPCbmADoe7tsM2Y5t9IK6zqalLlsaxkF/ezeXP5ShRMaunuc5ppf29SBzqwGHCBPh
         bfT4d9XeJiWdKURSECLlequ112zkXDs2DvH0b9U8Vy1/PsmcRFG0CmeKbKV/pNcfypRi
         Zn3WHWAxruf5movYwNiLv+99QKyWX47l9hwaWp3IfPHpv8W/jS+WAL2S86AkTEngJeDW
         4xRA==
X-Gm-Message-State: ACrzQf0nxRwkk/CB8L3u5+JzMF/X6Sy/p0GoS3X1US6phPF7/2JGxACp
        lmK6QbM+jrCKlZBbEGz4IQg=
X-Google-Smtp-Source: AMsMyM5Azcxe565HkaHJNFaYn/LrVOJoFH9xkQfoPI29SOaJyxrNhy4UI08Ke5xVM9fjLzuVZiQGzw==
X-Received: by 2002:a17:90a:4316:b0:212:fadd:5d59 with SMTP id q22-20020a17090a431600b00212fadd5d59mr6964297pjg.45.1666580685494;
        Sun, 23 Oct 2022 20:04:45 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b0017a09ebd1e2sm18567456pln.237.2022.10.23.20.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 20:04:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 17F26103B1A; Mon, 24 Oct 2022 10:04:41 +0700 (WIB)
Date:   Mon, 24 Oct 2022 10:04:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Johannes Zink <j.zink@pengutronix.de>,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: fix segmentation fault in menuconfig search
Message-ID: <Y1YAyQ4s+wxfAPAU@debian.me>
References: <20221023191055.85098-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PFpEuUJq57bt2SZs"
Content-Disposition: inline
In-Reply-To: <20221023191055.85098-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PFpEuUJq57bt2SZs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 04:10:55AM +0900, Masahiro Yamada wrote:
> Since commit d05377e184fc ("kconfig: Create links to main menu items
> in search"), menuconfig shows a jump key next to "Main menu" if the
> nearest visible parent is the rootmenu. If you press that jump key,
> menuconfig crashes with a segmentation fault.
>=20
> For example, do this:
>=20
>   $ make ARCH=3Darm64 allnoconfig menuconfig
>=20
> Press '/' to search for the string "ACPI". Press '1' to choose
> "(1) Main menu". Then, menuconfig crashed with a segmentation fault.

You missed the prerequisites: search EFI and press 1 to jump to
CONFIG_EFI.

>=20
> The following code in search_conf()
>=20
>     conf(targets[i]->parent, targets[i]);
>=20
> results in NULL pointer dereference because targets[i] is the rootmenu,
> which does not have a parent.
>=20
> Commit d05377e184fc tried to fix the issue of top-level items not having
> a jump key, but adding the "Main menu" was not the right fix.
>=20
> The correct fix is to show the searched item itself. This fixes another
> weird behavior described in the comment block.
>=20
> Fixes: d05377e184fc ("kconfig: Create links to main menu items in search")
> Reported-by: Johannes Zink <j.zink@pengutronix.de>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Link: https://lore.kernel.org/r/20221023191055.85098-1-masahiroy@kernel.o=
rg

Missing Cc: stable? The segfault (IMO) appears after v5.15, so all
supported stable branches are affected.

Anyway, the segfault gone away with this patch applied. Thanks.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--PFpEuUJq57bt2SZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1YAxAAKCRD2uYlJVVFO
o2HWAQCc8AnxqmRk7EXDCw/tGNQvDKVAAcBJxEwn0+m5LiNlKgEA8X42VnAZRZRu
vsjQyQZtBJWTWn+v2wPuOLCMP+wTpwc=
=x7fI
-----END PGP SIGNATURE-----

--PFpEuUJq57bt2SZs--
