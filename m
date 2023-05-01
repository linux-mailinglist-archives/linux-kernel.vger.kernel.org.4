Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2476F3120
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjEAMo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjEAMo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:44:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3815619B2
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:44:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8a6602171so24305231fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682945060; x=1685537060;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=suaeyMT2wIT4/8yocWcP6im75ZqkU8QMeE1d2rFD3ic=;
        b=c7pk9kGVF3zIlacvFcyQJ0UA0BXjcIiKmJgKlYJnFQkUYqgPhV/CYNlQlngDttIdZt
         6ntmumKh7/opzHAj/f9mF7gKp34ahP4r1PamDyEMu5aGVWJvwk5pQH9+kvFsR69wgQsG
         rnIYCNT5OefbPSmhrVn1DMfMSKPakIl/Lp5J7FT1/8q4LtcnYY+EDOMvBt+vdWX9t+kp
         OxOFAVPgUOLMjrVRnSP9nVt1jzvfRQfOrhBVxVKWh3xNm8POfsaRcKdX05s2ILOLqVnJ
         Uyn1OvVHefwaI+5Vbhjw7mqinQlAGi45kYwfIF+1YUFq/PiGMOgTw0QjZj0mz/gRv+cE
         buSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945060; x=1685537060;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suaeyMT2wIT4/8yocWcP6im75ZqkU8QMeE1d2rFD3ic=;
        b=RENkSEL/oza6ZDNyZFmfkkqtAo0Q5XLcaw5K5mk0kjJJcVAdyOeBgE7CpwU9iHq7IA
         3JjyaT2BkUHfZhRiRFTE0qLSEZhLEnDb6HhA1Jlhz9/GW3hnf0T5GDP84K69xlgiinxk
         t2J4ZcFew1n6FV4iO7+nMxymJRWu/e1SlY+mh0FLEtvAq3/0Gp0Bs5uP1DzcZ2Tj5OtZ
         EaQD/GYRPE5mwCyuzGn0KxDI8sFcy9CRIPGxwAE+sqhrSkKFlHAWuQObQooGvUb6C5Hy
         o3tBLbWOjMSY9D6r59+wq1Y53B9yZs4NOy2dq/7WmwdDc/bkvZLzd6BaaPa8vxUkJ8nD
         r1Zg==
X-Gm-Message-State: AC+VfDxp2RsbzchMiprEKQKqRweUH3HoSuG9veuc166KkZFQIAA57U86
        adbmcMYMmUbfRMHZHTlhYUtmxg==
X-Google-Smtp-Source: ACHHUZ6yE30OtfPljX7Jl1MgoIhUtuFIHGsWWjI3F9JJzNvLWmq5NvR3XZhR6aS9nr4SLcLCbwqZGg==
X-Received: by 2002:a2e:918b:0:b0:2a8:a651:8098 with SMTP id f11-20020a2e918b000000b002a8a6518098mr3613054ljg.38.1682945059809;
        Mon, 01 May 2023 05:44:19 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n1-20020a2e8781000000b002a7e9e4e9dcsm4631177lji.114.2023.05.01.05.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 05:44:19 -0700 (PDT)
Message-ID: <4c5e485a-e6ed-f5ec-f1af-3aad2efbb30a@linaro.org>
Date:   Mon, 1 May 2023 14:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] spi: spi-geni-qcom: Correct CS_TOGGLE bit in
 SPI_TRANS_CFG
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
References: <1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com>
 <9f28dbff-ca3a-8523-5bfc-37b38bc846c3@linaro.org>
 <1b1b095e-8fcb-37d5-7542-48a6b55f35a1@quicinc.com>
 <d23d3757-da6f-69d7-bca9-581c489f81e6@linaro.org>
In-Reply-To: <d23d3757-da6f-69d7-bca9-581c489f81e6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.05.2023 14:43, Konrad Dybcio wrote:
> 
> 
> On 1.05.2023 10:05, Vijaya Krishna Nivarthi wrote:
>> On 4/25/2023 7:15 PM, Konrad Dybcio wrote:
>>>
>>> On 4/25/23 09:42, Vijaya Krishna Nivarthi wrote:
>>>> The CS_TOGGLE bit when set is supposed to instruct FW to
>>>> toggle CS line between words. The driver with intent of
>>>> disabling this behaviour has been unsetting BIT(0). This has
>>>> not caused any trouble so far because the original BIT(1)
>>>> is untouched and BIT(0) likely wasn't being used.
>>>>
>>>> Correct this to prevent a potential future bug.
>>>>
>>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>>> ---
>>>
>>> Has this always been the case, or did the switch to BIT(1)
>>> only occur on some recent platforms?
>>
>>
>> Thank you very much for the review..
>>
>> This has always been the case.
>>
>> With intent of disabling CS_TOGGLE, currently, the driver is unsetting BIT(0), though it should have been BIT(1).
>>
>> Yet no problem was encountered because
>>
>> a) BIT(0) seems to be an unused bit
>>
>> b) BIT(1) is probably already unset because its untouched
>>
>> Further more, as Doug pointed we are mostly using GPIO for CS.
>>
>>
>> Testing with the change has not caused any regressions.
> Okay, with no deeper knowledge of the topic best I can give you is:
> 
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 
Also, missing:

Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")

Konrad
> Konrad
>>
>>
>> Thank you,
>>
>> Vijay/
>>
>>
>>
>>>
>>> Konrad
>>>
>>>>   drivers/spi/spi-geni-qcom.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>> index ba7be50..8a7d1c2 100644
>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>> @@ -35,7 +35,7 @@
>>>>   #define CS_DEMUX_OUTPUT_SEL    GENMASK(3, 0)
>>>>     #define SE_SPI_TRANS_CFG    0x25c
>>>> -#define CS_TOGGLE        BIT(0)
>>>> +#define CS_TOGGLE        BIT(1)
>>>>     #define SE_SPI_WORD_LEN        0x268
>>>>   #define WORD_LEN_MSK        GENMASK(9, 0)
