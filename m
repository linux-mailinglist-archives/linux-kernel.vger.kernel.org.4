Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C915671064
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjARBqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjARBqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:46:50 -0500
Received: from progateway7-pub.mail.pro1.eigbox.com (gproxy5-pub.mail.unifiedlayer.com [67.222.38.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB62C66D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:46:49 -0800 (PST)
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by progateway7.mail.pro1.eigbox.com (Postfix) with ESMTP id 94C831004818A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:46:48 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id HxXMpObGgnQzLHxXMpuyFb; Wed, 18 Jan 2023 01:46:48 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Q8oXX66a c=1 sm=1 tr=0 ts=63c74f88
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=RvmDmJFTN0MA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=j6bprNooAAAA:8
 a=VwQbUJbxAAAA:8 a=k-0BSgzrAAAA:8 a=8pif782wAAAA:8 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=fKPdyXKGdRffcDw4d2UA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=ABifrie-J5MA:10:uccc_2email_address a=fS_Hu1hw59wj44055X5l:22
 a=AjGcO6oz07-iQ99wixmX:22 a=IbN6WrKXhHvVD0qv-cjL:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=icgEua7ZisqWoh1buhiqS6oOGBZ/RXFOAmFuObwimdY=; b=zktliHvR59KFTfKEiJBmtH+tGK
        tJOcn0wJcoyO0bcNEVwh05VxHhiROR9HEPdS4UN2ixN5xjUNgw9douYccGMzWu8aV4yjD1GmNt4we
        9gGz3JxJjL0n74OcULqGxpMtNGC+Z3s8KKLsj6gSaUgE2P/ZBjBxO0yZ7AIp77pvPPj9gvI0HLzIs
        HeeiuITEHFK67taZY7t1cv6lJUaE0Z7kfpHWwYZJTsyhWQaC0cPJYUxINnUwp2hr6lAV9ErBJHEcJ
        KSB82gqBgM4oqjn7Wv0aWVvcuNryvV1fqvowheze1k5bGTEDba5xO87RUa4/4IFyH9rPNOimHT559
        8MtjSAgg==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:51822 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <re@w6rz.net>)
        id 1pHxXL-0024Sn-Ft;
        Tue, 17 Jan 2023 18:46:47 -0700
Subject: Re: [PATCH 0/2] Change PWM-controlled LED pin active mode and
 algorithm
From:   Ron Economos <re@w6rz.net>
To:     Nylon Chen <nylon.chen@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20230113083115.2590-1-nylon.chen@sifive.com>
 <Y8GjySjm9OjoZvCF@spud> <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
 <CAHh=Yk-WJMOc-h9V47CyMQpyXZ5hDrtOPnPE2QKkJKzMhjh+Cg@mail.gmail.com>
 <eb1ce3b1-309f-ca1c-f24b-bdbcfa7c494b@w6rz.net>
Message-ID: <c0866553-d1a0-c76f-dea1-db3efceb7129@w6rz.net>
Date:   Tue, 17 Jan 2023 17:46:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <eb1ce3b1-309f-ca1c-f24b-bdbcfa7c494b@w6rz.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1pHxXL-0024Sn-Ft
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:51822
X-Source-Auth: re@w6rz.net
X-Email-Count: 6
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 7:08 AM, Ron Economos wrote:
> On 1/17/23 1:32 AM, Nylon Chen wrote:
>> Hi Conor, Jessica
>>
>> thanks for your reply.
>>
>> Jessica Clarke <jrtc27@jrtc27.com> 於 2023年1月14日 週六 上午3:24寫道：
>>> On 13 Jan 2023, at 18:32, Conor Dooley <conor@kernel.org> wrote:
>>>> +CC Uwe, Thierry, linux-pwm
>>>>
>>>> Hey Nylon,
>>>>
>>>> Please run scripts/get_maintainer.pl before sending patches, you 
>>>> missed
>>>> both me & the PWM maintainers unfortunately!
>>>> AFAIK, the PWM maintainers use patchwork, so you will probably have to
>>>> resend this patchset so that it is on their radar.
>>>> I've marked the series as "Changes Requested" on the RISC-V one.
>> I got it. I will base it on get_maintainer.pl, re-sent it.
>>>> On Fri, Jan 13, 2023 at 04:31:13PM +0800, Nylon Chen wrote:
>>>>
>>>>> According to the circuit diagram of User LEDs - RGB described in the
>>>>> manual hifive-unmatched-schematics-v3.pdf[0].
>>>>> The behavior of PWM is acitve-high.
>>>>>
>>>>> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
>>>>> Manual[1].
>>>>> The pwm algorithm is (PW) pulse active time  = (D) duty * (T) 
>>>>> period[2].
>>>>> The `frac` variable is pulse "inactive" time so we need to invert it.
>>>>>
>>>>> So this patchset removes active-low in DTS and adds reverse logic to
>>>>> the driver.
>>>>>
>>>>> [0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatched/hifive-unmatched-schematics-v3.pdf 
>>>>>
>>>>> [1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatched/fu740-c000-manual-v1p2.pdf 
>>>>>
>>>>> [2]:https://en.wikipedia.org/wiki/Duty_cycle
>>>> Please delete link 2, convert the other two to standard Link: tags and
>>>> put this information in the dts patch. Possibly into the PWM patch 
>>>> too,
>>>> depending on what the PWM maintainers think.
>> I got it. I will fix it.
>>>> This info should be in the commit history IMO and the commit 
>>>> message for
>>>> the dts patch says what's obvious from the diff without any 
>>>> explanation
>>>> as to why.
>>>>
>>>> I did a bit of looking around on lore, to see if I could figure out
>>>> why it was done like this in the first place, and I found:
>>>> https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com/ 
>>>>
>>> That DTS documentation makes no sense to me, why does what the LED is
>>> wired to matter? Whether you have your transistor next to ground or
>>> next to Vdd doesn’t matter, what matters is whether the transistor is
>>> on or off. Maybe what they mean is whether the *PWM's output* / *the
>>> transistor's input* is pulled to ground or Vdd? In which case the
>>> property would indeed not apply here.
>>>
>>> Unless that’s written assuming the LED is wired directly to the PWM, in
>>> which case it would make sense, but that’s a very narrow-minded view of
>>> what the PWM output is (directly) driving.
>>>
>>> Jess
>>>
>> This is a HiFive Unmatched/Unleashed LED-PWM layout
>>
>>              VDD
>>                 |
>>                 |
>>             _____
>>             \        /   LED
>>              \     /
>>                ---
>>                 |
>>                 |
>>                 |
>>           ______
>>          |              |
>>          -             |
>>          ^    -->    |------ PWM
>>          |___|___|
>>                 |
>>                 |
>>                __
>>                 -
>>              GND
>>
>> - the waveform
>> e.g. duty=30s, period=100s, actvie-high = 30%, active-low = 70%
>>
>> V
>> ^
>> |
>> | ----------|
>> |             |
>> |             |
>> |______ |__________ > t
>>
>> When VCC is high, the LED will be illuminated, which is an active-high
>> logic. This is why we need to remove "active-low".
>>
>> So, according to my understanding, Unleashed's DTS should also remove
>> active-low.
>>>> That doesn't explain the driver, but it does explain the dts being 
>>>> that
>>>> way. Perhaps a Fixes tag is also in order? But only if both patches 
>>>> get
>>>> one, otherwise backporting would lead to breakage.
>>>>
>>>> The min() construct appears to have been there since the RFC driver 
>>>> was
>>>> first posted.
>>>>
>>>> Thanks,
>>>> Conor.
>>>>
>>>>> Nylon Chen (2):
>>>>>   riscv: dts: sifive unmatched: Remove PWM controlled LED's 
>>>>> active-low
>>>> nit: s/sifive unmatched:/sifive: unmatched:/
>> I got it. I will fix it.
>>
>>>>>     properties
>>>>>   pwm: sifive: change the PWM controlled LED algorithm
>>>>>
>>>>> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
>>>>> drivers/pwm/pwm-sifive.c                            | 1 +
>>>>> 2 files changed, 1 insertion(+), 4 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.36.1
>
> I've tested this patch. For some reason, the heartbeat function no 
> longer works for D12. This is my /etc/udev/rules.d/99-pwm-leds.rules 
> file contents:
>
> # D12 LED: heartbeat
> SUBSYSTEM=="leds", KERNEL=="d12", ACTION=="add", 
> ATTR{trigger}="heartbeat"
>
> # D2 RGB LED: boot status
> SUBSYSTEM=="leds", KERNEL=="d2", ACTION=="add", 
> ATTR{trigger}="default-on", ATTR{multi_intensity}="25 25 25"
>
> This is from https://github.com/sifive/meta-sifive, but modified for 
> the multi_intensity driver introduced in Linux 6.0.
>
I've instrumented this patch with some printks. The reason the heartbeat 
doesn't work is that setting the LEDs to maximum brightness causes the 
variable "frac" to be set to -1 instead of 0.

You can test it with:

# /bin/echo "255" > /sys/class/leds/d12/brightness


