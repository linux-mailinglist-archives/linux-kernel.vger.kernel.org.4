Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF436FC775
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjEING3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjEINGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:06:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F749E8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:06:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so10950115a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683637567; x=1686229567;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dq27aAWxCkL5lh0gQsM04iiHCtmU3UirHOLrJGmxHBw=;
        b=bTzFElQ0Ijj7Qqx+ITj7N8by0OSLOkJjap0bR5jb2buLViuMHSIwCpg2gPnbNxbiur
         n33ue596ZSOoRMFmoqk2Nw+qulSAPRl9FFYrxG+D2hBsBpuJ9rzibf7y9hl7H2osQ8GV
         e9Y2kuXfjDo1FnM7qhu8Xbnp5qKFZZ1JKEy8kyyruikEg+KOZ18yiV3ne2ALwGNSFm2g
         Y9Pjr9teRy4OQkplB6eGyFeQQ/2RFgxPRgGrgYiTmhV3rK/WmKhBGkahCk3OLdhgtGmn
         jhA2SRixz7fO3Vq/zMVXv+AT/afuzs+K/HadURIPOpJYvBaEs8iR4BF1A3otPPfzz5ej
         +hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637567; x=1686229567;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq27aAWxCkL5lh0gQsM04iiHCtmU3UirHOLrJGmxHBw=;
        b=H9MY6F8smlHiBF9mlHDiVCI6gahGG4FgFX0aV+lhkCAMmoa0raISTGP2nDGe0Ll11J
         lNxPDx82NtWRT6c9RQbQPWdfUtQu+VEW8gWNUcM1UoayOdIsXgA3cb6ux/nI8k03k6qd
         wvVeI7MKdPPYIgfhDpwRmTOBGrbdtFsFyRbnoQQ9dnG1Xb0/SpYT84LNwMyodU/W911C
         Qv/eumbuhMNj5YuasBx1TsGFORTEjZiFGDkQkGnYMiJ2ztOW9u1uwWVOJ4BW+NWLYHd6
         8Bg7RX+OeaeQ/FIu+dwr++JIk9hkfh0KHinMhOyfKTTo07t6pvsnlQNNAkKA5JIJ8kpW
         +70w==
X-Gm-Message-State: AC+VfDzepBw8pewvUp4LAxHJatFE3feDIu65zeVQf9WyatbITRJg4Mpe
        qAKo/s/9xZjPsK0NCkYmRgFLHg==
X-Google-Smtp-Source: ACHHUZ6HVGeI7Az5TQaNdcCmmaidSWz1zdgkmcirij9gIwYx2Yg390YoZ0P4jiPXBvOB89RSgg60Lw==
X-Received: by 2002:aa7:c059:0:b0:50d:9b57:842a with SMTP id k25-20020aa7c059000000b0050d9b57842amr5582009edo.9.1683637567393;
        Tue, 09 May 2023 06:06:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id y2-20020a056402134200b00504ecc4fa96sm726424edw.95.2023.05.09.06.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 06:06:06 -0700 (PDT)
Message-ID: <8b540cc2-bc0d-9d8b-45e6-98410322b3f6@linaro.org>
Date:   Tue, 9 May 2023 15:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXT] Re: [PATCH 1/2 v7] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
References: <20230508131515.19403-1-bbhushan2@marvell.com>
 <ea9ae4c9-2808-bf22-70a3-bb7e7b1168d0@linaro.org>
 <DM5PR1801MB1883175A2538B85FEF571B7AE3769@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <8119eec8-0190-b6a5-85a7-301bcb81b0c9@linaro.org>
 <DM5PR1801MB1883A414F47BB56E9537673AE3769@DM5PR1801MB1883.namprd18.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM5PR1801MB1883A414F47BB56E9537673AE3769@DM5PR1801MB1883.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 11:01, Bharat Bhushan wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, May 9, 2023 1:38 PM
>> To: Bharat Bhushan <bbhushan2@marvell.com>; wim@linux-watchdog.org;
>> linux@roeck-us.net; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> linux-watchdog@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>
>> Subject: Re: [EXT] Re: [PATCH 1/2 v7] dt-bindings: watchdog: marvell GTI system
>> watchdog driver
>>
>> On 09/05/2023 09:26, Bharat Bhushan wrote:
>>
>>
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    oneOf:
>>>>> +      - const: marvell,octeontx2-wdt
>>>>
>>>> Why is this alone? Judging by the enum below, octeontx2 is not specific.
>>>>
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - marvell,octeontx2-95xx-wdt
>>>>> +              - marvell,octeontx2-96xx-wdt
>>>>> +              - marvell,octeontx2-98xx-wdt
>>>>
>>>> We don't allow wildcards in general
>>>
>>> Marvell have octeontx2 series of processor which have watchdog timer.
>>> In 95xx,98xx,96xx are the processors in octeontx2 series of processor. So
>> octeontx2-95xx is on soc, octeontx2-96xx is another and so on.
>>
>> No, 95xx is not a processor. Otherwise please point me to exact product
>> datasheet. Hint: I checked it.
> 
> Looks like 95xx data sheet is not public, will remove in that case.

We can talk about 96xx. Can you point me to the SoC named exactly like
this? Hint: I checked it.


> 
>>
>>>
>>>>
>>>>> +          - const: marvell,octeontx2-wdt
>>>>> +      - const: marvell,cn10k-wdt
>>>>
>>>> Same question - why is this alone?
>>> Same here, Marvell have cn10k series of processors and cn10kx and cnf10kx are
>> the processor in this series.
>>
>> I don't understand how does it explain my concern. This is alone because there
>> are series of processors? How is that related?
> 
> Tried to make it look like other drivers. Let's keep it simple, we want to enable this only for below ones

Enable what? None of these explains why do you need this entry alone,
since it is covered by list further.

> 
> properties:
>   compatible:
>     enum:
>      - marvell,cn10k-wdt
>      - marvell,octeontx2-wdt
> 
> Are you good with that?

Not sure, it sounds like it ignores our entire discussion. What's the
name of the SoC? I see "OcteonTx2 CN9130", not "OcteonTx2". I linked
your previously guide how to write bindings. Did you read it?

Best regards,
Krzysztof

