Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9462D7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiKQK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiKQK1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:27:31 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1080C532F0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:27:29 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h12so2102710ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kynY50ckiw0RzKQXKaPoaoAm91QSwXd4fLVfpMm4e0=;
        b=qei0nzvmfzHhFzvLpeh2XvFtLPoO3C6JaIH7olZAhujhgIhGDAtQWExPnqO4l6iQnt
         qJvZs+Rzv/EGieAd6m29GfntY34jMeKImzZJzvqyAKxdW1FAJauhGOtkXAYU2RxZDmYe
         ksukKt07+zeDvu/GEDBAakV6MOqm34dInbD79VFlPWxIvZKD2HJejvrAjZEKTgHbKie5
         kkjZapVNwX3dlIhHtgQ1VPNHDKb+QczHNW6ip9E4yPPC+8hDvnXKKf9KUovZkUksvB6/
         GpKoX5Zu6ADrNfHw8Zioi4h+SspRvNYSXXHN+HKErwPtM6Ga5WSf6i9v02UQ5YpuGF2y
         OXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kynY50ckiw0RzKQXKaPoaoAm91QSwXd4fLVfpMm4e0=;
        b=iE7OJwNH3ckp+nclhmJ4mmV1UFxeCiOq20tA6Z3WsEQthmiArXvGnd+GPZzxzNiJ3B
         Ja2SJdOpRqDsN36ELT+PS5wDEDxQbPWbjfEwV+ddI4FPszHS77AqzLMcP2XLZSHumuhd
         jfzp6YhqQOuUj6h4prZeEfbX/RvaWwNIL9LIrD1//ts6PGqm0fstVWkv/gIBOuVmaMyr
         iZbQM4P25VuqyjzoaDy9WGl+VL2f+WWHeYGUWH2a7xtfzTzaxiCKAXQEVcW1e6lB2njT
         xf/oxSZLcIG2NCDMkPIUuq0OBZMRiDEPbPdXJ4psxcIZp3BUkoMTbQdv4BFOUQekcEjw
         ZVgg==
X-Gm-Message-State: ANoB5pku0CtifkN+jAzg0Pnj4SE6GMxYl3/wRUsAU0q6XiLuIAvd9EFl
        Yprj2LNJhSwy6N+jfuhJX9IJfg==
X-Google-Smtp-Source: AA0mqf40gp0JWS9vrbYpcdERZdh+kArkyDdZuUk9mw4xv2UGpAVsutP2+H25Kj2gJE925TQqyDK/vw==
X-Received: by 2002:a2e:9f47:0:b0:277:1273:f3b8 with SMTP id v7-20020a2e9f47000000b002771273f3b8mr720385ljk.178.1668680847373;
        Thu, 17 Nov 2022 02:27:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h1-20020a19ca41000000b0049476667228sm84417lfj.65.2022.11.17.02.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 02:27:26 -0800 (PST)
Message-ID: <a51164de-eb2b-497c-8f07-a5cd734e293d@linaro.org>
Date:   Thu, 17 Nov 2022 11:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/9] dt-bindings: clock: Add SM8550 GCC clock bindings
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-2-abel.vesa@linaro.org>
 <c298fd71-22e9-98c5-14c6-88b078687b3d@linaro.org>
 <Y3YBpXIjDELtit0k@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3YBpXIjDELtit0k@linaro.org>
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

On 17/11/2022 10:40, Abel Vesa wrote:
> On 22-11-17 10:08:05, Krzysztof Kozlowski wrote:
>> On 16/11/2022 11:47, Abel Vesa wrote:
>>> Add device tree bindings for global clock controller on SM8550 SoCs.
>>
>> Subject: drop second, redundant "bindings".
> 
> Sure thing, will drop.
> 
>>
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>  .../bindings/clock/qcom,gcc-sm8550.yaml       |  88 +++++++
>>>  include/dt-bindings/clock/qcom,gcc-sm8550.h   | 231 ++++++++++++++++++
>>>  2 files changed, 319 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
>>>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8550.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
>>> new file mode 100644
>>> index 000000000000..a2468167c8ab
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
>>> @@ -0,0 +1,88 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/qcom,gcc-sm8550.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Global Clock & Reset Controller Binding for SM8550
>>
>> You need to base on recent bindings. See commit ece3c3198182a1.
>>
> 
> Yep, will do.
> 
>>> +
>>> +maintainers:
>>> +  - Bjorn Andersson <andersson@kernel.org>
>>> +
>>> +description: |
>>> +  Qualcomm global clock control module which supports the clocks, resets and
>>> +  power domains on SM8550
>>
>> Ditto
>>
>>> +
>>> +  See also:
>>> +  - dt-bindings/clock/qcom,gcc-sm8550.h
>>
>> Ditto
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,sm8550-gcc
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: Board XO source
>>> +      - description: Sleep clock source
>>> +      - description: PCIE 0 Pipe clock source (Optional clock)
>>
>> Drop "(Optional clock)"
> 
> Sure, will drop. I based this on SM8450, but maybe that also needs an
> update.
> 
>>
>>> +      - description: PCIE 1 Pipe clock source (Optional clock)
>>> +      - description: PCIE 1 Phy Auxiliary clock source (Optional clock)
>>> +      - description: UFS Phy Rx symbol 0 clock source (Optional clock)
>>> +      - description: UFS Phy Rx symbol 1 clock source (Optional clock)
>>> +      - description: UFS Phy Tx symbol 0 clock source (Optional clock)
>>> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
>>> +    minItems: 2
>>
>> This does not look correct. Why clocks of GCC are inputs clocks to GCC?
> 
> Well, it is not a GCC clock. It is a fixed-clock fed into GCC.
> The name is taken from downstream, but I'm pretty sure the HW clock is
> named so. So I think we should keep it as is.

I don't get it. The "PCIE 0 Pipe clock source" is defined here in this
header:
+#define GCC_PCIE_0_PIPE_CLK_SRC	41
so what do you mean it is not GCC clock?

Second thing, you have only one GCC, so how these clocks can be
optional? Either they are there or they are not. Optional means usually
that you have two devices having same compatible and they can operate a
bit differently or some pins are not connected. It's not the case here.

Best regards,
Krzysztof

