Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286B8735754
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFSMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjFSMva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:51:30 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DE11D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:50:59 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4714e9f07c0so675638e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687179057; x=1689771057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfY/cMV1kSoh4jJCVq6A3OC4e8p5nxJbjvuA8FEmXFc=;
        b=Ik7UwrWxsZjDSy0TQ+KMYzt7Fx4Rq4vPjhEdse5A8omaW64LC6Zy/deHmre6uqc/xl
         RWqL3JsgFLSUl7qLLTzSapl1OWWUp3TjhQKl+0UIIrLB3l3CNZUiWovTzIbE4ZkhywJy
         3u955i/V9hpo67No6jUzKkd2y5Lba9OyprJ/mXoGDLO+Tt2BJl6xacq6X5pAkF5aCKuR
         SBwhAWduQYTdN7m2lnz1nShjSKQFHLNIBkc7SadjqC7KrDRdW7D6O4Cj+zYFzaUGl0Pw
         UaQmeiv2XnUBvvsen3ahsbl2QkEJw2+kmy/l0p4uA05kR1+Pkkk6oqqmFlepjgxwD3Da
         qAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179057; x=1689771057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfY/cMV1kSoh4jJCVq6A3OC4e8p5nxJbjvuA8FEmXFc=;
        b=TniWtZ0hr/lL91ZUnOWYTvY3wzJFS0LWcpUqDi9riN5NdwCW9DoOQspebjsG41TFwo
         hr/ClOxz8YRFm0UQsrR8r4sZ/eaGrRsssWOPsaPqNlj3FfPgXUgtOgHFHwy48iLW5lc9
         OpDNf9UxaXZEnWE5GEcyp0IM5rYaZFU1tHWqOl+ftIWoTmCHnNqM0Ap5RdOOtyo3ZLOw
         hwQA0k0fS7c7Qjsx088jA25WYAsVjeOIpIAbhrjGJQHnzyfzGX3HsV9uJtN5pKiq2z2G
         1rZvFlT0v4bLleZFULR7awgFEpPyuq9wd40xGdRrOVnBWGLhChBnSIjJbWpina495XXC
         WPiQ==
X-Gm-Message-State: AC+VfDxd/qVx25jBSP+lmLKw4uwUXxh+o59aDYwjUgKFeEBL/NpAYyUQ
        SnVdEueD6RNpp2AqlO+dc0YWY95tI562n9O29QUiSw==
X-Google-Smtp-Source: ACHHUZ5NsUIDEPsYrN8wQ6Yuf4yj6GuoNAs/ilo/4wBak5PZc4UoexDuwdbuT71N24hJweq6OUX51OPpP7TaosgpbRM=
X-Received: by 2002:a1f:c1cf:0:b0:471:4c5b:7a62 with SMTP id
 r198-20020a1fc1cf000000b004714c5b7a62mr1390971vkf.2.1687179057467; Mon, 19
 Jun 2023 05:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230616145036.3910153-1-arnd@kernel.org>
In-Reply-To: <20230616145036.3910153-1-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Jun 2023 14:50:46 +0200
Message-ID: <CAMRc=MfVtNgRPHcceSW-ZsTuUmvGWw2tr4qD6YzwtoYO+KDvGA@mail.gmail.com>
Subject: Re: [PATCH] gpio: synq: remove unused zynq_gpio_irq_reqres/zynq_gpio_irq_relres
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 16, 2023 at 4:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver now uses the generic request/release callbacks, so the custom
> ones are no longer called. When building with -Woverride-init, gcc produc=
es
> a warning about the duplicate entries:
>
> In file included from drivers/gpio/gpio-zynq.c:10:
> include/linux/gpio/driver.h:621:43: error: initialized field overwritten =
[-Werror=3Doverride-init]
>   621 |                 .irq_request_resources  =3D gpiochip_irq_reqres, =
         \
>       |                                           ^~~~~~~~~~~~~~~~~~~
> drivers/gpio/gpio-zynq.c:611:9: note: in expansion of macro 'GPIOCHIP_IRQ=
_RESOURCE_HELPERS'
>   611 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/gpio/driver.h:621:43: note: (near initialization for 'zynq_=
gpio_level_irqchip.irq_request_resources')
>   621 |                 .irq_request_resources  =3D gpiochip_irq_reqres, =
         \
>       |                                           ^~~~~~~~~~~~~~~~~~~
> drivers/gpio/gpio-zynq.c:625:9: note: in expansion of macro 'GPIOCHIP_IRQ=
_RESOURCE_HELPERS'
>   625 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/gpio/driver.h:622:43: error: initialized field overwritten =
[-Werror=3Doverride-init]
>   622 |                 .irq_release_resources  =3D gpiochip_irq_relres
>       |                                           ^~~~~~~~~~~~~~~~~~~
>
> Removing the old ones has no effect on the driver but avoids the warnings=
.
>
> Fixes: f569143935378 ("gpio: zynq: fix zynqmp_gpio not an immutable chip =
warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/gpio-zynq.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
> index c334e46033bae..0a7264aabe488 100644
> --- a/drivers/gpio/gpio-zynq.c
> +++ b/drivers/gpio/gpio-zynq.c
> @@ -575,26 +575,6 @@ static int zynq_gpio_set_wake(struct irq_data *data,=
 unsigned int on)
>         return 0;
>  }
>
> -static int zynq_gpio_irq_reqres(struct irq_data *d)
> -{
> -       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> -       int ret;
> -
> -       ret =3D pm_runtime_resume_and_get(chip->parent);
> -       if (ret < 0)
> -               return ret;
> -
> -       return gpiochip_reqres_irq(chip, d->hwirq);
> -}
> -
> -static void zynq_gpio_irq_relres(struct irq_data *d)
> -{
> -       struct gpio_chip *chip =3D irq_data_get_irq_chip_data(d);
> -
> -       gpiochip_relres_irq(chip, d->hwirq);
> -       pm_runtime_put(chip->parent);
> -}
> -
>  /* irq chip descriptor */
>  static const struct irq_chip zynq_gpio_level_irqchip =3D {
>         .name           =3D DRIVER_NAME,
> @@ -604,8 +584,6 @@ static const struct irq_chip zynq_gpio_level_irqchip =
=3D {
>         .irq_unmask     =3D zynq_gpio_irq_unmask,
>         .irq_set_type   =3D zynq_gpio_set_irq_type,
>         .irq_set_wake   =3D zynq_gpio_set_wake,
> -       .irq_request_resources =3D zynq_gpio_irq_reqres,
> -       .irq_release_resources =3D zynq_gpio_irq_relres,
>         .flags          =3D IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED=
 |
>                           IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
>         GPIOCHIP_IRQ_RESOURCE_HELPERS,
> @@ -619,8 +597,6 @@ static const struct irq_chip zynq_gpio_edge_irqchip =
=3D {
>         .irq_unmask     =3D zynq_gpio_irq_unmask,
>         .irq_set_type   =3D zynq_gpio_set_irq_type,
>         .irq_set_wake   =3D zynq_gpio_set_wake,
> -       .irq_request_resources =3D zynq_gpio_irq_reqres,
> -       .irq_release_resources =3D zynq_gpio_irq_relres,
>         .flags          =3D IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
>         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>  };
> --
> 2.39.2
>

Applied, thanks!

Bart
