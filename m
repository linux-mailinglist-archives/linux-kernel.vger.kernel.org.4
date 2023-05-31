Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDA718AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjEaT6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEaT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:58:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C75126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:58:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fb45a5258so1078531066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685563109; x=1688155109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kO8WlvOUEbiLU2mYlRLfvqgungqdL2NWVtlvvYCWsaI=;
        b=svHen/C2oRCz3tfMOEaRR1oMbW7v6BrhkCjHNRUIuM/YvboIDvnfH/iguJzCH/AmZR
         1Kjss+M6JBfleCuDc2sEaQOYeAF2f2Pr0SSgQPUX5MxM/JKXlKAHEL3P4HjLEa/2OwJO
         9YVVe1E4bGNqIrF6KOarmaTgngZ2UvJdWLJegUD66wOMul/Okn+jRyh43Zg343PCR12f
         3irit6+pIsQodAZGhLVrEO83RT2lXlA/MmRq8KOwWNF/rENXPxIXJCz/3rNMZEsuYtBW
         8Pxx6+nt6r/5s9oWDUO8cAiNZDipQ52UqAIYeaJ3n+7ztnCNFkmwvESbKbTam2BrY4f4
         7/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685563109; x=1688155109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kO8WlvOUEbiLU2mYlRLfvqgungqdL2NWVtlvvYCWsaI=;
        b=J5vIUwtQ0l7RDa7Pd0U9qiObvVk/6VemCZUDayBqUZxIODxHgzUV51D01XHohsaP6E
         bkfeU4O/agHrt8f7EntBaZRyTuWHOAOI2kP4XelzffAggtthlFU31YlH29pa3UKF5wAt
         TL5BIIPmU0G89pi28v2jMRczO59KO5haoAEM2KN1esRsLdT64z8k40YoNvfHMu/yV0fM
         v4Stha1mOpLeq4ygdUDipGEZWDXBPQT3sU6iqia+TZaAQURmy+/i5Z8suTtTnjigQ/We
         b33sNUwAaJwWc5jGPwTrcRElYUmHhB/ACpn4SUMenqhjBSW3KMaimeTegxOOnum3W9LH
         UrbQ==
X-Gm-Message-State: AC+VfDze+kwGPICyFgTb6MhhA8Wp+g35Nd9r6AV+H4PHZYhDic+t+mlf
        Vl9/vdpHdtuSaZ1nEK0CHe+9fg==
X-Google-Smtp-Source: ACHHUZ78+SP18m7Sljirv4lWr3WdkUxTqSqYQTLRkqby0dxS66JkZP6BIWLZHbYDZlwVBxzB+KwNZg==
X-Received: by 2002:a17:907:1694:b0:96a:1ec1:2c9f with SMTP id hc20-20020a170907169400b0096a1ec12c9fmr5718651ejc.12.1685563108904;
        Wed, 31 May 2023 12:58:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id m22-20020a1709066d1600b0096f777fc1ccsm9334299ejr.200.2023.05.31.12.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:58:28 -0700 (PDT)
Message-ID: <a1f1010f-5f8d-9737-725e-a15e918c7771@linaro.org>
Date:   Wed, 31 May 2023 21:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Add YAML schemas for LPASSCC
 and reset on SC8280XP
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-2-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230525122930.17141-2-srinivas.kandagatla@linaro.org>
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

On 25/05/2023 14:29, Srinivas Kandagatla wrote:
> The LPASS (Low Power Audio Subsystem) clock controller provides reset
> support when it is under the control of Q6DSP.
> 

Thank you for your patch. There is something to discuss/improve.


> Add support for those resets and adds IDs for clients to request the reset.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/clock/qcom,sc8280xp-lpasscc.yaml | 57 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,lpasscc-sc8280xp.h | 12 ++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> new file mode 100644
> index 000000000000..08a9ae60a365
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sc8280xp-lpasscc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm LPASS Core & Audio Clock Controller on SC8280XP
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  Qualcomm LPASS core and audio clock control module provides the clocks,
> +  and reset on SC8280XP.
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> +
> +properties:
> +  reg: true

maxItems: 1

> +
> +  compatible:

compatible is first in the list

> +    enum:
> +      - qcom,sc8280xp-lpasscc
> +
> +  qcom,adsp-pil-mode:
> +    description:
> +      Indicates if the LPASS would be brought out of reset using
> +      peripheral loader.
> +    type: boolean
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - qcom,adsp-pil-mode
> +  - '#reset-cells'
> +  - '#clock-cells'

Keep the same order as in list of properties.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
> +    lpasscc: clock-controller@33e0000 {
> +        compatible = "qcom,sc8280xp-lpasscc";
> +        reg = <0x033e0000 0x12000>;
> +        qcom,adsp-pil-mode;
> +        #reset-cells = <1>;
> +        #clock-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
> new file mode 100644
> index 000000000000..df800ea2741c
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h

Filename matching compatible and bindings, so qcom,sc8280xp-lpasscc.h

> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Linaro Ltd.
> + */
Best regards,
Krzysztof

