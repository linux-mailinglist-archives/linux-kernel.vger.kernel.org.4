Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066C6F04A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbjD0LCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbjD0LCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:02:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9354C04;
        Thu, 27 Apr 2023 04:01:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3eef63eff7eso39567481cf.3;
        Thu, 27 Apr 2023 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682593317; x=1685185317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nBxwpnNO03GZyJpSYtHfr/pjNmOjj8lIN2yS6Xjf24=;
        b=I+WaLJX3uhBEFdIn/emBmqExYzyV8Vv50VMH5hEPm2jr8MOIkbXyZtgQEjddZ1tej6
         0n/eunjHB9eSG4Q5yevvxUjAvUqxzk4q1+i13XjoGyhtHpifufdOuNPGGZktU22apVVo
         OS5L/BtF8uQ4PLbGzJca2XrsbUE3eKuk5TsQe2zCCFE3WOTexzPF6HE5tN0Lcg8zs35i
         aFbY4VxaTGcq64HlSJ39V/NyZXMO2xEcqPRJUTVest3afWihhuetT9REJjLesWAZfllB
         JELJbWAaUsmjjGseAB9amDFSXCfSEcwak3HJBsrDWrp/YGHUR6irsFBR15VPkAnxCuBL
         9ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682593317; x=1685185317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nBxwpnNO03GZyJpSYtHfr/pjNmOjj8lIN2yS6Xjf24=;
        b=gdzwprZDxQaETgPIc2prFWVw7GuL7ibftyaJkAvO3mUJoPvJIWaxikMrdghFO8et/R
         pJcnDjqwfaiX6GkFQJdAN4Ml+vOxOjJu8ZnN1qcZ8iw9r0y4hutRaDXJBxc7DUcH6GEh
         fb+UNiovfUitQEQkNEZD+MrRroK1WjOsKAq+tWZnDkj2Hse5+qS4il+FKh4DBx1wdrlO
         KHzEAn2A4elUGc7+yd28zeB8dFmvXGMTUchDah/e/qQHUnjBb1LuWlAnh5jVCxeXhAj8
         AZdTu+oOLx4veurYSwATx1dwgOu6yW5ZNaJwj28u778iX0VUlOzz28NLhCw+lRxWb4z8
         uMGQ==
X-Gm-Message-State: AC+VfDyyKUjo/jsK9VU341q/FNMXH6sGsU3uZqe4iEpa4EopiFufRCUa
        m4vYSCbgg1i3ItFaepZRWYMm3XLZx3+BRQ20XM8=
X-Google-Smtp-Source: ACHHUZ51PQ/KNlXFOdCWuJgGXK2lpoizYRaYlT2+p6/Zncx2gH0BxqXMXVu37ubbw25C+y0XtzOAHwGd6i9o3fwv//A=
X-Received: by 2002:a05:622a:289:b0:3ef:4a9b:5dca with SMTP id
 z9-20020a05622a028900b003ef4a9b5dcamr1594011qtw.29.1682593317422; Thu, 27 Apr
 2023 04:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230426220338.430638-1-andreas@kemnade.info> <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
 <CAHp75Vep8VSirY7mvGGCubNi-O4jS_inTALS3Ei9mQu98RV+7Q@mail.gmail.com>
 <52453352-74bd-979f-03b6-322489800538@csgroup.eu> <20230427123733.15ad4aa3@aktux>
 <CAHp75VezDMZkRTRHRACtJZCW2S_1NoZL5GDK7tmA2vzjrAhOKg@mail.gmail.com> <d585bdd8-978a-8172-bd55-4494d25299e1@csgroup.eu>
In-Reply-To: <d585bdd8-978a-8172-bd55-4494d25299e1@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Apr 2023 14:01:21 +0300
Message-ID: <CAHp75Vexy1p8E5VYj=kX9VPxAghzVwbh3ANvLVP4yrxkHZ+H7A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
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

On Thu, Apr 27, 2023 at 1:55=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 27/04/2023 =C3=A0 12:46, Andy Shevchenko a =C3=A9crit :
> > On Thu, Apr 27, 2023 at 1:37=E2=80=AFPM Andreas Kemnade <andreas@kemnad=
e.info> wrote:
> >> On Thu, 27 Apr 2023 06:20:34 +0000
> >> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

...

> >> I will send a v2 of this patch with refined logic.
> >
> > Actually it would be nice to integrate a warning (if we don't have it
> > yet) when adding a GPIO chip with a static allocation and which will
> > overlap the dynamic base. Can you add that into your v2?
> >
>
> At the time being we have a warning for all static allocations,
> allthough their has been some discussion about reverting it, see commit
> 502df79b8605 ("gpiolib: Warn on drivers still using static gpiobase
> allocation")

Ah, even better! Then no need to have a specific one, thanks!

--=20
With Best Regards,
Andy Shevchenko
