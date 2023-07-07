Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714F974ADC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjGGJ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGGJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:28:43 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64031BE8;
        Fri,  7 Jul 2023 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=198Ic8NzW8Fbs/Xun3gZbDNwGyTZWmBq6K6pN6bRECw=; b=TZnmsBMcarY8k2NGU0KOczzdYV
        8xFOqEUDvCDpqmo3OAUwd+B5CZkQQZ7Zn/HdDFjlIzAyVGK5twrkwgDaSfpTFaFJpUlgyZQplLWw9
        vjjbUZZKsIfex2ql0LQkfYI6iEs4aOudGlfirvuhk1Nzyd7F3Gf6wIMH//6K1KVhCcnhLNDNFlEHH
        nk9N84duWmXUR4mJHKSQD5MOdeXeehFRcSfvcC7MoHGZd/8yGBTGJe2Fw5eESGlyDlXyfVod0Ri/n
        AkGEFe1C1WomvH6z8myrhJkdmouT+oiJyHpMkZuEqwT1y60FpRKeUFanju/dpjEMNeSkOEV5ZdwOH
        H11NsDyA==;
Received: from [89.212.21.243] (port=43232 helo=[192.168.69.84])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qHhlO-004Ydy-0v;
        Fri, 07 Jul 2023 11:28:29 +0200
Message-ID: <67f953cd-af17-2a5c-6a1f-ac902c1636ce@norik.com>
Date:   Fri, 7 Jul 2023 11:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6: pfla02: Fix SD card reboot problem
Content-Language: en-GB
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     devicetree@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        upstream@phytec.de
References: <20230704080304.816942-1-andrej.picej@norik.com>
 <20230704080304.816942-3-andrej.picej@norik.com>
 <20230704081712.7dyj2mspj2m25rp7@pengutronix.de>
 <7ed6fde0-37a4-a667-2629-0a6b8a202a69@norik.com>
 <14cd16df-ef47-05b3-5266-ffff109a8326@pengutronix.de>
 <3c0de35f-915a-7ae9-c369-9545b55dd2e4@norik.com>
 <6a2e5b14-c5d3-b384-2539-033381768dca@norik.com>
 <e9a08364-c277-bfec-cb31-b01b39e17bed@pengutronix.de>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <e9a08364-c277-bfec-cb31-b01b39e17bed@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5. 07. 23 14:06, Ahmad Fatoum wrote:
> On 05.07.23 12:39, Andrej Picej wrote:> On 5. 07. 23 10:40, Andrej Picej wrote:
>>> On 5. 07. 23 10:30, Ahmad Fatoum wrote:
>>>> On 05.07.23 10:28, Andrej Picej wrote:
>>>>> I think the main reason for a failed boot is that the PMIC doesn't get reset and that the bootloader doesn't specifically enable the SD card regulator.
>>>>>
>>>>> Could this patch still be applied or should we put the fix in reset routine/bootloader?
>>>>
>>>> Is SD-Card not main boot medium? From your description, I thought BootROM
>>>> will fail to boot before bootloader has a chance to do anything about it.
>>>>
>>>
>>> Yes sorry, you are absolutly right, the BootROM fails. It confused me because I could see the booloader booting, but it was from one of the fallback mediums. So I guess fixing the bootloader is not really an option.
>>> Sorry for the confusion.
>>>
>>
>> Ok, the main problem is well known, that's why PHYTEC disables the imx watchdog and uses a PMIC one for the reboot handler. This one resets the board completely. The SD card regulator problem is really just the manifestation of that bug. Unfortunately I didn't noticed that. :(
>>
>> I will create a v2 with a proper fix, where imx watchdog gets disabled.
> 
> I'd be wary about solving it this way at the DTSI level, because it can
> break existing users:
> 
>    - Boot flow depends on reading boot reason, but with PMIC reset, everything
>      is power-on reset
> 
>    - Bootloader starts i.MX watchdog, but new kernel will service only
>      PMIC watchdog leading to system reset
> 
>    - Even if updating bootloader and kernel together, fallback of kernel
>      may end up that bootloader uses PMIC watchdog, but kernel uses i.MX
>      watchdog
> 
>    - There can be valid reasons to use both watchdogs and disabling
>      one at the SoM level breaks that
> > I had a similar issue once (Board controller reset to be used instead 
of SoC
> reset) and settled on using the barebox watchdog-priority/restart-priority[1]
> binding to select the "better" watchdog and then fixed up this choice into
> the kernel command line (barebox CONFIG_SYSTEMD_OF_WATCHDOG).
> 
> If you decide to fix it for the evaluation kits, please add some text
> into the commit message that this fix should not be backported to older kernels.
> While it's ultimately the correct thing to do, changing this is IMO not stable
> backport material.
> 
> [1]: FWIW, there was past discussion about adding restart priorities to Linux, e.g.
> https://lore.kernel.org/all/20201006102949.dbw6b2mrgt2ltgpw@pengutronix.de/

Ok I see the problems this might raise. Nevertheless I think it would be 
good to sync upstream and PHYTEC downstream dts with this fix. Since by 
default imx watchdog reset is really a no-go with phyFLEX.
We could add the aliases for the watchdogs, marking the PMIC watchdog as 
watchdog0, and imx watchdog as watchdog1 which I think should tell the 
kernel to use the PMIC reboot handler, but not really sure how is that 
any better then disabling the imx watchdog.

Why do you think this shouldn't be backported to older kernels? Because
someone might use this with "not compatible" bootloader?

Thanks for your help,
Andrej

> 
> Cheers,
> Ahmad
> 
>>
>> Thanks for your help,
>> Andrej
>>
>>
>>>
>>>>>
>>>>> Best regards,
>>>>> Andrej
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>      Marco
>>>>>>
>>>>>>>                 };
>>>>>>>                   vdd_sd1_reg: ldo10 {
>>>>>>> -- 
>>>>>>> 2.25.1
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>>
>>
> 
