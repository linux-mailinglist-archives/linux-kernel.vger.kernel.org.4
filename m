Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D861E712787
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbjEZNbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbjEZNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:31:42 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752D12F
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:31:39 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4397b040c8fso420483137.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685107898; x=1687699898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksL0wfKrSI+58DAMm3woqLByXvazoTPFTjGEkGyXGLM=;
        b=RC8p2GNj4Amb+TIOYSRzmtzfF1Hi452s0NmrMr0ir6Z/1xoz7S6lcKJyA3tw0unC4b
         vUlnYS0ypMkOvn8tw5dldyJaD4HrK0T7j103FD0IZjEYUZhSJvJivua4mOWsIF1dAxwQ
         rt+sbWXcoJ7AWowdlbkhBhENAcx30ywi2IQjlZltDJUfPRagyknt/1FmYacHZi+xK1m3
         4J6uaD9sCTGHD43NeYXIK/KcBTqtoSgVYflrAkUvG1DUJMqD9r8WyOJi801qgIPc09H/
         90tcj5TOnXZ56EoAMs5ZfhSypSxUgfJLbbepZXtCtGwPwbjX8XDANPPEDnKz6dwml7aN
         HfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685107898; x=1687699898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksL0wfKrSI+58DAMm3woqLByXvazoTPFTjGEkGyXGLM=;
        b=aHo1S32/35Zw8HPW1GZJR+ro3NPGgCLpzWLBOIXSE/XE98/c8uSpWEFHrKHbHE+IQh
         ibgHi8NfjjbnzAMSknZ7Q1DRXCKCHIjh23ZsH9vG88derieR2d03HTdk4Pd7fu9X5WMt
         rNehz5kRYiDZl+nUklowiac91FRpLxKl/Sl1gxRGhjs8YRcjLICKtE+aswy6RHGS29g6
         WnkQ65fIRhdI9Lk0F3N6GRyP5AF0nexJQkSRnDg7fYO2nSf9J1F5Lnr1tvzK3A6VTPDy
         /B9LjpxV0FH0sPvl3JmbRwzGBiUtjrZd4RBm394PjHLpf57eI195Virjy0c3tnaQEyby
         Xgzw==
X-Gm-Message-State: AC+VfDxRHtj52glG8nwg69Uv6ZJSgLVrmqCJtgu2STvcgl1KHfxyXMM+
        c87kdxwVBaMVifvQHwGuklxtaVlToiowaL+SyB0f+A==
X-Google-Smtp-Source: ACHHUZ4b6AlaYHY4dcIa+ndk9KCrOMlYjzKoloAfeyNYHVFPnj83RPIoXXiITBm0TMiF44XgOcOZQ1eAjjvcNJPJUao=
X-Received: by 2002:a67:f5c3:0:b0:439:5a25:2e39 with SMTP id
 t3-20020a67f5c3000000b004395a252e39mr502884vso.34.1685107898701; Fri, 26 May
 2023 06:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
 <ZGiWdQcR6Zq6Aw65@surfacebook> <9fa1a6e8-368a-3e22-aa84-8cad09f72a32@baylibre.com>
 <CAHp75Vf0hW6sMXeGSVXRVoW1mxFufWmbJNzt7_10xPj_k5SNkA@mail.gmail.com> <0cf870f1-8cdb-df74-79d6-a4004cdfcc2f@baylibre.com>
In-Reply-To: <0cf870f1-8cdb-df74-79d6-a4004cdfcc2f@baylibre.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 26 May 2023 15:31:27 +0200
Message-ID: <CAMRc=MfFASi0v-B3FRy=57_1hn46wwXJZ=b9Dzf0nM-4_Jo9aQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 11:09=E2=80=AFAM jerome Neanne <jneanne@baylibre.co=
m> wrote:
>
>
>
> On 22/05/2023 13:18, Andy Shevchenko wrote:
> > On Mon, May 22, 2023 at 10:47=E2=80=AFAM jerome Neanne <jneanne@baylibr=
e.com> wrote:
> >> On 20/05/2023 11:44, andy.shevchenko@gmail.com wrote:
> >>> Mon, May 15, 2023 at 05:36:46PM +0200, Bartosz Golaszewski kirjoitti:
> >>>> On Thu, May 11, 2023 at 4:09=E2=80=AFPM Jerome Neanne <jneanne@bayli=
bre.com> wrote:
> >
> > ...
> >
> >>>>> +       gpio->gpio_chip =3D tps65219_gpio_chip;
> >>>>
> >>>> Aren't you getting any warnings here about dropping the 'const' from
> >>>> the global structure?
> >>>
> >>> But this is a copy of the contents and not the simple pointer.
> >
> > I commented on Bart's question.
> >
> >> In many other places where this is done, the struct is declared like:
> >>
> >> static const struct gpio_chip template_chip =3D {
> >>
> >> After internal review, I changed this to:
> >>
> >> static const struct gpio_chip tps65219_gpio_chip =3D {
> >>
> >> This is because I didn't want to have this "template" that sounds to m=
e
> >> like "dummy". Maybe I misunderstood and this "template" was used on
> >> purpose because this const struct is just copied once to initialize
> >> tps65219_gpio->gpio_chip during probe.
> >>
> >> Introducing tps65219_gpio_chip name is maybe confusing with
> >> tps65219_gpio struct.
> >>
> >> I think the const should not be a problem here but the naming I used
> >> might be misleading. If you have a suggestion of what is a good practi=
ce
> >> to make this piece of code clearer. I'll follow your suggestion (use
> >> template? more_explicit name like ???).
> >
> > It's up to Bart.
> >
> Bart, should I keep the code like this or do you suggest a name change
> so that's it's more appealing?

Yes, I prefer it to be named something something template for clarity.

tps65219_template_chip would be great.

Bart
