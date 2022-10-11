Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF85FAE48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJKITu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:19:48 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D427C140A7;
        Tue, 11 Oct 2022 01:19:46 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id a18so5142473qko.0;
        Tue, 11 Oct 2022 01:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlyNfj0a7dGLJLnND8iCa6F2UpgFM8hbpwL3tXCOrfM=;
        b=4/CSVFK50Usfeye+WIIVnGkEZNJWHSgb9fSaPAfePYLrGW5z0ptpRX0W86Oa8Kj2aS
         xjEv12wztYDqn5psmq7/8539mHcopqh7H3bbwwzKAO5aQmrdcYEYUWOFCW9zAa5ByX0v
         aLJ9dSKXZ1TtjnxuyPTOz9+m4lD+VQlHrwyiD6kNDrBEUWOz4bpZ8gXxUHbLh8E6Vbmc
         swrpFiCHQ1Zbn2LxrqopEs/RUe1AjEZcP8qA/jV1MCwjxa7DDILGvSVFfEPvETA4XPRJ
         7LMTe8N6EFgvGVU0d3kQ5uhXaVdMJr3jJcg0ej9Qw7Fh/ww7h+Ya4z+hsRuZjZILlR3l
         RBXA==
X-Gm-Message-State: ACrzQf0NUrTFIFF53B+MKylXm3ZnZDzCnvpYrHZLh3SWgiiVSMh0UDd8
        1ArwveJm8pxOqWzfyhH83KQIvTepOVZ2Lw==
X-Google-Smtp-Source: AMsMyM7G8+AuUE8isWfrRIyPILtWIrX7KPzxSr9kJ6X2ilRvpjATG9wWlW6hWkvsgei96p2QGBeP6A==
X-Received: by 2002:a05:620a:17a8:b0:6ce:99f0:7626 with SMTP id ay40-20020a05620a17a800b006ce99f07626mr15531857qkb.194.1665476385608;
        Tue, 11 Oct 2022 01:19:45 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id c24-20020a05620a269800b006b5cc25535fsm12396804qkp.99.2022.10.11.01.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:19:45 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id k3so15588067ybk.9;
        Tue, 11 Oct 2022 01:19:44 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr20488877ybb.604.1665476384274; Tue, 11
 Oct 2022 01:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221009230044.10961-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221009230044.10961-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221009230044.10961-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Oct 2022 10:19:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcvfWVid+bFFENFDXe9eG32J=OxzSp95+myk=ADdao=w@mail.gmail.com>
Message-ID: <CAMuHMdWcvfWVid+bFFENFDXe9eG32J=OxzSp95+myk=ADdao=w@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r9a07g054: Drop WDT2 node
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

Hi Prabhakar,

On Mon, Oct 10, 2022 at 1:01 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> WDT CH2 is specifically to check the operation of Cortex-M33 CPU and if
> used from CA55 CPU would result in an unexpected behaviour. Hence drop
> WDT2 node from RZ/V2L SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
> @@ -1000,21 +1000,6 @@ wdt1: watchdog@12800c00 {
>                         status = "disabled";
>                 };
>
> -               wdt2: watchdog@12800400 {
> -                       compatible = "renesas,r9a07g054-wdt",
> -                                    "renesas,rzg2l-wdt";
> -                       reg = <0 0x12800400 0 0x400>;
> -                       clocks = <&cpg CPG_MOD R9A07G054_WDT2_PCLK>,
> -                                <&cpg CPG_MOD R9A07G054_WDT2_CLK>;
> -                       clock-names = "pclk", "oscclk";
> -                       interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> -                                    <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupt-names = "wdt", "perrout";
> -                       resets = <&cpg R9A07G054_WDT2_PRESETN>;
> -                       power-domains = <&cpg>;
> -                       status = "disabled";
> -               };
> -
>                 ostm0: timer@12801000 {
>                         compatible = "renesas,r9a07g054-ostm",
>                                      "renesas,ostm";

As this is hardware description, and the node is disabled by default,
we could keep it.  However, as it is to be used by the CM33, its
interrupts property should point to the CM33 NVIC instead of the
CA55 GIC.  So let's drop it for now...

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
