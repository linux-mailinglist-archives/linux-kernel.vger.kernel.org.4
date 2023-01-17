Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5716466E534
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAQRr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjAQRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:46:05 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73F58294;
        Tue, 17 Jan 2023 09:35:48 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a37so8014126ljq.0;
        Tue, 17 Jan 2023 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eqwxXzbfJuwcyGV/f2tlqmYfB0CiqMfLfLaQcdfnmUc=;
        b=MyCE+2jZcl1rM9cMmvHpoG06LRLV/svFtYCoO7JmE82low/a5o3Cem3f5q1BtoQX8v
         sFW+sal/QrDLsHz8gQ64WHxjZovKa7Y/mfCCSAp65ek67BRv+ygF8vlRveB89Uz0jfTk
         LYTsDuhBYjsRPL1z3Pt4OfNEl3YtsdA2xBqLhb2bEVpoPtGLewff/XmAGKcFVI/tikRj
         IsWx5dmwQ/f2mJqw2EeSOEfdaSq8IxD8b7h08djbGInpi6XK/7dbEorU9q6EBr/gopcT
         UeTUv1QV3st+GxOzcbh3UIuwT9dn3nmnwwiQkntfEUCGw7TAVLidEsZFinZk7ivPGmgd
         SIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqwxXzbfJuwcyGV/f2tlqmYfB0CiqMfLfLaQcdfnmUc=;
        b=R7XmSYhiZTJNmzYGolU0Tk5nT+/QJu0MMsxEYU1PeKE/vBmsFPilyIeu3JgVEUxNJw
         l6fxmekk2ZTigmB4MYvkj9JlWMtUA1BdfPcGOJNemM1gTBoWZ61AducsYgxAsT6qTKhQ
         oPsbyjM7pcpJubj+oHtr0CUh1lnoOznhYYquLITRYUIk2QqRYSB9OJJ67cW/ryJFd2V+
         +huAsCtzYSPF3QA9Bd1+owV2whrAs7+8y+F+vLYh6nd7njy88hljUyORKBhPExVdjOEu
         vZEfC3HOzJcb3gBIajNKyFxNw5Z6U8XoWz18AKAY2uw2En4bKhL9EDRbmy+KRYultxcT
         4i+g==
X-Gm-Message-State: AFqh2kq2ZMIbA2mqerYMwyF4M9f4Mn047J3vxMmHeFdIcudjPmQjLD5P
        0hbQ2F+T7a6Y6M/WC8xmZ2TFgdN2SYSlhXtio3k=
X-Google-Smtp-Source: AMrXdXtTvhPNqCVQYqglQf+ISfVQE7hLx5JKwaKAIPT/rLf6I8GI1A9GLS3VUlQLvSF000OVBErwGm6Ra1X22JJ+XZU=
X-Received: by 2002:a2e:9c83:0:b0:287:4e8e:2139 with SMTP id
 x3-20020a2e9c83000000b002874e8e2139mr427811lji.73.1673976944884; Tue, 17 Jan
 2023 09:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20221211204324.169991-1-tmaimon77@gmail.com> <20221211204324.169991-2-tmaimon77@gmail.com>
 <20221216184402.8A426C433D2@smtp.kernel.org>
In-Reply-To: <20221216184402.8A426C433D2@smtp.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 17 Jan 2023 19:35:33 +0200
Message-ID: <CAP6Zq1iPmy-fvqqAwBuoskR18v0dPVwYm0tEcE5h1g8fOiOQvg@mail.gmail.com>
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

Very sorry for the late reply.

On Fri, 16 Dec 2022 at 20:44, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2022-12-11 12:43:24)
> > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > new file mode 100644
> > index 000000000000..08ee7bea6f3a
> > --- /dev/null
> > +++ b/drivers/clk/clk-npcm8xx.c
> > @@ -0,0 +1,650 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> [...]
> > +#define NPCM8XX_CLK_S_RCP        "rcp"
> > +
> > +static const u32 pll_mux_table[] = { 0, 1, 2, 3 };
> > +static const struct clk_parent_data pll_mux_parents[] = {
> > +       { .fw_name = NPCM8XX_CLK_S_PLL0, .name = NPCM8XX_CLK_S_PLL0 },
>
> As this is a new driver either you should only have .fw_name here. The
> .name field is a backup to migrate code over to a new binding. When
> .fw_name is used there should be an associated DT binding update. I
What do you mean by associated DT binding? does the.fw_name, for
example, NPCM8XX_CLK_S_PLL0 need to represent in the device tree?
> doubt the usage of .fw_name is correct though, because aren't these clks
> internal to the controller? The .fw_name field is about describing does the
yes the PLL clocks are internal.
> parents that are an input to the clk controller node in DT (because the
> controller is a consumer of these clks that are external to the device).
>
> So can you use the .hw field for these internal clks? Check out
> CLK_HW_INIT_HWS() macro and friends for a possible way to initialize
> this.
but still, I have used devm_clk_hw_register_mux_parent_data_table
function to register the clock mux,
should I use  devm_clk_hw_register_mux_parent_hws function instead?
Does this modification need to be done in all the mux parent struct?
could you point me to some example in the Linux kernel how do you
think that I should represent the mux clock in the NPCM8XX clock
driver?
>
> > +       { .fw_name = NPCM8XX_CLK_S_PLL1, .name = NPCM8XX_CLK_S_PLL1 },
> > +       { .fw_name = NPCM8XX_CLK_S_REFCLK, .name = NPCM8XX_CLK_S_REFCLK },
>
> Maybe this is external? If so, it would be great to have this in the
> binding as a `clocks` property.
O.K.

Thanks,

Tomer
