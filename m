Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC315EDC61
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiI1MQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiI1MQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:16:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADE7E014;
        Wed, 28 Sep 2022 05:15:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b2so3825061eja.6;
        Wed, 28 Sep 2022 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=w2WvxyPY6RXkuWJozN8KTXQujp3KO4pPhB3QayKEgz8=;
        b=dqbnN4ZWolUFzz6PipqWBEOKB2gHUwajLtFD61DerTNwXIpxrXhHvX5ywSaq2Aa/mV
         TKLIg5AzndvP6XY9crsqggpXff5hnD24nJDmzsspZsjE68GyBI8upTVnA4e55FNNZoRo
         +zHj7DkBPWi5HD5fLBPEQVq5RRGu51XI6kZmaKFr1SBa9DT7E1THj3bPjHdqL5xO142N
         k0PB3pVJyMW8NBLNMe09iUhA5qbHC3VeLpqPNCOwyavNC0GYFsiKe4/a4ByxmZiz2gfK
         sHRYSaZgrqMxDoqfS5moXp14+9J+6FxU/LBQdenAnBGV5GfX/WhJUl/5UEQXFkXZk6n7
         bUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w2WvxyPY6RXkuWJozN8KTXQujp3KO4pPhB3QayKEgz8=;
        b=pjSzSSX83OQdL7zWwNkQESQwYaGA/0lxUVZ5TMXRM5YlE19j2enP6pN8muGMIAlr8Q
         SyerC1t07Vi+re984ibE+ZD7XkEln7OeKuYym6KHcy1HojawXxX3SkR5fO89kweO6K3V
         fNkC2LQGWoY/est7Yo4vDWwrBfcgE51NafLhaxEVs0qGH07G0fn/QQ1oVpuVmuSfcFc7
         CsPRkDzPrkU81rt0EjAbiIzrOARsBzBpOgRraeyX3zCdTgra0Q8htWnTHBy28TTQjXiL
         Gf3kHahKy/kFUF+ty/afRS5PQ3p3TCAblIblHkHC+CwxhT+CEn78D49P5r59aS/hsEJQ
         /XPQ==
X-Gm-Message-State: ACrzQf0IGmhQf8l+fwMugHu3A10EhW0jwTSAzXaC1MaZL2Nr/+0uQexc
        bWzOCtkAeD5aMhiIFG7FRSU=
X-Google-Smtp-Source: AMsMyM7THVOWnM8D8auMBqIMc5SVBkp2v/DavzytV3CbgZgs4QTLHM8GAkLCYZ7bHSzRQSwy2oMH1g==
X-Received: by 2002:a17:906:a3c2:b0:783:19a2:74d3 with SMTP id ca2-20020a170906a3c200b0078319a274d3mr16817850ejb.288.1664367356958;
        Wed, 28 Sep 2022 05:15:56 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906844300b007415f8ffcbbsm2286000ejy.98.2022.09.28.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:15:55 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:15:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/4] pwm: sysfs: Utilize an array for polarity strings
Message-ID: <YzQ6+mX+75KBW9O7@orome>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-4-andriy.shevchenko@linux.intel.com>
 <5ba98dbd91dc981ec7384484b2a498805abef6b0.camel@perches.com>
 <CAHp75VfY5RgAju5ASvAp565oF6VmYYiuowNsPTGSm=+1iFJ98A@mail.gmail.com>
 <2e158f8dc433b6b78d47d209495bed678d92369a.camel@perches.com>
 <CAHp75Vc0NtYcuSUP106V54U6EBYsj3LMx2FDJT4_pfB3gAtpPQ@mail.gmail.com>
 <25705469f329005a4ff699d1f45a12dcb575adc0.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K7V/mrz7OYoGtLJP"
Content-Disposition: inline
In-Reply-To: <25705469f329005a4ff699d1f45a12dcb575adc0.camel@perches.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K7V/mrz7OYoGtLJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 28, 2022 at 02:19:22PM -0400, Joe Perches wrote:
> On Sun, 2022-08-28 at 20:40 +0300, Andy Shevchenko wrote:
> > On Sun, Aug 28, 2022 at 4:46 PM Joe Perches <joe@perches.com> wrote:
> > > On Sun, 2022-08-28 at 09:40 +0300, Andy Shevchenko wrote:
> > > > On Sunday, August 28, 2022, Joe Perches <joe@perches.com> wrote:
> > > > > On Fri, 2022-08-26 at 20:07 +0300, Andy Shevchenko wrote:
> > > > > > Code is smaller and looks nicer if we combine polarity strings
> > > > > > into an array.
> >=20
> > > > First of all, please remove unnecessary context when replying.
> > >=20
> > > I am _very_ aware of context.
> > > I specifically left the code in.
> > >=20
> > > > > It's less robust though as PWM_POLARITY_NORMAL and _INVERSED
> > > > > are now required to be 0 and 1.  As the only 2 values in
> > > > > an enum they are, but that's not really guaranteed unless
> > > > > you read the enum definition.
> > > >=20
> > > > So, what do you suggest here and in many other similar places (yes,=
 ABI
> > > > implied) in the kernel?
> > >=20
> > > Leaving the code alone.
> >=20
> > It's good that PWM maintainers look at this differently.
>=20
> The enum is not userspace so it's not ABI.
>=20
> The PWM maintainers are free to do what they want but I
> prefer obviousness over compactness.

I do agree with Joe, I don't see any benefit in this.

Thierry

--K7V/mrz7OYoGtLJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0OvcACgkQ3SOs138+
s6E2qA//efIhd72suhbp3wVU26ZYv3vUeU5PabYxkAYaKzVAwSJHsrbXFzBz6APi
X798wCLXzPfS12kYUC+pvu5CBEFvPuhjT3un37OLqgtdBOmcwJNodT/kQKy6rDcP
EeOx0Nsd0i9JWPvROazR2gXlYHGL1hrfnKUslbPX20zkLc2Ed4UCHmJc8pQMWdal
tltnqg8zyLe8qAmRKtUXqqzSD2jMNjntkHtAr/digrTbwejtAe+NEJlqgjQx0/EA
hCGrl48IVq8ZGnoAtFl3THxMEMuh3FZM0eULmDpkA1FsFgYzyIjbJGUoJHv+1N1O
E+FCXF0QmeL1T6uVxTnPG2kPyR63V7GdtvacROmTXRGsSfnQFewO/biLWnClUzF0
50rnYGZnL3pLnlfIxtkQ9hKyC0IU0yS3Nmda6wq3Bm4u8H9ABeOta6tHc3re3pG3
ftrZhHoRGF7IKl1IgEVcZ3zvYiNW25aZJFlo8vTLMrXlLWVLKiqqgTnwtA6tH+Yb
7N2KNbaWeYtbP/SgrBvWORQGMG2d5wRKT3JosZIVtrxvtKIKl78mrVcRPbEx5RvN
vWTI97/AYJloDRy+ltdoJO5gK0Xr6SAtFymnt2bfhLNc0fkZypA22Ztgn3qw/a/z
BQq2TAwX2m6je5HxNA5T1Xi6+55R8gDLuUOaV7lt4OWxdnmgB50=
=2Pm5
-----END PGP SIGNATURE-----

--K7V/mrz7OYoGtLJP--
