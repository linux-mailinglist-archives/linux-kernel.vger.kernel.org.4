Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9468CC42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBGBqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBGBqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:46:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22EF3644B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675734347; x=1707270347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vvKKbaXxXsaUpmsJMxijqZEagzraOoOKcASM8s9ugBc=;
  b=KyFsnC6e3hB7cxN2+No5mXT7/Cx8+VbJUPCU/stzN5HDR7vkkqzSPknP
   AeFSbFbMANuMzxjDzM89u3pb1tD+kgTsP4sX43tb0QJ6QYN3miAOA73fE
   bset6IUV4uv/ppn9LkDi8I4Es3HomRsERc8aSpiqtxyyIrcTOlGxPjfcq
   Op4Ra7MMqPLPBordpswyxhQV5+PXaI+/+mub/tHQ4Ttlt30m2Q53AYADr
   mwny+Pxkl3QCq5DO/+6IK4Ay6Q2mK+nvxmwHTfEpfJGzk6zYu1FOKW9vF
   Vh2DeNMll3K6kB4VmUjyjg577cTLxLSsVDTJvzolYC3V8eUQkSSmYuFcR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393971870"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="393971870"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 17:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="730216798"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="730216798"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2023 17:44:27 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPD22-0002w6-0x;
        Tue, 07 Feb 2023 01:44:26 +0000
Date:   Tue, 7 Feb 2023 09:44:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:sched/core 9/10] vmlinux.o: warning: objtool: local_clock+0x44:
 call to ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202302070951.oHp56RIa-lkp@intel.com>
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
commit: 776f22913b8e50011004c6ae43004711dab7efa5 [9/10] sched/clock: Make local_clock() noinstr
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20230207/202302070951.oHp56RIa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=776f22913b8e50011004c6ae43004711dab7efa5
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout 776f22913b8e50011004c6ae43004711dab7efa5
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
   vmlinux.o: warning: objtool: native_sched_clock+0x7d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu+0xd: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0x4d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check+0x52: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: pvclock_clocksource_read_nowd+0xb2: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: local_clock+0x44: call to ftrace_likely_update() leaves .noinstr.text section
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


objdump-func vmlinux.o local_clock:
0000 0000000000002d8c <local_clock>:
0000     2d8c:	f3 0f 1e fa          	endbr64
0004     2d90:	41 54                	push   %r12
0006     2d92:	53                   	push   %rbx
0007     2d93:	eb 14                	jmp    2da9 <local_clock+0x1d>
0009     2d95:	e8 00 00 00 00       	call   2d9a <local_clock+0xe>	2d96: R_X86_64_PLT32	sched_clock-0x4
000e     2d9a:	48 03 05 00 00 00 00 	add    0x0(%rip),%rax        # 2da1 <local_clock+0x15>	2d9d: R_X86_64_PC32	__sched_clock_offset-0x4
0015     2da1:	49 89 c4             	mov    %rax,%r12
0018     2da4:	e9 cc 00 00 00       	jmp    2e75 <local_clock+0xe9>
001d     2da9:	ff 05 00 00 00 00    	incl   0x0(%rip)        # 2daf <local_clock+0x23>	2dab: R_X86_64_PC32	pcpu_hot+0x4
0023     2daf:	e8 00 00 00 00       	call   2db4 <local_clock+0x28>	2db0: R_X86_64_PLT32	sched_clock-0x4
0028     2db4:	48 2b 05 00 00 00 00 	sub    0x0(%rip),%rax        # 2dbb <local_clock+0x2f>	2db7: R_X86_64_PC32	sched_clock_data-0x4
002f     2dbb:	31 c9                	xor    %ecx,%ecx
0031     2dbd:	31 d2                	xor    %edx,%edx
0033     2dbf:	49 89 c4             	mov    %rax,%r12
0036     2dc2:	48 c1 e8 3f          	shr    $0x3f,%rax
003a     2dc6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2dc9: R_X86_64_32S	_ftrace_annotated_branch+0x29be0
0041     2dcd:	48 89 c6             	mov    %rax,%rsi
0044     2dd0:	e8 00 00 00 00       	call   2dd5 <local_clock+0x49>	2dd1: R_X86_64_PLT32	ftrace_likely_update-0x4
0049     2dd5:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 2ddc <local_clock+0x50>	2dd8: R_X86_64_PC32	sched_clock_data+0xc
0050     2ddc:	31 c9                	xor    %ecx,%ecx
0052     2dde:	48 8b 15 00 00 00 00 	mov    0x0(%rip),%rdx        # 2de5 <local_clock+0x59>	2de1: R_X86_64_PC32	.data..read_mostly+0x26e4
0059     2de5:	48 03 15 00 00 00 00 	add    0x0(%rip),%rdx        # 2dec <local_clock+0x60>	2de8: R_X86_64_PC32	sched_clock_data+0x4
0060     2dec:	4d 85 e4             	test   %r12,%r12
0063     2def:	4c 0f 48 e1          	cmovs  %rcx,%r12
0067     2df3:	48 89 d1             	mov    %rdx,%rcx
006a     2df6:	48 89 c6             	mov    %rax,%rsi
006d     2df9:	48 29 c1             	sub    %rax,%rcx
0070     2dfc:	49 01 d4             	add    %rdx,%r12
0073     2dff:	48 85 c9             	test   %rcx,%rcx
0076     2e02:	48 89 c1             	mov    %rax,%rcx
0079     2e05:	48 0f 4f ca          	cmovg  %rdx,%rcx
007d     2e09:	48 81 c2 d5 dc 32 00 	add    $0x32dcd5,%rdx
0084     2e10:	48 29 d6             	sub    %rdx,%rsi
0087     2e13:	48 85 f6             	test   %rsi,%rsi
008a     2e16:	4c 89 e6             	mov    %r12,%rsi
008d     2e19:	48 0f 4f d0          	cmovg  %rax,%rdx
0091     2e1d:	48 29 ce             	sub    %rcx,%rsi
0094     2e20:	48 85 f6             	test   %rsi,%rsi
0097     2e23:	4c 0f 4e e1          	cmovle %rcx,%r12
009b     2e27:	49 39 d4             	cmp    %rdx,%r12
009e     2e2a:	4c 0f 49 e2          	cmovns %rdx,%r12
00a2     2e2e:	4c 0f b1 25 00 00 00 00 	cmpxchg %r12,0x0(%rip)        # 2e36 <local_clock+0xaa>	2e32: R_X86_64_PC32	sched_clock_data+0xc
00aa     2e36:	40 0f 95 c6          	setne  %sil
00ae     2e3a:	0f 94 c3             	sete   %bl
00b1     2e3d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2e40: R_X86_64_32S	_ftrace_annotated_branch+0x29bb0
00b8     2e44:	31 c9                	xor    %ecx,%ecx
00ba     2e46:	31 d2                	xor    %edx,%edx
00bc     2e48:	40 0f b6 f6          	movzbl %sil,%esi
00c0     2e4c:	e8 00 00 00 00       	call   2e51 <local_clock+0xc5>	2e4d: R_X86_64_PLT32	ftrace_likely_update-0x4
00c5     2e51:	31 c9                	xor    %ecx,%ecx
00c7     2e53:	0f b6 f3             	movzbl %bl,%esi
00ca     2e56:	ba 01 00 00 00       	mov    $0x1,%edx
00cf     2e5b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2e5e: R_X86_64_32S	_ftrace_annotated_branch+0x29b80
00d6     2e62:	e8 00 00 00 00       	call   2e67 <local_clock+0xdb>	2e63: R_X86_64_PLT32	ftrace_likely_update-0x4
00db     2e67:	84 db                	test   %bl,%bl
00dd     2e69:	0f 84 40 ff ff ff    	je     2daf <local_clock+0x23>
00e3     2e6f:	ff 0d 00 00 00 00    	decl   0x0(%rip)        # 2e75 <local_clock+0xe9>	2e71: R_X86_64_PC32	pcpu_hot+0x4
00e9     2e75:	4c 89 e0             	mov    %r12,%rax
00ec     2e78:	5b                   	pop    %rbx
00ed     2e79:	41 5c                	pop    %r12
00ef     2e7b:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
