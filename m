Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC46691D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjBJKub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjBJKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:50:28 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6C25961;
        Fri, 10 Feb 2023 02:50:27 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id g18so5221062qtb.6;
        Fri, 10 Feb 2023 02:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O+2tRhhMEhJk0xerV5ZsGPUconQ4LMJbYywKMwuYMY=;
        b=dawCNqvwwyZyvnxRIWC3V/l28N0Kpwmfg3WZNRaou3Mw5keMkY+NyP8A7fjlXGy9qj
         CX2ElihkvDvRIpdlg6vi26iJtnotTVxLU35fmr1WJm2owqurXpqmigr8tuv8BRhwj0db
         uV72r84OT264M/T6sD1/UHKwlJSY1B/GBFAfir9ctu/RXrKIucGV/qkUvK/CGpIE38rl
         XEdwh6KzqlNC03Xe35YxafZHhWwOYMT4hAREU8RQ465CD+JpsubJRp00W9QwbM/wZcnp
         FxF+RE7WK6ul83JNzGCu6uC2691dNtiyJigu0iLVydYOlJV4s4r5gceEiADe8zsH3f6L
         hXPQ==
X-Gm-Message-State: AO0yUKVGMKNFisvB74FOchpGP/m2nZXRmI30q2RBNNdx3AtpJi+e1DC1
        yykce2qpK5lemer0bzh0rPxktA0Jsy3kbVM+
X-Google-Smtp-Source: AK7set9DlPqPatmhNSus+QWhlhW2YXO+sFMWNwTM/VbJmRLpOUkbQvF1zV4ryvILvqzBgYlK2o/r5g==
X-Received: by 2002:a05:622a:146:b0:3b8:2033:78e3 with SMTP id v6-20020a05622a014600b003b8203378e3mr25474178qtw.55.1676026226377;
        Fri, 10 Feb 2023 02:50:26 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id l26-20020ac8459a000000b0039cc0fbdb61sm3135458qtn.53.2023.02.10.02.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 02:50:26 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id t1so5885153ybd.4;
        Fri, 10 Feb 2023 02:50:25 -0800 (PST)
X-Received: by 2002:a25:eb04:0:b0:7b4:6a33:d89f with SMTP id
 d4-20020a25eb04000000b007b46a33d89fmr1159076ybs.543.1676026225771; Fri, 10
 Feb 2023 02:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20230206001133.28776-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230206001133.28776-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Feb 2023 11:50:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWaBvx05Oio6i3j4ZG=HCryWOrCAsL76SAftFkv5Y1MRw@mail.gmail.com>
Message-ID: <CAMuHMdWaBvx05Oio6i3j4ZG=HCryWOrCAsL76SAftFkv5Y1MRw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r9a07g043u: Add Cortex-A55 PMU node
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 1:14 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the performance monitor unit for the Cortex-A55 core on the
> RZ/G2UL (r9a07g043u) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1 -> v2
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
