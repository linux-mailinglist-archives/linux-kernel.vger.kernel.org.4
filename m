Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B26B3EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCJMFt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 07:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCJMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:05:28 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9DEF34CD;
        Fri, 10 Mar 2023 04:05:26 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id r16so5315216qtx.9;
        Fri, 10 Mar 2023 04:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678449925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8UNkrLW/HQojg28MfnnyGYVjttNpcn/zGjRX4vMdGU=;
        b=eX7M9cdLl2JTraSX1senV5BGQ640IJDgBvnidCWcvt5YmGdBU7W/WZaJx9oTCGEU83
         S6YM7Mdf6zjpNCACSfEXQeS9MsYyhizwfqj8tnCmhCifjOzuDoeAWdiiQn9asBHkNGOZ
         xf7Qn68YKuJNRnjw0ONXfEDOUuK6ZmiokiWDD/2p66YnruXMmZ/JtGdgOec1lxV6tR2E
         7bhhc2m5kR74CK3YKVT1y+IOz3fUzF9oxJx55NsybXi6GXAuY2jqw56JYMZQwyKPEB+M
         zJLynCCC9+u6tVpCzDdQEtoGe0JxTKZEZYD4a6wWTtHTWqrAxpdpxWrezWYFjgM9wIZR
         oKPw==
X-Gm-Message-State: AO0yUKXWRBwFA6qgtlG+r3DctEIYDKJb/qJPNRPwu6BQ44sT+WkPUPzn
        ilaeW6pFjuGVjPAdzxCOBTzbXrvevLmxSg==
X-Google-Smtp-Source: AK7set+CqID7+IJqbGGixhQF4yvpRZA6GBZSshSdlfY83BI0NSeZiSrHNFvbT9TUhZBUdGkrfZFiiw==
X-Received: by 2002:a05:622a:170b:b0:3b6:3e4f:f876 with SMTP id h11-20020a05622a170b00b003b63e4ff876mr8371317qtk.18.1678449924831;
        Fri, 10 Mar 2023 04:05:24 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id c1-20020ac853c1000000b003b323387c1asm1296154qtq.18.2023.03.10.04.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 04:05:24 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id t4so4986171ybg.11;
        Fri, 10 Mar 2023 04:05:24 -0800 (PST)
X-Received: by 2002:a5b:18e:0:b0:967:f8b2:7a42 with SMTP id
 r14-20020a5b018e000000b00967f8b27a42mr12326443ybl.7.1678449923837; Fri, 10
 Mar 2023 04:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Mar 2023 13:05:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU=mCAWQNFCkkCxBkDyYTLM87QdrYMYE9hpOv1fuS=bWw@mail.gmail.com>
Message-ID: <CAMuHMdU=mCAWQNFCkkCxBkDyYTLM87QdrYMYE9hpOv1fuS=bWw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: r9a07g044: Update IRQ numbers
 for SSI channels
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Feb 17, 2023 at 7:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> From R01UH0914EJ0120 Rev.1.20 HW manual the interrupt numbers for SSI
> channels have been updated,
>
> SPI 329 - SSIF0 is now marked as reserved
> SPI 333 - SSIF1 is now marked as reserved
> SPI 335 - SSIF2 is now marked as reserved
> SPI 336 - SSIF2 is now marked as reserved
> SPI 341 - SSIF3 is now marked as reserved
>
> This patch drops the above IRQs from SoC DTSI.
>
> Fixes: 92a341315afc9 ("arm64: dts: renesas: r9a07g044: Add SSI support")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

> As this is is a fixes patch and we are still waiting for [0] to be merged
> shall do the same for V2L SoC?
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

No need to send, I cloned the above with
    s/G2L/V2L/
    s/g044/g054/
    s/G044/G054/
    s/R01UH0914EJ0120/R01UH0936EJ0120/

and
Fixes: cd0339ec25895c0b ("arm64: dts: renesas: r9a07g054: Add
SSI{1,2,3} nodes and fillup the SSI0 stub node")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
