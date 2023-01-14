Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F275766AA77
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjANJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjANJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:32:29 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA755A2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:32:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id F2CCD604FA;
        Sat, 14 Jan 2023 10:32:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673688742; bh=3ufTP1h23f/ALtNkf1D0wKA3UagV43oW4UMYWaxkmx0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Iz6e4zavZ06VFWh/tocui1/o6vg3HNFbG+2CpTqhilbMJWhjgjeqwPJTlaUR8kM4n
         jcDLU0czioKggwHZB0ypyo6GwmHe9Qvrj0MvP61IsYdOIKJujtfgCcB6piEbP2kGIC
         KXykoT4LXtSVZcWYaaewWZDplfjpKwmRf8V6EVoPOfcMQfHWRMR7QtZjRHO/Jb1tpj
         4SZvE+0TXuYxu5MkJM3Xc2SFTYfUpKplx6CSkdkmqjmS4A08D6NF7Zix4MY6uqNAyf
         vz+KpfHMXqD8l8URS8CF32OtTUeh0C4bPPPLF/IiJmXcRD9axbq4shQaX7wmhFR543
         r/bdbii9xkoFA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2F0U5Fdww_uh; Sat, 14 Jan 2023 10:32:19 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.197.22])
        by domac.alu.hr (Postfix) with ESMTPSA id 5F271604F9;
        Sat, 14 Jan 2023 10:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673688739; bh=3ufTP1h23f/ALtNkf1D0wKA3UagV43oW4UMYWaxkmx0=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=pa58tSJuKChXg5OAJYIY1i7RqK93ucd7Dx84qtu07LPg7CKvXpcoim/BmYg+JAfVD
         X1bVJm7IFaxZhZa8441r3xL7//opcPWRokl85ofNV4In3J78nDcIwbTsa8tciCJsRe
         2v+8VTj9Li22E55djN+jstmJPtc2s8VG2xWNf5+beglaCU5ZgHPDMphHxI9RQAAxoX
         G+wT0eife+eSxXPYL//oL1RxS9Q6A7gKu36IMtE7foqDL41A884qGDDofUBb7ANCDh
         fIE6YMvEtn3Nfj8Gv/ta9RNc7VVIY4THIWzegKso7h+/r6I6KhZfETskXzy8s4VHiz
         Md5j5fwSZpN6g==
Message-ID: <2973fd00-3150-89ea-e2c0-7dbce2e39cc6@alu.unizg.hr>
Date:   Sat, 14 Jan 2023 10:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBJTkZPOiBbQklTRUNURURdIFJlZ3Jl?=
 =?UTF-8?Q?ssion=3a_A_Problem_with_/sys/kernel/debug/kmemleak_output=3a_back?=
 =?UTF-8?Q?trace_not_printed_since_6=2e2=2e0-rc1?=
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <5272a819-ef74-65ff-be61-4d2d567337de@alu.unizg.hr>
 <4c467851-8080-44d3-d017-b0e283896119@alu.unizg.hr>
 <53c2d558-c6a1-38e5-5739-28fff023558d@alu.unizg.hr>
 <3ba5f8ee-d9bd-69ae-bb3a-c61e47020e2c@alu.unizg.hr>
 <314a477e7f0644fbaf8fc607daefe70e@BJMBX01.spreadtrum.com>
 <c26ecfcf-383c-2f51-6641-2b7b30a76b62@alu.unizg.hr>
 <9d0a089db61b4943a47b45b3975790be@BJMBX01.spreadtrum.com>
 <2c677d85-820c-d41a-fc98-7d3974b49e42@alu.unizg.hr>
In-Reply-To: <2c677d85-820c-d41a-fc98-7d3974b49e42@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 01. 2023. 14:40, Mirsad Goran Todorovac wrote:
> On 13.1.2023. 11:14, 黄朝阳 (Zhaoyang Huang) wrote:
>>> On 13.1.2023. 7:20, 黄朝阳 (Zhaoyang Huang) wrote:
>>>>> /sys/kernel/debug/kmemleak output: backtrace not printed since
>>>>> 6.2.0-rc1
>>>>>
>>>>>
>>>>>> On 12. 01. 2023. 20:50, Mirsad Todorovac wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> there seems to be a problem with the output of
>>>>>> /sys/kernel/debug/kmemleak:
>>>>>>>
>>>>>>> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak unreferenced
>>>>>>> object 0xffff951c118568b0 (size 16):
>>>>>>>     comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
>>>>>>>     hex dump (first 16 bytes):
>>>>>>>       6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>>>>>>>     backtrace:
>>>>>>> [root@pc-mtodorov ~]#
>>>>>>>
>>>>>>> Apparently, backtrace of called functions on the stack is no longer
>>>>>>> printed
>>>>>> with the list of memory leaks.
>>>>>>>
>>>>>>> This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and
>>>>>>> BIOS version M22KT49A (11/10/2022) and 6.2-rc1 and 6.2-rc2 builds.
>>>>>>>
>>>>>>> This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU
>>>>>> enabled
>>>>>>> on a vanilla mainstream kernel from Mr. Torvalds' tree. I don't
>>>>>>> know if this is
>>>>>> deliberate feature for some reason or a bug.
>>>>>>>
>>>>>>> Please find attached the config, lshw and kmemleak output.
>>>>>>>
>>>>>>> The bisection gave this commit as the culprit for the severed stack
>>>>>>> backtrace print in /sys/kernel/debug/kmemleak:
>>>>>>>
>>>>>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect good
>>>>>>> 56a61617dd2276cbc56a6c868599716386d70041 is the first bad commit
>>>>>>> commit 56a61617dd2276cbc56a6c868599716386d70041
>>>>>>> Author: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>>>>> Date:   Thu Oct 27 17:50:24 2022 +0800
>>>>>>>
>>>>>>>       mm: use stack_depot for recording kmemleak's backtrace
>>>>>>>
>>>>>>>       Using stack_depot to record kmemleak's backtrace which has
>>> been
>>>>>>>       implemented on slub for reducing redundant information.
>>>>>>>
>>>>>>> The complete bisect log is:
>>>>>>>
>>>>>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect log git
>>>>>>> bisect start '--' 'mm'
>>>>>>> # good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1 git
>>>>>>> bisect good 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
>>>>>>> # bad: [1b929c02afd37871d5afb9d498426f83432e71c2] Linux 6.2-rc1 git
>>>>>>> bisect bad 1b929c02afd37871d5afb9d498426f83432e71c2
>>>>>>> # good: [8b9ed79c2d587bec5f603d66801478a5af9af842] Merge tag
>>>>>>> 'x86_asm_for_v6.2' of
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>>> git bisect good 8b9ed79c2d587bec5f603d66801478a5af9af842
>>>>>>> # good: [e83b39d6bbdb6d25bd6f5c258832774635d29b47] mm: make
>>>>>>> drop_caches keep reclaiming on all nodes git bisect good
>>>>>>> e83b39d6bbdb6d25bd6f5c258832774635d29b47
>>>>>>> # good: [9997bc017549acd6425e32300eff28424ffeeb6b] zsmalloc:
>>>>>> implement
>>>>>>> writeback mechanism for zsmalloc git bisect good
>>>>>>> 9997bc017549acd6425e32300eff28424ffeeb6b
>>>>>>> # good: [6287b7dae80944bfa37784a8f9d6861a4facaa6e] mm,thp,rmap:
>>> fix
>>>>>>> races between updates of subpages_mapcount git bisect good
>>>>>>> 6287b7dae80944bfa37784a8f9d6861a4facaa6e
>>>>>>> # good: [8fa590bf344816c925810331eea8387627bbeb40] Merge tag
>>>>>>> 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
>>>>>>> git bisect good 8fa590bf344816c925810331eea8387627bbeb40
>>>>>>> # good: [4f292c4de4f6fb83776c0ff22674121eb6ddfa2f] Merge tag
>>>>>>> 'x86_mm_for_6.2_v2' of
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>>> git bisect good 4f292c4de4f6fb83776c0ff22674121eb6ddfa2f
>>>>>>> # bad: [1ea9d333ba475041efe43d9d9bc32e64aea2ea2b] Merge tag
>>>>>>> 'mm-stable-2022-12-17-2' of
>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>>>>> git bisect bad 1ea9d333ba475041efe43d9d9bc32e64aea2ea2b
>>>>>>> # bad: [56a61617dd2276cbc56a6c868599716386d70041] mm: use
>>>>>> stack_depot
>>>>>>> for recording kmemleak's backtrace git bisect bad
>>>>>>> 56a61617dd2276cbc56a6c868599716386d70041
>>>>>>> # good: [61b963b52f59524e27692bc1c14bfb2459e32eb3] mm/gup_test:
>>>>>> free
>>>>>>> memory allocated via kvcalloc() using kvfree() git bisect good
>>>>>>> 61b963b52f59524e27692bc1c14bfb2459e32eb3
>>>>>>> # first bad commit: [56a61617dd2276cbc56a6c868599716386d70041]
>>> mm:
>>>>>> use
>>>>>>> stack_depot for recording kmemleak's backtrace # good:
>>>>>>> [9102b78b6f6ae6af3557114c265c266b312c1319] maple_tree: update
>>>>>>> copyright dates for test code git bisect good
>>>>>>> 9102b78b6f6ae6af3557114c265c266b312c1319
>>>>>>> # first bad commit: [56a61617dd2276cbc56a6c868599716386d70041]
>>> mm:
>>>>>> use
>>>>>>> stack_depot for recording kmemleak's backtrace You have mail in
>>>>>>> /var/mail/mtodorov mtodorov@domac:~/linux/kernel/linux_torvalds$
>>>>>>>
>>>>>>> The platform is 10TX000VCR
>>>>>> (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
>>>>>>> running AlmaLinux 8.7 (CentOS clone) and BIOS M22KT49A.
>>>>>>>
>>>>>>> GCC used was:
>>>>>>>
>>>>>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ gcc --version gcc
>>>>>>> (Debian 8.3.0-6) 8.3.0 Copyright (C) 2018 Free Software Foundation,
>>>>>>> Inc.
>>>>>>> This is free software; see the source for copying conditions.
>>>>>>> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>>>>>> PARTICULAR PURPOSE.
>>>>>>> mtodorov@domac:~/linux/kernel/linux_torvalds$
>>>>>>>
>>>>>>> Hope this helps.
>>>>>>>
>>>>>>> I lack the insight to pinpoint the exact fault in the patch.
>>>>>>
>>>>>> P.S.
>>>>>>
>>>>>> To further complicate things, on Ubuntu 22.10 Lenovo Ideapad 3
>>>>>> 15ITL6 laptop the kmemleak stack backtrace is printed correctly with
>>>>>> the same kernels (but .deb instead of .rpm for the same build):
>>>>>>
>>>>>> unreferenced object 0xffff94ca88e042d0 (size 80):
>>>>>>    comm "thermald", pid 768, jiffies 4294893592 (age 78581.504s)
>>>>>>    hex dump (first 32 bytes):
>>>>>>      00 00 00 00 00 00 00 00 0d 01 2d 00 00 00 00 00  ..........-.....
>>>>>>      af 07 01 80 fd ac ff ff 00 00 00 00 00 00 00 00  ................
>>>>>>    backtrace:
>>>>>>      [<ffffffffa0dcb921>] slab_post_alloc_hook+0x91/0x320
>>>>>>      [<ffffffffa0dcfb79>] kmem_cache_alloc+0x169/0x2f0
>>>>>>      [<ffffffffa12b1def>] acpi_os_acquire_object+0x2c/0x32
>>>>>>      [<ffffffffa12b1ea2>] acpi_ps_alloc_op+0x4a/0x99
>>>>>>      [<ffffffffa12af5c8>] acpi_ps_get_next_arg+0x611/0x761
>>>>>>      [<ffffffffa12afbbc>] acpi_ps_parse_loop+0x494/0x8d7
>>>>>>      [<ffffffffa12b1434>] acpi_ps_parse_aml+0x1bb/0x561
>>>>>>      [<ffffffffa12b24c8>] acpi_ps_execute_method+0x20f/0x2d5
>>>>>>      [<ffffffffa12a7acf>] acpi_ns_evaluate+0x34d/0x4f3
>>>>>>      [<ffffffffa12ad6a3>] acpi_evaluate_object+0x180/0x3ae
>>>>>>      [<ffffffffa1269ca8>] acpi_run_osc+0x128/0x250
>>>>>>      [<ffffffffc0bbb14f>] int3400_thermal_run_osc+0x6f/0xc0
>>>>>> [int3400_thermal]
>>>>>>      [<ffffffffc0bbb293>] current_uuid_store+0xe3/0x120
>>> [int3400_thermal]
>>>>>>      [<ffffffffa13b8ed4>] dev_attr_store+0x14/0x30
>>>>>>      [<ffffffffa0ee0458>] sysfs_kf_write+0x38/0x50
>>>>>>      [<ffffffffa0edf516>] kernfs_fop_write_iter+0x146/0x1d0 You have
>>>>>> new mail in /var/mail/root
>>>>>> root@marvin-IdeaPad-3-15ITL6:/home/marvin#
>>>>>>
>>>>>> Regards,
>>>>>> Mirsad
>>>>>
>>>>> thanks for head up. Could you please help to check If
>>>>> CONFIG_STACKTRACE and CONFIG_STACKDEPOT is enabled on the fault
>>> kernel?
>>>> Please try the patch below if the configs are right. I think it should
>>>> be caused by the late ready for kmemleak
>>>>
>>>> commit 556eb1927da99ab366e370d593fc32da946768c3
>>>> Author: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>> Date:   Fri Jan 13 14:13:39 2023 +0800
>>>>
>>>>       mm: instroduce a flag to indicate stack_depot's ready
>>>>
>>>>       try to solve the kmemleak's late ready issue.
>>>>
>>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c index 762b91f..7eb24bc
>>>> 100644
>>>> --- a/mm/kmemleak.c
>>>> +++ b/mm/kmemleak.c
>>>> @@ -216,6 +216,7 @@ struct kmemleak_object {  static int
>>> kmemleak_warning;
>>>>    /* set if a fatal kmemleak error has occurred */  static int
>>>> kmemleak_error;
>>>> +static int kmemleak_stadep_initialized;
>>>>
>>>>    /* minimum and maximum address that may be valid pointers */  static
>>> unsigned long min_addr = ULONG_MAX; @@ -601,7 +602,7 @@ static noinline
>>> depot_stack_handle_t set_track_prepare(void)
>>>>           unsigned long entries[MAX_TRACE];
>>>>           unsigned int nr_entries;
>>>>
>>>> -       if (!kmemleak_initialized)
>>>> +       if (!kmemleak_stadep_initialized)
>>>>                   return 0;
>>>>           nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>>>>           trace_handle = stack_depot_save(entries, nr_entries,
>>> GFP_NOWAIT); @@ -2110,6 +2111,7 @@ void __init kmemleak_init(void)
>>>>                   create_object((unsigned long)__start_ro_after_init,
>>>>                                 __end_ro_after_init -
>>> __start_ro_after_init,
>>>>                                 KMEMLEAK_GREY, GFP_ATOMIC);
>>>> +       kmemleak_stadep_initialized = 1;
>>>>    }
>>>
>>> Hi, Zhaoyang,
>>>
>>> Sorry, applied the patch and rebuilt, but it didn't work for me:
>>>
>>> [root@pc-mtodorov marvin]# uname -rms
>>> Linux 6.2.0-rc3-mglru-kmemlk-patch-zhaoyang1+ x86_64 [root@pc-mtodorov
>>> marvin]# cat /sys/kernel/debug/kmemleak [root@pc-mtodorov marvin]# echo
>>> scan | tee !$ echo scan | tee /sys/kernel/debug/kmemleak scan
>>> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak unreferenced
>>> object 0xffff98938fed1ee0 (size 16):
>>>    comm "kworker/u12:2", pid 57, jiffies 4294894053 (age 66.616s)
>>>    hex dump (first 16 bytes):
>>>      6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
>>>    backtrace:
>>> [root@pc-mtodorov marvin]#
>>>
>>> Still the stack backtrace list is severed.
>>> CONFIG_STACKDEPOT and CONFIG_STACKTRACE are both "=y":
>>>
>>> [root@pc-mtodorov marvin]# grep -E 'CONFIG_(STACKTRACE|STACKDEPOT)'
>>> /boot/config-6.2.0-rc3-mglru-kmemlk-patch-zhaoyang1+
>>> CONFIG_STACKTRACE_SUPPORT=y
>>> CONFIG_STACKDEPOT=y
>>> # CONFIG_STACKTRACE_BUILD_ID is not set
>>> CONFIG_STACKTRACE=y
>>> [root@pc-mtodorov marvin]#
>>>
>>> Your patch was successfully applied (after some tweaks):
>>>
>>> mtodorov@domac:~/linux/kernel/linux_torvalds$ git diff mm diff --git
>>> a/mm/kmemleak.c b/mm/kmemleak.c index 92f670edbf51..78fd3b89b057
>>> 100644
>>> --- a/mm/kmemleak.c
>>> +++ b/mm/kmemleak.c
>>> @@ -216,6 +216,7 @@ static int kmemleak_initialized;
>>>   static int kmemleak_warning;
>>>   /* set if a fatal kmemleak error has occurred */
>>>   static int kmemleak_error;
>>> +static int kmemleak_stadep_initialized;
>>>
>>>   /* minimum and maximum address that may be valid pointers */
>>>   static unsigned long min_addr = ULONG_MAX; @@ -601,7 +602,7 @@ static
>>> noinline depot_stack_handle_t set_track_prepare(void)
>>>          unsigned long entries[MAX_TRACE];
>>>          unsigned int nr_entries;
>>>
>>> -       if (!kmemleak_initialized)
>>> +       if (!kmemleak_stadep_initialized)
>>>                  return 0;
>>>          nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>>>          trace_handle = stack_depot_save(entries, nr_entries,
>>> GFP_NOWAIT); @@ -2110,6 +2111,7 @@ void __init kmemleak_init(void)
>>>                  create_object((unsigned long)__start_ro_after_init,
>>>                                __end_ro_after_init -
>>> __start_ro_after_init,
>>>                                KMEMLEAK_GREY, GFP_ATOMIC);
>>> +       kmemleak_stadep_initialized = 1;
>>>   }
>>>
>>>   /*
>>> mtodorov@domac:~/linux/kernel/linux_torvalds$
>>>
>>> Please verify that the above is correct.
>> It is correct. Another reason could be the stack is less than 3 layers which could be surpassed by stack_trace_save. Could you please try to modify the code as bellow and try again.
>> static noinline depot_stack_handle_t set_track_prepare(void)
>> {
>>     depot_stack_handle_t trace_handle;
>>     unsigned long entries[MAX_TRACE];
>>     unsigned int nr_entries;
>>
>>     if (!kmemleak_initialized)
>>         return 0;
>> -    nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>> +    nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
>>     trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>>
>>     return trace_handle;
>> }
> 
> Tried that, rebuilt, still no luck:
> 
> [root@pc-mtodorov marvin]# uname -rms
> Linux 6.2.0-rc3-mglru-kmemlk-patch-zhaoyang2+ x86_64
> [root@pc-mtodorov marvin]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8e8c86483c00 (size 16):
>   comm "kworker/u12:5", pid 364, jiffies 4294894029 (age 135.024s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
>   backtrace:
> unreferenced object 0xffff8e8c8edb3f70 (size 16):
>   comm "kworker/u12:5", pid 364, jiffies 4294894033 (age 135.008s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00  memstick0.......
>   backtrace:
> [root@pc-mtodorov marvin]#
> 
> What I have here is:
> 
> static noinline depot_stack_handle_t set_track_prepare(void)
> {
>         depot_stack_handle_t trace_handle;
>         unsigned long entries[MAX_TRACE];
>         unsigned int nr_entries;
> 
>         if (!kmemleak_stadep_initialized)
>                 return 0;
>         nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
>         trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> 
>         return trace_handle;
> }
> 
> Maybe this will help (dmesg says that Stack Depot is disabled due to errors?):
> 
> [    0.072031] Memory: 16152080K/16658536K available (18432K kernel code, 4118K rwdata, 7184K rodata, 4420K init, 7684K bss, 506196K reserved, 0K cma-reserved)
> [    0.072219] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
> [    0.072222] Stack Depot allocating hash table of 1048576 entries with kvcalloc
> [    0.072226] swapper: vmalloc error: size 8388608, vm_struct allocation failed, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=(null),mems_allowed=0-1023
> [    0.072235] CPU: 0 PID: 0 Comm: swapper Not tainted 6.2.0-rc3-mglru-kmemlk-patch-zhaoyang2+ #23
> [    0.072237] Hardware name: LENOVO 10TX000VCR/3140, BIOS M22KT49A 11/10/2022
> [    0.072238] Call Trace:
> [    0.072240]  <TASK>
> [    0.072242]  dump_stack_lvl+0x49/0x63
> [    0.072248]  dump_stack+0x10/0x16
> [    0.072250]  warn_alloc.cold.161+0x75/0xe8
> [    0.072255]  ? __get_vm_area_node+0x14d/0x160
> [    0.072260]  __vmalloc_node_range+0x5e5/0x7d0
> [    0.072264]  ? stack_depot_init.cold.2+0x7e/0xb3
> [    0.072267]  ? __kmalloc_large_node+0xf8/0x150
> [    0.072270]  ? kvmalloc_node+0x4f/0xe0
> [    0.072274]  kvmalloc_node+0xb1/0xe0
> [    0.072276]  ? stack_depot_init.cold.2+0x7e/0xb3
> [    0.072278]  stack_depot_init.cold.2+0x7e/0xb3
> [    0.072280]  kmemleak_init+0x1b/0x114
> [    0.072284]  start_kernel+0x710/0x9dc
> [    0.072288]  x86_64_start_reservations+0x24/0x2a
> [    0.072290]  x86_64_start_kernel+0xf2/0xfd
> [    0.072292]  secondary_startup_64_no_verify+0xe5/0xeb
> [    0.072297]  </TASK>
> [    0.072298] Mem-Info:
> [    0.072299] active_anon:0 inactive_anon:0 isolated_anon:0
>                 active_file:0 inactive_file:0 isolated_file:0
>                 unevictable:0 dirty:0 writeback:0
>                 slab_reclaimable:0 slab_unreclaimable:26
>                 mapped:0 shmem:0 pagetables:0
>                 sec_pagetables:0 bounce:0
>                 kernel_misc_reclaimable:0
>                 free:4037994 free_pcp:0 free_cma:0
> [    0.072303] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:0kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
> [    0.072307] Node 0 DMA free:14336kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:14336kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.072311] lowmem_reserve[]: 0 0 0 0 0
> [    0.072314] Node 0 DMA32 free:2085160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:2257392kB managed:2085160kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.072318] lowmem_reserve[]: 0 0 0 0 0
> [    0.072321] Node 0 Normal free:14052480kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:14385152kB managed:14052844kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.072325] lowmem_reserve[]: 0 0 0 0 0
> [    0.072328] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 2*1024kB (UM) 2*2048kB (M) 2*4096kB (M) = 14336kB
> [    0.072338] Node 0 DMA32: 8*4kB (M) 9*8kB (M) 8*16kB (M) 8*32kB (M) 7*64kB (M) 7*128kB (M) 8*256kB (M) 7*512kB (M) 5*1024kB (M) 6*2048kB (M) 503*4096kB (M) = 2085160kB
> [    0.072352] Node 0 Normal: 8*4kB (UM) 8*8kB (M) 2*16kB (UM) 2*32kB (M) 1*64kB (M) 3*128kB (UM) 2*256kB (M) 4*512kB (UM) 2*1024kB (UM) 3*2048kB (UM) 3428*4096kB (M) = 14052480kB
> [    0.072366] 0 total pagecache pages
> [    0.072367] 0 pages in swap cache
> [    0.072367] Free swap  = 0kB
> [    0.072368] Total swap = 0kB
> [    0.072369] 4164634 pages RAM
> [    0.072369] 0 pages HighMem/MovableOnly
> [    0.072370] 126549 pages reserved
> [    0.072371] 0 pages hwpoisoned
> [    0.072372] Stack Depot hash table allocation failed, disabling

Hi again,

I have an additional info:

Here we see Stack Depot trying to alocate 1024 * 1024 entires on a 16 GiB RAM
AlmaLinux 8.7 (CentOS clone):

[    0.071875] Stack Depot allocating hash table of 1048576 entries with kvcalloc
[    0.071879] swapper: vmalloc error: size 8388608, vm_struct allocation failed, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=(null),mems_allowed=0-1023
[    0.071888] CPU: 0 PID: 0 Comm: swapper Not tainted 6.2.0-rc3-mglru-kmemlk-nokasan-fixed-rcu+ #2
[    0.071891] Hardware name: LENOVO 10TX000VCR/3140, BIOS M22KT49A 11/10/2022

On another machine with just 8 GiB this mechanism is less demanding, requests
slightly more than 512 * 1024 entries and succeeds:

[    0.037858] Stack Depot allocating hash table of 524288 entries with kvcalloc
[    0.038225] ftrace: allocating 52222 entries in 204 pages

I am not that deep into kernel code to debug this :-(

As plain kvcalloc() fails, the only thing that comes to mind - maybe 0.072 s
since boot is still too early to request 8.3 MB? What are the probable causes
that kvcalloc and vmalloc should fail?

Thanks,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

