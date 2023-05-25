Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4992C7108B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbjEYJVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjEYJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:21:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CCC19C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:21:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-309438004a6so1213783f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685006497; x=1687598497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Zm/p2k/RehOfZBljDwc/bYZKGcOcF2/sVmCcVGUSgc=;
        b=h/WfuPez2QrX3mfUg4JCwKeOj2YjWD8wYM2Ie82UqDSiqAkNZfJBMYmBbQDdyHR2Cm
         UiXjRaSPu3slN288hugGIaOKrLB7Ir31pufgu9IPTY9Mxuwt2WLPZ/RZxpqIAmI8Prfl
         D/AcSaWSHjj/urr4wn16iczX0d1SNsBBILDaGxMXwsYYbb/raR7djRFAdCCYnC/Ocfmh
         zz02DsargQN9DqEeUk7RDxtyCx8bZJ9En6hwrmHSF3HW4MoJErK8rAVP/2QpgZaVvKla
         ATBbWfn1UgrKBDOJvJJI85NQbsQAkBh+P9fiuaMM+KgBzcad3oOpODO0gr7UBm9a5PkX
         8IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006497; x=1687598497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zm/p2k/RehOfZBljDwc/bYZKGcOcF2/sVmCcVGUSgc=;
        b=RMp7tiCOsuh6L4r9oOiZnhBufGniINPZACKNBc23RMHlyLnjqHOFJEtXgFZJkGPH4T
         wRpieZiiH/a6uKaeFmdbE8X24esntDdSoHOY288Jfq6Kjl+rIwNy04u95pLl7vUtCih3
         SSVg7QgPAry4zsa+9pcbCoYo7uhdBf0ylM1PDQEbpQud3zKCjg5akB7qpi/jk3uF3IOW
         AqyN2fC4ph9tOY0horQsvWgkuoh2b2OnA18gAXGq/kNI8UQKNbxVcKCd83RbfRd1uczC
         DlMX0zHznNxlmIuzDQe4/YZ1Nn5GM41XEgph+85mOml8JzmCX1i46lI+RalX3AXyCQc7
         BBng==
X-Gm-Message-State: AC+VfDzWCGHkedtU3zewYK+8tOp89QNmmel4uBK5c/ta1BSr7qqf918h
        mxzowvO3VGpZe64/6xX4tNMlCQ==
X-Google-Smtp-Source: ACHHUZ46dCc6t483kZe7a5eqGwSuR+0q2RWeVmzINPLITJx84wP7C+7JeIn1F7zdWCNRGS2rp27aiA==
X-Received: by 2002:adf:e9cf:0:b0:304:6762:2490 with SMTP id l15-20020adfe9cf000000b0030467622490mr1948466wrn.3.1685006496902;
        Thu, 25 May 2023 02:21:36 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b4-20020a5d5504000000b003062b6a522bsm1088916wrv.96.2023.05.25.02.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 02:21:36 -0700 (PDT)
Message-ID: <dee69294-e743-e249-3075-e83f5c668c88@linaro.org>
Date:   Thu, 25 May 2023 10:21:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add YAML schemas for LPASSCC and
 reset on SC8280XP
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
 <20230518113800.339158-2-srinivas.kandagatla@linaro.org>
 <ZGsmCmEdoWIkcVDd@hovoldconsulting.com>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZGsmCmEdoWIkcVDd@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

thanks Johan for review,

On 22/05/2023 09:21, Johan Hovold wrote:
> On Thu, May 18, 2023 at 12:37:56PM +0100, Srinivas Kandagatla wrote:
>> The LPASS(Low Power Audio Subsystem) clock provider provides reset
> 
> Missing space after LPASS acronym.
> 
> s/provider/controller/?
> 
>> controller support when is driven by the Q6DSP.
> 
> s/controller//?
> 
> "when is driven by": sounds like there are some words missing here.
> 
>> This patch adds support for those resets and adds IDs for clients
> 
> There is never any need to say "this patch" in a commit message. Just say
> 
> 	Add support for...
> 
>> to request the reset.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/clock/qcom,sc8280xp-lpasscc.yaml | 57 +++++++++++++++++++
>>   .../dt-bindings/clock/qcom,lpasscc-sc8280xp.h | 12 ++++
>>   2 files changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
>> new file mode 100644
>> index 000000000000..7c30614a0af9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,sc8280xp-lpasscc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm LPASS Core & Audio Clock Controller on SC8280XP
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
>> +  Qualcomm LPASS core and audio clock control module provides the clocks,
>> +  reset and power domains on SC8280XP.
> 
> "power domains"? copy-paste error?
> 
>> +
>> +  See also::
>> +    include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
>> +
>> +properties:
>> +  reg: true
>> +
>> +  compatible:
>> +    enum:
>> +      - qcom,sc8280xp-lpasscc
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
> 
> Move above #reset-cells for some sorting of related attributes. Same
> below (in two places).
> 
>> +
>> +  qcom,adsp-pil-mode:
>> +    description:
>> +      Indicates if the LPASS would be brought out of reset using
>> +      peripheral loader.
>> +    type: boolean
> 
> Move above the provider cells properties?
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - qcom,adsp-pil-mode
> 
> If this boolean property is always needed, shouldn't that simply be
> handled by the driver based on the compatible?

Traditionally in Qcom SoCs LPASS is under the control of ADSP, there 
have been some other variants specially chrome platforms that have moved 
this control to APPs processor.

Having this property at Device tree level provides more flexibility, 
given that both the cases use same compatible strings.


Am okay with reset of the comments, Will fix them in v2.
thanks,
Srini

> 
>> +  - '#reset-cells'
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
>> +    lpasscc: clock-controller@3900000 {
>> +      compatible = "qcom,sc8280xp-lpasscc";
> 
> binding examples use 4-space indentation.
> 
>> +      reg = <0x033e0000 0x12000>;
> 
> Does not match the node unit address.
> 
>> +      #reset-cells = <1>;
>> +      #clock-cells = <1>;
>> +      qcom,adsp-pil-mode;
>> +    };
>> +...
>> diff --git a/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
>> new file mode 100644
>> index 000000000000..df800ea2741c
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,lpasscc-sc8280xp.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) 2023, Linaro Ltd.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
>> +#define _DT_BINDINGS_CLK_QCOM_LPASSCC_SC8280XP_H
>> +
>> +/* LPASS TCSR */
>> +#define LPASS_AUDIO_SWR_TX_CGCR				0
>> +
>> +#endif
