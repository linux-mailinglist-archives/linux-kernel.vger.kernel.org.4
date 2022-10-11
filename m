Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA9A5FAE57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJKIYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJKIYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:24:44 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0763E60F7;
        Tue, 11 Oct 2022 01:24:42 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id 8so584488qka.1;
        Tue, 11 Oct 2022 01:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Uw1cmORZocU1edVD2sftuYrS4ha7u4YJ60SusOC6Dc=;
        b=vDkOTkHg0qh4Ng1sqSh3spPu10yn4FybOGJMPwUTbFnwg0RMOk/sAc0dxCzhHosAmV
         b32YGM/z7GrkgPf7quNfmJx/dqk41XxrAvJMeAsQudWhAaQiC71ln3ylZUiNNZIzS0iI
         LN6jCZIhZK1+CuoTB0n1c/NASC5oYOt+ra0JBSHC3K5HWfw7SeY8g6EeTw7GfPfQJk60
         FS2kFdXXPpK5S1z8ihGXxtZbDPaogx9eH3X9Ai1ADn3uwk+sxMczVg0628X4xubUHz6o
         KAc81hLo6Bbx2QYYDBERNBbohUg5o11d0edZ2xmCnulY/Zwxd/UFUeOFK/sxqR4eUvjC
         zkzQ==
X-Gm-Message-State: ACrzQf0N0urGKPyGUwOI+SxeEFFucP93mY+09H+6FCXIZuNwDD5G7opw
        gpT0g483XHB6kJjhNOpUEb/+DVa1GhY4Mg==
X-Google-Smtp-Source: AMsMyM6bcN+VVUQk8YbXTPCPnDt1Son9fMHty9psTCgkWOIBikSnc2ppECydu7n1gnQnAKdze6K0NA==
X-Received: by 2002:a05:620a:2892:b0:6cf:60a0:84ec with SMTP id j18-20020a05620a289200b006cf60a084ecmr15066142qkp.574.1665476681344;
        Tue, 11 Oct 2022 01:24:41 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id t24-20020a37ea18000000b006e42a8e9f9bsm12316713qkj.121.2022.10.11.01.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:24:41 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 81so15629451ybf.7;
        Tue, 11 Oct 2022 01:24:40 -0700 (PDT)
X-Received: by 2002:a25:3a02:0:b0:6bb:fce3:7b06 with SMTP id
 h2-20020a253a02000000b006bbfce37b06mr22250962yba.89.1665476680562; Tue, 11
 Oct 2022 01:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221009231253.15592-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221009231253.15592-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:24:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVUaMo5wEJweOqPRQ_a6Ojy0suLBjCWX38LXACUHnt7vA@mail.gmail.com>
Message-ID: <CAMuHMdVUaMo5wEJweOqPRQ_a6Ojy0suLBjCWX38LXACUHnt7vA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g043: Drop WDT2 clock and reset entry
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 1:13 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 clock and reset entries.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
