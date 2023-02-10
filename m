Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA94691B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjBJJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjBJJO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:14:29 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8E87166E;
        Fri, 10 Feb 2023 01:14:06 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id w3so5045515qts.7;
        Fri, 10 Feb 2023 01:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8GFHwVww8oer0oGvyL00kwNGTL9qnx5RyHX6+suopg=;
        b=eBWiksFzU8hB30K2NyTxzd1xb55VNwR2DD1MMrvW5ZtYxGLjc24Q3FMEgizl13pYQf
         LFac23YueM1648hnlIXMxAoBynjnnDLxmorgz5ZhPHQQfnsLqQsaYxN6ddGA2R3EWe2c
         r+buVvZRHR8T2KAI85jUA97q+vg6Wo5g83pGF3TJbC4w1848TmzPEZ/a6YQMkdKOGOkf
         TmZHUvmgNaNJlWSKpJ/WlYtGkkcSeB928WgpjC70KmlDujyBoh9eLt+wkdgIAzn0MwlE
         QXSQpFjTJTVLiUcS5JFPceSUm+Ldtgkfw14q1kaQ9uhpqmimJ/UBt5iYVgWKTZQuZfO2
         bFEQ==
X-Gm-Message-State: AO0yUKVbq5ygx3BepsuDVjTrRovANeyof11dDLk9SeaFULYIJ88YtmRH
        kPQf+DCVT+DatT1v+WL1xALamjsJ6EsA4TO2
X-Google-Smtp-Source: AK7set/8dSmexyQ4I8SYauMPhySFpnz2b2LwP8vM/6C/ptYdMfruxjM9fszR1dgvbgpvUKVSTJsmNg==
X-Received: by 2002:a05:622a:11d6:b0:3b8:4729:8239 with SMTP id n22-20020a05622a11d600b003b847298239mr10642600qtk.12.1676020445065;
        Fri, 10 Feb 2023 01:14:05 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id fp41-20020a05622a50a900b003b9a73cd120sm3021682qtb.17.2023.02.10.01.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 01:14:04 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id a1so5574748ybj.9;
        Fri, 10 Feb 2023 01:14:04 -0800 (PST)
X-Received: by 2002:a5b:24c:0:b0:87a:68fd:181a with SMTP id
 g12-20020a5b024c000000b0087a68fd181amr1770542ybp.36.1676020444431; Fri, 10
 Feb 2023 01:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20230202092332.2504-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230202092332.2504-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Feb 2023 10:13:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWGd3=vZER4bArO34zyJ2pjhXrViNp8x+8wVfNpKCZqaA@mail.gmail.com>
Message-ID: <CAMuHMdWGd3=vZER4bArO34zyJ2pjhXrViNp8x+8wVfNpKCZqaA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rcar-gen3: disable R-Car H3 ES1.*
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Feb 2, 2023 at 10:23 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> R-Car H3 ES1.* was only available to an internal development group and
> needed a lot of quirks and workarounds. These become a maintenance
> burden now, so our development group decided to remove upstream support
> for this SoC. Public users only have ES2 onwards.
>
> In addition to the ES1 specific removals, a check for it was added
> preventing the machine to boot further. It may otherwise inherit wrong
> clock settings from ES2 which could damage the hardware.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you, queuing in renesas-clk-for-v6.3, as this serves as the
main gatekeeper for preventing booting on R-Car H3 ES1.x.  Hence
it should go upstream before any of the other R-Car H3 ES1.x quirk
handling is removed (in v6.4).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
