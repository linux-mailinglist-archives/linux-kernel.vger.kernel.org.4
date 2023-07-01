Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF174488E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGAKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjGAKvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:51:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0E3C05
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:51:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992f15c36fcso159423266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688208676; x=1690800676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=poat+7LJyBVOXz72f7QSYyR4e+jhljirM/hQxmbxiyc=;
        b=nSfoh29XQ0b832DqNw7BftsRnoqaS9j530fVP0A/zOfldM11h7eN0pHygtx5yIrmAS
         YxJSBTPmRVEI+ZvubyZW6wsJMUqoXewAu7xYY9h7eLtrR/eVd8eHMVW1WdkchD1yfGUg
         tkoLDyrurKt96H5oLARMJIbO+0pMkuBtBN0Szznqlf83S8cSnRP0VJv6I0pVYkV+3Rig
         GU/qGf9MB+xWD14aPIbFch4+tPBDcOqNAqcX/DDhUEcc/l74e2x3pVZpBos+6G4viKUY
         4iS8Izw/s23cIzfo4P+XrBXjOrHlPWEV/BVmxtg0CwN7HBHg7wesoLpNgQDoDLfPuQpN
         zOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688208676; x=1690800676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poat+7LJyBVOXz72f7QSYyR4e+jhljirM/hQxmbxiyc=;
        b=MfBeFBP9LIBVbfRBCHgvj/xDsMdNkP2rIwRunhN3+siQXfYP2P+AMqQmwab2AR/608
         tOYHAZpX6PwZ8CNAjbBV/X5hVnww+aiWGfHyReEYJ7MpBtws08nvYzT0AI87HI2l4eDA
         kT3JKZ4IyLTAt65i7whljPHV2fufW9ScKY1tHctqKbKbM8AsVw8TjoSa56AJcPYauwK4
         5cU9V8POZG4yWGEIA78yQEjGAoeKrLoq5niJz0qF/a7gKuss/IyAaz5UXFSEwCFJBzI8
         ahM8GORtCGl8QXtQ4C+Ot79935lehQgY+QHp52hN1s52t7h2zTMLu9FMPlqOuwAgRBHN
         5keA==
X-Gm-Message-State: ABy/qLa1jytRtbERq+ujvop/kL5NDvsEM6wI8nbFy2DW01zY1OpzwpQn
        JUd+W/2QnMJoCxpHt3L99p3nlA==
X-Google-Smtp-Source: APBJJlHrI592wZF7xkYxgBqLFei9JbCnmRVtVyhWS+LjlScoOHrcXYWuMRl05gymoR993pZsubH6Sg==
X-Received: by 2002:a17:906:13d5:b0:968:236:eb17 with SMTP id g21-20020a17090613d500b009680236eb17mr3401971ejc.24.1688208676136;
        Sat, 01 Jul 2023 03:51:16 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id qk3-20020a170906d9c300b00984822540c9sm9186217ejb.96.2023.07.01.03.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 03:51:15 -0700 (PDT)
Message-ID: <2eace846-1feb-4299-4678-e1ff06179fdc@linaro.org>
Date:   Sat, 1 Jul 2023 12:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
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
 <5f9cc367-eaa5-4c19-4e5e-7052b0259ccf@linaro.org>
 <04f5e3cb-d2f5-747c-1fd0-4b61d845e2c5@quicinc.com>
 <36900050-2ffd-b5dd-f768-986624a83c70@linaro.org>
 <59d92b83-f759-50de-9b8b-834c3c0bec5a@quicinc.com>
 <8dbd8330-de83-b663-8105-e33c16687a88@linaro.org>
 <c312824f-1438-d5de-d139-aaeb63f3c566@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c312824f-1438-d5de-d139-aaeb63f3c566@quicinc.com>
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

On 30/06/2023 09:12, Manikanta Mylavarapu wrote:
> 
> 
> On 6/24/2023 12:49 PM, Krzysztof Kozlowski wrote:
>> On 21/06/2023 13:39, Manikanta Mylavarapu wrote:
>>>>> on number of wcss radios connected on that board and only one instance
>>>>> of 'qcom,ipq5018-q6-mpd'.
>>>>>
>>>>
>>>> I don't understand why the user protection domains need a specific
>>>> compatible. Why do they need compatible at all?
>>>>
>>>> Not mentioning that amount of your domains on Q6 is actually fixed per
>>>> SoC and probably should not be in DT at all.
>>>>
>>>     root domain is fixed per soc (One Q6 DSP, one per soc)
>>>     user domain(s) are variable (based on number of wcss radios attached)
>>>
>>>     The sequence to initialize, bring up, tear down the Q6 and wcss radios
>>>     are completely different. So in order to differentiate them, we will
>>>     need different compatibles. So this is a new rproc driver/architecture
>>>     which has a parent/child topology (Q6 DSP -> Master/parent controls
>>>     the WCSS (child)).
>>
>> I understand you need different properties, but I don't see yet the
>> benefit of creating here artificial compatibles. Look at your ipq9574
>> DTSI change - it does not use even ipq9574 compatibles for 66% of its
>> children.
>>
>> Maybe you should have there just property describing type of device or
>> bringup?
>>
> 
> 	Yeah i got your point. Indeed the requirement here is to
> 	have device specific compatibles, so will have just two
> 	compatible one for Q6-MPD and another for WCSS-MPD device's
> 
> 
> 	"qcom,q6-mpd" --> For Q6-MPD device
> 	"qcom,wcss-mpd" --> For WCSS-MPD device
> 
> 	Is this approach fine ?

Can you fix your reply style, so it is like on every mailing list? Some
weird indentation does no help to read it.

I was proposing to drop compatibles entirely. Making compatibles generic
is not solving any of my concerns.

I don't understand what do you want to achieve here and very limited
description of the hardware in the binding does not help.

> 
>> Given SoC cannot come with different amount of children (PD) and
>> different amount of radios. You even fix the firmware name, so
>> boards/customers cannot use anything else. It's fixed and the only
>> variable element here is disabling some of the blocks per board, if they
>> do not have physical interface (e.g. radio).
>>
>> You even hard-code the number of PD by using "pd-[123]", without unit
>> address, so you do not expect it will grow.
>>
>> Unless you want to say that these are devices? But your binding does not
>> really suggest it...
>>
>>
>> 	Yes, as i mentioned above the requirement is to have device

What requirement? You did not describe anything. Binding describes
hardware, not your requirements.

Binding said nothing about devices.

> 	specific bindings. We will remove "PD-X" from soc dtsi and
> 	add it in board dts file.

Why? How is it related to the bindings? What does it solve? Instead of
doing some changes you should explain why.

> 
> 	So soc dts would have "Q6-MPD" master node & board dts have
> 	"WCSS-MPD" child nodes based on number of radio's connected
> 	on board.
> 
> 	Is this fine ?
> 

Why?

Best regards,
Krzysztof

