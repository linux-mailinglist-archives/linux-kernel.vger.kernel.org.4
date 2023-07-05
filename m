Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F120748F99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGEVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGEVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:14:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9619A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:14:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703caf344so5717501fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688591685; x=1691183685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXh1qp3VcG4x7VyPV9/wVqCpHKyRAdF4uZDV5Kq0EWU=;
        b=LGDjVr757p+L1QWlKXvJ/gAUWsdtaNcGemcGO48U8DQxQFg+HA0sACmPwdhmO6Yije
         yC9oGziCNSmcU/ONMcQ1ICN2sQKkFIg45jLS4QfTG/8NzfywfoTw/FJ/C7QUGnryOK9S
         O36ox78hhxZpsPBKKnGASV00AV/X4M36XsVwHeqGo5UbfkLRkgB5wGKs5BdB+D+4URwM
         mXpMOmat7KRkEhCMUWH36i9ZR7sSJqitAWImjG9cfhMRSIWAMxyeQoqi30aIdBhDNXN+
         syXgAPgM8BrSHauYn1cLnIcB1aVoagbk6uSPxvKi6w2R+QcopLIZT2TCX2RxbtN7OkJP
         2xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688591685; x=1691183685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXh1qp3VcG4x7VyPV9/wVqCpHKyRAdF4uZDV5Kq0EWU=;
        b=Gjh9iaQCo9kuMsk9MwCCqVuWt7GCwRF4s4mttCW83cZG3MzrW3AOYdfUO3epHsZjeR
         L77SPafkTFtnnKfzU/bNAHn1Va2uqDVf0CoKQJFtqlAsbBklmfCcLCks5qwOwiHcOBXI
         BVhRqMEpqaBD5GKbvzGkPdMvgpxdy9DgVqgwhWe4I6DAOaTtQ6F+EBmijdKk201yiJc4
         kMi6U1U6yi9flMoEc/dmY7uchyrtjmE6i/sLQsSigXjllO/K/3zL1vBgAnOlI4qdCB+V
         Vz33cxApm7wBjbs/Bmx8q52KaCpNU4Ofxey5BIWIRhJT9Qg0i3FPQ1v583vOmJz8pnOm
         bgeA==
X-Gm-Message-State: ABy/qLat8FmsCoZSyx3KSd32dCwZSv68AuiEv6z9uzmVPigjrD9eLXKq
        5VuCdcUHpg/AUconEupdLlyjpQ==
X-Google-Smtp-Source: APBJJlGCrgsEZyfPbyg9iwta9Ar+mKIE43BkXWms0nT6cArFKi8I2D+CP8m4idO2s/cRmXDRYobs1g==
X-Received: by 2002:a2e:9159:0:b0:2b6:a3b0:f4d3 with SMTP id q25-20020a2e9159000000b002b6a3b0f4d3mr14294522ljg.26.1688591684965;
        Wed, 05 Jul 2023 14:14:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9613000000b002b6d781b60esm3446940ljh.82.2023.07.05.14.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 14:14:44 -0700 (PDT)
Message-ID: <eceb14da-a839-8475-c416-bc694ecade30@linaro.org>
Date:   Thu, 6 Jul 2023 00:14:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V7 1/2] dt-bindings: firmware: bootstats: Add the dtschema
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
 <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
 <d339d413-5242-0d5a-96f6-c2f670e5e5dc@linaro.org>
 <968fb5d3-6cd8-7850-47e7-682e26f9ee5f@quicinc.com>
 <a0631800-f3d5-ff13-b316-9bc027275a82@linaro.org>
 <20230705193012.GA1642540-robh@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230705193012.GA1642540-robh@kernel.org>
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

On 05/07/2023 22:30, Rob Herring wrote:
> On Wed, Jul 05, 2023 at 11:34:35AM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2023 10:33, Souradeep Chowdhury wrote:
>>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>>> +
>>>>> +  abl-time:
>>>>> +    description: The property to store the duration of abl in ms.
>>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>>
>>>> I have no clue what this entire binding is about. Nothing can bind to
>>>> it, no usage explained. Properties are not used to "store the duration".
>>>> This does not look like suitable for DT, drop entire binding.
>>>
>>> This binding was created as per the suggestion on version 6 of the patch
>>> by Arnd. The idea was that these 2 devicetree properties will be used to
>>> populate the bootstat values from the bootloader and exposed to the user
>>> via /sys/firmware/devicetree/ directly.
>>>
>>> Details in the link below:-
>>>
>>> https://lore.kernel.org/lkml/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/T/#mbdc9ad95fcbb5ad7b56c6996a3933899b42d982c
>>>
>>> Can you suggest any alternative way to represent this as a binding?
>>
>> Then you should clearly state in the binding how this is going to be
>> used and who is going to populate it. Not only in the binding but also
>> in commit msg which currently has 0 rationale and answers to "why". Your
>> commit msg explained only "what", which is usually obvious and much less
>> important. Your commit should stand on its own and should clearly
>> explain why we need this feature at all, what problem it solves.
>>
>> And before you claim that there is some discussion under link or some
>> cover letter - these do not matter. Commit and bindings matter.
>>
>> What's more, I don't think that Arnd's advice is correct here - DT is
>> suppose to describe hardware or firmware. These properties are coming
>> from firmware but they are not describing any firmware or hardware
>> characteristics. Instead they are debugging of current boot status.
>>
>> I will leave the decision on that for Rob, however anyway binding is
>> very vague and incorrect, so I would expect he will come with the same
>> concerns regardless whether it is suitable to DT or is not.
> 
> My main concern here is not so much having this info in DT, but whether
> it's just the start of various properties. Either because there's already
> more data and these are just the 2 things you care about now, or because
> once we enable this it's an invitation to add more properties.
> 
> Boot timing information seems like something multiple platforms might
> want and only having 2 stages isn't extensible.

I preferred the previous implementation idea, where the Linux driver 
will parse firmware data, instead of bootloader doing something for us.

Not to mention that that approach would allow us to get boot time stats 
on older platforms, without waiting (indefinitely) for the platform 
vendor to update the bootloader.

> 
> Rob

-- 
With best wishes
Dmitry

