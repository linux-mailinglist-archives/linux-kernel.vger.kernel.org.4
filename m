Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259666494FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 16:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiLKPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 10:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiLKPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 10:51:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E6EF002;
        Sun, 11 Dec 2022 07:51:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E1B2B80AE8;
        Sun, 11 Dec 2022 15:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFD7C433F2;
        Sun, 11 Dec 2022 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670773914;
        bh=dJPoRJoE0b7D0qoTg74go7ZPIqI4E63GTw/sa+mGBcw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbAK9zubcW/9MOpoFhmS+s+SQqnT55D+dx+ku6V7jWsP+x5xeVVzaH+L6x4o3vdrA
         xmFxvaYWEWXBmmRwoulLCR36/Eje8yP6pePGsSf2bNgl+25HY2oJon/Q+ELq+eFf0z
         lzgGpoTXL/Hq/cEMpC+h1Eccv2uCX1Pio8A0H1UxtTSK+r5uPji1AtVyqIeWlFOaRM
         pO2I4chV0gnqrY6JNxk/O1s47Io4zMlUncXqTlGADVHjFFJjetEKugDNJbLyRTaXM/
         ii4QdTQEVuP10l21cRfpYLg/kb+aSpkUcc6btm9uOb3caoZ3tJsxY4PstnUmdac4LO
         XJ6VYS8CeubUQ==
Received: by mail-ua1-f54.google.com with SMTP id v21so2560792uam.1;
        Sun, 11 Dec 2022 07:51:54 -0800 (PST)
X-Gm-Message-State: ANoB5pnmmCVlFXHyvr6sre7rStU9NukPCddEWycCkgyf+VB/DYGzXBf8
        UqEailU+YJ0NXxPqaseIdxCg5WIyrNshTd8hJA==
X-Google-Smtp-Source: AA0mqf4ZX6PzBBHcVvYR+A/t+vslGzC+Y0WOhfJ69k+mS5u6Cm9N+bGaMJr6O2NwLPCylgHyQA7ytgjSJwTlGjYH8A0=
X-Received: by 2002:ab0:3a96:0:b0:419:678:cf31 with SMTP id
 r22-20020ab03a96000000b004190678cf31mr35054148uaw.63.1670773913199; Sun, 11
 Dec 2022 07:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20220927075511.3147847-1-clabbe@baylibre.com> <20220927075511.3147847-29-clabbe@baylibre.com>
In-Reply-To: <20220927075511.3147847-29-clabbe@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 11 Dec 2022 09:51:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJkHR+iccEf=5SU40Qq+cQpGZRq26TLzec-_Nr-Buu2KQ@mail.gmail.com>
Message-ID: <CAL_JsqJkHR+iccEf=5SU40Qq+cQpGZRq26TLzec-_Nr-Buu2KQ@mail.gmail.com>
Subject: Re: [PATCH v10 28/33] arm64: dts: rockchip: rk3399: add crypto node
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 2:56 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> The rk3399 has a crypto IP handled by the rk3288 crypto driver so adds a
> node for it.
>
> Tested-by Diederik de Haas <didi.debian@cknow.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 92c2207e686c..4391aea25984 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -582,6 +582,26 @@ saradc: saradc@ff100000 {
>                 status = "disabled";
>         };
>
> +       crypto0: crypto@ff8b0000 {
> +               compatible = "rockchip,rk3399-crypto";
> +               reg = <0x0 0xff8b0000 0x0 0x4000>;
> +               interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>;
> +               clocks = <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>, <&cru SCLK_CRYPTO0>;
> +               clock-names = "hclk_master", "hclk_slave", "sclk";
> +               resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
> +               reset-names = "master", "lave", "crypto";

This doesn't match the binding:

crypto@ff8b8000: reset-names:2: 'crypto-rst' was expected
crypto@ff8b0000: reset-names:2: 'crypto-rst' was expected
crypto@ff8b0000: reset-names:1: 'slave' was expected

Rob
