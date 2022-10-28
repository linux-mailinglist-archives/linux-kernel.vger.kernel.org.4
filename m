Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC72610BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ1IHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1IHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:07:15 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD5314D1DE;
        Fri, 28 Oct 2022 01:07:14 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id t25so2968993qkm.2;
        Fri, 28 Oct 2022 01:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3K6HrWPJdcJ3kNDZ8m1cpGhsIwUzPY/4lz3JycA9gM=;
        b=ALbpJQSJzwsaiby2jBHGhEBD/CFFd3qkafEAWWxFSzfR+XKjQFD7FVFK8RObRv8x5Q
         03y2/vvcbpntSq+AK7UUbgXSh5707+6ax2isMBtN4o4hiyPDivjjbmJdQk8TME5OaKOJ
         2LZi0Km63vsR3oSXw7SKdozOWxf5t/BykY5tAvPR6X3QjBzOp05nbyCJHRlqEsXh09Il
         gYIuNuvBUUFU7h+wTakoUIwZSLNY2qfSn1RsvywSdUq8HZ4fUTuxsN6tn5juTSW1k8HF
         BQ5a+cEizoiz182JVlgJO7ROMiLuv1VZux+dfC31sKf/T2E7eyc2m8XjaD19UBz/ToNZ
         pnnQ==
X-Gm-Message-State: ACrzQf2XRVWBFCU/bKiY++6OueDbQPUn9yOmkAsd2LpC6S53ztP6auVa
        DnAFAQBrWVNAD3lGb2ygwMz3NmhJawE6kg==
X-Google-Smtp-Source: AMsMyM6z7X15zju+vTYrCJnky8Wzd9ZChI7oO4tahyF3POdI2Ht8xpGljKONVjRQ0iiv/rK7R36MWA==
X-Received: by 2002:a05:620a:1995:b0:6f8:4c19:a12b with SMTP id bm21-20020a05620a199500b006f84c19a12bmr12153736qkb.482.1666944433848;
        Fri, 28 Oct 2022 01:07:13 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006ee7e223bb8sm2522892qkp.39.2022.10.28.01.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 01:07:13 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-367b8adf788so40853407b3.2;
        Fri, 28 Oct 2022 01:07:13 -0700 (PDT)
X-Received: by 2002:a81:12c8:0:b0:36a:bd6b:92fb with SMTP id
 191-20020a8112c8000000b0036abd6b92fbmr30447625yws.316.1666944433383; Fri, 28
 Oct 2022 01:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221027112300.77184-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221027112300.77184-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 10:07:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5V_Vx8uxuK=pGHP6t548bYBLmL9xJ8P2xj-ify3HC3A@mail.gmail.com>
Message-ID: <CAMuHMdU5V_Vx8uxuK=pGHP6t548bYBLmL9xJ8P2xj-ify3HC3A@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Drop selecting GPIOLIB and PINCTRL
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 1:23 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Don't automatically select the GPIOLIB and PINCTRL config options as we
> already have automatically selected it as part of the SOC_RENESAS config
> option [0].
>
> [0] drivers/soc/renesas/Kconfig
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Note to self: beware dependencies, as commit b3acbca3c80e6124 ("soc:
renesas: Kconfig: Explicitly select GPIOLIB and PINCTRL config under
SOC_RENESAS") is queued in a different branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
