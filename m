Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30F67760E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjAWIHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjAWIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:07:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C21125AD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:07:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so7868145wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVQ5axIJVwuSAYvhI9ZqbYDfSY4qZw3+ju4l505nmSM=;
        b=YDMGPSSgTkWlWhATwYx5t55ztqz0WtMY/+rw9TD/xNR6r0uLpNh3+PQ6r+GWv7jvCO
         bsbj2uPKR+zF8z141GMP77eFA+lPPMZcCAnpDcXcHUU1Wyy3MmCKq2zoGoOTGlqgWs2F
         kBzNCju4oy3pfI80WDiPFUSCn7o8hHcf++hNcn6Am45wITw568oqWUkrvAElLUhlrk9h
         GaRzoAujd5JSsTFqBpY/YPCB5lrlnMxjX/Ms2HdkYVH5n6YOWTZ4to5CkkGdQY7AgBrv
         deFmVSpLbFaeov5WOTSQ0Z43IZVaSP1aJB9z0TUi7KhZIRQVD67HknmmThmci7KMrZDj
         Nm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVQ5axIJVwuSAYvhI9ZqbYDfSY4qZw3+ju4l505nmSM=;
        b=lQFGdOeZyty6lB0bianp8RR+6MvxMW5NByiX+WbYC3Ef29MPYOm7+lBao+7ppvD7zB
         4HqiePlTYg7hpTkJEYX4OT/TZvYPxcWv/mpkaOhXkq64jMv5hrRgI8GCcEqCzJrHtFjy
         PZT9Lqq7wEmiL4x383Rt82NCvaLUgEbow9g+1SyDKTBkQ/exwWdTxLeIZl8rWAquglqL
         H11JCg01zKedBNn5q2l6U/W3aztZVz7/vZ2rNFo9QMuDpEr88YsFn3q+3SCeZH/IGcwf
         RDkA2QOqqnmFIfUH4QBWbwlF4yErMp73Z5Mi+b1wMunvs+HcoTR5Q6Ej3ge1H1h2MqPl
         5VAA==
X-Gm-Message-State: AFqh2kqQ+znevbfMJWjKoog0iqsKGHFZLhSD5RRUuMM+sef60l9YbZEK
        tOIYjGMGk3PxxjAFV0gFju2GIw==
X-Google-Smtp-Source: AMrXdXtu2wzIhO70Sk+2krkLKVQM9Z9xPAVVSe0gI8P3VO5rhnqBm/JSnP57nxnU7W6zhLt7W07VOA==
X-Received: by 2002:a05:600c:21c4:b0:3da:fcf1:d4cc with SMTP id x4-20020a05600c21c400b003dafcf1d4ccmr22816261wmj.30.1674461254499;
        Mon, 23 Jan 2023 00:07:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6787000000b0025e86026866sm5603695wru.0.2023.01.23.00.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:07:34 -0800 (PST)
Message-ID: <7d191871-1025-43a3-20bf-8fc6b3f92c89@linaro.org>
Date:   Mon, 23 Jan 2023 09:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 04/15] dt-bindings: arm: add support for Ambarella SoC
Content-Language: en-US
To:     Li Chen <lchen@ambarella.com>, Li Chen <me@linux.beauty>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-5-lchen@ambarella.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123073305.149940-5-lchen@ambarella.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 08:32, Li Chen wrote:
> Create a vendor directory for Ambarella, and add
> cpuid, rct, scratchpad documents.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>
> Change-Id: I2c29e45c08666489b0d9b588ac37d713f5b723d1

Please run scripts/checkpatch.pl and fix reported warnings.

Applies to all your patches. Also test them... I have doubts that you
tested if you actually ignored checkpatch :/

> ---
>  .../arm/ambarella/ambarella,cpuid.yaml        | 24 +++++++++++++++++++
>  .../bindings/arm/ambarella/ambarella,rct.yaml | 24 +++++++++++++++++++
>  .../arm/ambarella/ambarella,scratchpad.yaml   | 24 +++++++++++++++++++
>  .../bindings/arm/ambarella/ambarella.yaml     | 22 +++++++++++++++++
>  MAINTAINERS                                   |  4 ++++
>  5 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,scratchpad.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml b/Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml
> new file mode 100644
> index 000000000000..1f4d9cec8f92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml

This goes to soc

> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ambarella,cpuid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella SoC ID
> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.com>

Missing description.

> +
> +properties:
> +  compatible:
> +    const: "ambarella,cpuid", "syscon"

Drop quotes (applies to all your patches)

Missing SoC specific compatible.

> +
> +  reg:
> +    maxItems: 1

Missing additionalProperties. sorry, start from scratch from some
existing recent bindings or better example-schema.

> +
> +examples:
> +  - |
> +    cpuid_syscon: cpuid@e0000000 {
> +        compatible = "ambarella,cpuid", "syscon";
> +        reg = <0xe0000000 0x1000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml b/Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
> new file mode 100644
> index 000000000000..7279bab17d9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ambarella,rct.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella RCT module
> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.com>
> +
> +properties:
> +  compatible:
> +    const: "ambarella,rct", "syscon"

All the same problems.

> +
> +  reg:
> +    maxItems: 1
> +
> +examples:
> +  - |
> +		rct_syscon: rct_syscon@ed080000 {

Really? Just take a look and you will see wrong indentation. Also drop
underscores in node names and "rct". Node names should be generic.


> +        compatible = "ambarella,rct", "syscon";
> +        reg = <0xed080000 0x1000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/ambarella/ambarella,scratchpad.yaml b/Documentation/devicetree/bindings/arm/ambarella/ambarella,scratchpad.yaml
> new file mode 100644
> index 000000000000..5d2bd243b5c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ambarella/ambarella,scratchpad.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ambarella,scratchpad.yaml#

That's not a clock controller!


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella Scratchpad
> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.com>
> +
> +properties:
> +  compatible:
> +    const: "ambarella,scratchpad", "syscon"
> +
> +  reg:
> +    maxItems: 1
> +
> +examples:
> +  - |
> +    scratchpad_syscon: scratchpad_syscon@e0022000 {

All the same problems.

> +        compatible = "ambarella,scratchpad", "syscon";
> +        reg = <0xe0022000 0x100>;
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/ambarella/ambarella.yaml b/Documentation/devicetree/bindings/arm/ambarella/ambarella.yaml
> new file mode 100644
> index 000000000000..5991bd745c05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ambarella/ambarella.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ambarella.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ambarella SoC Device Tree Bindings
> +
> +maintainers:
> +  - Li Chen <lchen@ambarella.com>
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +  compatible:
> +    oneOf:
> +      - description: Ambarella SoC based platforms
> +        items:
> +          - enum:
> +              - ambarella,s6lm

What is this? How do you expect it to apply? Can you try by yourself?


Best regards,
Krzysztof

