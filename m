Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09E72DB20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbjFMHih convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjFMHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:38:34 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E3AA;
        Tue, 13 Jun 2023 00:38:33 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-56d5492850dso6764397b3.0;
        Tue, 13 Jun 2023 00:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641912; x=1689233912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HYSRhDPwRoW06pJwnVk/r95T6M6w1GodDXdJDLZ7hw=;
        b=ErTBJHcVFLs7fU0t/WS8JU/lWBKznx7RfhF6qFEZ8Mzwf/SU2w2i1gPeK9nEePwyYK
         0O46g2jbCe27596CJMeQpACBJtUEZZAqKrDyCkEbC7sWHdgfM7sQXfyeFABqXAiW6vVI
         bn19WtZNg8YMqV62sr8OjzDogN4Nm71KrzZtCptZ2bptbWlCe6zE+j0n2nNYkEQnSlXH
         Ybu00AsNs6thwz97zcHDI5QyhicemJLbwQsfCQ/sJQCNmXRSjSQqHn3VYf1dDNQ0iPyB
         mhJCWvS2hDuSwm5mB7A5rQg2SJAj2qBMEx7LPZCvIbnnSM/BzVv0NWHzfNr+15VQn9Xi
         +uZg==
X-Gm-Message-State: AC+VfDw8Q07fQh8YZLYGWdyJsuinzEGW1zC0KOcQRifEXz/e+SVrOLUl
        Stq5web72+MTSJNDtSIpwLLalouC9V7NxA==
X-Google-Smtp-Source: ACHHUZ5Xy96REM2G8fMuYRpTXaL0Tx08J209KzAHyTv/iamcC284Vmx7eV+yhc2IHk03D3kppazIwA==
X-Received: by 2002:a25:cf8a:0:b0:ba6:b00d:b865 with SMTP id f132-20020a25cf8a000000b00ba6b00db865mr779527ybg.56.1686641912378;
        Tue, 13 Jun 2023 00:38:32 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id e72-20020a25e74b000000b00bc8f984984asm1258554ybh.35.2023.06.13.00.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:38:32 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bc4e167c4b2so3115260276.3;
        Tue, 13 Jun 2023 00:38:32 -0700 (PDT)
X-Received: by 2002:a25:4245:0:b0:ba8:1ebe:9b96 with SMTP id
 p66-20020a254245000000b00ba81ebe9b96mr762286yba.1.1686641911996; Tue, 13 Jun
 2023 00:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230613021643.3330661-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230613021643.3330661-1-gongruiqi@huaweicloud.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Jun 2023 09:38:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGG2xu+nXJt6CSTfV6aM=U=hMW+DiDgP3RhOw8+O8y=A@mail.gmail.com>
Message-ID: <CAMuHMdXGG2xu+nXJt6CSTfV6aM=U=hMW+DiDgP3RhOw8+O8y=A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: remove checker warnings: x | !y
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gong,

On Tue, Jun 13, 2023 at 4:13 AM GONG, Ruiqi <gongruiqi@huaweicloud.com> wrote:
> Eliminate the following Sparse reports when building with C=1:
>
> drivers/pinctrl/renesas/pinctrl-rzn1.c:187:52: warning: dubious: x | !y
> drivers/pinctrl/renesas/pinctrl-rzn1.c:193:52: warning: dubious: x | !y
>
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>

Thanks for your patch!

Looks like sparse needs to be taught the "|" is not used in a boolean
context here?

> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> @@ -184,13 +184,15 @@ static void rzn1_hw_set_lock(struct rzn1_pinctrl *ipctl, u8 lock, u8 value)
>          * address | 1.
>          */
>         if (lock & LOCK_LEVEL1) {
> -               u32 val = ipctl->lev1_protect_phys | !(value & LOCK_LEVEL1);
> +               u32 val = ipctl->lev1_protect_phys |
> +                       (value & LOCK_LEVEL1 ? 0 : 1);
>
>                 writel(val, &ipctl->lev1->status_protect);
>         }
>
>         if (lock & LOCK_LEVEL2) {
> -               u32 val = ipctl->lev2_protect_phys | !(value & LOCK_LEVEL2);
> +               u32 val = ipctl->lev2_protect_phys |
> +                       (value & LOCK_LEVEL2 ? 0 : 1);
>
>                 writel(val, &ipctl->lev2->status_protect);
>         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
