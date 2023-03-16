Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03CE6BC75D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCPHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCPHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:38:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB0C9BA52
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:37:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so3799294edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hF/zNj1V0FG7Xst+DyFdaV0IqlsgpWiuTDh6rcAehuI=;
        b=UZpv1cNZxXWcEX/fMRoA3CV/3HFENAHzHCospOSmfTP22Qjiz9f12YHg5fSt9D7Te1
         TyuwtPZsy6fyGGEXDH8ZLAfSWrTo1kO5+QlbyE/EjAyAO1BnNjks7uT9BBzmTHXF407m
         h/Ad2EnyY70WDkeCuNRxZfjgo2KlmGmUpnWfQAfug7WePy+N5IjRsk2iDanu0XowtAGJ
         gvltWl5uy+aSaJBjiEhYeOX5f/cTJoiLMAyjEdmLuwnuuE7TF4XJp0tCs5OC3PyjZ4LE
         ngeY2We5dC+XJYajz6nxGQMVkMihdHaktyvXV+2lmVMbJFBfO3G2koGyPrg7Vg4qsZ2j
         4HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hF/zNj1V0FG7Xst+DyFdaV0IqlsgpWiuTDh6rcAehuI=;
        b=n6MHCruPkYOH788OqSclbI0mpzSkLXcpiht5AyCQNJ7ORFouODkt/CCIgPGs6eG7AW
         HKWmOHJzBfrrO8185uqqwCp5sUI+biWtIPpSaBNIeoecs6vEaffC2pERekWGdExltgRq
         6WNGu7lT1kPxEzfI3FUOXC/hKI6HrQ6uV3hI1wOfoTEMFkbeqkGyYR2OBp4I8/Vn2gu/
         AQCD2uK971nAOYaQ0x7CBWA8muLKRfa9iLajVOgIcN4XUujCjGaAXAVfXH6bD1EtNrOm
         XfB45LJ5qVZJHASq5rY6HxwBXMKYSMQJedZkR4MEQIIm1Gd7deUxec35gXBCsyP7DQ0f
         UHAA==
X-Gm-Message-State: AO0yUKVusfSiC5JHCCnpTCQvUhk0ZZ0UjVRIP7Jve/Gn4dmrjdi9/LT0
        iHLQ6BaCNc4YV8BRLcsPWixrkw==
X-Google-Smtp-Source: AK7set99BARYiABWdxSucm1AIAG1CMIxyxg7JeEMhWzwH/fPGwk27qMXxPmFMvOKuIreidu+KbUQJQ==
X-Received: by 2002:aa7:d14a:0:b0:4bb:f229:9431 with SMTP id r10-20020aa7d14a000000b004bbf2299431mr5712363edo.19.1678952271472;
        Thu, 16 Mar 2023 00:37:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170907985100b009300424a2fdsm760791ejc.144.2023.03.16.00.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:37:51 -0700 (PDT)
Message-ID: <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
Date:   Thu, 16 Mar 2023 08:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset
 controller bindings
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-10-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-10-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 reset driver bindings.

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> new file mode 100644
> index 000000000000..f66c566c6dce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Reset Controller
> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description:
> +  The system reset controller can be used to reset various peripheral
> +  controllers in MA35D1 SoC.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-reset
> +
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the register map node.

You need to be specific what is this. As you can easily check, there is
no such property in any devices. I don't understand why do you need it
in the first place.

> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - regmap
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # system reset controller node:
> +  - |
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +    sys: system-management@40460000 {
> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";

And your patchset is not bisectable.... Test for bisectability before
sending.


Best regards,
Krzysztof

