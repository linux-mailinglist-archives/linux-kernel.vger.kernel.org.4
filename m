Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66D363BCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiK2JYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK2JYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:24:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57F3FB83
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:24:38 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f13so21517687lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBDc9CcCcTklSkLn2omn0o3yNWgPbE363k3eUvI/h7M=;
        b=Es2zzDQYxQUOfxd+vsDHLcyrTM7DQmqyh+D+PB6b6KhjmVs66Iw1Yqn2XrszY+3//i
         5RLbkf9b92gJuqqo1Dcn4Sux20Vw1n0CPi7Ke64abWlPlfmhommdQrQUIxgOJdGGToSg
         qbosMJRC5XYGV013mo52sFACgUI7X1YVshzxbvCRPn6Eh0BYWrwogP9+PEhrxVbavV94
         DtQ9LtSdgav1KAawshTUb5+1VjwGdS4an4dnVX7dC/QNLQ2f+TnuqtAwtw20Kn2H7JbQ
         DvdiclwVseLcof0Uo+d1HokEk58wRZUBMK2ErsQF7+07VhYMGQGghGATi+F8UODoNC/x
         AfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBDc9CcCcTklSkLn2omn0o3yNWgPbE363k3eUvI/h7M=;
        b=W25rVz0h76XV5ISg01NzOrbt9Jn43YxAEVglCP3HA27rkuiDxE9snYBRHpitawQBC3
         2vCW8h7Ty2otcaYqPl6CRZuZ0plCNLq0xcUEO28qxSFBlGdfV7ugwADWhtLrmR8HaVHy
         I+uaEJoVPlZv9lUjfEX3+3bSJyQiN744NayK1YpoEwumISno2fkP1UPW681t9nSkV1O0
         Xy6lPa3l/DDO7gQVIR1wGzzdjeYpm1VggbUQcJlDzwC0wqJ6rNQg9vpwx3HwKwpxyyYZ
         7NScM+XA661LIsm0pVkeuB8f4ZzbjHHjiCsXUobxhcF6uAy6U027viVxRUNbHdf0C5r1
         thYw==
X-Gm-Message-State: ANoB5pmOFY5Lv3uechF/MiVSSx9TmPhiXptjth8tKUJsF+koJiTkFigo
        l+AK27Y/mRFp0knSzUm85VJ/eA==
X-Google-Smtp-Source: AA0mqf7Di+vA1MHihgiN372ZA1nFRb+Z/G5naXPqvEmAfNO2xwioDDiYClbUnBMUTROvQc29I6mipg==
X-Received: by 2002:a19:4f52:0:b0:4a6:2ff5:ddd2 with SMTP id a18-20020a194f52000000b004a62ff5ddd2mr20497054lfk.166.1669713876371;
        Tue, 29 Nov 2022 01:24:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a2-20020ac25202000000b004acff58a951sm1603246lfl.133.2022.11.29.01.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 01:24:35 -0800 (PST)
Message-ID: <89b16ec5-f9a5-f836-f51a-8325448e4775@linaro.org>
Date:   Tue, 29 Nov 2022 10:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: RNG: Add Rockchip RNG bindings
Content-Language: en-US
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-2-aurelien@aurel32.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128184718.1963353-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 19:47, Aurelien Jarno wrote:
> Add the RNG bindings for the RK3568 SoC from Rockchip

Use subject prefixes matching the subsystem (git log --oneline -- ...),
so it is rng, not RNG. Also, you are not adding all-Rockhip RNG but a
specific device.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  .../bindings/rng/rockchip,rk3568-rng.yaml     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml b/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
> new file mode 100644
> index 000000000000..c2f5ef69cf07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rng/rockchip,rk3568-rng.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip TRNG
> +
> +description: True Random Number Generator for some Rockchip SoCs

s/for some Rockchip SoCs/on Rokchip RK3568 SoC/

> +
> +maintainers:
> +  - Aurelien Jarno <aurelien@aurel32.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-rng
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: TRNG clock
> +      - description: TRNG AHB clock
> +
> +  clock-names:
> +    items:
> +      - const: trng_clk
> +      - const: trng_hclk

These are too vague names. Everything is a clk in clock-names, so no
need usually to add it as name suffix. Give them some descriptive names,
e.g. core and ahb.

> +
> +  resets:
> +    maxItems: 1
> +

Best regards,
Krzysztof

