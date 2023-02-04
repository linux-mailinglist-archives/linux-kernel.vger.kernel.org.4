Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9968AB09
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjBDQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 11:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 11:06:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBCB22A0A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 08:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675526817; x=1707062817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=74jhwRipY9DqEhY/9dgCcUoI6QNGE/J2TwduXSDlwY4=;
  b=JXX8H7ZrSqkwfHqax5FOEvbpePEYuHOCYajtBxQdQDaWXOjkk/HqOzQk
   1Igb8J25WX2sn3fPjflGXi5jS2lADdMWLTKGUtRI9tDa1qZbR9P2LUy95
   6Vgh0zBpDG4RSsH8BkT3U1+kGx35rOjxFBh7ljJ7XqhQFZPYoI7D+fKhV
   UcGvvTkwYazDVykgA6HHQRiQ78KINM7wfIaW3jFmuBI9Qgqz73gb6cYSS
   OX2nZi/eQykSzrupmeqT5woVlKuJpel6jJL3mYWOkrUOPvX/A7efW49tq
   Nmkh4jbO75uumfuLoAY3i4uWuhYaBKBZC6ofj9hQEUDlyRDO5v5yxJguY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="312613458"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="312613458"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 08:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="734679181"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="734679181"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Feb 2023 08:06:49 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOL3w-0001Po-23;
        Sat, 04 Feb 2023 16:06:48 +0000
Date:   Sun, 5 Feb 2023 00:06:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x27: call to
 context_tracking_enabled_this_cpu() leaves .noinstr.text section
Message-ID: <202302050019.075FHixH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0136d86b78522bbd5755f8194c97a987f0586ba5
commit: 2bc3dec7055e34c2c2e497f109da6748544c0791 objtool: Don't print parentheses in function addresses
date:   10 months ago
config: x86_64-randconfig-a004-20221128 (https://download.01.org/0day-ci/archive/20230205/202302050019.075FHixH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2bc3dec7055e34c2c2e497f109da6748544c0791
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2bc3dec7055e34c2c2e497f109da6748544c0791
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   ld: warning: arch/x86/lib/retpoline.o: missing .note.GNU-stack section implies executable stack
   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>> vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x27: call to context_tracking_enabled_this_cpu() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x57: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section
   ld: warning: vmlinux.o: requires executable stack (because the .note.GNU-stack section is executable)
   ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   ld: warning: vmlinux.o: requires executable stack (because the .note.GNU-stack section is executable)
   ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
   ld: warning: vmlinux.o: requires executable stack (because the .note.GNU-stack section is executable)
   ld: warning: vmlinux has a LOAD segment with RWX permissions


objdump-func vmlinux.o vmx_vcpu_enter_exit:
0000 000000000000030d <vmx_vcpu_enter_exit>:
0000      30d:	55                   	push   %rbp
0001      30e:	48 89 f5             	mov    %rsi,%rbp
0004      311:	53                   	push   %rbx
0005      312:	48 89 fb             	mov    %rdi,%rbx
0008      315:	90                   	nop
0009      316:	e8 00 00 00 00       	call   31b <vmx_vcpu_enter_exit+0xe>	317: R_X86_64_PLT32	trace_hardirqs_on_prepare-0x4
000e      31b:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
0013      320:	e8 00 00 00 00       	call   325 <vmx_vcpu_enter_exit+0x18>	321: R_X86_64_PLT32	lockdep_hardirqs_on_prepare-0x4
0018      325:	90                   	nop
0019      326:	66 90                	xchg   %ax,%ax
001b      328:	eb 0a                	jmp    334 <vmx_vcpu_enter_exit+0x27>
001d      32a:	bf 02 00 00 00       	mov    $0x2,%edi
0022      32f:	e8 00 00 00 00       	call   334 <vmx_vcpu_enter_exit+0x27>	330: R_X86_64_PLT32	__context_tracking_enter-0x4
0027      334:	e8 00 00 00 00       	call   339 <vmx_vcpu_enter_exit+0x2c>	335: R_X86_64_PC32	.text+0x151972
002c      339:	84 c0                	test   %al,%al
002e      33b:	75 07                	jne    344 <vmx_vcpu_enter_exit+0x37>
0030      33d:	90                   	nop
0031      33e:	e8 00 00 00 00       	call   343 <vmx_vcpu_enter_exit+0x36>	33f: R_X86_64_PC32	.text+0x15ac9b
0036      343:	90                   	nop
0037      344:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
003c      349:	e8 00 00 00 00       	call   34e <vmx_vcpu_enter_exit+0x41>	34a: R_X86_64_PLT32	lockdep_hardirqs_on-0x4
0041      34e:	66 90                	xchg   %ax,%ax
0043      350:	66 90                	xchg   %ax,%ax
0045      352:	eb 11                	jmp    365 <vmx_vcpu_enter_exit+0x58>
0047      354:	48 89 df             	mov    %rbx,%rdi
004a      357:	e8 3b ff ff ff       	call   297 <vmx_l1d_flush>
004f      35c:	eb 07                	jmp    365 <vmx_vcpu_enter_exit+0x58>
0051      35e:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 365 <vmx_vcpu_enter_exit+0x58>	361: R_X86_64_PC32	.rodata+0x42c1c
0058      365:	48 8b 83 78 02 00 00 	mov    0x278(%rbx),%rax
005f      36c:	0f 20 d2             	mov    %cr2,%rdx
0062      36f:	48 39 d0             	cmp    %rdx,%rax
0065      372:	74 03                	je     377 <vmx_vcpu_enter_exit+0x6a>
0067      374:	0f 22 d0             	mov    %rax,%cr2
006a      377:	48 8b 85 60 23 00 00 	mov    0x2360(%rbp),%rax
0071      37e:	48 8d b3 d8 01 00 00 	lea    0x1d8(%rbx),%rsi
0078      385:	48 89 ef             	mov    %rbp,%rdi
007b      388:	0f b6 50 14          	movzbl 0x14(%rax),%edx
007f      38c:	e8 00 00 00 00       	call   391 <vmx_vcpu_enter_exit+0x84>	38d: R_X86_64_PLT32	__vmx_vcpu_run-0x4
0084      391:	88 85 d8 21 00 00    	mov    %al,0x21d8(%rbp)
008a      397:	0f 20 d0             	mov    %cr2,%rax
008d      39a:	48 89 83 78 02 00 00 	mov    %rax,0x278(%rbx)
0094      3a1:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
0099      3a6:	e8 00 00 00 00       	call   3ab <vmx_vcpu_enter_exit+0x9e>	3a7: R_X86_64_PLT32	lockdep_hardirqs_off-0x4
009e      3ab:	66 90                	xchg   %ax,%ax
00a0      3ad:	eb 0a                	jmp    3b9 <vmx_vcpu_enter_exit+0xac>
00a2      3af:	bf 02 00 00 00       	mov    $0x2,%edi
00a7      3b4:	e8 00 00 00 00       	call   3b9 <vmx_vcpu_enter_exit+0xac>	3b5: R_X86_64_PLT32	__context_tracking_exit-0x4
00ac      3b9:	90                   	nop
00ad      3ba:	e8 00 00 00 00       	call   3bf <vmx_vcpu_enter_exit+0xb2>	3bb: R_X86_64_PLT32	trace_hardirqs_off_finish-0x4
00b2      3bf:	90                   	nop
00b3      3c0:	5b                   	pop    %rbx
00b4      3c1:	5d                   	pop    %rbp
00b5      3c2:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
