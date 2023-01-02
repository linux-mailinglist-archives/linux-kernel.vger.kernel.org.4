Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98E65B423
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjABPY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjABPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:24:24 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1278A8FD7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:24:23 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u12so25590367ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6F3428X3VkXSfWeI7eD1wlzHHDb68i1pKwC7SZ80+k=;
        b=pJEgiUmlMEJSoLMcyNxOgnwHpoV1ZzN/TRB46JAQrE+ZHWYTwvSQIx4icRaHmhdrCn
         gERURdjg+ufg6jAr+CB//czB+2KuFH3q4EG8jXNZd3uv+mp8sDc6ae/uMcd+swGA7ZhC
         ADwOuUZLSDjLt1xB84KcvUQ4vcd+fm3Y15cCLSNhvnYgeqfA4YXWxXuXS0AktQ9eJUU5
         kALqxyVJ6T7FdqEieLJLmCBUfDuv2hKjlgOL6o/y3aB5GgIox3f+CeBDFy7K1jmwaUPY
         jky0osnK/5JnUH2tnWger7p3D1+KNLty7CIPtnpFrQWjiQSb75SUGNcqsBOpdHGdjclI
         NmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6F3428X3VkXSfWeI7eD1wlzHHDb68i1pKwC7SZ80+k=;
        b=6YCbxGBB8yqihD6zkT+enzRkhrBrWdVxhZjpp0oMz53xL+Qq+GvHJNb+gQO5oE+1cb
         Jh8fFGhjc1TMYQupQjCJ9eV06yEGKneFlUCbFgYyZ8/AB0Yr5DDUyTJM9D0b0XHMZrnM
         X06NxsIgX0NzC1gYNzPkTMCQN1HuzxZwB40fKxhTN/yRhxifVqw5Oq6w+pDDV4j9iOUC
         h1HF6Ypom3UGtyqJ8WYnmkgHEZpkC/zQUZKMU7ErL6XnWepVIoBNptTgMk85sgp2WzEZ
         AQsCxDWJd338/Rz1qwZhhflBYSW/H7CcWfXfP6MH9lzBX6a5I0QfUWQmR7W2usztbMpa
         51IQ==
X-Gm-Message-State: AFqh2krMzwrdab8ybAWM7A3EHgEy6BZo17Q+liJZi+Qgb96iIrG46G62
        Vx221BA36u/8hDIRvY6seEftcA==
X-Google-Smtp-Source: AMrXdXvyJrFjZYR4SFhKddpqhM/UTzlhtgRzf8QAyXwkMXp0ofuhD1crGdqVlHDNKkgk6M8e6f+4RQ==
X-Received: by 2002:a05:651c:510:b0:27f:bc6c:c4f4 with SMTP id o16-20020a05651c051000b0027fbc6cc4f4mr9269731ljp.9.1672673061422;
        Mon, 02 Jan 2023 07:24:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m9-20020a194349000000b004b4ec76016esm4482440lfj.113.2023.01.02.07.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:24:20 -0800 (PST)
Message-ID: <582a53a4-991c-5596-d8c8-2c1c09997874@linaro.org>
Date:   Mon, 2 Jan 2023 16:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] arm64: dts: qcom: sm8450-hdk: fix wcd938x codec node
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-7-johan+linaro@kernel.org>
 <c2a32bd3-90cf-6d1b-1ca7-76071232c81b@linaro.org>
 <791c0e37-f825-c324-7a99-163b0566c758@linaro.org>
 <Y7Ly1wlft4Y6VfIG@hovoldconsulting.com>
 <e57164f6-7dcf-5139-1b4f-6b63f9fd7786@linaro.org>
 <Y7L11WymK7BChUPc@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7L11WymK7BChUPc@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 16:18, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 04:09:59PM +0100, Krzysztof Kozlowski wrote:
>> On 02/01/2023 16:05, Johan Hovold wrote:
>>> On Mon, Jan 02, 2023 at 01:24:34PM +0100, Krzysztof Kozlowski wrote:
>>>> On 02/01/2023 13:23, Krzysztof Kozlowski wrote:
>>>>> On 02/01/2023 11:50, Johan Hovold wrote:
>>>>>> The wcd938x codec is not a memory-mapped device and does not belong
>>>>>> under the soc node.
>>>>>>
>>>>>> Move the node to the root node to avoid DT validation failures.
>>>>>>
>>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 52 ++++++++++++-------------
>>>>>>  1 file changed, 25 insertions(+), 27 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>>>> index 4de3e1f1c39c..217b2c654745 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>>>>>> @@ -17,6 +17,31 @@ aliases {
>>>>>>  		serial0 = &uart7;
>>>>>>  	};
>>>>>>  
>>>>>> +	wcd938x: codec {
>>>>>
>>>>> Let's call it audio-codec and put it somewhere ordered alphabetically.
>>>>> This avoids useless reshuffles immediately. Moving things back and forth
>>>>> does not make sense.
>>>>
>>>> Eh, on the other hand SM8250-MTP uses name codec so maybe the rename in
>>>> SC8280xp should be dropped.
>>>
>>> Nah, let's go with audio-codec. Your MTP change hasn't been merged yet
>>> so we can still drop or respin that one.
>>
>> It was, ~5 days ago, so please rebase.
> 
> Again, not in the qcom tree yet AFAICS.

It's clearly visible there, since a week, so please update your trees
and rebase.

Best regards,
Krzysztof

