Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203867E183
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjA0KW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjA0KWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:22:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9701E9C3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:22:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q10so4527156wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CEHKrMArowrp45y0BJCJO3EwlygbfM1dWauMJbvYl4=;
        b=otigbkRW6OwuOG2Op9YG90y/V+Tu/nCl0D7Wg/TvdYnKbPVzQNxJRx0zM4SOoTK7MD
         2Txd9qlyPedexlCQiNusoXu+emdX0JHchh7Xrml0Yt+XvNYRlLGQ/O1a4HrO3cczbXh1
         1VYNF+dGw9FSP4ZV0V4sXVy7tMrKOJ7h3bthsWGCTJugtBJCd9klwMCAoSEkGaiR3OkA
         RTchiXQPqraytJyp/9A/rWew1+S0BFJE8mCj5HVU8ade5WMSXgZXQ2PRANbqlfxh3nJj
         tUyX6DwdNVX9iV3JJj8ajSqvyBto8Vse5s0uvaU5AVWACM51yo70S3BCC733S7Qm9YTH
         QlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CEHKrMArowrp45y0BJCJO3EwlygbfM1dWauMJbvYl4=;
        b=PUw9lmz8qDwSIO2LS+InnDDvH66AhUzuHT92PHfirgRocugz4vfKmhH3uEX08VYpjy
         lQUBo+hisPZpsFGwaWBzHIx1Ll8nOvDK0hqnKHut6t6GiU7Qbe0VBpvNNQCTN+bldoBv
         D+/sF2IX1DDlMO+QR6jDCUBbcJiYUlKbtWZK4zHbCzG22t3XKSHEqV64GW4CQulzhuj4
         QpfvuCpdh0b2+ZQumZzgpyxi5PBmdR+iL8srenxaXlbEPMIgor/M0I9nryBqQN8IwnS7
         uWTKMFSPBEAOmWZME3zxHAzM6Ua8frdWE+joAF6lxjcKS/Ce/pJnfIrfDV/Fqs90+fn+
         Lt/w==
X-Gm-Message-State: AFqh2kq5Ke1ey52oW+kNTNv7y6iWAwh5l3c6szQrNCM7x6dT6msVa4Nx
        0Ha3ugJLC7M0e3ESaHIbZfXP7csKoNu61/OA
X-Google-Smtp-Source: AMrXdXuOhdgMh17Z4KujKWs02hUZNK/b3pZwJtW3Bkyst7YC0mAzk4Kn36PGmaGsYP8VOwfbJUywYw==
X-Received: by 2002:a05:6000:81b:b0:2be:5c3d:99e3 with SMTP id bt27-20020a056000081b00b002be5c3d99e3mr27717572wrb.10.1674814971469;
        Fri, 27 Jan 2023 02:22:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b002b065272da2sm3706693wrn.13.2023.01.27.02.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:22:50 -0800 (PST)
Message-ID: <b8ce28b5-0e53-aca4-a2e4-f6333b5ac80b@linaro.org>
Date:   Fri, 27 Jan 2023 11:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: Add Qcom SM6115 GPUCC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126181335.12970-1-konrad.dybcio@linaro.org>
 <20230126181335.12970-6-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126181335.12970-6-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 19:13, Konrad Dybcio wrote:
> Add device tree bindings for graphics clock controller for Qualcomm
> Technology Inc's SM6115 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> 
> No changes
> 
>  .../bindings/clock/qcom,sm6115-gpucc.yaml     | 71 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm6115-gpucc.h | 36 ++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm6115-gpucc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
> new file mode 100644
> index 000000000000..abf4e87359a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-gpucc.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm6115-gpucc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Graphics Clock & Reset Controller on SM6115
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description: |
> +  Qualcomm graphics clock control module provides clocks and power domains on
> +  Qualcomm SoCs.
> +
> +  See also:: include/dt-bindings/clock/qcom,sm6115-gpucc.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6115-gpucc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: GPLL0 main branch source
> +      - description: GPLL0 main div source
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'

Why this one is not referencing gcc.yaml? Looks the same as your
previous sm6375.

Best regards,
Krzysztof

