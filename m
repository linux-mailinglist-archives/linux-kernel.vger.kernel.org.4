Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93629707041
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEQR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjEQR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:58:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5EF30E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:58:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso1100796a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684346328; x=1686938328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3xY1JCEQxcvzs0PmRIIYxSLiWCMdSU7/ohWJm/hG6xo=;
        b=KuyZ4BSpveQ66Kj7PM9d4+h4kwrBu5OJuEFatgNtyCQxJbCrA33RS+HKUUfws2z2yU
         +WXpdgic2ft5KJk0W1KKD6XP7dwINh0nosE8QQ4i9Tp5LJtGZYy4uUI6fE+1nAvfcU+o
         2j2rpSCIO6agggEbsMJhMRDL3Akee8twxUB218bO0ucZey7pAQYG2xH2e8tgl1rzpinU
         xmtToOaPD8k+6GeWkb7YNCguTws3pUz+oau8dNv6yLNvUO5qY5omMuqezVb7jZ4HqSkr
         PMTNzChR21QGqeQHQF/dduKl0qvYYYrgY8Wz2aM0RgDJIiunkfFEFEstSdAJ7wTDqcKK
         pW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684346328; x=1686938328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xY1JCEQxcvzs0PmRIIYxSLiWCMdSU7/ohWJm/hG6xo=;
        b=QoMh6aevhaKpbCDDCrIvAi1j4TG/+BEz9QR6QIBAb9usGy9XQbxlZwQ30sdZjr8yrH
         0Mh2gvciQn3xIg4BF+DXG9SFBAP0dcSvvbByrTBQ+a0q747BeWWRszHe4QhkICCc9qqX
         HeW2CFNpMRoxUjUmDGXdXc/aGexjH/2UNEGxziTeKSEjprM95tblzzNeYU/64nibRAF7
         9lvM9+ocgnxgwpTOp53CHmlACDBOwrjINeg0ytdMSz+zdzNyC6HyjW2P0YMhAxcJsUBa
         dbIPPKqF8mp0u2oudjVpga8sHGeIbynF/+6Jgd92r4aPubFkxtbf+EawdcidUtvwI1qb
         HOuA==
X-Gm-Message-State: AC+VfDwfHox6YWBCyraFBppMdPlaeqyneBBSYVNz+PdwuUdryT8zYufD
        Nflf4QtleRSWdFjhMjAiC0EnLg==
X-Google-Smtp-Source: ACHHUZ4+I04w2oCouHmiraoxQ9cnEQIU0CDJVo5wdeZ/CokqQoACA/pFV0LqPYEBUzSYqDjhdWBRjg==
X-Received: by 2002:a17:906:9749:b0:96f:1b96:6147 with SMTP id o9-20020a170906974900b0096f1b966147mr1208654ejy.55.1684346327721;
        Wed, 17 May 2023 10:58:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ay20-20020a056402203400b00502689a06b2sm9632296edb.91.2023.05.17.10.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 10:58:47 -0700 (PDT)
Message-ID: <3239db1b-3ade-8881-e05b-2e69a7d5f287@linaro.org>
Date:   Wed, 17 May 2023 19:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] dt-bindings: clock: Add Qcom SM8450 GPUCC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
 <20230517-topic-waipio-gpucc-v1-1-4f40e282af1d@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230517-topic-waipio-gpucc-v1-1-4f40e282af1d@linaro.org>
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

On 17/05/2023 18:40, Konrad Dybcio wrote:
> Add device tree bindings for the graphics clock controller on Qualcomm
> Technology Inc's SM8450 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8450-gpucc.yaml          | 73 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm8450-gpucc.h      | 48 ++++++++++++++
>  include/dt-bindings/reset/qcom,sm8450-gpucc.h      | 20 ++++++
>  3 files changed, 141 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
> new file mode 100644
> index 000000000000..ad913b2daf0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8450-gpucc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Graphics Clock & Reset Controller on SM8450
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description: |
> +  Qualcomm graphics clock control module provides the clocks, resets and power
> +  domains on Qualcomm SoCs.
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,sm8450-gpucc.h
> +    include/dt-bindings/reset/qcom,sm8450-gpucc.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm8450-gpucc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: GPLL0 main branch source
> +      - description: GPLL0 div branch source
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

If there is going to be new version:

Keep the same order as in properties:, so if reg is not second there,
neither should be here.

In any case:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

