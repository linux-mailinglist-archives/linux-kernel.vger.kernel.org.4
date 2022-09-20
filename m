Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497DE5BDBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiITEuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiITEuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:50:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C77303E8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663649404; x=1695185404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gp0qhRWi1Wcu/TGtHzPK7lXnh9IVTkgsRnxFMWSEHYE=;
  b=X37bjh06vifO/YVcMeBObFdsXJW4dEQzqgtkPYD5ltpnqPRoDGFfDUaL
   ymZmo27UOrHUJtkaLsfnyVT6PKoHOPEK0Z2kiahKHWXs92sw8vOm94Gg2
   RyaqKAROS8CC4AdVdd+6eEz+nd4f7HWlIJVsFgMmh5UbF73JiyWwqMGLL
   h9y9X6S23uiY223MBJxkIukWSedM1xaPBaSY+VKXLT5RAdrX+cdGAK9zp
   QF++0S6uLMF5FGSgqYI7HAWDrmvksvlVEdtLOyZA2jZLqbVncHgGBQHq+
   /IhsveQ1nbzPW63I7PBwCzlXTQY6HXnjyTBi3An1Qb9/bGf0xGiX9aA1F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279323385"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="279323385"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 21:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="687253847"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2022 21:50:01 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaVCr-0002Tn-0b;
        Tue, 20 Sep 2022 04:50:01 +0000
Date:   Tue, 20 Sep 2022 12:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7229/8454]
 drivers/hwmon/pmbus/adm1275.o: warning: objtool: adm1275_probe()+0x5b6:
 unreachable instruction
Message-ID: <202209201250.nTPt7mSx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   02c4837d98bf509b70afb8368175c489a5ba7b4a
commit: b24fdd0f1c3328cf8ee0c518b93a7187f8cee097 [7229/8454] x86/retbleed: Add fine grained Kconfig knobs
config: x86_64-buildonly-randconfig-r001-20220919 (https://download.01.org/0day-ci/archive/20220920/202209201250.nTPt7mSx-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b24fdd0f1c3328cf8ee0c518b93a7187f8cee097
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout b24fdd0f1c3328cf8ee0c518b93a7187f8cee097
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/adm1275.o: warning: objtool: adm1275_probe()+0x5b6: unreachable instruction


objdump-func vmlinux.o adm1275_probe:
0000 0000000000da9620 <adm1275_probe>:
0000   da9620:	e8 00 00 00 00       	call   da9625 <adm1275_probe+0x5>	da9621: R_X86_64_PLT32	__fentry__-0x4
0005   da9625:	55                   	push   %rbp
0006   da9626:	48 89 e5             	mov    %rsp,%rbp
0009   da9629:	41 57                	push   %r15
000b   da962b:	41 56                	push   %r14
000d   da962d:	41 55                	push   %r13
000f   da962f:	41 54                	push   %r12
0011   da9631:	53                   	push   %rbx
0012   da9632:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
0016   da9636:	48 83 ec 50          	sub    $0x50,%rsp
001a   da963a:	49 89 ff             	mov    %rdi,%r15
001d   da963d:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
0026   da9646:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
002b   da964b:	c6 44 24 30 00       	movb   $0x0,0x30(%rsp)
0030   da9650:	48 c7 44 24 28 00 00 00 00 	movq   $0x0,0x28(%rsp)
0039   da9659:	48 c7 44 24 20 00 00 00 00 	movq   $0x0,0x20(%rsp)
0042   da9662:	48 c7 44 24 18 00 00 00 00 	movq   $0x0,0x18(%rsp)
004b   da966b:	48 c7 44 24 10 00 00 00 00 	movq   $0x0,0x10(%rsp)
0054   da9674:	48 8b 7f 18          	mov    0x18(%rdi),%rdi
0058   da9678:	48 8b 47 10          	mov    0x10(%rdi),%rax
005c   da967c:	ff 50 20             	call   *0x20(%rax)
005f   da967f:	f7 d0                	not    %eax
0061   da9681:	bb ed ff ff ff       	mov    $0xffffffed,%ebx
0066   da9686:	a9 00 00 08 03       	test   $0x3080000,%eax
006b   da968b:	0f 85 fa 06 00 00    	jne    da9d8b <adm1275_probe+0x76b>
0071   da9691:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
0076   da9696:	4c 89 ff             	mov    %r15,%rdi
0079   da9699:	be 99 00 00 00       	mov    $0x99,%esi
007e   da969e:	e8 00 00 00 00       	call   da96a3 <adm1275_probe+0x83>	da969f: R_X86_64_PLT32	i2c_smbus_read_block_data-0x4
0083   da96a3:	85 c0                	test   %eax,%eax
0085   da96a5:	0f 88 de 06 00 00    	js     da9d89 <adm1275_probe+0x769>
008b   da96ab:	83 f8 03             	cmp    $0x3,%eax
008e   da96ae:	0f 85 d7 06 00 00    	jne    da9d8b <adm1275_probe+0x76b>
0094   da96b4:	b8 41 44 00 00       	mov    $0x4441,%eax
0099   da96b9:	33 44 24 10          	xor    0x10(%rsp),%eax
009d   da96bd:	0f b6 4c 24 12       	movzbl 0x12(%rsp),%ecx
00a2   da96c2:	83 f1 49             	xor    $0x49,%ecx
00a5   da96c5:	66 09 c1             	or     %ax,%cx
00a8   da96c8:	0f 85 bd 06 00 00    	jne    da9d8b <adm1275_probe+0x76b>
00ae   da96ce:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
00b3   da96d3:	4c 89 ff             	mov    %r15,%rdi
00b6   da96d6:	be 9a 00 00 00       	mov    $0x9a,%esi
00bb   da96db:	e8 00 00 00 00       	call   da96e0 <adm1275_probe+0xc0>	da96dc: R_X86_64_PLT32	i2c_smbus_read_block_data-0x4
00c0   da96e0:	85 c0                	test   %eax,%eax
00c2   da96e2:	0f 88 a1 06 00 00    	js     da9d89 <adm1275_probe+0x769>
00c8   da96e8:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	da96eb: R_X86_64_32S	.rodata+0x2f6e50
00cf   da96ef:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da96f2: R_X86_64_32S	.rodata+0x2f6e50
00d6   da96f6:	e8 00 00 00 00       	call   da96fb <adm1275_probe+0xdb>	da96f7: R_X86_64_PLT32	strlen-0x4
00db   da96fb:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
00e0   da9700:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9703: R_X86_64_32S	.rodata+0x2f6e50
00e7   da9707:	48 89 c2             	mov    %rax,%rdx
00ea   da970a:	e8 00 00 00 00       	call   da970f <adm1275_probe+0xef>	da970b: R_X86_64_PLT32	strncasecmp-0x4
00ef   da970f:	85 c0                	test   %eax,%eax
00f1   da9711:	0f 84 12 01 00 00    	je     da9829 <adm1275_probe+0x209>
00f7   da9717:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	da971a: R_X86_64_32S	.rodata+0x2f6e70
00fe   da971e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9721: R_X86_64_32S	.rodata+0x2f6e70
0105   da9725:	e8 00 00 00 00       	call   da972a <adm1275_probe+0x10a>	da9726: R_X86_64_PLT32	strlen-0x4
010a   da972a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
010f   da972f:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9732: R_X86_64_32S	.rodata+0x2f6e70
0116   da9736:	48 89 c2             	mov    %rax,%rdx
0119   da9739:	e8 00 00 00 00       	call   da973e <adm1275_probe+0x11e>	da973a: R_X86_64_PLT32	strncasecmp-0x4
011e   da973e:	85 c0                	test   %eax,%eax
0120   da9740:	0f 84 e3 00 00 00    	je     da9829 <adm1275_probe+0x209>
0126   da9746:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	da9749: R_X86_64_32S	.rodata+0x2f6e90
012d   da974d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9750: R_X86_64_32S	.rodata+0x2f6e90
0134   da9754:	e8 00 00 00 00       	call   da9759 <adm1275_probe+0x139>	da9755: R_X86_64_PLT32	strlen-0x4
0139   da9759:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
013e   da975e:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9761: R_X86_64_32S	.rodata+0x2f6e90
0145   da9765:	48 89 c2             	mov    %rax,%rdx
0148   da9768:	e8 00 00 00 00       	call   da976d <adm1275_probe+0x14d>	da9769: R_X86_64_PLT32	strncasecmp-0x4
014d   da976d:	85 c0                	test   %eax,%eax
014f   da976f:	0f 84 b4 00 00 00    	je     da9829 <adm1275_probe+0x209>
0155   da9775:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	da9778: R_X86_64_32S	.rodata+0x2f6eb0
015c   da977c:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da977f: R_X86_64_32S	.rodata+0x2f6eb0
0163   da9783:	e8 00 00 00 00       	call   da9788 <adm1275_probe+0x168>	da9784: R_X86_64_PLT32	strlen-0x4
0168   da9788:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
016d   da978d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9790: R_X86_64_32S	.rodata+0x2f6eb0
0174   da9794:	48 89 c2             	mov    %rax,%rdx
0177   da9797:	e8 00 00 00 00       	call   da979c <adm1275_probe+0x17c>	da9798: R_X86_64_PLT32	strncasecmp-0x4
017c   da979c:	85 c0                	test   %eax,%eax
017e   da979e:	0f 84 85 00 00 00    	je     da9829 <adm1275_probe+0x209>
0184   da97a4:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	da97a7: R_X86_64_32S	.rodata+0x2f6ed0
018b   da97ab:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da97ae: R_X86_64_32S	.rodata+0x2f6ed0
0192   da97b2:	e8 00 00 00 00       	call   da97b7 <adm1275_probe+0x197>	da97b3: R_X86_64_PLT32	strlen-0x4
0197   da97b7:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
019c   da97bc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da97bf: R_X86_64_32S	.rodata+0x2f6ed0
01a3   da97c3:	48 89 c2             	mov    %rax,%rdx
01a6   da97c6:	e8 00 00 00 00       	call   da97cb <adm1275_probe+0x1ab>	da97c7: R_X86_64_PLT32	strncasecmp-0x4
01ab   da97cb:	85 c0                	test   %eax,%eax
01ad   da97cd:	74 5a                	je     da9829 <adm1275_probe+0x209>
01af   da97cf:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	da97d2: R_X86_64_32S	.rodata+0x2f6ef0
01b6   da97d6:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da97d9: R_X86_64_32S	.rodata+0x2f6ef0
01bd   da97dd:	e8 00 00 00 00       	call   da97e2 <adm1275_probe+0x1c2>	da97de: R_X86_64_PLT32	strlen-0x4
01c2   da97e2:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
01c7   da97e7:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da97ea: R_X86_64_32S	.rodata+0x2f6ef0
01ce   da97ee:	48 89 c2             	mov    %rax,%rdx
01d1   da97f1:	e8 00 00 00 00       	call   da97f6 <adm1275_probe+0x1d6>	da97f2: R_X86_64_PLT32	strncasecmp-0x4
01d6   da97f6:	85 c0                	test   %eax,%eax
01d8   da97f8:	74 2f                	je     da9829 <adm1275_probe+0x209>
01da   da97fa:	49 c7 c6 00 00 00 00 	mov    $0x0,%r14	da97fd: R_X86_64_32S	.rodata+0x2f6f10
01e1   da9801:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9804: R_X86_64_32S	.rodata+0x2f6f10
01e8   da9808:	e8 00 00 00 00       	call   da980d <adm1275_probe+0x1ed>	da9809: R_X86_64_PLT32	strlen-0x4
01ed   da980d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
01f2   da9812:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	da9815: R_X86_64_32S	.rodata+0x2f6f10
01f9   da9819:	48 89 c2             	mov    %rax,%rdx
01fc   da981c:	e8 00 00 00 00       	call   da9821 <adm1275_probe+0x201>	da981d: R_X86_64_PLT32	strncasecmp-0x4
0201   da9821:	85 c0                	test   %eax,%eax
0203   da9823:	0f 85 62 05 00 00    	jne    da9d8b <adm1275_probe+0x76b>
0209   da9829:	49 8b 46 18          	mov    0x18(%r14),%rax
020d   da982d:	48 8d 48 ff          	lea    -0x1(%rax),%rcx
0211   da9831:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	da9834: R_X86_64_32S	i2c_smbus_read_byte_data
0218   da9838:	48 83 f9 05          	cmp    $0x5,%rcx
021c   da983c:	77 0f                	ja     da984d <adm1275_probe+0x22d>
021e   da983e:	48 c7 c1 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rcx
0225   da9845:	4c 8b ac c1 00 00 00 00 	mov    0x0(%rcx,%rax,8),%r13	da9849: R_X86_64_32S	.rodata+0x2f7088
022d   da984d:	4c 89 ff             	mov    %r15,%rdi
0230   da9850:	be d4 00 00 00       	mov    $0xd4,%esi
0235   da9855:	41 ff d5             	call   *%r13
0238   da9858:	85 c0                	test   %eax,%eax
023a   da985a:	0f 88 29 05 00 00    	js     da9d89 <adm1275_probe+0x769>
0240   da9860:	41 89 c4             	mov    %eax,%r12d
0243   da9863:	89 44 24 04          	mov    %eax,0x4(%rsp)
0247   da9867:	4c 89 ff             	mov    %r15,%rdi
024a   da986a:	be d8 00 00 00       	mov    $0xd8,%esi
024f   da986f:	41 ff d5             	call   *%r13
0252   da9872:	41 89 c5             	mov    %eax,%r13d
0255   da9875:	85 c0                	test   %eax,%eax
0257   da9877:	0f 88 c0 00 00 00    	js     da993d <adm1275_probe+0x31d>
025d   da987d:	49 8d 7f 20          	lea    0x20(%r15),%rdi
0261   da9881:	be 18 02 00 00       	mov    $0x218,%esi
0266   da9886:	ba c0 0d 00 00       	mov    $0xdc0,%edx
026b   da988b:	e8 00 00 00 00       	call   da9890 <adm1275_probe+0x270>	da988c: R_X86_64_PLT32	devm_kmalloc-0x4
0270   da9890:	48 85 c0             	test   %rax,%rax
0273   da9893:	0f 84 ac 00 00 00    	je     da9945 <adm1275_probe+0x325>
0279   da9899:	49 89 c1             	mov    %rax,%r9
027c   da989c:	41 8b 46 18          	mov    0x18(%r14),%eax
0280   da98a0:	41 89 01             	mov    %eax,(%r9)
0283   da98a3:	41 c7 41 10 01 00 00 00 	movl   $0x1,0x10(%r9)
028b   da98ab:	48 b9 01 00 00 00 01 00 00 00 	movabs $0x100000001,%rcx
0295   da98b5:	49 89 49 34          	mov    %rcx,0x34(%r9)
0299   da98b9:	49 89 49 40          	mov    %rcx,0x40(%r9)
029d   da98bd:	41 c7 41 48 01 00 00 00 	movl   $0x1,0x48(%r9)
02a5   da98c5:	41 c7 81 34 01 00 00 10 20 40 00 	movl   $0x402010,0x134(%r9)
02b0   da98d0:	49 c7 81 e0 01 00 00 00 00 00 00 	movq   $0x0,0x1e0(%r9)	da98d7: R_X86_64_32S	.text+0xda9dc0
02bb   da98db:	49 c7 81 d8 01 00 00 00 00 00 00 	movq   $0x0,0x1d8(%r9)	da98e2: R_X86_64_32S	.text+0xda9ff0
02c6   da98e6:	49 c7 81 e8 01 00 00 00 00 00 00 	movq   $0x0,0x1e8(%r9)	da98ed: R_X86_64_32S	.text+0xdaa100
02d1   da98f1:	48 83 f8 06          	cmp    $0x6,%rax
02d5   da98f5:	0f 87 90 04 00 00    	ja     da9d8b <adm1275_probe+0x76b>
02db   da98fb:	4d 89 ca             	mov    %r9,%r10
02de   da98fe:	ff 24 c5 00 00 00 00 	jmp    *0x0(,%rax,8)	da9901: R_X86_64_32S	.rodata+0x2f6980
02e5   da9905:	41 c6 42 0d 01       	movb   $0x1,0xd(%r10)
02ea   da990a:	44 89 e1             	mov    %r12d,%ecx
02ed   da990d:	89 c8                	mov    %ecx,%eax
02ef   da990f:	83 e0 0c             	and    $0xc,%eax
02f2   da9912:	41 c7 42 08 01 01 01 01 	movl   $0x1010101,0x8(%r10)
02fa   da991a:	48 83 f8 0c          	cmp    $0xc,%rax
02fe   da991e:	0f 84 2d 01 00 00    	je     da9a51 <adm1275_probe+0x431>
0304   da9924:	83 f8 08             	cmp    $0x8,%eax
0307   da9927:	0f 84 1d 01 00 00    	je     da9a4a <adm1275_probe+0x42a>
030d   da992d:	83 f8 04             	cmp    $0x4,%eax
0310   da9930:	0f 85 24 01 00 00    	jne    da9a5a <adm1275_probe+0x43a>
0316   da9936:	31 ff                	xor    %edi,%edi
0318   da9938:	e9 19 01 00 00       	jmp    da9a56 <adm1275_probe+0x436>
031d   da993d:	44 89 eb             	mov    %r13d,%ebx
0320   da9940:	e9 46 04 00 00       	jmp    da9d8b <adm1275_probe+0x76b>
0325   da9945:	bb f4 ff ff ff       	mov    $0xfffffff4,%ebx
032a   da994a:	e9 3c 04 00 00       	jmp    da9d8b <adm1275_probe+0x76b>
032f   da994f:	41 c6 42 06 01       	movb   $0x1,0x6(%r10)
0334   da9954:	66 41 c7 42 0b 01 01 	movw   $0x101,0xb(%r10)
033b   da995b:	41 c6 42 0d 01       	movb   $0x1,0xd(%r10)
0340   da9960:	41 c7 82 34 01 00 00 34 f2 40 00 	movl   $0x40f234,0x134(%r10)
034b   da996b:	44 89 e0             	mov    %r12d,%eax
034e   da996e:	f7 d0                	not    %eax
0350   da9970:	a8 0a                	test   $0xa,%al
0352   da9972:	74 31                	je     da99a5 <adm1275_probe+0x385>
0354   da9974:	41 83 cc 0a          	or     $0xa,%r12d
0358   da9978:	41 0f b6 d4          	movzbl %r12b,%edx
035c   da997c:	4c 89 ff             	mov    %r15,%rdi
035f   da997f:	be d4 00 00 00       	mov    $0xd4,%esi
0364   da9984:	4d 89 ce             	mov    %r9,%r14
0367   da9987:	4d 89 d5             	mov    %r10,%r13
036a   da998a:	e8 00 00 00 00       	call   da998f <adm1275_probe+0x36f>	da998b: R_X86_64_PLT32	i2c_smbus_write_byte_data-0x4
036f   da998f:	4d 89 ea             	mov    %r13,%r10
0372   da9992:	4d 89 f1             	mov    %r14,%r9
0375   da9995:	44 89 e1             	mov    %r12d,%ecx
0378   da9998:	44 89 64 24 04       	mov    %r12d,0x4(%rsp)
037d   da999d:	85 c0                	test   %eax,%eax
037f   da999f:	0f 88 e6 03 00 00    	js     da9d8b <adm1275_probe+0x76b>
0385   da99a5:	41 b8 03 00 00 00    	mov    $0x3,%r8d
038b   da99ab:	40 b6 01             	mov    $0x1,%sil
038e   da99ae:	41 bd 02 00 00 00    	mov    $0x2,%r13d
0394   da99b4:	41 bc 01 00 00 00    	mov    $0x1,%r12d
039a   da99ba:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	da99bd: R_X86_64_32S	.rodata+0x2f6ff0
03a1   da99c1:	31 d2                	xor    %edx,%edx
03a3   da99c3:	bf 00 00 00 00       	mov    $0x0,%edi
03a8   da99c8:	bb 01 00 00 00       	mov    $0x1,%ebx
03ad   da99cd:	f6 44 24 04 04       	testb  $0x4,0x4(%rsp)
03b2   da99d2:	0f 85 89 02 00 00    	jne    da9c61 <adm1275_probe+0x641>
03b8   da99d8:	e9 9d 02 00 00       	jmp    da9c7a <adm1275_probe+0x65a>
03bd   da99dd:	41 f6 c5 10          	test   $0x10,%r13b
03c1   da99e1:	0f 85 c7 00 00 00    	jne    da9aae <adm1275_probe+0x48e>
03c7   da99e7:	41 c6 42 05 01       	movb   $0x1,0x5(%r10)
03cc   da99ec:	e9 c2 00 00 00       	jmp    da9ab3 <adm1275_probe+0x493>
03d1   da99f1:	41 f6 c5 10          	test   $0x10,%r13b
03d5   da99f5:	0f 85 ec 00 00 00    	jne    da9ae7 <adm1275_probe+0x4c7>
03db   da99fb:	41 c6 42 05 01       	movb   $0x1,0x5(%r10)
03e0   da9a00:	e9 e7 00 00 00       	jmp    da9aec <adm1275_probe+0x4cc>
03e5   da9a05:	41 f6 c5 10          	test   $0x10,%r13b
03e9   da9a09:	0f 85 4c 01 00 00    	jne    da9b5b <adm1275_probe+0x53b>
03ef   da9a0f:	41 c6 42 05 01       	movb   $0x1,0x5(%r10)
03f4   da9a14:	e9 47 01 00 00       	jmp    da9b60 <adm1275_probe+0x540>
03f9   da9a19:	41 c6 42 06 01       	movb   $0x1,0x6(%r10)
03fe   da9a1e:	66 41 c7 42 0b 01 01 	movw   $0x101,0xb(%r10)
0405   da9a25:	41 c6 42 0d 01       	movb   $0x1,0xd(%r10)
040a   da9a2a:	44 89 e0             	mov    %r12d,%eax
040d   da9a2d:	89 c1                	mov    %eax,%ecx
040f   da9a2f:	83 e1 21             	and    $0x21,%ecx
0412   da9a32:	41 bd 04 00 00 00    	mov    $0x4,%r13d
0418   da9a38:	ff 24 cd 00 00 00 00 	jmp    *0x0(,%rcx,8)	da9a3b: R_X86_64_32S	.rodata+0x2f69b8
041f   da9a3f:	41 bd 06 00 00 00    	mov    $0x6,%r13d
0425   da9a45:	e9 9a 01 00 00       	jmp    da9be4 <adm1275_probe+0x5c4>
042a   da9a4a:	bf 01 00 00 00       	mov    $0x1,%edi
042f   da9a4f:	eb 05                	jmp    da9a56 <adm1275_probe+0x436>
0431   da9a51:	bf 02 00 00 00       	mov    $0x2,%edi
0436   da9a56:	b0 01                	mov    $0x1,%al
0438   da9a58:	eb 07                	jmp    da9a61 <adm1275_probe+0x441>
043a   da9a5a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
043f   da9a5f:	31 c0                	xor    %eax,%eax
0441   da9a61:	41 c1 ec 06          	shr    $0x6,%r12d
0445   da9a65:	41 83 e4 03          	and    $0x3,%r12d
0449   da9a69:	44 89 e3             	mov    %r12d,%ebx
044c   da9a6c:	83 c3 03             	add    $0x3,%ebx
044f   da9a6f:	41 8d 14 bc          	lea    (%r12,%rdi,4),%edx
0453   da9a73:	83 c2 07             	add    $0x7,%edx
0456   da9a76:	84 c0                	test   %al,%al
0458   da9a78:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
045e   da9a7e:	44 0f 45 ea          	cmovne %edx,%r13d
0462   da9a82:	31 d2                	xor    %edx,%edx
0464   da9a84:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	da9a87: R_X86_64_32S	.rodata+0x2f7010
046b   da9a8b:	be 31 60 40 00       	mov    $0x406031,%esi
0470   da9a90:	f6 c1 02             	test   $0x2,%cl
0473   da9a93:	0f 84 a5 00 00 00    	je     da9b3e <adm1275_probe+0x51e>
0479   da9a99:	41 c7 82 34 01 00 00 14 30 40 00 	movl   $0x403014,0x134(%r10)
0484   da9aa4:	be 35 70 40 00       	mov    $0x407035,%esi
0489   da9aa9:	e9 90 00 00 00       	jmp    da9b3e <adm1275_probe+0x51e>
048e   da9aae:	41 c6 42 04 01       	movb   $0x1,0x4(%r10)
0493   da9ab3:	8b 44 24 04          	mov    0x4(%rsp),%eax
0497   da9ab7:	31 ff                	xor    %edi,%edi
0499   da9ab9:	a8 20                	test   $0x20,%al
049b   da9abb:	40 0f 94 c7          	sete   %dil
049f   da9abf:	a8 40                	test   $0x40,%al
04a1   da9ac1:	b8 11 60 40 00       	mov    $0x406011,%eax
04a6   da9ac6:	be 14 30 40 00       	mov    $0x403014,%esi
04ab   da9acb:	0f 44 f0             	cmove  %eax,%esi
04ae   da9ace:	41 c6 42 06 01       	movb   $0x1,0x6(%r10)
04b3   da9ad3:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	da9ad6: R_X86_64_32S	.rodata+0x2f6fb0
04ba   da9ada:	bb 02 00 00 00       	mov    $0x2,%ebx
04bf   da9adf:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
04c5   da9ae5:	eb 55                	jmp    da9b3c <adm1275_probe+0x51c>
04c7   da9ae7:	41 c6 42 04 01       	movb   $0x1,0x4(%r10)
04cc   da9aec:	41 c6 42 06 01       	movb   $0x1,0x6(%r10)
04d1   da9af1:	41 c6 42 0b 01       	movb   $0x1,0xb(%r10)
04d6   da9af6:	44 89 e0             	mov    %r12d,%eax
04d9   da9af9:	89 c1                	mov    %eax,%ecx
04db   da9afb:	83 e1 20             	and    $0x20,%ecx
04de   da9afe:	48 89 cf             	mov    %rcx,%rdi
04e1   da9b01:	48 c1 ef 05          	shr    $0x5,%rdi
04e5   da9b05:	83 f7 01             	xor    $0x1,%edi
04e8   da9b08:	48 83 f9 01          	cmp    $0x1,%rcx
04ec   da9b0c:	41 bd 03 00 00 00    	mov    $0x3,%r13d
04f2   da9b12:	41 83 d5 00          	adc    $0x0,%r13d
04f6   da9b16:	41 c7 82 34 01 00 00 31 60 40 00 	movl   $0x406031,0x134(%r10)
0501   da9b21:	a8 40                	test   $0x40,%al
0503   da9b23:	b8 31 60 40 00       	mov    $0x406031,%eax
0508   da9b28:	be 35 70 40 00       	mov    $0x407035,%esi
050d   da9b2d:	0f 44 f0             	cmove  %eax,%esi
0510   da9b30:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	da9b33: R_X86_64_32S	.rodata+0x2f6fd0
0517   da9b37:	bb 02 00 00 00       	mov    $0x2,%ebx
051c   da9b3c:	89 fa                	mov    %edi,%edx
051e   da9b3e:	41 89 b2 34 01 00 00 	mov    %esi,0x134(%r10)
0525   da9b45:	49 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%r8
052c   da9b4c:	31 f6                	xor    %esi,%esi
052e   da9b4e:	85 ff                	test   %edi,%edi
0530   da9b50:	0f 89 24 01 00 00    	jns    da9c7a <adm1275_probe+0x65a>
0536   da9b56:	e9 48 01 00 00       	jmp    da9ca3 <adm1275_probe+0x683>
053b   da9b5b:	41 c6 42 04 01       	movb   $0x1,0x4(%r10)
0540   da9b60:	41 c6 42 0b 01       	movb   $0x1,0xb(%r10)
0545   da9b65:	41 c6 42 07 01       	movb   $0x1,0x7(%r10)
054a   da9b6a:	44 89 e0             	mov    %r12d,%eax
054d   da9b6d:	89 c1                	mov    %eax,%ecx
054f   da9b6f:	83 e1 18             	and    $0x18,%ecx
0552   da9b72:	48 83 f9 08          	cmp    $0x8,%rcx
0556   da9b76:	74 13                	je     da9b8b <adm1275_probe+0x56b>
0558   da9b78:	83 f9 10             	cmp    $0x10,%ecx
055b   da9b7b:	75 1c                	jne    da9b99 <adm1275_probe+0x579>
055d   da9b7d:	41 bd 04 00 00 00    	mov    $0x4,%r13d
0563   da9b83:	41 bc 02 00 00 00    	mov    $0x2,%r12d
0569   da9b89:	eb 1a                	jmp    da9ba5 <adm1275_probe+0x585>
056b   da9b8b:	41 bd 03 00 00 00    	mov    $0x3,%r13d
0571   da9b91:	41 bc 01 00 00 00    	mov    $0x1,%r12d
0577   da9b97:	eb 0c                	jmp    da9ba5 <adm1275_probe+0x585>
0579   da9b99:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
057f   da9b9f:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
0585   da9ba5:	41 c7 82 34 01 00 00 31 60 40 00 	movl   $0x406031,0x134(%r10)
0590   da9bb0:	a8 40                	test   $0x40,%al
0592   da9bb2:	b8 31 60 40 00       	mov    $0x406031,%eax
0597   da9bb7:	bf 35 70 40 00       	mov    $0x407035,%edi
059c   da9bbc:	0f 44 f8             	cmove  %eax,%edi
059f   da9bbf:	49 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%r8
05a6   da9bc6:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	da9bc9: R_X86_64_32S	.rodata+0x2f6f50
05ad   da9bcd:	31 d2                	xor    %edx,%edx
05af   da9bcf:	31 f6                	xor    %esi,%esi
05b1   da9bd1:	e9 98 00 00 00       	jmp    da9c6e <adm1275_probe+0x64e>
05b6   da9bd6:	41 bd 07 00 00 00    	mov    $0x7,%r13d
05bc   da9bdc:	eb 06                	jmp    da9be4 <adm1275_probe+0x5c4>
05be   da9bde:	41 bd 05 00 00 00    	mov    $0x5,%r13d
05c4   da9be4:	41 c7 82 34 01 00 00 34 70 40 00 	movl   $0x407034,0x134(%r10)
05cf   da9bef:	a8 02                	test   $0x2,%al
05d1   da9bf1:	75 32                	jne    da9c25 <adm1275_probe+0x605>
05d3   da9bf3:	44 89 e0             	mov    %r12d,%eax
05d6   da9bf6:	83 c8 02             	or     $0x2,%eax
05d9   da9bf9:	89 44 24 04          	mov    %eax,0x4(%rsp)
05dd   da9bfd:	0f b6 d0             	movzbl %al,%edx
05e0   da9c00:	4c 89 ff             	mov    %r15,%rdi
05e3   da9c03:	be d4 00 00 00       	mov    $0xd4,%esi
05e8   da9c08:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
05ed   da9c0d:	4d 89 d6             	mov    %r10,%r14
05f0   da9c10:	e8 00 00 00 00       	call   da9c15 <adm1275_probe+0x5f5>	da9c11: R_X86_64_PLT32	i2c_smbus_write_byte_data-0x4
05f5   da9c15:	4d 89 f2             	mov    %r14,%r10
05f8   da9c18:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
05fd   da9c1d:	85 c0                	test   %eax,%eax
05ff   da9c1f:	0f 88 66 01 00 00    	js     da9d8b <adm1275_probe+0x76b>
0605   da9c25:	44 89 e2             	mov    %r12d,%edx
0608   da9c28:	c1 ea 05             	shr    $0x5,%edx
060b   da9c2b:	41 83 e4 01          	and    $0x1,%r12d
060f   da9c2f:	8b 4c 24 04          	mov    0x4(%rsp),%ecx
0613   da9c33:	f6 c1 08             	test   $0x8,%cl
0616   da9c36:	74 08                	je     da9c40 <adm1275_probe+0x620>
0618   da9c38:	41 80 8a 35 01 00 00 82 	orb    $0x82,0x135(%r10)
0620   da9c40:	83 e2 01             	and    $0x1,%edx
0623   da9c43:	41 83 cc 02          	or     $0x2,%r12d
0627   da9c47:	41 b8 08 00 00 00    	mov    $0x8,%r8d
062d   da9c4d:	40 b6 01             	mov    $0x1,%sil
0630   da9c50:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax	da9c53: R_X86_64_32S	.rodata+0x2f6f70
0637   da9c57:	89 d7                	mov    %edx,%edi
0639   da9c59:	44 89 e3             	mov    %r12d,%ebx
063c   da9c5c:	f6 c1 04             	test   $0x4,%cl
063f   da9c5f:	74 19                	je     da9c7a <adm1275_probe+0x65a>
0641   da9c61:	41 8b ba 34 01 00 00 	mov    0x134(%r10),%edi
0648   da9c68:	83 cf 01             	or     $0x1,%edi
064b   da9c6b:	40 b6 01             	mov    $0x1,%sil
064e   da9c6e:	41 89 ba 34 01 00 00 	mov    %edi,0x134(%r10)
0655   da9c75:	89 d7                	mov    %edx,%edi
0657   da9c77:	44 89 e3             	mov    %r12d,%ebx
065a   da9c7a:	89 f9                	mov    %edi,%ecx
065c   da9c7c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
0660   da9c80:	0f bf 3c 48          	movswl (%rax,%rcx,2),%edi
0664   da9c84:	41 89 ba d4 00 00 00 	mov    %edi,0xd4(%r10)
066b   da9c8b:	0f bf 7c 48 02       	movswl 0x2(%rax,%rcx,2),%edi
0670   da9c90:	41 89 ba f4 00 00 00 	mov    %edi,0xf4(%r10)
0677   da9c97:	0f bf 4c 48 04       	movswl 0x4(%rax,%rcx,2),%ecx
067c   da9c9c:	41 89 8a 14 01 00 00 	mov    %ecx,0x114(%r10)
0683   da9ca3:	85 d2                	test   %edx,%edx
0685   da9ca5:	78 29                	js     da9cd0 <adm1275_probe+0x6b0>
0687   da9ca7:	89 d1                	mov    %edx,%ecx
0689   da9ca9:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
068d   da9cad:	0f bf 14 48          	movswl (%rax,%rcx,2),%edx
0691   da9cb1:	41 89 92 d8 00 00 00 	mov    %edx,0xd8(%r10)
0698   da9cb8:	0f bf 54 48 02       	movswl 0x2(%rax,%rcx,2),%edx
069d   da9cbd:	41 89 92 f8 00 00 00 	mov    %edx,0xf8(%r10)
06a4   da9cc4:	0f bf 4c 48 04       	movswl 0x4(%rax,%rcx,2),%ecx
06a9   da9cc9:	41 89 8a 18 01 00 00 	mov    %ecx,0x118(%r10)
06b0   da9cd0:	85 db                	test   %ebx,%ebx
06b2   da9cd2:	78 3a                	js     da9d0e <adm1275_probe+0x6ee>
06b4   da9cd4:	89 d9                	mov    %ebx,%ecx
06b6   da9cd6:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
06ba   da9cda:	0f bf 14 48          	movswl (%rax,%rcx,2),%edx
06be   da9cde:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
06c4   da9ce4:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
06cb   da9ceb:	48 c1 ea 26          	shr    $0x26,%rdx
06cf   da9cef:	41 89 92 e0 00 00 00 	mov    %edx,0xe0(%r10)
06d6   da9cf6:	0f bf 54 48 02       	movswl 0x2(%rax,%rcx,2),%edx
06db   da9cfb:	41 89 92 00 01 00 00 	mov    %edx,0x100(%r10)
06e2   da9d02:	0f bf 4c 48 04       	movswl 0x4(%rax,%rcx,2),%ecx
06e7   da9d07:	41 89 8a 20 01 00 00 	mov    %ecx,0x120(%r10)
06ee   da9d0e:	45 85 ed             	test   %r13d,%r13d
06f1   da9d11:	78 3b                	js     da9d4e <adm1275_probe+0x72e>
06f3   da9d13:	44 89 e9             	mov    %r13d,%ecx
06f6   da9d16:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
06fa   da9d1a:	0f bf 14 48          	movswl (%rax,%rcx,2),%edx
06fe   da9d1e:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
0704   da9d24:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
070b   da9d2b:	48 c1 ea 26          	shr    $0x26,%rdx
070f   da9d2f:	41 89 92 e4 00 00 00 	mov    %edx,0xe4(%r10)
0716   da9d36:	0f bf 54 48 02       	movswl 0x2(%rax,%rcx,2),%edx
071b   da9d3b:	41 89 92 04 01 00 00 	mov    %edx,0x104(%r10)
0722   da9d42:	0f bf 4c 48 04       	movswl 0x4(%rax,%rcx,2),%ecx
0727   da9d47:	41 89 8a 24 01 00 00 	mov    %ecx,0x124(%r10)
072e   da9d4e:	49 83 c1 10          	add    $0x10,%r9
0732   da9d52:	40 84 f6             	test   %sil,%sil
0735   da9d55:	74 27                	je     da9d7e <adm1275_probe+0x75e>
0737   da9d57:	4b 8d 0c 40          	lea    (%r8,%r8,2),%rcx
073b   da9d5b:	0f bf 14 48          	movswl (%rax,%rcx,2),%edx
073f   da9d5f:	41 89 92 e8 00 00 00 	mov    %edx,0xe8(%r10)
0746   da9d66:	0f bf 54 48 02       	movswl 0x2(%rax,%rcx,2),%edx
074b   da9d6b:	41 89 92 08 01 00 00 	mov    %edx,0x108(%r10)
0752   da9d72:	0f bf 44 48 04       	movswl 0x4(%rax,%rcx,2),%eax
0757   da9d77:	41 89 82 28 01 00 00 	mov    %eax,0x128(%r10)
075e   da9d7e:	4c 89 ff             	mov    %r15,%rdi
0761   da9d81:	4c 89 ce             	mov    %r9,%rsi
0764   da9d84:	e8 00 00 00 00       	call   da9d89 <adm1275_probe+0x769>	da9d85: R_X86_64_PLT32	pmbus_do_probe-0x4
0769   da9d89:	89 c3                	mov    %eax,%ebx
076b   da9d8b:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
0774   da9d94:	48 3b 44 24 40       	cmp    0x40(%rsp),%rax
0779   da9d99:	75 11                	jne    da9dac <adm1275_probe+0x78c>
077b   da9d9b:	89 d8                	mov    %ebx,%eax
077d   da9d9d:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
0781   da9da1:	5b                   	pop    %rbx
0782   da9da2:	41 5c                	pop    %r12
0784   da9da4:	41 5d                	pop    %r13
0786   da9da6:	41 5e                	pop    %r14
0788   da9da8:	41 5f                	pop    %r15
078a   da9daa:	5d                   	pop    %rbp
078b   da9dab:	c3                   	ret
078c   da9dac:	e8 00 00 00 00       	call   da9db1 <adm1275_probe+0x791>	da9dad: R_X86_64_PLT32	__stack_chk_fail-0x4
0791   da9db1:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
079c   da9dbc:	0f 1f 40 00          	nopl   0x0(%rax)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
