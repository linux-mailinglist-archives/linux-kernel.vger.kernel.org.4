Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94345F09C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiI3LQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiI3LPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:15:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558385F991
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:58:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j24so4400234lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5VAtT045HhMngkmwARoPHUum6+7Xd5AahGP1N35/lRw=;
        b=fawDO9CiFlwFpbC+3YyovBO32HiOGqZ+TrjsTr2Q6YcCJCeFCfaJEiuP3XHibreYfx
         wmTrXtWKvlU1ywiJ18MNHJj+RSbhfYPzYo/ZQnDGj5GgluDuZ7okPUozoUJ9Bly33yV+
         99Z1HqEmfxSxaOxu2hRBQLI/YMe6RRvV6/zPLAw5oIi08PrbCiJd9EDxTCh2vkUZ1DeE
         gB5wvphZ3bsi5lkQQFRQrzVf4UF488cob5ENfxZInr0/UCv9a9gGzuoOW55ZT5WQtV8W
         HTLuyjBNlC+clvHUjLjUY1yo60g20jhmRl9loUR9iM1zQH9LB+mXFS8ZnTfLUrKTAqZU
         AXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5VAtT045HhMngkmwARoPHUum6+7Xd5AahGP1N35/lRw=;
        b=afy50nZBSYf/C8hw2ZxI5XFo6H8zxuo8VtrOQAI7D9+R6Czv2yDDO6mrt6iaGIxQ9/
         Uu1KoZT/hdFx4WmLPJbTy3slExaBc8qW7/zTmt/rAkw2rgKJeRHgT59WkCRbFspeYO5K
         axdyXYDN7dpt4g9IE4byYMwwQQxre8OWO0Zs3GQ8JVGJxXZTM/0uBkvzlf/kSDXLJMYT
         vb9ZtqmNB016w+2OziIBlLQ9m8hslQGpO0on96/r7p5G3Y1SzzJwB9LQNyBZayNxuJZp
         JgXgxcMzcYdTgchmxGfzjhAJL5U9IfpvJ9LWUHaYMs+LHBm7sLxN8pY3ryiUpMSPEpem
         oHJQ==
X-Gm-Message-State: ACrzQf2d1vfivyfg+4jbmE/WvucSo+8u8HYQRTd+X0Ym2gqTk6YyzODx
        tOpvHkCIuHDcfIKOpNhe5hYPJQ==
X-Google-Smtp-Source: AMsMyM7TKpBGxyi1XbG3exK/6MQW1oPEOmmR7/XdLTYi4sSeeYzQ9S++Asikue7qCrHD8G5zL9+8Lw==
X-Received: by 2002:a2e:7201:0:b0:26b:dd49:721b with SMTP id n1-20020a2e7201000000b0026bdd49721bmr2574829ljc.509.1664535493744;
        Fri, 30 Sep 2022 03:58:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h19-20020a056512221300b00498f3ebffb2sm265007lfu.25.2022.09.30.03.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 03:58:13 -0700 (PDT)
Message-ID: <c99f6552-db04-fe30-ed69-4a08b0af5276@linaro.org>
Date:   Fri, 30 Sep 2022 12:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 17/30] dt-bindings: clock: Add
 starfive,jh7110-clkgen-sys bindings
Content-Language: en-US
To:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929222647.23816-1-hal.feng@linux.starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929222647.23816-1-hal.feng@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 00:26, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the system clock generator on the JH7110
> RISC-V SoC by StarFive Technology Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>

(...)

> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive-jh7110-sys.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscrg_clk: clock-controller@13020000 {

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +        compatible = "starfive,jh7110-clkgen-sys";
> +        clocks = <&osc>, <&gmac1_rmii_refin>,
> +                 <&gmac1_rgmii_rxin>,
> +                 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> +                 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> +                 <&tdm_ext>, <&mclk_ext>;
> +        clock-names = "osc", "gmac1_rmii_refin",
> +                      "gmac1_rgmii_rxin",
> +                      "i2stx_bclk_ext", "i2stx_lrck_ext",
> +                      "i2srx_bclk_ext", "i2srx_lrck_ext",
> +                      "tdm_ext", "mclk_ext";
> +        #clock-cells = <1>;
> +    };

Best regards,
Krzysztof

