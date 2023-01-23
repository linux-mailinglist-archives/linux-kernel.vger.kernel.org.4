Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0D67771C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjAWJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjAWJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:11:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FBA1E5D1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:11:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so8014628wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CG19qBP1qisED+IAqQMmGMoYnI5R7guTZv3vQ7JrYgg=;
        b=KY62Yq/Jod9kD7PdpFPEQoBKCnOIQ8HCN0No5mdMa/Nx8XDcOjWbz+OldgofOdZTO9
         thcgGwrrjOisNNizvprqix7unM1N9yeLBaJ1k0IZsteOHUR+KvqwYWzbfgnWnJB3uCLB
         mlHOH2jKMSOnyq/AZKQ7g23bWUVI5sIKVVad4cecou+6X/B3tSyVyOllKWRo9BeWa2lH
         Ck7ucBhsWm4YT5p+K0bO5LhH0IbpbZOAeyOAijykOc1sWVCuKmNuMRXkJDvcKNj+atX1
         tqjIYypPUXn+rzRqoFA9oUbSDuegvVt7yXIVnw9FDDhcqw2GkglMks7uVT29n+OYGRN/
         U1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG19qBP1qisED+IAqQMmGMoYnI5R7guTZv3vQ7JrYgg=;
        b=jQ/mKLdzozCubxMLGw5n2zm3jofbOtpLdKLY/p8wcAoLkXWnK5SOmlSd7/8HWFDrFZ
         FWWKXAzGGlOc4NDQlttsrs+ER7NXBc/wE2CrpEcmZaTLZJFbnUD2MsOUMiyD472OANrC
         /aJsMO5Aj6cTGZLytLDRyVk6xpXzTHj9LtcpyU8CajZnwEs77jKWWIRwarRkDZh2IePd
         8o5UEA1waskEI4KI0Y0wW24i2XOT2Z4So4bbwguNtzO1Z9hyTbBuBLNdycR+okUFfjI3
         A/ZrK/c7+57EByUi3Ftg/KXV5N7E589B/kPp6hWT6VEQG9WNcSfoTZh6F03eVjE+CZ/x
         C+KQ==
X-Gm-Message-State: AFqh2krlbxmsU+pePYPYqhVUfxn5+P7wAWJZBb9cpmAMaTAlgz7ILMCw
        gKYPTPUMxpgmb+ufoN+5/Gsw7w==
X-Google-Smtp-Source: AMrXdXvhrbLBq5qfOpbnhzrPoA1QWjj+VqwIqC8hv2Peu4Tu/YazU8Ya88WE1sTPHwqxrjxy2z4+zA==
X-Received: by 2002:a05:600c:3083:b0:3da:e4d:e6ba with SMTP id g3-20020a05600c308300b003da0e4de6bamr22647113wmn.14.1674465092407;
        Mon, 23 Jan 2023 01:11:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003d9e74dd9b2sm10463657wmn.9.2023.01.23.01.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:11:32 -0800 (PST)
Message-ID: <5f778c47-a1a3-70f2-78b8-107a11e31eeb@linaro.org>
Date:   Mon, 23 Jan 2023 10:11:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add SM7150 GCC clocks
Content-Language: en-US
To:     Danila Tikhonov <danila@jiaxyga.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
References: <20230122192924.119636-1-danila@jiaxyga.com>
 <20230122192924.119636-2-danila@jiaxyga.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230122192924.119636-2-danila@jiaxyga.com>
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

On 22/01/2023 20:29, Danila Tikhonov wrote:
> Add device tree bindings for global clock subsystem clock
> controller for Qualcomm Technology Inc's SM7150 SoCs.
> 
> Co-developed-by: David Wronek <davidwronek@gmail.com>
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../bindings/clock/qcom,sm7150-gcc.yaml       |  69 +++++++
>  include/dt-bindings/clock/qcom,sm7150-gcc.h   | 193 ++++++++++++++++++
>  2 files changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
> new file mode 100644
> index 000000000000..a0105e11fdb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm7150-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on SM7150
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Danila Tikhonov <danila@jiaxyga.com>
> +  - David Wronek <davidwronek@gmail.com>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on SM7150
> +
> +  See also:: include/dt-bindings/clock/qcom,sm7150-gcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm7150-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Board XO Active-Only source
> +      - description: Sleep clock source
> +

If you started your work from the most recent bindings (e.g. sm8550) you
would have saved one iteration and one set of review...

> +  '#clock-cells':
> +    const: 1

Drop entire property, it's coming from gcc.yaml.


> +  '#reset-cells':
> +    const: 1

Ditto

> +
> +  '#power-domain-cells':
> +    const: 1

Ditto

> +
> +  reg:
> +    maxItems: 1

Ditto

> +
> +required:
> +  - compatible
> +  - reg

Drop reg

> +  - clocks
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'

Drop these three.

> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    clock-controller@100000 {
> +      compatible = "qcom,sm7150-gcc";
> +      reg = <0x00100000 0x001f0000>;
> +      clocks = <&rpmhcc RPMH_CXO_CLK>,
> +               <&rpmhcc RPMH_CXO_CLK_A>,
> +               <&sleep_clk>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> +
> diff --git a/include/dt-bindings/clock/qcom,sm7150-gcc.h b/include/dt-bindings/clock/qcom,sm7150-gcc.h
> new file mode 100644
> index 000000000000..3e5f8d32796d
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm7150-gcc.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Danila Tikhonov <danila@jiaxyga.com>
> + * Copyright (c) 2023, David Wronek <davidwronek@gmail.com>

You did not base your work on any existing bindings upstream or
downstream? This should include original work copyrights...

Best regards,
Krzysztof

