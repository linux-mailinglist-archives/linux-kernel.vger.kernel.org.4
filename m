Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A646A3E54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjB0J3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjB0J3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:29:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF947ABE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677490177; x=1709026177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yJdwQJ4sWLH/6HVxooSeLnRUgM6Pbpk6vfThcui5G1g=;
  b=SGk589r/zXF+cgvVRkA2S0yetME/5laCgrecLLe1pxdHsnk6cow1b8lJ
   0Ewo5l3PfW5xSf5S9Wo3uGh4uNIcwIvsBUdiSScL4DS62ucnVkXH8uPmc
   xnzBs4fZMzrv8DDLbyz9ih72/rrb4S/nspL720YxmqJzSJ/JpztgmXZU/
   bQunr4V4P6GFW1vt8fZS3HqrS0KCCli82k2IspwNOggPemNUhBYfO+O+8
   hLe53QqhUgfb/vANfKZEDpQlVMBks59PL3FZbqK1zOM13yfvN0p9xzCIu
   MBRpBUmmOecP9G9pjAUUWyZw8bf+C8uDKvdljSP5vNdQpQKLgd+Z8kKvR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="332541922"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="332541922"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 01:29:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="675790147"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="675790147"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Feb 2023 01:29:35 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWZp8-0004Hf-27;
        Mon, 27 Feb 2023 09:29:34 +0000
Date:   Mon, 27 Feb 2023 17:28:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable
 instruction
Message-ID: <202302271743.78emit6I-lkp@intel.com>
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

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   5 weeks ago
config: x86_64-randconfig-r026-20230227 (https://download.01.org/0day-ci/archive/20230227/202302271743.78emit6I-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c27cd083cfb9d392f304657ed00fcde1136704e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c27cd083cfb9d392f304657ed00fcde1136704e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302271743.78emit6I-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable instruction


objdump-func vmlinux.o mptscsih_abort:
0000 0000000002fb7410 <mptscsih_abort>:
0000  2fb7410:	f3 0f 1e fa          	endbr64
0004  2fb7414:	55                   	push   %rbp
0005  2fb7415:	48 89 e5             	mov    %rsp,%rbp
0008  2fb7418:	41 57                	push   %r15
000a  2fb741a:	41 56                	push   %r14
000c  2fb741c:	41 55                	push   %r13
000e  2fb741e:	41 54                	push   %r12
0010  2fb7420:	49 89 fc             	mov    %rdi,%r12
0013  2fb7423:	53                   	push   %rbx
0014  2fb7424:	48 83 ec 40          	sub    $0x40,%rsp
0018  2fb7428:	e8 00 00 00 00       	call   2fb742d <mptscsih_abort+0x1d>	2fb7429: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
001d  2fb742d:	4c 89 e2             	mov    %r12,%rdx
0020  2fb7430:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
002a  2fb743a:	48 c1 ea 03          	shr    $0x3,%rdx
002e  2fb743e:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0032  2fb7442:	0f 85 fc 07 00 00    	jne    2fb7c44 <mptscsih_abort+0x834>
0038  2fb7448:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0042  2fb7452:	49 8b 1c 24          	mov    (%r12),%rbx
0046  2fb7456:	48 89 da             	mov    %rbx,%rdx
0049  2fb7459:	48 c1 ea 03          	shr    $0x3,%rdx
004d  2fb745d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0051  2fb7461:	0f 85 d0 07 00 00    	jne    2fb7c37 <mptscsih_abort+0x827>
0057  2fb7467:	48 8b 1b             	mov    (%rbx),%rbx
005a  2fb746a:	48 89 d8             	mov    %rbx,%rax
005d  2fb746d:	48 05 70 0c 00 00    	add    $0xc70,%rax
0063  2fb7473:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
0067  2fb7477:	0f 84 9a 06 00 00    	je     2fb7b17 <mptscsih_abort+0x707>
006d  2fb747d:	e8 00 00 00 00       	call   2fb7482 <mptscsih_abort+0x72>	2fb747e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0072  2fb7482:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
0076  2fb7486:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0080  2fb7490:	48 c1 ea 03          	shr    $0x3,%rdx
0084  2fb7494:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0088  2fb7498:	0f 85 da 07 00 00    	jne    2fb7c78 <mptscsih_abort+0x868>
008e  2fb749e:	48 8b 83 70 0c 00 00 	mov    0xc70(%rbx),%rax
0095  2fb74a5:	4c 89 e2             	mov    %r12,%rdx
0098  2fb74a8:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2fb74ab: R_X86_64_32S	.rodata+0x72a6e0
009f  2fb74af:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
00a3  2fb74b3:	48 83 c0 08          	add    $0x8,%rax
00a7  2fb74b7:	48 89 c6             	mov    %rax,%rsi
00aa  2fb74ba:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
00ae  2fb74be:	e8 00 00 00 00       	call   2fb74c3 <mptscsih_abort+0xb3>	2fb74bf: R_X86_64_PLT32	_printk-0x4
00b3  2fb74c3:	4c 89 e7             	mov    %r12,%rdi
00b6  2fb74c6:	e8 00 00 00 00       	call   2fb74cb <mptscsih_abort+0xbb>	2fb74c7: R_X86_64_PLT32	scsi_print_command-0x4
00bb  2fb74cb:	4c 89 e2             	mov    %r12,%rdx
00be  2fb74ce:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
00c8  2fb74d8:	48 c1 ea 03          	shr    $0x3,%rdx
00cc  2fb74dc:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
00d0  2fb74e0:	0f 85 78 07 00 00    	jne    2fb7c5e <mptscsih_abort+0x84e>
00d6  2fb74e6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
00e0  2fb74f0:	49 8b 1c 24          	mov    (%r12),%rbx
00e4  2fb74f4:	48 8d bb e0 00 00 00 	lea    0xe0(%rbx),%rdi
00eb  2fb74fb:	48 89 fa             	mov    %rdi,%rdx
00ee  2fb74fe:	48 c1 ea 03          	shr    $0x3,%rdx
00f2  2fb7502:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
00f6  2fb7506:	0f 85 7a 07 00 00    	jne    2fb7c86 <mptscsih_abort+0x876>
00fc  2fb750c:	4c 8b b3 e0 00 00 00 	mov    0xe0(%rbx),%r14
0103  2fb7513:	4d 85 f6             	test   %r14,%r14
0106  2fb7516:	0f 84 a7 05 00 00    	je     2fb7ac3 <mptscsih_abort+0x6b3>
010c  2fb751c:	e8 00 00 00 00       	call   2fb7521 <mptscsih_abort+0x111>	2fb751d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0111  2fb7521:	4c 89 f2             	mov    %r14,%rdx
0114  2fb7524:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
011e  2fb752e:	48 c1 ea 03          	shr    $0x3,%rdx
0122  2fb7532:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0126  2fb7536:	0f 85 2f 07 00 00    	jne    2fb7c6b <mptscsih_abort+0x85b>
012c  2fb753c:	49 8b 1e             	mov    (%r14),%rbx
012f  2fb753f:	48 85 db             	test   %rbx,%rbx
0132  2fb7542:	0f 84 7b 05 00 00    	je     2fb7ac3 <mptscsih_abort+0x6b3>
0138  2fb7548:	e8 00 00 00 00       	call   2fb754d <mptscsih_abort+0x13d>	2fb7549: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
013d  2fb754d:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
0141  2fb7551:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
014b  2fb755b:	48 89 fa             	mov    %rdi,%rdx
014e  2fb755e:	48 c1 ea 03          	shr    $0x3,%rdx
0152  2fb7562:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0156  2fb7566:	84 c0                	test   %al,%al
0158  2fb7568:	74 06                	je     2fb7570 <mptscsih_abort+0x160>
015a  2fb756a:	0f 8e 99 06 00 00    	jle    2fb7c09 <mptscsih_abort+0x7f9>
0160  2fb7570:	44 0f b6 6b 08       	movzbl 0x8(%rbx),%r13d
0165  2fb7575:	31 ff                	xor    %edi,%edi
0167  2fb7577:	41 83 e5 40          	and    $0x40,%r13d
016b  2fb757b:	44 89 ee             	mov    %r13d,%esi
016e  2fb757e:	e8 00 00 00 00       	call   2fb7583 <mptscsih_abort+0x173>	2fb757f: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp1-0x4
0173  2fb7583:	45 84 ed             	test   %r13b,%r13b
0176  2fb7586:	0f 85 bb 04 00 00    	jne    2fb7a47 <mptscsih_abort+0x637>
017c  2fb758c:	e8 00 00 00 00       	call   2fb7591 <mptscsih_abort+0x181>	2fb758d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0181  2fb7591:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
0185  2fb7595:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
018f  2fb759f:	48 89 fa             	mov    %rdi,%rdx
0192  2fb75a2:	48 c1 ea 03          	shr    $0x3,%rdx
0196  2fb75a6:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
019a  2fb75aa:	84 c0                	test   %al,%al
019c  2fb75ac:	74 06                	je     2fb75b4 <mptscsih_abort+0x1a4>
019e  2fb75ae:	0f 8e dc 06 00 00    	jle    2fb7c90 <mptscsih_abort+0x880>
01a4  2fb75b4:	0f b6 5b 10          	movzbl 0x10(%rbx),%ebx
01a8  2fb75b8:	31 ff                	xor    %edi,%edi
01aa  2fb75ba:	89 de                	mov    %ebx,%esi
01ac  2fb75bc:	e8 00 00 00 00       	call   2fb75c1 <mptscsih_abort+0x1b1>	2fb75bd: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp1-0x4
01b1  2fb75c1:	84 db                	test   %bl,%bl
01b3  2fb75c3:	0f 85 7e 04 00 00    	jne    2fb7a47 <mptscsih_abort+0x637>
01b9  2fb75c9:	e8 00 00 00 00       	call   2fb75ce <mptscsih_abort+0x1be>	2fb75ca: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01be  2fb75ce:	48 8b 5d d0          	mov    -0x30(%rbp),%rbx
01c2  2fb75d2:	48 8d 83 f0 12 00 00 	lea    0x12f0(%rbx),%rax
01c9  2fb75d9:	48 89 c7             	mov    %rax,%rdi
01cc  2fb75dc:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
01d0  2fb75e0:	e8 00 00 00 00       	call   2fb75e5 <mptscsih_abort+0x1d5>	2fb75e1: R_X86_64_PLT32	_raw_spin_lock_irqsave-0x4
01d5  2fb75e5:	48 8d b3 74 01 00 00 	lea    0x174(%rbx),%rsi
01dc  2fb75ec:	48 89 f2             	mov    %rsi,%rdx
01df  2fb75ef:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
01e3  2fb75f3:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
01ed  2fb75fd:	48 c1 ea 03          	shr    $0x3,%rdx
01f1  2fb7601:	48 89 75 a8          	mov    %rsi,-0x58(%rbp)
01f5  2fb7605:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
01f9  2fb7609:	48 89 f0             	mov    %rsi,%rax
01fc  2fb760c:	83 e0 07             	and    $0x7,%eax
01ff  2fb760f:	83 c0 03             	add    $0x3,%eax
0202  2fb7612:	38 d0                	cmp    %dl,%al
0204  2fb7614:	7c 08                	jl     2fb761e <mptscsih_abort+0x20e>
0206  2fb7616:	84 d2                	test   %dl,%dl
0208  2fb7618:	0f 85 f5 05 00 00    	jne    2fb7c13 <mptscsih_abort+0x803>
020e  2fb761e:	48 8b 5d d0          	mov    -0x30(%rbp),%rbx
0212  2fb7622:	31 ff                	xor    %edi,%edi
0214  2fb7624:	44 8b ab 74 01 00 00 	mov    0x174(%rbx),%r13d
021b  2fb762b:	44 89 ee             	mov    %r13d,%esi
021e  2fb762e:	e8 00 00 00 00       	call   2fb7633 <mptscsih_abort+0x223>	2fb762f: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0223  2fb7633:	45 85 ed             	test   %r13d,%r13d
0226  2fb7636:	0f 8e 5b 05 00 00    	jle    2fb7b97 <mptscsih_abort+0x787>
022c  2fb763c:	e8 00 00 00 00       	call   2fb7641 <mptscsih_abort+0x231>	2fb763d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0231  2fb7641:	48 8d 83 e8 12 00 00 	lea    0x12e8(%rbx),%rax
0238  2fb7648:	48 89 c2             	mov    %rax,%rdx
023b  2fb764b:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
023f  2fb764f:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0249  2fb7659:	48 c1 ea 03          	shr    $0x3,%rdx
024d  2fb765d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0251  2fb7661:	0f 85 3d 06 00 00    	jne    2fb7ca4 <mptscsih_abort+0x894>
0257  2fb7667:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
025b  2fb766b:	45 31 ff             	xor    %r15d,%r15d
025e  2fb766e:	48 8b 98 e8 12 00 00 	mov    0x12e8(%rax),%rbx
0265  2fb7675:	eb 21                	jmp    2fb7698 <mptscsih_abort+0x288>
0267  2fb7677:	e8 00 00 00 00       	call   2fb767c <mptscsih_abort+0x26c>	2fb7678: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
026c  2fb767c:	41 83 c7 01          	add    $0x1,%r15d
0270  2fb7680:	44 89 ee             	mov    %r13d,%esi
0273  2fb7683:	48 83 c3 08          	add    $0x8,%rbx
0277  2fb7687:	44 89 ff             	mov    %r15d,%edi
027a  2fb768a:	e8 00 00 00 00       	call   2fb768f <mptscsih_abort+0x27f>	2fb768b: R_X86_64_PLT32	__sanitizer_cov_trace_cmp4-0x4
027f  2fb768f:	45 39 ef             	cmp    %r13d,%r15d
0282  2fb7692:	0f 84 ff 04 00 00    	je     2fb7b97 <mptscsih_abort+0x787>
0288  2fb7698:	e8 00 00 00 00       	call   2fb769d <mptscsih_abort+0x28d>	2fb7699: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
028d  2fb769d:	48 89 d8             	mov    %rbx,%rax
0290  2fb76a0:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
029a  2fb76aa:	48 c1 e8 03          	shr    $0x3,%rax
029e  2fb76ae:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
02a2  2fb76b2:	0f 85 72 05 00 00    	jne    2fb7c2a <mptscsih_abort+0x81a>
02a8  2fb76b8:	4c 3b 23             	cmp    (%rbx),%r12
02ab  2fb76bb:	75 ba                	jne    2fb7677 <mptscsih_abort+0x267>
02ad  2fb76bd:	e8 00 00 00 00       	call   2fb76c2 <mptscsih_abort+0x2b2>	2fb76be: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02b2  2fb76c2:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
02b6  2fb76c6:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
02ba  2fb76ca:	e8 00 00 00 00       	call   2fb76cf <mptscsih_abort+0x2bf>	2fb76cb: R_X86_64_PLT32	_raw_spin_unlock_irqrestore-0x4
02bf  2fb76cf:	31 ff                	xor    %edi,%edi
02c1  2fb76d1:	44 89 fe             	mov    %r15d,%esi
02c4  2fb76d4:	e8 00 00 00 00       	call   2fb76d9 <mptscsih_abort+0x2c9>	2fb76d5: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
02c9  2fb76d9:	e8 00 00 00 00       	call   2fb76de <mptscsih_abort+0x2ce>	2fb76da: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02ce  2fb76de:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
02d2  2fb76e2:	48 8d b8 e0 12 00 00 	lea    0x12e0(%rax),%rdi
02d9  2fb76e9:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
02e3  2fb76f3:	48 89 fa             	mov    %rdi,%rdx
02e6  2fb76f6:	48 c1 ea 03          	shr    $0x3,%rdx
02ea  2fb76fa:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
02ee  2fb76fe:	0f 85 dd 05 00 00    	jne    2fb7ce1 <mptscsih_abort+0x8d1>
02f4  2fb7704:	4c 8b 6d d0          	mov    -0x30(%rbp),%r13
02f8  2fb7708:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
02ff  2fb770f:	49 8b 9d e0 12 00 00 	mov    0x12e0(%r13),%rbx
0306  2fb7716:	48 89 de             	mov    %rbx,%rsi
0309  2fb7719:	e8 00 00 00 00       	call   2fb771e <mptscsih_abort+0x30e>	2fb771a: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
030e  2fb771e:	48 83 fb ff          	cmp    $0xffffffffffffffff,%rbx
0312  2fb7722:	74 10                	je     2fb7734 <mptscsih_abort+0x324>
0314  2fb7724:	e8 00 00 00 00       	call   2fb7729 <mptscsih_abort+0x319>	2fb7725: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0319  2fb7729:	48 83 c3 01          	add    $0x1,%rbx
031d  2fb772d:	49 89 9d e0 12 00 00 	mov    %rbx,0x12e0(%r13)
0324  2fb7734:	e8 00 00 00 00       	call   2fb7739 <mptscsih_abort+0x329>	2fb7735: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0329  2fb7739:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	2fb773c: R_X86_64_32S	mpt_fwfault_debug
0330  2fb7740:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
033a  2fb774a:	48 89 c1             	mov    %rax,%rcx
033d  2fb774d:	83 e0 07             	and    $0x7,%eax
0340  2fb7750:	48 c1 e9 03          	shr    $0x3,%rcx
0344  2fb7754:	83 c0 03             	add    $0x3,%eax
0347  2fb7757:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
034b  2fb775b:	38 d0                	cmp    %dl,%al
034d  2fb775d:	7c 08                	jl     2fb7767 <mptscsih_abort+0x357>
034f  2fb775f:	84 d2                	test   %dl,%dl
0351  2fb7761:	0f 85 69 05 00 00    	jne    2fb7cd0 <mptscsih_abort+0x8c0>
0357  2fb7767:	8b 1d 00 00 00 00    	mov    0x0(%rip),%ebx        # 2fb776d <mptscsih_abort+0x35d>	2fb7769: R_X86_64_PC32	mpt_fwfault_debug-0x4
035d  2fb776d:	31 ff                	xor    %edi,%edi
035f  2fb776f:	89 de                	mov    %ebx,%esi
0361  2fb7771:	e8 00 00 00 00       	call   2fb7776 <mptscsih_abort+0x366>	2fb7772: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0366  2fb7776:	85 db                	test   %ebx,%ebx
0368  2fb7778:	0f 85 78 04 00 00    	jne    2fb7bf6 <mptscsih_abort+0x7e6>
036e  2fb777e:	e8 00 00 00 00       	call   2fb7783 <mptscsih_abort+0x373>	2fb777f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0373  2fb7783:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
0377  2fb7787:	48 8d b8 68 01 00 00 	lea    0x168(%rax),%rdi
037e  2fb778e:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0388  2fb7798:	48 89 fa             	mov    %rdi,%rdx
038b  2fb779b:	48 c1 ea 03          	shr    $0x3,%rdx
038f  2fb779f:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0393  2fb77a3:	0f 85 1d 05 00 00    	jne    2fb7cc6 <mptscsih_abort+0x8b6>
0399  2fb77a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
039d  2fb77ad:	48 8d b8 78 01 00 00 	lea    0x178(%rax),%rdi
03a4  2fb77b4:	48 8b 98 68 01 00 00 	mov    0x168(%rax),%rbx
03ab  2fb77bb:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
03b5  2fb77c5:	48 89 fa             	mov    %rdi,%rdx
03b8  2fb77c8:	48 c1 ea 03          	shr    $0x3,%rdx
03bc  2fb77cc:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
03c0  2fb77d0:	84 c0                	test   %al,%al
03c2  2fb77d2:	74 08                	je     2fb77dc <mptscsih_abort+0x3cc>
03c4  2fb77d4:	3c 03                	cmp    $0x3,%al
03c6  2fb77d6:	0f 8e e0 04 00 00    	jle    2fb7cbc <mptscsih_abort+0x8ac>
03cc  2fb77dc:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
03d0  2fb77e0:	8b 81 78 01 00 00    	mov    0x178(%rcx),%eax
03d6  2fb77e6:	41 0f af c7          	imul   %r15d,%eax
03da  2fb77ea:	48 98                	cltq
03dc  2fb77ec:	48 01 c3             	add    %rax,%rbx
03df  2fb77ef:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
03e9  2fb77f9:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
03ed  2fb77fd:	48 89 fa             	mov    %rdi,%rdx
03f0  2fb7800:	48 c1 ea 03          	shr    $0x3,%rdx
03f4  2fb7804:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
03f8  2fb7808:	84 c0                	test   %al,%al
03fa  2fb780a:	74 08                	je     2fb7814 <mptscsih_abort+0x404>
03fc  2fb780c:	3c 03                	cmp    $0x3,%al
03fe  2fb780e:	0f 8e 45 05 00 00    	jle    2fb7d59 <mptscsih_abort+0x949>
0404  2fb7814:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
0408  2fb7818:	8b 5b 08             	mov    0x8(%rbx),%ebx
040b  2fb781b:	48 8d b8 80 00 00 00 	lea    0x80(%rax),%rdi
0412  2fb7822:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
041c  2fb782c:	48 89 fa             	mov    %rdi,%rdx
041f  2fb782f:	48 c1 ea 03          	shr    $0x3,%rdx
0423  2fb7833:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0427  2fb7837:	84 c0                	test   %al,%al
0429  2fb7839:	74 06                	je     2fb7841 <mptscsih_abort+0x431>
042b  2fb783b:	0f 8e 0e 05 00 00    	jle    2fb7d4f <mptscsih_abort+0x93f>
0431  2fb7841:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
0435  2fb7845:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	2fb7848: R_X86_64_32S	.rodata+0x72abc0
043c  2fb784c:	41 bd 28 00 00 00    	mov    $0x28,%r13d
0442  2fb7852:	0f b6 b8 80 00 00 00 	movzbl 0x80(%rax),%edi
0449  2fb7859:	40 88 7d b0          	mov    %dil,-0x50(%rbp)
044d  2fb785d:	e8 00 00 00 00       	call   2fb7862 <mptscsih_abort+0x452>	2fb785e: R_X86_64_PLT32	__sanitizer_cov_trace_switch-0x4
0452  2fb7862:	0f b6 45 b0          	movzbl -0x50(%rbp),%eax
0456  2fb7866:	84 c0                	test   %al,%al
0458  2fb7868:	74 11                	je     2fb787b <mptscsih_abort+0x46b>
045a  2fb786a:	3c 02                	cmp    $0x2,%al
045c  2fb786c:	41 bd 0a 00 00 00    	mov    $0xa,%r13d
0462  2fb7872:	b8 1e 00 00 00       	mov    $0x1e,%eax
0467  2fb7877:	4c 0f 44 e8          	cmove  %rax,%r13
046b  2fb787b:	e8 00 00 00 00       	call   2fb7880 <mptscsih_abort+0x470>	2fb787c: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0470  2fb7880:	49 8d 7e 10          	lea    0x10(%r14),%rdi
0474  2fb7884:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
047e  2fb788e:	48 89 fa             	mov    %rdi,%rdx
0481  2fb7891:	48 c1 ea 03          	shr    $0x3,%rdx
0485  2fb7895:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0489  2fb7899:	0f 85 a6 04 00 00    	jne    2fb7d45 <mptscsih_abort+0x935>
048f  2fb789f:	4c 89 f2             	mov    %r14,%rdx
0492  2fb78a2:	4d 8b 46 10          	mov    0x10(%r14),%r8
0496  2fb78a6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
04a0  2fb78b0:	48 c1 ea 03          	shr    $0x3,%rdx
04a4  2fb78b4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
04a8  2fb78b8:	0f 85 72 04 00 00    	jne    2fb7d30 <mptscsih_abort+0x920>
04ae  2fb78be:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
04b8  2fb78c8:	4d 8b 36             	mov    (%r14),%r14
04bb  2fb78cb:	49 8d 7e 0a          	lea    0xa(%r14),%rdi
04bf  2fb78cf:	48 89 fa             	mov    %rdi,%rdx
04c2  2fb78d2:	48 c1 ea 03          	shr    $0x3,%rdx
04c6  2fb78d6:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
04ca  2fb78da:	48 89 fa             	mov    %rdi,%rdx
04cd  2fb78dd:	83 e2 07             	and    $0x7,%edx
04d0  2fb78e0:	38 d0                	cmp    %dl,%al
04d2  2fb78e2:	7f 08                	jg     2fb78ec <mptscsih_abort+0x4dc>
04d4  2fb78e4:	84 c0                	test   %al,%al
04d6  2fb78e6:	0f 85 32 04 00 00    	jne    2fb7d1e <mptscsih_abort+0x90e>
04dc  2fb78ec:	49 8d 7e 0b          	lea    0xb(%r14),%rdi
04e0  2fb78f0:	41 0f b6 4e 0a       	movzbl 0xa(%r14),%ecx
04e5  2fb78f5:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
04ef  2fb78ff:	48 89 fa             	mov    %rdi,%rdx
04f2  2fb7902:	48 c1 ea 03          	shr    $0x3,%rdx
04f6  2fb7906:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
04fa  2fb790a:	48 89 fa             	mov    %rdi,%rdx
04fd  2fb790d:	83 e2 07             	and    $0x7,%edx
0500  2fb7910:	38 d0                	cmp    %dl,%al
0502  2fb7912:	7f 08                	jg     2fb791c <mptscsih_abort+0x50c>
0504  2fb7914:	84 c0                	test   %al,%al
0506  2fb7916:	0f 85 ea 03 00 00    	jne    2fb7d06 <mptscsih_abort+0x8f6>
050c  2fb791c:	41 0f b6 56 0b       	movzbl 0xb(%r14),%edx
0511  2fb7921:	41 55                	push   %r13
0513  2fb7923:	be 01 00 00 00       	mov    $0x1,%esi
0518  2fb7928:	41 89 d9             	mov    %ebx,%r9d
051b  2fb792b:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
051f  2fb792f:	e8 00 00 00 00       	call   2fb7934 <mptscsih_abort+0x524>	2fb7930: R_X86_64_PLT32	mptscsih_IssueTaskMgmt-0x4
0524  2fb7934:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0528  2fb7938:	e8 00 00 00 00       	call   2fb793d <mptscsih_abort+0x52d>	2fb7939: R_X86_64_PLT32	_raw_spin_lock_irqsave-0x4
052d  2fb793d:	48 8b 4d a8          	mov    -0x58(%rbp),%rcx
0531  2fb7941:	5e                   	pop    %rsi
0532  2fb7942:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
0536  2fb7946:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0540  2fb7950:	48 89 ca             	mov    %rcx,%rdx
0543  2fb7953:	48 c1 ea 03          	shr    $0x3,%rdx
0547  2fb7957:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
054b  2fb795b:	48 89 c8             	mov    %rcx,%rax
054e  2fb795e:	83 e0 07             	and    $0x7,%eax
0551  2fb7961:	83 c0 03             	add    $0x3,%eax
0554  2fb7964:	38 d0                	cmp    %dl,%al
0556  2fb7966:	7c 08                	jl     2fb7970 <mptscsih_abort+0x560>
0558  2fb7968:	84 d2                	test   %dl,%dl
055a  2fb796a:	0f 85 89 03 00 00    	jne    2fb7cf9 <mptscsih_abort+0x8e9>
0560  2fb7970:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
0564  2fb7974:	31 ff                	xor    %edi,%edi
0566  2fb7976:	44 8b b0 74 01 00 00 	mov    0x174(%rax),%r14d
056d  2fb797d:	44 89 f6             	mov    %r14d,%esi
0570  2fb7980:	e8 00 00 00 00       	call   2fb7985 <mptscsih_abort+0x575>	2fb7981: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0575  2fb7985:	45 85 f6             	test   %r14d,%r14d
0578  2fb7988:	0f 8e e5 01 00 00    	jle    2fb7b73 <mptscsih_abort+0x763>
057e  2fb798e:	e8 00 00 00 00       	call   2fb7993 <mptscsih_abort+0x583>	2fb798f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0583  2fb7993:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
0587  2fb7997:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0591  2fb79a1:	48 c1 ea 03          	shr    $0x3,%rdx
0595  2fb79a5:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0599  2fb79a9:	0f 85 3c 03 00 00    	jne    2fb7ceb <mptscsih_abort+0x8db>
059f  2fb79af:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
05a3  2fb79b3:	31 db                	xor    %ebx,%ebx
05a5  2fb79b5:	4c 8b a8 e8 12 00 00 	mov    0x12e8(%rax),%r13
05ac  2fb79bc:	eb 1f                	jmp    2fb79dd <mptscsih_abort+0x5cd>
05ae  2fb79be:	e8 00 00 00 00       	call   2fb79c3 <mptscsih_abort+0x5b3>	2fb79bf: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
05b3  2fb79c3:	83 c3 01             	add    $0x1,%ebx
05b6  2fb79c6:	44 89 f6             	mov    %r14d,%esi
05b9  2fb79c9:	49 83 c5 08          	add    $0x8,%r13
05bd  2fb79cd:	89 df                	mov    %ebx,%edi
05bf  2fb79cf:	e8 00 00 00 00       	call   2fb79d4 <mptscsih_abort+0x5c4>	2fb79d0: R_X86_64_PLT32	__sanitizer_cov_trace_cmp4-0x4
05c4  2fb79d4:	44 39 f3             	cmp    %r14d,%ebx
05c7  2fb79d7:	0f 84 96 01 00 00    	je     2fb7b73 <mptscsih_abort+0x763>
05cd  2fb79dd:	e8 00 00 00 00       	call   2fb79e2 <mptscsih_abort+0x5d2>	2fb79de: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
05d2  2fb79e2:	4c 89 e8             	mov    %r13,%rax
05d5  2fb79e5:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
05df  2fb79ef:	48 c1 e8 03          	shr    $0x3,%rax
05e3  2fb79f3:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
05e7  2fb79f7:	0f 85 54 02 00 00    	jne    2fb7c51 <mptscsih_abort+0x841>
05ed  2fb79fd:	4d 3b 65 00          	cmp    0x0(%r13),%r12
05f1  2fb7a01:	75 bb                	jne    2fb79be <mptscsih_abort+0x5ae>
05f3  2fb7a03:	e8 00 00 00 00       	call   2fb7a08 <mptscsih_abort+0x5f8>	2fb7a04: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
05f8  2fb7a08:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
05fc  2fb7a0c:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0600  2fb7a10:	45 31 ed             	xor    %r13d,%r13d
0603  2fb7a13:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	2fb7a16: R_X86_64_32S	.rodata+0x72a120
060a  2fb7a1a:	e8 00 00 00 00       	call   2fb7a1f <mptscsih_abort+0x60f>	2fb7a1b: R_X86_64_PLT32	_raw_spin_unlock_irqrestore-0x4
060f  2fb7a1f:	44 89 fe             	mov    %r15d,%esi
0612  2fb7a22:	89 df                	mov    %ebx,%edi
0614  2fb7a24:	e8 00 00 00 00       	call   2fb7a29 <mptscsih_abort+0x619>	2fb7a25: R_X86_64_PLT32	__sanitizer_cov_trace_cmp4-0x4
0619  2fb7a29:	44 39 fb             	cmp    %r15d,%ebx
061c  2fb7a2c:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	2fb7a2f: R_X86_64_32S	.rodata+0x72a080
0623  2fb7a33:	41 0f 94 c5          	sete   %r13b
0627  2fb7a37:	41 81 c5 02 20 00 00 	add    $0x2002,%r13d
062e  2fb7a3e:	44 39 fb             	cmp    %r15d,%ebx
0631  2fb7a41:	4c 0f 45 f0          	cmovne %rax,%r14
0635  2fb7a45:	eb 47                	jmp    2fb7a8e <mptscsih_abort+0x67e>
0637  2fb7a47:	e8 00 00 00 00       	call   2fb7a4c <mptscsih_abort+0x63c>	2fb7a48: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
063c  2fb7a4c:	49 8d bc 24 70 01 00 00 	lea    0x170(%r12),%rdi
0644  2fb7a54:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
064e  2fb7a5e:	48 89 fa             	mov    %rdi,%rdx
0651  2fb7a61:	48 c1 ea 03          	shr    $0x3,%rdx
0655  2fb7a65:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0659  2fb7a69:	84 c0                	test   %al,%al
065b  2fb7a6b:	74 08                	je     2fb7a75 <mptscsih_abort+0x665>
065d  2fb7a6d:	3c 03                	cmp    $0x3,%al
065f  2fb7a6f:	0f 8e 25 02 00 00    	jle    2fb7c9a <mptscsih_abort+0x88a>
0665  2fb7a75:	41 bd 03 20 00 00    	mov    $0x2003,%r13d
066b  2fb7a7b:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	2fb7a7e: R_X86_64_32S	.rodata+0x72a120
0672  2fb7a82:	41 c7 84 24 70 01 00 00 00 00 08 00 	movl   $0x80000,0x170(%r12)
067e  2fb7a8e:	e8 00 00 00 00       	call   2fb7a93 <mptscsih_abort+0x683>	2fb7a8f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0683  2fb7a93:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
0687  2fb7a97:	4d 89 e0             	mov    %r12,%r8
068a  2fb7a9a:	44 89 e9             	mov    %r13d,%ecx
068d  2fb7a9d:	4c 89 f2             	mov    %r14,%rdx
0690  2fb7aa0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2fb7aa3: R_X86_64_32S	.rodata+0x72a740
0697  2fb7aa7:	e8 00 00 00 00       	call   2fb7aac <mptscsih_abort+0x69c>	2fb7aa8: R_X86_64_PLT32	_printk-0x4
069c  2fb7aac:	e8 00 00 00 00       	call   2fb7ab1 <mptscsih_abort+0x6a1>	2fb7aad: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
06a1  2fb7ab1:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
06a5  2fb7ab5:	44 89 e8             	mov    %r13d,%eax
06a8  2fb7ab8:	5b                   	pop    %rbx
06a9  2fb7ab9:	41 5c                	pop    %r12
06ab  2fb7abb:	41 5d                	pop    %r13
06ad  2fb7abd:	41 5e                	pop    %r14
06af  2fb7abf:	41 5f                	pop    %r15
06b1  2fb7ac1:	5d                   	pop    %rbp
06b2  2fb7ac2:	c3                   	ret
06b3  2fb7ac3:	e8 00 00 00 00       	call   2fb7ac8 <mptscsih_abort+0x6b8>	2fb7ac4: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
06b8  2fb7ac8:	49 8d bc 24 70 01 00 00 	lea    0x170(%r12),%rdi
06c0  2fb7ad0:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
06ca  2fb7ada:	48 89 fa             	mov    %rdi,%rdx
06cd  2fb7add:	48 c1 ea 03          	shr    $0x3,%rdx
06d1  2fb7ae1:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
06d5  2fb7ae5:	84 c0                	test   %al,%al
06d7  2fb7ae7:	74 08                	je     2fb7af1 <mptscsih_abort+0x6e1>
06d9  2fb7ae9:	3c 03                	cmp    $0x3,%al
06db  2fb7aeb:	0f 8e 2f 01 00 00    	jle    2fb7c20 <mptscsih_abort+0x810>
06e1  2fb7af1:	4c 89 e7             	mov    %r12,%rdi
06e4  2fb7af4:	41 bd 02 20 00 00    	mov    $0x2002,%r13d
06ea  2fb7afa:	41 c7 84 24 70 01 00 00 00 00 01 00 	movl   $0x10000,0x170(%r12)
06f6  2fb7b06:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	2fb7b09: R_X86_64_32S	.rodata+0x72a080
06fd  2fb7b0d:	e8 00 00 00 00       	call   2fb7b12 <mptscsih_abort+0x702>	2fb7b0e: R_X86_64_PLT32	scsi_done-0x4
0702  2fb7b12:	e9 77 ff ff ff       	jmp    2fb7a8e <mptscsih_abort+0x67e>
0707  2fb7b17:	e8 00 00 00 00       	call   2fb7b1c <mptscsih_abort+0x70c>	2fb7b18: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
070c  2fb7b1c:	49 8d bc 24 70 01 00 00 	lea    0x170(%r12),%rdi
0714  2fb7b24:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
071e  2fb7b2e:	48 89 fa             	mov    %rdi,%rdx
0721  2fb7b31:	48 c1 ea 03          	shr    $0x3,%rdx
0725  2fb7b35:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
0729  2fb7b39:	84 c0                	test   %al,%al
072b  2fb7b3b:	74 08                	je     2fb7b45 <mptscsih_abort+0x735>
072d  2fb7b3d:	3c 03                	cmp    $0x3,%al
072f  2fb7b3f:	0f 8e 6d 01 00 00    	jle    2fb7cb2 <mptscsih_abort+0x8a2>
0735  2fb7b45:	41 c7 84 24 70 01 00 00 00 00 08 00 	movl   $0x80000,0x170(%r12)
0741  2fb7b51:	4c 89 e7             	mov    %r12,%rdi
0744  2fb7b54:	41 bd 03 20 00 00    	mov    $0x2003,%r13d
074a  2fb7b5a:	e8 00 00 00 00       	call   2fb7b5f <mptscsih_abort+0x74f>	2fb7b5b: R_X86_64_PLT32	scsi_done-0x4
074f  2fb7b5f:	4c 89 e6             	mov    %r12,%rsi
0752  2fb7b62:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2fb7b65: R_X86_64_32S	.rodata+0x72a680
0759  2fb7b69:	e8 00 00 00 00       	call   2fb7b6e <mptscsih_abort+0x75e>	2fb7b6a: R_X86_64_PLT32	_printk-0x4
075e  2fb7b6e:	e9 39 ff ff ff       	jmp    2fb7aac <mptscsih_abort+0x69c>
0763  2fb7b73:	e8 00 00 00 00       	call   2fb7b78 <mptscsih_abort+0x768>	2fb7b74: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0768  2fb7b78:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
076c  2fb7b7c:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0770  2fb7b80:	41 bd 02 20 00 00    	mov    $0x2002,%r13d
0776  2fb7b86:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	2fb7b89: R_X86_64_32S	.rodata+0x72a080
077d  2fb7b8d:	e8 00 00 00 00       	call   2fb7b92 <mptscsih_abort+0x782>	2fb7b8e: R_X86_64_PLT32	_raw_spin_unlock_irqrestore-0x4
0782  2fb7b92:	e9 f7 fe ff ff       	jmp    2fb7a8e <mptscsih_abort+0x67e>
0787  2fb7b97:	e8 00 00 00 00       	call   2fb7b9c <mptscsih_abort+0x78c>	2fb7b98: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
078c  2fb7b9c:	48 8b 7d b8          	mov    -0x48(%rbp),%rdi
0790  2fb7ba0:	48 8b 75 b0          	mov    -0x50(%rbp),%rsi
0794  2fb7ba4:	e8 00 00 00 00       	call   2fb7ba9 <mptscsih_abort+0x799>	2fb7ba5: R_X86_64_PLT32	_raw_spin_unlock_irqrestore-0x4
0799  2fb7ba9:	e8 00 00 00 00       	call   2fb7bae <mptscsih_abort+0x79e>	2fb7baa: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
079e  2fb7bae:	49 8d bc 24 70 01 00 00 	lea    0x170(%r12),%rdi
07a6  2fb7bb6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
07b0  2fb7bc0:	48 89 fa             	mov    %rdi,%rdx
07b3  2fb7bc3:	48 c1 ea 03          	shr    $0x3,%rdx
07b7  2fb7bc7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
07bb  2fb7bcb:	84 c0                	test   %al,%al
07bd  2fb7bcd:	74 09                	je     2fb7bd8 <mptscsih_abort+0x7c8>
07bf  2fb7bcf:	3c 03                	cmp    $0x3,%al
07c1  2fb7bd1:	7f 05                	jg     2fb7bd8 <mptscsih_abort+0x7c8>
07c3  2fb7bd3:	e8 00 00 00 00       	call   2fb7bd8 <mptscsih_abort+0x7c8>	2fb7bd4: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
07c8  2fb7bd8:	41 bd 02 20 00 00    	mov    $0x2002,%r13d
07ce  2fb7bde:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	2fb7be1: R_X86_64_32S	.rodata+0x72a080
07d5  2fb7be5:	41 c7 84 24 70 01 00 00 00 00 08 00 	movl   $0x80000,0x170(%r12)
07e1  2fb7bf1:	e9 98 fe ff ff       	jmp    2fb7a8e <mptscsih_abort+0x67e>
07e6  2fb7bf6:	e8 00 00 00 00       	call   2fb7bfb <mptscsih_abort+0x7eb>	2fb7bf7: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
07eb  2fb7bfb:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
07ef  2fb7bff:	e8 00 00 00 00       	call   2fb7c04 <mptscsih_abort+0x7f4>	2fb7c00: R_X86_64_PLT32	mpt_halt_firmware-0x4
07f4  2fb7c04:	e9 75 fb ff ff       	jmp    2fb777e <mptscsih_abort+0x36e>
07f9  2fb7c09:	e8 00 00 00 00       	call   2fb7c0e <mptscsih_abort+0x7fe>	2fb7c0a: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
07fe  2fb7c0e:	e9 5d f9 ff ff       	jmp    2fb7570 <mptscsih_abort+0x160>
0803  2fb7c13:	48 89 f7             	mov    %rsi,%rdi
0806  2fb7c16:	e8 00 00 00 00       	call   2fb7c1b <mptscsih_abort+0x80b>	2fb7c17: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
080b  2fb7c1b:	e9 fe f9 ff ff       	jmp    2fb761e <mptscsih_abort+0x20e>
0810  2fb7c20:	e8 00 00 00 00       	call   2fb7c25 <mptscsih_abort+0x815>	2fb7c21: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
0815  2fb7c25:	e9 c7 fe ff ff       	jmp    2fb7af1 <mptscsih_abort+0x6e1>
081a  2fb7c2a:	48 89 df             	mov    %rbx,%rdi
081d  2fb7c2d:	e8 00 00 00 00       	call   2fb7c32 <mptscsih_abort+0x822>	2fb7c2e: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0822  2fb7c32:	e9 81 fa ff ff       	jmp    2fb76b8 <mptscsih_abort+0x2a8>
0827  2fb7c37:	48 89 df             	mov    %rbx,%rdi
082a  2fb7c3a:	e8 00 00 00 00       	call   2fb7c3f <mptscsih_abort+0x82f>	2fb7c3b: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
082f  2fb7c3f:	e9 23 f8 ff ff       	jmp    2fb7467 <mptscsih_abort+0x57>
0834  2fb7c44:	4c 89 e7             	mov    %r12,%rdi
0837  2fb7c47:	e8 00 00 00 00       	call   2fb7c4c <mptscsih_abort+0x83c>	2fb7c48: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
083c  2fb7c4c:	e9 f7 f7 ff ff       	jmp    2fb7448 <mptscsih_abort+0x38>
0841  2fb7c51:	4c 89 ef             	mov    %r13,%rdi
0844  2fb7c54:	e8 00 00 00 00       	call   2fb7c59 <mptscsih_abort+0x849>	2fb7c55: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0849  2fb7c59:	e9 9f fd ff ff       	jmp    2fb79fd <mptscsih_abort+0x5ed>
084e  2fb7c5e:	4c 89 e7             	mov    %r12,%rdi
0851  2fb7c61:	e8 00 00 00 00       	call   2fb7c66 <mptscsih_abort+0x856>	2fb7c62: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0856  2fb7c66:	e9 7b f8 ff ff       	jmp    2fb74e6 <mptscsih_abort+0xd6>
085b  2fb7c6b:	4c 89 f7             	mov    %r14,%rdi
085e  2fb7c6e:	e8 00 00 00 00       	call   2fb7c73 <mptscsih_abort+0x863>	2fb7c6f: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0863  2fb7c73:	e9 c4 f8 ff ff       	jmp    2fb753c <mptscsih_abort+0x12c>
0868  2fb7c78:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
086c  2fb7c7c:	e8 00 00 00 00       	call   2fb7c81 <mptscsih_abort+0x871>	2fb7c7d: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0871  2fb7c81:	e9 18 f8 ff ff       	jmp    2fb749e <mptscsih_abort+0x8e>
0876  2fb7c86:	e8 00 00 00 00       	call   2fb7c8b <mptscsih_abort+0x87b>	2fb7c87: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
087b  2fb7c8b:	e9 7c f8 ff ff       	jmp    2fb750c <mptscsih_abort+0xfc>
0880  2fb7c90:	e8 00 00 00 00       	call   2fb7c95 <mptscsih_abort+0x885>	2fb7c91: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0885  2fb7c95:	e9 1a f9 ff ff       	jmp    2fb75b4 <mptscsih_abort+0x1a4>
088a  2fb7c9a:	e8 00 00 00 00       	call   2fb7c9f <mptscsih_abort+0x88f>	2fb7c9b: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
088f  2fb7c9f:	e9 d1 fd ff ff       	jmp    2fb7a75 <mptscsih_abort+0x665>
0894  2fb7ca4:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
0898  2fb7ca8:	e8 00 00 00 00       	call   2fb7cad <mptscsih_abort+0x89d>	2fb7ca9: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
089d  2fb7cad:	e9 b5 f9 ff ff       	jmp    2fb7667 <mptscsih_abort+0x257>
08a2  2fb7cb2:	e8 00 00 00 00       	call   2fb7cb7 <mptscsih_abort+0x8a7>	2fb7cb3: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
08a7  2fb7cb7:	e9 89 fe ff ff       	jmp    2fb7b45 <mptscsih_abort+0x735>
08ac  2fb7cbc:	e8 00 00 00 00       	call   2fb7cc1 <mptscsih_abort+0x8b1>	2fb7cbd: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
08b1  2fb7cc1:	e9 16 fb ff ff       	jmp    2fb77dc <mptscsih_abort+0x3cc>
08b6  2fb7cc6:	e8 00 00 00 00       	call   2fb7ccb <mptscsih_abort+0x8bb>	2fb7cc7: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
08bb  2fb7ccb:	e9 d9 fa ff ff       	jmp    2fb77a9 <mptscsih_abort+0x399>
08c0  2fb7cd0:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	2fb7cd3: R_X86_64_32S	mpt_fwfault_debug
08c7  2fb7cd7:	e8 00 00 00 00       	call   2fb7cdc <mptscsih_abort+0x8cc>	2fb7cd8: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
08cc  2fb7cdc:	e9 86 fa ff ff       	jmp    2fb7767 <mptscsih_abort+0x357>
08d1  2fb7ce1:	e8 00 00 00 00       	call   2fb7ce6 <mptscsih_abort+0x8d6>	2fb7ce2: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
08d6  2fb7ce6:	e9 19 fa ff ff       	jmp    2fb7704 <mptscsih_abort+0x2f4>
08db  2fb7ceb:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
08df  2fb7cef:	e8 00 00 00 00       	call   2fb7cf4 <mptscsih_abort+0x8e4>	2fb7cf0: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
08e4  2fb7cf4:	e9 b6 fc ff ff       	jmp    2fb79af <mptscsih_abort+0x59f>
08e9  2fb7cf9:	48 89 cf             	mov    %rcx,%rdi
08ec  2fb7cfc:	e8 00 00 00 00       	call   2fb7d01 <mptscsih_abort+0x8f1>	2fb7cfd: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
08f1  2fb7d01:	e9 6a fc ff ff       	jmp    2fb7970 <mptscsih_abort+0x560>
08f6  2fb7d06:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
08f9  2fb7d09:	4c 89 45 b0          	mov    %r8,-0x50(%rbp)
08fd  2fb7d0d:	e8 00 00 00 00       	call   2fb7d12 <mptscsih_abort+0x902>	2fb7d0e: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0902  2fb7d12:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
0905  2fb7d15:	4c 8b 45 b0          	mov    -0x50(%rbp),%r8
0909  2fb7d19:	e9 fe fb ff ff       	jmp    2fb791c <mptscsih_abort+0x50c>
090e  2fb7d1e:	4c 89 45 b0          	mov    %r8,-0x50(%rbp)
0912  2fb7d22:	e8 00 00 00 00       	call   2fb7d27 <mptscsih_abort+0x917>	2fb7d23: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0917  2fb7d27:	4c 8b 45 b0          	mov    -0x50(%rbp),%r8
091b  2fb7d2b:	e9 bc fb ff ff       	jmp    2fb78ec <mptscsih_abort+0x4dc>
0920  2fb7d30:	4c 89 f7             	mov    %r14,%rdi
0923  2fb7d33:	4c 89 45 b0          	mov    %r8,-0x50(%rbp)
0927  2fb7d37:	e8 00 00 00 00       	call   2fb7d3c <mptscsih_abort+0x92c>	2fb7d38: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
092c  2fb7d3c:	4c 8b 45 b0          	mov    -0x50(%rbp),%r8
0930  2fb7d40:	e9 79 fb ff ff       	jmp    2fb78be <mptscsih_abort+0x4ae>
0935  2fb7d45:	e8 00 00 00 00       	call   2fb7d4a <mptscsih_abort+0x93a>	2fb7d46: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
093a  2fb7d4a:	e9 50 fb ff ff       	jmp    2fb789f <mptscsih_abort+0x48f>
093f  2fb7d4f:	e8 00 00 00 00       	call   2fb7d54 <mptscsih_abort+0x944>	2fb7d50: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0944  2fb7d54:	e9 e8 fa ff ff       	jmp    2fb7841 <mptscsih_abort+0x431>
0949  2fb7d59:	e8 00 00 00 00       	call   2fb7d5e <mptscsih_abort+0x94e>	2fb7d5a: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
094e  2fb7d5e:	e9 b1 fa ff ff       	jmp    2fb7814 <mptscsih_abort+0x404>
0953  2fb7d63:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
095e  2fb7d6e:	66 90                	xchg   %ax,%ax

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
