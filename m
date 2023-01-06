Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC66605B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjAFR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjAFR2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:28:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A96718F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:28:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id dw9so690694pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nUCtQgrIdP8b8zbqjioHahTx9ziEzNiWXxIpIpui70=;
        b=Ps524Rjl7K7tEP4Hci3tyJQH+7nWqn5GINvdb3s5SRfxZlljtvng8ocE+TfxPheLXj
         5rUzHRxi8bOyO5bOn14CGXHxcomExC5iPrqfpT+KDL2PmEDrOyu2czMMonseIGo+4RDI
         iE0J9XuW93lQRnWyPYNroT9yv53+iMu/dQCuygro0oPfmndNkH6RNDpoH+kder9l5SGZ
         Ru5GRxhRh7K2I4UUMHnWSiRmMWjBA2sJsi1IxeYsCY07yprZ4JozREyQQ9Nx16zgHWMH
         5Pe5UkamGV1mP0dVXxyNKz1R1Oq7hdNruRzltxfUEDQu3doouh1CIgXjz3GVoBqqLSqV
         r71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nUCtQgrIdP8b8zbqjioHahTx9ziEzNiWXxIpIpui70=;
        b=AhxKjZEEvxXklP7Lwyp267U5KVBi8K4FJmwX5wOhjXTkXFUxeKLs1z1+y88FT7CYB/
         PRVfVzylO3Yfb2qEEB7vuBDWpPIXGrCIX648b+7o5J8Eyl3viSO8RQfQ9rrEPKGYK//6
         TiEKzX9qgWHRxFg6IyR4bTKCrHE6yjEZAztliJ7IyGlwG5qIqgRyWAYhjm8n8VHh3o9A
         6g/oWcREKqEiGsBooBDxB416aemDgqrKz7SaFUymNX/pvyo71uy1IYyIUT4VeGrJtSK0
         5rHCEMIllUpuuiyWHG4EnAY4JAgnv9KRV1cDb5FA1Ts46g1eS0+AKfNI/8Iz0C2H9SMh
         W7pA==
X-Gm-Message-State: AFqh2koR4u/Ble6dVNzzZQj8SmIqsLcntkkKlClSWCs1V5UYy6lqC8FH
        okdpsLOZxdhxDg3GyXUYOEA=
X-Google-Smtp-Source: AMrXdXsobCCQ+JIPym0aIgBIKmRYEVFR7aQzEWFHoKUrvXY9FDyJI6Io8uvJU5NnnylciixuUN/P6A==
X-Received: by 2002:a17:903:3289:b0:192:8c20:444c with SMTP id jh9-20020a170903328900b001928c20444cmr37065113plb.12.1673026103397;
        Fri, 06 Jan 2023 09:28:23 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b0019300c89011sm1255470plk.63.2023.01.06.09.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:28:21 -0800 (PST)
Date:   Sat, 7 Jan 2023 02:28:16 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [linus:master] [mm, slub]  0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7haMK7uGcMqXcyq@hyeyoo>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212312021.bc1efe86-oliver.sang@intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 11:26:25PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed kernel_BUG_at_include/linux/mm.h due to commit (built with gcc-11):
> 
> commit: 0af8489b0216fa1dd83e264bef8063f2632633d7 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: tasks-tracing
> 
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202212312021.bc1efe86-oliver.sang@intel.com

Adding list_debug oops on same commit and config,
and to me it seems to be related with the reported issue.

Looks like something is corrupting struct pages that are in pcp list...

[    9.271595][  T271] list_del corruption. next->prev should be ee3aac04, but was 22000001. (next=ee3aabb1)
[    9.271943][  T271] ------------[ cut here ]------------
[    9.272117][  T271] kernel BUG at lib/list_debug.c:62!
[    9.272296][  T271] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
[    9.272498][  T271] CPU: 1 PID: 271 Comm: systemd-udevd Tainted: G S                 6.1.0-rc2-00010-g0af8489b0216 #2144 30f8917077604b53250250d749a1d46e4be1d31a
[    9.272961][  T271] EIP: __list_del_entry_valid.cold+0x7a/0x1c4
[    9.273162][  T271] Code: 0c 89 5c 24 04 89 44 24 08 c7 04 24 2c 33 32 c4 83 15 a4 6a e5 c5 00 e8 0c 02 f9 ff 83 05 a8 6a e5 c5 01 83 15 ac 6a e5 c5 00 <0f> 0b 83 05 b0 6a e5 c5 01 b8 bc 1f b5 c4 83 15 b4 6a e5 c5 00 e8
[    9.273783][  T271] EAX: 00000055 EBX: ee3aac04 ECX: f6ff05c0 EDX: 00000001
[    9.274007][  T271] ESI: f6ff4560 EDI: ee3aac00 EBP: c8dd3be0 ESP: c8dd3bcc
[    9.274234][  T271] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
[    9.274476][  T271] CR0: 80050033 CR2: bfa85bf0 CR3: 08a0e000 CR4: 00040690
[    9.274707][  T271] Call Trace:
[    9.274816][  T271]  __rmqueue_pcplist+0x5d/0x1c0
[    9.274972][  T271]  rmqueue_pcplist.constprop.0+0xc7/0x240
[    9.275153][  T271]  rmqueue.isra.0+0x57f/0xc60
[    9.275305][  T271]  ? zone_watermark_fast+0x118/0x230
[    9.275479][  T271]  get_page_from_freelist+0xe7/0x310
[    9.275651][  T271]  __alloc_pages+0xdd/0x360
[    9.275799][  T271]  alloc_slab_page+0x12d/0x200
[    9.275952][  T271]  allocate_slab+0x6a/0x350
[    9.276098][  T271]  new_slab+0x48/0xc0
[    9.276228][  T271]  __slab_alloc_node.constprop.0+0xf3/0x260
[    9.276416][  T271]  __kmem_cache_alloc_node+0x75/0x490
[    9.276591][  T271]  ? lock_is_held_type+0x80/0xf0
[    9.276753][  T271]  __kmalloc_node+0x7a/0x170
[    9.276902][  T271]  ? kvmalloc_node+0x42/0x1e0
[    9.277053][  T271]  ? seq_read_iter+0x55/0x770
[    9.277205][  T271]  ? kvmalloc_node+0x42/0x1e0
[    9.277355][  T271]  kvmalloc_node+0x42/0x1e0
[    9.277503][  T271]  seq_read_iter+0x359/0x770
[    9.277653][  T271]  proc_reg_read_iter+0xab/0x140
[    9.277813][  T271]  vfs_read+0x294/0x3c0
[    9.277947][  T271]  ksys_read+0x82/0x1c0
[    9.278077][  T271]  __ia32_sys_read+0x1e/0x30
[    9.278227][  T271]  __do_fast_syscall_32+0x72/0xd0
[    9.278388][  T271]  ? __do_fast_syscall_32+0x7c/0xd0
[    9.278557][  T271]  ? lockdep_hardirqs_on_prepare+0x242/0x400
[    9.278759][  T271]  ? syscall_exit_to_user_mode+0x5f/0x90
[    9.278940][  T271]  ? __do_fast_syscall_32+0x7c/0xd0
[    9.279106][  T271]  ? syscall_exit_to_user_mode+0x5f/0x90
[    9.279285][  T271]  ? __do_fast_syscall_32+0x7c/0xd0
[    9.279453][  T271]  ? __do_fast_syscall_32+0x7c/0xd0
[    9.279621][  T271]  ? irqentry_exit_to_user_mode+0x23/0x30
[    9.279806][  T271]  do_fast_syscall_32+0x32/0x70
[    9.279960][  T271]  do_SYSENTER_32+0x15/0x20
[    9.280107][  T271]  entry_SYSENTER_32+0xa2/0xfb
[    9.280262][  T271] EIP: 0xb7f31549
[    9.280379][  T271] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[    9.280996][  T271] EAX: ffffffda EBX: 00000007 ECX: 004dd3d0 EDX: 00000400
[    9.281223][  T271] ESI: 004cfa90 EDI: b7e3a960 EBP: bfa86888 ESP: bfa86838
