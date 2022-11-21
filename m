Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0EB631CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKUJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKUJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:40:22 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E17A27924;
        Mon, 21 Nov 2022 01:40:22 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id z1so7615263qkl.9;
        Mon, 21 Nov 2022 01:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4rlrAyktGkWb1x+yDeRfOg4XirV9skGgXAar9V+0cQ=;
        b=4vwD8acsVUPGX4jHGaSCbLvYTdj7cDv4tTV8l5MJOjdu9wgNZ0rQisFs6OqzFtWKcd
         JY/jiHBo0J3zVHFlyFoqM95WoarIqpn1eYoWoMEdKvJRLQcrQxGxUkKnQqppNElN2dIM
         KbNc4dJgVh3oOYP4kevdObSJctOmnbrUg2+nTpJ9j2fwPBvjgULk8cXdFvJzGdoFG9B2
         iMF4TAy3jNeQTqrUW4SaTMQ1Zgz7y1o1hipAZHAjsSxO9ujKVYEr5rOGvyT30elicK/O
         sh6qtwj11vEwBFTX4VH77cWWpRmRmGix8SDHPi6nwwLWYFfXpH5/R5I+HZ/qzwYAWfz9
         NTtg==
X-Gm-Message-State: ANoB5pmYlF5hOdbt0RtM4JyhgrTKedCojttOrChekcG5CI3gri+TK02w
        onRSH4E/GNPMjdIg9x3ItV1EAzfQcVXp4Q==
X-Google-Smtp-Source: AA0mqf6fOWvmeTQ6MzCmcM6EH+ADibwQEV8jtGJlNumKXXP1ZQMP/U5yjrdtXIZ4GdxVyIZ9nwbgXA==
X-Received: by 2002:a05:620a:1014:b0:6ce:4418:16d6 with SMTP id z20-20020a05620a101400b006ce441816d6mr15160699qkj.138.1669023621136;
        Mon, 21 Nov 2022 01:40:21 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006fb112f512csm7998204qkp.74.2022.11.21.01.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:40:19 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 205so12907207ybe.7;
        Mon, 21 Nov 2022 01:40:19 -0800 (PST)
X-Received: by 2002:a25:4289:0:b0:6ca:e43:d9ff with SMTP id
 p131-20020a254289000000b006ca0e43d9ffmr15779488yba.543.1669023619176; Mon, 21
 Nov 2022 01:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20221118133829.12855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221118133829.12855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:40:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuP6zYK4zupbMfQQ-RS2SNSOd3NKGoSNBH6gS9FSiw=Q@mail.gmail.com>
Message-ID: <CAMuHMdUuP6zYK4zupbMfQQ-RS2SNSOd3NKGoSNBH6gS9FSiw=Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 2:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The WDT block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-wdt" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rzg2l-wdt" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
