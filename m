Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB0668642
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjALV7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbjALV7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:59:03 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A56ADBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:50:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9ECD2604FA;
        Thu, 12 Jan 2023 22:50:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673560209; bh=OBT0DLP8e7+/8COlzJrZMM/i5P+WyMFS7A4soRTey/c=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=GdL9sNpCYPGR3Z6knQT7Bl3CnIkBwUbueqxn5H44iCOUgN8rwotN5V2cCav/aWcSH
         4h5I6KA1ddGqsm9tZcPVxj6TUYs9Fg/DOdszAAXZvZTgM0IHIBrKWO5Q8wizkFkC/H
         muq3mftFN2x0j1YCv9HUhG/ASviUxvfsy4J3TwYYXqIOfwnu+HIilEXP1m3Qsk7WGo
         ilAHk2nfRJCWP3U9ccoaYhBf8mgHmNITPVI42RnKKQFYqN6a3QMFBJsnEfqXciYsUw
         KQN93RXykCjn9yPpi7zO1eGHMcrZgXGVzKdZwGoArzzJRqZWIscvw0mjI10QQrj4kb
         3tNsi7ZdOxang==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XfKzoVmlnEJO; Thu, 12 Jan 2023 22:50:07 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.199.93])
        by domac.alu.hr (Postfix) with ESMTPSA id A576B604F9;
        Thu, 12 Jan 2023 22:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673560207; bh=OBT0DLP8e7+/8COlzJrZMM/i5P+WyMFS7A4soRTey/c=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=qaN8ixP/njKC/YwpS8MfT8mWUReP/kyLZ4FMyzX5QqCLJ/A8l2VPb8vlmmrDXv6/V
         dwbmlrJOHRPk3SWptexcIGapqPpit8mW+9Dg5qpyJX+/8nUtJz5lVcyOqOGnphr1PJ
         6GKQbygB5xdxWSMA09aUyXHQ7c+RZefb7WpsMoC2vCkJSZY/WGsTVLjDQE2eMQjwKW
         BJiiEhpMjL3g/1PKRAbO/zacRUQnZ1dddv0NRBL+ma8wXXqTjfBCYJWnDRgmZHorp4
         7GY5WnBkWFmyshm7OYhfjBQ8l3YNs2Pi8WRNDHW5qzlIFcaNQwkRHryNE+mu7rXAWu
         dz+v5xqXo3cng==
Message-ID: <3ba5f8ee-d9bd-69ae-bb3a-c61e47020e2c@alu.unizg.hr>
Date:   Thu, 12 Jan 2023 22:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: INFO: [BISECTED] Regression: A Problem with
 /sys/kernel/debug/kmemleak output: backtrace not printed since 6.2.0-rc1
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <5272a819-ef74-65ff-be61-4d2d567337de@alu.unizg.hr>
 <4c467851-8080-44d3-d017-b0e283896119@alu.unizg.hr>
 <53c2d558-c6a1-38e5-5739-28fff023558d@alu.unizg.hr>
In-Reply-To: <53c2d558-c6a1-38e5-5739-28fff023558d@alu.unizg.hr>
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

On 12. 01. 2023. 20:50, Mirsad Todorovac wrote:
> Hi all,
> 
> there seems to be a problem with the output of /sys/kernel/debug/kmemleak:
> 
> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff951c118568b0 (size 16):
>   comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
>   hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>   backtrace:
> [root@pc-mtodorov ~]#
> 
> Apparently, backtrace of called functions on the stack is no longer printed with the list of memory leaks.
> 
> This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and BIOS version M22KT49A (11/10/2022)
> and 6.2-rc1 and 6.2-rc2 builds.
> 
> This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU enabled on a vanilla mainstream kernel
> from Mr. Torvalds' tree. I don't know if this is deliberate feature for some reason or a bug.
> 
> Please find attached the config, lshw and kmemleak output.
> 
> The bisection gave this commit as the culprit for the severed stack backtrace print
> in /sys/kernel/debug/kmemleak:
> 
> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect good
> 56a61617dd2276cbc56a6c868599716386d70041 is the first bad commit
> commit 56a61617dd2276cbc56a6c868599716386d70041
> Author: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Date:   Thu Oct 27 17:50:24 2022 +0800
> 
>     mm: use stack_depot for recording kmemleak's backtrace
> 
>     Using stack_depot to record kmemleak's backtrace which has been
>     implemented on slub for reducing redundant information.
> 
> The complete bisect log is:
> 
> mtodorov@domac:~/linux/kernel/linux_torvalds$ git bisect log
> git bisect start '--' 'mm'
> # good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
> git bisect good 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
> # bad: [1b929c02afd37871d5afb9d498426f83432e71c2] Linux 6.2-rc1
> git bisect bad 1b929c02afd37871d5afb9d498426f83432e71c2
> # good: [8b9ed79c2d587bec5f603d66801478a5af9af842] Merge tag 'x86_asm_for_v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 8b9ed79c2d587bec5f603d66801478a5af9af842
> # good: [e83b39d6bbdb6d25bd6f5c258832774635d29b47] mm: make drop_caches keep reclaiming on all nodes
> git bisect good e83b39d6bbdb6d25bd6f5c258832774635d29b47
> # good: [9997bc017549acd6425e32300eff28424ffeeb6b] zsmalloc: implement writeback mechanism for zsmalloc
> git bisect good 9997bc017549acd6425e32300eff28424ffeeb6b
> # good: [6287b7dae80944bfa37784a8f9d6861a4facaa6e] mm,thp,rmap: fix races between updates of subpages_mapcount
> git bisect good 6287b7dae80944bfa37784a8f9d6861a4facaa6e
> # good: [8fa590bf344816c925810331eea8387627bbeb40] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect good 8fa590bf344816c925810331eea8387627bbeb40
> # good: [4f292c4de4f6fb83776c0ff22674121eb6ddfa2f] Merge tag 'x86_mm_for_6.2_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 4f292c4de4f6fb83776c0ff22674121eb6ddfa2f
> # bad: [1ea9d333ba475041efe43d9d9bc32e64aea2ea2b] Merge tag 'mm-stable-2022-12-17-2' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 1ea9d333ba475041efe43d9d9bc32e64aea2ea2b
> # bad: [56a61617dd2276cbc56a6c868599716386d70041] mm: use stack_depot for recording kmemleak's backtrace
> git bisect bad 56a61617dd2276cbc56a6c868599716386d70041
> # good: [61b963b52f59524e27692bc1c14bfb2459e32eb3] mm/gup_test: free memory allocated via kvcalloc() using kvfree()
> git bisect good 61b963b52f59524e27692bc1c14bfb2459e32eb3
> # first bad commit: [56a61617dd2276cbc56a6c868599716386d70041] mm: use stack_depot for recording kmemleak's backtrace
> # good: [9102b78b6f6ae6af3557114c265c266b312c1319] maple_tree: update copyright dates for test code
> git bisect good 9102b78b6f6ae6af3557114c265c266b312c1319
> # first bad commit: [56a61617dd2276cbc56a6c868599716386d70041] mm: use stack_depot for recording kmemleak's backtrace
> You have mail in /var/mail/mtodorov
> mtodorov@domac:~/linux/kernel/linux_torvalds$
> 
> The platform is 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB) running AlmaLinux 8.7
> (CentOS clone) and BIOS M22KT49A.
> 
> GCC used was:
> 
> mtodorov@domac:~/linux/kernel/linux_torvalds$ gcc --version
> gcc (Debian 8.3.0-6) 8.3.0
> Copyright (C) 2018 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> mtodorov@domac:~/linux/kernel/linux_torvalds$
> 
> Hope this helps.
> 
> I lack the insight to pinpoint the exact fault in the patch.

P.S.

To further complicate things, on Ubuntu 22.10 Lenovo Ideapad 3 15ITL6 laptop
the kmemleak stack backtrace is printed correctly with the same kernels
(but .deb instead of .rpm for the same build):

unreferenced object 0xffff94ca88e042d0 (size 80):
  comm "thermald", pid 768, jiffies 4294893592 (age 78581.504s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 0d 01 2d 00 00 00 00 00  ..........-.....
    af 07 01 80 fd ac ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffa0dcb921>] slab_post_alloc_hook+0x91/0x320
    [<ffffffffa0dcfb79>] kmem_cache_alloc+0x169/0x2f0
    [<ffffffffa12b1def>] acpi_os_acquire_object+0x2c/0x32
    [<ffffffffa12b1ea2>] acpi_ps_alloc_op+0x4a/0x99
    [<ffffffffa12af5c8>] acpi_ps_get_next_arg+0x611/0x761
    [<ffffffffa12afbbc>] acpi_ps_parse_loop+0x494/0x8d7
    [<ffffffffa12b1434>] acpi_ps_parse_aml+0x1bb/0x561
    [<ffffffffa12b24c8>] acpi_ps_execute_method+0x20f/0x2d5
    [<ffffffffa12a7acf>] acpi_ns_evaluate+0x34d/0x4f3
    [<ffffffffa12ad6a3>] acpi_evaluate_object+0x180/0x3ae
    [<ffffffffa1269ca8>] acpi_run_osc+0x128/0x250
    [<ffffffffc0bbb14f>] int3400_thermal_run_osc+0x6f/0xc0 [int3400_thermal]
    [<ffffffffc0bbb293>] current_uuid_store+0xe3/0x120 [int3400_thermal]
    [<ffffffffa13b8ed4>] dev_attr_store+0x14/0x30
    [<ffffffffa0ee0458>] sysfs_kf_write+0x38/0x50
    [<ffffffffa0edf516>] kernfs_fop_write_iter+0x146/0x1d0
You have new mail in /var/mail/root
root@marvin-IdeaPad-3-15ITL6:/home/marvin# 

Regards,
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

