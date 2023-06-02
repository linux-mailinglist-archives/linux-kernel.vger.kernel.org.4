Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196D371FF6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjFBKfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjFBKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:34:51 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF8910C8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:33:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="98600087"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="98600087"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:08 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4381CC3F80
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6872BE647D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:04 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 730392F4C31;
        Fri,  2 Jun 2023 19:27:02 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     kexec@lists.infradead.org, nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        bhe@redhat.com, ruansy.fnst@fujitsu.com, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, Li Zhijian <lizhijian@fujitsu.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86@kernel.org
Subject: [RFC PATCH v3 0/3] pmem memmap dump support
Date:   Fri,  2 Jun 2023 18:26:49 +0800
Message-Id: <20230602102656.131654-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--27.366500-10.000000
X-TMASE-MatchedRID: vYzBBoYqFnIL0MkR8StpMHzmmMD/HXF+1QQ6Jx/fflZdXeeZrNJbgtSH
        nJDq2yhM8Xo3NKXpyhevaHVEeXCQcbF6nptaEfP/KQxHYsCcxGn0swHSFcVJ6J4Q+L3BXIWuT1z
        kvtd51Lg3hBXKCg/wwFQq+dhQEIHhk7vOomzD71wK3Ma88LL+boIw3bnTjwR6+OO8YTtOnsLJFa
        y2oiD2TjuQeheTvyfknALOVSaqFWVn8E7VhPK+pqJVTu7sjgg1homn0bwgVmkfmRnL8RBuBBpP9
        70zHN/Y1oO1QnWfbjp/iseCANV019DFhoVadDNxBe3KRVyu+k2/yN2q8U674pArM4zg1+iSGNtH
        9cKwddarbBryRVQGjVW5uDlybuu3uHnt1UKh315i71i5on34Kj/FEHo4adva6ljkEk+hhAeYFC8
        uMwGxQQUz8cUeDqKoj0RC7hmppJv8esyAp1A0ZwmyVrMCuJ9SY/8hgefJn7BLIy6IPbYWFx2rrG
        e8rZbLZwtNYoYGSjw2mtxMhqolwypD3qhltGUjtT4jIeGRd/W/mvr+BRd9bnUJIpqzDt/HqgqKT
        3T4weX9UygY5s61EU1i01tCTSuDH8dePSFct0l9SSAOK4bGf9Fb0ZIwh4Su31GNm6M+JKTiuX4U
        cbdWgBcfmI3+RkHYDMsOoTK7WFBtnFZPAvryPrqQyAveNtg6uoYFb0nRiqM8cwBuO6HB3xg4MG1
        tpr1J9XlZDxPHq+BgLfJxky5aUlFL3FSfuOf23QqJN4m15UGuLG21Eb4T8wZZ8N3RvTMxo8WMkQ
        Wv6iXBcIE78YqRWo6HM5rqDwqtlExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

After sending out the previous version of the patch set, we received some comments,
and we really appreciate your input. However, as you can see, the current patch
set is still in its early stages, especially in terms of the solution selection,
which may still undergo changes.

Changes in V3:
Mainly based on the understanding from the first version, I implemented the proposal
suggested by Dan. In the kdump kernel, the device's superblock is read through
a device file interface to calculate the metadata range. In the second version,
the first kernel writes the metadata range to vmcoreinfo, and after kdump occurs,
the kdump kernel can directly read it from /proc/vmcore.

Comparing these two approaches, the advantage of Version 3 is fewer kernel
modifications, but the downside is the introduction of a new external library,
libndctl, to search for each namespace, which introduces a higher level of
coupling with ndctl.

One important thing to note about both V2 and V3 is the introduction of a new
ELF flag, PF_DEV, to indicate whether a range is on a device. I'm not sure if
there are better alternatives or if we can use this flag internally without
exposing it in elf.h.

We greatly appreciate your feedback and would like to hear your response.

In RFC stage, I folded these 3 projects in this same cover letter for reviewing convenience.
kernel(3):
  nvdimm: set force_raw=1 in kdump kernel
  x86/crash: Add pmem region into PT_LOADs of vmcore
  kernel/kexec_file: Mark pmem region with new flag PF_DEV
kexec-tools(1):
  kexec: Add and mark pmem region into PT_LOADs
makedumpfile(3):
  elf_info.c: Introduce is_pmem_pt_load_range
  makedumpfile.c: Exclude all pmem pages
  makedumpfile: get metadata boundaries from pmem's infoblock

Currently, this RFC has already implemented to supported case D*. And the case A&B is disabled
deliberately in makedumpfile.
---

pmem memmap can also be called pmem metadata here.

### Background and motivate overview ###
---
Crash dump is an important feature for trouble shooting of kernel. It is the final way to chase what
happened at the kernel panic, slowdown, and so on. It is the most important tool for customer support.
However, a part of data on pmem is not included in crash dump, it may cause difficulty to analyze
trouble around pmem (especially Filesystem-DAX).

A pmem namespace in "fsdax" or "devdax" mode requires allocation of per-page metadata[1]. The allocation
can be drawn from either mem(system memory) or dev(pmem device), see `ndctl help create-namespace` for
more details. In fsdax, struct page array becomes very important, it is one of the key data to find
status of reverse map.

So, when metadata was stored in pmem, even pmem's per-page metadata will not be dumped. That means
troubleshooters are unable to check more details about pmem from the dumpfile.

### Make pmem memmap dump support ###
---
Our goal is that whether metadata is stored on mem or pmem, its metadata can be dumped and then the
crash-utilities can read more details about the pmem. Of course, this feature can be enabled/disabled.

First, based on our previous investigation, according to the location of metadata and the scope of
dump, we can divide it into the following four cases: A, B, C, D.
It should be noted that although we mentioned case A&B below, we do not want these two cases to be
part of this feature, because dumping the entire pmem will consume a lot of space, and more importantly,
it may contain user sensitive data.

+-------------+----------+------------+
|\+--------+\     metadata location   |
|            ++-----------------------+
| dump scope  |  mem     |   PMEM     |
+-------------+----------+------------+
| entire pmem |     A    |     B      |
+-------------+----------+------------+
| metadata    |     C    |     D      |
+-------------+----------+------------+

### Testing ###
Only x86_64 are tested. Please note that we have to disable the 2nd kernel's libnvdimm to ensure the
metadata in 2nd kernel will not be touched again.

below 2 commits use sha256 to check the metadata in 1st kernel during panic and makedumpfile in 2nd kernel.
https://github.com/zhijianli88/makedumpfile/commit/91a135be6980e6e87b9e00b909aaaf8ef9566ec0
https://github.com/zhijianli88/linux/commit/55bef07f8f0b2e587737b796e73b92f242947e5a

### TODO ###
Only x86 are fully supported for both kexec_load(2) and kexec_file_load(2)
kexec_file_load(2) on other architectures are TODOs.
---
[1] Pmem region layout:
   ^<--namespace0.0---->^<--namespace0.1------>^
   |                    |                      |
   +--+m----------------+--+m------------------+---------------------+-+a
   |++|e                |++|e                  |                     |+|l
   |++|t                |++|t                  |                     |+|i
   |++|a                |++|a                  |                     |+|g
   |++|d  namespace0.0  |++|d  namespace0.1    |     un-allocated    |+|n
   |++|a    fsdax       |++|a     devdax       |                     |+|m
   |++|t                |++|t                  |                     |+|e
   +--+a----------------+--+a------------------+---------------------+-+n
   |                                                                   |t
   v<-----------------------pmem region------------------------------->v

[2] https://lore.kernel.org/linux-mm/70F971CF-1A96-4D87-B70C-B971C2A1747C@roc.cs.umass.edu/T/
[3] https://lore.kernel.org/linux-mm/3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com/

### makedumpfile output in case B ####
kdump.sh[224]: makedumpfile: version 1.7.2++ (released on 20 Oct 2022)
kdump.sh[224]: command line: makedumpfile -l --message-level 31 -d 31 /proc/vmcore /sysroot/var/crash/127.0.0.1-2023-04-21-02:50:57//vmcore-incomplete
kdump.sh[224]: sadump: does not have partition header
kdump.sh[224]: sadump: read dump device as unknown format
kdump.sh[224]: sadump: unknown format
kdump.sh[224]:                phys_start         phys_end       virt_start         virt_end  is_pmem
kdump.sh[224]: LOAD[ 0]          1000000          3c26000 ffffffff81000000 ffffffff83c26000    false
kdump.sh[224]: LOAD[ 1]           100000         7f000000 ffff888000100000 ffff88807f000000    false
kdump.sh[224]: LOAD[ 2]         bf000000         bffd7000 ffff8880bf000000 ffff8880bffd7000    false
kdump.sh[224]: LOAD[ 3]        100000000        140000000 ffff888100000000 ffff888140000000    false
kdump.sh[224]: LOAD[ 4]        140000000        23e200000 ffff888140000000 ffff88823e200000     true
kdump.sh[224]: Linux kdump
kdump.sh[224]: VMCOREINFO   :
kdump.sh[224]:   OSRELEASE=6.3.0-rc3-pmem-bad+
kdump.sh[224]:   BUILD-ID=0546bd82db93706799d3eea38194ac648790aa85
kdump.sh[224]:   PAGESIZE=4096
kdump.sh[224]: page_size    : 4096
kdump.sh[224]:   SYMBOL(init_uts_ns)=ffffffff82671300
kdump.sh[224]:   OFFSET(uts_namespace.name)=0
kdump.sh[224]:   SYMBOL(node_online_map)=ffffffff826bbe08
kdump.sh[224]:   SYMBOL(swapper_pg_dir)=ffffffff82446000
kdump.sh[224]:   SYMBOL(_stext)=ffffffff81000000
kdump.sh[224]:   SYMBOL(vmap_area_list)=ffffffff82585fb0
kdump.sh[224]:   SYMBOL(devm_memmap_vmcore_head)=ffffffff825603c0
kdump.sh[224]:   SIZE(devm_memmap_vmcore)=40
kdump.sh[224]:   OFFSET(devm_memmap_vmcore.entry)=0
kdump.sh[224]:   OFFSET(devm_memmap_vmcore.start)=16
kdump.sh[224]:   OFFSET(devm_memmap_vmcore.end)=24
kdump.sh[224]:   SYMBOL(mem_section)=ffff88813fff4000
kdump.sh[224]:   LENGTH(mem_section)=2048
kdump.sh[224]:   SIZE(mem_section)=16
kdump.sh[224]:   OFFSET(mem_section.section_mem_map)=0
...
kdump.sh[224]: STEP [Checking for memory holes  ] : 0.012699 seconds
kdump.sh[224]: STEP [Excluding unnecessary pages] : 0.538059 seconds
kdump.sh[224]: STEP [Copying data               ] : 0.995418 seconds
kdump.sh[224]: STEP [Copying data               ] : 0.000067 seconds
kdump.sh[224]: Writing erase info...
kdump.sh[224]: offset_eraseinfo: 5d02266, size_eraseinfo: 0
kdump.sh[224]: Original pages  : 0x00000000001c0cfd
kdump.sh[224]:   Excluded pages   : 0x00000000001a58d2
kdump.sh[224]:     Pages filled with zero  : 0x0000000000006805
kdump.sh[224]:     Non-private cache pages : 0x0000000000019e93
kdump.sh[224]:     Private cache pages     : 0x0000000000077572
kdump.sh[224]:     User process data pages : 0x0000000000002c3b
kdump.sh[224]:     Free pages              : 0x0000000000010e8d
kdump.sh[224]:     Hwpoison pages          : 0x0000000000000000
kdump.sh[224]:     Offline pages           : 0x0000000000000000
kdump.sh[224]:     pmem metadata pages     : 0x0000000000000000
kdump.sh[224]:     pmem userdata pages     : 0x00000000000fa200
kdump.sh[224]:   Remaining pages  : 0x000000000001b42b
kdump.sh[224]:   (The number of pages is reduced to 6%.)
kdump.sh[224]: Memory Hole     : 0x000000000007d503
kdump.sh[224]: --------------------------------------------------
kdump.sh[224]: Total pages     : 0x000000000023e200
kdump.sh[224]: Write bytes     : 97522590
kdump.sh[224]: Cache hit: 191669, miss: 292, hit rate: 99.8%
kdump.sh[224]: The dumpfile is saved to /sysroot/var/crash/127.0.0.1-2023-04-21-02:50:57//vmcore-incomplete.
kdump.sh[224]: makedumpfile Completed.

CC: Baoquan He <bhe@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Dave Young <dyoung@redhat.com>
CC: Eric Biederman <ebiederm@xmission.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: x86@kernel.org
CC: kexec@lists.infradead.org
CC: nvdimm@lists.linux.dev

-- 
2.29.2

