Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E3A62D94E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbiKQLUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbiKQLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:20:35 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70B013EBC;
        Thu, 17 Nov 2022 03:20:34 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id h10so948914qvq.7;
        Thu, 17 Nov 2022 03:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3UsUK/TjT1z93KhLxxghxMW8cugHnHa5KSXtnbw2b0=;
        b=taT7a/3Zt2Qr1IFRaUCiypjwG0bz83jtmD+LIn94Wm6f/n3WBiP9/jTvD6GkZT+8eV
         SD4CCWdkW4k3Qz9pxdRjtMaym8FVqGgjhQw1q9hhmfTzlG3xdIcfZl1yxZQSBycE8nDX
         tEFZxBbpkvetcjTijkN2FdIzvQ1S4DrYD9XfTK3gr9CaJl0qtP1rcHjYfPfjkNCer/pk
         ivaeWMtqlirh7gjFk0IgN7K2p6sLItGs51OF8hoeCnuiOOFGJR0Bq/gAlOrpMhHEvfsi
         dd1pnxNVGeo3430BXpbTN5kZOgo46W7alge/3IUzsYOpo/zrlfBLnTxpPa5+4TZiYFUm
         MA9w==
X-Gm-Message-State: ANoB5pkVD2s2jgrTvZ0xKL3euNHfK6X+zO1WK1tOoVRYK1FKjQBg1h7p
        tgLfY/FuW74QEQuUkS3mPj4Im/SMdQU4cQ==
X-Google-Smtp-Source: AA0mqf7WnwyRV+YFnDFvVJeBBQuruMbxHSBY02Z3yqXpSM6qbitVAP4qUu1h3ZYxLBj+H7VHap+hLw==
X-Received: by 2002:a05:6214:5649:b0:4af:ad6e:9ac9 with SMTP id mh9-20020a056214564900b004afad6e9ac9mr1992223qvb.22.1668684033528;
        Thu, 17 Nov 2022 03:20:33 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id d12-20020ac8060c000000b0039d085a2571sm219318qth.55.2022.11.17.03.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:20:33 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3691e040abaso15476707b3.9;
        Thu, 17 Nov 2022 03:20:33 -0800 (PST)
X-Received: by 2002:a05:690c:b81:b0:37e:6806:a5f9 with SMTP id
 ck1-20020a05690c0b8100b0037e6806a5f9mr1541973ywb.47.1668684033193; Thu, 17
 Nov 2022 03:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221107175305.63975-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221107175305.63975-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 12:20:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+e63iW2yCNaTqYv6_b7zSnok-1i07sbNfgJvq5vGUCQ@mail.gmail.com>
Message-ID: <CAMuHMdV+e63iW2yCNaTqYv6_b7zSnok-1i07sbNfgJvq5vGUCQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] arm64: dts: renesas: r9a07g043[u]: Update pinctrl
 node to handle GPIO interrupts
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add required properties in pinctrl node to handle GPIO interrupts.
>
> Note as IRQC is not enabled in RZ/Five the phandle for interrupt-parent
> is added in RZ/G2UL specific dtsi so that RZ/Five pinctrl driver
> continues without waiting for IRQC to probe.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -531,6 +531,8 @@ pinctrl: pinctrl@11030000 {
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         gpio-ranges = <&pinctrl 0 0 152>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
>                         clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
>                         power-domains = <&cpg>;
>                         resets = <&cpg R9A07G043_GPIO_RSTN>,
> diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> index 7a8ed7ae253b..65e7b029361e 100644
> --- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
> @@ -98,6 +98,10 @@ &irqc {
>         resets = <&cpg R9A07G043_IA55_RESETN>;
>  };
>
> +&pinctrl {
> +       interrupt-parent = <&irqc>;
> +};

Do you plan to move it back to the common r9a07g043.dtsi later?
Perhaps it makes sense to move the full irqc node to r9a07g043[uf].dtsi?
There is not that much common left, even the compatible value differs.
We don't keep the few common properties of the cpu0 node in
r9a07g043.dtsi neither.

> +
>  &soc {
>         interrupt-parent = <&gic>;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
