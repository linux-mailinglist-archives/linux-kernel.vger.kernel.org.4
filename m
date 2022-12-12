Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6353A649ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiLLJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiLLJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:12:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2311AE5A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:12:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p36so17452700lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qajxMeWKx//tvnIrgwzb8+4ROl0SWERL+/53UrfDDE0=;
        b=ctcaPhjow1/M/34rEWePItWNlAs0nKRgg0qb3cEaYlERzlNUB4s2ryTfVnMQVrk46r
         RBmlJvEvGMg7twPz8OfwJYL34wCCBjkhQPEkNd/tmTexMw77xsmC7ud/ESmKUgrChfK0
         y4waJry3LzQaNsj5DnNNRI8zf1g+L4qYk0av70H+6dPMQiE5vebZfHQJcfPDZYcEqBBH
         1jtr2yG1Iu6xtxzhhSvBZ9FbWXnN9KbY0weS7gJ/qU4n06DEtEW9azFZA+MOIG3OPjLO
         dl1Wt+CeMlaG8z775szojsBNzC75pVkxy/cTKXRXY9qzXnwC9fGva0f12vbEvqJdQkRS
         2lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qajxMeWKx//tvnIrgwzb8+4ROl0SWERL+/53UrfDDE0=;
        b=BpHMc2HF7yAujhug7JSdMDjkEh3yCvF5aYVEurxmJ2PAqoNH1k+vDM3H2/6WUOJe7U
         4cYcGy+d5VkQg4bWZwf6005t0KYn8X1pGKMY9ETPgk6HD/YOamNxBzA572hQ5UVnPfwR
         F/70QQlIpMVJz6nrDnXf4iv9PHpa+NyOHOJ57Wbt5Gn940tz1eQZP944RqgOeWkWQmdT
         ZVu0iz+Xz9ETQOU6X5XUcc33VRKERGjiVysRxoBPC6cwekECFqOZSgWh0VoR3WJjo17s
         0n1EwbmzkQzeNtIyJ0/kesFEc7kPQ0rTPSM5L7kzm9i2rx6jzLMSyFKZ+MDJpdS6IlBq
         StPg==
X-Gm-Message-State: ANoB5pkMJxYuqfFdGVGYi5k9fUhO5lQOf4vqaoGVfI1ijidCH9tewg02
        bhoBA8S99VHdEDFByj+AR9KbKw==
X-Google-Smtp-Source: AA0mqf5Qe4dRffSeJqDkP1/xjf9TrqptQyuVwJp2GcprSREEEf69TdbzcAukywqo9X+dSH9zTx+kvA==
X-Received: by 2002:a05:6512:2511:b0:4b6:ea42:de0d with SMTP id be17-20020a056512251100b004b6ea42de0dmr1122780lfb.39.1670836345337;
        Mon, 12 Dec 2022 01:12:25 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id h3-20020a056512054300b004b551cdfe13sm1541670lfl.279.2022.12.12.01.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 01:12:24 -0800 (PST)
Message-ID: <fd13b0ba-79b7-4219-9795-ae3055b12bf9@linaro.org>
Date:   Mon, 12 Dec 2022 10:12:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250: move sound and codec nodes
 out of soc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <20221210115704.97614-4-krzysztof.kozlowski@linaro.org>
 <f1aa7f4c-35e4-47d2-2443-8271175dc5af@linaro.org>
 <61b4b894-2c49-881f-c2eb-107e8e558232@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <61b4b894-2c49-881f-c2eb-107e8e558232@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.12.2022 21:13, Krzysztof Kozlowski wrote:
> On 10/12/2022 13:31, Konrad Dybcio wrote:
>>
>>
>> On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
>>> The sound and codec nodes are not a property of a soc, but rather board
>>> as it describes the sound configuration.
>> * in this case, there exist SoC-internal codecs
> 
> wcd9380 is not SoC internal, so to which codec you refer to? Sound node
> is for sound configuration, not codec, and sound configuration is board
> specific.
Your patch is correct, this was a nit pertaining to the commit message,
as it could suggest that all codecs should be moved out of /soc, which
would not be the case for MMIO-mapped ones.

Konrad
> 
>>
>>  It also does not have unit
>>> address:
>>>
>>>   sm8250-hdk.dtb: soc@0: sound: {} should not be valid under {'type': 'object'}
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Best regards,
> Krzysztof
> 
