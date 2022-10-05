Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1781E5F55C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJENpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJENpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:45:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C712092
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:45:01 -0700 (PDT)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3B2D7413E6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664977500;
        bh=vHvbLZZalRRqCku7hn7wW+CT1JrQH9C5FZAMYitv8cE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=IjlX18RQfeQpc8eTGJVMDivoeM+biZRXXMWY13brtLnI6l1h2EEHKycRzQIESIleq
         rmAJZgN3/ZsVNUXF9EWOZnxrO3+MPe8rsh+GFBUo74rpyqcAUi7vuyUCpYZ49VhxIa
         nr7R/OLNXHe5gOKZwJI6XyC1ngYchbg20MoKlgpc18Q03U6Z+1OQlmrVz/jX13UKON
         puRp9ersriVDTpwEhsXNZMlcjwdtdhGRbxDPAlwrmElNwnBkwNUxqPeKP/ubXME92v
         Nkb7rjNNppqc8nHv7R8eif/etxVqm9YYA5Zl5MhPuoHpab9JIL4QbGEogR6sTbaruZ
         df0lCoP6aossw==
Received: by mail-qv1-f69.google.com with SMTP id ks15-20020a056214310f00b004b18ea4bc05so4891784qvb.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 06:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vHvbLZZalRRqCku7hn7wW+CT1JrQH9C5FZAMYitv8cE=;
        b=qi5mC3EWqRnUu1bVFlTqmstwIb8w1lYBE6W3fBTwxYNFEtssibvgdKg08/zYzon8Cn
         s2YymWeC0gbyVaVAG9xVhmJ/3E8cDLC6CdMm7JDt3yYcKwdZnpi5hDy/yRdMDFIQgUDk
         PiJCIlDlG18wS8FkrGjpZ3R8i1e/l2JPVygtB+wWZ5krxiSxXT6DFsQWF3Vp0L4a+zCR
         3wt4RqF1uLinmGSIqEglt5pHB7bmAzuJ8zOtzHt2t6JsQy/9n5pPXm0p5FrINdVZKjXV
         kOJGBhaB2c6eIE3nHuPJkFv8jMLEVJ6EhJ/xpuZ812+j8rJxP5jl9At9hiibd9LlFNDQ
         sJOQ==
X-Gm-Message-State: ACrzQf0eREmB7pxuggKmyzcEvijAjdRPE2TR4pEtE7w1nX3+6BHmbbvd
        w8lXHIOdadwK8k9e4IM+FIxSLgyolw7uKaXgMepqwy7DDjLxIFlsCyS+mCiPDEioWKP3PyWniIN
        VYytVeRHzSYyaMhhJbDtSghwUSdkNs+53x3iBGk2q4+KQ4A/nFlFz+d4O/Q==
X-Received: by 2002:a05:620a:3729:b0:6ce:4711:8137 with SMTP id de41-20020a05620a372900b006ce47118137mr19887909qkb.720.1664977499253;
        Wed, 05 Oct 2022 06:44:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5iRopqmvzesAPcWETTAmBahzPyLHdQHBWSaylF00li/lAnce3mJQiy71AFp3W6dMQuOJaFi94GvW8lzUw0y5Y=
X-Received: by 2002:a05:620a:3729:b0:6ce:4711:8137 with SMTP id
 de41-20020a05620a372900b006ce47118137mr19887889qkb.720.1664977499036; Wed, 05
 Oct 2022 06:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929143225.17907-6-hal.feng@linux.starfivetech.com> <40d0abb6-88dc-d315-f768-27a623f60986@sifive.com>
In-Reply-To: <40d0abb6-88dc-d315-f768-27a623f60986@sifive.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 5 Oct 2022 15:44:43 +0200
Message-ID: <CAJM55Z-PzvM_-_6jTWX+Jyy2FQ3TJdh4uYj0evpktnEENHL6WA@mail.gmail.com>
Subject: Re: [PATCH v1 05/30] soc: sifive: l2 cache: Convert to platform driver
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 19:59, Ben Dooks <ben.dooks@sifive.com> wrote:
>
> On 29/09/2022 15:32, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >
> > This converts the driver to use the builtin_platform_driver_probe macro
> > to initialize the driver. This macro ends up calling device_initcall as
> > was used previously, but also allocates a platform device which gives us
> > access to much nicer APIs such as platform_ioremap_resource,
> > platform_get_irq and dev_err_probe.
>
> This is useful, but also there are other changes currently being sorted
> out by Zong Li (cc'd into this message) which have already been reviewed
> and are hopefully queued for the next kernel release.
>
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>

I'm ok with something like this being merged, but please note that if
we ever want to support the JH7100 which uses registers in this
peripheral to flush the cache for its non-coherent DMAs then this
driver needs to be loaded before other peripherals or we will trigger
the 2nd warning in arch/riscv/mm/dma-noncoherent.c. I'm not sure we
can do that when it's a platform driver. See this patch for an
alternative to support the JH71x0s:
https://github.com/esmil/linux/commit/9c5b29da56ae29159c9572c5bb195fe3a1b535c5

/Emil

> >   drivers/soc/sifive/sifive_l2_cache.c | 79 ++++++++++++++--------------
> >   1 file changed, 40 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
> > index 59640a1d0b28..010d612f7420 100644
> > --- a/drivers/soc/sifive/sifive_l2_cache.c
> > +++ b/drivers/soc/sifive/sifive_l2_cache.c
> > @@ -7,9 +7,9 @@
> >    */
> >   #include <linux/debugfs.h>
> >   #include <linux/interrupt.h>
> > -#include <linux/of_irq.h>
> > -#include <linux/of_address.h>
> > -#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> >   #include <asm/cacheinfo.h>
> >   #include <soc/sifive/sifive_l2_cache.h>
> >
> > @@ -96,12 +96,6 @@ static void l2_config_read(void)
> >       pr_info("L2CACHE: Index of the largest way enabled: %d\n", regval);
> >   }
> >
> > -static const struct of_device_id sifive_l2_ids[] = {
> > -     { .compatible = "sifive,fu540-c000-ccache" },
> > -     { .compatible = "sifive,fu740-c000-ccache" },
> > -     { /* end of table */ },
> > -};
> > -
> >   static ATOMIC_NOTIFIER_HEAD(l2_err_chain);
> >
> >   int register_sifive_l2_error_notifier(struct notifier_block *nb)
> > @@ -192,36 +186,29 @@ static irqreturn_t l2_int_handler(int irq, void *device)
> >       return IRQ_HANDLED;
> >   }
> >
> > -static int __init sifive_l2_init(void)
> > +static int __init sifive_l2_probe(struct platform_device *pdev)
> >   {
> > -     struct device_node *np;
> > -     struct resource res;
> > -     int i, rc, intr_num;
> > -
> > -     np = of_find_matching_node(NULL, sifive_l2_ids);
> > -     if (!np)
> > -             return -ENODEV;
> > -
> > -     if (of_address_to_resource(np, 0, &res))
> > -             return -ENODEV;
> > -
> > -     l2_base = ioremap(res.start, resource_size(&res));
> > -     if (!l2_base)
> > -             return -ENOMEM;
> > -
> > -     intr_num = of_property_count_u32_elems(np, "interrupts");
> > -     if (!intr_num) {
> > -             pr_err("L2CACHE: no interrupts property\n");
> > -             return -ENODEV;
> > -     }
> > -
> > -     for (i = 0; i < intr_num; i++) {
> > -             g_irq[i] = irq_of_parse_and_map(np, i);
> > -             rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
> > -             if (rc) {
> > -                     pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
> > -                     return rc;
> > -             }
> > +     struct device *dev = &pdev->dev;
> > +     int nirqs;
> > +     int ret;
> > +     int i;
> > +
> > +     l2_base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(l2_base))
> > +             return PTR_ERR(l2_base);
> > +
> > +     nirqs = platform_irq_count(pdev);
> > +     if (nirqs <= 0)
> > +             return dev_err_probe(dev, -ENODEV, "no interrupts\n");
>
> I wonder if zero irqs is an actual issue here?
>
> > +     for (i = 0; i < nirqs; i++) {
> > +             g_irq[i] = platform_get_irq(pdev, i);
>
> I wonder if we need to keep g_irq[] around now? Is it going to be useful
> in the future?
>
> > +             if (g_irq[i] < 0)
> > +                     return g_irq[i];
> > +
> > +             ret = devm_request_irq(dev, g_irq[i], l2_int_handler, 0, pdev->name, NULL);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret, "Could not request IRQ %d\n", g_irq[i]);
> >       }
> >
> >       l2_config_read();
> > @@ -234,4 +221,18 @@ static int __init sifive_l2_init(void)
> >   #endif
> >       return 0;
> >   }
> > -device_initcall(sifive_l2_init);
> > +
> > +static const struct of_device_id sifive_l2_match[] = {
> > +     { .compatible = "sifive,fu540-c000-ccache" },
> > +     { .compatible = "sifive,fu740-c000-ccache" },
> > +     { /* sentinel */ }
> > +};
> > +
> > +static struct platform_driver sifive_l2_driver = {
> > +     .driver = {
> > +             .name = "sifive_l2_cache",
> > +             .of_match_table = sifive_l2_match,
> > +             .suppress_bind_attrs = true,
> > +     },
> > +};
> > +builtin_platform_driver_probe(sifive_l2_driver, sifive_l2_probe);
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
