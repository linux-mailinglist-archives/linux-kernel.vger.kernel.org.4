Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA67D637802
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKXLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKXLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:51:59 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482B69370B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:51:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r8so1717338ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOdTvMo8dMW0KOze7cODnIqtVzrXTSA2hp1NUSdu9ZM=;
        b=zmKh5jbifjAJVRLyl1Om4Fi5vQG7QeZB/vETFbmb1b0Iv0NjfDNz1VeiZKIdbp9Y1i
         swOQ9aJxjwIVdFgnrJXHgnbzwD7aqZRK+zXa9yoxSO6n72pc6F6qyG9UibtvDxfReEKS
         93OCvOjogMyBudb8o1WvckVJt40mwbuMkd3JNHlyBueeBqpMkzBuyfNXc0y85bHGFPX0
         hlw8oQAGUhJmjBU3/L1W1Ndrv2N+Ut8xJZKPMX3KKaGGo8vvj+/HpmjaDNgP0KFF0e62
         aJnTJtpKEc0ZTvgJPrlFmkKD15i4PgGu/6nlVgioJzYzy/RWlGZ8eE+HV6Mm/R/v24HO
         pDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOdTvMo8dMW0KOze7cODnIqtVzrXTSA2hp1NUSdu9ZM=;
        b=6aXOaZoLB/3Xmfj983yvB7M1mMg9Oc+rHJhcOoA6zd/5FN1ZhqlUoQ/rVW7sHQdOUp
         a8Mz3Hj1+1kx/UF9lwkWO7vEoie5NajnLlfrdwoGoVlUsYTxgvgxFO44zSzmHFXy6SF+
         q8ufvqfXpM89CvK9S3r7R8V0Ux6f74J3fX0+CyfbrhEgYEeFRUTZsQlpGo+73SwwsPIJ
         h7yt43nY/Wnt60h3CtRMctIKrfqRSxtgIfGb8+fKumvknhUTHNOyWMhbJJgYfKG7IcmQ
         EKj4BrT+7J07t1QZtaU9vILz+/ZCAOs7RIaoAVzaVpzF1HxOsYNJ2O0y4CTxG/qAtCgl
         ZxPQ==
X-Gm-Message-State: ANoB5pky+vAAGtWduBVby5w0nitQAusXTqa+yIjN1TQ7ZIE4IAQMXFLG
        W7ZsFBKT3UYQ3bIesBFwchCjdw==
X-Google-Smtp-Source: AA0mqf5Uby/2/Ol2+Q46FnOUV4X5k6uLRpoAeZ9RhJC9SCiGl76St58sKeziu8lkXzkGj1Q0gTHP9w==
X-Received: by 2002:a2e:b8d1:0:b0:277:6fea:ac1e with SMTP id s17-20020a2eb8d1000000b002776feaac1emr10187873ljp.200.1669290715630;
        Thu, 24 Nov 2022 03:51:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512358400b00499b27a329esm96141lfr.300.2022.11.24.03.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:51:55 -0800 (PST)
Message-ID: <bef911e9-174a-3ab1-41b0-949028a7db7d@linaro.org>
Date:   Thu, 24 Nov 2022 12:51:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/9] dt-bindings: clock: Add SM8550 TCSR CC clocks
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221123142009.594781-1-abel.vesa@linaro.org>
 <20221123142009.594781-3-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123142009.594781-3-abel.vesa@linaro.org>
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

On 23/11/2022 15:20, Abel Vesa wrote:
> Add bindings documentation for clock TCSR driver on SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * based on recent bindings, like Krzysztof asked
>  * used qcom,gcc.yaml and dropped redundant properties
>  * used additionalProperties instead unevaluatedProperties
>  * renamed qcom,tcsrcc-sm8550.h to qcom,sm8550-tcsrcc.h, to match
>    compatible
>  * added dual lincese to qcom,sm8550-tcsrcc.h
>  * moved patch to the beginning of patchset
>  * dropped redundant "bindings" from subject line
> 
>  .../bindings/clock/qcom,sm8550-tcsrcc.yaml    | 39 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm8550-tcsrcc.h    | 18 +++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
> new file mode 100644
> index 000000000000..a4531a7cad8c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8550-tcsrcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm TCSR Clock Controller on SM8550
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description: |
> +  Qualcomm TCSR clock control module provides the clocks, resets and
> +  power domains on SM8550
> +
> +  See also:: include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> +
> +allOf:
> +  - $ref qcom,gcc.yaml#

I am not sure if this is similar block as GCC (or how similar). This
wasn't here previously. There is also a typo (missing :), so bindings
were not tested. :)

> +
> +properties:
> +  compatible:
> +    const: qcom,sm8550-tcsrcc
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@1fc0000 {
> +      compatible = "qcom,sm8550-tcsrcc";
> +      reg = <0x1fc0000 0x30000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> new file mode 100644
> index 000000000000..4ce98ffc43ce
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm8550-tcsrcc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
> +#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_SM8550_H
> +
> +/* GCC clocks */

And these are TCSR CC clocks :)


Best regards,
Krzysztof

