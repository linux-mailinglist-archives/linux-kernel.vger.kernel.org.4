Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488606A070B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjBWLHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjBWLHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:07:22 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD754A13;
        Thu, 23 Feb 2023 03:06:55 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id f1so11574684qvx.13;
        Thu, 23 Feb 2023 03:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ7vDPLjJ4VXk//zkA9jWLslnKwxJvBeT6R5MRjaDbc=;
        b=kEscro6vEHJDfmpUYCN3NT+Ru5gx2LZPPD6WD5B+zkn6YwSReaVZYmPLIoFgvC80SH
         GMitZsPJrxwRTkg4Yzr6ckJfDVC2Mpw/L5JbXUODMk/37YnojpsytqFodY6TfdAuhWj8
         3yZ+/GT24PDxe4itSx2X27RITrkqthJpYFLMYLqfHBEBSaTYYqQxk5F88TZRrRjwu1va
         g1IyRu8EK90LVHKz9CqqfTjpDgrB+gtVTBLgHkT18BLnPKuu+nSxHi+OVUrhxRgDGsTP
         uNMHdtTmf6fQjpKda2Baee350m0UPEOz8LhpgcRu8TcEdMYhjH2vmiYwH4Qq1tv4ukz4
         btPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ7vDPLjJ4VXk//zkA9jWLslnKwxJvBeT6R5MRjaDbc=;
        b=7V/KLrTBBrV+sZbPTeSHLFu3zNsJl+bPkvCM8L6NHGOI49H1+g4cr7mx1uXRz5l13C
         2YL7wm47oIPF1vGT/Dt6UCdEkkmoNPD2pwJeVwpGmykqB/sRKyjgUIq3UEeRk/3tOf1Q
         x2Dlx8gNbBvLRwJ4Mh/q5mbNYuNk6d+5nXSxb+8HhqSrkhr1cFfK+x8bxgjg5xCVRuPt
         UAtWTftU8DY7Wdvb5G049E9WbXrun2UnoKBjlzoJQXjHagOPUmmKdxUc/GsxcN43XVZI
         5C+2QawsB2WhCdNqkXeHyWduZTxo4RIfpwZnVLY9Lp3vn4XAXeZqwISERBzXYufPeR/U
         f6Bg==
X-Gm-Message-State: AO0yUKVWOmhQEGmPaShVm7V4mn4gPgWZph7JNG4wHyWZnp9CvEjiywcc
        C+9FK70qUTW6Bb9xfsEXAfwT/8Zs/Bql0lWwHgNkFUaa/daAvQ==
X-Google-Smtp-Source: AK7set9gGwuSb5dhvncPsrYGsaRaMn+mon7HNF1esL8UBBEJEn8sDobopEdnFtMW2Q9y2saxaV6OnLsRyPtQQY1zses=
X-Received: by 2002:ad4:5588:0:b0:56e:9ad3:ab9c with SMTP id
 f8-20020ad45588000000b0056e9ad3ab9cmr1670481qvx.1.1677150412153; Thu, 23 Feb
 2023 03:06:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com> <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Feb 2023 13:06:15 +0200
Message-ID: <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 8:40 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

First of all, please, please, fix your email client!
It's so hard to distinguish my own words from yours.

> > +static const struct irq_chip gpio_mlxbf3_irqchip =3D {
> > +       .name =3D "MLNXBF33",
> > +       .irq_set_type =3D mlxbf3_gpio_irq_set_type,
> > +       .irq_enable =3D mlxbf3_gpio_irq_enable,
> > +       .irq_disable =3D mlxbf3_gpio_irq_disable, };
>
> Seems missing two things (dunno if bgpio_init() helps with that):
> - IMMUTABLE flag
> - actual calls to enable and disable IRQs for internal GPIO library usage
> See other drivers how it's done. There are even plenty of patches to enab=
le this thing separately.
>
> I saw that in other drivers only irq_enable and irq_disable are defined. =
Example in gpio-davinci.c:
> static struct irq_chip gpio_irqchip =3D {
> .name           =3D "GPIO",
> .irq_enable     =3D gpio_irq_enable,
> .irq_disable    =3D gpio_irq_disable,
> .irq_set_type   =3D gpio_irq_type,
> .flags          =3D IRQCHIP_SET_TYPE_MASKED,
> };
>
> Which I think is ok due to the following logic:
>
> gpiochip_add_irqchip calls
> gpiochip_set_irq_hooks which contains the following logic:
>
> if (irqchip->irq_disable) {
>                  gc->irq.irq_disable =3D irqchip->irq_disable;
>                  irqchip->irq_disable =3D gpiochip_irq_disable;
> } else {
>                  gc->irq.irq_mask =3D irqchip->irq_mask;
>                  irqchip->irq_mask =3D gpiochip_irq_mask;
> }
> if (irqchip->irq_enable) {
>                  gc->irq.irq_enable =3D irqchip->irq_enable;
>                  irqchip->irq_enable =3D gpiochip_irq_enable;
> } else {
>                  gc->irq.irq_unmask =3D irqchip->irq_unmask;
>                  irqchip->irq_unmask =3D gpiochip_irq_unmask;
> }

The chips have another flag there:

        .flags          =3D IRQCHIP_IMMUTABLE,
       GPIOCHIP_IRQ_RESOURCE_HELPERS,

> So it doesn=E2=80=99t seem like we need to define irq_mask/unmask if we h=
ave irq_enable/disable?
>
> > +       npins =3D MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
> > +       device_property_read_u32(dev, "npins", &npins);
>
> I don't see DT bindings for this property (being added in this series). I=
s it already established one?
>
> Ah that=E2=80=99s my bad. The property should be called "ngpios" like in =
the DT documentation. Will fix.

And why do you need it? What's a corner case that the GPIO library
doesn't handle yet?

--=20
With Best Regards,
Andy Shevchenko
