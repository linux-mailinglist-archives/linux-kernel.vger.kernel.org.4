Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745266587E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiL1XaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiL1XaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:30:11 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AAE13D15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:30:10 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-482363a1232so85797017b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJfpsuGmkRtYVHaS0jk9a9geCrWPkqTErNlvnVy7Oyo=;
        b=WxJtATyOD4OIRpZx7krCFnAd+CpK6cDQR2tbagDrzy77BZCbPEZydAV3rx+LbQGJwv
         hORrcoY6fb0ohy8fjUVzwQlrDNhbgWs1BdSyx05NBZF/2jOlzO/HHWXg6Qc8GADgQELw
         SSiZ/edoZOzRt/jjtTTzbU6ZuE06ykAb5c18rQpN83FgZZIRApp8hYvmKuiG8U6402+i
         vLAGySHaOiMAW1RB9C5/9BEhQ/u+pauK2bz5d6lAHXCqoJVwBPCblp/qMSOwjT2GEyjL
         MYWDqNQbeRUNjFOWdWQPTeKVvwamfvxzGGZ+l6EbTApwaNqyTlL1H4L0B/dobLPsbgKp
         xpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJfpsuGmkRtYVHaS0jk9a9geCrWPkqTErNlvnVy7Oyo=;
        b=U/wsfWsz31+uMa91NzeMBfma9w+NLNNlCqPY5nTHrb73aSx9gGS7DOGrwus9JIfwJ/
         M84VnRaO6yguP02YZFblSsIWCZjmxWqN3cgTwi5jB/4fTiO8w+1tmQNSgKUPXeca2MuV
         Jszt782lp1U6WmgMjgXoRmeQnKNHun++OZPLAUZM+Krp/A32q/WrGblXJVmSxwuosiqx
         wl9AXynPobeffmMeC5ekos/v1nA0luCuJL52ziqAOn96YH8rtWS5vIAkrpwhCaKk9o2H
         xYVTlX+pikT4625CIwE05QIGp8VxGFFoERRJhJFcP98u+PsMCRziAo8FiRqRiEZMRFpa
         J6hw==
X-Gm-Message-State: AFqh2kq5EkrLcOnDAilAAIYUtj5viMhfKkH7KVBgpO8qDicAbpPi02ql
        Of4wLlxJ9abQrYBCW2N55TFpJUbPTPNv0br+2ZQ=
X-Google-Smtp-Source: AMrXdXt+whyfBdIz20L32St7MHdPXiMGOmwCGGnuNkHC1oGLlDYrUVHg6UnzAE/waSW8hu8c/N/ONhO5/dE+1inDjcY=
X-Received: by 2002:a81:1495:0:b0:465:d978:9724 with SMTP id
 143-20020a811495000000b00465d9789724mr3223519ywu.249.1672270209780; Wed, 28
 Dec 2022 15:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20221228004444.61568-1-samuel@sholland.org>
In-Reply-To: <20221228004444.61568-1-samuel@sholland.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 28 Dec 2022 23:29:43 +0000
Message-ID: <CA+V-a8t6pL-LrtwZzicUzC67yzZgE3hzHH+MNvdj5LuH7g3s6w@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock source rating
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

Hi Samuel,

Thank you for the patch.

On Wed, Dec 28, 2022 at 12:44 AM Samuel Holland <samuel@sholland.org> wrote:
>
> RISC-V provides an architectural clock source via the time CSR. This
> clock source exposes a 64-bit counter synchronized across all CPUs.
> Because it is accessed using a CSR, it is much more efficient to read
> than MMIO clock sources. For example, on the Allwinner D1, reading the
> sun4i timer in a loop takes 131 cycles/iteration, while reading the
> RISC-V time CSR takes only 5 cycles/iteration.
>
> Adjust the RISC-V clock source rating so it is preferred over the
> various platform-specific MMIO clock sources.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
>  drivers/clocksource/timer-riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index a0d66fabf073..55dad7965f43 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -73,7 +73,7 @@ static u64 notrace riscv_sched_clock(void)
>
>  static struct clocksource riscv_clocksource = {
>         .name           = "riscv_clocksource",
> -       .rating         = 300,
> +       .rating         = 400,
>         .mask           = CLOCKSOURCE_MASK(64),
>         .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
>         .read           = riscv_clocksource_rdtime,
> --
> 2.37.4
>
