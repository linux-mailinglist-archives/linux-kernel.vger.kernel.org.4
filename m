Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5116727ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjFHLd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjFHLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:33:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18307270B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:33:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-97668583210so79241866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686224003; x=1688816003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqHeY5G7mIeiooI7ja9w9njq/KqOX5B4nHAoGGVWiBk=;
        b=y3dQmK7aPMR+m7bDoIYNkOxdVSh4YHDPLQ6ZD/TklPbRUFXC3ugRN4H47WJzBWQZin
         VI+qaEpaNDYf9R21IHg6Drqcqq5TklxpZNFXf1rjDa0IlFVoNFH01SdPDuJCFAH4y4bi
         brbYQybxma6THxKe8VbzdNkqPhu+dv9X22rbK5cCu5lHu/eF3yMswWIA8rSfPPMzdlFO
         2nqO0pfeCqUOFWsZxc2u7NxxDsI+5AgfTJ2j7GZIElSyKC+CWg4U0iMIEUJQodualwNG
         l7rwotR3e2nWo2eFVeX+IZGEON8e5cppPZCgNdlDpYUXg45qqrlq/R6NzPNmR2UY++yc
         4YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686224003; x=1688816003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqHeY5G7mIeiooI7ja9w9njq/KqOX5B4nHAoGGVWiBk=;
        b=MtRIuR2Ef4R9XHTTPHqZfsl+Mw8mvUk3iykIoqjubCzC/LwQd/IcIBrO/6uF2BvZJ8
         hNbNw1AkD4uiIm81q1qX99qKIZJjdT+5RhcgE5e2zyDqXqBi8T8CmuTSus0Sgg0fIMew
         c5kjd0QHNVzVVXDeR36ZFzGo/Luz1aE3NeKWVRGO4An5GoPwCpC2Ps1eNmX0BX4qSV2g
         ZPnSrlwkYgcWc94cKsxfzCNO8a8LlHbYMxkWFhgW/lKXMcCgY1veOGUgGBd1TIfLyV+Y
         b62zLOGzIJSOh+5Q3sKbDdu1A1y+wUw0PVq3Ni5folUYs6ABI7kmiqfwcgNg74fQODek
         W5RQ==
X-Gm-Message-State: AC+VfDwbTkQ9hdGwEpMxHW5dn5vRbhtgJfupM9VZh3445WTCOJ0Hg46/
        VgA0gNAH84vnyf+LksmaAdfFaQ==
X-Google-Smtp-Source: ACHHUZ6aQyz91+hCmVLZTEti1T1pr0dOoizk+qwE1qd041u3uncqQAvrfQ/LD78OhEvNKifas2zDxA==
X-Received: by 2002:a17:907:3f13:b0:96a:19d8:f082 with SMTP id hq19-20020a1709073f1300b0096a19d8f082mr11607970ejc.25.1686224003570;
        Thu, 08 Jun 2023 04:33:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906b30f00b0096f67b55b0csm585508ejz.115.2023.06.08.04.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 04:33:23 -0700 (PDT)
Message-ID: <093c23a6-1c0f-6e86-3abb-a8267ebeed52@linaro.org>
Date:   Thu, 8 Jun 2023 13:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH v1 1/2] dt-bindings: misc: fastrpc: add fastrpc
 group IDs property
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-2-git-send-email-quic_ekangupt@quicinc.com>
 <44267461-e6f9-b549-a8eb-cba76384660b@linaro.org>
 <ced52be4-d5eb-2dcb-ce8a-f737fbcab1b6@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ced52be4-d5eb-2dcb-ce8a-f737fbcab1b6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 08/06/2023 12:36, Ekansh Gupta wrote:
> 
> 
> On 6/8/2023 12:14 AM, Krzysztof Kozlowski wrote:
>> On 07/06/2023 18:30, Ekansh Gupta wrote:
>>> Add "qcom,fastrpc-gids" property to the list of optional properties.
>>> This property contains the list of privileged group IDs which is
>>> used to offload process to remote subsystem with increased privileges.
>>
>> Why or when anyone would use this property?
>>
> This property can be used for the use cases which requires prioritized 
> access to remote subsystem resources.

This does not help me much yet.... Which systems or boards need
prioritized access?

>>>
>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>>> index 1ab9588..2a2124f 100644
>>> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>>> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>>> @@ -57,6 +57,11 @@ properties:
>>>         Virtual machine IDs for remote processor.
>>>       $ref: "/schemas/types.yaml#/definitions/uint32-array"
>>>   
>>> +  qcom,fastrpc-gids:
>>> +    description:
>>> +      Group IDs for fastrpc.
>>
>> You just pasted here property name. It does not help me to understand
>> what's this. Explain in description.
>>
> I'll add more details here when I re-submit the patch.
>>> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
>>
>> Drop quotes.
>>
>> missing min/maxItems.
>>
> I'll update this in v2. Thanks for reviewing.
>>> +
>>>     "#address-cells":
>>>       const: 1
>>>   
>>> @@ -120,6 +125,7 @@ examples:
>>>               qcom,glink-channels = "fastrpcglink-apps-dsp";
>>>               label = "sdsp";
>>>               qcom,non-secure-domain;
>>> +            qcom,fastrpc-gids = <2908>
>>
>> Eh, what does 2908 stands for? Why not 3012 or 1842? How anyone can
>> figure this out?
>>
> There is no hard restriction for this value to be 2908, it can be 
> anything. Just that the process which needs a privileged offload to any 
> remote subsystem should have the same gid which is defined here, whether 
> it is 2908 or anything else.
> 
> The intention of having 2908 in example is because this is used in 
> Android world where any process running with 2908 gid can offload as 
> privileged process to remote subsystem.
> Ref: 
> https://review.lineageos.org/c/LineageOS/android_device_motorola_sm7250-common/+/305612/4/config.fs
> 
> But, it can be set to anything just that the process also needs to adapt 
> to this gid.

So this is process ID? Group ID? GID? Why would you ever encode group
IDs, which change in every installation, or process IDs, which change
every boot, in DTS common for all devices?

This is not a DT property.

Best regards,
Krzysztof

