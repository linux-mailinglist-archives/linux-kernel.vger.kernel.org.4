Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E65B3B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiIIPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIIPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:09:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1B1AF16;
        Fri,  9 Sep 2022 08:09:38 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d17so595051qko.13;
        Fri, 09 Sep 2022 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kaFPBUf4reqnwAOmfokIZJzxD8zlP8lwl9LL+XYnMGs=;
        b=hI0i/l6Q0yYDBIk2cx08MVKnp5sMxvbbN8S5MhN9V4ym0rCcw78C9p/zDH2WA8B0/x
         ZzbG89Tt+DNGM7yWYbE79aoKWf6FbMC3kckjeWTu/4zNhcVCGyOV6v5eX5Ve3rPYillJ
         oGjp8mYG+JeSJy+za6ViZBN/qn50zUtbvbyYuQSFKiaU53n5b+K0sYL/ho4j57NRIu4p
         VJmTF7MA5dVaaGAj1in3kS6q+HvjcPwmxQyDBaALo/fITa+dFk8BfxcGXfRUryrT/B9G
         DioIlHgq/AdwRpQwxn+nKHlGof7WyXz3cXICRVQZHAD4qcffSKNTJf3Izfr2dPV1Ik/O
         DuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kaFPBUf4reqnwAOmfokIZJzxD8zlP8lwl9LL+XYnMGs=;
        b=6arfXUzhrk07YOh3FzIksJ+5Eym4Ki5HNn8mw6NsgIWjPcvWxPcheo2+DUiEoq1yPS
         1/INEbWJJHwXYNbnxu3BmQFGGfcXaQRW7cX/mztloF2LpOBH8HbDNaEr7QMv4G9gdFk3
         MInUSWy4jCeTG/cPeYgQtilCzwYVh4dCxg/4K4qA79AdnlQMFkqzBhbSfEONRmk/Pjli
         +21wY9XKGMyMVUY3i7OKEcmMdOl2x8kIOZD+v7rnHLrGrkPpZgkvDK7YhNsT6MKOq9Mh
         NEv/p5JLriKzTKs1wmwiJr+DXpy2z32o8P5u/UkyFXKxsCemQtiT1WU7J9cHeGbZWMdW
         +UOA==
X-Gm-Message-State: ACgBeo3P3l48fDtxz7KqnC0lbF+J3wIOk/fanN6fVXvZZv1V+MLvcd/c
        yYa6PkOtCbdb3NhKWgNpr8qHmoxtH96VZDwSm/yhsFpP4dFNYg==
X-Google-Smtp-Source: AA6agR70yy2tcy0AXvgLeA9BXLEEDYXEDKjEd1P4fweUv59MyEJ8sR9886+5poeoCjiG2/eq/JsFiluUetdjOtESLAQ=
X-Received: by 2002:a37:a80b:0:b0:6cb:dc5f:2ded with SMTP id
 r11-20020a37a80b000000b006cbdc5f2dedmr5055763qke.320.1662736177653; Fri, 09
 Sep 2022 08:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220909145942.844102-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220909145942.844102-1-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Sep 2022 18:09:01 +0300
Message-ID: <CAHp75VfNjQTVjsjWNJ1oOGuovxt_=ZEZrEfTvj=-Ym9R_ZzPoQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: ocelot: Fix interrupt controller
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 5:55 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

Thanks for an update, my comments below.

...

> -       dev_set_drvdata(dev, info->map);
> +       dev_set_drvdata(dev, info);

I would also change it to platform_set_drvdata() to keep symmetry with
->remove().

...

> +static int ocelot_pinctrl_remove(struct platform_device *pdev)
> +{
> +       struct ocelot_pinctrl *info = platform_get_drvdata(pdev);

> +       destroy_workqueue(info->wq);

Is it a synchronous operation? Anyway, what does guarantee that after
this no other task can schedule a new work due to unmasking an
interrupt? I think you need to be sure your device is quiescent before
killing that workqueue. Something like synchronize_irq() +
disable_irq() or equivalent? (I don't know for sure, you need to
investigate it yourself and find the best suitable way).

> +       return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
