Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4986465BC67
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbjACInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbjACInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:43:15 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240872C2;
        Tue,  3 Jan 2023 00:43:14 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id h21so24042590qta.12;
        Tue, 03 Jan 2023 00:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFTADltuEOcFi+js1tUqPDxEjy9GD4qbBgNy0+3Wats=;
        b=bs6lKAVWh6fdi09IfJ645mEe4jM0Xf3fqTPtAxQ6CVb1JdwSUXnCdK+h4RdNG9G3Ah
         SW82OYatCsXxih2lNwffunkEcKyfkxOL+eO1Rkfv8vObxvBjNAl7JY5x3eblKM/WURRi
         Uz08BbGh9a9UYDfjbceaqj5VADrEbZml51kTqwvezJTPPm9kXOs+bFGEBRXfbtx/UKto
         yzrgGMm3H6FwssBvIwX/GNmUkDgu65f6eTz4wJ95GYgpp2XyVIlYqXSd8KLg7aqk0I6j
         Vigw02ZRbHwg/iIaNHLBZgHjjZvjJcTA+afarH1i7dzzHxnN469J/dHoeRTK7AVoDqgR
         CuXQ==
X-Gm-Message-State: AFqh2krZTgcau1NDPOYk7Ikulg8up9bXT9YSotnf5sHf88VEKYzY929/
        yBZ756/44DJXA6BhE/9dbBguDZeHqe7sIQ==
X-Google-Smtp-Source: AMrXdXt8R1T15eRZITV0dvUpNmG7jcHx5j58YgNlhu9Bhqgz0bShhO9BYwZOKNWRw+688j8NGygUFg==
X-Received: by 2002:ac8:748f:0:b0:3a5:2704:d4bd with SMTP id v15-20020ac8748f000000b003a52704d4bdmr65211632qtq.16.1672735392802;
        Tue, 03 Jan 2023 00:43:12 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id m26-20020ac8445a000000b0039cb59f00fcsm18660598qtn.30.2023.01.03.00.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:43:12 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-482363a1232so272884277b3.3;
        Tue, 03 Jan 2023 00:43:11 -0800 (PST)
X-Received: by 2002:a81:7309:0:b0:475:f3f5:c6c with SMTP id
 o9-20020a817309000000b00475f3f50c6cmr4442904ywc.358.1672735391658; Tue, 03
 Jan 2023 00:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221221000242.340202-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <170665b6-161a-6dd0-6ceb-199277c0ce2f@linaro.org>
In-Reply-To: <170665b6-161a-6dd0-6ceb-199277c0ce2f@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 09:43:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV0D8kh3xhKpWOUjTa9MzC3jEDJ5evKAJD6hV1w+pMBZw@mail.gmail.com>
Message-ID: <CAMuHMdV0D8kh3xhKpWOUjTa9MzC3jEDJ5evKAJD6hV1w+pMBZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: interrupt-controller: irqc-rzg2l:
 Drop RZG2L_NMI macro
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Thu, Dec 29, 2022 at 9:46 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 21/12/2022 01:02, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > NMI interrupt is not an external interrupt as compared to IRQ0-7 and
> > TINT0-31 on RZ/G2L SoC, so there is no need for RZG2L_NMI macro.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1 -> v2
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Given
https://lore.kernel.org/all/CA+V-a8vb-PfzMWX=ndF8nsyYVbkfYBkAQZ-UoS9zpQPndL871Q@mail.gmail.com
I think this patch is planned to be dropped, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
