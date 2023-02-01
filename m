Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD5686777
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjBANvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjBANvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:51:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E686E22034
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:51:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n13so5715601wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=skHdOUp8a0O2VeWC0Ud27F7Yg35quVymPzucu8ggf5c=;
        b=lgqYQTYgmGKYJ3VcE3XqFsCLGAX/Zmt8c/6e0c1SgNnvDHSZVeZ9P5i9M8YYsxcmZa
         91GSQZ+BPi0OpXsAW4x91Hkb+RPCW6//wvl/leUU6T3LLrI3jQP+7TtdzMZbDgKqaUH2
         lUhB3ReSwYPlArKYc6G+egKktrYvh1uV3pYDrHS4lNxuY0ROM01e7WonAp3pJ7qjE/J9
         Vi2LnZoJwXpbucDjvskR/yvh0sBGMRcHoCJocEKRpX/+dgSfxu8KecIoDr3GpeEZN4gP
         VVaC6CVXNGlIGQ56Ot8zRbz3f00XBAVFZa+qWXcCsEfMXglAivF4zMYgdd0/rAcB0KAh
         bx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skHdOUp8a0O2VeWC0Ud27F7Yg35quVymPzucu8ggf5c=;
        b=56SW/loEe3JA2H0BgpqasBt9MmB2rbjKbsDLva5NwNE7lTuA0MDdNuqGJrxnaUa8KH
         4pH1bXxnZ4PFSCp5cFTsNq7LyrA5S/hskoYILsIXk8SfdNPfd7nkR+gWNrDqaCvxtOoy
         6tKJOMTfP7s0w0x5fLQkXQ1eZqME4b1nIdUFPug8DjW7QVWByCUyVRjOepf2Df+W1GwO
         2IB6X6jPG/WRXYkOkfb28aa/moES3IGrFQqX0H+3psVPTG9Xl9Ia3VMkQ6VrFWvpKWq8
         yQA3rv/2T/ANTf4IqoMciHm78lEyHGCG+T5zn97eAIK5qMJ49X7LLru6SM3PXxaOmnTq
         /gnw==
X-Gm-Message-State: AO0yUKVMOnXqxWG9aZslMK9A++ggAoTNqT9PPdjQCbTGftbvapXMr+He
        srHbQkxG3ylrLlVqx7YtA7Y=
X-Google-Smtp-Source: AK7set/asA5ao0giThJfFqWEnETU4WRPPmZ/hdU64C5avUmycquMj1kcyW3sm8UkFcf/wTzMYWmJPw==
X-Received: by 2002:a05:600c:1e24:b0:3da:f665:5b66 with SMTP id ay36-20020a05600c1e2400b003daf6655b66mr2454442wmb.6.1675259468375;
        Wed, 01 Feb 2023 05:51:08 -0800 (PST)
Received: from [192.168.1.10] (97e09f27.skybroadband.com. [151.224.159.39])
        by smtp.googlemail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm1903981wmb.8.2023.02.01.05.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:51:07 -0800 (PST)
Message-ID: <1632a9ef-2954-c8f0-cdc9-03157c9d8547@googlemail.com>
Date:   Wed, 1 Feb 2023 13:51:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Chris Clayton <chris2553@googlemail.com>
Subject: Re: linux-6.2-rc4+ hangs on poweroff/reboot: Bisected
To:     Ben Skeggs <skeggsb@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        bskeggs@redhat.com, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <b64705e3-2e63-a466-f829-f9568b06766a@googlemail.com>
 <fcec3c78-b5d9-eb48-0fc0-d1f27de87f23@leemhuis.info>
 <b21fa1f6-a71d-5657-8596-ee0be73185ea@leemhuis.info>
 <3ab28896-70e9-6f90-5b97-e5397b06e715@googlemail.com>
 <a163dd7b-c5d1-a07b-a816-7a2dfd3edfd4@leemhuis.info>
 <ab1b0f73-6b4e-8602-2999-b7bec25d92db@googlemail.com>
 <CACAvsv4sOtPjCVnEcKd2RCUqYWxSn5XKyksbS-Bds2qCqyusVw@mail.gmail.com>
 <1cdb84ac-f7a8-66ba-98fc-3db302b49a5a@googlemail.com>
 <dab6eb81-db3f-8fa1-84ad-9b40e209514b@googlemail.com>
 <CACAvsv5iYdF3P8AbyrbYo3zGmYRYhxDWn7WbAR5V9qHpbgBXRA@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CACAvsv5iYdF3P8AbyrbYo3zGmYRYhxDWn7WbAR5V9qHpbgBXRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2023 23:27, Ben Skeggs wrote:
> On Tue, 31 Jan 2023 at 09:09, Chris Clayton <chris2553@googlemail.com> wrote:
>>
>> Hi again.
>>
>> On 30/01/2023 20:19, Chris Clayton wrote:
>>> Thanks, Ben.
>>
>> <snip>
>>
>>>> Hey,
>>>>
>>>> This is a complete shot-in-the-dark, as I don't see this behaviour on
>>>> *any* of my boards.  Could you try the attached patch please?
>>>
>>> Unfortunately, the patch made no difference.
>>>
>>> I've been looking at how the graphics on my laptop is set up, and have a bit of a worry about whether the firmware might
>>> be playing a part in this problem. In order to offload video decoding to the NVidia TU117 GPU, it seems the scrubber
>>> firmware must be available, but as far as I know,that has not been released by NVidia. To get it to work, I followed
>>> what ubuntu have done and the scrubber in /lib/firmware/nvidia/tu117/nvdec/ is a symlink to
>>> ../../tu116/nvdev/scrubber.bin. That, of course, means that some of the firmware loaded is for a different card is being
>>> loaded. I note that processing related to firmware is being changed in the patch. Might my set up be at the root of my
>>> problem?
>>>
>>> I'll have a fiddle an see what I can work out.
>>>
>>> Chris
>>>
>>>>
>>>> Thanks,
>>>> Ben.
>>>>
>>>>>
>>
>> Well, my fiddling has got my system rebooting and shutting down successfully again. I found that if I delete the symlink
>> to the scrubber firmware, reboot and shutdown work again. There are however, a number of other files in the tu117
>> firmware directory tree that that are symlinks to actual files in its tu116 counterpart. So I deleted all of those too.
>> Unfortunately, the absence of one or more of those symlinks causes Xorg to fail to start. I've reinstated all the links
>> except scrubber and I now have a system that works as it did until I tried to run a kernel that includes the bad commit
>> I identified in my bisection. That includes offloading video decoding to the NVidia card, so what ever I read that said
>> the scrubber firmware was needed seems to have been wrong. I get a new message that (nouveau 0000:01:00.0: fb: VPR
>> locked, but no scrubber binary!), but, hey, we can't have everything.
>>
>> If you still want to get to the bottom of this, let me know what you need me to provide and I'll do my best. I suspect
>> you might want to because there will a n awful lot of Ubuntu-based systems out there with that scrubber.bin symlink in
>> place. On the other hand,m it could but quite a while before ubuntu are deploying 6.2 or later kernels.
> The symlinks are correct - whole groups of GPUs share the same FW, and
> we use symlinks in linux-firmware to represent this.
> 
> I don't really have any ideas how/why this patch causes issues with
> shutdown - it's a path that only gets executed during initialisation.
> Can you try and capture the kernel log during shutdown ("dmesg -w"
> over ssh? netconsole?), and see if there's any relevant messages
> providing a hint at what's going on?  Alternatively, you could try
> unloading the module (you will have to stop X/wayland/gdm/etc/etc
> first) and seeing if that hangs too.
> 
> Ben.

Sorry for the delay - I've been learning about netconsole and netcat. However, I had no success with ssh and netconsole
produced a log with nothing unusual in it.

Simply stopping Xorg and removing the nouveau module succeeds.

So, I rebuilt rc6+ after a pull from linus' tree this morning and set the nouveau debug level to 7. I then booted to a
console before doing a reboot (with Ctl+Alt+Del). As expected the machine locked up just before it would ordinarily
restart. The last few lines on the console might be helpful:

...
nouveau 0000:01:00:0  fifo: preinit running...
nouveau 0000:01:00:0  fifo: preinit completed in 4us
nouveau 0000:01:00:0  gr: preinit running...
nouveau 0000:01:00:0  gr: preinit completed in 0us
nouveau 0000:01:00:0  nvdec0: preinit running...
nouveau 0000:01:00:0  nvdec0: preinit completed in 0us
nouveau 0000:01:00:0  nvdec0: preinit running...
nouveau 0000:01:00:0  nvdec0: preinit completed in 0us
nouveau 0000:01:00:0  sec2: preinit running...
nouveau 0000:01:00:0  sec2: preinit completed in 0us
nouveau 0000:01:00:0  fb:.VPR locked, running scrubber binary

These messages appear after the "sd 4:0:0:0 [sda] Stopping disk" I reported in my initial email.

After the "running scrubber" line appears the machine is locked and I have to hold down the power button to recover. I
get the same outcome from running "halt -dip", "poweroff -di" and "shutdown -h -P now". I guess it's no surprise that
all three result in the same outcome because invocations halt, poweroff and reboot (without the -f argument)from a
runlevel other than 0 resukt in shutdown being run. switching to runlevel 0 with "telenit 0" results in the same
messages from nouveau followed by the lockup.

Let me know if you need any additional diagnostics.

Chris

> 
>>
>> Thanks,
>>
>> Chris
>>
>> <snip>
