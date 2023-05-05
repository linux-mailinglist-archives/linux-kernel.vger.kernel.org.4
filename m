Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A016F7D44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjEEGuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEEGuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:50:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF915EE9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:49:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so2645474a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269397; x=1685861397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28Amkh04p+8YFx4DGbxc9jqW7MpWBAmX1EZBEmgpetU=;
        b=d9T5YY/ZzcCK8CdHUuNpLLMgJdUWaZaQw/0vlrwliZbR1g889gv1prP/1egyJEuwfg
         WNvdcMuzOtpQpEeLqK9Ha5rL+IO6nbVhfJYTq9BQMocsNGqt/U1ABOOO9horMgJjBwn/
         l+ZXmMPe+CK61zWI5UAStHUvcIWGstXMDmXcm9An3m4RAuwhtoRunUDlG1HIWGAYZo/Q
         PAck0UUGv7F6XxErJzS8Uo1Ghuo2VfixXYEHkzWNGgDNJ4dXpWnIvvUykxBVDXOrm8MD
         929f3eTUAIgY6SiE70vn8Dy961xdQf8hqwxBPxN2wAd3IecEASY+RBLi3KuHwVY68QkM
         2DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269397; x=1685861397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28Amkh04p+8YFx4DGbxc9jqW7MpWBAmX1EZBEmgpetU=;
        b=U4N5VIZ/eQvG8cG17tWeggINTy54a0iQWuu+Y+KReEhUqLXF5s4q7r47g0nSWywUOe
         QDa8J1QOFrM1g7+AWxIeWbWkRG73K6lwGaBCCc+UpG7rzOutJJFecSSnlMv+U7O2jV2b
         GdAQc6O/EfmEcGha8uWk4CJlFhsLXj86z80RcNYTy0YvJMJjcryB4at4xQ5Sw/sfbqwV
         rIKjTt/5ifBY20M7hmZWYoNOxCYtE52uWvTU1H98vOjyBCR/n5/YZhVFsly2Ld7Zg/3H
         +E7qUFww+6fgROPDMJPxkKLqh7o2hgkEKUsDd5BhL1WGlqk23azE8OntuD17wfE0Dpel
         ceCA==
X-Gm-Message-State: AC+VfDy1i14S712jZmqyFmAgxRzhFyEYVsaGOB5z80TJ2sr5kMEKNkzN
        laT96ZqIa+vVRvCG8Sold6wm+A==
X-Google-Smtp-Source: ACHHUZ7uXiY7fJonm3DETvciJRwZfp0AwG+66b13twoR8wFRXx790O4owuKxR18HO6jUwgXemNVIHQ==
X-Received: by 2002:a17:907:9616:b0:94f:1a23:2f1b with SMTP id gb22-20020a170907961600b0094f1a232f1bmr266977ejc.24.1683269396852;
        Thu, 04 May 2023 23:49:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id v18-20020a1709060b5200b009659c23e78fsm521627ejg.215.2023.05.04.23.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 23:49:56 -0700 (PDT)
Message-ID: <30ee7d92-cc95-ba83-89e9-a2465cbd2fb7@linaro.org>
Date:   Fri, 5 May 2023 08:49:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: misc: brcm,kona-smc: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230504190250.GA10108@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504190250.GA10108@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 21:02, Stanislav Jakubek wrote:
> Convert Broadcom Kona family Secure Monitor bounce buffer bindings
> to DT schema.
> 
> Change during conversion:
>   - add used, but previously undocumented SoC-specific compatibles
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/misc/brcm,kona-smc.txt           | 15 -------
>  .../bindings/misc/brcm,kona-smc.yaml          | 44 +++++++++++++++++++

Please put SMC stuff in firmware subdirectory.

>  2 files changed, 44 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt b/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
> deleted file mode 100644
> index 05b47232ed9e..000000000000
> --- a/Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Broadcom Secure Monitor Bounce buffer
> ------------------------------------------------------
> -This binding defines the location of the bounce buffer
> -used for non-secure to secure communications.
> -
> -Required properties:
> -- compatible : "brcm,kona-smc"
> -- DEPRECATED: compatible : "bcm,kona-smc"
> -- reg : Location and size of bounce buffer
> -
> -Example:
> -	smc@3404c000 {
> -		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
> -		reg = <0x3404c000 0x400>; //1 KiB in SRAM
> -	};
> diff --git a/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml b/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
> new file mode 100644
> index 000000000000..ba0312a20083
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/brcm,kona-smc.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/brcm,kona-smc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Kona family Secure Monitor bounce buffer
> +
> +description:
> +  A bounce buffer used for non-secure to secure communications.
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm11351-smc
> +              - brcm,bcm21664-smc
> +              - brcm,bcm23550-smc
> +          - const: brcm,kona-smc
> +      - items:
> +          - const: bcm,bcm11351-smc
> +          - const: bcm,kona-smc
> +        deprecated: true

That's not correct. You deprecate the same set as you allow before. I
think you wanted to deprecated kona-smc alone.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Best regards,
Krzysztof

