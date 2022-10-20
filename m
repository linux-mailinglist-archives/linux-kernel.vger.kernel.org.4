Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F44606829
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJTSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJTSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:24:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE191F1839
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:24:02 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w3so142611qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbX/juujWC6ueA+dF64S7G5Ta7cBZWyKR6zbSd0h7YY=;
        b=AaABUfwRmy6Nfus8levvOmejLM3AdKQQPLMs+8C7Atk5/AiuCuCWT3QFxTCDgb89Br
         16M62FbFmBpKm0IJrw5ItxSNam9IBr6CrQsRGYaoQxSy/wBc+rHE2pEysHRiqf6fr4nF
         L5nc9tpgaamvXYaGuCaKnoY+V+b/TiVNnZNiP8qT1+mcBw9XjA/4UybFnd1olfzWnJH6
         dpbdGkTlqdLk57Z3yvB09nNLDrcbSfjzmUzeX5pfhMiV54UgeuV+WwT+nm7w0XRzxocU
         kOlPHCXBnv12pukrYyqavXi8XnLw3kOXX8ZL7igpuWV/iZICmrQj7NpKBPR6mXD+M8+v
         ulFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbX/juujWC6ueA+dF64S7G5Ta7cBZWyKR6zbSd0h7YY=;
        b=2YDrT/uqoMU7BEVcWx7ov+ehCOeupHTEwVxX9YKreHauptmdoucTvOAvP+dZuVB8gg
         ft92m8dYw1s0OfE5kYXngCbXNj/MpX0qIriLEIo8cyyqWJVOXN2uPmEicRBwiRu6nzCn
         COnpD3WFoXcCppZyFWeGKGxSHjJ9yYfi0skxav02DUnrQNU8QWvTk2EUUk4oKe1Ejork
         UBD2Whj4WV8+RItcDHuYXGhHFXbG/UU7/rmv+hDBP0wf0N4sQmkKU7GUWJml0P0q0OAB
         4KFXrDnK4xj5KgupvrHsDXOIQpY0v0SeYykXi5uOBP5Xh9kRhHlD4sYnfFG+9I0d+AlI
         ZpIQ==
X-Gm-Message-State: ACrzQf3rNxKdmx/Ey0/knbiHdDTIRr4yrRKUE91BZQt8/wnODr8CKmvY
        KxIxNBrNSdqQ87Sow0N5YUAASg==
X-Google-Smtp-Source: AMsMyM7D0BGgC1BtJnpb+bfxSiU74ftu8bSbR3bVqXlel9eqWedUYhS8sohMpV9TYWuUBSCYl+c2LA==
X-Received: by 2002:ac8:58c5:0:b0:39c:c710:f58c with SMTP id u5-20020ac858c5000000b0039cc710f58cmr12105164qta.295.1666290242072;
        Thu, 20 Oct 2022 11:24:02 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a132700b006b61b2cb1d2sm7684779qkj.46.2022.10.20.11.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 11:24:01 -0700 (PDT)
Message-ID: <f8435311-42fa-4858-4623-8088d644f6c6@linaro.org>
Date:   Thu, 20 Oct 2022 14:23:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: fsl-imx: document suspend in
 wait mode
Content-Language: en-US
To:     Andrej Picej <andrej.picej@norik.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
References: <20221019111714.1953262-1-andrej.picej@norik.com>
 <ea6893f6-be39-697c-4493-7f1c0ed6708d@linaro.org>
 <143f1466-e34a-254d-4e6e-fefa17ad1390@norik.com>
 <24401572.EfDdHjke4D@steina-w>
 <1a3a1c8c-8baf-ef70-9e5b-e817bb14cfad@norik.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1a3a1c8c-8baf-ef70-9e5b-e817bb14cfad@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 09:05, Andrej Picej wrote:
> 
> 
> On 20. 10. 22 14:41, Alexander Stein wrote:
>> Am Donnerstag, 20. Oktober 2022, 14:36:10 CEST schrieb Andrej Picej:
>>> On 20. 10. 22 14:18, Krzysztof Kozlowski wrote:
>>>> On 20/10/2022 02:23, Andrej Picej wrote:
>>>>> Hi Alexander and Krzysztof,
>>>>>
>>>>> hope I can reply to both questions here.
>>>>>
>>>>> On 19. 10. 22 17:51, Krzysztof Kozlowski wrote:
>>>>>> On 19/10/2022 09:00, Alexander Stein wrote:
>>>>>>> Hello Andrej,
>>>>>>
>>>>>>> Am Mittwoch, 19. Oktober 2022, 13:17:13 CEST schrieb Andrej Picej:
>>>>>> Missing commit msg.
>>>>>>
>>>>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>     Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml | 5
>>>>>>>>     +++++
>>>>>>>>     1 file changed, 5 insertions(+)
>>>>>>>>
>>>>>>>> diff --git
>>>>>>>> a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>>>>>>>> b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml index
>>>>>>>> fb7695515be1..01b3e04e7e65 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
>>>>>>>>
>>>>>>>> @@ -55,6 +55,11 @@ properties:
>>>>>>>>           If present, the watchdog device is configured to assert its
>>>>>>>>           external reset (WDOG_B) instead of issuing a software reset.
>>>>>>>>
>>>>>>>> +  fsl,suspend-in-wait:
>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>>>>> +    description: |
>>>>>>>> +      If present, the watchdog device is suspended in WAIT mode.
>>>>>>>> +
>>>>>>>>
>>>>>>>>     required:
>>>>>>>>       - compatible
>>>>>>>>       - interrupts
>>>>>>>
>>>>>>> What is the condition the watchdog is suspended in WAIT mode? Is this
>>>>>>> specific to SoC or platform or something else?
>>>>>
>>>>> Sorry, what exactly do you mean by condition?
>>>>
>>>> Ugh, I also cannot parse it now...
>>
>> Sorry, Krzysztof already asked the right question: When does one want to
>> enable/disable this feature?
>>
>>>>> When the property
>>>>> "fsl,suspend-in-wait" is set the watchdog is suspended in WAIT mode, so
>>>>> this is defined by the user. Didn't want to apply it for all the
>>>>> supported machines since there could be devices which depend on watchdog
>>>>> triggering in WAIT mode. We stumbled on this problem on imx6 devices,
>>>>> but the same bit (with the same description) is found on imx25, imx35,
>>>>> imx50/51/53, imx7 and imx8.
>>>>
>>>> I meant, what is expected to happen if you do not enable this bit and
>>>> watchdog triggers in WAIT mode? IOW, why someone might want to enable or
>>>> disable this property?
>>>
>>> If this is not enabled and you put the device into the Suspend-to-idle
>>> mode the device resets after 128 seconds. If not, the device can be left
>>> in that state for infinite time. I'm guessing you want me to better
>>> explain the property in device tree docs right?
>>> I can do that in v2.
>>>
>>>>>> And what happens else? When it is not suspended in WAIT mode?
>>>>>
>>>>> When you put the device in "freeze"/"Suspend-To-Idle" low-power mode the
>>>>> watchdog keeps running and triggers a reset after 128 seconds. So the
>>>>> maximum length the device can stay in this mode is limited to 128
>>>>> seconds.
>>>>
>>>> And who wakes up the system before 128 seconds? IOW is there a use case
>>>> of not enabling this property?
>>>
>>> Well I can think of one, system can be woken up by some other interrupt.
>>> Like RTC which triggers interrupt (for example every 10s). So if this
>>> property is left disabled the watchdog can handle errors where other
>>> wakeup sources don't trigger interrupt or if the system is unable to
>>> wake from low-power state. In that case the watchdog will do a hard
>>> reset of the device.
>>>
>>> But I'm not really sure if anybody uses this, just wanted to make sure
>>> that we keep the default behaviour as it is, since this driver is used
>>> by many devices and for quite some time.
>>
>> This sounds more like (application) configuration. If so this should not be
>> configured in device tree, IMHO.
>>
> 
> Do you have an idea where should it be configured? Just keep in mind 
> that this can not be configured at runtime, since this is write-once bit 
> so any configuration changes regarding this functionality can not be done.
> 
> Basically if I can sum up the problem:
> 
> Without this property enabled, the WDW bit is left unset:
> $ echo freeze > /sys/power/state
> #device enters Suspend-to-idle, watchdog is left running and the device 
> resets after 128 seconds in this state

I still wonder (and still did not receive) about such use case. When
would you like to have such behavior?

> 
> With this property set, the WDW bit is set at watchdog initialization:
> $ echo freeze > /sys/power/state
> #device enters Suspend-to-idle, watchdog is suspended and the device can 
> be left in this state until some other wakeup source triggers interrupt.

Assuming there is such use case, for keeping watchdog running even
though system sleeps (and cannot poke watchdog), it's fine.

Best regards,
Krzysztof

