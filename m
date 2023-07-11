Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54174E81C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjGKHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGKHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:35:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C26E40
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:35:33 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98e011f45ffso615384866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689060932; x=1691652932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fx+Vv2eXTf6DQUrqcHqLeD3pKo6Jx8+yvbrDyBDr5TM=;
        b=qTuHYQu0EifNSd5WQxFYZcNhdfKKq/UNeeIAbnVBUF8Mq4C12q93WFGNCFpeDtL+DQ
         YzXv8G7JYBBBCEozHk1LgHoKiF43db3zSDeFus6Aw2uxIkIsN1acmhB1OQnibC7JOL6B
         VgHhxls5Kcks6l2Ky9xdw6QsM/X2V6x5H7x5ALba1d+uzJy7tCblDHEyk/4L9dmzCAnL
         hvzyhc63pKwiJxSAVe9fSO2ByewK0RyLTIf0P8XUTt9c2MyIoQf89u3gaqQYVs6rfeiM
         gf7KwIMFHuvayR0qu06mczywib33U3dmeWCgONqNipGvXJA5cciWa+AcjbNZNHXW+1te
         d4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060932; x=1691652932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx+Vv2eXTf6DQUrqcHqLeD3pKo6Jx8+yvbrDyBDr5TM=;
        b=IjHcupYNpZYHI3eYLd5FU8Of3NZt/TkJa8WZiuTcu8hsf25/019Jv5gTwYb1ZeiwVf
         kVhAwv4JTWTHg53CT0ZEppZCi2rZWGbkB640WApcOckl9ppblGAJvDOheAyuWPmvMEov
         JRn2QIZodVscoZxGOIoPsVkbUMiWQ+w0sbN/suOVR9+80GsLIDlmR/H5QstgK3iTgntj
         if72dG+e/JnH0lT8VErqPASqD83jmC7dxVbbBTx2MdIZfp+pzmeq4S50iBdxLctQT3KM
         IvUTFWzOtNHdT0SmLs1CgHaEx2mvbRRQimqkf/lWvjhW7uPvFUZtGIW/yIXhc3RkEvf5
         +cMg==
X-Gm-Message-State: ABy/qLYkiCS5yTw/0XKzqSsGy7SR3I3VnETLTff/4CN658ljJsytE0w/
        pK1keoeTfYWVtuRnjZ0M/wvJDg==
X-Google-Smtp-Source: APBJJlF0AK38PC3IU/WCigwhDf+jr4s/nDYYzrdBC76Hw9cAGUV2DQotgXhsnxvUDKeTIlDnwZqdUA==
X-Received: by 2002:a17:906:6543:b0:993:a396:ac64 with SMTP id u3-20020a170906654300b00993a396ac64mr12625651ejn.38.1689060931966;
        Tue, 11 Jul 2023 00:35:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090680d200b00992d70cc8acsm763214ejx.112.2023.07.11.00.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:35:31 -0700 (PDT)
Message-ID: <80a43533-f6d6-b498-b677-08f7e608155a@linaro.org>
Date:   Tue, 11 Jul 2023 09:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: ti-serdes-mux: Add defines for SERDES4 in
 J784S4 SoC
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, peda@axentia.se,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-vadapalli@ti.com
References: <20230710102712.155195-1-j-choudhary@ti.com>
 <d136d58d-9582-3833-861f-086b64c1ad36@linaro.org>
 <ecbb6d34-e024-f6c6-5921-ba7bc6fe2e5e@ti.com>
 <97436a92-2cbd-0498-8aad-444ac3fab99b@linaro.org>
 <d54b0cc2-91d9-b081-fc39-0bbba715ee5b@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d54b0cc2-91d9-b081-fc39-0bbba715ee5b@ti.com>
Content-Type: text/plain; charset=UTF-8
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

On 11/07/2023 09:21, Jayesh Choudhary wrote:
> 
> 
> On 11/07/23 11:34, Krzysztof Kozlowski wrote:
>> On 11/07/2023 07:55, Jayesh Choudhary wrote:
>>> Hello Krzysztof,
>>>
>>> On 10/07/23 17:11, Krzysztof Kozlowski wrote:
>>>> On 10/07/2023 12:27, Jayesh Choudhary wrote:
>>>>> SERDES4 has 4 lanes. Add lane definitions for it.
>>>>>
>>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>>> ---
>>>>>    include/dt-bindings/mux/ti-serdes.h | 20 ++++++++++++++++++++
>>>>
>>>> Where are the users of this binding constants? IOW, why do you need to
>>>> add these?
>>>>
>>>> I don't see users of existing constants either...
>>>>
>>>
>>> These constants are propagated in the idle-state property for the
>>> mux-controller node (named serdes_ln_ctrl) usually in the final
>>> board dts files and occasionally in the main dtsi files for TI SoCs.
>>
>> So they are not used. 
> 
> 'They' as in SERDES4 definition or others as well??

I made quick greps and it seems that none of the defines - existing and
new - are used. But here anyway we talk about this patch, which without
users does not have any rationale.

Best regards,
Krzysztof

