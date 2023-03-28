Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60736CC9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjC1SGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjC1SG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:06:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F298
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680026787; x=1711562787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nAijSQ1k8u0lJZ89EcVO+KuMeKcEsy2/98bfVxO6GiY=;
  b=BLWTsin3CX+yb8R/YQrYry3RzKPDK7VftprE1GDpE6tcUyFxDLTxeExH
   5L1CmOcrK3E+jPAwzFvxFoTe8EuRi1wpFy3zmEueTwH1LUG8x7kvCwsl/
   ckCeLCIJ3Tmdq/mcUsW0m+CUvl509CJ72tP2iTkjao7KqwYsW0qRGGrVY
   gMfGDJ4QSE163FCPnYKXdKOOr1CjItemLLwZ6BawxH0IZvPEng2cLkwlB
   7gLM352zw8Us+Fbl2Zu6zrjqgQxx10z9n+Cck/RY1BYghKBZB3c26rFZv
   cQZ/flSCQobZTjD9YDqMLzAqaOyrEwbc8whYqZDrT5MXxCYaEiorowGk6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405589823"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405589823"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 11:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="753256819"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="753256819"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Mar 2023 11:06:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phDi3-000InP-27;
        Tue, 28 Mar 2023 18:06:15 +0000
Date:   Wed, 29 Mar 2023 02:05:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: vmlinux.o: warning: objtool: local_clock+0xaa: call to
 preempt_schedule_notrace_thunk() leaves .noinstr.text section
Message-ID: <202303290127.5NjnWVWg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a93e40326c8f470e71d20b4c42d36767450f38f
commit: 776f22913b8e50011004c6ae43004711dab7efa5 sched/clock: Make local_clock() noinstr
date:   8 weeks ago
config: x86_64-buildonly-randconfig-r004-20230327 (https://download.01.org/0day-ci/archive/20230329/202303290127.5NjnWVWg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=776f22913b8e50011004c6ae43004711dab7efa5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 776f22913b8e50011004c6ae43004711dab7efa5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303290127.5NjnWVWg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: native_sched_clock+0x97: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: local_clock+0xaa: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x30: call to preempt_count_add() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x66: call to preempt_count_add() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x38: call to preempt_count_add() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x30: call to preempt_count_add() leaves .noinstr.text section


objdump-func vmlinux.o local_clock:
0000 0000000000002800 <local_clock>:
0000     2800:	f3 0f 1e fa          	endbr64
0004     2804:	eb 1e                	jmp    2824 <local_clock+0x24>
0006     2806:	e8 00 00 00 00       	call   280b <local_clock+0xb>	2807: R_X86_64_PLT32	sched_clock-0x4
000b     280b:	48 03 05 00 00 00 00 	add    0x0(%rip),%rax        # 2812 <local_clock+0x12>	280e: R_X86_64_PC32	__sched_clock_offset-0x4
0012     2812:	49 89 c0             	mov    %rax,%r8
0015     2815:	4c 89 c0             	mov    %r8,%rax
0018     2818:	31 d2                	xor    %edx,%edx
001a     281a:	31 c9                	xor    %ecx,%ecx
001c     281c:	31 f6                	xor    %esi,%esi
001e     281e:	31 ff                	xor    %edi,%edi
0020     2820:	45 31 c0             	xor    %r8d,%r8d
0023     2823:	c3                   	ret
0024     2824:	ff 05 00 00 00 00    	incl   0x0(%rip)        # 282a <local_clock+0x2a>	2826: R_X86_64_PC32	pcpu_hot+0x4
002a     282a:	e8 00 00 00 00       	call   282f <local_clock+0x2f>	282b: R_X86_64_PLT32	sched_clock-0x4
002f     282f:	48 2b 05 00 00 00 00 	sub    0x0(%rip),%rax        # 2836 <local_clock+0x36>	2832: R_X86_64_PC32	sched_clock_data-0x4
0036     2836:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 283d <local_clock+0x3d>	2839: R_X86_64_PC32	.data..read_mostly+0x25b4
003d     283d:	48 89 c1             	mov    %rax,%rcx
0040     2840:	b8 00 00 00 00       	mov    $0x0,%eax
0045     2845:	48 0f 48 c8          	cmovs  %rax,%rcx
0049     2849:	48 03 15 00 00 00 00 	add    0x0(%rip),%rdx        # 2850 <local_clock+0x50>	284c: R_X86_64_PC32	sched_clock_data+0x4
0050     2850:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 2857 <local_clock+0x57>	2853: R_X86_64_PC32	sched_clock_data+0xc
0057     2857:	48 89 d7             	mov    %rdx,%rdi
005a     285a:	48 89 d6             	mov    %rdx,%rsi
005d     285d:	48 29 c7             	sub    %rax,%rdi
0060     2860:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
0064     2864:	48 85 ff             	test   %rdi,%rdi
0067     2867:	7f 09                	jg     2872 <local_clock+0x72>
0069     2869:	4c 89 c1             	mov    %r8,%rcx
006c     286c:	48 89 c6             	mov    %rax,%rsi
006f     286f:	48 29 c1             	sub    %rax,%rcx
0072     2872:	48 81 c2 00 09 3d 00 	add    $0x3d0900,%rdx
0079     2879:	48 89 c7             	mov    %rax,%rdi
007c     287c:	48 29 d7             	sub    %rdx,%rdi
007f     287f:	48 85 ff             	test   %rdi,%rdi
0082     2882:	48 0f 4f d0          	cmovg  %rax,%rdx
0086     2886:	48 85 c9             	test   %rcx,%rcx
0089     2889:	4c 0f 4e c6          	cmovle %rsi,%r8
008d     288d:	49 39 d0             	cmp    %rdx,%r8
0090     2890:	4c 0f 49 c2          	cmovns %rdx,%r8
0094     2894:	4c 0f b1 05 00 00 00 00 	cmpxchg %r8,0x0(%rip)        # 289c <local_clock+0x9c>	2898: R_X86_64_PC32	sched_clock_data+0xc
009c     289c:	75 8c                	jne    282a <local_clock+0x2a>
009e     289e:	ff 0d 00 00 00 00    	decl   0x0(%rip)        # 28a4 <local_clock+0xa4>	28a0: R_X86_64_PC32	pcpu_hot+0x4
00a4     28a4:	0f 85 6b ff ff ff    	jne    2815 <local_clock+0x15>
00aa     28aa:	e8 00 00 00 00       	call   28af <local_clock+0xaf>	28ab: R_X86_64_PLT32	preempt_schedule_notrace_thunk-0x4
00af     28af:	e9 61 ff ff ff       	jmp    2815 <local_clock+0x15>
00b4     28b4:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
00be     28be:	66 90                	xchg   %ax,%ax

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
