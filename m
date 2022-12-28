Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F7B657170
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiL1AmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiL1AmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:42:22 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3ADDF6B;
        Tue, 27 Dec 2022 16:42:21 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o14so6940158qkk.5;
        Tue, 27 Dec 2022 16:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AT7wAljAc6zDS49obSZ6/gRr6I2iWE2SnMYOzdxGqH0=;
        b=fvIBLKx8DB6ok4Yjy/zo/XKMF3Byp8a5yFT3Ef77uPXvhLsoM9zDllhfaa9Ey9n+2u
         9zj7G2KpZRv2QZmtXQbqB1yWEZCehBVK3PxiG0PAcVPYLHn2JemTIvBiCIw8vyExr3fM
         dMdA/uzQ7csB8vttR0z5KDUnNlJeBnR/w7sNwlEpgJQed5OOBPtZa/20AnabYzxCe8Ol
         hBEyaxTvAr/SQ69YzxNPqBPwQddcJQLLTFLba1DWWu6oRSA8sEhcNrEe0R7jiPmWQbwn
         4zrwTDg9D6a23LWMpq3OkKH2R4NDWdAPbParXPoYwnNzUl4x+Ze2hqGDkPplcapNSR22
         Ea3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT7wAljAc6zDS49obSZ6/gRr6I2iWE2SnMYOzdxGqH0=;
        b=ATCBn8v4YIfUxPFpZLTirwB76J/5f9vMy4CAoHZ8xXdXJCwdebvrmWbQpabbc2VF3M
         KwQGNZdnyEXHQGroEGVi6MMgr2TO+dJTFGBQdvrsySZXBBvLvJVGTmcaVwgkI/6A8YyZ
         QtJcCrWlLXeWF+AJ+Tz5onuPvmneuzSHLD9tUm3qZTxs40KR9Qm/DAWHemZTr2B44K5x
         T++9DJmw51ZP/0GxgsGx/f9La8bV01H3olVhMXQ1qO7dQ5RMXB05LG7BPTm1p1d0nKIT
         baIjh8H9GJM9JjQ+Nuuv7FWixcoDtrQTNiuRyue1FdRo+P0zBXLNGOX0gXurkDjpFOqp
         yHTA==
X-Gm-Message-State: AFqh2kpZMpLZdwZ1xJHfO3kNXlwC1LhB3AsBh5TwW83j9h2wjfxcoL8O
        mxfcKpWruU2OLPdlb40vcuBjDYMuP1onFpKJIUc=
X-Google-Smtp-Source: AMrXdXvadVuBZc49Yci9KBEGhRvSOnalF7+vOEUiJL87B02SslH2yeN532lzCUleTYh1rl74xZR7szjpmTOZI1+urq0=
X-Received: by 2002:a05:620a:1aa2:b0:702:34dc:25a8 with SMTP id
 bl34-20020a05620a1aa200b0070234dc25a8mr1108830qkb.748.1672188140306; Tue, 27
 Dec 2022 16:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20221227100659.157071-1-jjhiblot@traphandler.com> <20221227100659.157071-7-jjhiblot@traphandler.com>
In-Reply-To: <20221227100659.157071-7-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Dec 2022 02:41:44 +0200
Message-ID: <CAHp75VceSOCiu=17jrmHVOaqAoaqw4He9DKgH8Vjw_oYZdi7Eg@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 27, 2022 at 12:07 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> By allowing to group multiple monochrome LED into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

...

> +       count = 0;
> +       max_brightness = 0;
> +       for (;;) {
> +               struct led_classdev *led_cdev;
> +
> +               led_cdev = devm_of_led_get_optional(dev, count);

> +

Redundant blank line.

> +               if (IS_ERR(led_cdev))
> +                       return dev_err_probe(dev, PTR_ERR(led_cdev),
> +                                            "Unable to get led #%d", count);
> +
> +               /* Reached the end of the list ?*/
> +               if (!led_cdev)
> +                       break;

> +               count++;

If I understand the flow correctly, this can be moved...

> +               priv->monochromatics = devm_krealloc_array(dev, priv->monochromatics,
> +                                       count, sizeof(*priv->monochromatics),
> +                                       GFP_KERNEL);
> +               if (!priv->monochromatics)
> +                       return -ENOMEM;

> +               priv->monochromatics[count - 1] = led_cdev;

...here either as a separate line or a part of the above assignment,
in either case the -1 wouldn't be needed.


> +               max_brightness = max(max_brightness, led_cdev->max_brightness);
> +       }

-- 
With Best Regards,
Andy Shevchenko
