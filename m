Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C76B3A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCJJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCJJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:29:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178432A9BF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:26:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so2986884wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678440412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNL+f3pZ6bNpmj3kt1NLjVcEmx4ylNGYtgxCZ9dlKFA=;
        b=Sd4qVuxJDQFuMLlCPFaJoDKvhwHA9HlXnyhXjoU1pFEIyMWlwEmdwZnUEPK1vuhMzZ
         9lq0+0yA0+2WUFeTD8v4G+it6tTbmo5+k79Tcrlot5KeDZmkz1+X7zhcadhZ91VnPJyX
         CAtVpFMn5cjjOgRHzupMZWIyk5aNH7IJK3r7p7LauKKPOKZyQTGHFMB7SVdd4CRTh/9c
         Ltb4XwQA1r2f05/BOgLxSrkwciuvbI5VVpF5twbmZJhMFA71HM+pvyG7Ugo5LXMybPah
         /sAUZASNaCLN/ep2eHUDmQVlDH6bS+JqKDxoIGuuvU39/oyZGPXmp+2fkCFyIifKvvt4
         7eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNL+f3pZ6bNpmj3kt1NLjVcEmx4ylNGYtgxCZ9dlKFA=;
        b=ZoUqePkT/BfE8Foxb36BhqNIdYkQFJqpfaOKv8lPrVbWTYjR0BKJg3u/PxwRvDMOvQ
         EVSF1nTlB6PS4XwButnuIc4bDLd3sTPNAJf4j9FbH6lFFJzAkXw1pRtzOE9LsDVyHBx8
         kaAAoXUR39RxO4r0DT3Xus8NtP6KZg6IiR/jJLUc+d6N8cqcGk63HKfiXT8aJQlUzcYy
         LRLBNtHSILV9TNBOiubpfBenn7o1ZelnAJrbFWPJRJl4+c2OgW3lzkDoRtOJ9f4J8jXW
         9aetioFrepXJUZ+Ygmw2Uqv8uHig6hCFZI8IWUNfmJylfqywYHRUL985Y/8XySsXGgsl
         uAjw==
X-Gm-Message-State: AO0yUKUW2W1zPyeiXuJ/FL0zkp0J0dnrpLPTP6ERjFWGuvUORDZ+Yfhu
        RI95Gn1O096yiNvUGWAqqWo=
X-Google-Smtp-Source: AK7set9Xzk9BMbnoqlJVd1xoOzH2NobQcn8OcgRL3OMdLvLTW0Gl7RfPo93cGx+Qh3BdyL3vbUzymg==
X-Received: by 2002:a05:600c:35c9:b0:3ea:d601:976f with SMTP id r9-20020a05600c35c900b003ead601976fmr1979380wmq.23.1678440412107;
        Fri, 10 Mar 2023 01:26:52 -0800 (PST)
Received: from [192.168.1.10] (95f1a118.skybroadband.com. [149.241.161.24])
        by smtp.googlemail.com with ESMTPSA id g9-20020a7bc4c9000000b003e20970175dsm2353826wmk.32.2023.03.10.01.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:26:51 -0800 (PST)
Message-ID: <853b7e32-f566-2a92-0f59-3490ad5d88df@googlemail.com>
Date:   Fri, 10 Mar 2023 09:26:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
To:     Ben Skeggs <skeggsb@gmail.com>, Karol Herbst <kherbst@redhat.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Dave Airlie <airlied@gmail.com>, bskeggs@redhat.com,
        Lyude Paul <lyude@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
 <CACO55tvR4ydDOXt=9nbR3n2aFLKrj8zeuGRR_xpezVQBBLrjqg@mail.gmail.com>
 <a6188878-f84c-0fcc-9509-b9d7ab797f4c@leemhuis.info>
 <d031f0a5-8d5e-af51-6db6-11844de3eeba@googlemail.com>
 <CAPM=9tz+wksJTvMi_4Ef7XWezfH0ReN2se189s8Q=obJjHC+Fw@mail.gmail.com>
 <4e786e22-f17a-da76-5129-8fef0c7c825a@googlemail.com>
 <b829633e-ccc4-7a54-1cad-f29254de1251@leemhuis.info>
 <CACO55tsvM07_6mGU3dCgeji0a6B4JJKSDOOBuCHv2Mw3rYbCHg@mail.gmail.com>
 <181bea6a-e501-f5bd-b002-de7a244a921a@googlemail.com>
 <CACO55tsGXfy9-a-nexvcn7pnDGoEWXMqhiQEBwCDkGyOeT1sXQ@mail.gmail.com>
 <dbfc1f77-29f3-7690-c231-55f906a4e7e5@googlemail.com>
 <7f6ec5b3-b5c7-f564-003e-132f112b7cf4@googlemail.com>
 <CACAvsv7Uf5=K44y8YLsiy0aMnc1zvGEQdeDe7RQF=AV+fxxzuQ@mail.gmail.com>
 <c12aa9b8-65a1-0cdf-8948-15309f16b955@googlemail.com>
 <CACO55tvGQdHPnZEMAGPZN3K1nUCV-ruX_QNwSqQAg_z81ab0MA@mail.gmail.com>
 <CACAvsv53xc8dr0e5HEFcV+218WoCbGVor0HDgBw-C51fPkR9kQ@mail.gmail.com>
Content-Language: en-GB
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <CACAvsv53xc8dr0e5HEFcV+218WoCbGVor0HDgBw-C51fPkR9kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Is it likely that this fix will be sumbmitted to mainline during the ongoing 6.3 development cycle?

Chris

On 20/02/2023 22:16, Ben Skeggs wrote:
> On Mon, 20 Feb 2023 at 21:27, Karol Herbst <kherbst@redhat.com> wrote:
>>
>> On Mon, Feb 20, 2023 at 11:51 AM Chris Clayton <chris2553@googlemail.com> wrote:
>>>
>>>
>>>
>>> On 20/02/2023 05:35, Ben Skeggs wrote:
>>>> On Sun, 19 Feb 2023 at 04:55, Chris Clayton <chris2553@googlemail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 18/02/2023 15:19, Chris Clayton wrote:
>>>>>>
>>>>>>
>>>>>> On 18/02/2023 12:25, Karol Herbst wrote:
>>>>>>> On Sat, Feb 18, 2023 at 1:22 PM Chris Clayton <chris2553@googlemail.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 15/02/2023 11:09, Karol Herbst wrote:
>>>>>>>>> On Wed, Feb 15, 2023 at 11:36 AM Linux regression tracking #update
>>>>>>>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>>
>>>>>>>>>> On 13.02.23 10:14, Chris Clayton wrote:
>>>>>>>>>>> On 13/02/2023 02:57, Dave Airlie wrote:
>>>>>>>>>>>> On Sun, 12 Feb 2023 at 00:43, Chris Clayton <chris2553@googlemail.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 10/02/2023 19:33, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>>>>>>>>>>> On 10.02.23 20:01, Karol Herbst wrote:
>>>>>>>>>>>>>>> On Fri, Feb 10, 2023 at 7:35 PM Linux regression tracking (Thorsten
>>>>>>>>>>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 08.02.23 09:48, Chris Clayton wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I'm assuming  that we are not going to see a fix for this regression before 6.2 is released.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Yeah, looks like it. That's unfortunate, but happens. But there is still
>>>>>>>>>>>>>>>> time to fix it and there is one thing I wonder:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Did any of the nouveau developers look at the netconsole captures Chris
>>>>>>>>>>>>>>>> posted more than a week ago to check if they somehow help to track down
>>>>>>>>>>>>>>>> the root of this problem?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I did now and I can't spot anything. I think at this point it would
>>>>>>>>>>>>>>> make sense to dump the active tasks/threads via sqsrq keys to see if
>>>>>>>>>>>>>>> any is in a weird state preventing the machine from shutting down.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Many thx for looking into it!
>>>>>>>>>>>>>
>>>>>>>>>>>>> Yes, thanks Karol.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Attached is the output from dmesg when this block of code:
>>>>>>>>>>>>>
>>>>>>>>>>>>>         /bin/mount /dev/sda7 /mnt/sda7
>>>>>>>>>>>>>         /bin/mountpoint /proc || /bin/mount /proc
>>>>>>>>>>>>>         /bin/dmesg -w > /mnt/sda7/sysrq.dmesg.log &
>>>>>>>>>>>>>         /bin/echo t > /proc/sysrq-trigger
>>>>>>>>>>>>>         /bin/sleep 1
>>>>>>>>>>>>>         /bin/sync
>>>>>>>>>>>>>         /bin/sleep 1
>>>>>>>>>>>>>         kill $(pidof dmesg)
>>>>>>>>>>>>>         /bin/umount /mnt/sda7
>>>>>>>>>>>>>
>>>>>>>>>>>>> is executed immediately before /sbin/reboot is called as the final step of rebooting my system.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I hope this is what you were looking for, but if not, please let me know what you need
>>>>>>>>>>>
>>>>>>>>>>> Thanks Dave. [...]
>>>>>>>>>> FWIW, in case anyone strands here in the archives: the msg was
>>>>>>>>>> truncated. The full post can be found in a new thread:
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/lkml/e0b80506-b3cf-315b-4327-1b988d86031e@googlemail.com/
>>>>>>>>>>
>>>>>>>>>> Sadly it seems the info "With runpm=0, both reboot and poweroff work on
>>>>>>>>>> my laptop." didn't bring us much further to a solution. :-/ I don't
>>>>>>>>>> really like it, but for regression tracking I'm now putting this on the
>>>>>>>>>> back-burner, as a fix is not in sight.
>>>>>>>>>>
>>>>>>>>>> #regzbot monitor:
>>>>>>>>>> https://lore.kernel.org/lkml/e0b80506-b3cf-315b-4327-1b988d86031e@googlemail.com/
>>>>>>>>>> #regzbot backburner: hard to debug and apparently rare
>>>>>>>>>> #regzbot ignore-activity
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> yeah.. this bug looks a little annoying. Sadly the only Turing based
>>>>>>>>> laptop I got doesn't work on Nouveau because of firmware related
>>>>>>>>> issues and we probably need to get updated ones from Nvidia here :(
>>>>>>>>>
>>>>>>>>> But it's a bit weird that the kernel doesn't shutdown, because I don't
>>>>>>>>> see anything in the logs which would prevent that from happening.
>>>>>>>>> Unless it's waiting on one of the tasks to complete, but none of them
>>>>>>>>> looked in any way nouveau related.
>>>>>>>>>
>>>>>>>>> If somebody else has any fancy kernel debugging tips here to figure
>>>>>>>>> out why it hangs, that would be very helpful...
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think I've figured this out. It's to do with how my system is configured. I do have an initrd, but the only thing on
>>>>>>>> it is the cpu microcode which, it is recommended, should be loaded early. The absence of the NVidia firmare from an
>>>>>>>> initrd doesn't matter because the drivers for the hardware that need to load firmware are all built as modules, So, by
>>>>>>>> the time the devices are configured via udev, the root partition is mounted and the drivers can get at the firmware.
>>>>>>>>
>>>>>>>> I've found, by turning on nouveau debug and taking a video of the screen as the system shuts down, that nouveau seems to
>>>>>>>> be trying to run the scrubber very very late in the shutdown process. The problem is that by this time, I think the root
>>>>>>>> partition, and thus the scrubber binary, have become inaccessible.
>>>>>>>>
>>>>>>>> I seem to have two choices - either make the firmware accessible on an initrd or unload the module in a shutdown script
>>>>>>>> before the scrubber binary becomes inaccessible. The latter of these is the workaround I have implemented whilst the
>>>>>>>> problem I reported has been under investigation. For simplicity, I think I'll promote my workaround to being the
>>>>>>>> permanent solution.
>>>>>>>>
>>>>>>>> So, apologies (and thanks) to everyone whose time I have taken up with this non-bug.
>>>>>>>>
>>>>>>>
>>>>>>> Well.. nouveau shouldn't prevent the system from shutting down if the
>>>>>>> firmware file isn't available. Or at least it should print a
>>>>>>> warning/error. Mind messing with the code a little to see if skipping
>>>>>>> it kind of works? I probably can also come up with a patch by next
>>>>>>> week.
>>>>>>>
>>>>>> Well, I'd love to but a quick glance at the code caused me to bump into this obscenity:
>>>>>>
>>>>>> int
>>>>>> gm200_flcn_reset_wait_mem_scrubbing(struct nvkm_falcon *falcon)
>>>>>> {
>>>>>>         nvkm_falcon_mask(falcon, 0x040, 0x00000000, 0x00000000);
>>>>>>
>>>>>>         if (nvkm_msec(falcon->owner->device, 10,
>>>>>>                 if (!(nvkm_falcon_rd32(falcon, 0x10c) & 0x00000006))
>>>>>>                         break;
>>>>>>         ) < 0)
>>>>>>                 return -ETIMEDOUT;
>>>>>>
>>>>>>         return 0;
>>>>>> }
>>>>>>
>>>>>> nvkm_msec is #defined to nvkm_usec which in turn is #defined to nvkm_nsec where the loop that the break is related to
>>>>>> appears
>>>>>
>>>>> I think someone who knows the code needs to look at this. What I can confirm is that after a freeze, I waited for 90
>>>>> seconds for a timeout to occur, but it didn't.
>>>> Hey,
>>>>
>>>> Are you able to try the attached patch for me please?
>>>>
>>>> Thanks,
>>>> Ben.
>>>>
>>>
>>> Thanks Ben.
>>>
>>> Yes, this patch fixes the lockup on reboot and poweroff that I've been seeing on my laptop. As you would expect,
>>> offloaded rendering is still working and the discrete GPU is being powered on and off as required.
>>>
>>> Thanks.
>>>
>>> Reported-by: Chris Clayton <chris2553@googlemail.com>
>>> Tested-by: Chris Clayton <chris2553@googlemail.com>
>>>
>>
>> Ben, did you manage to get push rights to drm-misc by now or should I
>> just pick the patch and push it through -fixes?
> Feel free to pick it up!
> 
> Thank you,
> Ben.
> 
>>
>>>>>
>>>>>
>>>>> .> Chris
>>>>>>>>
>>>>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>>>>>>>> --
>>>>>>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>>>>>>> That page also explains what to do if mails like this annoy you.
>>>>>>>>>>
>>>>>>>>>> #regzbot ignore-activity
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>
>>
