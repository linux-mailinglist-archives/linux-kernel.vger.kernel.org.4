Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A16607396
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiJUJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiJUJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:10:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F87172A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:09:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l22so3376382edj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ00gNgP3Q+XocLnBJTsK8Spn3uV5zORNCmA+eX6cvI=;
        b=xh7xJ6ouTgDy99BEZDSRktFrkUHhO0I1Ca5KPxrRVmf4y7qzVE2PTiZeTPawPtit5s
         pZIlZGG82BSHvLVy4vP/4OGgQIZS4v7HPW2Kt0h0i48sA2lyisTzxL7Tgnx58dhRe/8W
         HWBusjVM+/8KUmBEwbj1eQD4ChuJQanwocCYzIDJKMG4/vYHPTVQ86jKwqqpA8mUAQLX
         zH3KOGe8Gew0fcs/Hxs15r7alRpJ2tq3p2l3UWpcqHDxyrYal3aG4Ct9Y+dVwgKGu1nA
         1f8UAFu4+3E/dg6M/Sh9z3KYHU82aWE4DvdOn+3ZqN+FVVKWdKUv6iZcjpK21LzzkZKU
         CKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZ00gNgP3Q+XocLnBJTsK8Spn3uV5zORNCmA+eX6cvI=;
        b=3zspahWJ2/0Cby+lNrlsu9ER7n+dbOHvXTZIUm02UZQPah8BpN6Bpkjl9rIdeDD+3D
         axcEpQa/h0cj9pAwTe6LN2y+VWxgoG9wAUO67La5V9BdkobW3Vp3lo6t4lgUhBthc3KP
         tfdiBl2Yh/Qzdbpavuf6T4D5XqBzNJrENvFpxjNj8vRWYz8LWbeFTqKfaqGSPz6CYitv
         +ERh4pWNbjHwrDRC+ZKzt4YKdtyyrE0iiR2rbcQHrpoCQTJB1Y6HRQnpVn4gYm4Le1Q8
         NV9PZg5YAIimz8MUB+xwD0XeNJ3Vlx9GjvyWVhLuctkN4yst5b+p5efzAbHDMhyU3Wy1
         gHHw==
X-Gm-Message-State: ACrzQf0HKMnoOAmqBHK9tmcLyHL1xypeVo4Cn8UmPew3iiiVu5v5cueW
        3yhheYVMbSFFMdHQjKwhnU3zhEiFdTCWKu2RjaEo/g==
X-Google-Smtp-Source: AMsMyM7UgqMHIuvm+nIloXnPhWNOkilm8KxtSRpgvFu6EP1Y5QVz9gaC7UiQWvfPLtfDV18jT9ZdwsCme1r0W4I3IxE=
X-Received: by 2002:a05:6402:1d55:b0:45f:c87f:c753 with SMTP id
 dz21-20020a0564021d5500b0045fc87fc753mr8129956edb.32.1666343379498; Fri, 21
 Oct 2022 02:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221019022450.16851-1-larry.lai@yunjingtech.com> <20221019022450.16851-6-larry.lai@yunjingtech.com>
In-Reply-To: <20221019022450.16851-6-larry.lai@yunjingtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Oct 2022 11:09:27 +0200
Message-ID: <CACRpkdYfPT6-gt2RCxzPfy+GdkLYo8KP02CLLC+uY512AqPwNw@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: Add support pin control for UP board CPLD/FPGA
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengwei,

thanks for your patch!

On Wed, Oct 19, 2022 at 4:26 AM chengwei <foxfly.lai.tw@gmail.com> wrote:

> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control) through an on-board FPGA.
>
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> [merge various fixes]
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
> Signed-off-by: chengwei <larry.lai@yunjingtech.com>

I am a bit confused by this driver. Andy pointed out some obvious nits that
need to be fixed but the overall architecture here is also a bit puzzling.

This seems to want to be compatible to Raspberry Pi (RPi), then which one?

The driver seems to translate GPIO calls to "native GPIO" in some cases,
which GPIO controller is that?

Also I don't see why, normally a pin control
driver is an agnostic back-end for a GPIO controller, so the GPIO driver
should be the same (whatever "native") means, and this driver should
not even implement a gpio chip, just let the GPIO driver do its job
and call back into the pin control back-end whenever it needs it.

Also we already have a driver that collects existing GPIOs to a new
GPIO chip, the GPIO aggregator:
drivers/gpio/gpio-aggregator.c

Maybe if you can explain a bit about how this hardware works and why
you have to do indirect calls to another GPIO controller, things will
be easier to understand?

Yours,
Linus Walleij
