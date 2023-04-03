Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B26D3B7F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjDCB0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjDCB0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:26:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1C19AE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 18:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680485201; x=1712021201;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SgAcI1sf8JKgB2b0G8NlzwgV/P9plfMnucKItx60vtg=;
  b=nsOD9zXji0+pN3nExgkgEbz9meWswb4Qgol941V9C8IBLGjtJTuGbucl
   kqfynwFIPZo98PfsVgOVYQ3pt34RMEg9q1iiZCl/PY01msZuhM7aT0+ki
   1curyxxLJKs2ad+w1DZgqhVoq9t0i5iIda3HhM0jphkB7GfjKfMGwivWo
   A4vGhNKeDr7oA6jChy3HwgShG6DHF09wf7elJgVwX9s1lej0hW+bCS9zK
   C5kfJjASgeNelVMA4Okgdu7kyllqtxnY7D0gHyLPyFxQtFqwp13gy5R59
   cdf4Wy236ABe8BwFW+x53vMkoc1G7dHl7uX+Y+CDx94iRNGLsDkNEvnL/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="404540778"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="404540778"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 18:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="796836103"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="796836103"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2023 18:26:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pj8xy-000Nsj-22;
        Mon, 03 Apr 2023 01:26:38 +0000
Date:   Mon, 3 Apr 2023 09:25:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: vmlinux.o: warning: objtool: btrfs_calc_avail_data_space+0xb5:
 unreachable instruction
Message-ID: <202304030902.PAf6LZwi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e364e56293bb98cae1b55fd835f5991c4e96e7d
commit: 083bd7e54e8e2c1d169f21236873272cdf6f409a btrfs: move the printk and assert helpers to messages.c
date:   4 months ago
config: x86_64-randconfig-r011-20230403 (https://download.01.org/0day-ci/archive/20230403/202304030902.PAf6LZwi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=083bd7e54e8e2c1d169f21236873272cdf6f409a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 083bd7e54e8e2c1d169f21236873272cdf6f409a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304030902.PAf6LZwi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: btrfs_calc_avail_data_space+0xb5: unreachable instruction


objdump-func vmlinux.o btrfs_calc_avail_data_space:
0000 0000000000d2b515 <btrfs_calc_avail_data_space>:
0000   d2b515:	41 57                	push   %r15
0002   d2b517:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
0007   d2b51c:	41 56                	push   %r14
0009   d2b51e:	48 c1 e0 2a          	shl    $0x2a,%rax
000d   d2b522:	41 55                	push   %r13
000f   d2b524:	41 54                	push   %r12
0011   d2b526:	49 89 fc             	mov    %rdi,%r12
0014   d2b529:	48 81 c7 a8 0f 00 00 	add    $0xfa8,%rdi
001b   d2b530:	55                   	push   %rbp
001c   d2b531:	48 89 fa             	mov    %rdi,%rdx
001f   d2b534:	53                   	push   %rbx
0020   d2b535:	48 c1 ea 03          	shr    $0x3,%rdx
0024   d2b539:	48 83 ec 40          	sub    $0x40,%rsp
0028   d2b53d:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
002c   d2b541:	48 89 34 24          	mov    %rsi,(%rsp)
0030   d2b545:	74 05                	je     d2b54c <btrfs_calc_avail_data_space+0x37>
0032   d2b547:	e8 00 00 00 00       	call   d2b54c <btrfs_calc_avail_data_space+0x37>	d2b548: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0037   d2b54c:	49 8b ac 24 a8 0f 00 00 	mov    0xfa8(%r12),%rbp
003f   d2b554:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
0044   d2b559:	48 c1 e0 2a          	shl    $0x2a,%rax
0048   d2b55d:	48 8d 7d 40          	lea    0x40(%rbp),%rdi
004c   d2b561:	48 89 fa             	mov    %rdi,%rdx
004f   d2b564:	48 c1 ea 03          	shr    $0x3,%rdx
0053   d2b568:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0057   d2b56c:	74 05                	je     d2b573 <btrfs_calc_avail_data_space+0x5e>
0059   d2b56e:	e8 00 00 00 00       	call   d2b573 <btrfs_calc_avail_data_space+0x5e>	d2b56f: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
005e   d2b573:	48 8b 45 40          	mov    0x40(%rbp),%rax
0062   d2b577:	89 44 24 10          	mov    %eax,0x10(%rsp)
0066   d2b57b:	85 c0                	test   %eax,%eax
0068   d2b57d:	75 7b                	jne    d2b5fa <btrfs_calc_avail_data_space+0xe5>
006a   d2b57f:	49 8b 9c 24 a8 0f 00 00 	mov    0xfa8(%r12),%rbx
0072   d2b587:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
0077   d2b58c:	48 c1 e0 2a          	shl    $0x2a,%rax
007b   d2b590:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
007f   d2b594:	48 89 fa             	mov    %rdi,%rdx
0082   d2b597:	48 c1 ea 03          	shr    $0x3,%rdx
0086   d2b59b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
008a   d2b59f:	74 05                	je     d2b5a6 <btrfs_calc_avail_data_space+0x91>
008c   d2b5a1:	e8 00 00 00 00       	call   d2b5a6 <btrfs_calc_avail_data_space+0x91>	d2b5a2: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0091   d2b5a6:	48 8b 43 40          	mov    0x40(%rbx),%rax
0095   d2b5aa:	89 44 24 10          	mov    %eax,0x10(%rsp)
0099   d2b5ae:	85 c0                	test   %eax,%eax
009b   d2b5b0:	75 48                	jne    d2b5fa <btrfs_calc_avail_data_space+0xe5>
009d   d2b5b2:	ba 7c 07 00 00       	mov    $0x77c,%edx
00a2   d2b5b7:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	d2b5ba: R_X86_64_32S	.rodata+0x6c0700
00a9   d2b5be:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	d2b5c1: R_X86_64_32S	.rodata+0x6c0be0
00b0   d2b5c5:	e8 00 00 00 00       	call   d2b5ca <btrfs_calc_avail_data_space+0xb5>	d2b5c6: R_X86_64_PLT32	btrfs_assertfail-0x4
00b5   d2b5ca:	48 8b 14 24          	mov    (%rsp),%rdx
00b9   d2b5ce:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
00be   d2b5d3:	48 c1 e0 2a          	shl    $0x2a,%rax
00c2   d2b5d7:	48 c1 ea 03          	shr    $0x3,%rdx
00c6   d2b5db:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
00ca   d2b5df:	74 09                	je     d2b5ea <btrfs_calc_avail_data_space+0xd5>
00cc   d2b5e1:	48 8b 3c 24          	mov    (%rsp),%rdi
00d0   d2b5e5:	e8 00 00 00 00       	call   d2b5ea <btrfs_calc_avail_data_space+0xd5>	d2b5e6: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
00d5   d2b5ea:	48 8b 04 24          	mov    (%rsp),%rax
00d9   d2b5ee:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
00e0   d2b5f5:	e9 2a 04 00 00       	jmp    d2ba24 <btrfs_calc_avail_data_space+0x50f>
00e5   d2b5fa:	48 63 7c 24 10       	movslq 0x10(%rsp),%rdi
00ea   d2b5ff:	ba 20 00 00 00       	mov    $0x20,%edx
00ef   d2b604:	48 89 f8             	mov    %rdi,%rax
00f2   d2b607:	48 f7 e2             	mul    %rdx
00f5   d2b60a:	48 89 c7             	mov    %rax,%rdi
00f8   d2b60d:	0f 90 c0             	seto   %al
00fb   d2b610:	0f b6 c0             	movzbl %al,%eax
00fe   d2b613:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
0103   d2b618:	71 0d                	jno    d2b627 <btrfs_calc_avail_data_space+0x112>
0105   d2b61a:	c7 44 24 10 f4 ff ff ff 	movl   $0xfffffff4,0x10(%rsp)
010d   d2b622:	e9 fd 03 00 00       	jmp    d2ba24 <btrfs_calc_avail_data_space+0x50f>
0112   d2b627:	be c0 0c 00 00       	mov    $0xcc0,%esi
0117   d2b62c:	e8 00 00 00 00       	call   d2b631 <btrfs_calc_avail_data_space+0x11c>	d2b62d: R_X86_64_PLT32	__kmalloc-0x4
011c   d2b631:	49 89 c5             	mov    %rax,%r13
011f   d2b634:	48 85 c0             	test   %rax,%rax
0122   d2b637:	74 e1                	je     d2b61a <btrfs_calc_avail_data_space+0x105>
0124   d2b639:	be 01 00 00 00       	mov    $0x1,%esi
0129   d2b63e:	4c 89 e7             	mov    %r12,%rdi
012c   d2b641:	e8 00 00 00 00       	call   d2b646 <btrfs_calc_avail_data_space+0x131>	d2b642: R_X86_64_PLT32	btrfs_get_alloc_profile-0x4
0131   d2b646:	48 89 c7             	mov    %rax,%rdi
0134   d2b649:	48 89 c3             	mov    %rax,%rbx
0137   d2b64c:	e8 00 00 00 00       	call   d2b651 <btrfs_calc_avail_data_space+0x13c>	d2b64d: R_X86_64_PLT32	btrfs_bg_flags_to_raid_index-0x4
013c   d2b651:	89 44 24 14          	mov    %eax,0x14(%rsp)
0140   d2b655:	89 c0                	mov    %eax,%eax
0142   d2b657:	83 7c 24 14 09       	cmpl   $0x9,0x14(%rsp)
0147   d2b65c:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
014c   d2b661:	76 0f                	jbe    d2b672 <btrfs_calc_avail_data_space+0x15d>
014e   d2b663:	48 89 c6             	mov    %rax,%rsi
0151   d2b666:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	d2b669: R_X86_64_32S	.data+0x875fc0
0158   d2b66d:	e8 00 00 00 00       	call   d2b672 <btrfs_calc_avail_data_space+0x15d>	d2b66e: R_X86_64_PLT32	__ubsan_handle_out_of_bounds-0x4
015d   d2b672:	44 8b 64 24 10       	mov    0x10(%rsp),%r12d
0162   d2b677:	f6 c3 08             	test   $0x8,%bl
0165   d2b67a:	75 63                	jne    d2b6df <btrfs_calc_avail_data_space+0x1ca>
0167   d2b67c:	f7 c3 10 06 00 00    	test   $0x610,%ebx
016d   d2b682:	74 49                	je     d2b6cd <btrfs_calc_avail_data_space+0x1b8>
016f   d2b684:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
0174   d2b689:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
0179   d2b68e:	48 c1 e0 2a          	shl    $0x2a,%rax
017d   d2b692:	48 c1 e7 05          	shl    $0x5,%rdi
0181   d2b696:	48 81 c7 00 00 00 00 	add    $0x0,%rdi	d2b699: R_X86_64_32S	btrfs_raid_array+0x6
0188   d2b69d:	48 89 fa             	mov    %rdi,%rdx
018b   d2b6a0:	48 c1 ea 03          	shr    $0x3,%rdx
018f   d2b6a4:	8a 04 02             	mov    (%rdx,%rax,1),%al
0192   d2b6a7:	48 89 fa             	mov    %rdi,%rdx
0195   d2b6aa:	83 e2 07             	and    $0x7,%edx
0198   d2b6ad:	38 d0                	cmp    %dl,%al
019a   d2b6af:	7f 09                	jg     d2b6ba <btrfs_calc_avail_data_space+0x1a5>
019c   d2b6b1:	84 c0                	test   %al,%al
019e   d2b6b3:	74 05                	je     d2b6ba <btrfs_calc_avail_data_space+0x1a5>
01a0   d2b6b5:	e8 00 00 00 00       	call   d2b6ba <btrfs_calc_avail_data_space+0x1a5>	d2b6b6: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
01a5   d2b6ba:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
01aa   d2b6bf:	48 c1 e0 05          	shl    $0x5,%rax
01ae   d2b6c3:	44 0f b6 a0 00 00 00 00 	movzbl 0x0(%rax),%r12d	d2b6c7: R_X86_64_32S	btrfs_raid_array+0x6
01b6   d2b6cb:	eb 12                	jmp    d2b6df <btrfs_calc_avail_data_space+0x1ca>
01b8   d2b6cd:	83 e3 40             	and    $0x40,%ebx
01bb   d2b6d0:	48 83 fb 01          	cmp    $0x1,%rbx
01bf   d2b6d4:	45 19 e4             	sbb    %r12d,%r12d
01c2   d2b6d7:	41 83 e4 fd          	and    $0xfffffffd,%r12d
01c6   d2b6db:	41 83 c4 04          	add    $0x4,%r12d
01ca   d2b6df:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
01cf   d2b6e4:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
01d4   d2b6e9:	48 c1 e0 2a          	shl    $0x2a,%rax
01d8   d2b6ed:	48 c1 e7 05          	shl    $0x5,%rdi
01dc   d2b6f1:	48 81 c7 00 00 00 00 	add    $0x0,%rdi	d2b6f4: R_X86_64_32S	btrfs_raid_array+0x1
01e3   d2b6f8:	48 89 fa             	mov    %rdi,%rdx
01e6   d2b6fb:	48 c1 ea 03          	shr    $0x3,%rdx
01ea   d2b6ff:	8a 04 02             	mov    (%rdx,%rax,1),%al
01ed   d2b702:	48 89 fa             	mov    %rdi,%rdx
01f0   d2b705:	83 e2 07             	and    $0x7,%edx
01f3   d2b708:	38 d0                	cmp    %dl,%al
01f5   d2b70a:	7f 09                	jg     d2b715 <btrfs_calc_avail_data_space+0x200>
01f7   d2b70c:	84 c0                	test   %al,%al
01f9   d2b70e:	74 05                	je     d2b715 <btrfs_calc_avail_data_space+0x200>
01fb   d2b710:	e8 00 00 00 00       	call   d2b715 <btrfs_calc_avail_data_space+0x200>	d2b711: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0200   d2b715:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
0205   d2b71a:	ff 05 00 00 00 00    	incl   0x0(%rip)        # d2b720 <btrfs_calc_avail_data_space+0x20b>	d2b71c: R_X86_64_PC32	__preempt_count-0x4
020b   d2b720:	48 c1 e0 05          	shl    $0x5,%rax
020f   d2b724:	0f b6 80 00 00 00 00 	movzbl 0x0(%rax),%eax	d2b727: R_X86_64_32S	btrfs_raid_array+0x1
0216   d2b72b:	c1 e0 10             	shl    $0x10,%eax
0219   d2b72e:	48 98                	cltq
021b   d2b730:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
0220   d2b735:	e8 60 f4 ff ff       	call   d2ab9a <rcu_lock_acquire.constprop.0>
0225   d2b73a:	48 8d 85 00 01 00 00 	lea    0x100(%rbp),%rax
022c   d2b741:	48 89 c2             	mov    %rax,%rdx
022f   d2b744:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
0234   d2b749:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
0239   d2b74e:	48 c1 ea 03          	shr    $0x3,%rdx
023d   d2b752:	48 c1 e0 2a          	shl    $0x2a,%rax
0241   d2b756:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0245   d2b75a:	74 0a                	je     d2b766 <btrfs_calc_avail_data_space+0x251>
0247   d2b75c:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
024c   d2b761:	e8 00 00 00 00       	call   d2b766 <btrfs_calc_avail_data_space+0x251>	d2b762: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0251   d2b766:	48 8b ad 00 01 00 00 	mov    0x100(%rbp),%rbp
0258   d2b76d:	31 db                	xor    %ebx,%ebx
025a   d2b76f:	49 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r14
0264   d2b779:	48 63 c3             	movslq %ebx,%rax
0267   d2b77c:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
026c   d2b781:	48 3b 6c 24 28       	cmp    0x28(%rsp),%rbp
0271   d2b786:	0f 84 8a 00 00 00    	je     d2b816 <btrfs_calc_avail_data_space+0x301>
0277   d2b78c:	4c 8d 7d 68          	lea    0x68(%rbp),%r15
027b   d2b790:	be 08 00 00 00       	mov    $0x8,%esi
0280   d2b795:	4c 89 ff             	mov    %r15,%rdi
0283   d2b798:	e8 00 00 00 00       	call   d2b79d <btrfs_calc_avail_data_space+0x288>	d2b799: R_X86_64_PLT32	__kasan_check_read-0x4
0288   d2b79d:	4c 89 f8             	mov    %r15,%rax
028b   d2b7a0:	48 c1 e8 03          	shr    $0x3,%rax
028f   d2b7a4:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
0294   d2b7a9:	74 08                	je     d2b7b3 <btrfs_calc_avail_data_space+0x29e>
0296   d2b7ab:	4c 89 ff             	mov    %r15,%rdi
0299   d2b7ae:	e8 00 00 00 00       	call   d2b7b3 <btrfs_calc_avail_data_space+0x29e>	d2b7af: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
029e   d2b7b3:	48 8b 45 68          	mov    0x68(%rbp),%rax
02a2   d2b7b7:	a8 02                	test   $0x2,%al
02a4   d2b7b9:	0f 84 7b 01 00 00    	je     d2b93a <btrfs_calc_avail_data_space+0x425>
02aa   d2b7bf:	48 8d 7d 50          	lea    0x50(%rbp),%rdi
02ae   d2b7c3:	48 89 f8             	mov    %rdi,%rax
02b1   d2b7c6:	48 c1 e8 03          	shr    $0x3,%rax
02b5   d2b7ca:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
02ba   d2b7cf:	74 05                	je     d2b7d6 <btrfs_calc_avail_data_space+0x2c1>
02bc   d2b7d1:	e8 00 00 00 00       	call   d2b7d6 <btrfs_calc_avail_data_space+0x2c1>	d2b7d2: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
02c1   d2b7d6:	48 83 7d 50 00       	cmpq   $0x0,0x50(%rbp)
02c6   d2b7db:	0f 84 59 01 00 00    	je     d2b93a <btrfs_calc_avail_data_space+0x425>
02cc   d2b7e1:	be 08 00 00 00       	mov    $0x8,%esi
02d1   d2b7e6:	4c 89 ff             	mov    %r15,%rdi
02d4   d2b7e9:	e8 00 00 00 00       	call   d2b7ee <btrfs_calc_avail_data_space+0x2d9>	d2b7ea: R_X86_64_PLT32	__kasan_check_read-0x4
02d9   d2b7ee:	4c 89 f8             	mov    %r15,%rax
02dc   d2b7f1:	48 c1 e8 03          	shr    $0x3,%rax
02e0   d2b7f5:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
02e5   d2b7fa:	74 08                	je     d2b804 <btrfs_calc_avail_data_space+0x2ef>
02e7   d2b7fc:	4c 89 ff             	mov    %r15,%rdi
02ea   d2b7ff:	e8 00 00 00 00       	call   d2b804 <btrfs_calc_avail_data_space+0x2ef>	d2b800: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
02ef   d2b804:	48 8b 45 68          	mov    0x68(%rbp),%rax
02f3   d2b808:	a8 08                	test   $0x8,%al
02f5   d2b80a:	0f 85 2a 01 00 00    	jne    d2b93a <btrfs_calc_avail_data_space+0x425>
02fb   d2b810:	3b 5c 24 10          	cmp    0x10(%rsp),%ebx
02ff   d2b814:	7c 77                	jl     d2b88d <btrfs_calc_avail_data_space+0x378>
0301   d2b816:	e8 e1 fc ff ff       	call   d2b4fc <rcu_read_unlock>
0306   d2b81b:	ba 20 00 00 00       	mov    $0x20,%edx
030b   d2b820:	4c 89 ef             	mov    %r13,%rdi
030e   d2b823:	45 31 c0             	xor    %r8d,%r8d
0311   d2b826:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx	d2b829: R_X86_64_32S	.text+0xd0953c
0318   d2b82d:	48 63 f3             	movslq %ebx,%rsi
031b   d2b830:	e8 00 00 00 00       	call   d2b835 <btrfs_calc_avail_data_space+0x320>	d2b831: R_X86_64_PLT32	sort-0x4
0320   d2b835:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
0325   d2b83a:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
032a   d2b83f:	48 c1 e0 2a          	shl    $0x2a,%rax
032e   d2b843:	48 c1 e7 05          	shl    $0x5,%rdi
0332   d2b847:	48 81 c7 00 00 00 00 	add    $0x0,%rdi	d2b84a: R_X86_64_32S	btrfs_raid_array+0x3
0339   d2b84e:	48 89 fa             	mov    %rdi,%rdx
033c   d2b851:	48 c1 ea 03          	shr    $0x3,%rdx
0340   d2b855:	8a 04 02             	mov    (%rdx,%rax,1),%al
0343   d2b858:	48 89 fa             	mov    %rdi,%rdx
0346   d2b85b:	83 e2 07             	and    $0x7,%edx
0349   d2b85e:	38 d0                	cmp    %dl,%al
034b   d2b860:	7f 09                	jg     d2b86b <btrfs_calc_avail_data_space+0x356>
034d   d2b862:	84 c0                	test   %al,%al
034f   d2b864:	74 05                	je     d2b86b <btrfs_calc_avail_data_space+0x356>
0351   d2b866:	e8 00 00 00 00       	call   d2b86b <btrfs_calc_avail_data_space+0x356>	d2b867: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0356   d2b86b:	49 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r14
0360   d2b875:	8b 44 24 14          	mov    0x14(%rsp),%eax
0364   d2b879:	48 c1 e0 05          	shl    $0x5,%rax
0368   d2b87d:	0f b6 80 00 00 00 00 	movzbl 0x0(%rax),%eax	d2b880: R_X86_64_32S	btrfs_raid_array+0x3
036f   d2b884:	89 44 24 10          	mov    %eax,0x10(%rsp)
0373   d2b888:	e9 1a 01 00 00       	jmp    d2b9a7 <btrfs_calc_avail_data_space+0x492>
0378   d2b88d:	48 8d bd 80 00 00 00 	lea    0x80(%rbp),%rdi
037f   d2b894:	48 89 f8             	mov    %rdi,%rax
0382   d2b897:	48 c1 e8 03          	shr    $0x3,%rax
0386   d2b89b:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
038b   d2b8a0:	74 05                	je     d2b8a7 <btrfs_calc_avail_data_space+0x392>
038d   d2b8a2:	e8 00 00 00 00       	call   d2b8a7 <btrfs_calc_avail_data_space+0x392>	d2b8a3: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0392   d2b8a7:	48 8d bd 90 00 00 00 	lea    0x90(%rbp),%rdi
0399   d2b8ae:	4c 8b bd 80 00 00 00 	mov    0x80(%rbp),%r15
03a0   d2b8b5:	48 89 f8             	mov    %rdi,%rax
03a3   d2b8b8:	48 c1 e8 03          	shr    $0x3,%rax
03a7   d2b8bc:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
03ac   d2b8c1:	74 05                	je     d2b8c8 <btrfs_calc_avail_data_space+0x3b3>
03ae   d2b8c3:	e8 00 00 00 00       	call   d2b8c8 <btrfs_calc_avail_data_space+0x3b3>	d2b8c4: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
03b3   d2b8c8:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
03b8   d2b8cd:	4c 89 f8             	mov    %r15,%rax
03bb   d2b8d0:	48 2b 85 90 00 00 00 	sub    0x90(%rbp),%rax
03c2   d2b8d7:	66 31 c0             	xor    %ax,%ax
03c5   d2b8da:	48 8d 91 00 00 10 00 	lea    0x100000(%rcx),%rdx
03cc   d2b8e1:	48 39 c2             	cmp    %rax,%rdx
03cf   d2b8e4:	73 54                	jae    d2b93a <btrfs_calc_avail_data_space+0x425>
03d1   d2b8e6:	48 2d 00 00 10 00    	sub    $0x100000,%rax
03d7   d2b8ec:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
03dc   d2b8f1:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
03e1   d2b8f6:	48 c1 e0 05          	shl    $0x5,%rax
03e5   d2b8fa:	4d 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%r15
03ea   d2b8ff:	4c 89 fa             	mov    %r15,%rdx
03ed   d2b902:	48 c1 ea 03          	shr    $0x3,%rdx
03f1   d2b906:	42 80 3c 32 00       	cmpb   $0x0,(%rdx,%r14,1)
03f6   d2b90b:	74 08                	je     d2b915 <btrfs_calc_avail_data_space+0x400>
03f8   d2b90d:	4c 89 ff             	mov    %r15,%rdi
03fb   d2b910:	e8 00 00 00 00       	call   d2b915 <btrfs_calc_avail_data_space+0x400>	d2b911: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
0400   d2b915:	49 8d 7f 10          	lea    0x10(%r15),%rdi
0404   d2b919:	49 89 2f             	mov    %rbp,(%r15)
0407   d2b91c:	48 89 fa             	mov    %rdi,%rdx
040a   d2b91f:	48 c1 ea 03          	shr    $0x3,%rdx
040e   d2b923:	42 80 3c 32 00       	cmpb   $0x0,(%rdx,%r14,1)
0413   d2b928:	74 05                	je     d2b92f <btrfs_calc_avail_data_space+0x41a>
0415   d2b92a:	e8 00 00 00 00       	call   d2b92f <btrfs_calc_avail_data_space+0x41a>	d2b92b: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
041a   d2b92f:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
041f   d2b934:	ff c3                	inc    %ebx
0421   d2b936:	49 89 47 10          	mov    %rax,0x10(%r15)
0425   d2b93a:	48 89 e8             	mov    %rbp,%rax
0428   d2b93d:	48 c1 e8 03          	shr    $0x3,%rax
042c   d2b941:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
0431   d2b946:	74 08                	je     d2b950 <btrfs_calc_avail_data_space+0x43b>
0433   d2b948:	48 89 ef             	mov    %rbp,%rdi
0436   d2b94b:	e8 00 00 00 00       	call   d2b950 <btrfs_calc_avail_data_space+0x43b>	d2b94c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
043b   d2b950:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
043f   d2b954:	e9 20 fe ff ff       	jmp    d2b779 <btrfs_calc_avail_data_space+0x264>
0444   d2b959:	41 39 dc             	cmp    %ebx,%r12d
0447   d2b95c:	48 63 c5             	movslq %ebp,%rax
044a   d2b95f:	44 0f 4f e3          	cmovg  %ebx,%r12d
044e   d2b963:	48 c1 e0 05          	shl    $0x5,%rax
0452   d2b967:	4d 8d 7c 05 00       	lea    0x0(%r13,%rax,1),%r15
0457   d2b96c:	49 8d 7f 10          	lea    0x10(%r15),%rdi
045b   d2b970:	48 89 fa             	mov    %rdi,%rdx
045e   d2b973:	48 c1 ea 03          	shr    $0x3,%rdx
0462   d2b977:	42 80 3c 32 00       	cmpb   $0x0,(%rdx,%r14,1)
0467   d2b97c:	74 05                	je     d2b983 <btrfs_calc_avail_data_space+0x46e>
0469   d2b97e:	e8 00 00 00 00       	call   d2b983 <btrfs_calc_avail_data_space+0x46e>	d2b97f: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
046e   d2b983:	49 8b 4f 10          	mov    0x10(%r15),%rcx
0472   d2b987:	48 3b 4c 24 20       	cmp    0x20(%rsp),%rcx
0477   d2b98c:	72 17                	jb     d2b9a5 <btrfs_calc_avail_data_space+0x490>
0479   d2b98e:	49 63 c4             	movslq %r12d,%rax
047c   d2b991:	44 29 e3             	sub    %r12d,%ebx
047f   d2b994:	48 0f af c1          	imul   %rcx,%rax
0483   d2b998:	48 01 44 24 18       	add    %rax,0x18(%rsp)
0488   d2b99d:	41 89 df             	mov    %ebx,%r15d
048b   d2b9a0:	44 39 fd             	cmp    %r15d,%ebp
048e   d2b9a3:	7d 0d                	jge    d2b9b2 <btrfs_calc_avail_data_space+0x49d>
0490   d2b9a5:	89 eb                	mov    %ebp,%ebx
0492   d2b9a7:	8d 6b ff             	lea    -0x1(%rbx),%ebp
0495   d2b9aa:	39 5c 24 10          	cmp    %ebx,0x10(%rsp)
0499   d2b9ae:	7e a9                	jle    d2b959 <btrfs_calc_avail_data_space+0x444>
049b   d2b9b0:	eb 36                	jmp    d2b9e8 <btrfs_calc_avail_data_space+0x4d3>
049d   d2b9b2:	49 63 c7             	movslq %r15d,%rax
04a0   d2b9b5:	48 c1 e0 05          	shl    $0x5,%rax
04a4   d2b9b9:	49 8d 5c 05 00       	lea    0x0(%r13,%rax,1),%rbx
04a9   d2b9be:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
04ad   d2b9c2:	48 89 f8             	mov    %rdi,%rax
04b0   d2b9c5:	48 c1 e8 03          	shr    $0x3,%rax
04b4   d2b9c9:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
04b9   d2b9ce:	74 0f                	je     d2b9df <btrfs_calc_avail_data_space+0x4ca>
04bb   d2b9d0:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
04c0   d2b9d5:	e8 00 00 00 00       	call   d2b9da <btrfs_calc_avail_data_space+0x4c5>	d2b9d6: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
04c5   d2b9da:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
04ca   d2b9df:	48 29 4b 10          	sub    %rcx,0x10(%rbx)
04ce   d2b9e3:	41 ff c7             	inc    %r15d
04d1   d2b9e6:	eb b8                	jmp    d2b9a0 <btrfs_calc_avail_data_space+0x48b>
04d3   d2b9e8:	4c 89 ef             	mov    %r13,%rdi
04d6   d2b9eb:	e8 00 00 00 00       	call   d2b9f0 <btrfs_calc_avail_data_space+0x4db>	d2b9ec: R_X86_64_PLT32	kfree-0x4
04db   d2b9f0:	48 8b 14 24          	mov    (%rsp),%rdx
04df   d2b9f4:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
04e4   d2b9f9:	48 c1 e0 2a          	shl    $0x2a,%rax
04e8   d2b9fd:	48 c1 ea 03          	shr    $0x3,%rdx
04ec   d2ba01:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
04f0   d2ba05:	74 09                	je     d2ba10 <btrfs_calc_avail_data_space+0x4fb>
04f2   d2ba07:	48 8b 3c 24          	mov    (%rsp),%rdi
04f6   d2ba0b:	e8 00 00 00 00       	call   d2ba10 <btrfs_calc_avail_data_space+0x4fb>	d2ba0c: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
04fb   d2ba10:	48 8b 04 24          	mov    (%rsp),%rax
04ff   d2ba14:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
0504   d2ba19:	c7 44 24 10 00 00 00 00 	movl   $0x0,0x10(%rsp)
050c   d2ba21:	48 89 08             	mov    %rcx,(%rax)
050f   d2ba24:	8b 44 24 10          	mov    0x10(%rsp),%eax
0513   d2ba28:	48 83 c4 40          	add    $0x40,%rsp
0517   d2ba2c:	5b                   	pop    %rbx
0518   d2ba2d:	5d                   	pop    %rbp
0519   d2ba2e:	41 5c                	pop    %r12
051b   d2ba30:	41 5d                	pop    %r13
051d   d2ba32:	41 5e                	pop    %r14
051f   d2ba34:	41 5f                	pop    %r15
0521   d2ba36:	c3                   	ret

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
