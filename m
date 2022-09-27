Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7645EBCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiI0IDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiI0ICg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:02:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F16B2CF2;
        Tue, 27 Sep 2022 00:57:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso8910799wma.1;
        Tue, 27 Sep 2022 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L7lzwl2ROYNxZkDiHQ7pKg/1Gs3z2fS+x1+GiBntGvI=;
        b=PBPtVts4kEOw5wKe5Y94V+6sgqGIUUFoKYZMUbUYVbEiyJuCrrz+eHEtyTlUw9kxC6
         FR1+WZWxXoYPqX7foSCNahG2/PswNQWFt26LTY5MO2v6pNrv8+DeLW2n76WFlKpKOlpq
         QTZSsqivAJVsjYPsS+Uv28oTdPtw2MWYA1SHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L7lzwl2ROYNxZkDiHQ7pKg/1Gs3z2fS+x1+GiBntGvI=;
        b=g6Y3WNYuzsLHQWTdrmtn2ZScFXqu0D2u9eRHflgLGzOXmio0EYtIwe733bMLajDRVG
         RZLsahX42lZvjthFR34KicbXc3WINGJzcheXwdK4+ynmosmLMxgxquVsmyUdrIShMW4a
         kt6gNhEgtyT97uJfPEieR75xMqBEdgf30+ivoxLwa4Ca7h3HMquTfn6yZGDVhtXYjcE2
         PgpTx/jKYv0NOIRePE4lUIZaj7hw9DJASWAlJ+8Uh23RBDMgP8MaUJ7bXhD0LlrCYB32
         8tLEVosLbySBs5ap03bGqOC5N63FnbqoUQBcH2t0+1FZrb1lznXJaA8ENH14oj5nHGb7
         1veQ==
X-Gm-Message-State: ACrzQf3VetyskSbqpeP9CzlPOulap5OuNmkcwIC/nLbhdmqXKeWWWBXa
        RZpHmysfOFaejJiJYRHAS5xbMYEBZ4ItpgDVHxS7hfJzAQE=
X-Google-Smtp-Source: AMsMyM7qHFHB+XTY4UMk5ab4ecNrg2RljaRASucq8apG47rSev717kTRZRhhAmP1W8Iap6GMajGd5uLyoozV3C/QwXE=
X-Received: by 2002:a05:600c:198a:b0:3b4:c06a:28b1 with SMTP id
 t10-20020a05600c198a00b003b4c06a28b1mr1643306wmq.72.1664265438160; Tue, 27
 Sep 2022 00:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220805090957.470434-1-j220584470k@gmail.com>
In-Reply-To: <20220805090957.470434-1-j220584470k@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 27 Sep 2022 07:57:06 +0000
Message-ID: <CACPK8Xc-kxwLS6Eb36Jig4mDiz_Z1ynEc127MUOsSsrC0z=xrQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: aspeed-g6: enable more UART controllers
To:     Ken Chen <j220584470k@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin.Lai@quantatw.com, Cosmo.Chou@quantatw.com,
        Michael Garner <garnermic@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 at 09:13, Ken Chen <j220584470k@gmail.com> wrote:
>
> Setup the configuration of UART6, UART7, UART8, and UART9 in
> aspeed-g6.dtsi.
>
> Signed-off-by: Ken Chen <j220584470k@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 64 +++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 8c0de3f27883b..fe7cef6b5e976 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -34,8 +34,12 @@ aliases {
>                 serial2 = &uart3;
>                 serial3 = &uart4;
>                 serial4 = &uart5;
> -               serial5 = &vuart1;
> -               serial6 = &vuart2;

As Andrew mentioned, this may be "ABI" for existing systems. They
expect the vuart to be ttyS5. However, since the beinning they also
have a udev rule that creates a symlink, so it may not be an issue:

bmc:~# ls -la /dev/ttyVUART0
lrwxrwxrwx    1 root     root             5 Jun 10 05:25 /dev/ttyVUART0 -> ttyS5

Can you test your patch with an existing userspace to verify?

I have applied the rest of the patch with the aliases part removed.

> +               serial5 = &uart6;
> +               serial6 = &uart7;
> +               serial7 = &uart8;
> +               serial8 = &uart9;
> +               serial9 = &vuart1;
> +               serial10 = &vuart2;
>         };
>
>
> @@ -745,6 +749,62 @@ uart4: serial@1e78f000 {
>                                 status = "disabled";
>                         };
>
> +                       uart6: serial@1e790000 {
> +                               compatible = "ns16550a";
> +                               reg = <0x1e790000 0x20>;
> +                               reg-shift = <2>;
> +                               reg-io-width = <4>;
> +                               interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART6CLK>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_uart6_default>;
> +
> +                               status = "disabled";
> +                       };
> +
> +                       uart7: serial@1e790100 {
> +                               compatible = "ns16550a";
> +                               reg = <0x1e790100 0x20>;
> +                               reg-shift = <2>;
> +                               reg-io-width = <4>;
> +                               interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART7CLK>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_uart7_default>;
> +
> +                               status = "disabled";
> +                       };
> +
> +                       uart8: serial@1e790200 {
> +                               compatible = "ns16550a";
> +                               reg = <0x1e790200 0x20>;
> +                               reg-shift = <2>;
> +                               reg-io-width = <4>;
> +                               interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART8CLK>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_uart8_default>;
> +
> +                               status = "disabled";
> +                       };
> +
> +                       uart9: serial@1e790300 {
> +                               compatible = "ns16550a";
> +                               reg = <0x1e790300 0x20>;
> +                               reg-shift = <2>;
> +                               reg-io-width = <4>;
> +                               interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_UART9CLK>;
> +                               no-loopback-test;
> +                               pinctrl-names = "default";
> +                               pinctrl-0 = <&pinctrl_uart9_default>;
> +
> +                               status = "disabled";
> +                       };
> +
>                         i2c: bus@1e78a000 {
>                                 compatible = "simple-bus";
>                                 #address-cells = <1>;
> --
> 2.31.1
>
