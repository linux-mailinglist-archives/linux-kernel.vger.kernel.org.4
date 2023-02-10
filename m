Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1845691D36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjBJKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjBJKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:49:43 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8C125A0;
        Fri, 10 Feb 2023 02:49:42 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id g8so5186456qtq.13;
        Fri, 10 Feb 2023 02:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NI+Ulfiznd1ImFYLxjiRQYK5luMUoTyiaBcUwp8/4A=;
        b=sxU0D/0vDWXsXcEQClCWMfnqzEaz2THBXt3b+SpzCZLKcuqdOsA+/u4m94PSW0bW0z
         PaB/icRtfQVqzxoBE+D2p0BQTD4iRe1bcypMAw7fLnJdde2mpJRolj7e0/qHFoehzq+y
         bC2yQjwiIwlCGvQIGj06vwY3XJE3a4uoFHgXLrbZGWKdkyP30Nc/8CQnWTEQd22iazmT
         hLR1nm0vVdsNx5aJatkFboW3RYhOmEaLFTFhRuyLj4ndMAmuUuCofTHwbmDgk9V2HneO
         q1gRR9HS8zXuE5wmtEbCOrnzYCaS2k5BoxP42eUeGdhwsAOJS+vq9BuEpHg3eK288Gbx
         IXaA==
X-Gm-Message-State: AO0yUKW7aN87q5nNeygnVZGS7NQacWABgGW2R4mYZ6QzSprtC1Ztr1Q/
        fr03pseHNgy49ttBjg540e5LwwyjxzwMMVJu
X-Google-Smtp-Source: AK7set9BF7muU9vtMoGLRxVqsoQcIF/xh019wYR+OXvcVujzYqs3BLCcFl6O/sCrq9U7W8eNt9DEAg==
X-Received: by 2002:a05:622a:47:b0:3b8:6b3c:a37 with SMTP id y7-20020a05622a004700b003b86b3c0a37mr28263396qtw.6.1676026181961;
        Fri, 10 Feb 2023 02:49:41 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 136-20020a370c8e000000b00706aeebe71csm3290729qkm.108.2023.02.10.02.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 02:49:41 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id a1so5830163ybj.9;
        Fri, 10 Feb 2023 02:49:41 -0800 (PST)
X-Received: by 2002:a25:8e84:0:b0:8be:8c5f:9d58 with SMTP id
 q4-20020a258e84000000b008be8c5f9d58mr1003355ybl.202.1676026180798; Fri, 10
 Feb 2023 02:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20230206001300.28937-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230206001300.28937-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Feb 2023 11:49:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+Az_yda0nTzn5teeQ2V7brQsmtZx6RUzBQsok3LxVKw@mail.gmail.com>
Message-ID: <CAMuHMdV+Az_yda0nTzn5teeQ2V7brQsmtZx6RUzBQsok3LxVKw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
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

On Mon, Feb 6, 2023 at 1:13 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the performance monitor unit for the Cortex-A55 cores on the
> RZ/G2L (r9a07g044) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Fixed interrupt type

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
