Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B463ED25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiLAKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiLAKDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:03:19 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891BC1C931;
        Thu,  1 Dec 2022 02:03:18 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id j26so771634qki.10;
        Thu, 01 Dec 2022 02:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7orI/+fp6P+9YeMZGsDnPDJ3YP/9fqlxMdclgUX5LM=;
        b=vcSZENOxUa4EY7f8um8RDR68OCZwLXYm2ogXy9mg/2JSCe9smUZZHpY55XUo4tCEhc
         ZJLE61Z8hc3c09aW7rY2NoSN+tYH2HoWS20XR5SW6Y8/cE1yKcpGkeWeOMTQdr7WwOBE
         l/67FXKgjgE64/FSaOVr7WJVsj6atQc+Q0EmNPglfIhQzwwYetdkPgzIx7iemjC2+Dei
         VJC0t+4mROROx/dnJpDI4K9uffwMH2Rx9FUKI7Di4fr7QoT36J1xESos2sLiAyX+thsD
         GQMEu56gRmxh4ZHKTkujW+z/XAgzGADkzUEFpVxrdV2UzJ9wt5/14d3Qj+/n4ZPbwSrR
         ED/A==
X-Gm-Message-State: ANoB5plWtuc9qgCincPO1u1ds+dE3kohtb7Ll5MQmtv72Q/z0Qwuicgb
        QK0OXoqckCHcu0Qa0BLIFTvuqUJEgDJfFA==
X-Google-Smtp-Source: AA0mqf5DEZNSUfrmASADZq4Wp8R0zRDo0i26JifgvihuB1DhAm6Mg5A6flCCf3qyBBcyOxeE8An7NQ==
X-Received: by 2002:a05:620a:31aa:b0:6fa:1745:46ee with SMTP id bi42-20020a05620a31aa00b006fa174546eemr40868963qkb.163.1669888997083;
        Thu, 01 Dec 2022 02:03:17 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a2a1500b006eeb3165554sm3218118qkp.19.2022.12.01.02.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 02:03:16 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id v206so1364142ybv.7;
        Thu, 01 Dec 2022 02:03:16 -0800 (PST)
X-Received: by 2002:a25:d655:0:b0:6fc:1c96:c9fe with SMTP id
 n82-20020a25d655000000b006fc1c96c9femr1249230ybg.36.1669888996192; Thu, 01
 Dec 2022 02:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com> <20221123065946.40415-6-tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <20221123065946.40415-6-tomi.valkeinen+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Dec 2022 11:03:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVy+cfDLsCWA0z-xF+Rr0g4hLSROry-m+=eZSBEsuLa_w@mail.gmail.com>
Message-ID: <CAMuHMdVy+cfDLsCWA0z-xF+Rr0g4hLSROry-m+=eZSBEsuLa_w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: renesas: white-hawk-cpu: Add DP output support
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
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

Hi Tomi,

On Wed, Nov 23, 2022 at 8:00 AM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> Add DT nodes needed for the mini DP connector. The DP is driven by
> sn65dsi86, which in turn gets the pixel data from the SoC via DSI.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3, with the mini-dp-con node
moved up.

> --- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
> @@ -97,6 +97,15 @@ memory@600000000 {
>                 reg = <0x6 0x00000000 0x1 0x00000000>;
>         };
>
> +       reg_1p2v: regulator-1p2v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "fixed-1.2V";
> +               regulator-min-microvolt = <1200000>;
> +               regulator-max-microvolt = <1200000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +
>         reg_1p8v: regulator-1p8v {
>                 compatible = "regulator-fixed";
>                 regulator-name = "fixed-1.8V";
> @@ -114,6 +123,24 @@ reg_3p3v: regulator-3p3v {
>                 regulator-boot-on;
>                 regulator-always-on;
>         };
> +
> +       mini-dp-con {
> +               compatible = "dp-connector";
> +               label = "CN5";
> +               type = "mini";
> +
> +               port {
> +                       mini_dp_con_in: endpoint {
> +                               remote-endpoint = <&sn65dsi86_out>;
> +                       };
> +               };
> +       };

Moving up while applying to preserve sort order...

> +
> +       sn65dsi86_refclk: clk-x6 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <38400000>;
> +       };
>  };
>
>  &avb0 {

> @@ -172,6 +216,51 @@ eeprom@50 {
>         };
>  };
>
> +&i2c1 {
> +       pinctrl-0 = <&i2c1_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       bridge@2c {

Ideally, this needs pinctrl for the intc_ex irq0 pin.
Unfortunately[1] is still in limbo as the naming of the alternate pins
is inconsistent.

> +               compatible = "ti,sn65dsi86";
> +               reg = <0x2c>;
> +
> +               clocks = <&sn65dsi86_refclk>;
> +               clock-names = "refclk";
> +
> +               interrupt-parent = <&intc_ex>;
> +               interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               enable-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +
> +               vccio-supply = <&reg_1p8v>;
> +               vpll-supply = <&reg_1p8v>;
> +               vcca-supply = <&reg_1p2v>;
> +               vcc-supply = <&reg_1p2v>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               sn65dsi86_in: endpoint {
> +                                       remote-endpoint = <&dsi0_out>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +                               sn65dsi86_out: endpoint {
> +                                       remote-endpoint = <&mini_dp_con_in>;
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
>  &mmc0 {
>         pinctrl-0 = <&mmc_pins>;
>         pinctrl-1 = <&mmc_pins>;

[1] "[PATCH/RFC] pinctrl: renesas: r8a779g0: Add INTC-EX pins, groups,
and function"
    https://lore.kernel.org/all/28fe05d41bea5a03ea6c8434f5a4fb6c80b48867.1664368425.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds
