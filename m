Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8841B6093A6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiJWNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJWNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:33:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67507167C3;
        Sun, 23 Oct 2022 06:33:35 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1omb6Z-0007RC-6G; Sun, 23 Oct 2022 15:33:31 +0200
Message-ID: <6a02e9d4-690e-1f71-066a-c2d8bd811a0c@leemhuis.info>
Date:   Sun, 23 Oct 2022 15:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd) #forregzbot
Content-Language: en-US, de-DE
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221021160603.GA23307@u164.east.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666532015;8cd60279;
X-HE-SMSGID: 1omb6Z-0007RC-6G
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 21.10.22 18:06, Anatoly Pugachev wrote:
> On Thu, Aug 11, 2022 at 12:13:28PM -0400, Peter Xu wrote:
>> Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
>> shouldn't be a correctness issue since when pmd_dirty() we'll have the page
>> marked dirty anyway, however having dirty bit carried over helps the next
>> initial writes of split ptes on some archs like x86.
>>
>> Reviewed-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  mm/huge_memory.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> 
> Hello!
> 
> Tried to update my debian sparc64 sid (unstable) linux distro to latest
> version of available packages, got dpkg segfault... 

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 0ccf7f168e17bb7
#regzbot title mm: sparc64: dpkg fails on sparc64 since "mm/thp: Carry
over dirty bit when thp splits on pmd)"
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> $ apt update -y
> ...
> Unpacking linux-image-sparc64-smp (6.0.2-1) ...
> E: Sub-process /usr/bin/dpkg received a segmentation fault.
> 
> Downgraded dpkg from 1.21.9 to 1.21.8 / 1.21.7 (2-3 monthes old
> versions) - still getting segfault on package install (which was never
> an issue before, even on this old dpkg versions).
> 
> Tried to gdb backtrace core file, which is unlucky :
> 
> 
> root@ttip:/# apt install -y linux-image-sparc64-smp ccache qemu-utils xdelta qemu-system-x86 distcc qemu-efi-aarch64 pkg-kde-tools
> ...
> Preparing to unpack .../2-linux-image-6.0.0-1-sparc64-smp_6.0.2-1_sparc64.deb ...
> Unpacking linux-image-6.0.0-1-sparc64-smp (6.0.2-1) ...
> Selecting previously unselected package linux-image-sparc64-smp.
> Preparing to unpack .../3-linux-image-sparc64-smp_6.0.2-1_sparc64.deb ...
> Unpacking linux-image-sparc64-smp (6.0.2-1) ...
> E: Sub-process /usr/bin/dpkg received a segmentation fault.
> root@ttip:/# ls -l core.4751
> -rw------- 1 root root 25042944 Oct 21 14:38 core.4751
> root@ttip:/# gdb -q -c core.4751
> GNU gdb (Debian 12.1-4) 12.1
> [New LWP 4751]
> Core was generated by `/usr/bin/dpkg --status-fd 15 --no-triggers --unpack --auto-deconfigure --recurs'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0xfff800010089cde4 in ?? ()
> (gdb) bt
> #0  0xfff800010089cde4 in ?? ()
> Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> (gdb)
> 
> 
> rebooted from my compiled kernel 6.1.0-rc1 to older (debian) kernel -
> 5.19.0-2-sparc64-smp
> 
> dpkg installed packages without any problems. Removed just installed
> packages, rebooted to 6.1.0-rc1 and tried to install packages, dpkg got
> segfault again.
> 
> Recompiled 6.1.0-rc1 with gcc-11 instead of gcc-12, still segfaults...
> ... bisect time ...
> 
> mator@ttip:~/linux-2.6$ git bisect log
> # bad: [9abf2313adc1ca1b6180c508c25f22f9395cc780] Linux 6.1-rc1
> # good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
> git bisect start 'v6.1-rc1' 'v6.0'
> # good: [18fd049731e67651009f316195da9281b756f2cf] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect good 18fd049731e67651009f316195da9281b756f2cf
> # good: [4c540c92b46497dcda59203eea78e4620bc96f47] RISC-V: Add mvendorid, marchid, and mimpid to /proc/cpuinfo output
> git bisect good 4c540c92b46497dcda59203eea78e4620bc96f47
> # bad: [27bc50fc90647bbf7b734c3fc306a5e61350da53] Merge tag 'mm-stable-2022-10-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 27bc50fc90647bbf7b734c3fc306a5e61350da53
> # good: [ada3bfb6492a6d0d3eca50f3b61315fe032efc72] Merge tag 'tpmdd-next-v6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
> git bisect good ada3bfb6492a6d0d3eca50f3b61315fe032efc72
> # bad: [5f7fa13fa858c17580ed513bd5e0a4b36d68fdd6] mm: add pageblock_align() macro
> git bisect bad 5f7fa13fa858c17580ed513bd5e0a4b36d68fdd6
> # bad: [54a611b605901c7d5d05b6b8f5d04a6ceb0962aa] Maple Tree: add new data structure
> git bisect bad 54a611b605901c7d5d05b6b8f5d04a6ceb0962aa
> # good: [59298997df89e19aad426d4ae0a7e5037074da5a] x86/uaccess: avoid check_object_size() in copy_from_user_nmi()
> git bisect good 59298997df89e19aad426d4ae0a7e5037074da5a
> # good: [04c6b79ae4f0bcbd96afd7cea5e1a8848162438e] btrfs: convert __process_pages_contig() to use filemap_get_folios_contig()
> git bisect good 04c6b79ae4f0bcbd96afd7cea5e1a8848162438e
> # good: [da29499124cd2221539b235c1f93c7d93faf6565] mm, hwpoison: use __PageMovable() to detect non-lru movable pages
> git bisect good da29499124cd2221539b235c1f93c7d93faf6565
> # bad: [eed9a328aa1ae6ac1edaa026957e6882f57de0dd] mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> git bisect bad eed9a328aa1ae6ac1edaa026957e6882f57de0dd
> # bad: [f347c9d2697fcbbb64e077f7113a3887a181b8c0] filemap: make the accounting of thrashing more consistent
> git bisect bad f347c9d2697fcbbb64e077f7113a3887a181b8c0
> # good: [eba4d770efc86a3710e36b828190858abfa3bb74] mm/swap: comment all the ifdef in swapops.h
> git bisect good eba4d770efc86a3710e36b828190858abfa3bb74
> # bad: [2e3468778dbe3ec389a10c21a703bb8e5be5cfbc] mm: remember young/dirty bit for page migrations
> git bisect bad 2e3468778dbe3ec389a10c21a703bb8e5be5cfbc
> # bad: [0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb] mm/thp: carry over dirty bit when thp splits on pmd
> git bisect bad 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb
> # good: [0d206b5d2e0d7d7f09ac9540e3ab3e35a34f536e] mm/swap: add swp_offset_pfn() to fetch PFN from swap entry
> git bisect good 0d206b5d2e0d7d7f09ac9540e3ab3e35a34f536e
> # first bad commit: [0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb] mm/thp: carry over dirty bit when thp splits on pmd
> 
> 
> mator@ttip:~/linux-2.6$ git bisect good
> 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb is the first bad commit
> commit 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Aug 11 12:13:28 2022 -0400
> 
>     mm/thp: carry over dirty bit when thp splits on pmd
> 
>     Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
>     shouldn't be a correctness issue since when pmd_dirty() we'll have the
>     page marked dirty anyway, however having dirty bit carried over helps the
>     next initial writes of split ptes on some archs like x86.
> 
>     Link: https://lkml.kernel.org/r/20220811161331.37055-5-peterx@redhat.com
> 
> 
> 
> So, v6.0-rc3-176-g0d206b5d2e0d) does not segfault dpkg,
> v6.0-rc3-177-g0ccf7f168e17 segfaults it on package install.
> 
> dpkg test was (apt) install/remove some packages, segfaults only on install
> (not remove).
> 
> Reverted 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb from top of v6.1-rc1 and
> tried to compile kernel, but got error 
> 
> mm/huge_memory.c: In function ‘__split_huge_pmd_locked’:
> mm/huge_memory.c:2129:17: error: ‘dirty’ undeclared (first use in this function)
>  2129 |                 dirty = is_migration_entry_dirty(entry);
>       |                 ^~~~~
> mm/huge_memory.c:2129:17: note: each undeclared identifier is reported only once for each function it appears in
> make[2]: *** [scripts/Makefile.build:250: mm/huge_memory.o] Error 1
> 
> So can't test v6.1-rc1 with patch reverted...
