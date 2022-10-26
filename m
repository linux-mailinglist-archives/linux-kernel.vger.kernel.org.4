Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746BC60E0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiJZMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiJZMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:32:25 -0400
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A406973936
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:32:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9EAE2604ED;
        Wed, 26 Oct 2022 14:32:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666787540; bh=ii1Af+KtMsbFu/BXjMLxfpO0iqaegju++PSx4gnAX9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e2/+sE2ml+9l61xjEsV4R439ihc3tWBsDYMn2LGrc27ara5OME2P64XoWS95azRv4
         TeyTSJ466NfW1FZbsYIijVO72NP1GC1YyJWRL282dBAs5g9on2qmw/+hHGiBH1z1zA
         hKu6JISUxrp/LbO7CF+gcr9Mbed4swWkdproVww40TL2w/2AG+pa56d92dBo5juS/F
         ikBVeL4/151A68ro070SVJMkYEQnOe/ddVldoHngvINeNz1Qg3vr4V+v9Ex2xuuZhK
         91Attzz+Rz/GSH95GCx87fQX9ZKewwmfZkwLhzREVpHQn4v9YUkTG8H25wqKZoJK1A
         5/AHF6MF7iv2g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s0y5GihQF29s; Wed, 26 Oct 2022 14:32:17 +0200 (CEST)
Received: from [193.198.186.200] (PC-MTODOROV.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 922E6604EC;
        Wed, 26 Oct 2022 14:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1666787537; bh=ii1Af+KtMsbFu/BXjMLxfpO0iqaegju++PSx4gnAX9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bFe9fRpNme+jMw3wiXUNVvSzHXygxBmFF6MiQDKtJv2aIBXOvYChNxPyNaMAqpRjJ
         H8FTlZC9cYG1jKDfVBhqg1ry83t6+WiezNdNTvNDOCsazFVSZKoTJff/UOlRHQXlMD
         /0zOwyohPcnIOmU1QxmG5qDUpdhyxhoZwUOpe9+IzfdnVXA6V/VNzk7VEUfvgJBBpt
         njrzBHIFQKHzEG2IUNHInczAkhwJpgs4xy2iXN1IRI5e5jPa0NFGk+HyTjZvBY/zvA
         kcKtWniMlDS6o/Qv2WClQRbp8ZIBQO5Po4Ta8o2wf27+DMkgBMpISrcw1eY1oX8uj5
         DgP0KInd4Cfyw==
Message-ID: <f045aaa8-0c14-10e4-f8dd-50abbe5a3f17@alu.unizg.hr>
Date:   Wed, 26 Oct 2022 14:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit
 c7ff29763989bd09c433f73fae3c1e1c15d9cda4 #forregzbot
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     regressions@lists.linux.dev
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
 <e75adcf8-68ce-e521-301c-177928d8aae9@leemhuis.info>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <e75adcf8-68ce-e521-301c-177928d8aae9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2022 10:08 AM, Thorsten Leemhuis wrote:

> [Note: this mail is primarily send for documentation purposes and/or for
> regzbot, my Linux kernel regression tracking bot. That's why I removed
> most or all folks from the list of recipients, but left any that looked
> like a mailing lists. These mails usually contain '#forregzbot' in the
> subject, to make them easy to spot and filter out.]
>
> [TLDR: I'm adding this regression report to the list of tracked
> regressions; all text from me you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.]
>
> Hi, this is your Linux kernel regression tracker.
>
> On 24.10.22 15:13, Mirsad Goran Todorovac wrote:
>> Dear all,
>>
>> Around Sep 27th 2022 I've noticed in a mainline kernel built with
>> CONFIG_DEBUG_KMEMLEAK=y
>> that there actually is a leak:
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
>
> #regzbot ^introduced c7ff29763989bd
> #regzbot title thermald regression (MEMLEAK)
> #regzbot ignore-activity
>
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply -- ideally with also
> telling regzbot about it, as explained here:
> https://linux-regtracking.leemhuis.info/tracked-regression/

You're welcome, no thanks needed.

Is this really a regression? I can't tell if this is a one-time memory 
leak in thermald, or can it be
exploited for causing memory leaks in a loop, exhausting kernel memory 
and producing denial-of-service
or kernel crash.

Thanks,
Mirsad

> Reminder for developers: When fixing the issue, add 'Link:' tags
> pointing to the report (the mail this one replies to), as explained for
> in the Linux kernel's documentation; above webpage explains why this is
> important for tracked regressions.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>
>
>> |sudo cat /sys/kernel/debug/kmemleak unreferenced object
>> 0xffff8881095f3ee0 (size 80): comm "thermald", pid 837, jiffies
>> 4294896698 (age 9867.428s) hex dump (first 32 bytes): 00 00 00 00 00 00
>> 00 00 0d 01 2d 00 00 00 00 00 ..........-..... af 07 01 00 00 c9 ff ff
>> 00 00 00 00 00 00 00 00 ................ backtrace: [<00000000b50b9dd6>]
>> kmem_cache_alloc+0x184/0x380 [<00000000fa8428c0>]
>> acpi_os_acquire_object+0x2c/0x32 [<000000002cc0099f>]
>> acpi_ps_alloc_op+0x65/0xe6 [<00000000335faf1b>]
>> acpi_ps_get_next_arg+0x842/0x9ed [<000000007afa2dee>]
>> acpi_ps_parse_loop+0x718/0xee1 [<0000000010ce490e>]
>> acpi_ps_parse_aml+0x261/0x7b2 [<00000000278d4c5f>]
>> acpi_ps_execute_method+0x360/0x459 [<00000000ff7ad4ba>]
>> acpi_ns_evaluate+0x595/0x810 [<0000000037ce3488>]
>> acpi_evaluate_object+0x28b/0x5b2 [<000000001a800bbf>]
>> acpi_run_osc+0x209/0x3d0 [<00000000776fbd43>]
>> int3400_thermal_run_osc+0xed/0x180 [int3400_thermal]
>> [<00000000d6ec2302>] current_uuid_store+0x17c/0x1d0 [int3400_thermal]
>> [<00000000486cf3e6>] dev_attr_store+0x3e/0x60 [<00000000bf193027>]
>> sysfs_kf_write+0x88/0xa0 [<00000000820b5cce>]
>> kernfs_fop_write_iter+0x1c9/0x270 [<0000000062f8d35e>]
>> vfs_write+0x5a5/0x750 Mr. Pandruvada required a bug bisect from me, so I
>> have eventually made one. # first bad commit:
>> [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal: int340x: Update OS
>> policy capability handshake Here is the git bisect log:
>> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log git bisect
>> start # good: [b6abb62daa5511c4a3eaa30cbdb02544d1f10fa2] Linux 5.15.1
>> git bisect good b6abb62daa5511c4a3eaa30cbdb02544d1f10fa2 # bad:
>> [e6f4ff3f91251f67b130c29f38673eb5702f88b9] Linux 6.0.3 git bisect bad
>> e6f4ff3f91251f67b130c29f38673eb5702f88b9 # good:
>> [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15 git bisect good
>> 8bb7eca972ad531c9b149c0a51ab43a417385813 # bad:
>> [1464677662943738741500a6f16b85d36bbde2be] Merge tag
>> 'platform-drivers-x86-v5.18-1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
>> git bisect bad 1464677662943738741500a6f16b85d36bbde2be # good:
>> [8efd0d9c316af470377894a6a0f9ff63ce18c177] Merge tag '5.17-net-next' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next git bisect
>> good 8efd0d9c316af470377894a6a0f9ff63ce18c177 # good:
>> [aaa25a2fa7964d94690f6de5edd7164ca7d76555] Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net git bisect good
>> aaa25a2fa7964d94690f6de5edd7164ca7d76555 # bad:
>> [b4bc93bd76d4da32600795cd323c971f00a2e788] Merge tag 'arm-drivers-5.18'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc git bisect bad
>> b4bc93bd76d4da32600795cd323c971f00a2e788 # bad:
>> [ef510682af3dbe2f9cdae7126a1461c94e010967] Merge tag 'f2fs-for-5.18' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs git bisect
>> bad ef510682af3dbe2f9cdae7126a1461c94e010967 # good:
>> [a04b1bf574e1f4875ea91f5c62ca051666443200] Merge tag 'for-5.18/parisc-1'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux git
>> bisect good a04b1bf574e1f4875ea91f5c62ca051666443200 # bad:
>> [b080cee72ef355669cbc52ff55dc513d37433600] Merge tag
>> 'for-5.18/io_uring-statx-2022-03-18' of git://git.kernel.dk/linux-block
>> git bisect bad b080cee72ef355669cbc52ff55dc513d37433600 # good:
>> [02b82b02c34321dde10d003aafcd831a769b2a8a] Merge tag 'pm-5.18-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm git bisect
>> good 02b82b02c34321dde10d003aafcd831a769b2a8a # good:
>> [0e03b8fd29363f2df44e2a7a176d486de550757a] crypto: xilinx - Turn SHA
>> into a tristate and allow COMPILE_TEST git bisect good
>> 0e03b8fd29363f2df44e2a7a176d486de550757a # good:
>> [3e504d2026eb6c8762cd6040ae57db166516824a] random: check for signal and
>> try earlier when generating entropy git bisect good
>> 3e504d2026eb6c8762cd6040ae57db166516824a # good:
>> [5e929367468c8f97cd1ffb0417316cecfebef94b] io_uring: terminate manual
>> loop iterator loop correctly for non-vecs git bisect good
>> 5e929367468c8f97cd1ffb0417316cecfebef94b # bad:
>> [2d6fc1455f3f383499e013ebc4b19ff49c53c15e] Merge branches
>> 'thermal-powerclamp', 'thermal-int340x' and 'thermal-docs' git bisect
>> bad 2d6fc1455f3f383499e013ebc4b19ff49c53c15e # good:
>> [1d6aab36a26ba44b114d7f8a857c430c9e0c32c9]
>> thermal/drivers/ti-soc-thermal: Remove unused function
>> ti_thermal_get_temp() git bisect good
>> 1d6aab36a26ba44b114d7f8a857c430c9e0c32c9 # bad:
>> [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal: int340x: Update OS
>> policy capability handshake git bisect bad
>> c7ff29763989bd09c433f73fae3c1e1c15d9cda4 # good:
>> [098c874e20be2a4cee3021aa9b3485ed5e1f4d5b] thermal: Replace
>> acpi_bus_get_device() git bisect good
>> 098c874e20be2a4cee3021aa9b3485ed5e1f4d5b # good:
>> [668f69a5f863b877bc3ae129efe9a80b6f055141] thermal: int340x: Increase
>> bitmap size git bisect good 668f69a5f863b877bc3ae129efe9a80b6f055141 #
>> first bad commit: [c7ff29763989bd09c433f73fae3c1e1c15d9cda4] thermal:
>> int340x: Update OS policy capability handshake You have new mail in
>> /var/mail/mtodorov mtodorov@domac:~/linux/kernel/linux_stable$ I was
>> unable to locate the culprit in the patch myself. Thank you very much
>> for your attention. I am available for all further questions. Have a
>> nice day :) Regards, |
>>
-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
--
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

