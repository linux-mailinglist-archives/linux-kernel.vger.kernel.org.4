Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635B1731A97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbjFON5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbjFON5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:57:06 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91842D65;
        Thu, 15 Jun 2023 06:56:30 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62fe192f7d3so15696786d6.3;
        Thu, 15 Jun 2023 06:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686837389; x=1689429389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tbFxV0ES/OznLa3QmlMD6yaqCsP95A8qSLkUV9gcRA=;
        b=T+GKvtK9J4PYGDVV9IyI7VuGpA83q+zS9pA3HCEB/3b9WWYBpxYgvcr9gUm5YaonwJ
         vJ2Qfb+O3rsa/PaUGQmIYSC9Fyz/uczVqYWCYLAk46aAjpk4AxtIW0j7WIYs0hW2kq9h
         65uowTa7TtzQGkvCayN+/WCnSDevqTs+nYChhx95TX/AaiBeBh9nsH9Kukwud4Ub12Su
         z/Mlvu2+mqAiE40bZ5iWZNM8NyTR33MrJGv0G2+Sg2YrRUhIYaK5mRCczqmo2ZaTkDBm
         bDgyJAVAsa1+/ZRcB9COnL2L3Hhe2HRj2IxLWGgZ1uuNAFQ0pRSPXbw0oGdc6DAeglCa
         +gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837389; x=1689429389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tbFxV0ES/OznLa3QmlMD6yaqCsP95A8qSLkUV9gcRA=;
        b=dy8PtoIu8Y2g10OdvhpYCfco3tgnxw+nUMvWmYrTpg3HKM+DaqwdMtv3kH7M0fOsY1
         cZd8ZqwYl+2i8Ao6TZdVZMXaGLBZxHXVJu9mcc+Ardu+68lUPHdQt4ejY/tgKM86N2Jg
         f4ANK4wnHvqC4bExdoprqEmRihHQL/hMhCZxmRMrvL1gNJFRMDTgucJIMWfbyMwiNFGE
         OrdUiIxRs0QeovXpprHzPQgPCl8OHp1FCbTbs8yoY6arcWyASZ+xRBcj/SlURGP22E3R
         +UVSbqMszG/FQ1IQisfmbGXqRGnfZLwjbyUPMQ13GNzzUDcncs8UFPICU74r18WyWdby
         pCCA==
X-Gm-Message-State: AC+VfDxb+THnL6RGjB/eeMD/c8l2rcbVs7R+hzG8OIwEV7ufICI5UTFd
        Jyen6vhrqiH1wuvUoXjcz4lWK4oa9WYSjl1PMkA=
X-Google-Smtp-Source: ACHHUZ5WJI2ksUR6caTa+UiQWq5OfkKZ4UBRHYWnZ86IJG42vXYJ2W30gGNCOpzt5k5dsLR8KOtXYmVQEmwAG1w2ZW0=
X-Received: by 2002:a05:6214:29ef:b0:626:1637:f58c with SMTP id
 jv15-20020a05621429ef00b006261637f58cmr21335345qvb.30.1686837389181; Thu, 15
 Jun 2023 06:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230607081803.778223-1-jiawenwu@trustnetic.com>
 <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com>
 <15e2fc098a1e63317368f4812290ca35@walle.cc> <010401d99f6f$26d41600$747c4200$@trustnetic.com>
 <b9af98d801d2808de3460c9e4fec8bdd@walle.cc>
In-Reply-To: <b9af98d801d2808de3460c9e4fec8bdd@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jun 2023 16:55:52 +0300
Message-ID: <CAHp75VcgAhaSARXMnRzsDE3x57AjnwS6Ep25Mz7SnizUccG6BA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
To:     Michael Walle <michael@walle.cc>
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, shreeya.patel@collabora.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 15, 2023 at 1:45=E2=80=AFPM Michael Walle <michael@walle.cc> wr=
ote:
> > BTW, I wonder if it has problems when unregistering gpio-regmap.
> > Call Trace of irq_domain_remove() always exits in my test:
> > https://lore.kernel.org/all/011c01d98d3d$99e6c6e0$cdb454a0$@trustnetic.=
com/
> >
> > Of course, it could be because there was something wrong with my
> > test code. But I want to be clear about this.
>
> Mh, you've said you don't use the devm_ variant of
> regmap_add_irq_chip(),
> correct? Do you call regmap_del_irq_chip() yourself?
>
> It seems that gpiolib is already removing the domain itself. Mh.
> I guess if the the domain is set via gpiochip_irqchip_add_domain()
> gpiolib must not call irq_domain_remove() because the domain resource
> is handled externally (i.e. gpiolib doesn't allocate the domain
> itself) in our case.
>
> Nice finding! Looks like it has been broken since the beginning
> when I've introduced the gpiochip_irqchip_add_domain(). Will you
> do another fixes patch for that? I'm not sure where to store
> that information though. Maybe a new bool "no_domain_free"
> in struct gpio_irq_chip?

While reading this I also thought about flag, but please use positive
notation, e.g. "irq_domain_is_ext".

--=20
With Best Regards,
Andy Shevchenko
