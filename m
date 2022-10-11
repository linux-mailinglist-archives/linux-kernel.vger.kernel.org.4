Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A65FAE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJKIPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJKIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:14:49 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B7D80;
        Tue, 11 Oct 2022 01:14:36 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id z30so8021757qkz.13;
        Tue, 11 Oct 2022 01:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMcWJMFpbTv/M4gUgWn8+tSgvKlzALSNyxl0s8wbjAI=;
        b=eLAEGHtnwMfaEN5izmfmVr6AF9hKCUaLlYxuup0God7cpi5AaNb/osto+ypATjPcnI
         28AatMf7yr53sx+U3WLXrqEbw8HcoT0k2NagVTCSAxF47YspUb65DazWDiGWEYhwmjXl
         A6jS11VX1nIVtgPHIEOcThG4+eVSeG2DCKn+Pw/bDCkAaeEOUkkil50FWF3BVTmLynBm
         7I7FHqsiG9rsPEPzLu+kSWLsXC5rcnT99xcGLBNrNXhnXLjZQh1hs3YW6UdH1BndVigt
         /WsGKxbs2UPcQy3VOKEthHZe798kW3spa1FhTyUFCZkWPnMWp988BEFsJNYI7X7cfc8G
         fxeQ==
X-Gm-Message-State: ACrzQf2jtSomIcI4XIkmz9lpg/ZKcHBxMCNrZrHP1jh7N+JoN9bRECO6
        cyKy8FFFqr7z6Ap51stekL1Y9CO0ANFBkg==
X-Google-Smtp-Source: AMsMyM6cgaLIVsDGSpgxLl9PvMhg+LU4N7r++5FHoRBQd7q6Ldu8zDSMgwEez/tjMWMfJMI+rbhjhQ==
X-Received: by 2002:a05:620a:688:b0:6ec:5699:1cc5 with SMTP id f8-20020a05620a068800b006ec56991cc5mr7379171qkh.536.1665476049376;
        Tue, 11 Oct 2022 01:14:09 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id q22-20020a05620a0d9600b006c479acd82fsm12684971qkl.7.2022.10.11.01.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:14:06 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id k3so15574655ybk.9;
        Tue, 11 Oct 2022 01:14:05 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr21699902ybx.543.1665476045309;
 Tue, 11 Oct 2022 01:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221009230044.10961-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221009230044.10961-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:13:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJRHHjx2Xx6a0RjeoXuo_b2y+ahG1c5=pOe46Gcs08TQ@mail.gmail.com>
Message-ID: <CAMuHMdVJRHHjx2Xx6a0RjeoXuo_b2y+ahG1c5=pOe46Gcs08TQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: renesas: rzg2lc-smarc-som: Drop enabling WDT2
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

On Mon, Oct 10, 2022 at 1:01 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> enabling WDT2.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
