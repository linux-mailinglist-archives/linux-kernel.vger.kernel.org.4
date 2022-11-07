Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7261EFA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiKGJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiKGJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:53:26 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED14338
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:53:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8BC3B604E7;
        Mon,  7 Nov 2022 10:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1667814801; bh=l4ul2SB6o/IgUz3ghD3x5ZhBD1gHB/BQL/YODe1kxrc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lqWv6mMdOu27kbEFAnT+UEHXv0LH7Je4gEDCBEQv9lJLLzUKFBCtvO/B7Dr2KGEaX
         2Ye9SIhAqWHYZNWa67HCrtpnSlm9NxLOl1muRE8ArOYm6qPfF/piaV9o/w+UOff6iB
         /IWqAXEfeQIOgGagD7V7HXb8cXrCE8ioG26+W7xT5RGg+VqcVjPIGpBSYwUudU6vSV
         lzDThPg0aMEpAOk9FXFhzDw50/7VciTQazPmpi4gmy1mWbIbNXH2fbepN1wEl9EkOs
         OJ5jZE0Y205IRs9/hSUmpZ9zl2X+as41COBxjpbUbg80rDyIQItlzh9tQ7Rd5H+kEN
         7BBDbQN2euyyA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MTcV9dNnC3sY; Mon,  7 Nov 2022 10:53:17 +0100 (CET)
Received: from [10.0.1.9] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 412E2604E6;
        Mon,  7 Nov 2022 10:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1667814797; bh=l4ul2SB6o/IgUz3ghD3x5ZhBD1gHB/BQL/YODe1kxrc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=tI/Vq+hbz14OuwfRpmAk5hOAhqDos+C8Oy/51Zc6xpex3f4D0RFwXcSK3OTRJXUsN
         z3L5bi6qDg6NVm+rfvkmq82zaasH3Y/2EHYulTuXvVcywGg6nXd0uhP8g8inHjPe3v
         DcSOrmacubZeZzoOqcihQtpClp9TA9PUOjyGHjU7cB5qy0vyQaI6QXdEV3hyzaCl7D
         Z4LtSf0PczLV/BcC+TT6G5plqbmhlAKhLlKq/7WpOXSIJq7zroPi188RTGas9SE+EA
         8LPMO1cz1doQISVWEjbOA8rf/rdE+eqkQJspy84xBwfNRpJUc7wrSg+GWSdM0MXfLM
         quTjb21Z2KYjw==
Message-ID: <ccfca0ea-ac3a-0319-f1a5-bd14ad731fbc@alu.unizg.hr>
Date:   Mon, 7 Nov 2022 10:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: INFO: rcu_preempt detected expedited stalls on CPUs/tasks
 (6.1.0-rc3): in cat /sys/kernel/debug/kmemleak
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <e048a5c5-dea5-a31a-1022-1b007e022adb@alu.unizg.hr>
 <5372edc0b0a45de9286a2d4948e9858dcb9741fc.camel@linux.intel.com>
 <32da7e3f-8608-29a9-3787-1d4c3315d235@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <32da7e3f-8608-29a9-3787-1d4c3315d235@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 2022. 00:39, Mirsad Goran Todorovac wrote:

> On 05. 11. 2022. 00:00, srinivas pandruvada wrote:
>
>> On Fri, 2022-11-04 at 23:01 +0100, Mirsad Goran Todorovac wrote:
>>> Dear all,
>>>
>>> When investigating thermald kmemleak, it occurred that the "cat
>>> /sys/kernel/debug/kmemleak"
>>> and "tail -20 /sys/kernel/debug/kmemleak" commands take unusual
>>> amount
>>> of time.
>>>
>> This memleak occurred because of bad element in the BIOS configuration
>> of _OSC method.
>> Unfortunately fixing this in ACPI interpreter can have other side
>> effects as this is not expected. So the ACPICA team
>> (https://acpica.org/community) is looking further.
>>
>> Thanks,
>> Srinivas
>
> Dear Mr. Srinivas,
>
> Thank you for the update.
>
> However, the investigation on thermald memleak had lead to discovery 
> of the RCU stalls
> in the kmemleak itself. I felt it correct to include you in Cc: 
> because thermald caused the
> leaks in question. I suspected myself it is the problem specific to my 
> Lenovo Ideapad 3 Intel core
> i5 laptop's BIOS, because I couldn't reproduce it on the other 
> (desktop Lenovo) computer.
>
> Thank you very much,
> Mirsad
>
I felt it prudent to report that the issue is still present in 6.1.0-rc4 
kernel:

Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004752] rcu: 
INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 5-.... } 6 
jiffies s: 1021 root: 0x20/.
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004777] rcu: 
blocking rcu_node structures (internal RCU debug):
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004782] Sending 
NMI from CPU 3 to CPUs 5:
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004796] NMI 
backtrace for cpu 5
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004802] CPU: 5 
PID: 11912 Comm: tail Not tainted 6.1.0-rc4 #1
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004808] Hardware 
name: LENOVO 82H8/LNVNB161216, BIOS GGCN34WW 03/08/2022
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004810] RIP: 
0010:kmemleak_seq_start+0x41/0x80
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004821] Code: e5 
f5 a5 00 4c 63 e0 85 c0 78 40 e8 09 81 db ff 48 8b 05 d2 fe 88 01 4c 8d 
60 f8 48 3d b0 63 03 ad 75 17 eb 32 49 8b 44 24 08 <48> 83 eb 01 4c 8d 
60 f8 48 3d b0 63 03 ad 74 1d 48 85 db 7f e6 4c
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004825] RSP: 
0018:ffffa7e621bc7cd8 EFLAGS: 00000202
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004829] RAX: 
ffff8efb493ae008 RBX: 00000000000418cd RCX: 0000000000000001
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004833] RDX: 
ffff8efc709da000 RSI: ffff8efb415937a8 RDI: ffffffffad036340
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004835] RBP: 
ffffa7e621bc7ce8 R08: 0000000000002000 R09: ffff8efb44502f80
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004837] R10: 
0000000000020000 R11: 0000000000000000 R12: ffff8efb493af0a0
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004839] R13: 
ffff8efb5c6d6200 R14: ffff8efb41593780 R15: ffffa7e621bc7ed8
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004841] FS:  
00007f55020df740(0000) GS:ffff8efce8940000(0000) knlGS:0000000000000000
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004844] CS:  0010 
DS: 0000 ES: 0000 CR0: 0000000080050033
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004847] CR2: 
00001d8300d0c000 CR3: 0000000266aaa003 CR4: 0000000000770ee0
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004850] PKRU: 
55555554
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004851] Call Trace:
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004853] <TASK>
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004856] 
seq_read_iter+0x169/0x420
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004862]  ? 
seq_read+0xad/0xe0
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004867] 
seq_read+0xad/0xe0
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004871] 
full_proxy_read+0x59/0x90
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004880] 
vfs_read+0xb2/0x2e0
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004887] 
ksys_read+0x61/0xe0
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004893] 
__x64_sys_read+0x1a/0x20
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004898] 
do_syscall_64+0x58/0x80
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004905]  ? 
common_interrupt+0x54/0xa0
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004911] 
entry_SYSCALL_64_after_hwframe+0x63/0xcd
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004917] RIP: 
0033:0x7f5501f14992
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004922] Code: c0 
e9 b2 fe ff ff 50 48 8d 3d fa b2 0c 00 e8 c5 1d 02 00 0f 1f 44 00 00 f3 
0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 
77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004925] RSP: 
002b:00007ffef4b4ce18 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004929] RAX: 
ffffffffffffffda RBX: 0000000000002000 RCX: 00007f5501f14992
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004931] RDX: 
0000000000002000 RSI: 000055f43da40160 RDI: 0000000000000003
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004933] RBP: 
000055f43da40160 R08: 000055f43da40fba R09: 000055f43da42180
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004935] R10: 
0000000000000077 R11: 0000000000000246 R12: 0000000000000e5a
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004937] R13: 
0000000000000003 R14: 000055f43da42180 R15: 0000000000000003
Nov  7 10:50:08 marvin-IdeaPad-3-15ITL6 kernel: [ 2369.004943] </TASK>

Thank you,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

