Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5AA6F5018
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjECG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 02:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECG2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 02:28:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6502D1FCF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 23:28:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd87539c2so1748536a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 23:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683095329; x=1685687329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QkCOwPVV47rBbXiC/TT/NWf8AZkKzBELUWgp+uXk1c=;
        b=S19sAVeim0llat822qN0TkI1wzFO8rpIJ7D5aG4/0xlZcLvVVy7Buc17IYzgKAnoiR
         KezJLEAG9iNZX5sHkZ9aRcEuuO398FvHSWwkXRhfLP8nF07Q6Bk5JF4MLSrhflUI0RjC
         foe/QaKWXI/K/ZLWBd72bt6XOeBlte8XfRLQSfROs9NPVUPAGM0pOR6yl1pwwbWEoEQJ
         9mAaZ7aNi2lEuNCdyWjVTMsSV35VjrgeyFs0SBzb+7a27cHTPbnswK9Y48mRAITrBS/Z
         /CiSFhppTl0jAFlTQQFXb/cV2dI3x9va2QbcqRzcHJSQy39mKgaCJFSqR6wzC1QKN8i7
         dfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683095329; x=1685687329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QkCOwPVV47rBbXiC/TT/NWf8AZkKzBELUWgp+uXk1c=;
        b=aescWIzDCqTpMjkOOXwv+jfR3ZE3ktk26BeRmZE24R3CgyQePH8j5z3q8JLESeJYpn
         GGCCNbcDiMKKnkoOx3p+qbZfMpQLJ3V5ZMubnNbq8lEb374ntLkK58DjeHzxtz0NWf1t
         pAFe/2i1c3oPTaZfOk+EZNkMcaxk5IkZXdxJOQhX+bYzRUJ0iX01k03uS4sIVqELLapy
         jZX/mF4dinLp4ZwuwCLFwvhxVcWgrCmMWu0nshsPecm915+opRsX9s1d86nxY/0SQRLp
         7HPrYftti1VYIqJlqKAzrk/Hg9hnAeCtN/KIJIv+eU3npJ7eODX2FzANGkBVGN0W5/j/
         hnCw==
X-Gm-Message-State: AC+VfDxQujP+DmKBwVSwScnJyrfa+DY39uAqJyNh0hNellaF8kZLhxQq
        f4JG0O0s40A70nYsyTU1gY2I1Q==
X-Google-Smtp-Source: ACHHUZ7NJYZH4xiaQvcnIk6FigSAqVosnLMbEKPw1SuimdWpQi0rQKBsgWdAXfyBV1PKSN/I14RAEg==
X-Received: by 2002:a17:907:a426:b0:94a:9c9e:6885 with SMTP id sg38-20020a170907a42600b0094a9c9e6885mr2184090ejc.58.1683095328796;
        Tue, 02 May 2023 23:28:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5? ([2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906394b00b0094f4f2db7e0sm17159284eje.143.2023.05.02.23.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 23:28:48 -0700 (PDT)
Message-ID: <0678c24c-33ae-7e99-7bb6-d15dc5a7ed76@linaro.org>
Date:   Wed, 3 May 2023 08:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: rockchip-otp: Add compatible for
 RK3588
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 10:43, Cristian Ciocaltea wrote:
> Document the OTP memory found on Rockchip RK3588 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  .../bindings/nvmem/rockchip-otp.yaml          | 71 ++++++++++++++++---
>  1 file changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> index 658ceed14ee2..84a11382c6e7 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
> @@ -9,34 +9,31 @@ title: Rockchip internal OTP (One Time Programmable) memory
>  maintainers:
>    - Heiko Stuebner <heiko@sntech.de>
>  
> -allOf:
> -  - $ref: nvmem.yaml#
> -
>  properties:
>    compatible:
>      enum:
>        - rockchip,px30-otp
>        - rockchip,rk3308-otp
> +      - rockchip,rk3588-otp
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
>      minItems: 3
> -    maxItems: 3
> +    maxItems: 4
>  
>    clock-names:
> -    items:
> -      - const: otp
> -      - const: apb_pclk
> -      - const: phy
> +    minItems: 3
> +    maxItems: 4
>  
>    resets:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
>  
>    reset-names:
> -    items:
> -      - const: phy
> +    minItems: 1
> +    maxItems: 3
>  
>  required:
>    - compatible
> @@ -46,6 +43,58 @@ required:
>    - resets
>    - reset-names
>  
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-otp
> +              - rockchip,rk3308-otp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: otp
> +            - const: apb_pclk
> +            - const: phy
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: phy
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3588-otp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: otpc
> +            - const: apb
> +            - const: arb
> +            - const: phy

Keep the same order of clocks as in older variants, so you can keep the
list in top-level place and here only minItems: 4.

> +        resets:
> +          minItems: 1
> +          maxItems: 3
> +        reset-names:
> +          items:
> +            - const: otpc

Shouldn't this be phy?



Best regards,
Krzysztof

