Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6BF5B8BA9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiINPU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiINPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:20:26 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5F1A04F;
        Wed, 14 Sep 2022 08:20:25 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id v15so11979499qvi.11;
        Wed, 14 Sep 2022 08:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ojugek6KBkaTNGX1te3XluOa+UNNG5FLDq2Ihxg8cpw=;
        b=ch097PZ+6l49d6yfzeyBk0u7SivnjtTsh8kf2UJ24dLMn/wxJCprZRjp3HV+spJbKO
         Lb/FqFFkNIIWsgeOXQWCYkRzvH2gvTQFUiSsbMgian4Ub1H8iaBZFBXNUeRc7mBqF2Nc
         31cjsJJJ8dPWGN/KkmcfjZRdMPPHY/iYuOqn6E/qjRoq1twQn4Wq4vkOg8NnYgWgFeTw
         wPqpIMY2eLr30Yz93ZNqUN/l4jjbb9Mqo+GlpxslyWuECM2M5/zInNrhv1dNpwsrWn3x
         jBzxfrMpXv5gMe7TffMRWRbWfaUOmfsvh0gd5P6FBTSgXehmcmdA2UMRkrMjjBt7MlZ/
         w6oA==
X-Gm-Message-State: ACgBeo3uTWSVYzwNK6Z1f6VR8pzWRCaeo3lnwvYM77XkgZ54xkukS4aU
        iIX0olSPjBoS+TCKAfgVIz8WgN4DJUpwtAHo
X-Google-Smtp-Source: AA6agR5NHoenS2uR93eb55l2WFqOGfLmQy+E7nmbH1QnR/3X8Zrc5WSMGk0sO4tQhMZ89FjbhfceTA==
X-Received: by 2002:a05:6214:4102:b0:4a8:940b:b752 with SMTP id kc2-20020a056214410200b004a8940bb752mr32846165qvb.68.1663168824680;
        Wed, 14 Sep 2022 08:20:24 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b0034355a352d1sm1663750qtv.92.2022.09.14.08.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 08:20:24 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id e81so3881012ybb.13;
        Wed, 14 Sep 2022 08:20:24 -0700 (PDT)
X-Received: by 2002:a25:3851:0:b0:6ad:9cba:9708 with SMTP id
 f78-20020a253851000000b006ad9cba9708mr29016892yba.36.1663168823884; Wed, 14
 Sep 2022 08:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151145.73253-1-brgl@bgdev.pl>
In-Reply-To: <20220914151145.73253-1-brgl@bgdev.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Sep 2022 16:20:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7__tOo1waXCg7ayKG9XLxKWZfqZX56vXPH6oPEmPj9g@mail.gmail.com>
Message-ID: <CAMuHMdV7__tOo1waXCg7ayKG9XLxKWZfqZX56vXPH6oPEmPj9g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Wed, Sep 14, 2022 at 4:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> This adds a new TODO item for gpiolib and can also be used to start
> a discussion about the need for it and implementation details.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

> --- a/drivers/gpio/TODO
> +++ b/drivers/gpio/TODO

> +This item is about proposing a solution, most likely in the form of a new device
> +property called "safe-state" that would define the safe states of specific lines
> +(e.g. output-high) but not block the line from being requested by users who
> +could then modify that default state. Once released the GPIO core would then
> +put the line back into the "safe-state".

#bikeshedding

If this state is the "safe" state, would that imply that any other state is
"unsafe"? I guess not, as the idea is that a knowledgeable driver can
still change it (else a hog would be sufficient).
Hence I think "idle-state" would reflect this better. Any other thoughts?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
