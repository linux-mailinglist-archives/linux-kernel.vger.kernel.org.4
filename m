Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6830668C845
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBFVJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjBFVJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:09:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036524CB7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675717756; x=1707253756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OW+8VvPtGDZ+Zi/gMd0HnCCT33/h7QFb6RI8Nhn9K4E=;
  b=KFIm6O39lHxByJdmv+amCnRE6Np9f1UE8Mmi+ECeLhquiYcFn+HGy+Gn
   yO/EdWt1VfjJ+qP5fUVF5i80L6x+T52bd3H2PggkWTO2eKexkazo2isQa
   JHLeotgRJ2zJl+YZFSz5efB7xxW24KzpwHq9dgd/gaSlp2HNzUigps+Fd
   3kpKgqCLXPB1C1nE8ccidXl9i5kMGIpZqYn4Cm3KxRnoHHz/0FIKJdGPa
   hy96vaf0QhMo5QzpzFBNNPf6t1aA1YF8fxAz9e7fEkyAHh5lYNgPRSLV0
   nG2Towe/0ZJ54OI1lnSSsfF5YukABIc7xiZaXuoAnnOGvm8wyMi/4IM60
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327950037"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327950037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 13:09:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="666608032"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="666608032"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2023 13:09:13 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP8jh-0002n1-09;
        Mon, 06 Feb 2023 21:09:13 +0000
Date:   Tue, 7 Feb 2023 05:09:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:sched/core 8/10] vmlinux.o: warning: objtool:
 native_sched_clock+0x7d: call to ftrace_likely_update() leaves .noinstr.text
 section
Message-ID: <202302070512.rKWJ7hb1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   4d627628d7584f3d3add1d53342d0f01aa878e04
commit: 8739c6811572b087decd561f96382087402cc343 [8/10] sched/clock/x86: Mark sched_clock() noinstr
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20230207/202302070512.rKWJ7hb1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=8739c6811572b087decd561f96382087402cc343
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout 8739c6811572b087decd561f96382087402cc343
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __asan_memset+0x53: call to __memset() with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_memmove+0x7f: call to __memmove() with UACCESS enabled
   vmlinux.o: warning: objtool: __asan_memcpy+0x7f: call to __memcpy() with UACCESS enabled
   vmlinux.o: warning: objtool: __wrgsbase_inactive+0x36: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __rdgsbase_inactive+0x32: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x75: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x3d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0xbc: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x34: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: native_sched_clock+0x7d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu+0xd: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0x4d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check+0x52: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: pvclock_clocksource_read_nowd+0xb2: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x49: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x8e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x3f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit+0x3e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_processor_ffh_cstate_enter+0x45: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_s2idle+0x63: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_xstate+0x5e: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_irq+0x5a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle+0x59: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: intel_idle_ibrs+0x12: call to sched_smt_active() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter_s2idle+0x53: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: acpi_idle_enter+0x4c: call to ftrace_likely_update() leaves .noinstr.text section


objdump-func vmlinux.o native_sched_clock:
0000 000000000000158f <native_sched_clock>:
0000     158f:	f3 0f 1e fa          	endbr64
0004     1593:	e9 de 00 00 00       	jmp    1676 <native_sched_clock+0xe7>
0009     1598:	55                   	push   %rbp
000a     1599:	48 89 e5             	mov    %rsp,%rbp
000d     159c:	41 57                	push   %r15
000f     159e:	41 56                	push   %r14
0011     15a0:	41 55                	push   %r13
0013     15a2:	41 54                	push   %r12
0015     15a4:	53                   	push   %rbx
0016     15a5:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
001a     15a9:	48 83 ec 20          	sub    $0x20,%rsp
001e     15ad:	0f 31                	rdtsc
0020     15af:	48 c1 e2 20          	shl    $0x20,%rdx
0024     15b3:	48 09 c2             	or     %rax,%rdx
0027     15b6:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
002c     15bb:	ff 05 00 00 00 00    	incl   0x0(%rip)        # 15c1 <native_sched_clock+0x32>	15bd: R_X86_64_PC32	pcpu_hot+0x4
0032     15c1:	44 8b 3d 00 00 00 00 	mov    0x0(%rip),%r15d        # 15c8 <native_sched_clock+0x39>	15c4: R_X86_64_PC32	cyc2ns+0x1c
0039     15c8:	44 89 f8             	mov    %r15d,%eax
003c     15cb:	83 e0 01             	and    $0x1,%eax
003f     15ce:	48 89 c2             	mov    %rax,%rdx
0042     15d1:	48 c1 e2 04          	shl    $0x4,%rdx
0046     15d5:	48 8b 9a 00 00 00 00 	mov    0x0(%rdx),%rbx	15d8: R_X86_64_32S	cyc2ns+0x8
004d     15dc:	48 89 c2             	mov    %rax,%rdx
0050     15df:	48 c1 e2 04          	shl    $0x4,%rdx
0054     15e3:	44 8b a2 00 00 00 00 	mov    0x0(%rdx),%r12d	15e6: R_X86_64_32S	cyc2ns
005b     15ea:	44 8b b2 00 00 00 00 	mov    0x0(%rdx),%r14d	15ed: R_X86_64_32S	cyc2ns+0x4
0062     15f1:	44 8b 2d 00 00 00 00 	mov    0x0(%rip),%r13d        # 15f8 <native_sched_clock+0x69>	15f4: R_X86_64_PC32	cyc2ns+0x1c
0069     15f8:	31 f6                	xor    %esi,%esi
006b     15fa:	45 39 ef             	cmp    %r13d,%r15d
006e     15fd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	1600: R_X86_64_32S	_ftrace_annotated_branch+0x8c40
0075     1604:	40 0f 95 c6          	setne  %sil
0079     1608:	31 c9                	xor    %ecx,%ecx
007b     160a:	31 d2                	xor    %edx,%edx
007d     160c:	e8 00 00 00 00       	call   1611 <native_sched_clock+0x82>	160d: R_X86_64_PLT32	ftrace_likely_update-0x4
0082     1611:	45 39 ef             	cmp    %r13d,%r15d
0085     1614:	75 ab                	jne    15c1 <native_sched_clock+0x32>
0087     1616:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
008c     161b:	45 89 e4             	mov    %r12d,%r12d
008f     161e:	49 f7 e4             	mul    %r12
0092     1621:	49 89 c4             	mov    %rax,%r12
0095     1624:	49 89 d5             	mov    %rdx,%r13
0098     1627:	41 83 fe 7f          	cmp    $0x7f,%r14d
009c     162b:	76 1e                	jbe    164b <native_sched_clock+0xbc>
009e     162d:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
00a3     1632:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
00a8     1637:	44 89 f2             	mov    %r14d,%edx
00ab     163a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	163d: R_X86_64_32S	.data+0xb1880
00b2     1641:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
00b7     1646:	e8 00 00 00 00       	call   164b <native_sched_clock+0xbc>	1647: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
00bc     164b:	44 89 f1             	mov    %r14d,%ecx
00bf     164e:	4d 0f ad ec          	shrd   %cl,%r13,%r12
00c3     1652:	49 d3 ed             	shr    %cl,%r13
00c6     1655:	41 f6 c6 40          	test   $0x40,%r14b
00ca     1659:	4d 0f 45 e5          	cmovne %r13,%r12
00ce     165d:	4a 8d 04 23          	lea    (%rbx,%r12,1),%rax
00d2     1661:	ff 0d 00 00 00 00    	decl   0x0(%rip)        # 1667 <native_sched_clock+0xd8>	1663: R_X86_64_PC32	pcpu_hot+0x4
00d8     1667:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
00dc     166b:	5b                   	pop    %rbx
00dd     166c:	41 5c                	pop    %r12
00df     166e:	41 5d                	pop    %r13
00e1     1670:	41 5e                	pop    %r14
00e3     1672:	41 5f                	pop    %r15
00e5     1674:	5d                   	pop    %rbp
00e6     1675:	c3                   	ret
00e7     1676:	48 69 05 00 00 00 00 d5 dc 32 00 	imul   $0x32dcd5,0x0(%rip),%rax        # 1681 <native_sched_clock+0xf2>	1679: R_X86_64_PC32	jiffies_64-0x8
00f2     1681:	48 ba d0 42 64 d9 70 23 cd ff 	movabs $0xffcd2370d96442d0,%rdx
00fc     168b:	48 01 d0             	add    %rdx,%rax
00ff     168e:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
