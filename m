Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893D96D156D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCaCDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaCDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:03:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A2BB95;
        Thu, 30 Mar 2023 19:03:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q102so19020185pjq.3;
        Thu, 30 Mar 2023 19:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680228202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKIofgr/GCTBNuO9ZygMr6tfiN0nXLiY+RGo82nSz7Q=;
        b=Ig9evASaqAhW6JpaKUEv1RDr56mWfL5iElcEno2q1KtDuqIgijiCy1ZrYLZvzMzg/Z
         NTWJQeqHR7wOBj4OZHtG6faG7dmvHPkuoCznrytnE38dev0eq0McXsKCq+ZfY/nWodVB
         ofw2HCD40DIsz9olk1fowvOVGmCbuUD4++kRcQMZKry0X5UG+fGQIA2lSmp/V0Bu3Iml
         fArad05lm1o7bEyzqzVEswhv8ZAg26uQVdv8f7GXR3p3gvEndBDxFbx+8tup1vQQbPFk
         ybPU/pMBGeGzo29SPCz5HgOdtS1TkBdOyEC6h2kWax9BRhCHVEm3PgqsjmnvMxH08TO5
         0uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680228202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKIofgr/GCTBNuO9ZygMr6tfiN0nXLiY+RGo82nSz7Q=;
        b=6z9lBRQZFQAOlNwy3UAljTaqOwVHjflXP7ebIQ0pCjBiNmg5SegLR51ZFXIY4mwXtj
         1kfqGcIXVlaBWhjEsRARByAdkjiHJbQBdTt5FFf5qvA62I0JLNE1FF3OTmqMVZHsty8t
         1zDCLP96SaulsrcJTvVPpVlEvZiiXsdl21FHYmI5IKQjnb8niP3m4hBfh9FZs9kiXCk7
         l/eOkZUXknQ9YsK18ZZfmEzQhArghxeYOzphrgSDZYEXyQhxh4mpewmh766vkp3HSoQZ
         FSgbOx/69tMYY4FExZ9LqVpFebOKfHVX0c35sijrCPvMKO2YmgoAgq9tgxYx01uKi3jT
         YzsQ==
X-Gm-Message-State: AO0yUKXHUZQxlRz1Xlu9bvjVM20DoRF/1JF6XnlCY6NKJPvph8B/1XdJ
        vPkGj5e10HEX1DYGqnh7k+8=
X-Google-Smtp-Source: AK7set9AVhm0k3VBBBlPzTAy/S+MsPVrdmvsUCwwjsGEX0hjdJZ+Uy1zuSQ4Yh33ScbmvVN9orFXPg==
X-Received: by 2002:a05:6a20:2494:b0:d3:72c6:b018 with SMTP id m20-20020a056a20249400b000d372c6b018mr21002448pzd.39.1680228202279;
        Thu, 30 Mar 2023 19:03:22 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78256000000b00625cfe645ddsm529160pfn.2.2023.03.30.19.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 19:03:21 -0700 (PDT)
Message-ID: <28df13b6-201c-2fad-6f69-f12d24fba8e8@gmail.com>
Date:   Fri, 31 Mar 2023 10:03:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart
 controller
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-8-ychuang570808@gmail.com>
 <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
 <7b5e42bc-0788-5208-e97e-10502da1c238@gmail.com>
 <4c1fa450-79c9-2c66-4bb8-b880f2cf07a5@linaro.org>
 <8bf559ec-0f5f-7ac5-6400-ccd2395b3b95@gmail.com>
 <20230330131219.GA1849090-robh@kernel.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230330131219.GA1849090-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/30 下午 09:12, Rob Herring wrote:
> On Thu, Mar 30, 2023 at 06:52:11PM +0800, Jacky Huang wrote:
>>
>> On 2023/3/30 下午 03:33, Krzysztof Kozlowski wrote:
>>> On 29/03/2023 10:44, Jacky Huang wrote:
>>>> Dear Krzysztof,
>>>>
>>>>
>>>> Thanks for your review.
>>>>
>>>>
>>>> On 2023/3/29 下午 04:20, Krzysztof Kozlowski wrote:
>>>>> On 28/03/2023 04:19, Jacky Huang wrote:
>>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>>
>>>>>> Add documentation to describe nuvoton ma35d1 uart driver bindings.
>>>>>>
>>>>> This depends on clock patches, so it must be taken together.
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> OK, I will combine this patch with the clock patch.
>>> I don't know what you mean by "combine", but I don't think this is what
>>> we want. You must clearly state all dependencies and patch merging
>>> strategy/way.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Dear Krzysztof,
>>
>>
>> I may be misunderstanding your request.
>> I thought it was moving the "nuvoton,ma35d1-serial.yaml" to the patch of
>> nuvoton,ma35d1-clk.h.
>> Would you please provide guidance what should I do next on this [PATCH v6
>> 07/12]. Thank you.
> The only combining you should do is putting the 2 patches in the same
> series. Combining to 1 patch would be wrong.
>
> Your other option is just drop the header in the example and use the
> raw numbers. Then there is no dependency to manage and each subsystem
> maintainer can take the relevant patches.
>
> Rob

Dear Rob,

Thanks for your detailed explanation. I got it now.


Best regards,
Jacky Huang




