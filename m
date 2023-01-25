Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F08767B6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjAYQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjAYQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:19:01 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3740C4;
        Wed, 25 Jan 2023 08:19:00 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id y19so20903326ljq.7;
        Wed, 25 Jan 2023 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWTwmjgTRG2EECSYQmhAYPRybSGpNQjjUuI6hEqENqQ=;
        b=fx79Yiu3p2VXSMIcnE7/zAtFUxCLQDsSiyj52gsKmsSDYNjSzuO4hPDMCxgq28t05i
         mh+tX7/+ncTaf2xBg9P9U6WuEyl3q1g2et/x2160Z/dI9KMElTdFj6t0cOz3t51M8VFl
         5QeVyLwBk9BKztwZzSLq/3Vxhz98Vs4D3T3u0f7fe/VYf6X0fi2+G7xtsqDKCblkxpZl
         TfcgDwHkqyM98dq5Gzt9aLzQp0Vzkcku4dlAq58MqSfkv1tl+ChM/bk7ssoQiLE1+18+
         WlhvCV2fjS44+JitD9d1InSaypTg5JxlrHMx5tBIVqThjhLy5jkDKOmSnLyc4b90KeVg
         t1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWTwmjgTRG2EECSYQmhAYPRybSGpNQjjUuI6hEqENqQ=;
        b=USUw3xBUd2Qyg64UTBfRm6Z8vxJoUvQbCh+317PYv8/LcLEFX7E5C3WJ82QU2ngrjR
         moqOJsI8ui8STsUFRhgmXsmNLjejMR/as4GmF8tzVx5Imyads3YcGQiYmmolCp2zNgeO
         qzxknrZNAoYQtd9yqTWlbpe78HFuhWgaiHKOxL0TQxuIqeQNghOVj60ERGSo6urjHNq5
         n07++tNGdaLxGSxWgDuT2cbs9LyFnY+Cg3L25hs5xFfh25K+RzxEvbYh22Wh/4+w3EuD
         tS3FPUxPJHwaiv/tPaS3XxX2lqatd52KWwxRByVC19kyc8C+nUEge9nXqCUxO1kqbQEC
         sOdg==
X-Gm-Message-State: AFqh2kpCnu7SMF1LP5x0fLMhZe2cJzCGFJDWayUlVZTNVLHSMtuwzzyz
        l6WCfOYiEu2B7TPrDSjTEi9ykHku0oWaFO+GE0M=
X-Google-Smtp-Source: AMrXdXt+i/C8qLbsPe1lcHCbto7pEcuq4AoalDKFW9EXEReHLxE56apK7IJ7DuB55V7+a9FU6onq+yWAq9F1fTPa7cw=
X-Received: by 2002:a2e:9210:0:b0:28b:cb2b:d11c with SMTP id
 k16-20020a2e9210000000b0028bcb2bd11cmr1873538ljg.73.1674663538274; Wed, 25
 Jan 2023 08:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20221211204324.169991-1-tmaimon77@gmail.com> <20221211204324.169991-2-tmaimon77@gmail.com>
 <20221216184402.8A426C433D2@smtp.kernel.org> <CAP6Zq1iPmy-fvqqAwBuoskR18v0dPVwYm0tEcE5h1g8fOiOQvg@mail.gmail.com>
In-Reply-To: <CAP6Zq1iPmy-fvqqAwBuoskR18v0dPVwYm0tEcE5h1g8fOiOQvg@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 25 Jan 2023 18:18:47 +0200
Message-ID: <CAP6Zq1iAMcahqZJz1WTYokXoxJWROk3YK5br3OG1gry2uMrq7A@mail.gmail.com>
Subject: Re: [PATCH v14 1/1] clk: npcm8xx: add clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     avifishman70@gmail.com, benjaminfair@google.com, joel@jms.id.au,
        mturquette@baylibre.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, openbmc@lists.ozlabs.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Kind reminder regarding the NPCM clock questions

Thanks,

Tomer

On Tue, 17 Jan 2023 at 19:35, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Stephen,
>
> Very sorry for the late reply.
>
> On Fri, 16 Dec 2022 at 20:44, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2022-12-11 12:43:24)
> > > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > > new file mode 100644
> > > index 000000000000..08ee7bea6f3a
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-npcm8xx.c
> > > @@ -0,0 +1,650 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > [...]
> > > +#define NPCM8XX_CLK_S_RCP        "rcp"
> > > +
> > > +static const u32 pll_mux_table[] = { 0, 1, 2, 3 };
> > > +static const struct clk_parent_data pll_mux_parents[] = {
> > > +       { .fw_name = NPCM8XX_CLK_S_PLL0, .name = NPCM8XX_CLK_S_PLL0 },
> >
> > As this is a new driver either you should only have .fw_name here. The
> > .name field is a backup to migrate code over to a new binding. When
> > .fw_name is used there should be an associated DT binding update. I
> What do you mean by associated DT binding? does the.fw_name, for
> example, NPCM8XX_CLK_S_PLL0 need to represent in the device tree?
> > doubt the usage of .fw_name is correct though, because aren't these clks
> > internal to the controller? The .fw_name field is about describing does the
> yes the PLL clocks are internal.
> > parents that are an input to the clk controller node in DT (because the
> > controller is a consumer of these clks that are external to the device).
> >
> > So can you use the .hw field for these internal clks? Check out
> > CLK_HW_INIT_HWS() macro and friends for a possible way to initialize
> > this.
> but still, I have used devm_clk_hw_register_mux_parent_data_table
> function to register the clock mux,
> should I use  devm_clk_hw_register_mux_parent_hws function instead?
> Does this modification need to be done in all the mux parent struct?
> could you point me to some example in the Linux kernel how do you
> think that I should represent the mux clock in the NPCM8XX clock
> driver?
> >
> > > +       { .fw_name = NPCM8XX_CLK_S_PLL1, .name = NPCM8XX_CLK_S_PLL1 },
> > > +       { .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
> >
> > Maybe this is external? If so, it would be great to have this in the
> > binding as a `clocks` property.
> O.K.
>
> Thanks,
>
> Tomer
