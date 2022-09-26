Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73F55EA749
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiIZNak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiIZNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:30:11 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB821DB566;
        Mon, 26 Sep 2022 04:53:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i3so3888769qkl.3;
        Mon, 26 Sep 2022 04:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mVuGJPGJe2H+3+FixPWiruk+UJOFvQNy8mtyw4ti/gs=;
        b=lfIaCJtsilZce/5dgOUpHw7EzBToAwvGukuki8q/l3F9WFkG/FmtBB/sDKim1KHNLq
         9GZSgdN++YfOiTp86wzJm3bH/R4SukeQfun8hMRcQ6U5nYweIYTpZcHK+VnWaR2oGNBN
         zNzIlyIjTS22RaX129cRIMcsZaFlF8hfEj3uolZWViXMmwkiCMcgLW32wtEwzUgOFceO
         Z3HTZffPsfAqen1OM+1n5I65doNYAIMvGbD1wPum/gQD/DzR9OL66cUfbds4Td/8PqM7
         YEBiYCfD6YoG5ZkTBERLdz7PUwOYbEm9YAm6WukN6pXI12nkG6YbCM2yDnm0CYXACQp7
         hERg==
X-Gm-Message-State: ACrzQf3YOZ3eg0vfvX5kS0VV/Sz6sYP7hUzr4cmw+k25f5aEvJp8JQF+
        4sWjLJ+Lg/d4kPUBbM6iL9QM4ScYsUS4+Q==
X-Google-Smtp-Source: AMsMyM6201Ll1guJSciLRUZqAwkQ/Q7CDaM6WPu3mXZ5b0UozLIJDadSyILgnzI75/0feM52MTnInA==
X-Received: by 2002:a05:620a:1103:b0:6ce:a0f6:90da with SMTP id o3-20020a05620a110300b006cea0f690damr14037502qkk.101.1664193102779;
        Mon, 26 Sep 2022 04:51:42 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006ce515196a7sm11381825qkh.8.2022.09.26.04.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 04:51:42 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3511e80f908so2601127b3.2;
        Mon, 26 Sep 2022 04:51:42 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr19418082ywc.316.1664193101855; Mon, 26
 Sep 2022 04:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220921080051.5604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220921080051.5604-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 13:51:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULe59ZDysdLzyYTwXa0SXvLm7sGVOVjZ40r05h0sXmRA@mail.gmail.com>
Message-ID: <CAMuHMdULe59ZDysdLzyYTwXa0SXvLm7sGVOVjZ40r05h0sXmRA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rzg2l: Fix typo in function name
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:01 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fix typo, rzg2l_mod_clock__get_sibling -> rzg2l_mod_clock_get_sibling
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
