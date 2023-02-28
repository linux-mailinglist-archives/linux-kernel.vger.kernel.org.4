Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D878B6A5C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjB1PlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1PlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:41:20 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1145F222EE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:41:19 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id n2so13727542lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0oSgh79dT4BwHorcu4cOKoy0Ow/ZznwbgklRDRu1oI=;
        b=DS1vDN4ANBGoA83nXmkMioB5k5jbyFbCQwLBa21/NiGfTLei+j5AWJSkIIhKiioaD6
         /+1jav2hwaG002/lMwDMVhjm399pqGtxzaQiZS14sjA9xNfsdY7Q6r4RKRGqGR5rrZ27
         CyKV2YPmLXXvwzlUH0xebECCyvWeOsjdcyfTeKQUToVTXxMG+g2R0+PtoreW6XZWpGks
         LxOqnht0f8MXHon5V6eQoAMCDR5BF2QzDodk2HJIAudJ+w1/ccGkSOQP8u5skOElKw4G
         LmOIt8gqcS7cPVSE8ynxL7ycKQKiJRU/2bKB4zhySo/b4rUDP5WqDku/kN2xFR0yFChs
         XzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0oSgh79dT4BwHorcu4cOKoy0Ow/ZznwbgklRDRu1oI=;
        b=P75qLCmLzBKpi4lIiUabcc9LDbKUYs2XE7SyeykD3ng0QsnzjfhGjbovXv2kCJppNL
         jr0ood3TR6eYieWGW8RAT1KgkYAeZhHlkxjjX30jDDtlOzd9bGRlBTNa1oxaEzQY8j7H
         OMSM6qi9yLKDvbD2ENCYLr+PBDv9OEmHa8KXpg0Q/relbxbi5xPDyBdal4lLaQHZR5/L
         CbApNo9tZxR9NlD3mXRNhYMMJPdloSUolgqp9PJfvKBXMTR9s5YC2U62Sp0TVdz6qaQs
         HPn5V7GW2tNTUv8Ce6TIEhpbupEmuE6hqXX1pB8CH94RGdK2LU3xPuXLEYqj4p5Nd9gG
         3CYA==
X-Gm-Message-State: AO0yUKUEvz/jEb+RsLIJpohupMWbxK/5aBk6cbkl7ZCutdxhkl1dkVf6
        bSGJZxwG21u3vgvbuIRRTXW25w==
X-Google-Smtp-Source: AK7set9GsnKLQmZvi1EI42Kuf4fQXweX0TVas8vb7ohjCdBBF/7lr7xMAdrXNr2J30rocg7gCVS12g==
X-Received: by 2002:a05:6512:ea7:b0:4db:25bb:ff0b with SMTP id bi39-20020a0565120ea700b004db25bbff0bmr2954320lfb.2.1677598877358;
        Tue, 28 Feb 2023 07:41:17 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id r7-20020ac252a7000000b004dc4d26c324sm1372910lfm.143.2023.02.28.07.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:41:16 -0800 (PST)
Message-ID: <1091d8b4-3dd3-427b-2fcb-c3e0d32b0a3b@linaro.org>
Date:   Tue, 28 Feb 2023 16:41:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/18] media: venus: hfi_venus: Set
 venus_sys_idle_indicator to false on V6
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-1-58c2c88384e9@linaro.org>
 <99eeebc6-69aa-c6ba-139b-92672c299747@linaro.org>
 <893851c9-c8be-ed7f-ebde-5d90b9313f6d@linaro.org>
 <48ac4272-0e11-d943-e950-0be8d93fb036@linaro.org>
 <b7f0c568-72b7-3342-decc-784cd5f68b1a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b7f0c568-72b7-3342-decc-784cd5f68b1a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 16:38, Bryan O'Donoghue wrote:
> On 28/02/2023 15:37, Konrad Dybcio wrote:
>>
>>
>> On 28.02.2023 16:31, Bryan O'Donoghue wrote:
>>> On 28/02/2023 15:26, Bryan O'Donoghue wrote:
>>>> On 28/02/2023 15:24, Konrad Dybcio wrote:
>>>>> This call does not seem to have been cast on any kernel with support
>>>>> for VPU-1.0 or newer (and by extension, HFI6 and newer).
>>>>
>>>> We tested this on sm8250
>>>>
>>>> Restrict it
>>>>> to V4 only, as it seems to have been enabled by mistake and causes a
>>>>> hang & reboot to EDL on at least one occasion with SM6115 / AR50L
>>>>>
>>>>> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
>>>>> Signed-off-by: Konrad Dybcio<konrad.dybcio@linaro.org>
>>>>
>>>> Right. This may indeed fix it for you on SM6115, could you test it on RB5 and verify the above statement ?
>>>>
>>>> ---
>>>> bod
>>>
>>> For example.
>>>
>>> Doesn't your later patch take account of VPU h/w version ? IRIS_1, IRIS_2 etc.
>>>
>>> When we added for V6 here, we meant for current tested V6 hardware at that point - at least sm8250.
>>>
>>> Can you not differentiate sm6115 based on VPU hardware identifier ? We want to retain this logic for 8250 and then assuming your patch is correct, not do this for sm6115.
>> As far as my only source of information (msm-4.19 techpack) goes, this is
>> unnecessary/incorrect on 8250 as well. I doubt downstream would ship Venus
>> with no/broken low-power modes..
> 
> Can you test it and make sure ?
As I mentioned in the cover letter, 8250 still seems to work with this
patchset. I have no idea how one would go about validating the
functionality enabled through this call.

Konrad
> 
> ---
> bod
> 
