Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F495BB746
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIQIiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIQIiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:38:22 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F075A2D2;
        Sat, 17 Sep 2022 01:38:21 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o13so18348959qvw.12;
        Sat, 17 Sep 2022 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=I74yKbbEKIm/62gbVurzxkM05YVP2M1gGHJOakj6RhM=;
        b=UzJAxgBK88Q9X98yO6Ry9S576TEhYe8m6bW24XhKVf8UrDUtkQLAWVNMgHXZpxIpSu
         9/Bt3ZWrBTQqK3ApqsYLh5coQOsYLZwK09pJl+pUPXIPmj3wgKRyxwL/858eMEa0Dkaj
         c+ttL9iUnxPs64IoN2DXODHddnsKpyBo9EPPOO3RBRmatuS86bMvzhVFqh42UtcSx8VI
         JaJsXCMyokuukvZPmhMd4e0VAT1bBOYRqlYKfsNEprfNFM4u86z3icZl5qMtWG7b2K7+
         1MIpc04emAJz3/t+pxa5mkpwXWmPt3NRPLV8P2Me/ipHDYjtGewgDI6+Ww1JDPcYz8ru
         sKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I74yKbbEKIm/62gbVurzxkM05YVP2M1gGHJOakj6RhM=;
        b=nrhnnCxonR2TDpy4IiA/Ig1ngTVe37uq2sNxwF0ee139UjB7Pfgkk3uwz8btdfhJTi
         jVsjg0FsbXAyhlgfXHYlXbMU6N+5csw9LO6mvBTBMzZCx2JEV1JQKEUvfINvAUpyKSod
         S6copGqDqz5usgb6cUOi7FPe7P/FudWaYrILY81mitLBFH5lFFcMpndx/IdZUxKd4gJe
         Ln9b/5nVa+re7xXRcReNQrskvgXA+9/WL9mLxDArYaDWEupTeATjKXNz+mXCf9NyriFd
         x7d9mgfbtcEsFCbBgM1QYKnOAyUeNKpjbEyQ4Ly0veT55I4rthkBVh5hsEzigvXOkgJT
         TwCA==
X-Gm-Message-State: ACrzQf0QdpnzpnnREpZoU2Hy6MqiXGSv0pMjony6o55x/v+IZG/E4tN+
        ythNi9c18L0BYFxWKySCJkryJKoeiLZ3iFazId8=
X-Google-Smtp-Source: AMsMyM6Nut1PvGPyZJQY1STA9ugOVAi671m8yr/TdAPuzXvmcGey3RmevAnlc6+5wuQvtZwYUzIjdLCxC6Wj2435vR0=
X-Received: by 2002:ad4:5b8d:0:b0:4ad:22e7:ae4c with SMTP id
 13-20020ad45b8d000000b004ad22e7ae4cmr1530243qvp.48.1663403900104; Sat, 17 Sep
 2022 01:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220917081339.3354075-1-jjhiblot@traphandler.com> <20220917081339.3354075-5-jjhiblot@traphandler.com>
In-Reply-To: <20220917081339.3354075-5-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Sep 2022 11:37:44 +0300
Message-ID: <CAHp75VeAnJQt7kS8UE+OKcqnScYnmHnVvL+QNW6jR=yF0=oMAA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> By allowing to group multiple monochrome LED into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

...

> +config LEDS_GRP_MULTICOLOR
> +       tristate "Multi-color LED grouping support"
> +       help
> +         This option enables support for monochrome LEDs that are
> +         grouped into multicolor LEDs.

What will be the module name in case of "m" choice?

...

> +       struct led_mcg_priv *priv =
> +               container_of(mc_cdev, struct led_mcg_priv, mc_cdev);

One line?

...

> +               /*
> +                * Scale the intensity according the max brightness of the
> +                * monochromatic LED

Usually we put a grammar period at the end of sentences in multi-line comments.

> +                */

...

> +               actual_led_brightness = DIV_ROUND_CLOSEST(
> +                       mono->max_brightness * mc_cdev->subled_info[i].brightness,
> +                       mc_cdev->led_cdev.max_brightness);

Can you fix an indentation, so it won't leave the line ending by open
parenthesis? I believe with the help of a temporary variable it can be
easily achieved.

...

> +       for (;;) {
> +               struct led_classdev *led_cdev;

> +               led_cdev = devm_of_led_get(dev, count);

Why _of_ variant? Please, make this OF independent since it's
pretending to cover not only OF-based systems.


> +               if (IS_ERR(led_cdev)) {

> +                       /* Reached the end of the list ? */
> +                       if (PTR_ERR(led_cdev) == -ENOENT)
> +                               break;

Looks like the above needs an _optional() variant

> +                       return dev_err_probe(dev, PTR_ERR(led_cdev),
> +                                            "Unable to get led #%d", count);
> +               }

...

> +               priv->monochromatics = devm_krealloc(dev, priv->monochromatics,
> +                                       count * sizeof(*priv->monochromatics),
> +                                       GFP_KERNEL);

This needs at minimum to use one of the helpers from overflow.h,
ideally you may implement devm_krealloc_array() as a suitable wrapper
for that.

> +               if (!priv->monochromatics)
> +                       return -ENOMEM;

...

> +       subled = devm_kzalloc(dev, count * sizeof(*subled), GFP_KERNEL);

NIH devm_kcalloc()

> +       if (!subled)
> +               return -ENOMEM;

--
With Best Regards,
Andy Shevchenko
