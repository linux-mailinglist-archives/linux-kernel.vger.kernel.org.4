Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6066272DB77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjFMHsq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Jun 2023 03:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjFMHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:39:50 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7271A5;
        Tue, 13 Jun 2023 00:39:49 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bc9782291f5so2286653276.1;
        Tue, 13 Jun 2023 00:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641989; x=1689233989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXHsYsW3sGwaS5VK0EBUqtTJTWaYVmFmgpLimYiew8E=;
        b=MUBmeI1twmPclG9Zq3DYOyWz0jmCvBalhePltETU+eeKubePmYQ9tL5DrLURxIq+fg
         MRh0+hwQM1RNy8onslTR8i5kmL0In/tlqIg2guXXAJEevjTodOnb+NS0/NBV5mMl31Tm
         9ygF8UuBN6W4cIxQq9Wm2o/JNtmveVfXBx24Au8wG0rxWOxTKPf0iReJmiNY4KVbb7RQ
         kz6HJ6Kfnr0iQtioncnvNMW65K/Qs/jiA7lJV+H/e46No1wLaK23oP+vQ0Rk1aT12Ffv
         HfYY1YZyVzHDsfGakgVt3M08+R8Wh+8aOLRuFzoAifkyEKZyVisizFk6PpeMfEjBuruG
         eDhw==
X-Gm-Message-State: AC+VfDxZ+txGwhoCa4b2zA48iwnLyGzPjO4rvAlGYnnB2m5FDcoy8Mu0
        UoIB8fx8XnHlCQAxY0XuyA5UhMpPVWXvPg==
X-Google-Smtp-Source: ACHHUZ6N+5XyHFj9XZ0mx6uFV7Hky+JU1nUz0j6Lo4eAOVNcCjPQqp7IfyKBAIcwMghpiAm9E6bGjA==
X-Received: by 2002:a25:1e57:0:b0:ba8:66fb:dd84 with SMTP id e84-20020a251e57000000b00ba866fbdd84mr798730ybe.20.1686641989007;
        Tue, 13 Jun 2023 00:39:49 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id h125-20020a255383000000b00ba73c26f0d6sm3013120ybb.15.2023.06.13.00.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:39:48 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bc5a3075e92so3155884276.0;
        Tue, 13 Jun 2023 00:39:48 -0700 (PDT)
X-Received: by 2002:a25:402:0:b0:bc8:2759:e4f6 with SMTP id
 2-20020a250402000000b00bc82759e4f6mr761612ybe.14.1686641988249; Tue, 13 Jun
 2023 00:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230613025403.3338129-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230613025403.3338129-1-gongruiqi@huaweicloud.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Jun 2023 09:39:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhp7AntSk1ZnTowiEC6XibR1im_7OKdF2JDg=51ewsyw@mail.gmail.com>
Message-ID: <CAMuHMdUhp7AntSk1ZnTowiEC6XibR1im_7OKdF2JDg=51ewsyw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r8a7778: remove checker warnings: x | !y
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
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

On Tue, Jun 13, 2023 at 4:50 AM GONG, Ruiqi <gongruiqi@huaweicloud.com> wrote:
> Eliminate the following Sparse reports when building with C=1:
>
> drivers/clk/renesas/clk-r8a7778.c:85:52: warning: dubious: x | !y
> drivers/clk/renesas/clk-r8a7778.c:87:50: warning: dubious: x | !y
>
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>

Thanks for your patch!

Looks like sparse needs to be taught the "|" is not used in a boolean
context here?

See also
https://lore.kernel.org/r/CAMuHMdXGG2xu+nXJt6CSTfV6aM=U=hMW+DiDgP3RhOw8+O8y=A@mail.gmail.com

> --- a/drivers/clk/renesas/clk-r8a7778.c
> +++ b/drivers/clk/renesas/clk-r8a7778.c
> @@ -81,11 +81,11 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
>
>         BUG_ON(!(mode & BIT(19)));
>
> -       cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
> -                        (!!(mode & BIT(12)) << 1) |
> -                        (!!(mode & BIT(11)));
> -       cpg_mode_divs = (!!(mode & BIT(2)) << 1) |
> -                       (!!(mode & BIT(1)));
> +       cpg_mode_rates = (mode & BIT(18) ? BIT(2) : 0) |
> +                        (mode & BIT(12) ? BIT(1) : 0) |
> +                        (mode & BIT(11) ? BIT(0) : 0);
> +       cpg_mode_divs = (mode & BIT(2) ? BIT(1) : 0) |
> +                       (mode & BIT(1) ? BIT(0) : 0);
>
>         num_clks = of_property_count_strings(np, "clock-output-names");
>         if (num_clks < 0) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
