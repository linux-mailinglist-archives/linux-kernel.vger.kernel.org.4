Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E38B6FC037
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjEIHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjEIHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:11:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4518B7AAE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:11:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so10291567a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683616295; x=1686208295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APH4uf0HQ8cOpTtx4oEH1mlDXvsjwJke9jk7vwtuN80=;
        b=e7j6qkllm/T/2M2c1EkqE/Qd/638PextIBR0EfhntkXwIPUhY6InG0cTEP19Pl6rJX
         tzpjvB4ljG1Wpv06IP8v0iJEsTwM4pF4IdAbZvRdo2cjs5Wv4t8ffGIy4i89YSSwoyZY
         QIWbShgowuM5OzwGJdJ1FxIYWJO8yENJsZnyGyyMcDCnf5X/AfB0a4iDpCyXAzK5kv83
         YhQ2A8UNHBgzd9cPjbCi7+0ZFJkOowMKZg7uOa2zCrr9/kDcXodhAZYIk727px/1eZA4
         D+/Wf5n6mnlx2gWnDoJQyYp8xv+TH0psqoE9I70jPYNednkYtru0ZwjFHM60MdO5DDQg
         WJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683616295; x=1686208295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APH4uf0HQ8cOpTtx4oEH1mlDXvsjwJke9jk7vwtuN80=;
        b=IsohLI+ImRTFgekyJFH3yVoKGpKIvVBRbOwjFEhN5K9YjKaRQZTFHfODr5i/QPnhF4
         CthGcCMOsGzEZTW1ZwbPKXC1yymwSKhS9c4SsIAKuyRal0mfSX2Nh3+KspA8c/1neMht
         2xlmYOMSC5vcQkcZBXnbQzQzAFhIbMqjHWLz9ZePvWqO8v9B/bzh8XiQka3g9f0DM5WZ
         bmQ5VnIApykzinC4pQurtlVkJcifk0pU8czjuxWAD7YPgnkdmEuk+svaiYvIPp757NtY
         81ZVtulCqEVnD50ctLB3rBbYqjVFdvdksLnU9PYE5sdZbRShFuxY6I5bGRqPKHMauStg
         75qg==
X-Gm-Message-State: AC+VfDzIXVVQmIEfjnYEtzqX7+1pJizS3UTsza3k2nWn0faWTaQsTBY9
        rtmjT+Hn94AAZM7VLiBY5HmEdA==
X-Google-Smtp-Source: ACHHUZ4NTgyfxBlvxeFNFcg9A0+pojhfwrdDKrGACJsSCpzT73/PLN82DOw9k/K7FMCu1mximsVIng==
X-Received: by 2002:a05:6402:8c3:b0:506:7d3e:ade5 with SMTP id d3-20020a05640208c300b005067d3eade5mr9710332edz.33.1683616294764;
        Tue, 09 May 2023 00:11:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id n7-20020aa7d047000000b004fbdfbb5acesm415192edo.89.2023.05.09.00.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 00:11:34 -0700 (PDT)
Message-ID: <7777c016-4875-a6c9-cd5e-78c2ac686448@linaro.org>
Date:   Tue, 9 May 2023 09:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
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
 <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
 <c6f730b6-f702-91d4-4abd-71546e02f869@linaro.org>
 <23b493f4-1a01-8d03-fc12-d588b2c6fd74@quicinc.com>
 <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
 <500e5abc-fb71-8468-a6b0-3ced2676b57c@linaro.org>
 <e714566e-39b7-d46b-13bd-3c0e20e9f944@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e714566e-39b7-d46b-13bd-3c0e20e9f944@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 09:10, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 10:04 PM, Krzysztof Kozlowski wrote:
>> On 04/05/2023 17:21, Krzysztof Kozlowski wrote:
>>>>>
>>>>>> +	ret = qcom_minidump_init_apss_subsystem(md);
>>>>>> +	if (ret) {
>>>>>> +		dev_err(&pdev->dev, "apss minidump initialization failed: %d\n", ret);
>>>>>> +		goto unlock;
>>>>>> +	}
>>>>>> +
>>>>>> +	__md = md;
>>>>>
>>>>> No. This is a platform device, so it can have multiple instances.
>>>>
>>>> It can have only one instance that is created from SMEM driver probe.
>>>
>>> Anyone can instantiate more of them.... how did you solve it?
>>
>> To clarify - sprinkling more of singletons makes everything tightly
>> coupled, difficult to debug and non-portable. You cannot have two
>> instances, you have to control concurrent initialization by yourself in
>> each of such singletons.
>>
>> I understand sometimes they are unavoidable, for example when this does
>> not map to hardware property. However here you have the parent - smem -
>> which can return you valid instance. Thus you avoid entire problem of
>> file-scope variables.
> 
> I get your point, why one's should avoid file scope variables.
> 
> 
> This is infrastructure driver and will not have multiple instances and 
> even if it happens could be avoided with with the help of global mutex 
> and protect below function which i am already doing at the moment and 

But we do not want global mutexes... so incorrect design is being
improved by more incorrect design.

> fail the other probe if it is already initialized with proper logging..e.g
> 
> "already initialized..."
> 
> 
> ret = qcom_minidump_init_apss_subsystem(md);
> 
> 
> And this will be in-lined with
> 
> /* Pointer to the one and only smem handle */
> static struct qcom_smem *__smem;
> 
> Let me know if you still disagree...and have some other way ?

Why the parent - smem - cannot return every consumer the instance it
has? There will be one smem having only one minidump, so all problems
solved?

Best regards,
Krzysztof

