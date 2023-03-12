Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744AF6B682A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCLQTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCLQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:18:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEC734F6E;
        Sun, 12 Mar 2023 09:17:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nn1-20020a17090b38c100b0023d059f427cso495373pjb.2;
        Sun, 12 Mar 2023 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678637800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/euGLr2kNf1BD3rSEK7yIgr0KvogjaCLJIxVWWMM9Os=;
        b=Fgu6aKo3PTrxHShYzf+69AjAudptePajwX9xzzoKJGphQ/R2aTEJvkjmGZeoJzEAEj
         XUQYOyoEDCqQQe998FtuKPVBY/7qqMb9HLnC7HiWF/dpVf4ZiyoGipunm8/1P+6BmU5P
         uBu1f5QHb4P2tSCGWbzIpU4n+Aj4p49hmCEhdoEOo/vZLSYr4q4lRpbF+M3MGThLSMQM
         Qgr6ZBu3jM4sO/RGp12PNgn0cnXo3jcv1C8ad1cmQ9pAnf65WWvkkTliSZFKRGpFuLJc
         cp9DCXhtkkX6Z6EEbKsvrMVabWeMH5ih5VVPmBEqcPesY8uhJf9bYFXW1CmBroXadd2c
         FOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678637800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/euGLr2kNf1BD3rSEK7yIgr0KvogjaCLJIxVWWMM9Os=;
        b=bR54wSuRB01uTjpNYD2rL1OCKmXPHmI1QvwKfY0YXZ4kFf9eLzQuBsO2o/phaohhDb
         jQ3a2HP1yx++KwDSa1dSN46NdCHA7GQTvAvd6almhSsyWOSYgmawiG5hjbsRfIKxhKR1
         vkWfpRB7QwAIw5m2Opc2XQG0lF7y49u0GMz1Wcam5K688z81KKQnP3HGxxH/WSz2Fr4Q
         /sRR9+VrK29Oxj9OWPRej00s9Ud3Ik0qcVOJd5YDzJVRnxRq9+DEuZmmWDDqTve6fA1e
         9L/SgrBSUDGanEKRiKQVe5odykyG5Q1B09jh2JQU8f3qQcC3c/wPgcxtNObCWeJ4iqaA
         KWrQ==
X-Gm-Message-State: AO0yUKV5B1G5gu76teNZyzwDx2SkmmzFGA8PnoALuYCjYQTdfDVhxRTC
        WzisFzCnDRHVG7J4tQV5L5Y=
X-Google-Smtp-Source: AK7set/UWWBQw/svTTBnUHbzlG3aSGuX57aDPuzmlsmwKv7GrC9uhXALN2FOoMk+tnWk1gqKRz5GnQ==
X-Received: by 2002:a17:903:32c3:b0:1a0:4423:b1bd with SMTP id i3-20020a17090332c300b001a04423b1bdmr1671611plr.7.1678637800258;
        Sun, 12 Mar 2023 09:16:40 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b0019ac9c9ce16sm3021055plg.138.2023.03.12.09.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 09:16:39 -0700 (PDT)
Message-ID: <a88fc41b-69d3-b042-fa91-e403d1263742@gmail.com>
Date:   Sun, 12 Mar 2023 09:16:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310121306.4632-1-noltari@gmail.com>
 <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
 <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
 <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/2023 11:31 PM, William Zhang wrote:
> 
> 
> On 03/11/2023 11:44 AM, Jonas Gorski wrote:
>> On Sat, 11 Mar 2023 at 18:32, Florian Fainelli <f.fainelli@gmail.com> 
>> wrote:
>>>
>>>
>>>
>>> On 3/10/2023 4:13 AM, Álvaro Fernández Rojas wrote:
>>>> arch_sync_dma_for_cpu_all() causes kernel panics on BCM6358 with 
>>>> EHCI/OHCI:
>>>> [    3.881739] usb 1-1: new high-speed USB device number 2 using 
>>>> ehci-platform
>>>> [    3.895011] Reserved instruction in kernel code[#1]:
>>>> [    3.900113] CPU: 0 PID: 1 Comm: init Not tainted 5.10.16 #0
>>>> [    3.905829] $ 0   : 00000000 10008700 00000000 77d94060
>>>> [    3.911238] $ 4   : 7fd1f088 00000000 81431cac 81431ca0
>>>> [    3.916641] $ 8   : 00000000 ffffefff 8075cd34 00000000
>>>> [    3.922043] $12   : 806f8d40 f3e812b7 00000000 000d9aaa
>>>> [    3.927446] $16   : 7fd1f068 7fd1f080 7ff559b8 81428470
>>>> [    3.932848] $20   : 00000000 00000000 55590000 77d70000
>>>> [    3.938251] $24   : 00000018 00000010
>>>> [    3.943655] $28   : 81430000 81431e60 81431f28 800157fc
>>>> [    3.949058] Hi    : 00000000
>>>> [    3.952013] Lo    : 00000000
>>>> [    3.955019] epc   : 80015808 setup_sigcontext+0x54/0x24c
>>>> [    3.960464] ra    : 800157fc setup_sigcontext+0x48/0x24c
>>>> [    3.965913] Status: 10008703       KERNEL EXL IE
>>>> [    3.970216] Cause : 00800028 (ExcCode 0a)
>>>> [    3.974340] PrId  : 0002a010 (Broadcom BMIPS4350)
>>>> [    3.979170] Modules linked in: ohci_platform ohci_hcd 
>>>> fsl_mph_dr_of ehci_platform ehci_fsl ehci_hcd gpio_button_hotplug 
>>>> usbcore nls_base usb_common
>>>> [    3.992907] Process init (pid: 1, threadinfo=(ptrval), 
>>>> task=(ptrval), tls=77e22ec8)
>>>> [    4.000776] Stack : 81431ef4 7fd1f080 81431f28 81428470 7fd1f068 
>>>> 81431edc 7ff559b8 81428470
>>>> [    4.009467]         81431f28 7fd1f080 55590000 77d70000 77d5498c 
>>>> 80015c70 806f0000 8063ae74
>>>> [    4.018149]         08100002 81431f28 0000000a 08100002 81431f28 
>>>> 0000000a 77d6b418 00000003
>>>> [    4.026831]         ffffffff 80016414 80080734 81431ecc 81431ecc 
>>>> 00000001 00000000 04000000
>>>> [    4.035512]         77d54874 00000000 00000000 00000000 00000000 
>>>> 00000012 00000002 00000000
>>>> [    4.044196]         ...
>>>> [    4.046706] Call Trace:
>>>> [    4.049238] [<80015808>] setup_sigcontext+0x54/0x24c
>>>> [    4.054356] [<80015c70>] setup_frame+0xdc/0x124
>>>> [    4.059015] [<80016414>] do_notify_resume+0x1dc/0x288
>>>> [    4.064207] [<80011b50>] work_notifysig+0x10/0x18
>>>> [    4.069036]
>>>> [    4.070538] Code: 8fc300b4  00001025  26240008 <ac820000> 
>>>> ac830004  3c048063  0c0228aa  24846a00  26240010
>>>> [    4.080686]
>>>> [    4.082517] ---[ end trace 22a8edb41f5f983b ]---
>>>> [    4.087374] Kernel panic - not syncing: Fatal exception
>>>> [    4.092753] Rebooting in 1 seconds..
>>>
>>> Did you pinpoint which specific instruction within
>>> arch_sync_dma_for_cpu_all() is causing the reserved instruction 
>>> exception?
>>
>> It's setup_sigcontext(), not arch_sync_dma_for_cpu_all() that's
>> causing the exception ;-)
>>
>> Hand decoding the Code gives me
>>
>> lw $1, 0xb4($fp)
>> or $v0, 0, 0
>> addiu $a0, $s1, 8
>> sw $v0, 0($a0) <- the code in brackets, so I guess EPC?
>> sw $v1, 4($a0)
>>
>> which I assume is this part:
>>
>> err |= __put_user(regs->cp0_epc, &sc->sc_pc);
>>
>> (0xb4 is the offset of cp0_epc, 0x8 the offset of sc_pc)
>>
>> One thing I see is that we do the RAC flush for BMIPS3300, 4350 and
>> 4380, but only initialize it for 3300 [1], but leave it at whatever
>> state the bootloader did for the other ones. Maybe it has some invalid
>> config in (that particuar?) 6358 that triggers issues later on after a
>> flush? E.g. the flush puts it in an error state, and the next time
>> something triggers a prefetch(write?) (by trying to access userspace)
>> it generates an error exception.
>>
> Depending on the bootloader but likely bootloader does not use RAC at 
> all.  So agree that RAC may not be properly initialized when the flush 
> function is called and push the stale data to corrupt memory and cause 
> problem later on the userspace.

Alvaro, could you do the following and let us know the results, at boot 
time in bcm6358_quirks():

- issue a read_c0_brcm_config_0() and look whether bit 29 (RAC present) 
is set, if it is not set, then we should forcibly disable the use of the 
RAC using a flag

- issue a __raw_readl(cbr + BMIPS_RAC_CONFIG) and check whether bits 0 
(RAC_I) or 1 (RAC_D) are set, if not, try to set them and see whether it 
works

Thanks!
-- 
Florian
