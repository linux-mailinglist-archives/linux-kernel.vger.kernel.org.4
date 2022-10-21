Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A8606CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJUA5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJUA5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:57:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D011C7128
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:57:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id x15so885155qvp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0SdjGX93SoUfgDNcPGyqCsKajZovtPz4VDBIQaEbUw=;
        b=K2GsRTG+bSqoKbLmErsIpN4EL1UTxTrjiH5LtCpkVWp8ZKQJ3BP7leJ8aTCinICyFB
         F76jiPG1g5sb9CBh92ZbvlDB9CdqJd0zYtkW3KdkTOSs8xekNf+wqpu9nDZCaK27heET
         agVbeQ97cNPvr8f91bT3FXLrUD2hhr5kCuPPejQ+1IhJYRXgsL7P+qkL8tVEaHsOSH3P
         39mH1CKTA9MtHDRqMu+vv+c8JB6k4V0UJncn7D0aK0slUrywNsOk0J8AdFGHEykfhWYJ
         Iy7aBYBz0Jtiiyvm4MKOTPnOS8o5J2Ov9p4NYdIGLtFpOnuE8aoHGzcTALTBOZ2pfP7h
         akRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0SdjGX93SoUfgDNcPGyqCsKajZovtPz4VDBIQaEbUw=;
        b=cHPPMdF5DvPPSbD0uzAQ1T96NpU9RgdOTqZFn4lHlZxWkM5DSWsSkmD5Egcxb5Mvn8
         YLuXfQIwjdvdwApGchT9oKCDPifIcnR3K9mflskeOql7AhAJYAXCsOWk0mhDnzOkJgfG
         zomjkxTadN6sa7AW2S69oN3AePyIYKVldlGD15xaFiFRlO3SkZuZ9b1jIjX5jLbpgJE7
         n7i4wHu+LpeMSVJnfx4/Z66jn07iU2R66G1qJFx4MxyVVmlpATJoVez0OlN7p7Y897yY
         YRBeDfqTIwm9VrDJbsCMpJOF9vBTcYbo2McnxKw6ZwJwjUKIyVFaNylfHh6bB71ZaR1A
         Twig==
X-Gm-Message-State: ACrzQf0lP2FHzjzuFdE+NNJcqvzbGdUdF81Uf6z4WcQyiwwMVRtQMUo9
        svB4XJhmvFPpVqzfkryVw++gBA==
X-Google-Smtp-Source: AMsMyM4RPti2boCODgoqSWyPSib8gDX4SUzNZkPomNOm7OB5OU0HG8iKXhT6X7ezvTMPKyb11m+LFw==
X-Received: by 2002:a05:6214:29cb:b0:4b1:7991:e844 with SMTP id gh11-20020a05621429cb00b004b17991e844mr14426856qvb.72.1666313857373;
        Thu, 20 Oct 2022 17:57:37 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a414b00b006e99290e83fsm8678550qko.107.2022.10.20.17.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 17:57:36 -0700 (PDT)
Message-ID: <2458332d-5a55-a74d-d6f0-c1457fbda282@linaro.org>
Date:   Thu, 20 Oct 2022 20:57:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT6190 regulator
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1666249033-12219-1-git-send-email-u0084500@gmail.com>
 <1666249033-12219-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1666249033-12219-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 02:57, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add devicetree binding for Richtek RT6190 4-Switch buckboost controller.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt6190-regulator.yaml        | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml
> new file mode 100644
> index 00000000..be0fa7f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt6190-regulator.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt6190-regulator.yaml#

Filename based on compatible, so just richtek,rt6190.yaml

Unless it is a part of some MFD-like device, but then compatibles needs
fixes.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT6190 4-Switch BuckBoost controller
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RT6190 is 4-Switch BuckBoost controller designed for converting input
> +  voltage to output voltage that can be equal to, higher or lower than input
> +  voltage. It operates with wide input voltage range from 4.5V to 36V, and
> +  the output voltage can be set from 3V to 36V by external FB pin. It's commonly
> +  used for the application like as BuckBoost bus upply, docking station and USB
> +  power delivery product.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RT6190/DS6190-02.pdf
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt6190

Best regards,
Krzysztof

