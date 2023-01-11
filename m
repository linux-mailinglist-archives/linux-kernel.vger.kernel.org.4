Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1480666081
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbjAKQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjAKQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:30:00 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689FECE07;
        Wed, 11 Jan 2023 08:29:34 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id h16so2768162qtu.2;
        Wed, 11 Jan 2023 08:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjrcWIBjmmPlwZTcOfDOO38h43AQNOgajs77lr03LAg=;
        b=gvZbZGhnSt6eaRePRZ2MrpMG4AamK+sJRNN7LI/52IY7iGgg+dy65NfUKeCzyfAfa+
         W3ciqyhotOLZP9seeS9s4+yo2ufjLC6Nmio2rC/qZ9d2ugkGQ8EmgQVZp+RNL9HLK9WB
         KCSo16c3mh7HmToWJPy24DYavBziuqkONNlJ5VFt9UKBvDwJTPhuaqmG3t9LThMlY530
         0rAPBObEuxxPcf1ruHqlJQmZiteKAY9IPybsBL7cNXhOS9Ks0/ovGhPcK/7/hZYLsfcz
         X6FHSb4Y8dqLOshKNPPrmfAzZKdS01guv91HdwzYnaZIYMycdFcoXpzrkJtWjKr8KYE4
         n9CA==
X-Gm-Message-State: AFqh2kq1wv/94GiLEjLsgCCDIkMn+5SI88aJMEvdczXnt5gYzHJRNOgA
        MMw7A0YbABKnwBgDXZhU4F9Gf2GQuqI03w==
X-Google-Smtp-Source: AMrXdXsUDgB+NK0Fpm3QJtCw8pkwCUFw79A9mCE9laXxleJYgXMh3P/HRxy74N8CrLQDsBmSl1FmfQ==
X-Received: by 2002:ac8:4c8c:0:b0:3a5:3134:48ac with SMTP id j12-20020ac84c8c000000b003a5313448acmr8939578qtv.3.1673454573263;
        Wed, 11 Jan 2023 08:29:33 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id d16-20020ac85350000000b003a689a5b177sm7774491qto.8.2023.01.11.08.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:29:33 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 16so15609333ybc.0;
        Wed, 11 Jan 2023 08:29:32 -0800 (PST)
X-Received: by 2002:a25:46c6:0:b0:7b8:a0b8:f7ec with SMTP id
 t189-20020a2546c6000000b007b8a0b8f7ecmr2429658yba.36.1673454572643; Wed, 11
 Jan 2023 08:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com>
In-Reply-To: <20230104141245.8407-1-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jan 2023 17:29:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWuE4L6K4ULdVLZKeLwd3xYfzkyBNrf6s7Qc2kf9b-_Cg@mail.gmail.com>
Message-ID: <CAMuHMdWuE4L6K4ULdVLZKeLwd3xYfzkyBNrf6s7Qc2kf9b-_Cg@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: beacon-renesom: Fix gpio expander reference
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Wed, Jan 4, 2023 at 3:12 PM Adam Ford <aford173@gmail.com> wrote:
> The board used to originally introduce the Beacon Embedded
> RZ/G2[M/N/H] boards had a GPIO expander with address 20, but
> this was change when the final board went to production.
>
> The production boards changed both the part itself and
> the address.  With the incorrect address, the LCD cannot
> come up.  If the LCD fails, the rcar-du driver fails to come up,
> and that also breaks HDMI.
>
> Pre-release board were not shipped to the general public, so it
> should be safe to push this as a fix.  Anyone with a production
> board would have video fail due to this GPIO expander change.
>
> Fixes: a1d8a344f1ca ("arm64: dts: renesas: Introduce r8a774a1-beacon-rzg2m-kit")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> +++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> @@ -437,20 +437,6 @@ wm8962_endpoint: endpoint {
>                 };
>         };
>
> -       /* 0 - lcd_reset */
> -       /* 1 - lcd_pwr */
> -       /* 2 - lcd_select */
> -       /* 3 - backlight-enable */
> -       /* 4 - Touch_shdwn */
> -       /* 5 - LCD_H_pol */
> -       /* 6 - lcd_V_pol */
> -       gpio_exp1: gpio@20 {
> -               compatible = "onnn,pca9654";
> -               reg = <0x20>;
> -               gpio-controller;
> -               #gpio-cells = <2>;
> -       };
> -
>         touchscreen@26 {
>                 compatible = "ilitek,ili2117";
>                 reg = <0x26>;
> @@ -482,6 +468,21 @@ hd3ss3220_out_ep: endpoint {
>                         };
>                 };
>         };
> +
> +       gpio_exp1: gpio@70 {
> +               compatible = "onnn,pca9654";

According to the patch description, the actual part was changed, too?

> +               reg = <0x70>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-line-names =
> +                       "lcd_reset",
> +                       "lcd_pwr",
> +                       "lcd_select",
> +                       "backlight-enable",
> +                       "Touch_shdwn",
> +                       "LCD_H_pol",
> +                       "lcd_V_pol";
> +       };
>  };

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
