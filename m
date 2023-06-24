Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D39273CA42
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjFXJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjFXJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:38:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ABE1BF8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:38:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso1569778a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687599499; x=1690191499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXBFCivXYU4jqrNenN0qqCdwRcocFvfR8QjuhlC/BNA=;
        b=R68zl3EL0G2cCxmLykHsoLVBaFLnVsVmuPYJGvZiSFCkHgoVSkrCVf+n9i4Q0yOWDg
         +s3so7MPt6yCrcnH39+6/mDLpjDbQlfumyCDRYM5HqCSpU9oTSBp+QQf2zvVy7sT5rAD
         2ykkyJqbMz5FGn0oRZxWJqtn5SDEWmV05NL2H7P+GTJcYpMBAe2nmTcWDWq0phXF2Vy1
         V35CVaORp5+zHfJsaY6+dDEXzyY8zC53AGNPotbheHGgrCeaEZc/QW00F8XsLkmTsR8o
         D8y22pr6oO09jUpK6NSkr1fXkD/x7wTyaXTr+xcvIe5OsPJ8dmTwsBZ1tW8HKDYaQt/u
         cq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687599499; x=1690191499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXBFCivXYU4jqrNenN0qqCdwRcocFvfR8QjuhlC/BNA=;
        b=WZ+F3PWIRWJlLoYXYR5z2iFkXWla4cWhR4qUAZBazf7iU3EB1USx2aOIw76utxPfEH
         Csn9/Up9Q/s9e+4Nm7NiXdLk1yZ6slzuJxbnleGTAdOYcN8v7SRud+Mrek36nOSI/DzW
         4q8RnG3+gL0Tu2Ml7BYYwb4nRmTg5orl6g4Ub9T+c0dvIjnZXW6SYGKhSaHxAjYC3Z2T
         Ea6GblCtgeI0oVEhY7OxxbUWIXwBLbUA0djPd+DQVGPRuNc8sr+3bYl899qiFJWXl3li
         y52hY13Os1jzt3Wm0X+jZ/LYQr+tX/dncpHvboE1LoLR313j0oJansxokPZ2dQp5Srjc
         Kn8A==
X-Gm-Message-State: AC+VfDxJAIKVxblaj7qSdXgS5t8zyeSDGUDgKYE3sACLcaZ8a2BSCqpq
        VhjffBvKeATaZeTpmvPLBHD/mQ==
X-Google-Smtp-Source: ACHHUZ7PVLABuL30C6bX/NntvPW8rghUXjMj6NCmfnVnVEa70oQE8lUdlRmnW05GgXT5nQ/s5wXJbw==
X-Received: by 2002:aa7:c14a:0:b0:51b:deaf:a489 with SMTP id r10-20020aa7c14a000000b0051bdeafa489mr5936677edp.12.1687599499110;
        Sat, 24 Jun 2023 02:38:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v9-20020aa7cd49000000b005187a42b44fsm474958edw.58.2023.06.24.02.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:38:18 -0700 (PDT)
Message-ID: <e61aa4a6-ca7d-3e33-1971-92b97f8d876e@linaro.org>
Date:   Sat, 24 Jun 2023 11:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621185949.2068-2-quic_amelende@quicinc.com>
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

On 21/06/2023 20:59, Anjelique Melendez wrote:
> Add binding for the Qualcomm Programmable Boot Sequencer device.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  .../bindings/soc/qcom/qcom-pbs.yaml           | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml

Except missing testing... few more comments:


> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
> new file mode 100644
> index 000000000000..0a89c334f95c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml

Filename matching compatibles, so qcom,pbs

> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom-pbs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. PBS

Qualcomm PBS foo bar a bit more than just one word.

E.g. expand PBS acronym

> +
> +maintainers:
> +  - Anjelique Melendez <quic_amelende@quicinc.com>
> +
> +description: |
> +  Qualcomm PBS (programmable boot sequencer) supports triggering sequences
> +  for clients upon request.

I don't understand what's this. What is "triggering sequences"? What
sequences?

> +
> +properties:
> +  compatible:
> +    const: qcom,pbs

Missing SoC specific comaptibles.


> +
> +  reg:
> +    description: |
> +      Base address of the PBS peripheral.

Drop description, it's obvious.

> +    maxItems: 1
> +

Binding looks very incomplete...

> +required:
> + - compatible
> + - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,pbs@7400 {

That's not a proper node name. Do you see anywhere such node? Please, do
not work on downstream code, but on mainline.

> +        compatible = "qcom,pbs";
> +        reg = <0x7400>;
> +      };
> +    };

Best regards,
Krzysztof

