Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560D8720303
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjFBNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjFBNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:17:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE52E74
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:17:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso2971970a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711848; x=1688303848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fY7bbQIPT2xA10x1UgE0E5+ayGshUTrJHxa3pbabpo=;
        b=bE7jyu4/I1cepLQjzEZDIWtav5BzekEP+h5PinZX8fXandcuko9zpaMUXPkIMXza52
         JKUjDkOCO//2dNgFo7cACkNhMQhajVTh5gPZ7St39C1JVbu0sYrd1GLPmYmtYK73a19Y
         f3LusTLCEdWA/YzaY4mTWr3jGMvI6/POvErtT5095YmuWGLiYI5X5LBi90RujUOLcHIj
         e+OVANNoH/B5GCI5g4mr1P8czOfQ1gcGdG/UGcFYjPesFfkMHBPW5TscEmj1XIVMDGmO
         PRguTu3vJaHrPwmrKA2IB4+5/TZebwdhqLMigpPmQaKPr38s0IOH7KPYSr3G8cKl8/z+
         GpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711848; x=1688303848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fY7bbQIPT2xA10x1UgE0E5+ayGshUTrJHxa3pbabpo=;
        b=EkuloOegankL83+FsV778T/Sx7Rk1Z02TTjY7nJ79h7TXrxp7mQArdegq0gRMeFpbd
         Ar29Rt7b0ydpvLEBZ8/Ff1DEN1E9roZyxjbMFXbophKCCGVjPdW1FOyDllyhzEKhPI31
         IR0/L1wb7n9SDXp/31yskTscxmBMygritEzA8rsoe/ODTVwrbw2k5FNgvfBTaNNK4Rhy
         KRCUl2VSZ5OWrYwHckHbMWNrQQnhQmQv00TsaXkxakT4Dwh9dC8em9LbYeqiYP4Elbt2
         DlRQZd5jnxVuf+wzBRXGtah7+eEnffnZYxHOmIkPnLobbuMqpvbB1l/FG/LgBvOTrINt
         UWmQ==
X-Gm-Message-State: AC+VfDw/pFfjl4XAggSa9vlZGk+uFlEjtJz5vNOXgIePfpVMcVVq7D4V
        lMm9L1VuKdTZICYTQQv3vKxHFQ==
X-Google-Smtp-Source: ACHHUZ418rmLGTtFNlp2AvZEOomlBzrjFdBzEmOPlaaC7qbEdkVU1W12n9pmOvk3BSRvocfUgElUxg==
X-Received: by 2002:a05:6402:7ca:b0:50b:fd52:2f4b with SMTP id u10-20020a05640207ca00b0050bfd522f4bmr2106421edy.24.1685711848503;
        Fri, 02 Jun 2023 06:17:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b0051631518aabsm670509edr.93.2023.06.02.06.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:17:27 -0700 (PDT)
Message-ID: <bedb5ab1-59f4-98f7-1a0f-8d3be6e10569@linaro.org>
Date:   Fri, 2 Jun 2023 15:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: clock: Add YAML schemas for LPASSCC
 and reset on SC8280XP
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
Content-Language: en-US
In-Reply-To: <20230525122930.17141-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as my previous email probably got lost. If you got it twice,
apologies.

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

