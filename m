Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA872EB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFMSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjFMSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:34:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B231BC5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:34:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977d0288fd2so958612066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686681268; x=1689273268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtcqOw9tGOLwmlWw5dD/FwSbu+eMTAPAiQdNyorGdKs=;
        b=TF06f9ZKq7pMgbq7ormbfzR+qN7ngTNxN1iQAXw5U5DuvJrUq1xjjW5xw9Ize6wSp7
         EYxB2YzFz/QtVppI3GMbtwa4xgZ9sRQc3f4t8YBK/meyV6UR1DiBbMgwpXwOIgNKFs33
         U87sFC0COYk9vce4kBnTGAGE2hazjZOGeQSpl2b7BLjyXbNQiuFuyb5xpd60z2nQkxnA
         4ykIXEPRyNRfLYITKW1o/rh6DBnkOaeN2/hn1ZF0+4KTDPZWhyejI8hH3+tu0EYeYbJB
         EJffQ0cUT8Gpm0QKBn3ydp3Uf+0X+hUyQ9Savf8KEz8OyniD+XdZ/s6VAtYcnNCFkcFq
         8qsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681268; x=1689273268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtcqOw9tGOLwmlWw5dD/FwSbu+eMTAPAiQdNyorGdKs=;
        b=l8uOZsBrQams41q+F8GaC/EcCa3Leg09fDXITFZnaCiUXWmTU4ToCwaC6wH376Q+oY
         TLYWnYM29rJ1aiKoxSsKo5+wHFWMcp5mAHNIIlnf1pMMW3IOsL2CbgJm7XGRVKWPoSMz
         50/RCtTN1oAjLYlzgfEWYoKOIEvZGMMsrSVZEVZA5ohI0gldkGWrhoKDQtnFY7QzoApT
         gTeY77SYbEcE20mNqkQq81sgUzY2XY6uGXYybxyWcKoWy22zo9jOB4oHoHeHxjO4Mqox
         DStovQaig2tUjVRi2WiDSS293L7+Yk6bZhu1F2AEkXn6qD6rcWEZgvvVu/mCBmD0k+rC
         q3XQ==
X-Gm-Message-State: AC+VfDw7YynjkrCFcDMuPs9ZZna1x7CcTpL+A+WzmIXIcuJA7AODTE1+
        Js0T7kmmBnAuduGcAj0A7QIu3w==
X-Google-Smtp-Source: ACHHUZ5h4YyZdlSWo9Eiykl6LWg95TEWZGgJxSeDzTRZm8HcaKkAKbdZzhGVqPwl1h+uQO5nbWUlYg==
X-Received: by 2002:a17:907:eac:b0:978:8925:7a08 with SMTP id ho44-20020a1709070eac00b0097889257a08mr15533059ejc.72.1686681268157;
        Tue, 13 Jun 2023 11:34:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id pv12-20020a170907208c00b0096b4ec45e10sm6946337ejb.139.2023.06.13.11.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:34:27 -0700 (PDT)
Message-ID: <75508c4d-d86e-f88f-191f-dd870ebe7bd7@linaro.org>
Date:   Tue, 13 Jun 2023 20:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/7] dt-bindings: clock: jh7110-syscrg: Add PLL clock
 inputs
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230613125852.211636-1-xingyu.wu@starfivetech.com>
 <20230613125852.211636-4-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613125852.211636-4-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 14:58, Xingyu Wu wrote:
> Add optional PLL clock inputs from PLL clock generator.

Are you sure that PLLs are optional? Usually they are not...

> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-syscrg.yaml         | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> index 84373ae31644..5536e5f9e20b 100644
> --- a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> @@ -39,6 +39,33 @@ properties:
>            - description: External TDM clock
>            - description: External audio master clock
>  
> +      - items:
> +          - description: Main Oscillator (24 MHz)
> +          - description: GMAC1 RMII reference or GMAC1 RGMII RX
> +          - description: External I2S TX bit clock
> +          - description: External I2S TX left/right channel clock
> +          - description: External I2S RX bit clock
> +          - description: External I2S RX left/right channel clock
> +          - description: External TDM clock
> +          - description: External audio master clock
> +          - description: PLL0
> +          - description: PLL1
> +          - description: PLL2

Add these three to the existing entry with minItems.

> +
> +      - items:
> +          - description: Main Oscillator (24 MHz)
> +          - description: GMAC1 RMII reference
> +          - description: GMAC1 RGMII RX
> +          - description: External I2S TX bit clock
> +          - description: External I2S TX left/right channel clock
> +          - description: External I2S RX bit clock
> +          - description: External I2S RX left/right channel clock
> +          - description: External TDM clock
> +          - description: External audio master clock
> +          - description: PLL0
> +          - description: PLL1
> +          - description: PLL2

Add these three to the existing entry with minItems.



> +
>    clock-names:
>      oneOf:
>        - items:
> @@ -64,6 +91,35 @@ properties:
>            - const: tdm_ext
>            - const: mclk_ext
>  
> +      - items:
> +          - const: osc
> +          - enum:
> +              - gmac1_rmii_refin
> +              - gmac1_rgmii_rxin
> +          - const: i2stx_bclk_ext
> +          - const: i2stx_lrck_ext
> +          - const: i2srx_bclk_ext
> +          - const: i2srx_lrck_ext
> +          - const: tdm_ext
> +          - const: mclk_ext
> +          - const: pll0_out
> +          - const: pll1_out
> +          - const: pll2_out

Add these three to the existing entry with minItems.


> +
> +      - items:
> +          - const: osc
> +          - const: gmac1_rmii_refin
> +          - const: gmac1_rgmii_rxin
> +          - const: i2stx_bclk_ext
> +          - const: i2stx_lrck_ext
> +          - const: i2srx_bclk_ext
> +          - const: i2srx_lrck_ext
> +          - const: tdm_ext
> +          - const: mclk_ext
> +          - const: pll0_out
> +          - const: pll1_out
> +          - const: pll2_out

Add these three to the existing entry with minItems.



Best regards,
Krzysztof

