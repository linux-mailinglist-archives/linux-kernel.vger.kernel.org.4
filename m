Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1168F871
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjBHTzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBHTzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:55:39 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89AE25BBD;
        Wed,  8 Feb 2023 11:55:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 73F4F604EF;
        Wed,  8 Feb 2023 20:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1675886133; bh=PboEW/f44zxH+nOazdCeV3GWj1wEoqxUkez+F1kjtNA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=GChyirwaNUnwsGC+UWcS0yrCmuZGt9+w1JLkT8yFgYZgnxDnQ6ZUJIw1tXD+348xt
         F/rc1h8WygBAcQMdiIpYSxPhomS4FshA3T/VLwOPfpLVSVNtbw9Xfst9AWhFbhcS++
         XlMBU/OT2cDSazvCAUIpdyfcevPfTNaswd3D0HsR1fCQtjB4zZxg7MBR02aZBE04WQ
         1T3fVMikV/ga5+5OR2RPU5DTA3q6sgcTJ9eJ/8MOO0BW1+wwzLYInPjh1rDNlqQiYw
         mUsYdQTYQFqRLg/oNkjAsC5VxuIjHZM3ejf1LzkLZ6pELBKA88E2syecNP6kXdAa1G
         mrqiOWrLzNA7w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id saVoMqH-0yLs; Wed,  8 Feb 2023 20:55:30 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 1827E604EA;
        Wed,  8 Feb 2023 20:55:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1675886130; bh=PboEW/f44zxH+nOazdCeV3GWj1wEoqxUkez+F1kjtNA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=WrXGs7EwZR8nvWNkMtfNpfPuckebm7sL3xni//BclHarI0vDYTEFQoNDu+dm5qpWy
         +9Ep7uQimMV2HQ85U06nT0ZtPI4PkFukNhN2auO443zFyiy5Eytw7j+PjsPHr2tdqN
         xv+MOfJ8VTKf6M2v8d+5TRmZp074y9hh/1bk5NMXChSRGSC0p4TJLxuz+0w5Lsi7XN
         htH9tEGnszy/e/J36ltfl19osmZDNDlesslQ0A6WOh48bNc2wtweWG0W+4fMuzK2A8
         P8suOTAhHuN4XQLepBYUbcBXEAtZ0N060z/Bh46D8rAyZgjzoLsUOj1yvKvnsLyr4d
         5ZiVK198Z+BQw==
Content-Type: multipart/mixed; boundary="------------04uoXsyNMUryBorWPQsdx8hc"
Message-ID: <fb12086b-ff5f-333a-3199-a8690c4d4bdf@alu.unizg.hr>
Date:   Wed, 8 Feb 2023 20:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: INFO: REPRODUCED: memory leak in gpio device in 6.2-rc6
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
Content-Language: en-US, hr
In-Reply-To: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------04uoXsyNMUryBorWPQsdx8hc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

On 31. 01. 2023. 10:36, Mirsad Goran Todorovac wrote:
> Hi all,
> 
> I came across this memory leak apparently in the GPIO device driver.
> It is still present in 6.2-rc6 release candidate kernel (just ran kselftest).
> 
> This is a vanilla Torvalds tree kernel with MGLRU and KMEMLEAK (obviously)
> enabled.
> 
> If you think this bug is significant, I can attempt the bug bisect in the
> environment that triggered it (Lenovo LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
> with BIOS M22KT49A from 11/10/2022 and AlmaLinux 8.7.
> 
> Here is the /sys/kernel/debug/kmemleak output:
> 
> unreferenced object 0xffff9e67ad71f160 (size 32):
>   comm "gpio-sim.sh", pid 208926, jiffies 4372229685 (age 2101.564s)
>   hex dump (first 32 bytes):
>     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000098bf3d1b>] slab_post_alloc_hook+0x91/0x320
>     [<00000000da3205c5>] __kmem_cache_alloc_node+0x1bf/0x2b0
>     [<00000000aa51a58a>] __kmalloc_node_track_caller+0x55/0x140
>     [<00000000bd682ecc>] kvasprintf+0x6b/0xd0
>     [<00000000a3431d55>] kasprintf+0x4e/0x70
>     [<00000000f52d2629>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
>     [<00000000673fc6df>] configfs_write_iter+0xcc/0x130
>     [<000000001d5d0829>] vfs_write+0x2b4/0x3d0
>     [<00000000d2336251>] ksys_write+0x61/0xe0
>     [<00000000f7015bb1>] __x64_sys_write+0x1a/0x20
>     [<000000008ac743d2>] do_syscall_64+0x58/0x80
>     [<000000004d7b7d50>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [root@pc-mtodorov marvin]#

The new development on the bug is that it probably requires some superuser privileges
or some capability to be exploited, for it requires access to configfs,
but it was reproduced on different hardware as well.

The minimum reproducing script is attached, with its output log.

From the testing "age" of the unreferenced object I assume that it is allocated earlier
in a part of script I am unable to locate or specify, but orphaned at the end of the script.

root@/home/user/kernel_bugs/gpio-sim# time ./gpio-reproduce-min.sh
2.14. Lines can be hogged
Scanning stage 2.14.7 ... done.
Sleeping 60 seconds ... done.
Stage 2.14.7 clean.
Rescanning stage 2.14.7 ... done.
Sleeping 60 seconds ... done.
unreferenced object 0xffff9593b9d16bc0 (size 32):
  comm "gpio-reproduce-", pid 7594, jiffies 4295865460 (age 136.184s)
  hex dump (first 32 bytes):
    67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
    [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
    [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
    [<000000000c0f91cd>] kasprintf+0x4e/0x70
    [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
    [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
    [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
    [<000000008a17e041>] ksys_write+0x61/0xe0
    [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
    [<00000000e1220148>] do_syscall_64+0x58/0x80
    [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

real	2m16.398s
user	0m0.023s
sys	0m16.360s
root@/home/user/kernel_bugs/gpio-sim# 

The effect is cummulative:

root@marvin-IdeaPad-3-15ITL6:/home/user/kernel_bugs/gpio-sim# cat /sys/kernel/debug/kmemleak 
unreferenced object 0xffff9593b9d16bc0 (size 32):
  comm "gpio-reproduce-", pid 7594, jiffies 4295865460 (age 520.296s)
  hex dump (first 32 bytes):
    67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
    [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
    [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
    [<000000000c0f91cd>] kasprintf+0x4e/0x70
    [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
    [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
    [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
    [<000000008a17e041>] ksys_write+0x61/0xe0
    [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
    [<00000000e1220148>] do_syscall_64+0x58/0x80
    [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
unreferenced object 0xffff95938918fb40 (size 32):
  comm "gpio-reproduce-", pid 7675, jiffies 4295954327 (age 164.832s)
  hex dump (first 32 bytes):
    67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
    [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
    [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
    [<000000000c0f91cd>] kasprintf+0x4e/0x70
    [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
    [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
    [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
    [<000000008a17e041>] ksys_write+0x61/0xe0
    [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
    [<00000000e1220148>] do_syscall_64+0x58/0x80
    [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
unreferenced object 0xffff9594a3cf1820 (size 32):
  comm "gpio-reproduce-", pid 7721, jiffies 4295976853 (age 74.728s)
  hex dump (first 32 bytes):
    67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000fe76444b>] __kmem_cache_alloc_node+0x380/0x4e0
    [<0000000099f63f55>] __kmalloc_node_track_caller+0x55/0x140
    [<00000000c4efe87f>] kvasprintf+0x6b/0xd0
    [<000000000c0f91cd>] kasprintf+0x4e/0x70
    [<000000003434d9b5>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
    [<0000000052ce6759>] configfs_write_iter+0xcc/0x130
    [<0000000006087fd2>] vfs_write+0x2b4/0x3d0
    [<000000008a17e041>] ksys_write+0x61/0xe0
    [<000000007bded8ea>] __x64_sys_write+0x1a/0x20
    [<00000000e1220148>] do_syscall_64+0x58/0x80
    [<0000000006093069>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
root@marvin-IdeaPad-3-15ITL6:/home/user/kernel_bugs/gpio-sim# 

With sufficient privileges (or possibly even without them), an exploit can be devised
to automate allocation of orphaned objects, at a rate of a couple per second (PoC attached).

Regards,

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

--------------04uoXsyNMUryBorWPQsdx8hc
Content-Type: text/x-log; charset=UTF-8; name="gpio-trace.log"
Content-Disposition: attachment; filename="gpio-trace.log"
Content-Transfer-Encoding: base64

Mi4xNC4gTGluZXMgY2FuIGJlIGhvZ2dlZApTY2FubmluZyBzdGFnZSAyLjE0LjAgLi4uIGRv
bmUuClNsZWVwaW5nIDYwIHNlY29uZHMgLi4uIGRvbmUuClN0YWdlIDIuMTQuMCBjbGVhbi4K
UmVzY2FubmluZyBzdGFnZSAyLjE0LjAgLi4uIGRvbmUuClNsZWVwaW5nIDYwIHNlY29uZHMg
Li4uIGRvbmUuClN0YWdlIDIuMTQuMCByZS1jaGVjayBjbGVhbi4KUmUtcmVzY2FubmluZyBz
dGFnZSAyLjE0LjAgLi4uIGRvbmUuClNsZWVwaW5nIDYwIHNlY29uZHMgLi4uIGRvbmUuClN0
YWdlIDIuMTQuMCByZS1jaGVjayBjbGVhbi4KU2Nhbm5pbmcgc3RhZ2UgMi4xNC4xIC4uLiBk
b25lLgpTbGVlcGluZyA2MCBzZWNvbmRzIC4uLiBkb25lLgpTdGFnZSAyLjE0LjEgY2xlYW4u
ClJlc2Nhbm5pbmcgc3RhZ2UgMi4xNC4xIC4uLiBkb25lLgpTbGVlcGluZyA2MCBzZWNvbmRz
IC4uLiBkb25lLgpTdGFnZSAyLjE0LjEgcmUtY2hlY2sgY2xlYW4uClJlLXJlc2Nhbm5pbmcg
c3RhZ2UgMi4xNC4xIC4uLiBkb25lLgpTbGVlcGluZyA2MCBzZWNvbmRzIC4uLiBkb25lLgpT
dGFnZSAyLjE0LjEgcmUtY2hlY2sgY2xlYW4uClNjYW5uaW5nIHN0YWdlIDIuMTQuMiAuLi4g
ZG9uZS4KU2xlZXBpbmcgNjAgc2Vjb25kcyAuLi4gZG9uZS4KU3RhZ2UgMi4xNC4yIGNsZWFu
LgpSZXNjYW5uaW5nIHN0YWdlIDIuMTQuMiAuLi4gZG9uZS4KU2xlZXBpbmcgNjAgc2Vjb25k
cyAuLi4gZG9uZS4KU3RhZ2UgMi4xNC4yIHJlLWNoZWNrIGNsZWFuLgpSZS1yZXNjYW5uaW5n
IHN0YWdlIDIuMTQuMiAuLi4gZG9uZS4KU2xlZXBpbmcgNjAgc2Vjb25kcyAuLi4gZG9uZS4K
U3RhZ2UgMi4xNC4yIHJlLWNoZWNrIGNsZWFuLgpTY2FubmluZyBzdGFnZSAyLjE0LjMgLi4u
IGRvbmUuClNsZWVwaW5nIDYwIHNlY29uZHMgLi4uIGRvbmUuClN0YWdlIDIuMTQuMyBjbGVh
bi4KUmVzY2FubmluZyBzdGFnZSAyLjE0LjMgLi4uIGRvbmUuClNsZWVwaW5nIDYwIHNlY29u
ZHMgLi4uIGRvbmUuClN0YWdlIDIuMTQuMyByZS1jaGVjayBjbGVhbi4KUmUtcmVzY2Fubmlu
ZyBzdGFnZSAyLjE0LjMgLi4uIGRvbmUuClNsZWVwaW5nIDYwIHNlY29uZHMgLi4uIGRvbmUu
ClN0YWdlIDIuMTQuMyByZS1jaGVjayBjbGVhbi4KU2Nhbm5pbmcgc3RhZ2UgMi4xNC40IC4u
LiBkb25lLgpTbGVlcGluZyA2MCBzZWNvbmRzIC4uLiBkb25lLgpTdGFnZSAyLjE0LjQgY2xl
YW4uClJlc2Nhbm5pbmcgc3RhZ2UgMi4xNC40IC4uLiBkb25lLgpTbGVlcGluZyA2MCBzZWNv
bmRzIC4uLiBkb25lLgpTdGFnZSAyLjE0LjQgcmUtY2hlY2sgY2xlYW4uClJlLXJlc2Nhbm5p
bmcgc3RhZ2UgMi4xNC40IC4uLiBkb25lLgpTbGVlcGluZyA2MCBzZWNvbmRzIC4uLiBkb25l
LgpTdGFnZSAyLjE0LjQgcmUtY2hlY2sgY2xlYW4uClNjYW5uaW5nIHN0YWdlIDIuMTQuNSAu
Li4gZG9uZS4KU2xlZXBpbmcgNjAgc2Vjb25kcyAuLi4gZG9uZS4KU3RhZ2UgMi4xNC41IGNs
ZWFuLgpSZXNjYW5uaW5nIHN0YWdlIDIuMTQuNSAuLi4gZG9uZS4KU2xlZXBpbmcgNjAgc2Vj
b25kcyAuLi4gZG9uZS4KU3RhZ2UgMi4xNC41IHJlLWNoZWNrIGNsZWFuLgpSZS1yZXNjYW5u
aW5nIHN0YWdlIDIuMTQuNSAuLi4gZG9uZS4KU2xlZXBpbmcgNjAgc2Vjb25kcyAuLi4gZG9u
ZS4KU3RhZ2UgMi4xNC41IHJlLWNoZWNrIGNsZWFuLgpTY2FubmluZyBzdGFnZSAyLjE0LjYg
Li4uIGRvbmUuClNsZWVwaW5nIDYwIHNlY29uZHMgLi4uIGRvbmUuClN0YWdlIDIuMTQuNiBj
bGVhbi4KUmVzY2FubmluZyBzdGFnZSAyLjE0LjYgLi4uIGRvbmUuClNsZWVwaW5nIDYwIHNl
Y29uZHMgLi4uIGRvbmUuClN0YWdlIDIuMTQuNiByZS1jaGVjayBjbGVhbi4KUmUtcmVzY2Fu
bmluZyBzdGFnZSAyLjE0LjYgLi4uIGRvbmUuClNsZWVwaW5nIDYwIHNlY29uZHMgLi4uIGRv
bmUuClN0YWdlIDIuMTQuNiByZS1jaGVjayBjbGVhbi4KU2Nhbm5pbmcgc3RhZ2UgMi4xNC43
IC4uLiBkb25lLgpTbGVlcGluZyA2MCBzZWNvbmRzIC4uLiBkb25lLgpTdGFnZSAyLjE0Ljcg
Y2xlYW4uClJlc2Nhbm5pbmcgc3RhZ2UgMi4xNC43IC4uLiBkb25lLgpTbGVlcGluZyA2MCBz
ZWNvbmRzIC4uLiBkb25lLgogIGNvbW0gImdwaW8tc2ltLXJlcHJvZCIsIHBpZCA3NDM1OSwg
amlmZmllcyA0MzE3NjE3ODczIChhZ2UgNTMxLjk0MHMpCiAgICA2NyA3MCA2OSA2ZiAyZCA3
MyA2OSA2ZCAyZSAzMCAyZCA2ZSA2ZiA2NCA2NSAzMCAgZ3Bpby1zaW0uMC1ub2RlMApSZS1y
ZXNjYW5uaW5nIHN0YWdlIDIuMTQuNyAuLi4gZG9uZS4KU2xlZXBpbmcgNjAgc2Vjb25kcyAu
Li4gZG9uZS4KICBjb21tICJncGlvLXNpbS1yZXByb2QiLCBwaWQgNzQzNTksIGppZmZpZXMg
NDMxNzYxNzg3MyAoYWdlIDU5OC40ODBzKQogICAgNjcgNzAgNjkgNmYgMmQgNzMgNjkgNmQg
MmUgMzAgMmQgNmUgNmYgNjQgNjUgMzAgIGdwaW8tc2ltLjAtbm9kZTAK
--------------04uoXsyNMUryBorWPQsdx8hc
Content-Type: application/x-shellscript; name="gpio-reproduce-min.sh"
Content-Disposition: attachment; filename="gpio-reproduce-min.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAojIENvcHly
aWdodCAoQykgMjAyMSBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGJnZGV2LnBsPgoKQkFT
RV9ESVI9YGRpcm5hbWUgJDBgCkNPTkZJR0ZTX0RJUj0iL3N5cy9rZXJuZWwvY29uZmlnL2dw
aW8tc2ltIgpNT0RVTEU9ImdwaW8tc2ltIgoKS01FTUxFQUs9L3N5cy9rZXJuZWwvZGVidWcv
a21lbWxlYWsKCmNoZWNrX2ttZW1sZWFrICgpIHsKCWVjaG8gLW4gIlNjYW5uaW5nIHN0YWdl
ICQxIC4uLiAiCgllY2hvIHNjYW4gPiAkS01FTUxFQUsKCWVjaG8gImRvbmUuIgoJZWNobyAt
biAiU2xlZXBpbmcgNjAgc2Vjb25kcyAuLi4gIjsgc2xlZXAgNjA7IGVjaG8gImRvbmUuIgoJ
Z3JlcCAiZ3Bpby1zaW0iICRLTUVNTEVBSyA+IC9kZXYvbnVsbAoJaWYgW1sgIiQ/IiA9PSAi
MSIgXV07IHRoZW4gZWNobyAiU3RhZ2UgJDEgY2xlYW4uIjsgZWxzZSBjYXQgJEtNRU1MRUFL
OyBleGl0OyBmaQoJZWNobyAtbiAiUmVzY2FubmluZyBzdGFnZSAkMSAuLi4gIgoJZWNobyBz
Y2FuID4gJEtNRU1MRUFLCgllY2hvICJkb25lLiIKCWVjaG8gLW4gIlNsZWVwaW5nIDYwIHNl
Y29uZHMgLi4uICI7IHNsZWVwIDYwOyBlY2hvICJkb25lLiIKCWdyZXAgImdwaW8tc2ltIiAk
S01FTUxFQUsgPiAvZGV2L251bGwKCWlmIFtbICIkPyIgPT0gIjEiIF1dOyB0aGVuIGVjaG8g
IlN0YWdlICQxIGNsZWFuLiI7IGVsc2UgY2F0ICRLTUVNTEVBSzsgZXhpdDsgZmkKCWVjaG8g
LW4gIlJlLXJlc2Nhbm5pbmcgc3RhZ2UgJDEgLi4uICIKCWVjaG8gc2NhbiA+ICRLTUVNTEVB
SwoJZWNobyAiZG9uZS4iCgllY2hvIC1uICJTbGVlcGluZyA2MCBzZWNvbmRzIC4uLiAiOyBz
bGVlcCA2MDsgZWNobyAiZG9uZS4iCglncmVwICJncGlvLXNpbSIgJEtNRU1MRUFLID4gL2Rl
di9udWxsCglpZiBbWyAiJD8iID09ICIxIiBdXTsgdGhlbiBlY2hvICJTdGFnZSAkMSBjbGVh
bi4iOyBlbHNlIGNhdCAkS01FTUxFQUs7IGV4aXQ7IGZpCn0KCmZhaWwoKSB7CgllY2hvICIk
KiIgPiYyCgllY2hvICJHUElPICRNT0RVTEUgdGVzdCBGQUlMIgoJZXhpdCAxCn0KCnNraXAo
KSB7CgllY2hvICIkKiIgPiYyCgllY2hvICJHUElPICRNT0RVTEUgdGVzdCBTS0lQIgoJZXhp
dCA0Cn0KCnJlbW92ZV9jaGlwKCkgewoJbG9jYWwgQ0hJUD0kMQoKCWZvciBGSUxFIGluICRD
T05GSUdGU19ESVIvJENISVAvKjsgZG8KCQlCQU5LPWBiYXNlbmFtZSAkRklMRWAKCQlpZiBb
ICIkQkFOSyIgPSAibGl2ZSIgLW8gIiRCQU5LIiA9ICJkZXZfbmFtZSIgXTsgdGhlbgoJCQlj
b250aW51ZQoJCWZpCgoJCUxJTkVTPWBscyAkQ09ORklHRlNfRElSLyRDSElQLyRCQU5LLyB8
IGdyZXAgLUUgXmxpbmVgCgkJaWYgWyAiJD8iID0gMCBdOyB0aGVuCgkJCWZvciBMSU5FIGlu
ICRMSU5FUzsgZG8KCQkJCWlmIFsgLWUgJENPTkZJR0ZTX0RJUi8kQ0hJUC8kQkFOSy8kTElO
RS9ob2cgXTsgdGhlbgoJCQkJCXJtZGlyICRDT05GSUdGU19ESVIvJENISVAvJEJBTksvJExJ
TkUvaG9nIHx8IFwKCQkJCQkJZmFpbCAiVW5hYmxlIHRvIHJlbW92ZSB0aGUgaG9nIgoJCQkJ
ZmkKCgkJCQlybWRpciAkQ09ORklHRlNfRElSLyRDSElQLyRCQU5LLyRMSU5FIHx8IFwKCQkJ
CQlmYWlsICJVbmFibGUgdG8gcmVtb3ZlIHRoZSBsaW5lIgoJCQlkb25lCgkJZmkKCgkJcm1k
aXIgJENPTkZJR0ZTX0RJUi8kQ0hJUC8kQkFOSwoJZG9uZQoKCXJtZGlyICRDT05GSUdGU19E
SVIvJENISVAgfHwgZmFpbCAiVW5hYmxlIHRvIHJlbW92ZSB0aGUgY2hpcCIKfQoKY29uZmln
ZnNfY2xlYW51cCgpIHsKCWZvciBDSElQIGluIGBscyAkQ09ORklHRlNfRElSL2A7IGRvCgkJ
cmVtb3ZlX2NoaXAgJENISVAKCWRvbmUKfQoKY3JlYXRlX2NoaXAoKSB7Cglsb2NhbCBDSElQ
PSQxCgoJbWtkaXIgJENPTkZJR0ZTX0RJUi8kQ0hJUAp9CgpjcmVhdGVfYmFuaygpIHsKCWxv
Y2FsIENISVA9JDEKCWxvY2FsIEJBTks9JDIKCglta2RpciAkQ09ORklHRlNfRElSLyRDSElQ
LyRCQU5LCn0KCnNldF9sYWJlbCgpIHsKCWxvY2FsIENISVA9JDEKCWxvY2FsIEJBTks9JDIK
CWxvY2FsIExBQkVMPSQzCgoJZWNobyAkTEFCRUwgPiAkQ09ORklHRlNfRElSLyRDSElQLyRC
QU5LL2xhYmVsIHx8IGZhaWwgIlVuYWJsZSB0byBzZXQgdGhlIGNoaXAgbGFiZWwiCn0KCnNl
dF9udW1fbGluZXMoKSB7Cglsb2NhbCBDSElQPSQxCglsb2NhbCBCQU5LPSQyCglsb2NhbCBO
VU1fTElORVM9JDMKCgllY2hvICROVU1fTElORVMgPiAkQ09ORklHRlNfRElSLyRDSElQLyRC
QU5LL251bV9saW5lcyB8fCBcCgkJZmFpbCAiVW5hYmxlIHRvIHNldCB0aGUgbnVtYmVyIG9m
IGxpbmVzIgp9CgpzZXRfbGluZV9uYW1lKCkgewoJbG9jYWwgQ0hJUD0kMQoJbG9jYWwgQkFO
Sz0kMgoJbG9jYWwgT0ZGU0VUPSQzCglsb2NhbCBOQU1FPSQ0Cglsb2NhbCBMSU5FX0RJUj0k
Q09ORklHRlNfRElSLyRDSElQLyRCQU5LL2xpbmUkT0ZGU0VUCgoJdGVzdCAtZCAkTElORV9E
SVIgfHwgbWtkaXIgJExJTkVfRElSCgllY2hvICROQU1FID4gJExJTkVfRElSL25hbWUgfHwg
ZmFpbCAiVW5hYmxlIHRvIHNldCB0aGUgbGluZSBuYW1lIgp9CgplbmFibGVfY2hpcCgpIHsK
CWxvY2FsIENISVA9JDEKCgllY2hvIDEgPiAkQ09ORklHRlNfRElSLyRDSElQL2xpdmUgfHwg
ZmFpbCAiVW5hYmxlIHRvIGVuYWJsZSB0aGUgY2hpcCIKfQoKZGlzYWJsZV9jaGlwKCkgewoJ
bG9jYWwgQ0hJUD0kMQoKCWVjaG8gMCA+ICRDT05GSUdGU19ESVIvJENISVAvbGl2ZSB8fCBm
YWlsICJVbmFibGUgdG8gZGlzYWJsZSB0aGUgY2hpcCIKfQoKY29uZmlnZnNfY2hpcF9uYW1l
KCkgewoJbG9jYWwgQ0hJUD0kMQoJbG9jYWwgQkFOSz0kMgoKCWNhdCAkQ09ORklHRlNfRElS
LyRDSElQLyRCQU5LL2NoaXBfbmFtZSAyPiAvZGV2L251bGwgfHwgXAoJCWZhaWwgInVuYWJs
ZSB0byByZWFkIHRoZSBjaGlwIG5hbWUgZnJvbSBjb25maWdmcyIKfQoKY29uZmlnZnNfZGV2
X25hbWUoKSB7Cglsb2NhbCBDSElQPSQxCgoJY2F0ICRDT05GSUdGU19ESVIvJENISVAvZGV2
X25hbWUgMj4gL2Rldi9udWxsIHx8IFwKCQlmYWlsICJ1bmFibGUgdG8gcmVhZCB0aGUgZGV2
aWNlIG5hbWUgZnJvbSBjb25maWdmcyIKfQoKZ2V0X2NoaXBfbnVtX2xpbmVzKCkgewoJbG9j
YWwgQ0hJUD0kMQoJbG9jYWwgQkFOSz0kMgoKCSRCQVNFX0RJUi9ncGlvLWNoaXAtaW5mbyAv
ZGV2L2Bjb25maWdmc19jaGlwX25hbWUgJENISVAgJEJBTktgIG51bS1saW5lcyB8fCBcCgkJ
ZmFpbCAidW5hYmxlIHRvIHJlYWQgdGhlIG51bWJlciBvZiBsaW5lcyBmcm9tIHRoZSBjaGFy
YWN0ZXIgZGV2aWNlIgp9CgpnZXRfY2hpcF9sYWJlbCgpIHsKCWxvY2FsIENISVA9JDEKCWxv
Y2FsIEJBTks9JDIKCgkkQkFTRV9ESVIvZ3Bpby1jaGlwLWluZm8gL2Rldi9gY29uZmlnZnNf
Y2hpcF9uYW1lICRDSElQICRCQU5LYCBsYWJlbCB8fCBcCgkJZmFpbCAidW5hYmxlIHRvIHJl
YWQgdGhlIGNoaXAgbGFiZWwgZnJvbSB0aGUgY2hhcmFjdGVyIGRldmljZSIKfQoKZ2V0X2xp
bmVfbmFtZSgpIHsKCWxvY2FsIENISVA9JDEKCWxvY2FsIEJBTks9JDIKCWxvY2FsIE9GRlNF
VD0kMwoKCSRCQVNFX0RJUi9ncGlvLWxpbmUtbmFtZSAvZGV2L2Bjb25maWdmc19jaGlwX25h
bWUgJENISVAgJEJBTktgICRPRkZTRVQgfHwgXAoJCWZhaWwgInVuYWJsZSB0byByZWFkIHRo
ZSBsaW5lIG5hbWUgZnJvbSB0aGUgY2hhcmFjdGVyIGRldmljZSIKfQoKc3lzZnNfc2V0X3B1
bGwoKSB7Cglsb2NhbCBERVY9JDEKCWxvY2FsIEJBTks9JDIKCWxvY2FsIE9GRlNFVD0kMwoJ
bG9jYWwgUFVMTD0kNAoJbG9jYWwgREVWTkFNRT1gY29uZmlnZnNfZGV2X25hbWUgJERFVmAK
CWxvY2FsIENISVBOQU1FPWBjb25maWdmc19jaGlwX25hbWUgJERFViAkQkFOS2AKCWxvY2Fs
IFNZU0ZTUEFUSD0iL3N5cy9kZXZpY2VzL3BsYXRmb3JtLyRERVZOQU1FLyRDSElQTkFNRS9z
aW1fZ3BpbyRPRkZTRVQvcHVsbCIKCgllY2hvICRQVUxMID4gJFNZU0ZTUEFUSCB8fCBmYWls
ICJVbmFibGUgdG8gc2V0IGxpbmUgcHVsbCBpbiBzeXNmcyIKfQoKIyBMb2FkIHRoZSBncGlv
LXNpbSBtb2R1bGUuIFRoaXMgd2lsbCBwdWxsIGluIGNvbmZpZ2ZzIGlmIG5lZWRlZCB0b28u
Cm1vZHByb2JlIGdwaW8tc2ltIHx8IHNraXAgInVuYWJsZSB0byBsb2FkIHRoZSBncGlvLXNp
bSBtb2R1bGUiCiMgTWFrZSBzdXJlIGNvbmZpZ2ZzIGlzIG1vdW50ZWQgYXQgL3N5cy9rZXJu
ZWwvY29uZmlnLiBXYWl0IGEgYml0IGlmIG5lZWRlZC4KZm9yIElEWCBpbiBgc2VxIDVgOyBk
bwoJaWYgWyAiJElEWCIgLWVxICI1IiBdOyB0aGVuCgkJc2tpcCAiY29uZmlnZnMgbm90IG1v
dW50ZWQgYXQgL3N5cy9rZXJuZWwvY29uZmlnIgoJZmkKCgltb3VudHBvaW50IC1xIC9zeXMv
a2VybmVsL2NvbmZpZyAmJiBicmVhawoJc2xlZXAgMC4xCmRvbmUKIyBJZiB0aGUgbW9kdWxl
IHdhcyBhbHJlYWR5IGxvYWRlZDogcmVtb3ZlIGFsbCBwcmV2aW91cyBjaGlwcwpjb25maWdm
c19jbGVhbnVwCgojIHRyYXAgImV4aXQgMSIgU0lHVEVSTSBTSUdJTlQKdHJhcCBjb25maWdm
c19jbGVhbnVwIEVYSVQKCmVjaG8gIjIuMTQuIExpbmVzIGNhbiBiZSBob2dnZWQiCiMgY2hl
Y2tfa21lbWxlYWsgMi4xNC4wCmNyZWF0ZV9jaGlwIGNoaXAKIyBjaGVja19rbWVtbGVhayAy
LjE0LjEKY3JlYXRlX2JhbmsgY2hpcCBiYW5rCiMgY2hlY2tfa21lbWxlYWsgMi4xNC4yCnNl
dF9udW1fbGluZXMgY2hpcCBiYW5rIDgKIyBjaGVja19rbWVtbGVhayAyLjE0LjMKbWtkaXIg
LXAgJENPTkZJR0ZTX0RJUi9jaGlwL2JhbmsvbGluZTQvaG9nCiMgY2hlY2tfa21lbWxlYWsg
Mi4xNC40CmVuYWJsZV9jaGlwIGNoaXAKIyBjaGVja19rbWVtbGVhayAyLjE0LjUKJEJBU0Vf
RElSL2dwaW8tbW9ja3VwLWNkZXYgLXMgMSAvZGV2L2Bjb25maWdmc19jaGlwX25hbWUgY2hp
cCBiYW5rYCA0IDI+IC9kZXYvbnVsbCAmJiBcCglmYWlsICJTZXR0aW5nIHRoZSB2YWx1ZSBv
ZiBhIGhvZ2dlZCBsaW5lIHNob3VsZG4ndCBzdWNjZWVkIgojIGNoZWNrX2ttZW1sZWFrIDIu
MTQuNgpyZW1vdmVfY2hpcCBjaGlwCmNoZWNrX2ttZW1sZWFrIDIuMTQuNwoK
--------------04uoXsyNMUryBorWPQsdx8hc
Content-Type: application/x-shellscript; name="gpio-min-iterate.sh"
Content-Disposition: attachment; filename="gpio-min-iterate.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAojIENvcHly
aWdodCAoQykgMjAyMSBCYXJ0b3N6IEdvbGFzemV3c2tpIDxicmdsQGJnZGV2LnBsPgoKQkFT
RV9ESVI9YGRpcm5hbWUgJDBgCkNPTkZJR0ZTX0RJUj0iL3N5cy9rZXJuZWwvY29uZmlnL2dw
aW8tc2ltIgpNT0RVTEU9ImdwaW8tc2ltIgoKS01FTUxFQUs9L3N5cy9rZXJuZWwvZGVidWcv
a21lbWxlYWsKCmNoZWNrX2ttZW1sZWFrICgpIHsKCWVjaG8gLW4gIlNjYW5uaW5nIHN0YWdl
ICQxIC4uLiAiCgllY2hvIHNjYW4gPiAkS01FTUxFQUsKCWVjaG8gImRvbmUuIgoJZWNobyAt
biAiU2xlZXBpbmcgNjAgc2Vjb25kcyAuLi4gIjsgc2xlZXAgNjA7IGVjaG8gImRvbmUuIgoJ
Z3JlcCAiZ3Bpby1zaW0iICRLTUVNTEVBSyA+IC9kZXYvbnVsbAoJaWYgW1sgIiQ/IiA9PSAi
MSIgXV07IHRoZW4gZWNobyAiU3RhZ2UgJDEgY2xlYW4uIjsgZWxzZSBjYXQgJEtNRU1MRUFL
OyBleGl0OyBmaQoJZWNobyAtbiAiUmVzY2FubmluZyBzdGFnZSAkMSAuLi4gIgoJZWNobyBz
Y2FuID4gJEtNRU1MRUFLCgllY2hvICJkb25lLiIKCWVjaG8gLW4gIlNsZWVwaW5nIDYwIHNl
Y29uZHMgLi4uICI7IHNsZWVwIDYwOyBlY2hvICJkb25lLiIKCWdyZXAgImdwaW8tc2ltIiAk
S01FTUxFQUsgPiAvZGV2L251bGwKCWlmIFtbICIkPyIgPT0gIjEiIF1dOyB0aGVuIGVjaG8g
IlN0YWdlICQxIGNsZWFuLiI7IGVsc2UgY2F0ICRLTUVNTEVBSzsgZXhpdDsgZmkKCWVjaG8g
LW4gIlJlLXJlc2Nhbm5pbmcgc3RhZ2UgJDEgLi4uICIKCWVjaG8gc2NhbiA+ICRLTUVNTEVB
SwoJZWNobyAiZG9uZS4iCgllY2hvIC1uICJTbGVlcGluZyA2MCBzZWNvbmRzIC4uLiAiOyBz
bGVlcCA2MDsgZWNobyAiZG9uZS4iCglncmVwICJncGlvLXNpbSIgJEtNRU1MRUFLID4gL2Rl
di9udWxsCglpZiBbWyAiJD8iID09ICIxIiBdXTsgdGhlbiBlY2hvICJTdGFnZSAkMSBjbGVh
bi4iOyBlbHNlIGNhdCAkS01FTUxFQUs7IGV4aXQ7IGZpCn0KCmZhaWwoKSB7CgllY2hvICIk
KiIgPiYyCgllY2hvICJHUElPICRNT0RVTEUgdGVzdCBGQUlMIgoJZXhpdCAxCn0KCnNraXAo
KSB7CgllY2hvICIkKiIgPiYyCgllY2hvICJHUElPICRNT0RVTEUgdGVzdCBTS0lQIgoJZXhp
dCA0Cn0KCnJlbW92ZV9jaGlwKCkgewoJbG9jYWwgQ0hJUD0kMQoKCWZvciBGSUxFIGluICRD
T05GSUdGU19ESVIvJENISVAvKjsgZG8KCQlCQU5LPWBiYXNlbmFtZSAkRklMRWAKCQlpZiBb
ICIkQkFOSyIgPSAibGl2ZSIgLW8gIiRCQU5LIiA9ICJkZXZfbmFtZSIgXTsgdGhlbgoJCQlj
b250aW51ZQoJCWZpCgoJCUxJTkVTPWBscyAkQ09ORklHRlNfRElSLyRDSElQLyRCQU5LLyB8
IGdyZXAgLUUgXmxpbmVgCgkJaWYgWyAiJD8iID0gMCBdOyB0aGVuCgkJCWZvciBMSU5FIGlu
ICRMSU5FUzsgZG8KCQkJCWlmIFsgLWUgJENPTkZJR0ZTX0RJUi8kQ0hJUC8kQkFOSy8kTElO
RS9ob2cgXTsgdGhlbgoJCQkJCXJtZGlyICRDT05GSUdGU19ESVIvJENISVAvJEJBTksvJExJ
TkUvaG9nIHx8IFwKCQkJCQkJZmFpbCAiVW5hYmxlIHRvIHJlbW92ZSB0aGUgaG9nIgoJCQkJ
ZmkKCgkJCQlybWRpciAkQ09ORklHRlNfRElSLyRDSElQLyRCQU5LLyRMSU5FIHx8IFwKCQkJ
CQlmYWlsICJVbmFibGUgdG8gcmVtb3ZlIHRoZSBsaW5lIgoJCQlkb25lCgkJZmkKCgkJcm1k
aXIgJENPTkZJR0ZTX0RJUi8kQ0hJUC8kQkFOSwoJZG9uZQoKCXJtZGlyICRDT05GSUdGU19E
SVIvJENISVAgfHwgZmFpbCAiVW5hYmxlIHRvIHJlbW92ZSB0aGUgY2hpcCIKfQoKY29uZmln
ZnNfY2xlYW51cCgpIHsKCWZvciBDSElQIGluIGBscyAkQ09ORklHRlNfRElSL2A7IGRvCgkJ
cmVtb3ZlX2NoaXAgJENISVAKCWRvbmUKfQoKY3JlYXRlX2NoaXAoKSB7Cglsb2NhbCBDSElQ
PSQxCgoJbWtkaXIgJENPTkZJR0ZTX0RJUi8kQ0hJUAp9CgpjcmVhdGVfYmFuaygpIHsKCWxv
Y2FsIENISVA9JDEKCWxvY2FsIEJBTks9JDIKCglta2RpciAkQ09ORklHRlNfRElSLyRDSElQ
LyRCQU5LCn0KCnNldF9sYWJlbCgpIHsKCWxvY2FsIENISVA9JDEKCWxvY2FsIEJBTks9JDIK
CWxvY2FsIExBQkVMPSQzCgoJZWNobyAkTEFCRUwgPiAkQ09ORklHRlNfRElSLyRDSElQLyRC
QU5LL2xhYmVsIHx8IGZhaWwgIlVuYWJsZSB0byBzZXQgdGhlIGNoaXAgbGFiZWwiCn0KCnNl
dF9udW1fbGluZXMoKSB7Cglsb2NhbCBDSElQPSQxCglsb2NhbCBCQU5LPSQyCglsb2NhbCBO
VU1fTElORVM9JDMKCgllY2hvICROVU1fTElORVMgPiAkQ09ORklHRlNfRElSLyRDSElQLyRC
QU5LL251bV9saW5lcyB8fCBcCgkJZmFpbCAiVW5hYmxlIHRvIHNldCB0aGUgbnVtYmVyIG9m
IGxpbmVzIgp9CgpzZXRfbGluZV9uYW1lKCkgewoJbG9jYWwgQ0hJUD0kMQoJbG9jYWwgQkFO
Sz0kMgoJbG9jYWwgT0ZGU0VUPSQzCglsb2NhbCBOQU1FPSQ0Cglsb2NhbCBMSU5FX0RJUj0k
Q09ORklHRlNfRElSLyRDSElQLyRCQU5LL2xpbmUkT0ZGU0VUCgoJdGVzdCAtZCAkTElORV9E
SVIgfHwgbWtkaXIgJExJTkVfRElSCgllY2hvICROQU1FID4gJExJTkVfRElSL25hbWUgfHwg
ZmFpbCAiVW5hYmxlIHRvIHNldCB0aGUgbGluZSBuYW1lIgp9CgplbmFibGVfY2hpcCgpIHsK
CWxvY2FsIENISVA9JDEKCgllY2hvIDEgPiAkQ09ORklHRlNfRElSLyRDSElQL2xpdmUgfHwg
ZmFpbCAiVW5hYmxlIHRvIGVuYWJsZSB0aGUgY2hpcCIKfQoKZGlzYWJsZV9jaGlwKCkgewoJ
bG9jYWwgQ0hJUD0kMQoKCWVjaG8gMCA+ICRDT05GSUdGU19ESVIvJENISVAvbGl2ZSB8fCBm
YWlsICJVbmFibGUgdG8gZGlzYWJsZSB0aGUgY2hpcCIKfQoKY29uZmlnZnNfY2hpcF9uYW1l
KCkgewoJbG9jYWwgQ0hJUD0kMQoJbG9jYWwgQkFOSz0kMgoKCWNhdCAkQ09ORklHRlNfRElS
LyRDSElQLyRCQU5LL2NoaXBfbmFtZSAyPiAvZGV2L251bGwgfHwgXAoJCWZhaWwgInVuYWJs
ZSB0byByZWFkIHRoZSBjaGlwIG5hbWUgZnJvbSBjb25maWdmcyIKfQoKY29uZmlnZnNfZGV2
X25hbWUoKSB7Cglsb2NhbCBDSElQPSQxCgoJY2F0ICRDT05GSUdGU19ESVIvJENISVAvZGV2
X25hbWUgMj4gL2Rldi9udWxsIHx8IFwKCQlmYWlsICJ1bmFibGUgdG8gcmVhZCB0aGUgZGV2
aWNlIG5hbWUgZnJvbSBjb25maWdmcyIKfQoKZ2V0X2NoaXBfbnVtX2xpbmVzKCkgewoJbG9j
YWwgQ0hJUD0kMQoJbG9jYWwgQkFOSz0kMgoKCSRCQVNFX0RJUi9ncGlvLWNoaXAtaW5mbyAv
ZGV2L2Bjb25maWdmc19jaGlwX25hbWUgJENISVAgJEJBTktgIG51bS1saW5lcyB8fCBcCgkJ
ZmFpbCAidW5hYmxlIHRvIHJlYWQgdGhlIG51bWJlciBvZiBsaW5lcyBmcm9tIHRoZSBjaGFy
YWN0ZXIgZGV2aWNlIgp9CgpnZXRfY2hpcF9sYWJlbCgpIHsKCWxvY2FsIENISVA9JDEKCWxv
Y2FsIEJBTks9JDIKCgkkQkFTRV9ESVIvZ3Bpby1jaGlwLWluZm8gL2Rldi9gY29uZmlnZnNf
Y2hpcF9uYW1lICRDSElQICRCQU5LYCBsYWJlbCB8fCBcCgkJZmFpbCAidW5hYmxlIHRvIHJl
YWQgdGhlIGNoaXAgbGFiZWwgZnJvbSB0aGUgY2hhcmFjdGVyIGRldmljZSIKfQoKZ2V0X2xp
bmVfbmFtZSgpIHsKCWxvY2FsIENISVA9JDEKCWxvY2FsIEJBTks9JDIKCWxvY2FsIE9GRlNF
VD0kMwoKCSRCQVNFX0RJUi9ncGlvLWxpbmUtbmFtZSAvZGV2L2Bjb25maWdmc19jaGlwX25h
bWUgJENISVAgJEJBTktgICRPRkZTRVQgfHwgXAoJCWZhaWwgInVuYWJsZSB0byByZWFkIHRo
ZSBsaW5lIG5hbWUgZnJvbSB0aGUgY2hhcmFjdGVyIGRldmljZSIKfQoKc3lzZnNfc2V0X3B1
bGwoKSB7Cglsb2NhbCBERVY9JDEKCWxvY2FsIEJBTks9JDIKCWxvY2FsIE9GRlNFVD0kMwoJ
bG9jYWwgUFVMTD0kNAoJbG9jYWwgREVWTkFNRT1gY29uZmlnZnNfZGV2X25hbWUgJERFVmAK
CWxvY2FsIENISVBOQU1FPWBjb25maWdmc19jaGlwX25hbWUgJERFViAkQkFOS2AKCWxvY2Fs
IFNZU0ZTUEFUSD0iL3N5cy9kZXZpY2VzL3BsYXRmb3JtLyRERVZOQU1FLyRDSElQTkFNRS9z
aW1fZ3BpbyRPRkZTRVQvcHVsbCIKCgllY2hvICRQVUxMID4gJFNZU0ZTUEFUSCB8fCBmYWls
ICJVbmFibGUgdG8gc2V0IGxpbmUgcHVsbCBpbiBzeXNmcyIKfQoKIyBMb2FkIHRoZSBncGlv
LXNpbSBtb2R1bGUuIFRoaXMgd2lsbCBwdWxsIGluIGNvbmZpZ2ZzIGlmIG5lZWRlZCB0b28u
Cm1vZHByb2JlIGdwaW8tc2ltIHx8IHNraXAgInVuYWJsZSB0byBsb2FkIHRoZSBncGlvLXNp
bSBtb2R1bGUiCiMgTWFrZSBzdXJlIGNvbmZpZ2ZzIGlzIG1vdW50ZWQgYXQgL3N5cy9rZXJu
ZWwvY29uZmlnLiBXYWl0IGEgYml0IGlmIG5lZWRlZC4KZm9yIElEWCBpbiBgc2VxIDVgOyBk
bwoJaWYgWyAiJElEWCIgLWVxICI1IiBdOyB0aGVuCgkJc2tpcCAiY29uZmlnZnMgbm90IG1v
dW50ZWQgYXQgL3N5cy9rZXJuZWwvY29uZmlnIgoJZmkKCgltb3VudHBvaW50IC1xIC9zeXMv
a2VybmVsL2NvbmZpZyAmJiBicmVhawoJc2xlZXAgMC4xCmRvbmUKIyBJZiB0aGUgbW9kdWxl
IHdhcyBhbHJlYWR5IGxvYWRlZDogcmVtb3ZlIGFsbCBwcmV2aW91cyBjaGlwcwpjb25maWdm
c19jbGVhbnVwCgojIHRyYXAgImV4aXQgMSIgU0lHVEVSTSBTSUdJTlQKdHJhcCBjb25maWdm
c19jbGVhbnVwIEVYSVQKCmZvciBhIGluIHsxLi4xMDAwMDAwfTsgZG8KICAgIGVjaG8gIjIu
MTQuIExpbmVzIGNhbiBiZSBob2dnZWQgJGEiCiAgICAjIGNoZWNrX2ttZW1sZWFrIDIuMTQu
MAogICAgY3JlYXRlX2NoaXAgY2hpcAogICAgIyBjaGVja19rbWVtbGVhayAyLjE0LjEKICAg
IGNyZWF0ZV9iYW5rIGNoaXAgYmFuawogICAgIyBjaGVja19rbWVtbGVhayAyLjE0LjIKICAg
IHNldF9udW1fbGluZXMgY2hpcCBiYW5rIDgKICAgICMgY2hlY2tfa21lbWxlYWsgMi4xNC4z
CiAgICBta2RpciAtcCAkQ09ORklHRlNfRElSL2NoaXAvYmFuay9saW5lNC9ob2cKICAgICMg
Y2hlY2tfa21lbWxlYWsgMi4xNC40CiAgICBlbmFibGVfY2hpcCBjaGlwCiAgICAjIGNoZWNr
X2ttZW1sZWFrIDIuMTQuNQogICAgJEJBU0VfRElSL2dwaW8tbW9ja3VwLWNkZXYgLXMgMSAv
ZGV2L2Bjb25maWdmc19jaGlwX25hbWUgY2hpcCBiYW5rYCA0IDI+IC9kZXYvbnVsbCAmJiBc
CgkgICAgZmFpbCAiU2V0dGluZyB0aGUgdmFsdWUgb2YgYSBob2dnZWQgbGluZSBzaG91bGRu
J3Qgc3VjY2VlZCIKICAgICMgY2hlY2tfa21lbWxlYWsgMi4xNC42CiAgICByZW1vdmVfY2hp
cCBjaGlwCmRvbmUKCmNoZWNrX2ttZW1sZWFrIDIuMTQuNwoK

--------------04uoXsyNMUryBorWPQsdx8hc--
