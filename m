Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9C36F046C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbjD0KrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbjD0Kqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:46:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65F59C7;
        Thu, 27 Apr 2023 03:46:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef38864360so83636741cf.2;
        Thu, 27 Apr 2023 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682592397; x=1685184397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khfGPRS85Vq7Ff4Ms3My2tPal19zyIsJYVi7TPES5OQ=;
        b=H2NKfjmXqSaDFIGx/KzMyc1lGGu3fyWaR1zODyZKQJdwm96farKgAAlwvZw932bpae
         hXd84u17NhNTJXPGsXQHaaG2fSugonCuCRXwlaEixkbosuVujgVPeJu5yqxnLHN4iMbS
         6oXZyYZw5gd1YqjV6UfvP2PVq2duNUF9t1eoRAKC/GS9FEl5ThLnulmkn/XCC9HvMLIy
         g3IvoLer835JT0JcVh3XHUZcWPyDZxcC7ghI0G8ZxCVT22A983LIf1PLCLkODM6KabTP
         RAUY7y+MhY3Pd1Skby6JkqLrATQKTPO+8De7ehIEDI3nkp3cYw+SAm1AF33/0rC5ijQr
         Vvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592397; x=1685184397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khfGPRS85Vq7Ff4Ms3My2tPal19zyIsJYVi7TPES5OQ=;
        b=ODlfb1apqH0FZmDu/kdI1eZhW/KDWsrHR6bWvH4IF8XrajoxzJrhP7Z54O8LQCT5lQ
         T3S1mTbCPyvzBCWIveedeD6eAn6EGmlCApMaLrRoOEg7TQ0v4MKVb+fi3GYcHlgRiBvQ
         or20P3TjJ1eg5BuzmauomZIO4pqoMmJ9tyl6CCVj6zcn9p836vXek13dfPu09mxSdHVC
         vl//9OwWOx91zpvXTYDW1HjdDllBiflvplkweIMsRafbWzdXx9aCfkgbLbIqvT7MqbNL
         pHSxsl6gFRiqNqCmQ67uDStq+coHrblcebF1W/A9GO7rg14woIOed0iMTWCp3XNtVfqR
         QhQA==
X-Gm-Message-State: AC+VfDzqsX+H7Ekla3QFCEF6xA525ag+Xsd5KwXDowLJvk3xFgY83nv2
        v3Wgyv9FMPOd3/roqH/XyGPmsTISucmeL8maGInten9bneYP8w==
X-Google-Smtp-Source: ACHHUZ7CIgc/BsbmBHGKvw4r/T6e89y95R+ziXfEr9TH7hLMSFLN3HmWN3TSeWApq9MSwf1PMWcnrfuV+lIAaNWYBfI=
X-Received: by 2002:a05:622a:1755:b0:3ef:4c4b:7e1e with SMTP id
 l21-20020a05622a175500b003ef4c4b7e1emr1617566qtk.29.1682592397024; Thu, 27
 Apr 2023 03:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230426220338.430638-1-andreas@kemnade.info> <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
 <CAHp75Vep8VSirY7mvGGCubNi-O4jS_inTALS3Ei9mQu98RV+7Q@mail.gmail.com>
 <52453352-74bd-979f-03b6-322489800538@csgroup.eu> <20230427123733.15ad4aa3@aktux>
In-Reply-To: <20230427123733.15ad4aa3@aktux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Apr 2023 13:46:01 +0300
Message-ID: <CAHp75VezDMZkRTRHRACtJZCW2S_1NoZL5GDK7tmA2vzjrAhOKg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ": Tony Lindgren" <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 1:37=E2=80=AFPM Andreas Kemnade <andreas@kemnade.in=
fo> wrote:
>
> On Thu, 27 Apr 2023 06:20:34 +0000
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>
> > Le 27/04/2023 =C3=A0 08:00, Andy Shevchenko a =C3=A9crit :
> > > On Thu, Apr 27, 2023 at 8:40=E2=80=AFAM Christophe Leroy
> > > <christophe.leroy@csgroup.eu> wrote:
> > >>
> > >>
> > >>
> > >> Le 27/04/2023 =C3=A0 00:03, Andreas Kemnade a =C3=A9crit :
> > >>> [Vous ne recevez pas souvent de courriers de andreas@kemnade.info. =
D=C3=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAbout=
SenderIdentification ]
> > >>>
> > >>> If static allocation and dynamic allocation GPIOs are present,
> > >>> dynamic allocation pollutes the numberspace for static allocation,
> > >>> causing static allocation to fail.
> > >>> Enfore dynamic allocation above GPIO_DYNAMIC_BASE.
> > >>
> > >> Hum ....
> > >>
> > >> Commit 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS") was suppos=
ed
> > >> to enforce dynamic allocation above GPIO_DYNAMIC_BASE already.
> > >>
> > >> Can you describe what is going wrong exactly with the above commit ?
> > >
> > > Above commit only works to the first dynamic allocation, if you need
> > > more than one with static ones present it mistakenly will give you a
> > > base _below_ DYNAMIC_BASE.
> >
> > Ah right, that needs to be fixed.
> >
> > >
> > > However, this change is just PoC I proposed, the conditional and
> > > action should be slightly different to cover a corner case, when
> > > statically allocated chip overlaps the DYNAMIC_BASE, i.e. gdev->base =
<
> > > DYNAMIC_BASE, while gdev->base + gdev->ngpio >=3D DYNAMIC_BASE.
> > >
> >
> > Yes you are right, that's gdev->base + gdev->ngpio that should be check=
ed.
> >
> and that not with simple continue or base might simply stay at DYNAMIC_BA=
SE.
>
> I will send a v2 of this patch with refined logic.

Actually it would be nice to integrate a warning (if we don't have it
yet) when adding a GPIO chip with a static allocation and which will
overlap the dynamic base. Can you add that into your v2?


--=20
With Best Regards,
Andy Shevchenko
