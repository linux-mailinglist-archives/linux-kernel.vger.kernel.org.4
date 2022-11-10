Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30A6623B13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiKJE6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiKJE6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:58:05 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084FE2B1B8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:58:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 94535604F2;
        Thu, 10 Nov 2022 05:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668056281; bh=HlvL/rNMDq0gNMxw710sjO64wRDrS6TgxRUpnupu38I=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=0gyCSUdMKFM7/HaDqgNAIxVbe0GeJdzYLmcTrWLVNAgtUnWrEbbsp8gxCpM6EfKIR
         B2suD3Buy4E/DmLt8rO7KUgopoyfJzc/h0zTKlc+AwHzz/ZqZdb6a6IXjLWaHpZdT0
         dEpucJDCgVa6vm5LO7g6I06kNVlI4fsY9ZSb6LdwaoxL1vJDoFAtgqhNDcZNKz6G7i
         H7+U2dCotYRpn5cMxEntsL99YK5Lg33rtbbrUoDDLhxh0syKKDbSU+7mkUWJkYN9G8
         C7ca1p+G2XO/+BqF4RRiDLCAhwyXoYwzIoxbx3ArWuKrTf5f9HOLf5QwzAKyLJqGzI
         Le+UDUNc4aP0Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dH9FGErAijnm; Thu, 10 Nov 2022 05:57:59 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.82])
        by domac.alu.hr (Postfix) with ESMTPSA id 28B72604ED;
        Thu, 10 Nov 2022 05:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668056279; bh=HlvL/rNMDq0gNMxw710sjO64wRDrS6TgxRUpnupu38I=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=DBA1udqa9mqHaT3DwI0uT9mYR1fE0K9RjIhNluC9QumdHd86yBIq7C+xzlxpafkf5
         QQ6XRuykScoS6DR0eKqQQFKhyeJ8UFtILa2te4c73HVCNcq2epzPKBejGnu57unIb3
         gN+nA7ZI56ExhrFcGoeqntIYl1XD/x9mQ5vFmFS7NVfzLzOTR5mcTOayTy9flzdNwb
         blaT7Fc1mT8Jl9p1xxQr1XQOfLS3+W/M89Kv9cL1HP2fFr2JvX96LJZnRVP4Up4BKL
         TubjdKKaQ4F77J/k5Pa61NDOSduFHIaVb/Z7M1jA0vKi0uADsZ9ldKvSDvB2ZovDid
         iqfPCPnxxH/5A==
Content-Type: multipart/mixed; boundary="------------h8kKATVYmCiv69Mc65GaI0TR"
Message-ID: <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
Date:   Thu, 10 Nov 2022 05:57:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BUG: kworker + systemd-udevd memory leaks found in 6.1.0-rc4
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tejun Heo <tj@kernel.org>,
        Florian Mickler <florian@mickler.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        systemd-devel@lists.freedesktop.org
References: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
Content-Language: en-US
In-Reply-To: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------h8kKATVYmCiv69Mc65GaI0TR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04. 11. 2022. 11:40, Mirsad Goran Todorovac wrote:

> Dear Sirs,
>
> When building a RPM 6.1.0-rc3 for AlmaLinux 8.6, I have enabled 
> CONFIG_DEBUG_KMEMLEAK=y
> and the result showed an unreferenced object in kworker process:
>
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffffa01dabff6100 (size 16):
>   comm "kworker/u12:4", pid 400, jiffies 4294894771 (age 5284.956s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>   backtrace:
>     [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
>     [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
>     [<0000000005472512>] kstrdup+0x36/0x70
>     [<000000002f797ac4>] kstrdup_const+0x28/0x30
>     [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
>     [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
>     [<000000004158a6c0>] dev_set_name+0x53/0x70
>     [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
>     [<00000000122bb894>] process_one_work+0x214/0x3f0
>     [<00000000fcf282cc>] worker_thread+0x34/0x3d0
>     [<0000000002409855>] kthread+0xed/0x120
>     [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
> unreferenced object 0xffffa01dabff6ec0 (size 16):
>   comm "kworker/u12:4", pid 400, jiffies 4294894774 (age 5284.944s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>   backtrace:
>     [<000000009ff951f6>] __kmem_cache_alloc_node+0x380/0x4e0
>     [<00000000451f4268>] __kmalloc_node_track_caller+0x55/0x150
>     [<0000000005472512>] kstrdup+0x36/0x70
>     [<000000002f797ac4>] kstrdup_const+0x28/0x30
>     [<00000000e3f86581>] kvasprintf_const+0x78/0xa0
>     [<00000000e15920f7>] kobject_set_name_vargs+0x23/0xa0
>     [<000000004158a6c0>] dev_set_name+0x53/0x70
>     [<000000001a120541>] memstick_check+0xff/0x384 [memstick]
>     [<00000000122bb894>] process_one_work+0x214/0x3f0
>     [<00000000fcf282cc>] worker_thread+0x34/0x3d0
>     [<0000000002409855>] kthread+0xed/0x120
>     [<000000007b02b4a3>] ret_from_fork+0x1f/0x30
> #
>
> Please fing the build config and lshw output attached.
>
> dmesg is useless, as it is filled with events like:
>
> [ 6068.996120] evbug: Event. Dev: input4, Type: 1, Code: 31, Value: 0
> [ 6068.996121] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
> [ 6069.124145] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
> [ 6069.124149] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 1
> [ 6069.124150] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
> [ 6069.196003] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458762
> [ 6069.196007] evbug: Event. Dev: input4, Type: 1, Code: 34, Value: 0
> [ 6069.196009] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0
> [ 6069.788129] evbug: Event. Dev: input4, Type: 4, Code: 4, Value: 458792
> [ 6069.788133] evbug: Event. Dev: input4, Type: 1, Code: 28, Value: 1
> [ 6069.788135] evbug: Event. Dev: input4, Type: 0, Code: 0, Value: 0

This bug is confirmed in 6.1-rc4, among the "thermald" and "systemd-dev" 
kernel memory leaks, potentially exposing race conditions or other more 
serious bug.

The bug is now also confirmed and now manifested also in the Ubuntu 
22.04 LTS jammy 6.1-rc4 build.

Here is the kmemleak output:

unreferenced object 0xffff9242b13b3980 (size 64):
   comm "kworker/5:3", pid 43106, jiffies 4305052439 (age 71828.792s)
   hex dump (first 32 bytes):
     80 8b a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ....B...........
     20 86 a0 f0 42 92 ff ff 00 00 00 00 00 00 00 00 ...B...........
   backtrace:
     [<00000000c5dea4db>] __kmem_cache_alloc_node+0x380/0x4e0
     [<000000002b17af47>] kmalloc_node_trace+0x27/0xa0
     [<000000004c09eee5>] xhci_alloc_command+0x6e/0x180
     [<0000000099436a99>] xhci_alloc_command_with_ctx+0x1d/0x60
     [<0000000070f45e17>] xhci_change_max_exit_latency+0x2e/0x1c0
     [<000000001b13cf46>] xhci_disable_usb3_lpm_timeout+0x77/0xb0
     [<00000000ff561da4>] usb_disable_link_state+0x53/0xd0
     [<0000000068febd40>] usb_disable_lpm+0x82/0xc0
     [<00000000dffec01f>] usb_unlocked_disable_lpm+0x2d/0x50
     [<0000000061a59294>] usb_disable_device+0x12f/0x250
     [<0000000044e2299d>] usb_set_configuration+0x65c/0x9a0
     [<000000001af32470>] driver_set_config_work+0x78/0xa0
     [<00000000320216c3>] process_one_work+0x214/0x3f0
     [<00000000694e932f>] worker_thread+0x34/0x3d0
     [<0000000002e30775>] kthread+0xed/0x120
     [<00000000512e8066>] ret_from_fork+0x1f/0x30
unreferenced object 0xffff9242f0a08620 (size 32):
   comm "kworker/5:3", pid 43106, jiffies 4305052439 (age 71828.792s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
     30 86 a0 f0 42 92 ff ff 30 86 a0 f0 42 92 ff ff 0...B...0...B...
   backtrace:
     [<00000000c5dea4db>] __kmem_cache_alloc_node+0x380/0x4e0
     [<000000002b17af47>] kmalloc_node_trace+0x27/0xa0
     [<00000000459908cf>] xhci_alloc_command+0xe6/0x180
     [<0000000099436a99>] xhci_alloc_command_with_ctx+0x1d/0x60
     [<0000000070f45e17>] xhci_change_max_exit_latency+0x2e/0x1c0
     [<000000001b13cf46>] xhci_disable_usb3_lpm_timeout+0x77/0xb0
     [<00000000ff561da4>] usb_disable_link_state+0x53/0xd0
     [<0000000068febd40>] usb_disable_lpm+0x82/0xc0
     [<00000000dffec01f>] usb_unlocked_disable_lpm+0x2d/0x50
     [<0000000061a59294>] usb_disable_device+0x12f/0x250
     [<0000000044e2299d>] usb_set_configuration+0x65c/0x9a0
     [<000000001af32470>] driver_set_config_work+0x78/0xa0
     [<00000000320216c3>] process_one_work+0x214/0x3f0
     [<00000000694e932f>] worker_thread+0x34/0x3d0
     [<0000000002e30775>] kthread+0xed/0x120
     [<00000000512e8066>] ret_from_fork+0x1f/0x30

Please find the complete kmemleak output attached:

Thanks,
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

--------------h8kKATVYmCiv69Mc65GaI0TR
Content-Type: application/x-lrzip;
 name="thermald_systemd-dev_kworker.memleak.lrz"
Content-Disposition: attachment;
 filename="thermald_systemd-dev_kworker.memleak.lrz"
Content-Transfer-Encoding: base64

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
b0M1i1fnINVz0KylsEDss3UySdqKRsI=

--------------h8kKATVYmCiv69Mc65GaI0TR--
