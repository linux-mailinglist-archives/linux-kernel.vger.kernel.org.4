Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB5772579C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbjFGI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjFGI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:28:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D64E49
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:28:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977d6aa3758so576509866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686126479; x=1688718479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udzaaw6qDHSkruTSqapZilAwmBDTeRd1WqYkzLxfxKw=;
        b=mCSLZ0SpTD8dM8IYBeH0NsSoPs/RoeEsK3Gz91De8m0o/bkR9A1JQfbDdPRCwXNkao
         j/mft2XNI0lezzVQ1Cap/N2JFPUjdDIhTTCvRIKrDzoR2ad3g8QWoD6RNPiPwm01U9p8
         wiY2wli1m7w3XwWE8qhD6lMF7711UkDsI5Cb/qGK2ngdGOMqY7y7ejLnMacZJ/13YmyE
         WbO9efLR2U4tFZxeIMadh6qY7gdLmP2+n78s6lXZeBUR7Jz95SQq77xJE5tnVSqnAuJD
         Y2ZJrNPTob5s5pGAakoVOXqp+EabmPcxfb5CjySIaRtfDqSX0TqngwuP2spaJBVNmvjw
         2lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126479; x=1688718479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udzaaw6qDHSkruTSqapZilAwmBDTeRd1WqYkzLxfxKw=;
        b=kG3yl/zOYF6CjrDRE0/VQkOHCnGNKpFyp46VdQr9ZiYr/1fCtdUdP0NEkytsCS29Uc
         Z0iNsPP6E6khpdz4RRDF5F0bb5CaUh9FmiWajQ3WTUQwtP6aj6PbaudEmombpbFn9Fr1
         Md+DlTltNfTfOqcKay92xiZgTYtD0Sw8uLlNSSW42yh2mIbQbH0Lc2+gLYMoc0g+R3E9
         BFN3Ynz9OjierVa4t8hv6Yc5Tm1XFPzNQTi1ZFczU/RMLoFMYspX+lzSRdGgDGlnIteQ
         7nONO2pqNvCZsKhrHlxamV3NV0jgcdcvIxZjzNuD0pi+C/pYtf67cpgEQ7kjM1wG4dup
         w8uQ==
X-Gm-Message-State: AC+VfDxFK5l4TjYb/7x6l+z1V24zr9S3aacDdR4zqUXo+FfoMo76O1OW
        uvx0+HOtw9zI/25vgcb2ILX3CQ==
X-Google-Smtp-Source: ACHHUZ551irlhGeCoLFUsmqhKcmyEYKhUagCEadWq9J9KXqoa5i4D87g/vHnCHUNgfj3GYF+SJNTGg==
X-Received: by 2002:a17:907:7e9c:b0:96f:bcea:df87 with SMTP id qb28-20020a1709077e9c00b0096fbceadf87mr4846126ejc.42.1686126479436;
        Wed, 07 Jun 2023 01:27:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id uz13-20020a170907118d00b009775eb0343bsm5439900ejb.79.2023.06.07.01.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:27:59 -0700 (PDT)
Message-ID: <5f9cc367-eaa5-4c19-4e5e-7052b0259ccf@linaro.org>
Date:   Wed, 7 Jun 2023 10:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
 <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
 <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
 <87edmoitu3.fsf@kernel.org>
 <0555c089-9d0d-7d19-9646-f0f9b8630d12@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0555c089-9d0d-7d19-9646-f0f9b8630d12@quicinc.com>
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

On 07/06/2023 10:10, Manikanta Mylavarapu wrote:
> 
> 
> On 6/6/2023 7:19 PM, Kalle Valo wrote:
>> Manikanta Mylavarapu <quic_mmanikan@quicinc.com> writes:
>>
>>>>>>> +
>>>>>>> +    properties:
>>>>>>> +      compatible:
>>>>>>> +        enum:
>>>>>>> +          - qcom,ipq5018-wcss-ahb-mpd
>>>>>>> +          - qcom,ipq9574-wcss-ahb-mpd
>>>>>>> +          - qcom,ipq5018-wcss-pcie-mpd
>>>>>>
>>>>>> Keep rather alphabetical order (so both 5018 together).
>>>>>>
>>>>>> I also do not understand these at all. Why adding bus type to
>>>>>> compatible? This rarely is allowed (unless it is PCIe controller within
>>>>>> soc).
>>>>>>
>>>>> IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
>>>>> external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE
>>>>> radio's properties, i have added bus type to compatible.
>>>>
>>>> It's the same device - WCSS - right? We do not create multiple nodes and
>>>> compatibles for the same devices. Bus suffixes are almost never parts of
>>>> compatibles.
>>>
>>>
>>> No it's not the same device. WCSS on inside IPQ5018 and WCSS attached
>>> via pcie to IPQ5018. Here QDSP6 managing both WCSS's.
>>>
>>> So for better clarity i will use attached SOC ID in compatible.
>>> Below are the new compatible's.
>>>
>>> - qcom,ipq5018-wcss-mpd //IPQ5018 internal radio
>>> - qcom,ipq9574-wcss-mpd	//IPQ9574 internal radio
>>> - qcom,qcn6122-wcss-mpd //IPQ5018 attached radio
>>
>> What mandates that there's just one QCN6122 device attached to PCI?
>> Assuming fixed PCI configurations like that makes me worried.
>>
> 
> IPQ5018 always has one internal radio, attached pcie radio's depends on 
> no of pcie ports. IPQ5018 has 2 pcie ports, so it supports max two 
> qcn6122 devices. One compatible (qcom,qcn6122-wcss-mpd) itself support's 
> number of pcie devices controlled by QDSP6.

So this is hot-pluggable (or at least board-pluggable), then should not
be a part of static DTS.

Some concepts of virtual-processes is anyway far away from hardware
description, thus does not fit into DTS. Adding now to the equation PCIe
with variable number of such processes, brings us even further.

This is not a DT property. Remember - DT describes hardware.

Best regards,
Krzysztof

