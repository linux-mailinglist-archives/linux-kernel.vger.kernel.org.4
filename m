Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45567F419
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjA1CmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1CmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:42:01 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8F487585
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 18:41:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 622B3604F2;
        Sat, 28 Jan 2023 03:41:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1674873715; bh=xNALLMEGCu1e2Z0AuLZu9Y5lsiHKH0Ilj51qKC4JVHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gPqJOEkKjPT3S75fFrQbusDa41lg/JDOZIyzX/edrscE0vA9L9aWX1XZ73Z3iJQCD
         AdiU7eDpAOY/UoUP2gSCE0fITUZ5wsSj9c3WzFpEkHbRuGH4lrFDUjalVc2uI11i5r
         3yzaAHtoMR8s1/dH1wVO8kqeu7asL+OJE+7dlYI5fKyrOBMagg0QHnUvzW7FnseANR
         ysH/DLGK7vunwr8cu/+/vqbyFYoUYO+3Bys/NVPb5LRTDZisbGGBcwswvkLFkVcsyj
         1h5j5n9TnYIilpKuuzqJpIqFqhILEFv8lP6gZRk8beYYVgZJKrXk3mbGpExo3Exr67
         wCFtYi8Fw2fKw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id apBT7QIqKhG5; Sat, 28 Jan 2023 03:41:52 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.191])
        by domac.alu.hr (Postfix) with ESMTPSA id C9458604ED;
        Sat, 28 Jan 2023 03:41:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1674873712; bh=xNALLMEGCu1e2Z0AuLZu9Y5lsiHKH0Ilj51qKC4JVHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Myt0RSO2z1UcVDA2K459kLE3HXDSLa7SwJ7DY7HA5UqmeoiedbE1Gt7V8Yyz4dF7V
         ooiE12DzxgBh1WCpy7hU/MeXPSvzJGi2xzEwKHjRALRwWoIE50EdVbqlG2UXeUqZj+
         nJH8oqvfMqdq+tPPmxVchqTqg9noXSIl7LjBYaA5JboABEt0aNbvB/TsHY4wRZIq6I
         uJos9qJxypDHb9z23UhqfiSbM6JMrsEx0SveUikxNOJgfdZv4IUm4N9zScpStnrP8u
         q8+IbwbiltoKIi3iw/VjEQtnvfYIY7uSJPO5mQLsQkQoSAOtnlJdPMpuXGoYFCbcrl
         GAItsq3ugNwLw==
Message-ID: <07e42002-e78d-7947-19a7-0dd035466f50@alu.unizg.hr>
Date:   Sat, 28 Jan 2023 03:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Failure during Stack Depot allocating hash table of 1048576
 entries with kvcalloc
Content-Language: en-US, hr
To:     Borislav Petkov <bp@alien8.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <Y8Fq5m0CLfcFLCOY@zn.tnic>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y8Fq5m0CLfcFLCOY@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 01. 2023. 15:29, Borislav Petkov wrote:
> Hi,
> 
> Lemme CC the stackdepot.c commit signers re the below splat.
> 
> Lemme know if you need more info.
> 
> Thx.
> 
> ...
> [    0.000000] software IO TLB: area num 4.
> [    0.000000] Memory: 15612528K/16165300K available (12288K kernel code, 116072K rwdata, 5024K rodata, 2412K init, 3822
> 0K bss, 552516K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Stack Depot allocating hash table of 1048576 entries with kvcalloc
> [    0.000000] swapper: vmalloc error: size 8388608, vm_struct allocation failed, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nod
> emask=(null)
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.2.0-rc3+ #1
> [    0.000000] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
> [    0.000000] Call Trace:
> [    0.000000]  <TASK>
> [    0.000000]  dump_stack_lvl+0x33/0x46
> [    0.000000]  warn_alloc+0xff/0x120
> [    0.000000]  ? __get_vm_area_node+0x173/0x180
> [    0.000000]  __vmalloc_node_range+0x4d6/0x7d0
> [    0.000000]  ? stack_depot_init.cold+0x5e/0x8f
> [    0.000000]  ? __kmalloc_large_node+0xde/0x120
> [    0.000000]  kvmalloc_node+0xb7/0xd0
> [    0.000000]  ? stack_depot_init.cold+0x5e/0x8f
> [    0.000000]  stack_depot_init.cold+0x5e/0x8f
> [    0.000000]  kmemleak_init+0x17/0x106
> [    0.000000]  start_kernel+0x3e8/0x64e
> [    0.000000]  secondary_startup_64_no_verify+0xd3/0xdb
> [    0.000000]  </TASK>
> [    0.000000] Mem-Info:
> [    0.000000] active_anon:0 inactive_anon:0 isolated_anon:0
>                 active_file:0 inactive_file:0 isolated_file:0
>                 unevictable:0 dirty:0 writeback:0
>                 slab_reclaimable:0 slab_unreclaimable:25
>                 mapped:0 shmem:0 pagetables:0
>                 sec_pagetables:0 bounce:0
>                 kernel_misc_reclaimable:0
>                 free:3903107 free_pcp:0 free_cma:0
> [    0.000000] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:0kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
> [    0.000000] Node 0 DMA free:15360kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15988kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.000000] lowmem_reserve[]: 0 0 0 0
> [    0.000000] Node 0 DMA32 free:2262644kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:2534208kB managed:2262644kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.000000] lowmem_reserve[]: 0 0 0 0
> [    0.000000] Node 0 Normal free:13334424kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:13615104kB managed:13334780kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.000000] lowmem_reserve[]: 0 0 0 0
> [    0.000000] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
> [    0.000000] Node 0 DMA32: 5*4kB (UM) 2*8kB (M) 3*16kB (M) 3*32kB (M) 3*64kB (M) 2*128kB (M) 2*256kB (M) 3*512kB (M) 3*1024kB (M) 2*2048kB (M) 550*4096kB (M) = 2262644kB
> [    0.000000] Node 0 Normal: 6*4kB (UM) 6*8kB (UM) 5*16kB (UM) 0*32kB 0*64kB 2*128kB (UM) 4*256kB (M) 1*512kB (U) 2*1024kB (UM) 1*2048kB (U) 3254*4096kB (M) = 13334424kB
> [    0.000000] 0 total pagecache pages
> [    0.000000] 0 pages in swap cache
> [    0.000000] Free swap  = 0kB
> [    0.000000] Total swap = 0kB
> [    0.000000] 4041325 pages RAM
> [    0.000000] 0 pages HighMem/MovableOnly
> [    0.000000] 138129 pages reserved
> [    0.000000] 0 pages hwpoisoned
> [    0.000000] Stack Depot hash table allocation failed, disabling
> [    0.000000] ftrace: allocating 35561 entries in 139 pages
> [    0.000000] ftrace: allocated 139 pages with 4 groups
> [    0.000000] Dynamic Preempt: full

This appears to be a duplicate of the report:
https://lore.kernel.org/linux-mm/2c677d85-820c-d41a-fc98-7d3974b49e42@alu.unizg.hr/raw

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

