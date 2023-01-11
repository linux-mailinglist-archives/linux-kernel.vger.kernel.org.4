Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8DA665F29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbjAKPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbjAKPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:32:01 -0500
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA64FE014;
        Wed, 11 Jan 2023 07:31:59 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-4c15c4fc8ccso199824457b3.4;
        Wed, 11 Jan 2023 07:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWWK6I7J26Ex/aS6RPMJ/FobgR20kblYkBrs1gZdrv8=;
        b=gqxexgJNamrQERS9rrvY51LyAl9oZqDgticUK0EYy1YIoi6j7/XIKCMu1l/pDijJQS
         i9cxWwXx4yKcGPQDZMHNFjelMOF5FVE3CH6ev/8sVnW/qj2WR5Cdzo42M3qxc7vtam9T
         Lc2yYlWjJytAwsHERq9BK+h5TPQTJZlTv8oZ8mNUdZiyiSNW5ROSk0ze3eFaX6Ih+5NV
         Rq3cZKBdij/zswrTXLewu2JjFo6FIoxTcmLfJs/0h48Za/SHIVAR2gwQTSSkXzmxRPyX
         cTTwC/XQcm4rwDXgEDnuWy3ftnBeOLDXHPhffFMyHU5XtMEWy2vSTM+xlJ5Vgr0bMS3n
         HVOA==
X-Gm-Message-State: AFqh2kro29SpQf7UGrqqRBuUimm32cwp20MwQYttxT2q8+thH4oSlhUT
        tfmDKY5jaGcSjbNVgmWv3cKqzzXps/104A==
X-Google-Smtp-Source: AMrXdXs8e4HQdOVIfhEQvlc99qBR22LN9wW9bqTc2/kXvYMgXKkvkzVhExSesw0xb8437Q8H9uUIgg==
X-Received: by 2002:a05:690c:b14:b0:470:a693:8fd2 with SMTP id cj20-20020a05690c0b1400b00470a6938fd2mr12767497ywb.4.1673451118659;
        Wed, 11 Jan 2023 07:31:58 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n21-20020a05620a295500b00704c6263924sm9226768qkp.13.2023.01.11.07.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:31:58 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id p188so15391981yba.5;
        Wed, 11 Jan 2023 07:31:58 -0800 (PST)
X-Received: by 2002:a25:d84e:0:b0:7b4:6a33:d89f with SMTP id
 p75-20020a25d84e000000b007b46a33d89fmr1631365ybg.543.1673451117777; Wed, 11
 Jan 2023 07:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20221221212703.348278-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221221212703.348278-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jan 2023 16:31:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQ-mecRFyLRhFnSdG2L-P+MTUudsqKouGY85Nw=eLWgw@mail.gmail.com>
Message-ID: <CAMuHMdWQ-mecRFyLRhFnSdG2L-P+MTUudsqKouGY85Nw=eLWgw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g044: Add clock and reset entries for CRU
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:32 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add CRU clock and reset entries to CPG driver.
>
> CRU_SYSCLK and CRU_VCLK clocks need to be turned ON/OFF in particular
> sequence for the CRU block hence add these clocks to
> r9a07g044_no_pm_mod_clks[] array and pass it as part of CPG data for
> both RZ/G2L and RZ/V2L SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
