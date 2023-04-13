Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A106E0C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjDMLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMLMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:12:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B972BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:12:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s2so10560418wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681384341; x=1683976341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QArK/FYVA8r4jHMgxjz+s5Hgq6dOuc63XEe7lmAWZVQ=;
        b=k41bUmuuwfM1btMOKkxoehhXgXxjhJcpDNZ+tOwc0USDBlyDnQSDMbiFA2w0O+mYTA
         Skeo4ykHdzNaFkiON1NBc6Q5UbdOQQ1B+eQh06KYoaRrqqXjhGqF143wNUBvyNW1rsQ1
         9PyNa6doco5cnifjr8dZENnaXSiCcU3cpADCd17X2e2R1mU3fDbkRLFvtP0RSsvhDUaM
         h8hMInV4tCjyHEhwsPGwn6Wwi88Jm4hKdt6AaG3RbNMN9HWd2W8brTFgzpveNzH8pYxF
         SeueAnnBjaorYeJiy02fAgYcPMM0JSZoK+u/O3AYSw6IkXEDONYJmBGrIpcZqrUk5h1X
         IP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384341; x=1683976341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QArK/FYVA8r4jHMgxjz+s5Hgq6dOuc63XEe7lmAWZVQ=;
        b=eOSoE8AJsK6b+DId33OjnTSmuO1cBj0gmIS9hRp1Y7jEnH05F7/PTOoWtla2gEWYLB
         ebwZuky4s8SLCoEcr5dbm71ph59q4tm/INrN6wcRn2gcu/LcfWGvNVYiGY6uRcdNyYJy
         4RXSu3q+2m8pal4Cr915WtebBYeGxaMbhAbBsbI9QxJycDECLKm8jP7sSx8bnWi4dW0J
         DmiQQcVjd+2T2yq3ijd9OsVINa6Q66SsD2K+TwkSY74RVMoVxoWGfk2uF/+daTJMkKr9
         a0WX/HHGvBNmkaUM992//sMWIFgkBAZvO2YJIc4d5QlzPNTgE2xLZlORzvTwyborLLJg
         yMaA==
X-Gm-Message-State: AAQBX9c8YvHW1ufm5+lB61iX3hhI602aajuHlcX+5n5Q48eXs/gxQ1hL
        mHdibgp6xoZdOsn2Iay2chFYDr9HPHSBVg84K9I=
X-Google-Smtp-Source: AKy350ao9yolIef91UMqjque+KErSt6pLHDXQB1aEkBr6cmmLqvMkHUHWz42eqTmRHczBtxsHIAyLA==
X-Received: by 2002:a05:6000:1b8c:b0:2f4:d4a3:c252 with SMTP id r12-20020a0560001b8c00b002f4d4a3c252mr1304177wru.3.1681384341423;
        Thu, 13 Apr 2023 04:12:21 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id c14-20020adfe74e000000b002cefcac0c62sm1093126wrn.9.2023.04.13.04.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:12:20 -0700 (PDT)
Message-ID: <9156affd-7f08-282b-ee65-ae82f4d94cbc@linaro.org>
Date:   Thu, 13 Apr 2023 12:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/7] dt-bindings: soundwire: qcom: add 16-bit sample
 interval
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-3-krzysztof.kozlowski@linaro.org>
 <94590a79-cae3-7b88-8f02-0c356adf06b7@linaro.org>
 <7c7afc80-713f-1949-4feb-f5f2d192569c@linaro.org>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <7c7afc80-713f-1949-4feb-f5f2d192569c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 17:16, Krzysztof Kozlowski wrote:
> On 12/04/2023 17:28, Srinivas Kandagatla wrote:
>>
>>
>> On 03/04/2023 14:24, Krzysztof Kozlowski wrote:
>>> The port sample interval was always 16-bit, split into low and high
>>> bytes.  This split was unnecessary, although harmless for older devices
>>> because all of them used only lower byte (so values < 0xff).  With
>>> support for Soundwire controller on Qualcomm SM8550 and its devices,
>>> both bytes will be used, thus add a new 'qcom,ports-sinterval' property
>>> to allow 16-bit sample intervals.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    .../bindings/soundwire/qcom,soundwire.yaml    | 22 +++++++++++++++++--
>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
>>> index c283c594fb5c..883b8be9be1b 100644
>>> --- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
>>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
>>> @@ -86,7 +86,7 @@ properties:
>>>      qcom,ports-sinterval-low:
>>>        $ref: /schemas/types.yaml#/definitions/uint8-array
>>>        description:
>>> -      Sample interval low of each data port.
>>> +      Sample interval (only lowest byte) of each data port.
>>>          Out ports followed by In ports. Used for Sample Interval calculation.
>>>          Value of 0xff indicates that this option is not implemented
>>>          or applicable for the respective data port.
>>> @@ -94,6 +94,19 @@ properties:
>>>        minItems: 3
>>>        maxItems: 16
>>>    
>>> +  qcom,ports-sinterval:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>
>> Should this not be ref: /schemas/types.yaml#/definitions/uint16-array ?
> 
> Same answer as for Rob:
> 
> Because I am afraid it will grow in next version to 24 or 32 bits. I can
> change easily maximum, but if I put here uint16-array, all DTS will have
> /bytes 16/ annotation.
> 
As per MiPi Specs the sample Interval is an integer in the range 2 to 
65535. I don't see a value in making this u32, other than adding some 
confusion by deviating from specs.

--srini

> Best regards,
> Krzysztof
> 
