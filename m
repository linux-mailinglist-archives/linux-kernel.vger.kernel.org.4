Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7597660C624
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiJYINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiJYIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:13:26 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC7EEF59E;
        Tue, 25 Oct 2022 01:13:25 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id l9so5031466qkk.11;
        Tue, 25 Oct 2022 01:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtQY6npOwzdAaof0U9/1BSiKAWT8zlsAxOmGaO2LJJU=;
        b=AvXnRsGDKOxy5AqK3Ijm7nbYO8iMN/1LNoV33RpqErb+ZHwBCbLVC8AbgV7Y19UL2Q
         aqGNnddQw7tQF+5WvCA4Nsxkc9oNvXYTUJMJEmlAx2mHVty42p+cZ2b00HskS12V0JSw
         Y6MAv1qkEIKAyL2K4F113Nc8PIrZPi6cVkJI5+xtfncCY1peGXNae0XM1LUDSvCZrhn6
         4Z/khKuq2cbiDA0CtmSoGaeVUDUznbfAz3aUxxN763M41+aKtSyRDo3Cet7rufF8TsDo
         EZb3ViT8YYdWTY4cj6K/Oo0G6TL6JeyvLMrcWTi7HEWRDXvsSG7UXAaEC8OTUZ5z8ohA
         5o6Q==
X-Gm-Message-State: ACrzQf1lrlCOcxMW0izo/sZFRNb65/VJxOrk2mqdEOZ43AvTYHHBqX5A
        qnyKjSb/8S4SPJYTlbOn955AbypsvbyQVA==
X-Google-Smtp-Source: AMsMyM5iweyC604cUhRZST7up1PaoYKREGcaguAShjygJaiQCRDb+XZGnpJUnnfH0ywlzjHqvVsIQg==
X-Received: by 2002:a05:620a:2686:b0:6f5:723e:6316 with SMTP id c6-20020a05620a268600b006f5723e6316mr6249327qkp.103.1666685604844;
        Tue, 25 Oct 2022 01:13:24 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id cm21-20020a05622a251500b0039c72bb51f3sm1215273qtb.86.2022.10.25.01.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 01:13:24 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-36847dfc5ccso107245067b3.0;
        Tue, 25 Oct 2022 01:13:24 -0700 (PDT)
X-Received: by 2002:a81:1b09:0:b0:35d:cf91:aadc with SMTP id
 b9-20020a811b09000000b0035dcf91aadcmr32638191ywb.47.1666685604020; Tue, 25
 Oct 2022 01:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220915165256.352843-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915165256.352843-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 10:13:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJ4gp=kT2S+5bhjdZACSbEX=3pP7mmmi_GEbeAOxtHGw@mail.gmail.com>
Message-ID: <CAMuHMdVJ4gp=kT2S+5bhjdZACSbEX=3pP7mmmi_GEbeAOxtHGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: rzg2ul-smarc: Add
 /omit-if-no-ref/ to pinmux
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Sep 15, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> In preparation to re-use the RZ/G2UL SMARC SoM and carrier DTS/I with the
> RZ/Five add /omit-if-no-ref/ keyword to pinmux entries as the support for
> RZ/Five SMARC EVK will be gradually added.
>
> Once we have full blown support for RZ/Five SMARC EVK we can get rid of
> the /omit-if-no-ref/ keyword.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

I finally had a deeper look at this...

Why do you want to disable these nodes? While they are indeed not
used yet on RZ/Five, they are valid hardware descriptions for the
RZ/Five SMARC EVK, and their presence doesn't harm anything.

I do see a valid use case for marking pin control subnodes with
/omit-if-no-ref/: you can provide all possible configurations as a
convenience for the user, so the user no longer has to look up the
numeric parameters of the RZG2L_PORT_PINMUX() macros.
But IMHO those would belong in the SoC-specific .dtsi, not in a
board .dtsi.  See e.g. the massive use of /omit-if-no-ref/ in sunxi
and rockchip .dtsi files.

Am I missing something?

> --- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
> @@ -12,12 +12,14 @@ &pinctrl {
>         pinctrl-0 = <&sound_clk_pins>;
                        ^^^^^^^^^^^^^^
>         pinctrl-names = "default";
>
> +       /omit-if-no-ref/
>         can0_pins: can0 {
>                 pinmux = <RZG2L_PORT_PINMUX(1, 1, 3)>, /* TX */
>                          <RZG2L_PORT_PINMUX(1, 2, 3)>; /* RX */
>         };
>
>  #if (SW_ET0_EN_N)
> +       /omit-if-no-ref/
>         can0-stb-hog {
>                 gpio-hog;
>                 gpios = <RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;

> @@ -94,11 +103,13 @@ sd1_mux_uhs {
>                 };
>         };
>
> +       /omit-if-no-ref/
>         sound_clk_pins: sound_clk {

FTR, this one is always referenced.

>                 pins = "AUDIO_CLK1", "AUDIO_CLK2";
>                 input-enable;
>         };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
