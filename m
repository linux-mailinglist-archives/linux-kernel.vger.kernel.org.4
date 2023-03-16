Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210156BD949
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjCPTeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCPTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:34:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525CD274B2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:34:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r11so11965822edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678995247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyciw28w72xcQW9mQh3xwrk42HtEkqAkTnLwxCjUt1I=;
        b=jDqdnQW7R9aFerJ6wrorsKPfOTU+aKBneRLhQVGtss9S/T+e8qLZ/WtyuHSPazKXlP
         LCLGXb1WbkdfS45+Npn8Nl0lKy1f84TjB4kQ8fy8EG/c9bwDun7ozcmubXSESQemTOzR
         h8ULyf3hwJtSIEP97mfo4O9wZyhKn/gZHDHoI73gViztzppizQXDBT5AYu0sxRRhDv2q
         IdGW3c8psvYjfBnse59HncFk0Bvr7+ObRp+8rLhKCLJvqQ4DEiqoJKstGX1bawSQZWwv
         1x7GY5SqbwcSUNZLLvaSUufn5E40ozOsYJj5tvPI70FDX6AEWkCBsACJUm/YtG/2Tirl
         iSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678995247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyciw28w72xcQW9mQh3xwrk42HtEkqAkTnLwxCjUt1I=;
        b=e1r85bke5JNUBk7MYA8eu6rPGjiqb86CRWdjrPoBAwzGb7L1VkKBgvEwjynhD6fpy7
         tJRWxlocfmazEZ4DjIPbNCiJ9ohI0GJtNCoSsgpA9/X5hu67Y1+Pu/svQJWBJVYrF5jU
         iaPGbd9/mpOrgsApYdjUXgmpVTS1jmOJzeFAsvlQchdWz0NCniQ2r+krPlYLFmtkQ61h
         XoGFLt5ej3bJOExdOxilU2TiOuTFKajqgqjo36nWwYE7QKVJzKDc0rz+c21DJrxU9o94
         R87L/FuBMbRXvXLXZWPRZNndGDvt4Ww0c/c9hncE45DAUvuD8MumevaxrCwvSsTXdBDa
         5WmQ==
X-Gm-Message-State: AO0yUKWTnJyjCC8IhhO6tPwJEXue5SV/87X9rfLqZXPesO0JWCUlOqIK
        2OW9xlPRthL/piHoskEF9eB7AA==
X-Google-Smtp-Source: AK7set/v1W7Ns5+ZlsqTjhJvhjWCh0bXOH6bccxxSpksf19UNwSeZsMDyZ3fw5BSDUUO2F7XNaAskg==
X-Received: by 2002:a17:906:cc54:b0:884:37fd:bf4c with SMTP id mm20-20020a170906cc5400b0088437fdbf4cmr11914784ejb.19.1678995246860;
        Thu, 16 Mar 2023 12:34:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709064d0500b00923f05b2931sm16291eju.118.2023.03.16.12.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 12:34:06 -0700 (PDT)
Message-ID: <7424bab4-6a92-7d71-b110-454819101678@linaro.org>
Date:   Thu, 16 Mar 2023 20:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: Add bindings for videocc on
 SM8450
Content-Language: en-US
To:     Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_skakitap@quicinc.com, quic_jkona@quicinc.com
References: <20230316083049.29979-1-quic_tdas@quicinc.com>
 <20230316083049.29979-2-quic_tdas@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316083049.29979-2-quic_tdas@quicinc.com>
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

On 16/03/2023 09:30, Taniya Das wrote:
> Add device tree bindings for the video clock controller on Qualcomm
> SM8450 platform.

Subject: drop second/last, redundant "bindings for". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../bindings/clock/qcom,sm8450-videocc.yaml   | 84 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,videocc-sm8450.h   | 38 +++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8450.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> new file mode 100644
> index 000000000000..909da704c123
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8450-videocc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Video Clock & Reset Controller on SM8450
> +
> +maintainers:
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm video clock control module provides the clocks, resets and power
> +  domains on SM8450.
> +
> +  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8450-videocc
> +
> +  clocks:
> +    items:
> +      - description: Video AHB clock from GCC
> +      - description: Board XO source
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bi_tcxo
> +
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      A phandle and PM domain specifier for the MMCX power domain.

Drop "A phandle and PM domain specifier for the"

> +
> +  required-opps:
> +    maxItems: 1
> +    description:
> +      A phandle to an OPP node describing required MMCX performance point.
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

That's a unusual ordering. Either order elements by name or use some
custom order... but then reg is always second property.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - required-opps
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'

And keep same order in required.

> +
> +additionalProperties: false


Best regards,
Krzysztof

