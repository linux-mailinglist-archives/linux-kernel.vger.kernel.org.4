Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B257064182A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 18:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLCRpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 12:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLCRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 12:45:15 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC741F2C1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 09:45:12 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id 125so7480076vsi.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBN3woypQP26GFXweXEKdf/II/Asy2wvLUhFeK5czLY=;
        b=jcjiWuqsARquelzM7hTj6CkRjUhpbPp4drn6npl40L9babTsHVcFcwycBrmMBVEoW5
         u5nlxCneDz+V8U0tEjtfDHpakEJ95rYv4MuXOE3vVKq+UpqrTUyU5aUqeeHX4H1S5M6E
         zTcza/wl73W6+vvYZKs3VgYspk/qTQeZILgkk9YMBEfDHstcF7SvI6NWjtQJDxOZ0nj2
         k7AQpwFIyZjBLzhfFf0QJfBGebLjGgFXs70/avvskvMkOprL/Z2II79puwVVKwkm9aq3
         R6zE0+0+q2B5wSNWXgxwSB31DvCCnFKuYeyLZwWyIDd0OkIwwnq13v5sTItaioL91o2X
         beVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBN3woypQP26GFXweXEKdf/II/Asy2wvLUhFeK5czLY=;
        b=L21/3J1XUG31YcF/ZBQ3J5mLkjGRqPkC7bTTq+CaEd9Dp7/Vlkc7v1EObRHtm5kjSm
         xDcEgA9vPgqkje0pmSNvreSBy5yZhpFyS73T/HooJxmgyyZSpGvIW8hYeixrgQWOx2Vm
         YFmr3f5XUz//Gjxcc8pr8f43TdNINc1PB0nEsveErGDsxZAKEAzk0YubVvEPO49EjAUz
         5uAHJeT2VFtr4uvSwfy5hvBjZ6JZIRJL+/3x0qFa5JhpTlljtGy9tG6Oc46DW5+qrr4O
         3N8DgNaJohAPJyRjaCAODS+xwfMis0Pl/UTyociBMyasbxs/7pTXwdUru7SrZiE8SebM
         Ytog==
X-Gm-Message-State: ANoB5pmOGRQETMudTMkdDexz4LhY32m/ha5qj+j7n/ZWKaAkAoFXTzTz
        ADnXxKhFdR7DMwe67LqInTmiAM5MGNTMaPwTFILhZA==
X-Google-Smtp-Source: AA0mqf4YFp0sgjU9KF2duJsJ04ARLjFFWA4mFeNY6LNCokCup+mhKE7qgJjbNDwvI5MaiETz6vjVxTNedajgbj7gmc0=
X-Received: by 2002:a67:ca86:0:b0:3b1:33bd:7fc7 with SMTP id
 a6-20020a67ca86000000b003b133bd7fc7mr747480vsl.13.1670089511955; Sat, 03 Dec
 2022 09:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20221201123220.7893-1-zhuyinbo@loongson.cn> <CACRpkdZm-4-5625szX_VqJoQH1OQZnw+jH3SqWsb9nr3S0Nbmw@mail.gmail.com>
 <35ff475a-e925-81eb-ffeb-448be43f59ff@loongson.cn> <Y4tq4i2CJdnQWFZC@smile.fi.intel.com>
 <Y4tuOyKOdZcQ4sjm@smile.fi.intel.com>
In-Reply-To: <Y4tuOyKOdZcQ4sjm@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 3 Dec 2022 18:45:01 +0100
Message-ID: <CAMRc=Me6PqGUJbE7vazwUho=Q0xYREziiytBrhT1CfHT_NOYxg@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] gpio: loongson: add gpio driver support
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 4:41 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, Dec 03, 2022 at 05:27:31PM +0200, Andy Shevchenko wrote:
> > On Sat, Dec 03, 2022 at 06:53:20PM +0800, Yinbo Zhu wrote:
> > > =E5=9C=A8 2022/12/3 18:03, Linus Walleij =E5=86=99=E9=81=93:
> > > > On Thu, Dec 1, 2022 at 1:33 PM Yinbo Zhu <zhuyinbo@loongson.cn> wro=
te:
> > > > > +config GPIO_LOONGSON_64BIT
> > > > > +       tristate "Loongson 64 bit GPIO support"
> > > > > +       depends on LOONGARCH || COMPILE_TEST
> > > > > +       select GPIO_GENERIC
> > > > > +       select GPIOLIB_IRQCHIP
> > > > If the kernelbots start complaining you might need to add a:
> > > >
> > > > select IRQ_DOMAIN_HIERARCHY
> > > >
> > > > here.
> > >
> > > Bartosz had merged my patch and I will add a change on top of the exi=
sting
> > > series.
> >
> > I don;'t know why he had done that, the driver requires a lot of cleanu=
ps,
> > e.g. why it uses acpi.h, what that "nice" container of the platform dev=
ice for.
>
> + we have macros for get_direction() returned values and so on.
>

You'll have the chance to review Yinbo's patches Andy because the
driver fails to build with current next. I didn't notice the code
references of_nodes even though they're gone now from struct
gpio_chip. I need to back it out and let's get back to it for the next
release.

Bartosz
