Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67C66E98AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjDTPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjDTPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:46:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60AE6D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:46:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95369921f8eso77452266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682005563; x=1684597563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cIHBvHWcGEnYBnx07Jx9M8LLOFZkmUFP1XaIMjnq7Q=;
        b=e0hKPqIszYbYGJTlvCw3gsjO6ZNlIy5fi0qrX+vYzS25QEKh4qLoIGJ1P76GqbcyBy
         1lF6GGuGAImVE6hpraQzoyydZGHRZlTmEG/wQZJTUuc2GPf/GFD56u+YxcyTM8EXhad2
         ylKfpwqfeYcWPiQB0WAGYfChHYQNT3kCk083C0x5//SsjpXJOndN3T82JISqqFcPiaxQ
         uGTT2LPm2MiosKnvZ7QIVoRgEox3hXsasn2T3YpQooRYnICpmdXwG3d/xVAgXljHO4Iw
         fD2Nb1zZK3jVpc8uBcEp+rrK1HYeNfyD2et9WGuKW3X+W8noKGK97O8yjmeHjl4NygxN
         KGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682005563; x=1684597563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cIHBvHWcGEnYBnx07Jx9M8LLOFZkmUFP1XaIMjnq7Q=;
        b=AH37/RL4znAljEX923UPi/80g+8Hdh4d0VrBMOG7dBM81NcQP+3BXWdKS4lJLv/4at
         +d+hgYRce2+LeFIj3bAbmI3E6zm4aPXZ9IDjOdESIgk9FMK/BS/A/Gj3H/Z0hg+p8YKz
         PPHJHsbsT1RU9czjo/LiGXalWhwyQBowv50/jZBkS4UfETSapkwt+oAABOZBT+QqK0l8
         KiCPSAG9lenEp/ikkpZ4ByjU5qTw3zN83m1L2fniVKpOVD9/I8MmiZhFABcpY7z3Foin
         /HPFseqF/W/kzw+rI8Y3pG9zCftAg3j1cKEpJ0pShCI4DKBH79iKOXjlDto3DOgWTmGv
         o33g==
X-Gm-Message-State: AAQBX9fRos+Y0gusBYfAZJ6eLNdWqE3hJU15iWsQoDsnrSIuXnP84g/g
        6q6JmfcufbKBoGtb2RW/ZZsAsw==
X-Google-Smtp-Source: AKy350ZR+5rRIUICH4MYgDTvUmfRzv2UsKC6PnHsLTZnVEbLk6qFlRl61Wr0kPjQFJ+5VzKwCqpkdQ==
X-Received: by 2002:a05:6402:332:b0:504:7f72:3db3 with SMTP id q18-20020a056402033200b005047f723db3mr2383006edw.9.1682005563214;
        Thu, 20 Apr 2023 08:46:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b0050687f06aacsm861574edy.12.2023.04.20.08.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:46:02 -0700 (PDT)
Message-ID: <4127a3d7-f65e-7d9c-86ea-e2e9754201aa@linaro.org>
Date:   Thu, 20 Apr 2023 17:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Add SM8350 VIDEOCC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230413-topic-lahaina_vidcc-v3-0-0e404765f945@linaro.org>
 <20230413-topic-lahaina_vidcc-v3-1-0e404765f945@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413-topic-lahaina_vidcc-v3-1-0e404765f945@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 14:53, Konrad Dybcio wrote:
> SM8350, like most recent higher-end chips has a separate clock
> controller block just for the Venus IP. Document it.
> 
> The binding was separated as the driver, unlike the earlier ones, doesn't
> expect clock-names to keep it easier to maintain.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8350-videocc.yaml        | 81 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm8350-videocc.h    | 35 ++++++++++
>  include/dt-bindings/reset/qcom,sm8350-videocc.h    | 18 +++++
>  3 files changed, 134 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
> new file mode 100644
> index 000000000000..28a1002b1563
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8350-videocc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8350 Video Clock & Reset Controller
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description: |
> +  Qualcomm video clock control module provides the clocks, resets and power
> +  domains on Qualcomm SoCs.
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,videocc-sm8350.h
> +    include/dt-bindings/reset/qcom,videocc-sm8350.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8350-videocc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Board active XO source
> +      - description: Board sleep clock
> +
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier for the MMCX power domain.
> +    maxItems: 1
> +
> +  required-opps:
> +    description:
> +      A phandle to an OPP node describing required MMCX performance point.
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1

Everything is the same as gcc.yaml, so add a allOf:$ref to it, drop
unnecessary properties and use unevaluatedProperties: false.

Best regards,
Krzysztof

