Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517F36545C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiLVR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiLVR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:56:07 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082162876B;
        Thu, 22 Dec 2022 09:56:05 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BMHtojr030741;
        Thu, 22 Dec 2022 11:55:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671731750;
        bh=HEPNELefQY8vutwbS0sibDLyacHcL0+Y8msG5+P4E+M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=wTc4sdpHCm+iPiR/Ab41EKgGo47UJhvf5ULbwujKxJqbn7RBH9nZAYnfsR7Fcn7B0
         f/g6DClbCUeYWgFchIZgUdufRpjXLo8B0RxaT6JHl0VwJmFFjfrM2UrmEYe8ssMx7d
         fGwJu7ylUWSZ7PQi9+hCUD9FwO82gNHBnc2mT1W4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BMHtocF017816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Dec 2022 11:55:50 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 22
 Dec 2022 11:55:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 22 Dec 2022 11:55:50 -0600
Received: from [10.250.232.188] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BMHtkjH040419;
        Thu, 22 Dec 2022 11:55:46 -0600
Message-ID: <d8aaea9b-dc3a-66ba-6bd3-e400be204013@ti.com>
Date:   Thu, 22 Dec 2022 23:25:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: Add support for J784S4 EVM board
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
References: <20221116130428.161329-1-a-nandan@ti.com>
 <20221116130428.161329-5-a-nandan@ti.com>
 <b57433e7-b309-bd1c-f794-3da74021f03c@ti.com>
 <20221118174754.y37pq77drvla2uxj@tinderbox>
 <8c123fa2-caab-d2dd-5eb4-688f1c6abb33@ti.com>
 <20221118180808.wnel7d6gswsnooww@junkman>
 <93242211-95e7-09a0-fced-5ef2deb9fc08@ti.com>
 <20221118192744.wish2vrxgy7dg7c2@unnerving>
 <3d5e41f6-16a8-4298-ccd3-6db60f94eb47@ti.com>
 <20221118221534.52rfyf5gsck3xrrb@sauciness>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20221118221534.52rfyf5gsck3xrrb@sauciness>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/11/22 03:45, Nishanth Menon wrote:
> On 15:08-20221118, Andrew Davis wrote:
>> On 11/18/22 1:27 PM, Nishanth Menon wrote:
>>> On 12:15-20221118, Andrew Davis wrote:
>>>> I don't see either of those addressed in that thread, only that
>>>> the aliases should go in the .dts files and be trimmed, nothing
>>> Key is trimmed to what the system and ecosystem needs.
>>>
>>>> stops us from:
>>>>
>>>> chosen {
>>>> 	stdout-path = "serial10:115200n8";
>>>> };
>>>>
>>>> aliases {
>>>> 	serial10 = &main_uart8;
>>>> };
>>> Do we need 10 serial aliases? There are'nt 10 serial ports exposed in
>>> j782s2. ok - lets say we do this, then: [1] is needed to boot? but why
>>> do we need to do that for all armv8 platforms when aliases allows us
>> Why do we need SERIAL_8250_NR_UARTS at all, might be a better question.
>> These should be dynamically allocated if the number goes over the
>> default count imposed by the TTY framework. Maybe folks are still a
>> bit too afraid to touch the TTY subsystem core, I don't blame them..
>>
>>> to trim it to just the 3 or 4 serial ports the platform really needs
>>> That + being able to use the convention that serial2 is always linux
>>> console, is'nt that a good thing? Hence recommending to just expose the
>>> serialports as aliases to exactly what we need while keeping serial2 as
>>> the linux console (which in this case happens to be main_uart8 - example
>>> as j721s2 does).
>>>
>> "serial2 as the linux console" is *not* a convention, we just don't want to
>> fix up our bootloader/userspace to actually reason about what serial ports to
>> put logins on. Why not make ttyS10 the default, or ttyS666, it doesn't solve
>> your multi-distro issue either way since they usually only start a login on
>> ttyS0, console=, and/or the first virtual tty. Never on ttyS2. So you are
>> hacking up DT for a solution that doesn't do what you want in the end.
> ttyS2 is an accidental convention not a "by design" or definition
> convention. I suspect we ended up here from old OMAP days - all
> platforms in k3 ended up with ttyS2. In hindsight, if I had to do it
> by design, I would probably have picked ttyS0, well, we did'nt.
>
> $ git grep stdout-path arch/arm/boot/dts|grep serial|cut -d '=' -f 2|cut -d ':' -f1|grep -v '&'|sort|uniq -c
>      379  "serial0
>       21  "serial1
>       33  "serial2
>       13  "serial3
>        1  "/slaves@3e000000/serial@0
>
> $ git grep stdout-path arch/arm64/boot/dts|grep serial|cut -d '=' -f 2|cut -d ':' -f1|grep -v '&'|sort|uniq -c
>      245  "serial0
>       17  "serial0";
>        7  "serial1
>       49  "serial2
>        3  "serial3
>        2  "serial4
>        2  "serial5
>        2  "serial6
>
> $ git grep stdout-path arch/arm64/boot/dts/ti|grep serial|cut -d '=' -f 2|cut -d ':' -f1|grep -v '&'|sort|uniq -c
>        8  "serial2
>        1  "serial3
>
> I don't buy the argument here for 1-1 mapping of aliased serial
> instances to instances - why should main_uart8 be ttyS10, why not
> ttyS8 (it is equally valid - why was it called uart8?).. That mapping
> is just a convention we are choosing to create.
>
> The iot2050 ecosystem picked ttyS3 as the linux console for reasons of
> that ecosystem. K3 so far has selected ttyS2 as the convention for
> console - no matter where the serial instances have been located.
>
> I want to maintain consistency of existing TI platforms here without
> needing to shove a dozen things on existing users (yes j78-evm is a new
> board, but it is within the existing k3 s/w ecosystem and yes, getty,
> systemd etc are smarter today than once upon a time)
>
> So, given TI K3 history does'nt follow rest of the non-TI instances
> unfortunately - and I am going to put my foot down here - serial8 or 10
> is "fake" anyways - rationalization can be made in different ways. So
> pushing for one over the other is not something I will entertain.
>
>  From usage model point of view - serial0 will be the best candidate as
> console followed by serial2 (purely statistically speaking). In K3
> context, it is just serial2 in TI board ecosystem.
>
> That is a discussion for pros and cons - Open to hearing opinions.
> Unless I hear 1000% strong reasons with _backing data_ - not an
> subjective "it is correct thing to do" - why we'd want to move TI
> board ecosystem (including all the pains of bootloader combinations
> etc) switch over to ttyS0[1], having a mix and churn for the s/w
> ecosystem of having to deal with ttyS0 and ttyS2 nodes in arm64/dts/ti
> at least for the TI board ecosystem.. I cant see why i want to put the
> ecosystem through another churn on consoles.. But, fine, i will keep
> my ears open. If there are no strong arguments with _data_, then we
> stick with serial2 and y'all can curse me for another decade+ for that
> call :)
>
> [1] I have'nt forgotten ttyO2 to ttyS2 transition of OMAP
>   https://duckduckgo.com/?q=ttyO2+to+ttyS2+omap


Hi all,

I agree that there could be different standpoints on the aliasing of serial,
and the current way might not be the right way, but we have been using that
a quite long without any issues. (All K3 platforms use the same serial2 for
console).

IMO, if needed, the right way to change to other serial would be to:
1. Change all the serial aliases across K3 platforms, along with other
serial dependencies in userspace.
2. And have that as a separate patch series, i.e. a series that changes 
all the
incorrect aliases across K3 platforms. And this J784S4 patch series is 
not that
one.

Coming to a consensus would take time, lets do that separately and no 
point blocking
this series for it. All the previous platforms use the serial2 for 
console uart
and I will post my next series with the same. If there is a need to 
change the serial
aliasing, change it across all previous platforms in a separate patch 
series.

-- 
Thanks and regards,
Apurva Nandan,
Texas Instruments India.

