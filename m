Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A1074FE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGLFBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjGLFBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:01:40 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B01992;
        Tue, 11 Jul 2023 22:01:34 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3465ec72cc8so16396275ab.0;
        Tue, 11 Jul 2023 22:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689138094; x=1691730094;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1DBjmIYFEqewvfNbu+ykUiY8KgREJ7OtERZJYe0jck=;
        b=TWwkkYm27mXd7+q17BR29vGpGdM28c63431u+ENDs+menxZYLWxdIDyK1i2fC4dxcd
         9AOT5AFnNsEyqOjtkHI0P07XP0FicJlhZ+JgYvM2ri3syArKlYdD7ERAu5/dbzzPM/sI
         vQqHISe9KH5nC5f9EyufccEhqcqNUrFq761e8aItQ7VkXwNHyd6EOC6jK7LuU3+NZw1P
         uxEeiwH8NNSlBUsnCdF5GxzPpZAWqok+CzDtndVUVA+c+m8ft7gJN9wPiOizSTH+s1oE
         M60gvWVySkGoFmpTXaAzjPNFzucikJuG1NBsXSrYWk6X3dz/N7AH9umd3AF0qma0ELi3
         gaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689138094; x=1691730094;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1DBjmIYFEqewvfNbu+ykUiY8KgREJ7OtERZJYe0jck=;
        b=Lb6CADKY5EGNo2d23lNm0Iox6NHK3kj7WFnJGDY6TuS38Bf0KN4PdgNP4zNXUJO/bl
         FjgiRgU+GmN4DNa9JYuU1cJ61Ey1eVdMxAuH6vFhRO5mICG/9WdCQ7IkdbgsWIGOvFYd
         w4Tw2g3y2i5Fdq0hfVsy5UO6DYrQ8Dp6EVIFarwpG6wSWa9e45zjL48JTpkczqFEZ+SL
         o+9uIHGg99Nm0Q3VF8XMft1KiXP/q+eWbDvQ2BxGJwdG0FN8jprp4uKtHpOj0DRYsZyb
         RiU1IanIZ7iv6edKa1D6oCROZM0aRmN/aWni+WjjcVEi3DsA+JCRKMxJRbtiNsPH9s/F
         CJTA==
X-Gm-Message-State: ABy/qLbpqSmeDXf6gVC0hUS6Z1kBd7UKZZINxgEr6PPRWBEWbXaV6gEs
        qG48/3p1tIgYZCLOoE6QH7Q=
X-Google-Smtp-Source: APBJJlHEXePdW0sBcDB/GYHCtN5vqLAAOyxVODJV22GISj/Rety8U9SXmXZ8sWtqZsIT/fAuJ8cChw==
X-Received: by 2002:a92:c708:0:b0:346:5a8b:53f3 with SMTP id a8-20020a92c708000000b003465a8b53f3mr9480112ilp.26.1689138093640;
        Tue, 11 Jul 2023 22:01:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i8-20020aa79088000000b0064fde7ae1ffsm2591919pfa.38.2023.07.11.22.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:01:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec89d59b-bb8d-ae7e-2284-1fd6bca22366@roeck-us.net>
Date:   Tue, 11 Jul 2023 22:01:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "Li, Hua Qian" <HuaQian.Li@siemens.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
 <20230711091713.1113010-4-huaqian.li@siemens.com>
 <165cf95b-663b-5dac-b686-a515f2111656@roeck-us.net>
 <0d1b15b1016d451862b895f851c6c6c81472755f.camel@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
In-Reply-To: <0d1b15b1016d451862b895f851c6c6c81472755f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 21:03, Li, Hua Qian wrote:
> On Tue, 2023-07-11 at 19:32 -0700, Guenter Roeck wrote:
>> On 7/11/23 02:17, huaqian.li@siemens.com wrote:
>>> From: Li Hua Qian <huaqian.li@siemens.com>
>>>
>>> This patch adds the WDIOF_CARDRESET support for the platform
>>> watchdog
>>> whose hardware does not support this feature, to know if the board
>>> reboot is due to a watchdog reset.
>>>
>>> This is done via reserved memory(RAM), which indicates if specific
>>> info saved, triggering the watchdog reset in last boot.
>>>
>>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>>> ---
>>>    drivers/watchdog/rti_wdt.c | 48
>>> ++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 48 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/rti_wdt.c
>>> b/drivers/watchdog/rti_wdt.c
>>> index ce8f18e93aa9..77fd6b54137c 100644
>>> --- a/drivers/watchdog/rti_wdt.c
>>> +++ b/drivers/watchdog/rti_wdt.c
>>> @@ -18,6 +18,7 @@
>>>    #include <linux/pm_runtime.h>
>>>    #include <linux/types.h>
>>>    #include <linux/watchdog.h>
>>> +#include <linux/of.h>
>>>    
>>>    #define DEFAULT_HEARTBEAT 60
>>>    
>>> @@ -52,6 +53,11 @@
>>>    
>>>    #define DWDST                 BIT(1)
>>>    
>>> +#define PON_REASON_SOF_NUM     0xBBBBCCCC
>>> +#define PON_REASON_MAGIC_NUM   0xDDDDDDDD
>>> +#define PON_REASON_EOF_NUM     0xCCCCBBBB
>>> +#define PON_REASON_ITEM_BITS   0xFFFFFFFF
>>> +
>>>    static int heartbeat = DEFAULT_HEARTBEAT;
>>>    
>>>    /*
>>> @@ -198,6 +204,11 @@ static int rti_wdt_probe(struct
>>> platform_device *pdev)
>>>          struct rti_wdt_device *wdt;
>>>          struct clk *clk;
>>>          u32 last_ping = 0;
>>> +       u32 reserved_mem_size;
>>> +       unsigned long *vaddr;
>>> +       unsigned long paddr;
>>> +       u32 data[3];
>>> +       u32 reg[8];
>>>    
>>>          wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>>          if (!wdt)
>>> @@ -284,6 +295,43 @@ static int rti_wdt_probe(struct
>>> platform_device *pdev)
>>>                  }
>>>          }
>>>    
>>> +       ret = of_property_read_variable_u32_array(pdev-
>>>> dev.of_node, "reg", reg,
>>> +                                        0, ARRAY_SIZE(reg));
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "cannot read the reg info.\n");
>>> +               goto err_iomap;
>>> +       }
>>
>> This aborts if the property does not exist, which is unacceptable.
>> Any such addition must be optional.
> Agree, refactor it.
>>
>>> +
>>> +       /*
>>> +        * If reserved memory is defined for watchdog reset cause.
>>> +        * Readout the Power-on(PON) reason and pass to bootstatus.
>>> +        */
>>> +       if (ret == 8) {
>>> +               paddr = reg[5];
>>> +               reserved_mem_size = reg[7];
>>
>> It seems odd that reserved_mem_size is not checked,
> ACK
>> and that it is even provided
>> given that it needs to be (at least) 24 bytes, and any other value
>> does not really
>> make sense.
>>
> I was thinkg to add the reliability, but it seems to be unnecessary and
> pointless. Were you suggesting that 8 bytes are enough?
> 

No.
>>> MEMREMAP_WB);
>>> +               if (vaddr == NULL) {
>>> +                       dev_err(dev, "Failed to map memory-
>>> region.\n");
>>> +                       goto err_iomap;
>>
>> This returns 8, which would be an odd error return.
>>
> ACK,refactor it.
>>> +               }
>>> +
>>> +               data[0] = *vaddr & PON_REASON_ITEM_BITS;
>>> +               data[1] = *(vaddr + 1) & PON_REASON_ITEM_BITS;
>>> +               data[2] = *(vaddr + 2) & PON_REASON_ITEM_BITS;
>>> +
>>
>> The & seems pointless / wasteful. Why ignore the upper 32 bits of
>> each location ?
>> Either make it u32 or make it u64 and use the entire 64 bit. Besides,
>> vaddr[0..2] would make the code much easier to read.
>>
> ACK, refactor it.
>>> +               dev_dbg(dev, "Watchdog: sof = %lX, data = %lX, eof
>>> = %lX\n",
>>> +                       data[0], data[1], data[2]);
>>> +
>>> +               if ((data[0] == PON_REASON_SOF_NUM)
>>> +                   && (data[1] == PON_REASON_MAGIC_NUM)
>>> +                   && (data[1] == PON_REASON_MAGIC_NUM)) {
>>
>> Unnecessary inner (), and I don't see the point of checking data[1]
>> twice.
> Yeah, a typo happened.
>>
>>> +                       dev_info(dev, "Watchdog reset cause
>>> detected.\n");
>>
>> Unnecessary noise.
> ACK,rename dev_info to dev_dbg.
>>
>>> +                       wdd->bootstatus |= WDIOF_CARDRESET;
>>> +               }
>>> +               memset(vaddr, 0, reserved_mem_size);
>>> +               memunmap(vaddr);
>>> +       }
>>
>> And some random data in the property is acceptable ? That is odd,
>> especially
>> after mandating the property itself.
>>
> Yeah, do you have any suggestions about how to store the watchdog
> reset cause?
> 

No, and that is not the point I was trying to make. Your code actively
aborts probe if the "reg" property does not exist at all, but then it
silently ignores if it contains a random number of elements (other
than 8). For example, something like
		reg = <0x1234 0x5678>
is silently ignored. If anything, _that_ should return -EINVAL
because it is obviously wrong.

On a higher level, the entire code puzzles me. Obviously there
must be a means for the BIOS or ROMMON to write PON_REASON_SOF_NUM
into some memory area. That means the BIOS/ROMMON must be able
to detect that situation. Why not use the same code to detect this
in the driver without the complexity of passing it from BIOS/ROMMON
to driver in some random memory area ?

> Best regards,
> Li Hua Qian
>>> +
>>>          watchdog_init_timeout(wdd, heartbeat, dev);
>>>    
>>>          ret = watchdog_register_device(wdd);
>>
> 

