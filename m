Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6D7196DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjFAJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjFAJZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:25:20 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E611F;
        Thu,  1 Jun 2023 02:25:19 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-626190df842so8096216d6.0;
        Thu, 01 Jun 2023 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685611518; x=1688203518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dzr0sXs/hmoLYt4Nl0MgN1apN4fZADrfHPGpIhvTR6I=;
        b=fXcUBky3xVq7/nHzFuvrCdhn1kEZ9DUp1DPAvmxeuqp2bl6bXecWRh9wLDfpaaHKxC
         WXVr1hkYof/ue5l8CLZzFwJmODcpG3vt+lJynLaIcJzL6LMtnpYOsr3R+zCntlud7xcZ
         N3hEO+sQMxvtpFpKJajYXy8Kw/TgYz8iPuvd5DDxhaAyxm2iFouNlfLWBc3BYwMp7d9H
         Hd6z8O/VQ0cufGwePwf86fVHUuJkjAfG2FH+v7BlKc4PMi++t3DTegO964/k/JnrdTTv
         ktSg7ivDKikHn2wESyUSErvqaGd+DU8/uSyY81f5ge+0lU3ILslolBjykCUFEp3a9ndg
         Kfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611518; x=1688203518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dzr0sXs/hmoLYt4Nl0MgN1apN4fZADrfHPGpIhvTR6I=;
        b=hCuvduUD8T9sq6fLVp9MEN1qGe7J08yhyLf3qnjmqFrMhAc3BtPz57paOaBIiaSolf
         IrW5iX1vHPvovvhrJ/1bPhL3XFasHNgIM08yS6aXo6v944livw+O6WJ5M9PPLNDzf9Ku
         cfzOz70OJLk48wL4KH22itl5ITGv4vQyKFQK5PU9mB+iLiCkpRl2GhJt+DwhdsNGJbus
         TSXqivS7x2BXfQ+in+4vnUvNB89tsbjDw3JmQ6JAcU5d2xfHTCzQiE3YVMhwrMePRQoN
         Pj77IuWgIS/QFL1yRf/9eRZRfbUO2RX2QAFyhl+Bulgh/hu4F9mptMlImumqV7qRNVw4
         0klA==
X-Gm-Message-State: AC+VfDy4yNI4s6+oJPOPoSlXgfWtOc+3EjXJK6/uc3r1Kbns67bfK5cJ
        myWWgXbuNbQwHg3qi8RQX7A6DatZGOVncOTVVdI=
X-Google-Smtp-Source: ACHHUZ5Ib5cta5bQfcho3pVqSqgpqkYTgu4VQXTg9s5YdPIUDBkI01TFMD70U0ZrMZDdCHYrLFEJgZAHJnaY60MbLsQ=
X-Received: by 2002:a05:6214:485:b0:625:b72a:142c with SMTP id
 pt5-20020a056214048500b00625b72a142cmr11229290qvb.14.1685611518304; Thu, 01
 Jun 2023 02:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230529140711.896830-1-hugo@hugovil.com> <20230529140711.896830-8-hugo@hugovil.com>
 <ZHUpWQafRPHW1RJQ@surfacebook> <20230530113649.73f28b9f6ba91f17ace1e12f@hugovil.com>
 <CAHp75Vf35rN93sXFBU0nRZQLpUgQHR2caGC8BmHkEgPZqF=dQg@mail.gmail.com> <20230531195723.462b140ac041b790711c1a7f@hugovil.com>
In-Reply-To: <20230531195723.462b140ac041b790711c1a7f@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Jun 2023 12:24:42 +0300
Message-ID: <CAHp75VcNihyzn3t8C48w1V+WWRk_zj8Br7shTfbHLU09u4OtcA@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] serial: sc16is7xx: fix regression with GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
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

On Thu, Jun 1, 2023 at 2:57=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Wed, 31 May 2023 00:56:57 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, May 30, 2023 at 6:36=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.c=
om> wrote:
> > > On Tue, 30 May 2023 01:38:17 +0300
> > > andy.shevchenko@gmail.com wrote:
> > > > Mon, May 29, 2023 at 10:07:09AM -0400, Hugo Villeneuve kirjoitti:

...

> > > > > +           of_property_for_each_u32(dev->of_node, "nxp,modem-con=
trol-line-ports",
> > > > > +                                    prop, p, u) {
> > > > > +                   if (u >=3D devtype->nr_uart)
> > > > > +                           continue;
> > > > > +
> > > > > +                   /* Use GPIO lines as modem control lines */
> > > > > +                   if (u =3D=3D 0)
> > > > > +                           mctrl_mask |=3D SC16IS7XX_IOCONTROL_M=
ODEM_A_BIT;
> > > > > +                   else if (u =3D=3D 1)
> > > > > +                           mctrl_mask |=3D SC16IS7XX_IOCONTROL_M=
ODEM_B_BIT;
> > > > > +           }
> > > >
> > > > Can we use device properties, please?
> > >
> > > I have converted this section to use device_property_count_u32() and =
device_property_read_u32_array(). Is that Ok?
> >
> > Yes, thank you!
>
> Hi Andy,
> now that I am using the device property API, I think I no longer have the=
 need to test for "if (dev->of_node)" before reading the new property "nxp,=
modem-control-line-ports"?
>
> If that is the case, I will leave the test "if (dev->of_node)" only for t=
he "irda-mode-ports" property.
>
> The pseudo code woulk look like this:
>
>         if (dev->of_node) {
>                 struct property *prop;
>                 const __be32 *p;
>                 u32 u;
>
>                 of_property_for_each_u32(dev->of_node, "irda-mode-ports",
>                                          prop, p, u)
>                         if (u < devtype->nr_uart)
>                                 s->p[u].irda_mode =3D true;
>         }
>
>         /* Read "nxp,modem-control-line-ports" using device property API.=
 */
>         sc16is7xx_setup_mctrl_ports(dev);

Looks good to me, thank you for following the advice!

--=20
With Best Regards,
Andy Shevchenko
