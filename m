Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7126982F2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjBOSJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBOSJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:09:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4E1041B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:09:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gd1so8195691pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkNyi7VRTQ0Z8CUhgejVvvpeDEJD1m33wT82rvAeMGg=;
        b=bHh1knHWq1/slihyOz1C4UkGKUfHBVZmY2Gq7bH8w+qBoMSiQvgDhxHSCXX4bIJoNT
         J3+bUZJ8dBpA74lvr8rdhLuBoLs2TCuLMnHHmQLmIXsFGyMq27xSDB2mJ/XcpsodPoQ/
         /TAf2NgLHuKBoJ0n8MWX5aO5lwYKdDVAr4DYPHtLJ3C6MccnK/k2tLHnC405XRtBT6vx
         sseyhJses8zpisW/GbYh5gIK95XbEF2usrWM1fhRbQjGTc7TU/y3Lxj6tq3fhlObHHQR
         puoFD0S3ou/DG4T9j8XzOrKUDVOX0bnfquxjnkK0bFwAzlex4HaZ4+BBg3qT2tz1MT2a
         91TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkNyi7VRTQ0Z8CUhgejVvvpeDEJD1m33wT82rvAeMGg=;
        b=DBFPba58NKCqvDxFfGHe5lZRrzdObL4rEBiuNPYnksSIQpt1LcUnpEbTt+S2Ftb31D
         tsSWToVYEwKrwQjmgHygVF6LGDGkyye6pJqQCkVBDyNEK4COH7B8ZPFLq5b9BX2AH2X5
         SopQfhDub5q7+Hr2IQzNGuLuiDneWEKnW0IoGv8xPGZiwJynR4mvMBLfStZAU1jZbsHk
         9eUqjOUtz3RsEQkxEug8MRzx9futUiGW35FvY3OxHyH2c7GDQD/UrBYz03SeLzRMx4yz
         C9UlSM58aHOoN+0rxZs5Aj0tQ/uwIwrA0oj7WfGa648nTd4Da1IxNpgHh2yHjcm6IJX3
         oDYg==
X-Gm-Message-State: AO0yUKVJZSepe/eWnY1a++7yMNAkWr9NegjNBBghkuKhQ+AWKEJrr/li
        4i8PsBa91R/Sm5fvFP6NajHu4vBNQ4AuVw==
X-Google-Smtp-Source: AK7set/t9ZD7xNInjFvKkvot6qgjlcKUxuNnLymMV7HTLa+cTaFilFhJ67u36fgQ7IfxKi4CWWwQsQ==
X-Received: by 2002:a17:90b:3806:b0:22c:7639:a910 with SMTP id mq6-20020a17090b380600b0022c7639a910mr3844614pjb.25.1676484561328;
        Wed, 15 Feb 2023 10:09:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ga6-20020a17090b038600b00232cd9ff0ffsm1778006pjb.15.2023.02.15.10.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 10:09:20 -0800 (PST)
Message-ID: <1911746a-5d97-27ef-e714-1ca21e6ab987@gmail.com>
Date:   Wed, 15 Feb 2023 10:09:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Save and restore distributor and
 re-distributor
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oliver.upton@linux.dev>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20230214233426.2994501-1-f.fainelli@gmail.com>
 <20230214233426.2994501-4-f.fainelli@gmail.com>
 <87o7pvz78z.wl-maz@kernel.org> <20230215121050.d57tnfh7wzpyqzti@bogus>
 <86ttznxa9n.wl-maz@kernel.org> <20230215151048.xxmpvfre2xdngowr@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230215151048.xxmpvfre2xdngowr@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 07:10, Sudeep Holla wrote:
> On Wed, Feb 15, 2023 at 02:40:04PM +0000, Marc Zyngier wrote:
>> On Wed, 15 Feb 2023 12:10:50 +0000,
>> Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On Wed, Feb 15, 2023 at 08:02:20AM +0000, Marc Zyngier wrote:
>>>> On Tue, 14 Feb 2023 23:34:26 +0000,
>>>> Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>
>>>>> On platforms implementing Suspend to RAM where the GIC loses power, we
>>>>> are not properly saving and restoring the GIC distributor and
>>>>> re-distributor registers thus leading to the system resuming without any
>>>>> functional interrupts.
>>>>
>>>> The real question is *why* we need any of this. On any decent system,
>>>> this is the firmware's job.  It was *never* the OS GIC driver's job
>>>> the first place.
>>>>
>>>
>>> Completely agreed on the points you have made here, no disagreement.
>>> However I would like to iterate some of the arguments/concerns the
>>> firmware teams I have interacted in the past have made around this.
>>> And this is while ago(couple of years) and they may have different
>>> views. I am repeating them as I think it may be still valid on some
>>> systems so that we can make some suggestions if we have here.
>>>
>>>> Importantly, the OS cannot save the full state: a large part of it is
>>>> only accessible via secure, and Linux doesn't run in secure mode. How
>>>> do you restore the group configuration, for example? Oh wait, you
>>>> don't even save it.
>>>>
>>>
>>> Agreed, we can't manage secure side configurations. But one of the concern
>>> was about the large memory footprint to save the larger non-secure GIC
>>> context in the smaller secure memory.
>>>
>>> One of the suggestion at the time was to carve out a chunk of non-secure
>>> memory and let the secure side use the same for context save and restore.
>>> Not sure if this was tried out especially for the GIC. I may need to
>>> chase that with the concerned teams.
>>
>> The main issue is that you still need secure memory to save the secure
>> state, as leaving it in NS memory would be an interesting attack
>> vector! Other than that, I see no issue with FW carving out the memory
>> it needs to save/restore the NS state of the GIC.
>>
> 
> Yes I meant NS memory for only NS state of GIC.

The secure state of the GIC is being re-initialized coming out of 
suspend to DRAM since the chip lost its state, in fact we configure it 
the same as we did during cold boot and then the firmware goes on 
re-initializing the various secure interrupts it uses.

The non-secure state was not dealt with by the firmware, which prompted 
me to mimicking what the GICv2 driver does since there is an expectation 
from Linux that interrupts will be saved/restored.

> 
>> Note that this isn't only the (re-)distributor(s) PPI/SPI registers.
>> The LPI setup must also be saved, and that includes all the ITS
>> registers. I'm surprised the FW folks are, all of a sudden,
>> discovering this requirements. It isn't like the GIC architecture is a
>> novelty, and they have had ample time to review the spec...
>>
> 
> I understand your concern about late realisation 😄.
> 
> Another issue in general I see with reference firmware stack(like
> Trusted Firmware in this case) is that the requirements are driven from
> the reference platforms which may not have this GIC save/restore
> requirement as they are in always on domain and it is then made platform
> specific problem in that project which may not be ideal and may result
> in somewhat misleading indirectly other firmware developers using it.

I suppose it is so obvious that saving/restoring must happen by trusted 
firmware that there is no point in putting that in BIG CAPITAL WORDS for 
people to know about it.

> 
> Also remember some firmware folks asking about LPI context, I am not sure
> if there was any work done in that area.
> 
>>>
>>> Thanks Florian for starting this thread and sorry that I couldn't recollect
>>> lots of the information when we chatted in the private about this. Marc
>>> response triggered all the memory back.
>>>
>>>> So unless you have a single security state system, this cannot
>>>> work. And apart from VMs (which by the way do not need any of this),
>>>> there is no GICv3-based system without EL3. If you know of one, please
>>>> let me know. And if it existed, then all the save/restore should
>>>> happen only when GICD_CTLR.DS==1.
>>>>
>>>
>>> Yes, now I remember the discussion we had probably almost 9-10 years
>>> back when I first added the CPU PM notifiers for GICv3. I am sure we
>>> would have discussed this at-least couple of times after that. Yet I
>>> just got carried away by the fact that GICv2 does the save/restore and
>>> this should also be possible. Sorry for that.
>>
>> GICv2 is just as fsck'd. It is just that we pretend it works for the
>> sake of 32bit that may run in secure mode. On a 64bit machine, or in a
>> NS setup, it is doomed for the same reasons. There really isn't any
>> substitute for secure firmware here.
> 
> Fair enough and thanks for refreshing my memory on this.
> 
> Hi Florian,
> 
> I did little bit digging in the TF-A and found this.
> plat_arm_gic_{save,resume}()in plat/arm/common/arm_gicv3.c which I assume
> makes it platform specific code and hence not used on any other platform.
> I also missed to see this earlier as I explicitly ignored the plat/ directory
> assuming it is all platform specific code not shared across.
> 
> Not sure if the firmware on your platform is not using that or is it
> different firmware altogether or may be TF-A forked before this change.
> If it is missing anything, it would be good to get that fixed and look
> at ways to generalise it.

As you may or may not remember we have our own ARM Trusted Firmware for 
better of for worse, I will put the code to save and restore the 
registers there. Thanks!
-- 
Florian

