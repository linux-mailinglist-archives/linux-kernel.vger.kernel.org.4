Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F463748C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiKXIzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKXIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:54:57 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29A10CE94
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:54:56 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 189so446121ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8R3F5kALGt7fZIFbbdQLZusILmf2AipY3tz1OkoyZg=;
        b=BoTT++1ZJhXWkMbqvMW/FRK8+Jp2xAbHiq27Xk1WEsyCZ7YGMXSoiYjXndFPTgLW3E
         Ak39gt1gk7HkJXwvl1ze3jPLtMdIGBkXI3TD6mJazIm5soc2L/KIXoktqhUnYB7k3AQO
         KG1FZND6mzdGbeZJcgp5NydoulbO1aJlSobDLYBYcFhiuvo+RXDBHhq4BJZm3yE8BZgN
         I5G/E5r2fLHt1x+F6ZSSRS9XeYFfiCEbobbo8jrrucKv3IHG/S65AHc3Onjwy2SWLsNy
         VHQs63G8Pxalw2RYjcDYGG1XwzMT0fcZaklDmBMHeJGkteMnQ8zmkk6t27JTibOCODaC
         H84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8R3F5kALGt7fZIFbbdQLZusILmf2AipY3tz1OkoyZg=;
        b=bcbkb3f9aK4l5m0Gp+D9SYgUWY/5tqxXcJ6gRFnCfcDDUNkxVunuonLTUEFvgzPx3j
         VsHa7NaPkvENwCFYAvopS810RyLahjjwnpjLRjBo6/y18S/FlcYvFG08mbpsGD7oFwML
         Nz7x9AUnEnOIJM+H+HgcoV8/5kKD20IerWLKZw66NEATypXw+tEbxKPmt8bhAAQMBB91
         uWbEuD/l73OS2pyfyc3ClWqmP+sfpSiYkkRSCyv/g/wLK/VMrKGLhqwf/SfwKzXfJJ7q
         9wYu4Hbjf3OSJ/ziPwO2AFPZnnOG+bslApuL+G0gM/XsG1UHQDb3o65bwhetzdJqzEo0
         vEiA==
X-Gm-Message-State: ANoB5plOu5gFkioAUEXx4gHSBj0PdWpcB774Nv/rl42LSL1JlXadqNSX
        KIKr5wpk1myv7FcrdFqkeW2o0q48fFK/11kKw0jc6A==
X-Google-Smtp-Source: AA0mqf7HBKYpljZej6bXe7Ojnqxlh65R7Qj4zpxpnR7ZPi1/Wnuyt44OyTeMDenQUWF4/SbRV3buTCxQI4MkWFzQ1DI=
X-Received: by 2002:a25:d8d4:0:b0:6f0:36e2:5fc2 with SMTP id
 p203-20020a25d8d4000000b006f036e25fc2mr5552927ybg.52.1669280095520; Thu, 24
 Nov 2022 00:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20221121123803.3786-1-zhuyinbo@loongson.cn> <20221121123803.3786-2-zhuyinbo@loongson.cn>
 <CACRpkda1adiNwbTZHdAyHKny3r5FFMP_XXVGbo1vnCdw9U1gNg@mail.gmail.com>
 <8a7abd77-9540-efa8-6f67-908530e85399@loongson.cn> <CACRpkdb=wdydOYCcrpjLSyvfVO--_ezXsFQ46qwfVCiiTd5fNw@mail.gmail.com>
 <4c02570e-03d5-85f1-73fb-b66d6170c875@loongson.cn>
In-Reply-To: <4c02570e-03d5-85f1-73fb-b66d6170c875@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Nov 2022 09:54:43 +0100
Message-ID: <CACRpkdbgP9m40t_Ky4H+SQi9TELikomT2M-JpF7+auKmzOxQdg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] gpio: loongson: add gpio driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 3:22 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> =E5=9C=A8 2022/11/24 =E4=B8=8A=E5=8D=886:05, Linus Walleij =E5=86=99=E9=
=81=93:

> > But these drivers can not rely on the .gpio_to_irq() callback
> > to be called before an IRQ is requested and used.
>
> I may not have made it clear before that the gpio irq chip for other
> platforms may need to be implemented, but the loongson platform may be
> special.
>
> I mean that the loongson platform use gpio irq does not need to rely on
> gpio_to_irq, because loongson interrupt controller driver has covered
> gpio irq.  The specific reason is my above explanation.
>
> so, Can I not realize gpio irq chip?

Isn't this a hierarchical irqchip then?

Please consult the following from
Documentation/driver-api/gpio/driver.rst:

---------------------------------

GPIO drivers providing IRQs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

It is custom that GPIO drivers (GPIO chips) are also providing interrupts,
most often cascaded off a parent interrupt controller, and in some special
cases the GPIO logic is melded with a SoC's primary interrupt controller.

The IRQ portions of the GPIO block are implemented using an irq_chip, using
the header <linux/irq.h>. So this combined driver is utilizing two sub-
systems simultaneously: gpio and irq.

It is legal for any IRQ consumer to request an IRQ from any irqchip even if=
 it
is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
irq_chip are orthogonal, and offering their services independent of each
other.

gpiod_to_irq() is just a convenience function to figure out the IRQ for a
certain GPIO line and should not be relied upon to have been called before
the IRQ is used.

Always prepare the hardware and make it ready for action in respective
callbacks from the GPIO and irq_chip APIs. Do not rely on gpiod_to_irq() ha=
ving
been called first.

We can divide GPIO irqchips in two broad categories:

- CASCADED INTERRUPT CHIPS: this means that the GPIO chip has one common
  interrupt output line, which is triggered by any enabled GPIO line on tha=
t
  chip. The interrupt output line will then be routed to an parent interrup=
t
  controller one level up, in the most simple case the systems primary
  interrupt controller. This is modeled by an irqchip that will inspect bit=
s
  inside the GPIO controller to figure out which line fired it. The irqchip
  part of the driver needs to inspect registers to figure this out and it
  will likely also need to acknowledge that it is handling the interrupt
  by clearing some bit (sometime implicitly, by just reading a status
  register) and it will often need to set up the configuration such as
  edge sensitivity (rising or falling edge, or high/low level interrupt for
  example).

- HIERARCHICAL INTERRUPT CHIPS: this means that each GPIO line has a dedica=
ted
  irq line to a parent interrupt controller one level up. There is no need
  to inquire the GPIO hardware to figure out which line has fired, but it
  may still be necessary to acknowledge the interrupt and set up configurat=
ion
  such as edge sensitivity.

---------------------------------

You find an example of a hierarchical GPIO irqchip using the
GPIOLIB_IRQCHIP in drivers/gpio/gpio-ixp4xx.c.

Yours,
Linus Walleij
