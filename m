Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA16F6F6EC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjEDPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjEDPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:16:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C941988
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:16:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f6c285d92so107589366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683213363; x=1685805363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+YrgzgoPKytJxQg/9aWnDzI+B7K2mIhuVq013nUpWU=;
        b=E7BE/gBtv4WgcDrRzQsAoLqMpAZ98Ge5Um79Csth4J3G5mvi2Jw1ZP0xq7c4Rfws0r
         57ZHgKB4KyisECxk6NPYpZ+pJlaQS62Jm7mvtbV6BtS7y4E+hVtaUDe4i5hMLL+WjVqw
         ocRXaRyfFAABWrJZO/P9o5oVRDfmxclBFNEy2G5+jZlHMdnLPP+SpGrsPFsGYKOkvSLa
         4WSEjctHqsczIY9gNN2PoRQxQIPaDltsp9mbYezbHI/ua42J8gi7dGYc3AAEckQ548VK
         kvxHdRe3MBzRUVr6q1w08SDbf6d254J7Im9DnuhEQzAfJy/hi0SniJcHLf8mrNJdablu
         H9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683213363; x=1685805363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+YrgzgoPKytJxQg/9aWnDzI+B7K2mIhuVq013nUpWU=;
        b=M2t7+cebth7WRPjDSraNW8FOfTUMWmEuGiB2Mtes9IahDkrS+WBUAg7nL4lr/uLSzV
         O00o/8LNGfu/Qwbu939VDJXB1KfCr+pNdd1o5dPMSjc7hckzkbtP/vIGGCA2tJFzEQT2
         aOh9k1g6nQpWZp9Oac1yiJzFhvUOwfxNrcywMAxsLJ9jp3nHN/d5BXHHcbnONd9OxnH+
         irPy03CleJmMTSczIv+wYzuz+ycn3z7hoemdeLtHF5LmbTdW+rFTtxt4H/0vTF/FDyFR
         KXzf02CB1DoeD9jNgihhpFPGHi2AhcfxHYGsy0TElEmWAk1qHIKrE1IQugDb0hpczg6o
         UfaQ==
X-Gm-Message-State: AC+VfDyIKvBANm+2m1eUdeLuiXAvL3bSC84x+tnbGughzFKqpOhVRHW6
        0731g1mv1kRqzJCXrDRrp/UHMg==
X-Google-Smtp-Source: ACHHUZ6snrat2F+BKDls0HrQaUaCQg8gmYaY6QGB8NtBsm1kSQSuiQaQkBo7Y+hSpHEZKau5uGmG+Q==
X-Received: by 2002:a17:907:97c3:b0:94a:474a:4dd7 with SMTP id js3-20020a17090797c300b0094a474a4dd7mr7177702ejc.60.1683213363181;
        Thu, 04 May 2023 08:16:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090639c600b0094b5ce9d43dsm18959477eje.85.2023.05.04.08.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:16:02 -0700 (PDT)
Message-ID: <caea3ae8-7cce-7c08-e524-93685c00a3c4@linaro.org>
Date:   Thu, 4 May 2023 17:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 02/18] remoteproc: qcom: Move minidump specific data to
 qcom_minidump.h
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-3-git-send-email-quic_mojha@quicinc.com>
 <fe94ed5c-c444-436d-720a-c96538c1026d@linaro.org>
 <e69862cc-4185-a7a2-07b2-15e331c4678a@quicinc.com>
 <659a9637-f82c-054b-99a8-dc25416c8e13@linaro.org>
 <33ea7c3b-4317-5aff-5e6a-af6e093d45a0@quicinc.com>
 <1a4f4b55-6284-6149-4c7b-7b45fa1de291@linaro.org>
 <d80868bf-610d-7e79-d279-da704efb38f0@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d80868bf-610d-7e79-d279-da704efb38f0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 14:57, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 6:06 PM, Krzysztof Kozlowski wrote:
>> On 04/05/2023 14:26, Mukesh Ojha wrote:
>>>
>>>
>>> On 5/4/2023 5:33 PM, Krzysztof Kozlowski wrote:
>>>> On 04/05/2023 13:58, Mukesh Ojha wrote:
>>>>>
>>>>>
>>>>> On 5/4/2023 5:08 PM, Krzysztof Kozlowski wrote:
>>>>>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>>>>>> Move minidump specific data types and macros to a separate internal
>>>>>>> header(qcom_minidump.h) so that it can be shared among different
>>>>>>> Qualcomm drivers.
>>>>>>
>>>>>> No, this is not internal header. You moved it to global header.
>>>>>>
>>>>>> There is no reason driver internals should be exposed to other unrelated
>>>>>> subsystems.
>>>>>>
>>>>>>>
>>>>>>> There is no change in functional behavior after this.
>>>>>>
>>>>>> It is. You made all these internal symbols available to others.
>>>>>>
>>>>>>>
>>>>>>
>>>>>> This comes without justification why other drivers needs to access
>>>>>> private and internal data. It does not look correct design. NAK.
>>>>>
>>>>> Thanks for catching outdated commit text, will fix the commit with
>>>>> more descriptive reasoning.
>>>>>
>>>>> It has to be global so that co-processor minidump and apss minidump can
>>>>> share data structure and they are lying in different directory.
>>>>>
>>>>
>>>> Then you should not share all the internals of memory layout but only
>>>> few pieces necessary to talk with minidump driver. The minidump driver
>>>> should organize everything how it wants.
>>>
>>> These are core data structure which is shared with boot firmware and the
>>> one's are moved here all are required by minidump driver .
>>
>> I am not sure if I understand correctly. If they are all required by
>> minidump driver, then this must not be in include, but stay with
>> minidump. Remoteproc then should not touch it.
>>
>> I don't understand why internals of minidump should be important for
>> remoteproc. If they are, means you broken encapsulation.
>>
>>>
>>> If you follow here[1], i raised by concern to make this particular one's
>>> as private and later to avoid confusion went with single header.
>>> But if others agree, I will keep the one that get shared with minidump
>>> as separate one or if relative path of headers are allowed that can make
>>> it private between these drivers(which i don't think, will be allowed or
>>> recommended).
>>
>> Let's be specific: why MD_REGION_VALID must be available for remoteproc
>> or any other driver after introducing qcom minidump driver?
> 
> Forget about this driver for a moment.
> 
> I am not sure  how much you know about existing qcom_minidump()
> implementation and why is it there in first place in remoteproc
> code in driver/remoteproc/qcom_common.c
> 
> The idea is, remoteproc co-processor like adsp/cdsp etc. may have their
> static predefined region (segments) to be collected on their crash which 
> is what exactly existing qcom_minidump() is doing.
> 
> Now, after this minidump series, APSS (linux) will have it's
> own of collecting linux client region independent of whether
> remoteproc minidump collection.
> 
> I think, are you hinting to move all minidump related code from 
> remoteproc to qcom_minidump driver, is this what are you trying
> to say ?

Close, not all but the ones not necessary to identify the
regions/storage/layout. If some variable about this
region/storage/layout is the same everywhere, it means it's basically a
property of qcom minidump and you have just exposed it to consumers
breaking encapsulation.

Best regards,
Krzysztof

