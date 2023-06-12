Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091E272B510
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFLBMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLBMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:12:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E9019C;
        Sun, 11 Jun 2023 18:12:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3c3f2d71eso4435275ad.2;
        Sun, 11 Jun 2023 18:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686532350; x=1689124350;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BY92OIs05U+Ju9yHTKboj6eF9PeJ7Y3XidpiHDFa61I=;
        b=GJbJYSQw+Nq7kd2AYVsZk3Ct0pNReyOF9nDAVdnGexD2JXIChdAKB5CAS5h+3Kb8uo
         3Rey5y/cd5c9+AaIhbnIq0BjiXbyuk2ozHRIQMz9Fl8RfRZFa/t/2m3aiuGnsLh/wxqr
         SKH1B5amFXhbNpw6hLT2AzMHS6aWyhdIM3sSw4fmRkjXx068vZHERsFEWYiYglo8a33j
         1aj/TI0cuvidApTZAgY+N834AGwYM/jr0WbtPAdbZ8UPsq7kMJNVyr7+foyK3Iz3RUR4
         GDt66Ru+UN8vJQxpoMXlTMyquTc4eEgyIOMC6nkZO423vZ5+qz42flUgj1psC43ZSvKE
         w+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686532350; x=1689124350;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BY92OIs05U+Ju9yHTKboj6eF9PeJ7Y3XidpiHDFa61I=;
        b=WjdoduCpVXc5FMBojVyPLhMTF3AbUIzEZEwYNq8al1tyfKW3RMF1z/92LK7Ss/LPTy
         mzETZnvyZdgursYq96OMwu5JE4X46dOHCD8Zvd0+AfbnqfRHOpHvrbZ1MLiNGotxCrcp
         ouSW0WBzmJ+ThfQrwKptkAt2nNw3mU+C3QXVznSeiXuhQpf+M7WrZUhVmBQ4el3mVlF+
         s6tBgTS2CxT0OUbbrwGxlOyGehi46VW86JgT3O4X7KkAjP6d0G8WxLSna/Tf1IyFA5WD
         k2dN6p8uJcHsbY69SqVZzmHvXOlu+PxQYaFrPAlrMp0rs6y3XGqPrHbajQvDGfjtRZbU
         IqgQ==
X-Gm-Message-State: AC+VfDxPZ6Y9AQHmgjKxHnFat0LPMAHR3jTEOb179x93WTA/dIuyemSh
        8f9RsZf89DIguuxma1XrUio=
X-Google-Smtp-Source: ACHHUZ7COuR0otVoXR/xl/GjbJeF51G0WEIJLy8ZhNbPP4Kx+qQJK+j7Vn9dzlN7TtWb1dykg0dtEQ==
X-Received: by 2002:a17:902:e884:b0:1b1:adb4:8fa8 with SMTP id w4-20020a170902e88400b001b1adb48fa8mr5924463plg.39.1686532350545;
        Sun, 11 Jun 2023 18:12:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b00198d7b52eefsm6850002plh.257.2023.06.11.18.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 18:12:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <922b48ab-f67d-9c32-893b-d6a02618d39a@roeck-us.net>
Date:   Sun, 11 Jun 2023 18:12:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Ido Schimmel <idosch@nvidia.com>
References: <20230607200903.652580797@linuxfoundation.org>
 <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
 <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
 <ZITNw9cv/WoZcSaO@duo.ucw.cz>
 <39b34446-88a7-eeb5-cf95-e4f1843100b3@roeck-us.net>
 <1e9e0ce4-dc47-81d6-e3a5-681d4a9ba9b0@roeck-us.net>
Content-Language: en-US
In-Reply-To: <1e9e0ce4-dc47-81d6-e3a5-681d4a9ba9b0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/23 08:14, Guenter Roeck wrote:
> On 6/10/23 14:14, Guenter Roeck wrote:
>> Hi,
>>
>> On 6/10/23 12:23, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> Build results:
>>>>>     total: 155 pass: 155 fail: 0
>>>>> Qemu test results:
>>>>>     total: 499 pass: 498 fail: 1
>>>>> Failed tests:
>>>>>     arm:kudo-bmc:multi_v7_defconfig:npcm:usb0.1:nuvoton-npcm730-kudo:rootfs
>>>>>
>>>>> The test failure is spurious and not new. I observe it randomly on
>>>>> multi_v7_defconfig builds, primarily on npcm platforms. There is no error
>>>>> message, just a stalled boot. I have been trying to bisect for a while,
>>>>> but I have not been successful so far. No immediate concern; I just wanted
>>>>> to mention it in case someone else hits the same or a similar problem.
>>>>>
>>>>
>>>> I managed to revise my bisect script sufficiently enough to get reliable
>>>> results. It looks like the culprit is commit 503e554782c9 (" debugobject:
>>>> Ensure pool refill (again)"); see bisect log below. Bisect on four
>>>> different systems all have the same result. After reverting this patch,
>>>> I do not see the problem anymore (again, confirmed on four different
>>>> systems). If anyone has an idea how to debug this, please let me know.
>>>> I'll be happy to give it a try.
>>>
>>> You may want to comment out debug_objects_fill_pool() in
>>> debug_object_activate or debug_object_assert_init to see which one is
>>> causing the failure...
>>>
>>> CONFIG_PREEMPT_RT is disabled for you, right? (Should 5.15 even have
>>> that option?)
>>>
>>
>> CONFIG_PREEMPT_RT is disabled (it depends on ARCH_SUPPORTS_RT which is not
>> enabled by any architecture in v5.15.y).
>>
>> The added call in debug_object_activate() triggers the problem.
>> Any idea what to do about it or how to debug it further ?
>>
> 
> I did some more debugging. The call to debug_object_activate()
> from debug_hrtimer_activate() causes the immediate problem, and the
> call from debug_timer_activate() causes a second (less likely) problem,
> where the stall is seen during reboot.
> 
> In other words, the problem is (only) seen if DEBUG_OBJECTS_TIMERS
> is enabled.
> 

Bisect log between v5.15 and v6.1 below. The fix is all but impossible to backport,
and I still have no idea what is actually going on. I think I'll just disable
DEBUG_OBJECTS_TIMERS in affected tests of v5.15.y.

Guenter

---
# fixed: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
# broken: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
git bisect start 'v6.1' 'v5.15'
# broken: [7fa2e481ff2fee20e0338d98489eb9f513ada45f] Merge branch 'big-tcp'
git bisect broken 7fa2e481ff2fee20e0338d98489eb9f513ada45f
# fixed: [9e2e5ea3b28f81512c792f30729edb1db0c21f6a] Merge tag 'usb-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect fixed 9e2e5ea3b28f81512c792f30729edb1db0c21f6a
# fixed: [4ad680f083ec360e0991c453e18a38ed9ae500d7] Merge tag 'staging-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect fixed 4ad680f083ec360e0991c453e18a38ed9ae500d7
# fixed: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
git bisect fixed 2518f226c60d8e04d18ba4295500a5b0b8ac7659
# broken: [fea3043314f30a87ca04fd1219661810600e256f] Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect broken fea3043314f30a87ca04fd1219661810600e256f
# broken: [f8122500a039abeabfff41b0ad8b6a2c94c1107d] Merge branch 'etnaviv/next' of https://git.pengutronix.de/git/lst/linux into drm-next
git bisect broken f8122500a039abeabfff41b0ad8b6a2c94c1107d
# fixed: [7e062cda7d90543ac8c7700fc7c5527d0c0f22ad] Merge tag 'net-next-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect fixed 7e062cda7d90543ac8c7700fc7c5527d0c0f22ad
# broken: [9fa87dd23251574a29cf948fd16cf39075762f3e] Merge tag 'linux-can-next-for-5.19-20220523' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
git bisect broken 9fa87dd23251574a29cf948fd16cf39075762f3e
# fixed: [88a618920e9baabc1780479e2fbb68e5551d0563] Merge tag 'docs-5.19' of git://git.lwn.net/linux
git bisect fixed 88a618920e9baabc1780479e2fbb68e5551d0563
# broken: [fdaf9a5840acaab18694a19e0eb0aa51162eeeed] Merge tag 'folio-5.19' of git://git.infradead.org/users/willy/pagecache
git bisect broken fdaf9a5840acaab18694a19e0eb0aa51162eeeed
# broken: [164f9fcb21cc9a144ca9ebcf85b00c49537f6be2] docs/ja_JP/SubmittingPatches: Suggest the use of scripts/get_maintainer.pl
git bisect broken 164f9fcb21cc9a144ca9ebcf85b00c49537f6be2
# broken: [2e17ce1106e04a7f3a83796ec623881487f75dd3] Merge tag 'slab-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
git bisect broken 2e17ce1106e04a7f3a83796ec623881487f75dd3
# fixed: [701850dc0c31bfadf75a0a74af7d2c97859945ec] printk, tracing: fix console tracepoint
git bisect fixed 701850dc0c31bfadf75a0a74af7d2c97859945ec
# broken: [1fc0ca9e0db61882208650b3603071e9f4b5cfee] printk: add con_printk() macro for console details
git bisect broken 1fc0ca9e0db61882208650b3603071e9f4b5cfee
# broken: [2bb2b7b57f81255c13f4395ea911d6bdc70c9fe2] printk: add functions to prefer direct printing
git bisect broken 2bb2b7b57f81255c13f4395ea911d6bdc70c9fe2
# fixed: [8e274732115f63c1d09136284431b3555bd5cc56] printk: extend console_lock for per-console locking
git bisect fixed 8e274732115f63c1d09136284431b3555bd5cc56
# fixed: [09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7] printk: add kthread console printers
git bisect fixed 09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7
# first fixed commit: [09c5ba0aa2fcfdadb17d045c3ee6f86d69270df7] printk: add kthread console printers


