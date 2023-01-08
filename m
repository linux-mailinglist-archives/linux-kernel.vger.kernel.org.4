Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174D9661675
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjAHQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:16:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03579C746;
        Sun,  8 Jan 2023 08:16:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso6849558pjf.1;
        Sun, 08 Jan 2023 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=szYh6U0O4rdLlceJ5Mu6MCo8pZSXN9nW69RUcTj6eOg=;
        b=eQ17HwrDwgeacRtKTqwxN1n2e/wUA7mAJCFKxVKjpEzf10u0tAzClpbcfAs9DPOXVW
         8RfySBmBTKsqPit8vpMWlMlCLC1yFya1dNLgkcPZN20e22QXpczWQrQw4CNGyfvD6V0c
         ERPpzOfkO/pUnOO+26Dy1IoJei2J3Fa6Aw16tMsACasSKJ/UE7llGMuFTNaTwWuS+1Pm
         6GenGBab5wBH7OwrAi8wbY/BHeV9Ylqk8r9Oj8aBX1Vev0mHuvdi+HENA1ZUuiD2qJTk
         KkiLhPnC099HK30wJBWZsuYdtoYfrDC7+Rbb8yRO2oWLb0yFkBvUk6mtH7Y8Kk7sjtrz
         azFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szYh6U0O4rdLlceJ5Mu6MCo8pZSXN9nW69RUcTj6eOg=;
        b=yaiLMTGdO4yJKujYuiJKnBIjl3qz+JHqYwPTx++lqkRKWduJkyduNBBfHQz4ksRJD0
         x5etSaBKKjNn9IeSOkfN3T/Wf6+cN9EAzZbWPw4MXDuVPH8cDplq0lKTMAJRBP5dGIJK
         C68QDUtZJNevd4YwR0/AqFxHNY1qphDeFCG+NzmfAvRkrY/4jgvxVpC8vpxEr1npQU2q
         YyuN7EIM+I0ak6UZWobNLqKtm+URx8rvizYnuwmCFOiKhvpMcXoR4u5uPucqlvWw2/Fl
         Kx3hZGAM3KuThd/dp+JpdUVzd1JeJSJnodyf/Wgc/U3flTQk9RI5xxjN6DkU03hiavIF
         OtkQ==
X-Gm-Message-State: AFqh2kppPyPdGm563wk26rPq3GrAe2qfMq3dhvkBcuiaO3K4fOoxnnlI
        DVKLpwFQ6ITqMmrFil3KyNlfS3STrJ5RjlCN1pKEjE7V
X-Google-Smtp-Source: AMrXdXulkLpHFTttJIn7bRE+8oIM0Vjee34mqKwknjgOSnTSYKVB3NwmesfeeSB8CT9N0TBf+bLSdrB79V1cQr8VEu0=
X-Received: by 2002:a17:903:2694:b0:192:9f8a:2e38 with SMTP id
 jf20-20020a170903269400b001929f8a2e38mr2697598plb.84.1673194604915; Sun, 08
 Jan 2023 08:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com>
In-Reply-To: <20230104141245.8407-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 8 Jan 2023 10:16:33 -0600
Message-ID: <CAHCN7xJ3eyZZm6or0N9WsGV8vsnyOBDWEoVAFyb1iamNe_AF2A@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: beacon-renesom: Fix gpio expander reference
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 8:12 AM Adam Ford <aford173@gmail.com> wrote:
>
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
Geert,

Is this patch OK as-is? This is more critical to me than the other
patches in the series.

adam

> Fixes: a1d8a344f1ca ("arm64: dts: renesas: Introduce r8a774a1-beacon-rzg2m-kit")
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
> index 8166e3c1ff4e..8b6fe235a8f0 100644
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
>
>  &lvds0 {
> --
> 2.34.1
>
