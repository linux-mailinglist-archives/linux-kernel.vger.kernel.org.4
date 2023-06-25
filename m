Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584B173D446
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjFYVAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYVAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:00:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF70126;
        Sun, 25 Jun 2023 14:00:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9786fc23505so200885466b.2;
        Sun, 25 Jun 2023 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687726817; x=1690318817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mJUkbQQcqyDE53aw5MOHAc9VhtcEJr6twJXYLB90jk=;
        b=A7qCeuCgKbtFEgGis1t2x/ErDOE+chG5xjp1mHsbD8UxcMKWjdXBegYJqsorobez3i
         A+P8dZby0eKzlFX25d47RbP/qssp4hyO+4oNOV/c4McI9RAgIvEe0hUWXba/q2dIhN5G
         6yxnSANBsC8Qva4NZLVyvvnsk+Ks5/50zA6nQSYOJkr/++RHIUi7Tha0uWQ7kSar1xwG
         hoqNMpYpQsH7rGKwcXtRqnxWTvTCdWYkM/y6r8WSVAjNMk4Q6pblTz9SrJ1RqwEJ7SWV
         9iJp6Zu+ZvUGorur+Hxo1mDm190O7XE1bPza8P27zKW5NWUIaz6jkLgxJS4c1LuNR7fG
         8vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687726817; x=1690318817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mJUkbQQcqyDE53aw5MOHAc9VhtcEJr6twJXYLB90jk=;
        b=TAb2DkGkEERQOaBCtcg6AcTQ6fQ1mDOaOK8I8EREqglCHHaG9LOxQummwCpYnIvaQF
         3GMmBZsQ5Ny4ZoRRST2P7Zwnr6sceV7hVBAwZoLYnbLopd8JHGZwTMYC26nmgrqC8PCD
         uzdMQ7dqaS9CUYd6u/PKqe3S5Nt9fwcrRBzG06Oo4nkEmVp5AMsRb2dKR4WcmMusJ6K8
         iyEBs1RqaFg8mFXOqjNJOJBBqNEk7LNSAH+xkSsdCkux5WtiiSkVrfgVbBv1btNvElYf
         UKg7r/hJtwobws46pODbTxrLzRp5UMmFTkKzyW+Z2p/Mxyykiojmj+KXAP9OIlxVCCiY
         U1FQ==
X-Gm-Message-State: AC+VfDzLB5Vy7FkEoeVeBS/qrq5vUrZGnOMTq7ge7Amu3p3R6PoqAbnR
        69cle4fXahc0nRBlf44fK8/C1u4nQ6gDppFWh2Q=
X-Google-Smtp-Source: ACHHUZ5yBmQinkSkuUlSQyLq8I7zzsqf8l+oBnyvl4CQafqwz9rPZS23Crq7w+vxpQEf+q2F4xwNtxGw+RdXfwGDVss=
X-Received: by 2002:a17:907:a06f:b0:98f:5640:16a with SMTP id
 ia15-20020a170907a06f00b0098f5640016amr1168601ejc.53.1687726817451; Sun, 25
 Jun 2023 14:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru> <20230607201641.20982-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20230607201641.20982-2-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Jun 2023 23:00:06 +0200
Message-ID: <CAFBinCAO14zcgY66UyJO9UxuCWf1N-Lsx=iYNTJL=cwXoJv__Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] arm64: dts: meson: a1: introduce PLL and
 Peripherals clk controllers
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        conor+dt@kernel.org, kernel@sberdevices.ru,
        sdfw_system_team@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 10:16=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> This patch adds clkc and clkc_pll dts nodes to A1 SoC main dtsi.
> The first one clk controller is responsible for all SoC peripherals
> clocks excluding audio clocks. The second one clk controller is used by
> A1 SoC PLLs. Actually, there are two different APB heads, so we have two
> different drivers.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-a1.dtsi
> index eed96f262844..a24228808c9c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -6,6 +6,8 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/gpio/meson-a1-gpio.h>
> +#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> +#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
>
>  / {
>         compatible =3D "amlogic,a1";
> @@ -126,6 +128,30 @@ uart_AO_B: serial@2000 {
>                                 status =3D "disabled";
>                         };
>
> +                       clkc_periphs: clock-controller@800 {
please keep the entries sorted - so &clkc_periphs should come after
&periphs_pinctrl

> +                               compatible =3D "amlogic,a1-peripherals-cl=
kc";
> +                               reg =3D <0 0x800 0 0x104>;
> +                               #clock-cells =3D <1>;
> +                               clocks =3D <&clkc_pll CLKID_FCLK_DIV2>,
> +                                        <&clkc_pll CLKID_FCLK_DIV3>,
> +                                        <&clkc_pll CLKID_FCLK_DIV5>,
> +                                        <&clkc_pll CLKID_FCLK_DIV7>,
> +                                        <&clkc_pll CLKID_HIFI_PLL>,
> +                                        <&xtal>;
> +                               clock-names =3D "fclk_div2", "fclk_div3",
> +                                             "fclk_div5", "fclk_div7",
> +                                             "hifi_pll", "xtal";
> +                       };
[...]

>                         gpio_intc: interrupt-controller@0440 {
note to self: at some point we'll have to re-order &gpio_intc, but
that's out of scope for this patch


Best regards,
Martin
