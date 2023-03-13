Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD846B79DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCMOFC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCMOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:04:49 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A8334009;
        Mon, 13 Mar 2023 07:04:48 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id s12so13132293qtq.11;
        Mon, 13 Mar 2023 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678716288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTxfzXAT/i8PE03o54XVi6USJTVXuZZl35BHIw+N+Wc=;
        b=mZIBTYcJGGSZTAY2DUMmvteS/ac5cKQIw7sYpvkJgQ5okDJ1S5/1LQwZKxqeamtwb7
         uK1prBVAOXecDgzVf2daKXLHZyQS/UP63m9X538/DOe6tZjkH/ICar93ib2OX+msI4wH
         +kDTnuqwzJT3W0/tvxh9P8mY7an4u0xVGEPNYDSTLtzGsDwOC+CFiwb7hgFI8wFjV7rd
         MShYfdZdG8oYu9VUI4f26jwxJwCdA9c4fOIwGXqsPDDqfJWGGyQVpOK4aFpvN7Gzi0oK
         MsAvpTngoBq0cWX1lkv/MJduMotcwIQj5qZ17VmdZr7BObZ3Ust1Qqvcs6oMytEXUNg3
         GZcA==
X-Gm-Message-State: AO0yUKU9MrTiu5Oc5US16TZoK6wBY/oRHY+yO64TBxFRS79w2IP0d8YX
        qkq+qfTVac9OVqdR9+quqBM0IE2vLchCWg==
X-Google-Smtp-Source: AK7set9ejg0baYIES0i1BSHDfgd7QQsVKeaK/dVrt3qK2pp/Edms09Krunw0nJM5XOoaTlAiI0Q4sw==
X-Received: by 2002:ac8:5acc:0:b0:3bf:dbb4:3bcc with SMTP id d12-20020ac85acc000000b003bfdbb43bccmr58815405qtd.4.1678716287710;
        Mon, 13 Mar 2023 07:04:47 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w20-20020ae9e514000000b0074269db4699sm5360031qkf.46.2023.03.13.07.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 07:04:47 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id e71so3547142ybc.0;
        Mon, 13 Mar 2023 07:04:47 -0700 (PDT)
X-Received: by 2002:a5b:68c:0:b0:b30:d9c:b393 with SMTP id j12-20020a5b068c000000b00b300d9cb393mr6831016ybq.12.1678716286977;
 Mon, 13 Mar 2023 07:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230312132650.352796-1-krzysztof.kozlowski@linaro.org> <CAMuHMdVQsQZgU213+c3eJKZ2+p69AorUEhHck84NAN01QtxEBg@mail.gmail.com>
In-Reply-To: <CAMuHMdVQsQZgU213+c3eJKZ2+p69AorUEhHck84NAN01QtxEBg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Mar 2023 15:04:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+dCvEPjWkGUoYR+EPC=d9xCdPx=NArmk04Qd4kPzcgA@mail.gmail.com>
Message-ID: <CAMuHMdV+dCvEPjWkGUoYR+EPC=d9xCdPx=NArmk04Qd4kPzcgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: renesas: mark OF related data as maybe unused
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Mar 12, 2023 at 2:26 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > The driver can be compile tested with !CONFIG_OF making certain data
> > unused:
> >
> >   drivers/soc/renesas/renesas-soc.c:272:34: error: ‘renesas_socs’ defined but not used [-Werror=unused-const-variable=]
>
> Where do you see this issue?

With W=1, as of_match_node() is a dummy macro, not an inline
function.

> This variable is used unconditionally, and the driver builds fine for
> me for m68k/allmodconfig+CONFIG_OF=n?
>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

> > --- a/drivers/soc/renesas/renesas-soc.c
> > +++ b/drivers/soc/renesas/renesas-soc.c
> > @@ -269,7 +269,7 @@ static const struct renesas_soc soc_shmobile_ag5 __initconst __maybe_unused = {
> >  };
> >
> >
> > -static const struct of_device_id renesas_socs[] __initconst = {
> > +static const struct of_device_id renesas_socs[] __initconst __maybe_unused = {
> >  #ifdef CONFIG_ARCH_R7S72100
> >         { .compatible = "renesas,r7s72100",     .data = &soc_rz_a1h },
> >  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
