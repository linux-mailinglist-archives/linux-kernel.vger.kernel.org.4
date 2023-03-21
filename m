Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B036C383F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCURd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCURd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:33:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898CD53D8F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:33:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t5so25951227edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679420000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ochp5U/z+JPJ/YorY5MT0cSwY1Sw+z1CDqsaJ+qW2jU=;
        b=xeo1rt1i/Xy2YmniokvFRCzHeMIAub0jrdV+Ou2OsopQ7Sx0W9xBotcgFRZ4VnBH/G
         2JAJBkYP1rpDPBNIErbDLhNLdX56BwjhubSL+Zdjsr+Kgo7psncK5VmkbNEOjMxlcONp
         ewZ+1KlwinjdvLlWoMn+2Gpp63T0xvWjjGGMT6DiHIuKdUJOaPBj1Xc41DEeaM++/QmL
         Z3fir6JozYswMIGIAnts48g2SQHx9wJLSnF39oI5FUx+5WvabIjNHH4KXqgBfquLCS7x
         OFq2zt2zYVIrWqNF3F05qma6e7v/HIvd2Wf9SNVzUPCJY1XsXnMs0bmUQ0OBaGQLKpdL
         ItFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ochp5U/z+JPJ/YorY5MT0cSwY1Sw+z1CDqsaJ+qW2jU=;
        b=8NE93efNf1y5DBwDtVIvmUi2eLwf+XaOSFgMG3D4+LPnD8Hppz67MrZKsZN0HC4Vbc
         ZJUWQa7JqTYc4PXC9VvCAcai0cZHLl6OPQUhOZegqLo4zBE/KhOlrgmMay2FDzuvGFdO
         NW01tFkRsIbFaCPfhAIICqK8iuSla+N96KgUaXd0w0ExxagemCvCQYrip8yyoxYzCq4p
         QDP11O9zWAjYchEKsUOQ+dMkCYx30oYM+LzRHpqinyAoeBQE4fC4BY92u456W3SjzJju
         2jRXVxL6jH2zPGmTPfB9olwWX1qjSGbHCuNyWD9qPjkbcZevsjQLbcYBl/6jaaiITh4x
         /dkA==
X-Gm-Message-State: AO0yUKVQTZzvaWijR4A9pAeqaXiocDJR95K+bb/SNJ51WZm2O7jqoV0s
        QJfcFNo7YYpJm81sT7Ff23kuDg==
X-Google-Smtp-Source: AK7set/v/ZVk5N7EL089HA1rFs0IQ+7797TjgYvJfWP5FuppUeBwgImPuQRLLhQvRVpAJCuZMYTb1A==
X-Received: by 2002:a17:906:4a0d:b0:88f:a236:69e6 with SMTP id w13-20020a1709064a0d00b0088fa23669e6mr3428975eju.7.1679420000035;
        Tue, 21 Mar 2023 10:33:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709062e8700b00933356c681esm4552255eji.150.2023.03.21.10.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:33:19 -0700 (PDT)
Message-ID: <fc46c48d-2de0-ba3a-08b0-a09526bd9e26@linaro.org>
Date:   Tue, 21 Mar 2023 18:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V1 2/4] dt-bindings: soc: qcom,mpm-sleep-counter: Add the
 dtschema
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <576e53a1d0ef218536da976102b4cc207436ec1d.1679403696.git.quic_schowdhu@quicinc.com>
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

On 21/03/2023 14:51, Souradeep Chowdhury wrote:
> Add the device tree bindings for the module power manager sleep
> counter.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../bindings/soc/qcom/qcom,mpm-sleep-counter.yaml  | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
> new file mode 100644
> index 0000000..f9f46b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,mpm-sleep-counter.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,mpm-sleep-counter.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MPM Sleep Counter
> +
> +maintainers:
> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +
> +description: |
> +    MPM(Module Power Manager) has a sleep counter which is used to track

Missing space:
MPM (Module

> +    various stages of the boot process in Qualcomm.

in Qualcomm SoC. Because you do not track it in the company...

> +
> +properties:
> +  compatible:
> +    items:

Drop items.

> +      - const: qcom,mpm2-sleep-counter

SoC specific compatible.

> +
> +  reg:
> +    items:
> +      - description: MPM Sleep Counter Base

just maxItems: 1

> +
> +  clock-frequency:
> +    description: Frequency for the sleep counter

Since this does not have clocks, what frequency you are setting here?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mpm2-sleep-counter@c221000{

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +       compatible = "qcom,mpm2-sleep-counter";
> +       reg = <0xc221000 0x1000>;
> +       clock-frequency = <32768>;
> +    };

Best regards,
Krzysztof

