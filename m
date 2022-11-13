Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFE0627008
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiKMOOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 09:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiKMOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 09:14:35 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16737B7EB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 06:14:35 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id cg5so5474804qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNZRFfPTIAo7WXZRG85F2W4fpqHXCOpB+6LDuGu/bak=;
        b=sE13bnfiQEwOas5EWN/9S1zISno6RI4STkh69426YI8yjtTcFtaIM+b1VG3fFH1uei
         BmxoJJlZJnk7ofNVYpYb8twKxJI0CPOWEa6hwK3mYYCh7zFsMGOfoz3cQHCZGrbjf3qW
         LDFplfzUF65uFR6j0XvJE+LcxbwWgzsaUnOqvCVPN8UPX43a5ODGiiOx/L3B9+Ju05gw
         liatH+v3lh1AiCcVrN5CdtgSbqUZwxFDkD60H9T93QZfHHri5cMFy2+ErwJXSLqsPr9I
         bg9OtkSjjJd/TeslErekQ2cAvlYpXZlt6DM1/ZQWiF74LGs0vMY/vJeZgpxmRGKZ2CpR
         j1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNZRFfPTIAo7WXZRG85F2W4fpqHXCOpB+6LDuGu/bak=;
        b=i86dG+9MNC599ZPZzh3EAOUey1H+uP5Cl1gokPT5xD/D5nRG9qqqaR6J3HDIYX+QFA
         BBnqmCylq2F/6LoCu3cXli9KYwB+/CakRvY20dOHmKtzQ+RCTWDuhQ7zPF1CvEoYUu7t
         TOIaNCNSQJz1pGuW5FjLD7M5ae1kyd5l/YrvMYMAAWwLmU5xFWknk5QRvMCTMPokRe7Z
         GMYWqnzlNGvTkg9i/QkUZixxEkkSv1MnzkVHghdKY4zipiVAecr7YsaOHLF1bAQdOHsW
         Ybn6yxSpRtwLALvawNTdoWGOMSY7FkDOuXdUxcfhKQv4+WCotEud1MXmNoLh1Njxrr0A
         4o9Q==
X-Gm-Message-State: ANoB5pkxluT7Ir/UfPsYNBbXmnlIfumLhvABHjqV9r42g3ts5VeJwT5J
        rb1SghGG+ElZQnf/jgk5JyEjfQ==
X-Google-Smtp-Source: AA0mqf5jFx8ZESzHrdKTSEHHQzdGZFMHRNEwRptg4AxS+bZMcap9WmJ+s9unN6xGg2AkpOjKjX/h5Q==
X-Received: by 2002:ac8:6b8f:0:b0:3a5:20b1:e390 with SMTP id z15-20020ac86b8f000000b003a520b1e390mr8754468qts.626.1668348874125;
        Sun, 13 Nov 2022 06:14:34 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a248f00b006fb3884e10bsm4841124qkn.24.2022.11.13.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 06:14:33 -0800 (PST)
Date:   Sun, 13 Nov 2022 09:07:42 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v2 4/4] gpio: i8255: Migrate to regmap API
Message-ID: <Y3D6Lji9bKeSbJaI@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <61327a67cc308af413471a69a4810b2785e53e8e.1668129763.git.william.gray@linaro.org>
 <Y3Dol6rHduFNQT85@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l+IjPmXaLKrbTOfD"
Content-Disposition: inline
In-Reply-To: <Y3Dol6rHduFNQT85@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+IjPmXaLKrbTOfD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2022 at 02:52:39PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 10, 2022 at 08:55:53PM -0500, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver. The 104-dio-48e and gpio-mm modules depend on
> > the i8255 library and are thus updated accordingly.
> >=20
> > By leveraging the gpio_regmap API, the i8255 library is reduced to
> > simply a devm_i8255_regmap_register() function, a configuration
> > structure struct i8255_regmap_config, and a helper macro
> > i8255_volatile_regmap_range() provided to simplify volatile PPI register
> > hinting for the regmap.
>=20
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Suggested-by?
> (I'm not insisting, just consider if it's appropriate to use here or in t=
he
>  other patches)

No problem, I'll make sure your Suggested-by lines are properly added
for the patches. ;-)

> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> > ---
> >  drivers/gpio/Kconfig            |   2 +
> >  drivers/gpio/gpio-104-dio-48e.c | 397 ++++++++++-------------------
> >  drivers/gpio/gpio-gpio-mm.c     | 151 +++--------
> >  drivers/gpio/gpio-i8255.c       | 429 +++++++++++---------------------
> >  drivers/gpio/gpio-i8255.h       |  80 +++---
>=20
> Can we actually split this to a few steps:
>  - providing gpio-i8255-regmap
>  - providing gpio-mm-regmap
>  - converting the driver
>  - removing not used modules (one by one)
> ?
>=20
> In this case if any regression somewhere appears, we can always perform a
> (semi-)revert for a certain driver.

Sure, I can split the regmap_irq migration for 104-dio-48e into a
separate precursor patch to reduce the amount of changes we see here and
provide a revert path for these IRQ changes. I can do a similar change
for 104-idi-48 as well.

The rest of the changes for 104-dio-48 and gpio-mm are essentially just
the regmap configurations, so the patch will be largely identical even
if we migrate gpio-i8255 to regmap API first before migrating again to
the gpio_regmap in a second patch.

I believe the reason the changes look ugly in this patch is because the
large number of lines deleted is confusing the match heuristic for diff
so the changes aren't lining up nicely into distinct deletion/creation
blocks. I can play around with the git diff "--break-rewrites" option to
get it to produce a nicer diff; I think gpio-mm looks much easier to
review as a rewrite rather than inline diffs [0].

[0] https://gitlab.com/vilhelmgray/gpio/-/raw/61327a67cc308af413471a69a4810=
b2785e53e8e/drivers/gpio/gpio-gpio-mm.c

William Breathitt Gray

--l+IjPmXaLKrbTOfD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3D6LgAKCRC1SFbKvhIj
K680AQDBglAZoOnqV+sVHlIl9/nOiibX2EdRb7qmeqg4iW9pbgEA6dBV3pWLBU1k
hzVMUuUSwa2v+gN6LsDoz3yELg9HKws=
=S2bd
-----END PGP SIGNATURE-----

--l+IjPmXaLKrbTOfD--
