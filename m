Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E906BD8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCPTKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCPTKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:10:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637FE1CBC3;
        Thu, 16 Mar 2023 12:10:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ja10so2854659plb.5;
        Thu, 16 Mar 2023 12:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678993834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+E8Ixd1Y68qyEsWPw4FyeSyxTc5J30wWegUf92YG+Yw=;
        b=Pu3ozm4mDjsfIsoSUODeAcc1jOpn19dMCDeXDxF5C2NN+vbXCzPYuQw3Up5X9/lnpi
         1hAf26MMB8eZcVuSebpszZFwvQtMounR4b/hUHWqJq5Gg+Azfib97HUexBIi5/g37Cki
         l0R4QunbKsx+4qNAuKursSV1RQb4atUc3jltxANanV78NgqMUsbhjVJ9NRp/Po0bT6OW
         Fo5D9anEy5/sOYyQMjNaOOnsUVdtZ2gmfI/VWdVUY8SidXFRa93HHSlA/Vm/IzlTA58A
         cf5sXHCbcjIvaxxJq0gvvuCOI9ngYL71dKK0fX79dOindsJdberUBDLmpLNBI5xJHQmJ
         JdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678993834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+E8Ixd1Y68qyEsWPw4FyeSyxTc5J30wWegUf92YG+Yw=;
        b=AYsOstsuKLTPf05th28yP6YrQ9BeuUm5YrNBWiFs8Fkxex2bokzC2vQ7yiRai2ui/3
         zbWRIfg4hMFhs6g+WcfTbjvxxUfd90ywTfM9P4TwvE9Rop/TjzRQlbzQ80q5UjVo1OYE
         /BqGHuTU6ED26gV6pr1liDjZ8nCmunxUcC4VOLGGDDxsGW0S9cQSTF5OS6is68ptrxkg
         NQdMO4G1+q6cicV4GFpdtw8cZY+yHgvxT0ulMzTYVLNEI4FMRhutL9VV6oieK1QKWy9E
         jJMBJlS1YXJFl99LneCLLhHl4aH99+LAIc0Pp9XJ0dSSr+v9kJJPdNvsR3ihKlyDqkBk
         bANQ==
X-Gm-Message-State: AO0yUKUSi6VLh9OKwyOxaJW0dWImeM6sYCEFm9btxTtMJRjl7PD03tOU
        Ynodb1HhbRGBo+aoNz/FXRk=
X-Google-Smtp-Source: AK7set9lCtfnYzOx1Y6KOMDTExwYEt+wT068NQm9Yk+BXMXEinlYPlmg020GJqrQxamutvtg4ZeQCw==
X-Received: by 2002:a17:902:e38b:b0:19f:3b86:4715 with SMTP id g11-20020a170902e38b00b0019f3b864715mr3742408ple.8.1678993833700;
        Thu, 16 Mar 2023 12:10:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id je19-20020a170903265300b0019f3e339fb4sm47339plb.187.2023.03.16.12.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 12:10:32 -0700 (PDT)
Message-ID: <cf868119-31e4-480e-6ebc-531f0686f664@gmail.com>
Date:   Thu, 16 Mar 2023 12:10:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] irqchip/bcm-6345-l1: show MMIO address
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        tglx@linutronix.de, maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316180701.783785-1-noltari@gmail.com>
 <aa72bcfb-b366-f373-60c5-99404109c482@gmail.com>
 <CAKR-sGcuKoDyZSmprbFPHoHdKjk9N=q1SDLE0+qTVuXmuF=saA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKR-sGcuKoDyZSmprbFPHoHdKjk9N=q1SDLE0+qTVuXmuF=saA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 12:04, Álvaro Fernández Rojas wrote:
> El jue, 16 mar 2023 a las 19:13, Florian Fainelli
> (<f.fainelli@gmail.com>) escribió:
>>
>> On 3/16/23 11:07, Álvaro Fernández Rojas wrote:
>>> It's safe to show MMIO address.
>>>
>>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>>
>> This is going to be the kernel virtual address, and while on MIPS it is
>> easy to resolve to the physical address because these platforms map
>> registers through KSEG0/1, on other platforms like ARM/ARM64 the kernel
>> virtual addresses are pretty meaningless unless what you want to debug
>> is how ioremap() mapped the address.
>>
>> I would rather do the following change:
>>
>> diff --git a/drivers/irqchip/irq-bcm6345-l1.c
>> b/drivers/irqchip/irq-bcm6345-l1.c
>> index 1bd0621c4ce2..832957d363a4 100644
>> --- a/drivers/irqchip/irq-bcm6345-l1.c
>> +++ b/drivers/irqchip/irq-bcm6345-l1.c
>> @@ -261,6 +261,8 @@ static int __init bcm6345_l1_init_one(struct
>> device_node *dn,
>>           if (!cpu->map_base)
>>                   return -ENOMEM;
>>
>> +       request_mem_region(res.start, sz, res.name);
>> +
>>           for (i = 0; i < n_words; i++) {
>>                   cpu->enable_cache[i] = 0;
>>                   __raw_writel(0, cpu->map_base + reg_enable(intc, i));
>>
>> such that this shows up in /proc/iomem. WDYT?
> 
> I tried doing it that way, but it still shows (ptrval):
> [    0.000000] irq_bcm6345_l1: registered BCM6345 L1 intc (IRQs: 32)
> [    0.000000] irq_bcm6345_l1:   CPU0 at MMIO 0x(ptrval) (irq = 2)

Well yes, if you don't remove the pr_info() you are still going to be 
printing it, and because map_base is the return of ioremap() which is a 
kernel virtual address, it is still hashed, also see Marc's message that 
came in. I guess I should have been way more explicit and also provide a 
tentative patch that also took out the pr_info().

> 
> I checked /proc/iomem and it's shown:
> root@OpenWrt:/# cat /proc/iomem
> 00000000-03ffffff : System RAM
>    00010000-0068e96f : Kernel code
>    0068e970-008834ff : Kernel data
>    01610000-016458e7 : Kernel bss
> 08000000-0800ffff : BCM6348 PCI IO space
> 1e000000-1fffffff : 1e000000.nor nor@1e000000
> 30000000-37ffffff : pci@fffe1000
>    30000000-3000ffff : 0000:00:01.0
>      30000000-3000ffff : ath9k
> fffe0004-fffe0007 : fffe0004.clock-controller clock-controller@fffe0004
> fffe000c-fffe0013 : interrupt-controller@fffe000c
> fffe0034-fffe0037 : fffe0034.reset-controller reset-controller@fffe0034
> fffe005c-fffe0067 : fffe005c.watchdog watchdog@fffe005c
> fffe0100-fffe0117 : fffe0100.serial serial@fffe0100
> fffe1000-fffe11ff : fffe1000.pci pci
> fffe1300-fffe13ff : fffe1300.usb usb@fffe1300
> fffe1400-fffe14ff : fffe1400.usb usb@fffe1400
> fffe1500-fffe1537 : fffe1500.usb-phy usb-phy@fffe1500
> 
> Any idea why this could be hapenning?

We now have the desired resource listed using its physical address:

fffe000c-fffe0013 : interrupt-controller@fffe000c

There could be a variety of improvements to how request_mem_region() is 
called if you want to provide a break down of each resource on a per-CPU 
basis.
-- 
Florian

