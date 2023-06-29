Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B35742296
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjF2ItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjF2IsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:48:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727FA44BD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:45:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso667147e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688028326; x=1690620326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9c/Sgnntrd4PLPE97fe1hO07h+vpbHzWVDhlUf4NLE=;
        b=o6Bt7kUqI6c73rmx2IZbT+oK/jw8EAUelXUlO2gDsHwXvf3MjL8oFp/n6JFHZwzoqK
         BLsDSI2zlFrU8fPPM/51ElJTnXqnPcjjc9A4mLveHt2EMunBe6OLmZBYXQ9pA4x693a1
         Lk1p5pIhKP0EzqiYbD3H05AuDt4thQpGRLJWU74lm3W1IJCHeawEUD99NrSgpYadEQnR
         DlKilvUXNiZUkO4uP4em1uAl3sXDwQddNr9VkQy+/7o6rnHmYOBC4nTqbfeOCHqoYsLn
         IXjKWDSSU8CI2lWcsqsusVusZm/BQVmM0yVf6Od/n49P0/KXFoZjnqrpNeTs7M9i6+gd
         HtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688028326; x=1690620326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9c/Sgnntrd4PLPE97fe1hO07h+vpbHzWVDhlUf4NLE=;
        b=jU4mfmXPrPgL2OR/xdCfXKye57owArdqcwGu96iu7wa4/WgfEHNWhOGZ56/n7Pd+tN
         V7THhux6dqDLux/6t1bqLGADZUPFCQN/SFj6eo0EQUNIGvFxYYGjBgDbMB2N5EEhXjqJ
         CBH0sYf2kGYma+MGVHEr7xeHpRsLdz1JMTVXrHsy7s1hIf9j6jykoPf5h9CDbeeaDKIC
         XHt/YbnYpXNiC36zZXHQHV5nV9gY5wp4HG5KofwhsRIzEw1NHxpHvqlhsewaeUoiGjuq
         6R69yqTXmAqHBY6BodIY9L2xP/puA5560HLtxJYroq7TOVxQ0E0TOQVugLwPgjl1A6CG
         X1jg==
X-Gm-Message-State: ABy/qLYB2pgqsC7ZsZWbjmepN3hNyJm16/xN4PUAs2jMb2JoDfWGrXjL
        p0tyhajUBWzkPoudKiDo2rdOTA==
X-Google-Smtp-Source: APBJJlH8LQwEMkOFJdbdn8IrGr/8WOtmsjrUEho66Yg7p5fPZKa4NzYigSxuH+FneC10rjP/rXqLgA==
X-Received: by 2002:a05:6512:2310:b0:4fb:9a1e:1262 with SMTP id o16-20020a056512231000b004fb9a1e1262mr1202033lfu.65.1688028326533;
        Thu, 29 Jun 2023 01:45:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512024700b004f85d80ca64sm2233550lfo.221.2023.06.29.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 01:45:26 -0700 (PDT)
Message-ID: <f274247c-f45b-8a48-92f2-cff4597aff15@linaro.org>
Date:   Thu, 29 Jun 2023 11:45:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-GB
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2023 04:19, Anjelique Melendez wrote:
> 
> 
> On 6/26/2023 6:58 AM, Rob Herring wrote:
>> On Wed, Jun 21, 2023 at 11:59:45AM -0700, Anjelique Melendez wrote:
>>> Add binding for the Qualcomm Programmable Boot Sequencer device.
>>>
>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> ---
>>>   .../bindings/soc/qcom/qcom-pbs.yaml           | 41 +++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>>> new file mode 100644
>>> index 000000000000..0a89c334f95c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
>>> @@ -0,0 +1,41 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/qcom/qcom-pbs.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Technologies, Inc. PBS
>>> +
>>> +maintainers:
>>> +  - Anjelique Melendez <quic_amelende@quicinc.com>
>>> +
>>> +description: |
>>> +  Qualcomm PBS (programmable boot sequencer) supports triggering sequences
>>> +  for clients upon request.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,pbs
>>> +
>>> +  reg:
>>> +    description: |
>>> +      Base address of the PBS peripheral.
>>> +    maxItems: 1
>>> +
>>> +required:
>>> + - compatible
>>> + - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    pmic {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      qcom,pbs@7400 {
>>> +        compatible = "qcom,pbs";
>>> +        reg = <0x7400>;
>>> +      };
>>
>> Why do you need a child node for this? Is there more than 1 instance in
>> a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.
>>
> 
> We currently have another downstream driver (which is planned to get upstreamed)
> which also needs a handle to a pbs device in order to properly trigger events.

Does it have to be a separate driver? Or is it a part of the LPG driver, 
just being artificially split away?

> 
>> Rob
> 
> 
> 

-- 
With best wishes
Dmitry

