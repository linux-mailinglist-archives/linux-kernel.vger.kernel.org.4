Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59B66B8430
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCMVqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCMVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:46:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD0763CB;
        Mon, 13 Mar 2023 14:46:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z6so14925243qtv.0;
        Mon, 13 Mar 2023 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678743997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qg96HiAT57XFTecYM41iXANMvUHpV28dRQiHinsiEo=;
        b=GmwTnojiuL6nlElWvIya25PHhq+xy+6j0ir/z4chS9VnT4TP8UbsN8chVcrb7OVVEg
         NUVipIQ7p3M71kfu4DqFYQvuj5+a4a6lMECKEvVp13mqIW/CvnC6yIzgN4jNxS7QH8t8
         7l0CmtzGwvL3jNewHQ3q3SluJvjinhMh7Na8bYZqs054giyZsEvy2ZZXcyFLawpW2ZQr
         EyfBr0Ep4SazhbcWtofV2bBP0P8Lou4uGwvWsiQBshCisK8aLasAK/SPCfqAlBobnpCr
         Cy5+07IYeOiHtbpC5PytJRgQaLeqEYtg0AYTI4r7+vYLGijRDW5VMoRAOng7n84EV9ED
         PeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678743997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qg96HiAT57XFTecYM41iXANMvUHpV28dRQiHinsiEo=;
        b=Hd3wOhtwA1nmiKJbzelLPT3g+ZGpft6QQ1fe3O4xZhoN/f/ZycaMTlys6Gx6x7KXi1
         CYg2iI3JmbTrr9krdgC0QYIFclQ3yhuiAjxFpbQOvoZ/0WvkgCYOxL3KJRiqZI9YbLLf
         hMyXJrivYyuf7tcUcqzjZhB7jXuVkqAc0SPGWCWcYxNfdfj5s82eCN06RoupAwHwR42t
         MvUpxcMO8juDDQCT7nYS4Hv4H6XhH9zeDuFC4WMD8dkBtnSqNWS4TSa45v4l6i+UJd8s
         /QQMrDsGnJavin+lVuCS0fH9OLQcYspaYwhsqlR2ew+CrP44soMAy2q86BRObTLpT4W1
         XiEA==
X-Gm-Message-State: AO0yUKVK9MGPlWhPRfi4OA1ZZrYc/Hnx2ZAyenoFHPD2fwbZEYHmclA9
        tyuMEvY6xVlLUH2+1nFzBLlRbYj91h8=
X-Google-Smtp-Source: AK7set9OT58xKY+oL2hgHBQOzh5j3oymtSbYMsyFl/eHZUeIXfbEsp7ZIjkVadFjtvhSlSX2NuIncw==
X-Received: by 2002:ac8:5bc8:0:b0:3bf:ced2:2ad with SMTP id b8-20020ac85bc8000000b003bfced202admr23465827qtb.19.1678743996912;
        Mon, 13 Mar 2023 14:46:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dt7-20020a05620a478700b00706b09b16fasm530163qkb.11.2023.03.13.14.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 14:46:36 -0700 (PDT)
Message-ID: <7517f1b0-2afb-7edf-a847-e839a410f46f@gmail.com>
Date:   Mon, 13 Mar 2023 14:46:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKR-sGcyMF26NGoeEApKuKDe6=14nCGKwRYx-o68LHAcmUNXhA@mail.gmail.com>
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

(please don't top post)

On 3/13/23 14:39, Álvaro Fernández Rojas wrote:
> Hi Florian,
> 
> I did another test changing from TP1 to TP0 and this is the result:
> [ 0.000000] Linux version 5.15.98 (noltari@atlantis)
> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
> [ 0.000000] bmips_cpu_setup: read_c0_brcm_config_0() = 0xe30e1006
> [ 0.000000] bmips_cpu_setup: BMIPS_RAC_CONFIG = 0x2a00015
> [ 0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
> 
> And there were no exceptions with EHCI/OHCI as opposed to TP1.
> So the issue is only happening when booting from TP1.

Ah, that explains it then, I was just about to ask you which TP was the 
kernel booted on.

> Maybe it's due to the fact that BCM6358 has a shared TLB?

I think it has to do with the fact that the BMIPS_RAC_CONFIG_1 is likely 
not enabling the RAC since that register pertains to TP1, could you dump 
its contents, and if they do not set bit 0 and/or 1, please set them and 
try again and see whether it works any better? The RAC provides 
substantial performance improvements, it would be a change to keep it 
disabled.

> 
> Maybe the correct way of solving the issue would be by adding the
> following code at bcm6358_quirks():
> if (read_c0_brcm_cmt_local() & (1 << 31))
>      bmips_dma_sync_disabled = 1;
> 
> BTW, if I understood it correctly, you want me to reverse the logic,
> so bmips_dma_sync_disabled instead of bmips_dma_sync_enabled.
> Is this correct?

Yes, I want the logic such that we need to set a variable to 1/true 
rather setting one to 0, less change to get it wrong IMHO.

> 
> Best regards,
> Álvaro.
> 
> 
> El lun, 13 mar 2023 a las 18:37, Florian Fainelli
> (<f.fainelli@gmail.com>) escribió:
>>
>> On 3/12/23 11:50, Álvaro Fernández Rojas wrote:
>>> Hi Florian,
>>>
>>> I tried what you suggested but it stil panics on EHCI:
>>>
>>> [    0.000000] Linux version 5.15.98 (noltari@atlantis)
>>> (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.2.0 r22187+1-19817fa3f5)
>>> 12.2.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Sun Mar 12 18:23:28 2023
>>> [    0.000000] bmips_cpu_setup: read_c0_brcm_config_0() = 0xe30e1006
>>> [    0.000000] bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG = 0x3c1b8041
>>> [    0.000000] CPU0 revision is: 0002a010 (Broadcom BMIPS4350)
>>>
>>> It looks like bit 29 is set so RAC should be present.
>>> And RAC_I seems to be set, but not RAC_D...
>>>
>>> BTW, this is what I added to bmips_cpu_setup:
>>>
>>> case CPU_BMIPS4350:
>>> cfg = read_c0_brcm_config_0();
>>> pr_info("bmips_cpu_setup: read_c0_brcm_config_0() = 0x%x\n", cfg);
>>>
>>> cfg = __raw_readl(cbr + BMIPS_RAC_CONFIG);
>>> pr_info("bmips_cpu_setup: cbr + BMIPS_RAC_CONFIG = 0x%x\n", cfg);
>>> __raw_writel(cfg | BIT(0) | BIT(1), cbr + BMIPS_RAC_CONFIG);
>>> __raw_readl(cbr + BMIPS_RAC_CONFIG);
>>> break;
>>
>> Thanks for running those experiments, I cannot explain what you are
>> seeing, so there must be some sort of erratum applicable to the
>> BMIPS4380 revision used on the 6358 somehow...
>>
>> If you can make the suggested change to use negative logic in order to
>> disable the RAC flushing, that would work for me, also maybe add a
>> Fixes: tag so it gets backported to stable trees?
>>
>> Thanks!
>> --
>> Florian
>>

-- 
Florian

