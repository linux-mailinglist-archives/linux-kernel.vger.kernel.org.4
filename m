Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849AF6BD748
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCPRlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCPRlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:41:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045ABCFCA;
        Thu, 16 Mar 2023 10:40:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso6232594pjf.0;
        Thu, 16 Mar 2023 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678988417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnLT3w3MddT1FeU+yFD8gqkc17TpH98T7IaFk8jMiuk=;
        b=A522MBa9ryjX761nW+71GjDjKYGiIKHWptxTWoLKOtkAQhKCK/vraNVWKsi2q2Cv9z
         IflKUMiGMS67v7WUk9czaRDi1K6fyWxt54iYTf3f+A6t4uCK8myIjPuQFZpJkf/5OBXn
         LIlxsQqHQf+mNjvXy2jFZn52EKQ+ZjfqVVl0gkc2BGZzZFkmCzlzAqajTSofgWp6vol2
         bD+CUUOO0NWD84SS/YQMVpZ9VJ0a219ZDWG9D8/QfkKkm+wsxZV/7di9onO0SAwiuNuI
         haJJbvZLDnpwVn7JnIXHPbQRtQoN9XCGA9V5ycuMRoUNp2ppN7gGO6Mxcx4wxwd3uq3t
         zGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnLT3w3MddT1FeU+yFD8gqkc17TpH98T7IaFk8jMiuk=;
        b=vWZFrYwzkuQC+HyDKOlYvGM2H9zu8BiwpBQRQ80BbVMKN7hUru5RplZvp16TW2ax2C
         Qwa7GNVjopYWKHyNu7ciZNW5mSYTQQF5pOx8H+bUVKuCuDgF0oZjqI+PLz0ydw1gg0m8
         TX1SZGEUi89aVuVzfQmz8pjspVsczhcBPvmTgFVD+ws+x3dnJAJUs5UXPgmeYkQZhDYP
         rOHDWzGfH2C824+ntm0/KzvnL3mkz+2uTAgoiL5jNnz6qgxFBpNRd8hPMRprw5SO0+7X
         T5LGVrT/UUCakq5vGNLDBDI1kkYmr/wF+SnPux4cOSMjqyqDvwSLUnWm2MB2iSlSF5HX
         YFzg==
X-Gm-Message-State: AO0yUKVHPFRMCyY3Dqi4RqrsxYLVkC34SHhIkzr24NbtWqkd/pbVJFdQ
        M4OtQf7D8rKfDrehXAIE6I+i1pclq1A=
X-Google-Smtp-Source: AK7set9kh6aca4zZSdEU93VoALZWhpFld2TQbqwAcIVZHGekqVMhgMPTiYNMpbMACQS2cFEFXA1aGw==
X-Received: by 2002:a05:6a20:bf02:b0:d0:4297:c698 with SMTP id gc2-20020a056a20bf0200b000d04297c698mr4380556pzb.9.1678988416446;
        Thu, 16 Mar 2023 10:40:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f24-20020aa78b18000000b005898fcb7c1bsm5885178pfd.177.2023.03.16.10.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:40:15 -0700 (PDT)
Message-ID: <fd4cb74c-3a8e-c9c0-f9ac-312fb916275c@gmail.com>
Date:   Thu, 16 Mar 2023 10:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310121306.4632-1-noltari@gmail.com>
 <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
 <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
 <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com>
 <a88fc41b-69d3-b042-fa91-e403d1263742@gmail.com>
 <CAKR-sGfL5_VU9uxJHGyZ-bj2P_7R6+OOfWs6Yf-ihcCF8bD2MA@mail.gmail.com>
 <e3cff853-8d5d-acdf-8e6a-3322c4de2023@gmail.com>
 <CAKR-sGcyMF26NGoeEApKuKDe6=14nCGKwRYx-o68LHAcmUNXhA@mail.gmail.com>
 <7517f1b0-2afb-7edf-a847-e839a410f46f@gmail.com>
 <CAKR-sGdOeg185sPFi0nwDxd6Fjx_SxyBgvtmFEiO9Y_50Wf2Bw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKR-sGdOeg185sPFi0nwDxd6Fjx_SxyBgvtmFEiO9Y_50Wf2Bw@mail.gmail.com>
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

On 3/14/23 11:14, Álvaro Fernández Rojas wrote:
> Hi Florian,
> 
> El lun, 13 mar 2023 a las 22:46, Florian Fainelli
> (<f.fainelli@gmail.com>) escribió:
>>
>> (please don't top post)
>>
>> On 3/13/23 14:39, Álvaro Fernández Rojas wrote:
>>> Hi Florian,
>>>
>>> I did another test changing from TP1 to TP0 and this is the result:
>>> [ 0.000000] Linux version 5.15.98 (noltari@atlantis)
>>> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
>>> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
>>> [ 0.000000] bmips_cpu_setup: read_c0_brcm_config_0() = 0xe30e1006
>>> [ 0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG = 0x2a00015
>>> [ 0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
>>>
>>> And there were no exceptions with EHCI/OHCI as opposed to TP1.
>>> So the issue is only happening when booting from TP1.
>>
>> Ah, that explains it then, I was just about to ask you which TP was the
>> kernel booted on.
>>
>>> Maybe it's due to the fact that BCM6358 has a shared TLB?
>>
>> I think it has to do with the fact that the BMIPS_RAC_CONFIG_1 is likely
>> not enabling the RAC since that register pertains to TP1, could you dump
>> its contents, and if they do not set bit 0 and/or 1, please set them and
>> try again and see whether it works any better? The RAC provides
>> substantial performance improvements, it would be a change to keep it
>> disabled.
> 
> This is the code that I added to bmips_cpu_setup():
>      case CPU_BMIPS4350:
>          cfg = read_c0_brcm_cmt_local();
>          pr_info("bmips_cpu_setup: read_c0_brcm_cmt_local() = 0x%x\n", cfg);
> 
>          cfg = read_c0_brcm_config_0();
>          pr_info("bmips_cpu_setup: read_c0_brcm_config_0() = 0x%x\n", cfg);
> 
>          cfg = __raw_readl(cbr + BMIPS_RAC_ADDRESS_RANGE);
>          pr_info("bmips_cpu_setup: BMIPS_RAC_ADDRESS_RANGE = 0x%x\n", cfg);
> 
>          cfg = __raw_readl(cbr + BMIPS_L2_CONFIG);
>          pr_info("bmips_cpu_setup: BMIPS_L2_CONFIG = 0x%x\n", cfg);
> 
>          cfg = __raw_readl(cbr + BMIPS_LMB_CONTROL);
>          pr_info("bmips_cpu_setup: BMIPS_LMB_CONTROL = 0x%x\n", cfg);
> 
>          cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
>          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG = 0x%x\n", cfg);
>          __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
>          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG = 0x%x\n", cfg);
>          __raw_readl(cbr + BMIPS_RAC_CONFIG);
> 
>          cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG_1);
>          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG_1 = 0x%x\n", cfg);
>          __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG_1);
>          pr_info("bmips_cpu_setup: BMIPS_RAC_CONFIG_1 = 0x%x\n", cfg);
>          __raw_readl(cbr + BMIPS_RAC_CONFIG_1);
>          break;
> 
> And this is the result:
> [    0.000000] bmips_cpu_setup: read_c0_brcm_cmt_local() = 0x80000000

OK, so we are executing from TP1, but we knew that already.

> [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() = 0xe30e1006

bit 31: instruction cache enabled
bit 30: data cache enabled
bit 29: RAC present
bit 25: DSU power enabled
bit 24: data cache power enabled
bit 19: low-latency memory bus (LMB) present
bit 18: concurrent multi threading (CMT) present
bit 17: reserved
bit 12: split instruction cache
bit 2: number of Hi/Lo special registers - 1
bit 1: eDSP present

This seems to match the recommended and default values

> [    0.000000] bmips_cpu_setup: BMIPS_RAC_ADDRESS_RANGE = 0x277bdab0

That does not look intended, the reset value is supposed to be 0. Can 
you apply the same values as the ones programmed in the CPU_BMIPS_3300 case?

> [    0.000000] bmips_cpu_setup: BMIPS_L2_CONFIG = 0x241a0008


> [    0.000000] bmips_cpu_setup: BMIPS_LMB_CONTROL = 0x0

LMB not enabled, that's OK.

> [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG = 0x3c1b8041
> [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG = 0x3c1b8041
> [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG_1 = 0x3600008
> [    0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG_1 = 0x3600008
> 
> As you can see the bit's aren't set and all the registers appear to
> have strange values and not the usual ones when initialized by the
> bootloader...

Yes, so maybe the best way to go about is indeed to go with your change 
such that if we are running on TP1, it is safe to assume that CFE has 
not done any sensible initialization, and we have a non functional RAC.

> 
>>
>>>
>>> Maybe the correct way of solving the issue would be by adding the
>>> following code at bcm6358_quirks():
>>> if (read_c0_brcm_cmt_local() & (1 << 31))
>>>       bmips_dma_sync_disabled = 1;
>>>
>>> BTW, if I understood it correctly, you want me to reverse the logic,
>>> so bmips_dma_sync_disabled instead of bmips_dma_sync_enabled.
>>> Is this correct?
>>
>> Yes, I want the logic such that we need to set a variable to 1/true
>> rather setting one to 0, less change to get it wrong IMHO.
>>
>>>
>>> Best regards,
>>> Álvaro.
>>>
>>>
>>> El lun, 13 mar 2023 a las 18:37, Florian Fainelli
>>> (<f.fainelli@gmail.com>) escribió:
>>>>
>>>> On 3/12/23 11:50, Álvaro Fernández Rojas wrote:
>>>>> Hi Florian,
>>>>>
>>>>> I tried what you suggested but it stil panics on EHCI:
>>>>>
>>>>> [    0.000000] Linux version 5.15.98 (noltari@atlantis)
>>>>> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
>>>>> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
>>>>> [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() = 0xe30e1006
>>>>> [    0.000000] bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG = 0x3c1b8041
>>>>> [    0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
>>>>>
>>>>> It looks like bit 29 is set so RAC should be present.
>>>>> And RAC_I seems to be set, but not RAC_D...
>>>>>
>>>>> BTW, this is what I added to bmips_cpu_setup:
>>>>>
>>>>> case CPU_BMIPS4350:
>>>>> cfg = read_c0_brcm_config_0();
>>>>> pr_info("bmips_cpu_setup: read_c0_brcm_config_0() = 0x%x\n", cfg);
>>>>>
>>>>> cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
>>>>> pr_info("bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG = 0x%x\n", cfg);
>>>>> __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
>>>>> __raw_readl(cbr + BMIPS_RAC_CONFIG);
>>>>> break;
>>>>
>>>> Thanks for running those experiments, I cannot explain what you are
>>>> seeing, so there must be some sort of erratum applicable to the
>>>> BMIPS4380 revision used on the 6358 somehow...
>>>>
>>>> If you can make the suggested change to use negative logic in order to
>>>> disable the RAC flushing, that would work for me, also maybe add a
>>>> Fixes: tag so it gets backported to stable trees?
>>>>
>>>> Thanks!
>>>> --
>>>> Florian
>>>>
>>
>> --
>> Florian
>>
> 
> Álvaro

-- 
Florian

