Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E86FB2C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjEHO1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjEHO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:27:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C55DE6A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683556056; x=1715092056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zAxePDKqaNpuWdX25sfBjHJGbIQfdb2PKkYXaIoJR/w=;
  b=aBbJLt65ozqZ7xqUDeIaRYYskCgTfJCl8vgl7Yq1bNlW6mcvVJTsflAF
   4REKfM2Fd4xfMuOPIgU+TEcvgQCGcI0WtoRLPEB+nLkMBbFp5cmWZ/BpT
   r5U3IcVQtiWqnRkbVSNyQCl+tAdDactnHf1wxDqREAW38D+n1ACZbjWMW
   3xCLTMCjC0nrc5u1FKLwtRrCLTyPYuAMj7irg9gVeYO9sGP4WzctEQK5y
   ueAV3mIdbaan+uf0x5jbHAvGsxXnaoSECZu/0HLqev2sKqxsAOqx4dTsB
   grauTLE122zqqQjmNd4hecz4RanNSfuvpsaqahGZ4Jr1iiiWToBY1PU+l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="347124544"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="347124544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842713382"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="842713382"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 07:27:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw1pt-0001GP-2H;
        Mon, 08 May 2023 14:27:33 +0000
Date:   Mon, 8 May 2023 22:27:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xb0: relocation to
 !ENDBR: native_write_cr4+0x41
Message-ID: <202305082200.6kL7Uro9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac9a78681b921877518763ba0e89202254349d1b
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   3 months ago
config: x86_64-intel-next-customedconfig-dcg_x86_64_defconfig (https://download.01.org/0day-ci/archive/20230508/202305082200.6kL7Uro9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
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
| Link: https://lore.kernel.org/oe-kbuild-all/202305082200.6kL7Uro9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: kasan_report+0x12: call to stackleak_track_stack() with UACCESS enabled
>> vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0xb0: relocation to !ENDBR: native_write_cr4+0x41


objdump-func vmlinux.o lkdtm_UNSET_SMEP:
0000 00000000022ba1d0 <lkdtm_UNSET_SMEP>:
0000  22ba1d0:	f3 0f 1e fa          	endbr64
0004  22ba1d4:	e8 00 00 00 00       	call   22ba1d9 <lkdtm_UNSET_SMEP+0x9>	22ba1d5: R_X86_64_PLT32	__fentry__-0x4
0009  22ba1d9:	41 56                	push   %r14
000b  22ba1db:	41 55                	push   %r13
000d  22ba1dd:	41 54                	push   %r12
000f  22ba1df:	55                   	push   %rbp
0010  22ba1e0:	53                   	push   %rbx
0011  22ba1e1:	41 0f 20 e5          	mov    %cr4,%r13
0015  22ba1e5:	41 f7 c5 00 00 10 00 	test   $0x100000,%r13d
001c  22ba1ec:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba1ef: R_X86_64_32S	.rodata+0x4ba760
0023  22ba1f3:	0f 84 32 01 00 00    	je     22ba32b <lkdtm_UNSET_SMEP+0x15b>
0029  22ba1f9:	49 81 e5 ff ff ef ff 	and    $0xffffffffffefffff,%r13
0030  22ba200:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba203: R_X86_64_32S	.rodata+0x4ba7a0
0037  22ba207:	e8 00 00 00 00       	call   22ba20c <lkdtm_UNSET_SMEP+0x3c>	22ba208: R_X86_64_PLT32	_printk-0x4
003c  22ba20c:	4c 89 ef             	mov    %r13,%rdi
003f  22ba20f:	e8 00 00 00 00       	call   22ba214 <lkdtm_UNSET_SMEP+0x44>	22ba210: R_X86_64_PLT32	native_write_cr4-0x4
0044  22ba214:	0f 20 e0             	mov    %cr4,%rax
0047  22ba217:	49 39 c5             	cmp    %rax,%r13
004a  22ba21a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba21d: R_X86_64_32S	.rodata+0x4ba800
0051  22ba221:	0f 84 c9 01 00 00    	je     22ba3f0 <lkdtm_UNSET_SMEP+0x220>
0057  22ba227:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba22a: R_X86_64_32S	.rodata+0x4ba8a0
005e  22ba22e:	48 c7 c3 00 00 00 00 	mov    $0x0,%rbx	22ba231: R_X86_64_32S	native_write_cr4+0x1
0065  22ba235:	49 c7 c4 00 00 00 00 	mov    $0x0,%r12	22ba238: R_X86_64_32S	native_write_cr4+0x2
006c  22ba23c:	e8 00 00 00 00       	call   22ba241 <lkdtm_UNSET_SMEP+0x71>	22ba23d: R_X86_64_PLT32	_printk-0x4
0071  22ba241:	49 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r14
007b  22ba24b:	eb 40                	jmp    22ba28d <lkdtm_UNSET_SMEP+0xbd>
007d  22ba24d:	3c 48                	cmp    $0x48,%al
007f  22ba24f:	75 27                	jne    22ba278 <lkdtm_UNSET_SMEP+0xa8>
0081  22ba251:	48 89 d8             	mov    %rbx,%rax
0084  22ba254:	48 89 da             	mov    %rbx,%rdx
0087  22ba257:	48 c1 e8 03          	shr    $0x3,%rax
008b  22ba25b:	83 e2 07             	and    $0x7,%edx
008e  22ba25e:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
0093  22ba263:	38 d0                	cmp    %dl,%al
0095  22ba265:	7f 08                	jg     22ba26f <lkdtm_UNSET_SMEP+0x9f>
0097  22ba267:	84 c0                	test   %al,%al
0099  22ba269:	0f 85 d7 01 00 00    	jne    22ba446 <lkdtm_UNSET_SMEP+0x276>
009f  22ba26f:	80 3b 89             	cmpb   $0x89,(%rbx)
00a2  22ba272:	0f 84 c0 00 00 00    	je     22ba338 <lkdtm_UNSET_SMEP+0x168>
00a8  22ba278:	48 83 c3 01          	add    $0x1,%rbx
00ac  22ba27c:	49 83 c4 01          	add    $0x1,%r12
00b0  22ba280:	48 81 fb 00 00 00 00 	cmp    $0x0,%rbx	22ba283: R_X86_64_32S	native_write_cr4+0x41
00b7  22ba287:	0f 84 8b 01 00 00    	je     22ba418 <lkdtm_UNSET_SMEP+0x248>
00bd  22ba28d:	48 8d 6b ff          	lea    -0x1(%rbx),%rbp
00c1  22ba291:	48 89 e8             	mov    %rbp,%rax
00c4  22ba294:	48 89 ea             	mov    %rbp,%rdx
00c7  22ba297:	48 c1 e8 03          	shr    $0x3,%rax
00cb  22ba29b:	83 e2 07             	and    $0x7,%edx
00ce  22ba29e:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
00d3  22ba2a3:	38 d0                	cmp    %dl,%al
00d5  22ba2a5:	7f 08                	jg     22ba2af <lkdtm_UNSET_SMEP+0xdf>
00d7  22ba2a7:	84 c0                	test   %al,%al
00d9  22ba2a9:	0f 85 7d 01 00 00    	jne    22ba42c <lkdtm_UNSET_SMEP+0x25c>
00df  22ba2af:	0f b6 43 ff          	movzbl -0x1(%rbx),%eax
00e3  22ba2b3:	3c 0f                	cmp    $0xf,%al
00e5  22ba2b5:	75 96                	jne    22ba24d <lkdtm_UNSET_SMEP+0x7d>
00e7  22ba2b7:	48 89 d8             	mov    %rbx,%rax
00ea  22ba2ba:	48 89 da             	mov    %rbx,%rdx
00ed  22ba2bd:	48 c1 e8 03          	shr    $0x3,%rax
00f1  22ba2c1:	83 e2 07             	and    $0x7,%edx
00f4  22ba2c4:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
00f9  22ba2c9:	38 d0                	cmp    %dl,%al
00fb  22ba2cb:	7f 08                	jg     22ba2d5 <lkdtm_UNSET_SMEP+0x105>
00fd  22ba2cd:	84 c0                	test   %al,%al
00ff  22ba2cf:	0f 85 64 01 00 00    	jne    22ba439 <lkdtm_UNSET_SMEP+0x269>
0105  22ba2d5:	80 3b 22             	cmpb   $0x22,(%rbx)
0108  22ba2d8:	75 9e                	jne    22ba278 <lkdtm_UNSET_SMEP+0xa8>
010a  22ba2da:	4c 89 e0             	mov    %r12,%rax
010d  22ba2dd:	4c 89 e2             	mov    %r12,%rdx
0110  22ba2e0:	48 c1 e8 03          	shr    $0x3,%rax
0114  22ba2e4:	83 e2 07             	and    $0x7,%edx
0117  22ba2e7:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
011c  22ba2ec:	38 d0                	cmp    %dl,%al
011e  22ba2ee:	7f 08                	jg     22ba2f8 <lkdtm_UNSET_SMEP+0x128>
0120  22ba2f0:	84 c0                	test   %al,%al
0122  22ba2f2:	0f 85 68 01 00 00    	jne    22ba460 <lkdtm_UNSET_SMEP+0x290>
0128  22ba2f8:	80 7b 01 e7          	cmpb   $0xe7,0x1(%rbx)
012c  22ba2fc:	0f 85 76 ff ff ff    	jne    22ba278 <lkdtm_UNSET_SMEP+0xa8>
0132  22ba302:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba305: R_X86_64_32S	.rodata+0x4baa20
0139  22ba309:	e8 00 00 00 00       	call   22ba30e <lkdtm_UNSET_SMEP+0x13e>	22ba30a: R_X86_64_PLT32	_printk-0x4
013e  22ba30e:	4c 89 ef             	mov    %r13,%rdi
0141  22ba311:	e8 00 00 00 00       	call   22ba316 <lkdtm_UNSET_SMEP+0x146>	22ba312: R_X86_64_PLT32	__x86_indirect_thunk_rbp-0x4
0146  22ba316:	0f 20 e0             	mov    %cr4,%rax
0149  22ba319:	a9 00 00 10 00       	test   $0x100000,%eax
014e  22ba31e:	0f 84 c5 00 00 00    	je     22ba3e9 <lkdtm_UNSET_SMEP+0x219>
0154  22ba324:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba327: R_X86_64_32S	.rodata+0x4ba900
015b  22ba32b:	5b                   	pop    %rbx
015c  22ba32c:	5d                   	pop    %rbp
015d  22ba32d:	41 5c                	pop    %r12
015f  22ba32f:	41 5d                	pop    %r13
0161  22ba331:	41 5e                	pop    %r14
0163  22ba333:	e9 00 00 00 00       	jmp    22ba338 <lkdtm_UNSET_SMEP+0x168>	22ba334: R_X86_64_PLT32	_printk-0x4
0168  22ba338:	4c 89 e0             	mov    %r12,%rax
016b  22ba33b:	4c 89 e2             	mov    %r12,%rdx
016e  22ba33e:	48 c1 e8 03          	shr    $0x3,%rax
0172  22ba342:	83 e2 07             	and    $0x7,%edx
0175  22ba345:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
017a  22ba34a:	38 d0                	cmp    %dl,%al
017c  22ba34c:	7f 08                	jg     22ba356 <lkdtm_UNSET_SMEP+0x186>
017e  22ba34e:	84 c0                	test   %al,%al
0180  22ba350:	0f 85 fd 00 00 00    	jne    22ba453 <lkdtm_UNSET_SMEP+0x283>
0186  22ba356:	80 7b 01 f8          	cmpb   $0xf8,0x1(%rbx)
018a  22ba35a:	0f 85 18 ff ff ff    	jne    22ba278 <lkdtm_UNSET_SMEP+0xa8>
0190  22ba360:	48 8d 7b 02          	lea    0x2(%rbx),%rdi
0194  22ba364:	48 89 f8             	mov    %rdi,%rax
0197  22ba367:	48 89 fa             	mov    %rdi,%rdx
019a  22ba36a:	48 c1 e8 03          	shr    $0x3,%rax
019e  22ba36e:	83 e2 07             	and    $0x7,%edx
01a1  22ba371:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
01a6  22ba376:	38 d0                	cmp    %dl,%al
01a8  22ba378:	7f 08                	jg     22ba382 <lkdtm_UNSET_SMEP+0x1b2>
01aa  22ba37a:	84 c0                	test   %al,%al
01ac  22ba37c:	0f 85 ff 00 00 00    	jne    22ba481 <lkdtm_UNSET_SMEP+0x2b1>
01b2  22ba382:	80 7b 02 0f          	cmpb   $0xf,0x2(%rbx)
01b6  22ba386:	0f 85 ec fe ff ff    	jne    22ba278 <lkdtm_UNSET_SMEP+0xa8>
01bc  22ba38c:	48 8d 7b 03          	lea    0x3(%rbx),%rdi
01c0  22ba390:	48 89 f8             	mov    %rdi,%rax
01c3  22ba393:	48 89 fa             	mov    %rdi,%rdx
01c6  22ba396:	48 c1 e8 03          	shr    $0x3,%rax
01ca  22ba39a:	83 e2 07             	and    $0x7,%edx
01cd  22ba39d:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
01d2  22ba3a2:	38 d0                	cmp    %dl,%al
01d4  22ba3a4:	7f 08                	jg     22ba3ae <lkdtm_UNSET_SMEP+0x1de>
01d6  22ba3a6:	84 c0                	test   %al,%al
01d8  22ba3a8:	0f 85 c9 00 00 00    	jne    22ba477 <lkdtm_UNSET_SMEP+0x2a7>
01de  22ba3ae:	80 7b 03 22          	cmpb   $0x22,0x3(%rbx)
01e2  22ba3b2:	0f 85 c0 fe ff ff    	jne    22ba278 <lkdtm_UNSET_SMEP+0xa8>
01e8  22ba3b8:	48 8d 7b 04          	lea    0x4(%rbx),%rdi
01ec  22ba3bc:	48 89 f8             	mov    %rdi,%rax
01ef  22ba3bf:	48 89 fa             	mov    %rdi,%rdx
01f2  22ba3c2:	48 c1 e8 03          	shr    $0x3,%rax
01f6  22ba3c6:	83 e2 07             	and    $0x7,%edx
01f9  22ba3c9:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
01fe  22ba3ce:	38 d0                	cmp    %dl,%al
0200  22ba3d0:	7f 08                	jg     22ba3da <lkdtm_UNSET_SMEP+0x20a>
0202  22ba3d2:	84 c0                	test   %al,%al
0204  22ba3d4:	0f 85 93 00 00 00    	jne    22ba46d <lkdtm_UNSET_SMEP+0x29d>
020a  22ba3da:	80 7b 04 e0          	cmpb   $0xe0,0x4(%rbx)
020e  22ba3de:	0f 85 94 fe ff ff    	jne    22ba278 <lkdtm_UNSET_SMEP+0xa8>
0214  22ba3e4:	e9 19 ff ff ff       	jmp    22ba302 <lkdtm_UNSET_SMEP+0x132>
0219  22ba3e9:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba3ec: R_X86_64_32S	.rodata+0x4ba960
0220  22ba3f0:	e8 00 00 00 00       	call   22ba3f5 <lkdtm_UNSET_SMEP+0x225>	22ba3f1: R_X86_64_PLT32	_printk-0x4
0225  22ba3f5:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba3f8: R_X86_64_32S	.rodata+0x4ba860
022c  22ba3fc:	e8 00 00 00 00       	call   22ba401 <lkdtm_UNSET_SMEP+0x231>	22ba3fd: R_X86_64_PLT32	_printk-0x4
0231  22ba401:	4c 89 ef             	mov    %r13,%rdi
0234  22ba404:	5b                   	pop    %rbx
0235  22ba405:	5d                   	pop    %rbp
0236  22ba406:	48 81 cf 00 00 10 00 	or     $0x100000,%rdi
023d  22ba40d:	41 5c                	pop    %r12
023f  22ba40f:	41 5d                	pop    %r13
0241  22ba411:	41 5e                	pop    %r14
0243  22ba413:	e9 00 00 00 00       	jmp    22ba418 <lkdtm_UNSET_SMEP+0x248>	22ba414: R_X86_64_PLT32	native_write_cr4-0x4
0248  22ba418:	5b                   	pop    %rbx
0249  22ba419:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	22ba41c: R_X86_64_32S	.rodata+0x4ba9c0
0250  22ba420:	5d                   	pop    %rbp
0251  22ba421:	41 5c                	pop    %r12
0253  22ba423:	41 5d                	pop    %r13
0255  22ba425:	41 5e                	pop    %r14
0257  22ba427:	e9 00 00 00 00       	jmp    22ba42c <lkdtm_UNSET_SMEP+0x25c>	22ba428: R_X86_64_PLT32	_printk-0x4
025c  22ba42c:	48 89 ef             	mov    %rbp,%rdi
025f  22ba42f:	e8 00 00 00 00       	call   22ba434 <lkdtm_UNSET_SMEP+0x264>	22ba430: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0264  22ba434:	e9 76 fe ff ff       	jmp    22ba2af <lkdtm_UNSET_SMEP+0xdf>
0269  22ba439:	48 89 df             	mov    %rbx,%rdi
026c  22ba43c:	e8 00 00 00 00       	call   22ba441 <lkdtm_UNSET_SMEP+0x271>	22ba43d: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0271  22ba441:	e9 8f fe ff ff       	jmp    22ba2d5 <lkdtm_UNSET_SMEP+0x105>
0276  22ba446:	48 89 df             	mov    %rbx,%rdi
0279  22ba449:	e8 00 00 00 00       	call   22ba44e <lkdtm_UNSET_SMEP+0x27e>	22ba44a: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
027e  22ba44e:	e9 1c fe ff ff       	jmp    22ba26f <lkdtm_UNSET_SMEP+0x9f>
0283  22ba453:	4c 89 e7             	mov    %r12,%rdi
0286  22ba456:	e8 00 00 00 00       	call   22ba45b <lkdtm_UNSET_SMEP+0x28b>	22ba457: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
028b  22ba45b:	e9 f6 fe ff ff       	jmp    22ba356 <lkdtm_UNSET_SMEP+0x186>
0290  22ba460:	4c 89 e7             	mov    %r12,%rdi
0293  22ba463:	e8 00 00 00 00       	call   22ba468 <lkdtm_UNSET_SMEP+0x298>	22ba464: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0298  22ba468:	e9 8b fe ff ff       	jmp    22ba2f8 <lkdtm_UNSET_SMEP+0x128>
029d  22ba46d:	e8 00 00 00 00       	call   22ba472 <lkdtm_UNSET_SMEP+0x2a2>	22ba46e: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
02a2  22ba472:	e9 63 ff ff ff       	jmp    22ba3da <lkdtm_UNSET_SMEP+0x20a>
02a7  22ba477:	e8 00 00 00 00       	call   22ba47c <lkdtm_UNSET_SMEP+0x2ac>	22ba478: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
02ac  22ba47c:	e9 2d ff ff ff       	jmp    22ba3ae <lkdtm_UNSET_SMEP+0x1de>
02b1  22ba481:	e8 00 00 00 00       	call   22ba486 <lkdtm_UNSET_SMEP+0x2b6>	22ba482: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
02b6  22ba486:	e9 f7 fe ff ff       	jmp    22ba382 <lkdtm_UNSET_SMEP+0x1b2>
02bb  22ba48b:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
02c6  22ba496:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
02d1  22ba4a1:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
02dc  22ba4ac:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
02e7  22ba4b7:	66 0f 1f 84 00 00 00 00 00 	nopw   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
