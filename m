Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C3706435
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEQJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEQJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:33:45 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00A4201
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:33:43 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-783ec566cb9so205621241.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684316022; x=1686908022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZP05VBsRBTnZPUQDMha8VxgfVkr0tg5YgvQMaq3VYA=;
        b=aBBRNgfRVqVIC9Dm9wfTTEuD3/7fHEtP2vqz1zKRHpv++rQJidsKaSv6VFaHtgUbRZ
         CXvFwrhx4TSnPhFw55pNZ6xWesH8LjcxhDZO0NhjUZTdxcvT+RpWAzoM4/jGu2B0q5tk
         /I/pHGwKwNVH2RwjTKwgErGoTTCaIjIwQrLjMJ9dFdAxHmyARJk5TfqE0oiSCE+xdRHY
         1WUCaoAVdW+sIheYNBjlyzTjOjC0Dx3a04IOVFFFmsPO7YnLXS0GrYyv04jt8A2sTol5
         kr6Wzma81tOJhTbplRq6UnjhD8F4ZAK7Y2VDE0Il3bseVJZY1BU9kmME6eOCZQ2qGZFR
         sSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684316022; x=1686908022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZP05VBsRBTnZPUQDMha8VxgfVkr0tg5YgvQMaq3VYA=;
        b=Pc2UvecQj8Ud8mQHUv41d70Prt1xSx81rjc91YFyYMqroLTIx8nZbvSFckT/GWWhW6
         j9xEaQiLhuep4i7XXMLGWagk20GxgkzNg8lu00ohcE3nt6VRkLceZofSYVNHhVpxoPHX
         BeA3S0nz09taGsBJKhUTKHquxDCpQGePXyerMaazyMD+8BRggWsqxpukI/mzpHBVBn9e
         NZIOVRNBIhBjR+DXyPlValYVUuz3A1UCS1dohEKC2rji+4btjdQ4w8pDa8mbRtVfiWhJ
         qy2Zrs1QzrlsCTasntU7FidA+VW6i8XdCmBE7X+eqcH60vnvw8BtXbDtQupIpjKrxpD0
         d6UA==
X-Gm-Message-State: AC+VfDyLP6vUlzyFhBB1TIy+hsIidqviv0YZX1ioTldewpnqAFea3H0/
        Sbmddd+J4xW02n+zwCScVRB97EyB+oL5uY7dWMQAkBf6UkbFz0gB
X-Google-Smtp-Source: ACHHUZ5q/zWRBS78Q6k4yWV3Mh1qbcw1QL9guDD0uikNGXvaPjcLe0Aq0aLDDiyxGAu2nBIP9kLjT8g7+jMV4bVkJMw=
X-Received: by 2002:a67:fd8c:0:b0:434:7037:c7dd with SMTP id
 k12-20020a67fd8c000000b004347037c7ddmr16176876vsq.34.1684316022180; Wed, 17
 May 2023 02:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230516201642.557733-1-arnd@kernel.org>
In-Reply-To: <20230516201642.557733-1-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 11:33:31 +0200
Message-ID: <CAMRc=Mdic_d3KaxFXrz7aVUcLyK8fBBHPgRGYP8nQvxN-ZwJXQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sa1100: include <mach/generic.h>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> sa1100_init_gpio() is declared in a machine specific header so it
> can be called from platform code, but the definition is in the device
> driver, which causes a warning:
>
> drivers/gpio/gpio-sa1100.c:310:13: error: no previous prototype for 'sa11=
00_init_gpio' [-Werror=3Dmissing-prototypes]
>
> It's already possible to include mach/generic.h from drivers, so add
> this one here as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/gpio-sa1100.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
> index 342a59ea489a..3b1cc8462fcb 100644
> --- a/drivers/gpio/gpio-sa1100.c
> +++ b/drivers/gpio/gpio-sa1100.c
> @@ -13,6 +13,7 @@
>  #include <mach/hardware.h>
>  #include <mach/regs-gpio.h>

This doesn't apply on top of my branch (neither on next) because of
this line. I can't see where this was added. Any hint?

Bart

>  #include <mach/irqs.h>
> +#include <mach/generic.h>
>
>  struct sa1100_gpio_chip {
>         struct gpio_chip chip;
> --
> 2.39.2
>
