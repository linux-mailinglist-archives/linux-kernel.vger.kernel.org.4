Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC75F7B89
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJGQdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJGQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:33:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B65FBCD6;
        Fri,  7 Oct 2022 09:33:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bs18so6330874ljb.1;
        Fri, 07 Oct 2022 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqq2/VeGbko7o9i7By0eflUe922IrbulvOMLp8wLa2U=;
        b=kqbrp/wq3NXY6uDw6V+svNSXhJ4W4EezCyFDa07T2lQuO1ejE8djxlGGZX1p4P1Mvc
         qu8JLpBgdkKjvKjE/z5OWjTVgbO2RJ9vKjitCH0UM/pgeY0P+PQqSxkOY1zGVr88Wcfa
         TvuGZB0EQWpY2mVRkG0DJe0l6YoWjhXR+f50KOIeDT15iAwb9Git9zD8IzHtE6HIbtuP
         VX1PhvRt+iwERLCjob7BLaShfH3HeFisGNaZ7KWihNWornQoX6dpdESF7wkXD2fF1nWe
         lQ+pF18NUV3ZrME0PoxNHpvGvThtxTqcDdkzMRreoijscHbjI3CJSetnr0jkrAbHmW7x
         XT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqq2/VeGbko7o9i7By0eflUe922IrbulvOMLp8wLa2U=;
        b=L8X1kg+YSDpRs1OY0AG0g3t4KsBWyVbeQAUAIYr2BtPVhLWSGZsZAsswUiCEmVbRpr
         bnyFvtVJ6eFfWhyXYl02YY+nzdzpEECoK2urhqxX5dqAHnITF4lEzo2tlArvK3DD6uWC
         KLJ84/M4TPjN21/AHdqc8g73likGADD+G8bYKa7BEHd7ZL2d0egExDkcrgHNr3/uc5lO
         7EZYGS9ImChSoc+IGE6Z7NKfc8UHe5fyQUA9GOSYqGxmalHsH+NG0RrFj6PxGMLqmG0/
         SZBfaFPT3Kf4oxrnt4nINHn40IBpNZbY3bfbnpsVA/f+9BwZO1fNpZv92chENgxYYM+R
         YwTw==
X-Gm-Message-State: ACrzQf0qVGXu6KGf4wOEbVnmxzG1z7zKqjzCEAinvmPR8PlDiRkoWYdg
        msAff645D8YLg2K75+eJIb4=
X-Google-Smtp-Source: AMsMyM5CFk6g9ekSGlP8uE3tpFTHLVKBNvkbaIQeImDnpGdjLVw/tf4dLIb+h+N0vXjEZRfaajs4gg==
X-Received: by 2002:a05:651c:19a5:b0:26c:3556:c7a9 with SMTP id bx37-20020a05651c19a500b0026c3556c7a9mr2121205ljb.430.1665160429348;
        Fri, 07 Oct 2022 09:33:49 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id h2-20020a2ea202000000b0026dcd805c92sm330202ljm.95.2022.10.07.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 09:33:48 -0700 (PDT)
Date:   Fri, 7 Oct 2022 19:33:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: gpio: Add gpio-latch binding document
Message-ID: <20221007163347.f4swjph7624eueay@mobilestation>
References: <20221007114647.2723457-1-s.hauer@pengutronix.de>
 <20221007114647.2723457-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007114647.2723457-3-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 01:46:47PM +0200, Sascha Hauer wrote:
> This adds a binding for a GPIO multiplexer driver based on latches
> connected to other GPIOs.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Just a note. In accordance with [1] the DT-bindings patches should come
in the series before the code implementing the bindings.

[1] Documentation/devicetree/bindings/submitting-patches.rst, unit I.5).

-Sergey

> ---
> 
> Notes:
>     Changes since v3:
>     - Introduce delays between GPIO toggles as suggested by Serge Semin
>     
>     Changes since v1:
>     - Add license to binding file
> 
>  .../devicetree/bindings/gpio/gpio-latch.yaml  | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-latch.yaml b/Documentation/devicetree/bindings/gpio/gpio-latch.yaml
> new file mode 100644
> index 0000000000000..1ed82a2cebdaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-latch.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-latch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO latch controller
> +
> +maintainers:
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +description: |
> +  This binding describes a GPIO multiplexer based on latches connected to
> +  other GPIOs, like this:
> +
> +  CLK0 ----------------------.        ,--------.
> +  CLK1 -------------------.  `--------|>    #0 |
> +                          |           |        |
> +  OUT0 ----------------+--|-----------|D0    Q0|-----|<
> +  OUT1 --------------+-|--|-----------|D1    Q1|-----|<
> +  OUT2 ------------+-|-|--|-----------|D2    Q2|-----|<
> +  OUT3 ----------+-|-|-|--|-----------|D3    Q3|-----|<
> +  OUT4 --------+-|-|-|-|--|-----------|D4    Q4|-----|<
> +  OUT5 ------+-|-|-|-|-|--|-----------|D5    Q5|-----|<
> +  OUT6 ----+-|-|-|-|-|-|--|-----------|D6    Q6|-----|<
> +  OUT7 --+-|-|-|-|-|-|-|--|-----------|D7    Q7|-----|<
> +         | | | | | | | |  |           `--------'
> +         | | | | | | | |  |
> +         | | | | | | | |  |           ,--------.
> +         | | | | | | | |  `-----------|>    #1 |
> +         | | | | | | | |              |        |
> +         | | | | | | | `--------------|D0    Q0|-----|<
> +         | | | | | | `----------------|D1    Q1|-----|<
> +         | | | | | `------------------|D2    Q2|-----|<
> +         | | | | `--------------------|D3    Q3|-----|<
> +         | | | `----------------------|D4    Q4|-----|<
> +         | | `------------------------|D5    Q5|-----|<
> +         | `--------------------------|D6    Q6|-----|<
> +         `----------------------------|D7    Q7|-----|<
> +                                      `--------'
> +
> +  The number of clk-gpios and latched-gpios is not fixed. The actual number
> +  of number of latches and the number of inputs per latch is derived from
> +  the number of GPIOs given in the corresponding device tree properties.
> +
> +properties:
> +  compatible:
> +    const: gpio-latch
> +  "#gpio-cells":
> +    const: 2
> +
> +  clk-gpios:
> +    description: Array of GPIOs to be used to clock a latch
> +
> +  latched-gpios:
> +    description: Array of GPIOs to be used as inputs per latch
> +
> +  setup-duration-ns:
> +    description: Delay in nanoseconds to wait after the latch inputs have been
> +      set up
> +
> +  clock-duration-ns:
> +    description: Delay in nanoseconds to wait between clock output changes
> +
> +  gpio-controller: true
> +
> +  gpio-line-names: true
> +
> +required:
> +  - compatible
> +  - "#gpio-cells"
> +  - gpio-controller
> +  - clk-gpios
> +  - latched-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio-latch {
> +        #gpio-cells = <2>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_di_do_leds>;
> +        compatible = "gpio-latch";
> +        gpio-controller;
> +        setup-duration-ns = <100>;
> +        clock-duration-ns = <100>;
> +
> +        clk-gpios = <&gpio3 7 0>, <&gpio3 8 0>;
> +        latched-gpios = <&gpio3 21 0>, <&gpio3 22 0>,
> +                       <&gpio3 23 0>, <&gpio3 24 0>,
> +                       <&gpio3 25 0>, <&gpio3 26 0>,
> +                       <&gpio3 27 0>, <&gpio3 28 0>;
> +    };
> -- 
> 2.30.2
> 
