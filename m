Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171695B5191
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIKWmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIKWmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:42:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BE21AF1E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662936135; x=1694472135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2CT059quif1vHHkd5oBy064mEBAqhqROoUh8CQYPHJs=;
  b=B5FRuztFTs7P2Bne+/pPvVTs0k8/drLM8YO5O5Wpuhq9IfhNuC/xYXsP
   ZlsvuZ25stYQNcYWhC+ZhpGwVlrZHDePszCAx6ZPRfjyJuxT3BF3H7BPT
   8McVNqlLQ1L31VnNPxnv9u4pXi1YSpSwdJ0bcT2cNXiLwnhwsdxlrpjxe
   V71kddtHC8pkeXm9Z4lJTwn9DGs/RL78aykGItTF+o9z7sB1Aw9SbhLYJ
   7iNSuPfmPhgwKHBR0bsEpnSFW3sEOatXIAikNnL9TQyQP/cNVSUguHAeO
   ERuYUI94wbN5OtAkrmszWXRg48wiDXiWtdRAZTBid56Vsv5G1uOWpS/lY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="297757792"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="297757792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 15:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="684231465"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2022 15:42:11 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXVeV-0001ud-0k;
        Sun, 11 Sep 2022 22:42:11 +0000
Date:   Mon, 12 Sep 2022 06:41:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7229/8352]
 drivers/hwmon/pmbus/adm1275.o: warning: objtool: adm1275_probe()+0xb9d:
 unreachable instruction
Message-ID: <202209120617.fQihNjOl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   281e81a5e2b211e2ecdca7362330acf9b238a1a6
commit: b24fdd0f1c3328cf8ee0c518b93a7187f8cee097 [7229/8352] x86/retbleed: Add fine grained Kconfig knobs
config: x86_64-randconfig-a011-20220912 (https://download.01.org/0day-ci/archive/20220912/202209120617.fQihNjOl-lkp@intel.com/config)
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

>> drivers/hwmon/pmbus/adm1275.o: warning: objtool: adm1275_probe()+0xb9d: unreachable instruction


objdump-func vmlinux.o adm1275_probe:
0000 000000000232cca0 <adm1275_probe>:
0000  232cca0:	e8 00 00 00 00       	call   232cca5 <adm1275_probe+0x5>	232cca1: R_X86_64_PLT32	__fentry__-0x4
0005  232cca5:	55                   	push   %rbp
0006  232cca6:	48 89 e5             	mov    %rsp,%rbp
0009  232cca9:	41 57                	push   %r15
000b  232ccab:	41 56                	push   %r14
000d  232ccad:	41 55                	push   %r13
000f  232ccaf:	41 54                	push   %r12
0011  232ccb1:	53                   	push   %rbx
0012  232ccb2:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
0016  232ccb6:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
001d  232ccbd:	49 89 fe             	mov    %rdi,%r14
0020  232ccc0:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
002a  232ccca:	48 8d 5f 18          	lea    0x18(%rdi),%rbx
002e  232ccce:	48 89 d8             	mov    %rbx,%rax
0031  232ccd1:	48 c1 e8 03          	shr    $0x3,%rax
0035  232ccd5:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
0039  232ccd9:	74 12                	je     232cced <adm1275_probe+0x4d>
003b  232ccdb:	48 89 df             	mov    %rbx,%rdi
003e  232ccde:	e8 00 00 00 00       	call   232cce3 <adm1275_probe+0x43>	232ccdf: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0043  232cce3:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
004d  232cced:	4c 8b 3b             	mov    (%rbx),%r15
0050  232ccf0:	49 8d 5f 10          	lea    0x10(%r15),%rbx
0054  232ccf4:	48 89 d8             	mov    %rbx,%rax
0057  232ccf7:	48 c1 e8 03          	shr    $0x3,%rax
005b  232ccfb:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
005f  232ccff:	74 12                	je     232cd13 <adm1275_probe+0x73>
0061  232cd01:	48 89 df             	mov    %rbx,%rdi
0064  232cd04:	e8 00 00 00 00       	call   232cd09 <adm1275_probe+0x69>	232cd05: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0069  232cd09:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
0073  232cd13:	48 8b 1b             	mov    (%rbx),%rbx
0076  232cd16:	48 83 c3 20          	add    $0x20,%rbx
007a  232cd1a:	48 89 d8             	mov    %rbx,%rax
007d  232cd1d:	48 c1 e8 03          	shr    $0x3,%rax
0081  232cd21:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
0085  232cd25:	74 08                	je     232cd2f <adm1275_probe+0x8f>
0087  232cd27:	48 89 df             	mov    %rbx,%rdi
008a  232cd2a:	e8 00 00 00 00       	call   232cd2f <adm1275_probe+0x8f>	232cd2b: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
008f  232cd2f:	4c 89 ff             	mov    %r15,%rdi
0092  232cd32:	ff 13                	call   *(%rbx)
0094  232cd34:	f7 d0                	not    %eax
0096  232cd36:	41 bc ed ff ff ff    	mov    $0xffffffed,%r12d
009c  232cd3c:	a9 00 00 08 03       	test   $0x3080000,%eax
00a1  232cd41:	0f 85 d3 0f 00 00    	jne    232dd1a <adm1275_probe+0x107a>
00a7  232cd47:	48 8d 54 24 40       	lea    0x40(%rsp),%rdx
00ac  232cd4c:	4c 89 f7             	mov    %r14,%rdi
00af  232cd4f:	be 99 00 00 00       	mov    $0x99,%esi
00b4  232cd54:	e8 00 00 00 00       	call   232cd59 <adm1275_probe+0xb9>	232cd55: R_X86_64_PLT32	i2c_smbus_read_block_data-0x4
00b9  232cd59:	89 c3                	mov    %eax,%ebx
00bb  232cd5b:	85 c0                	test   %eax,%eax
00bd  232cd5d:	0f 88 3e 05 00 00    	js     232d2a1 <adm1275_probe+0x601>
00c3  232cd63:	83 fb 03             	cmp    $0x3,%ebx
00c6  232cd66:	0f 85 db 02 00 00    	jne    232d047 <adm1275_probe+0x3a7>
00cc  232cd6c:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
00d1  232cd71:	ba 03 00 00 00       	mov    $0x3,%edx
00d6  232cd76:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232cd79: R_X86_64_32S	.rodata+0x8570c0
00dd  232cd7d:	e8 00 00 00 00       	call   232cd82 <adm1275_probe+0xe2>	232cd7e: R_X86_64_PLT32	bcmp-0x4
00e2  232cd82:	85 c0                	test   %eax,%eax
00e4  232cd84:	0f 85 bd 02 00 00    	jne    232d047 <adm1275_probe+0x3a7>
00ea  232cd8a:	48 8d 54 24 40       	lea    0x40(%rsp),%rdx
00ef  232cd8f:	4c 89 f7             	mov    %r14,%rdi
00f2  232cd92:	be 9a 00 00 00       	mov    $0x9a,%esi
00f7  232cd97:	e8 00 00 00 00       	call   232cd9c <adm1275_probe+0xfc>	232cd98: R_X86_64_PLT32	i2c_smbus_read_block_data-0x4
00fc  232cd9c:	85 c0                	test   %eax,%eax
00fe  232cd9e:	0f 88 0d 05 00 00    	js     232d2b1 <adm1275_probe+0x611>
0104  232cda4:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	232cda7: R_X86_64_32S	.rodata+0x856f40
010b  232cdab:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232cdae: R_X86_64_32S	.rodata+0x856f40
0112  232cdb2:	e8 00 00 00 00       	call   232cdb7 <adm1275_probe+0x117>	232cdb3: R_X86_64_PLT32	strlen-0x4
0117  232cdb7:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
011c  232cdbc:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232cdbf: R_X86_64_32S	.rodata+0x856f40
0123  232cdc3:	48 89 c2             	mov    %rax,%rdx
0126  232cdc6:	e8 00 00 00 00       	call   232cdcb <adm1275_probe+0x12b>	232cdc7: R_X86_64_PLT32	strncasecmp-0x4
012b  232cdcb:	85 c0                	test   %eax,%eax
012d  232cdcd:	0f 84 12 01 00 00    	je     232cee5 <adm1275_probe+0x245>
0133  232cdd3:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	232cdd6: R_X86_64_32S	.rodata+0x856f60
013a  232cdda:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232cddd: R_X86_64_32S	.rodata+0x856f60
0141  232cde1:	e8 00 00 00 00       	call   232cde6 <adm1275_probe+0x146>	232cde2: R_X86_64_PLT32	strlen-0x4
0146  232cde6:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
014b  232cdeb:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232cdee: R_X86_64_32S	.rodata+0x856f60
0152  232cdf2:	48 89 c2             	mov    %rax,%rdx
0155  232cdf5:	e8 00 00 00 00       	call   232cdfa <adm1275_probe+0x15a>	232cdf6: R_X86_64_PLT32	strncasecmp-0x4
015a  232cdfa:	85 c0                	test   %eax,%eax
015c  232cdfc:	0f 84 e3 00 00 00    	je     232cee5 <adm1275_probe+0x245>
0162  232ce02:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	232ce05: R_X86_64_32S	.rodata+0x856f80
0169  232ce09:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ce0c: R_X86_64_32S	.rodata+0x856f80
0170  232ce10:	e8 00 00 00 00       	call   232ce15 <adm1275_probe+0x175>	232ce11: R_X86_64_PLT32	strlen-0x4
0175  232ce15:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
017a  232ce1a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ce1d: R_X86_64_32S	.rodata+0x856f80
0181  232ce21:	48 89 c2             	mov    %rax,%rdx
0184  232ce24:	e8 00 00 00 00       	call   232ce29 <adm1275_probe+0x189>	232ce25: R_X86_64_PLT32	strncasecmp-0x4
0189  232ce29:	85 c0                	test   %eax,%eax
018b  232ce2b:	0f 84 b4 00 00 00    	je     232cee5 <adm1275_probe+0x245>
0191  232ce31:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	232ce34: R_X86_64_32S	.rodata+0x856fa0
0198  232ce38:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ce3b: R_X86_64_32S	.rodata+0x856fa0
019f  232ce3f:	e8 00 00 00 00       	call   232ce44 <adm1275_probe+0x1a4>	232ce40: R_X86_64_PLT32	strlen-0x4
01a4  232ce44:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
01a9  232ce49:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ce4c: R_X86_64_32S	.rodata+0x856fa0
01b0  232ce50:	48 89 c2             	mov    %rax,%rdx
01b3  232ce53:	e8 00 00 00 00       	call   232ce58 <adm1275_probe+0x1b8>	232ce54: R_X86_64_PLT32	strncasecmp-0x4
01b8  232ce58:	85 c0                	test   %eax,%eax
01ba  232ce5a:	0f 84 85 00 00 00    	je     232cee5 <adm1275_probe+0x245>
01c0  232ce60:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	232ce63: R_X86_64_32S	.rodata+0x856fc0
01c7  232ce67:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ce6a: R_X86_64_32S	.rodata+0x856fc0
01ce  232ce6e:	e8 00 00 00 00       	call   232ce73 <adm1275_probe+0x1d3>	232ce6f: R_X86_64_PLT32	strlen-0x4
01d3  232ce73:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
01d8  232ce78:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ce7b: R_X86_64_32S	.rodata+0x856fc0
01df  232ce7f:	48 89 c2             	mov    %rax,%rdx
01e2  232ce82:	e8 00 00 00 00       	call   232ce87 <adm1275_probe+0x1e7>	232ce83: R_X86_64_PLT32	strncasecmp-0x4
01e7  232ce87:	85 c0                	test   %eax,%eax
01e9  232ce89:	74 5a                	je     232cee5 <adm1275_probe+0x245>
01eb  232ce8b:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	232ce8e: R_X86_64_32S	.rodata+0x856fe0
01f2  232ce92:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ce95: R_X86_64_32S	.rodata+0x856fe0
01f9  232ce99:	e8 00 00 00 00       	call   232ce9e <adm1275_probe+0x1fe>	232ce9a: R_X86_64_PLT32	strlen-0x4
01fe  232ce9e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
0203  232cea3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232cea6: R_X86_64_32S	.rodata+0x856fe0
020a  232ceaa:	48 89 c2             	mov    %rax,%rdx
020d  232cead:	e8 00 00 00 00       	call   232ceb2 <adm1275_probe+0x212>	232ceae: R_X86_64_PLT32	strncasecmp-0x4
0212  232ceb2:	85 c0                	test   %eax,%eax
0214  232ceb4:	74 2f                	je     232cee5 <adm1275_probe+0x245>
0216  232ceb6:	49 c7 c5 00 00 00 00 	mov    $0x0,%r13	232ceb9: R_X86_64_32S	.rodata+0x857000
021d  232cebd:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232cec0: R_X86_64_32S	.rodata+0x857000
0224  232cec4:	e8 00 00 00 00       	call   232cec9 <adm1275_probe+0x229>	232cec5: R_X86_64_PLT32	strlen-0x4
0229  232cec9:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
022e  232cece:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	232ced1: R_X86_64_32S	.rodata+0x857000
0235  232ced5:	48 89 c2             	mov    %rax,%rdx
0238  232ced8:	e8 00 00 00 00       	call   232cedd <adm1275_probe+0x23d>	232ced9: R_X86_64_PLT32	strncasecmp-0x4
023d  232cedd:	85 c0                	test   %eax,%eax
023f  232cedf:	0f 85 47 0e 00 00    	jne    232dd2c <adm1275_probe+0x108c>
0245  232cee5:	49 8d 5e 04          	lea    0x4(%r14),%rbx
0249  232cee9:	48 89 df             	mov    %rbx,%rdi
024c  232ceec:	4c 89 ee             	mov    %r13,%rsi
024f  232ceef:	e8 00 00 00 00       	call   232cef4 <adm1275_probe+0x254>	232cef0: R_X86_64_PLT32	strcmp-0x4
0254  232cef4:	85 c0                	test   %eax,%eax
0256  232cef6:	0f 85 d2 03 00 00    	jne    232d2ce <adm1275_probe+0x62e>
025c  232cefc:	49 83 c5 18          	add    $0x18,%r13
0260  232cf00:	4d 89 ef             	mov    %r13,%r15
0263  232cf03:	49 c1 ef 03          	shr    $0x3,%r15
0267  232cf07:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
0271  232cf11:	41 80 3c 0f 00       	cmpb   $0x0,(%r15,%rcx,1)
0276  232cf16:	74 12                	je     232cf2a <adm1275_probe+0x28a>
0278  232cf18:	4c 89 ef             	mov    %r13,%rdi
027b  232cf1b:	e8 00 00 00 00       	call   232cf20 <adm1275_probe+0x280>	232cf1c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0280  232cf20:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
028a  232cf2a:	49 8b 45 00          	mov    0x0(%r13),%rax
028e  232cf2e:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
0292  232cf32:	48 c7 c3 00 00 00 00 	mov    $0x0,%rbx	232cf35: R_X86_64_32S	i2c_smbus_read_byte_data
0299  232cf39:	48 83 f8 05          	cmp    $0x5,%rax
029d  232cf3d:	77 20                	ja     232cf5f <adm1275_probe+0x2bf>
029f  232cf3f:	48 8d 1c c5 00 00 00 00 	lea    0x0(,%rax,8),%rbx	232cf43: R_X86_64_32S	.rodata+0x857500
02a7  232cf47:	48 89 d8             	mov    %rbx,%rax
02aa  232cf4a:	48 c1 e8 03          	shr    $0x3,%rax
02ae  232cf4e:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
02b2  232cf52:	74 08                	je     232cf5c <adm1275_probe+0x2bc>
02b4  232cf54:	48 89 df             	mov    %rbx,%rdi
02b7  232cf57:	e8 00 00 00 00       	call   232cf5c <adm1275_probe+0x2bc>	232cf58: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
02bc  232cf5c:	48 8b 1b             	mov    (%rbx),%rbx
02bf  232cf5f:	4c 89 f7             	mov    %r14,%rdi
02c2  232cf62:	be d4 00 00 00       	mov    $0xd4,%esi
02c7  232cf67:	ff d3                	call   *%rbx
02c9  232cf69:	89 c1                	mov    %eax,%ecx
02cb  232cf6b:	85 c0                	test   %eax,%eax
02cd  232cf6d:	0f 88 c1 00 00 00    	js     232d034 <adm1275_probe+0x394>
02d3  232cf73:	89 4c 24 08          	mov    %ecx,0x8(%rsp)
02d7  232cf77:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
02dc  232cf7c:	4c 89 f7             	mov    %r14,%rdi
02df  232cf7f:	be d8 00 00 00       	mov    $0xd8,%esi
02e4  232cf84:	ff d3                	call   *%rbx
02e6  232cf86:	85 c0                	test   %eax,%eax
02e8  232cf88:	0f 88 89 0d 00 00    	js     232dd17 <adm1275_probe+0x1077>
02ee  232cf8e:	89 44 24 0c          	mov    %eax,0xc(%rsp)
02f2  232cf92:	49 8d 5e 20          	lea    0x20(%r14),%rbx
02f6  232cf96:	be 18 02 00 00       	mov    $0x218,%esi
02fb  232cf9b:	48 89 df             	mov    %rbx,%rdi
02fe  232cf9e:	ba c0 0d 00 00       	mov    $0xdc0,%edx
0303  232cfa3:	e8 00 00 00 00       	call   232cfa8 <adm1275_probe+0x308>	232cfa4: R_X86_64_PLT32	devm_kmalloc-0x4
0308  232cfa8:	48 85 c0             	test   %rax,%rax
030b  232cfab:	0f 84 8b 00 00 00    	je     232d03c <adm1275_probe+0x39c>
0311  232cfb1:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
0316  232cfb6:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
031b  232cfbb:	49 8d 9e 50 04 00 00 	lea    0x450(%r14),%rbx
0322  232cfc2:	48 89 d8             	mov    %rbx,%rax
0325  232cfc5:	48 c1 e8 03          	shr    $0x3,%rax
0329  232cfc9:	48 b9 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rcx
0333  232cfd3:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
0337  232cfd7:	74 08                	je     232cfe1 <adm1275_probe+0x341>
0339  232cfd9:	48 89 df             	mov    %rbx,%rdi
033c  232cfdc:	e8 00 00 00 00       	call   232cfe1 <adm1275_probe+0x341>	232cfdd: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0341  232cfe1:	48 8b 3b             	mov    (%rbx),%rdi
0344  232cfe4:	48 8d 5c 24 34       	lea    0x34(%rsp),%rbx
0349  232cfe9:	b9 01 00 00 00       	mov    $0x1,%ecx
034e  232cfee:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232cff1: R_X86_64_32S	.rodata+0x857220
0355  232cff5:	48 89 da             	mov    %rbx,%rdx
0358  232cff8:	45 31 c0             	xor    %r8d,%r8d
035b  232cffb:	e8 00 00 00 00       	call   232d000 <adm1275_probe+0x360>	232cffc: R_X86_64_PLT32	of_property_read_variable_u32_array-0x4
0360  232d000:	48 c1 eb 03          	shr    $0x3,%rbx
0364  232d004:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
036e  232d00e:	85 c0                	test   %eax,%eax
0370  232d010:	78 4d                	js     232d05f <adm1275_probe+0x3bf>
0372  232d012:	8a 04 13             	mov    (%rbx,%rdx,1),%al
0375  232d015:	84 c0                	test   %al,%al
0377  232d017:	0f 85 c5 0e 00 00    	jne    232dee2 <adm1275_probe+0x1242>
037d  232d01d:	83 7c 24 34 00       	cmpl   $0x0,0x34(%rsp)
0382  232d022:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
0387  232d027:	75 4e                	jne    232d077 <adm1275_probe+0x3d7>
0389  232d029:	41 bc ea ff ff ff    	mov    $0xffffffea,%r12d
038f  232d02f:	e9 e6 0c 00 00       	jmp    232dd1a <adm1275_probe+0x107a>
0394  232d034:	41 89 cc             	mov    %ecx,%r12d
0397  232d037:	e9 de 0c 00 00       	jmp    232dd1a <adm1275_probe+0x107a>
039c  232d03c:	41 bc f4 ff ff ff    	mov    $0xfffffff4,%r12d
03a2  232d042:	e9 d3 0c 00 00       	jmp    232dd1a <adm1275_probe+0x107a>
03a7  232d047:	49 83 c6 20          	add    $0x20,%r14
03ab  232d04b:	4c 89 f7             	mov    %r14,%rdi
03ae  232d04e:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232d051: R_X86_64_32S	.rodata+0x8570e0
03b5  232d055:	e8 00 00 00 00       	call   232d05a <adm1275_probe+0x3ba>	232d056: R_X86_64_PLT32	_dev_err-0x4
03ba  232d05a:	e9 bb 0c 00 00       	jmp    232dd1a <adm1275_probe+0x107a>
03bf  232d05f:	8a 04 13             	mov    (%rbx,%rdx,1),%al
03c2  232d062:	84 c0                	test   %al,%al
03c4  232d064:	0f 85 97 17 00 00    	jne    232e801 <adm1275_probe+0x1b61>
03ca  232d06a:	c7 44 24 34 e8 03 00 00 	movl   $0x3e8,0x34(%rsp)
03d2  232d072:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
03d7  232d077:	41 80 3c 17 00       	cmpb   $0x0,(%r15,%rdx,1)
03dc  232d07c:	74 17                	je     232d095 <adm1275_probe+0x3f5>
03de  232d07e:	4c 89 ef             	mov    %r13,%rdi
03e1  232d081:	e8 00 00 00 00       	call   232d086 <adm1275_probe+0x3e6>	232d082: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
03e6  232d086:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
03eb  232d08b:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
03f5  232d095:	45 8b 6d 00          	mov    0x0(%r13),%r13d
03f9  232d099:	48 89 f0             	mov    %rsi,%rax
03fc  232d09c:	48 c1 e8 03          	shr    $0x3,%rax
0400  232d0a0:	8a 04 10             	mov    (%rax,%rdx,1),%al
0403  232d0a3:	84 c0                	test   %al,%al
0405  232d0a5:	0f 85 e0 0c 00 00    	jne    232dd8b <adm1275_probe+0x10eb>
040b  232d0ab:	44 89 2e             	mov    %r13d,(%rsi)
040e  232d0ae:	4c 8d 7e 10          	lea    0x10(%rsi),%r15
0412  232d0b2:	4c 89 f8             	mov    %r15,%rax
0415  232d0b5:	48 c1 e8 03          	shr    $0x3,%rax
0419  232d0b9:	8a 04 10             	mov    (%rax,%rdx,1),%al
041c  232d0bc:	84 c0                	test   %al,%al
041e  232d0be:	0f 85 f3 0c 00 00    	jne    232ddb7 <adm1275_probe+0x1117>
0424  232d0c4:	c7 46 10 01 00 00 00 	movl   $0x1,0x10(%rsi)
042b  232d0cb:	48 8d 7e 34          	lea    0x34(%rsi),%rdi
042f  232d0cf:	48 89 f8             	mov    %rdi,%rax
0432  232d0d2:	48 c1 e8 03          	shr    $0x3,%rax
0436  232d0d6:	8a 04 10             	mov    (%rax,%rdx,1),%al
0439  232d0d9:	84 c0                	test   %al,%al
043b  232d0db:	0f 85 03 0d 00 00    	jne    232dde4 <adm1275_probe+0x1144>
0441  232d0e1:	c7 46 34 01 00 00 00 	movl   $0x1,0x34(%rsi)
0448  232d0e8:	48 8d 7e 38          	lea    0x38(%rsi),%rdi
044c  232d0ec:	48 89 f8             	mov    %rdi,%rax
044f  232d0ef:	48 c1 e8 03          	shr    $0x3,%rax
0453  232d0f3:	8a 04 10             	mov    (%rax,%rdx,1),%al
0456  232d0f6:	84 c0                	test   %al,%al
0458  232d0f8:	0f 85 0f 0d 00 00    	jne    232de0d <adm1275_probe+0x116d>
045e  232d0fe:	c7 46 38 01 00 00 00 	movl   $0x1,0x38(%rsi)
0465  232d105:	48 8d 7e 40          	lea    0x40(%rsi),%rdi
0469  232d109:	48 89 f8             	mov    %rdi,%rax
046c  232d10c:	48 c1 e8 03          	shr    $0x3,%rax
0470  232d110:	8a 04 10             	mov    (%rax,%rdx,1),%al
0473  232d113:	84 c0                	test   %al,%al
0475  232d115:	0f 85 1b 0d 00 00    	jne    232de36 <adm1275_probe+0x1196>
047b  232d11b:	c7 46 40 01 00 00 00 	movl   $0x1,0x40(%rsi)
0482  232d122:	48 8d 7e 44          	lea    0x44(%rsi),%rdi
0486  232d126:	48 89 f8             	mov    %rdi,%rax
0489  232d129:	48 c1 e8 03          	shr    $0x3,%rax
048d  232d12d:	8a 04 10             	mov    (%rax,%rdx,1),%al
0490  232d130:	84 c0                	test   %al,%al
0492  232d132:	0f 85 27 0d 00 00    	jne    232de5f <adm1275_probe+0x11bf>
0498  232d138:	c7 46 44 01 00 00 00 	movl   $0x1,0x44(%rsi)
049f  232d13f:	48 8d 7e 48          	lea    0x48(%rsi),%rdi
04a3  232d143:	48 89 f8             	mov    %rdi,%rax
04a6  232d146:	48 c1 e8 03          	shr    $0x3,%rax
04aa  232d14a:	8a 04 10             	mov    (%rax,%rdx,1),%al
04ad  232d14d:	84 c0                	test   %al,%al
04af  232d14f:	0f 85 33 0d 00 00    	jne    232de88 <adm1275_probe+0x11e8>
04b5  232d155:	c7 46 48 01 00 00 00 	movl   $0x1,0x48(%rsi)
04bc  232d15c:	48 8d 8e 34 01 00 00 	lea    0x134(%rsi),%rcx
04c3  232d163:	48 89 c8             	mov    %rcx,%rax
04c6  232d166:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
04cb  232d16b:	48 c1 e9 03          	shr    $0x3,%rcx
04cf  232d16f:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
04d4  232d174:	8a 04 11             	mov    (%rcx,%rdx,1),%al
04d7  232d177:	84 c0                	test   %al,%al
04d9  232d179:	0f 85 32 0d 00 00    	jne    232deb1 <adm1275_probe+0x1211>
04df  232d17f:	c7 86 34 01 00 00 10 20 40 00 	movl   $0x402010,0x134(%rsi)
04e9  232d189:	48 8d be e0 01 00 00 	lea    0x1e0(%rsi),%rdi
04f0  232d190:	48 89 f8             	mov    %rdi,%rax
04f3  232d193:	48 c1 e8 03          	shr    $0x3,%rax
04f7  232d197:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
04fb  232d19b:	74 14                	je     232d1b1 <adm1275_probe+0x511>
04fd  232d19d:	e8 00 00 00 00       	call   232d1a2 <adm1275_probe+0x502>	232d19e: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
0502  232d1a2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
0507  232d1a7:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0511  232d1b1:	48 c7 86 e0 01 00 00 00 00 00 00 	movq   $0x0,0x1e0(%rsi)	232d1b8: R_X86_64_32S	.text+0x232edb0
051c  232d1bc:	48 8d be d8 01 00 00 	lea    0x1d8(%rsi),%rdi
0523  232d1c3:	48 89 f8             	mov    %rdi,%rax
0526  232d1c6:	48 c1 e8 03          	shr    $0x3,%rax
052a  232d1ca:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
052e  232d1ce:	74 14                	je     232d1e4 <adm1275_probe+0x544>
0530  232d1d0:	e8 00 00 00 00       	call   232d1d5 <adm1275_probe+0x535>	232d1d1: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
0535  232d1d5:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
053a  232d1da:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0544  232d1e4:	48 c7 86 d8 01 00 00 00 00 00 00 	movq   $0x0,0x1d8(%rsi)	232d1eb: R_X86_64_32S	.text+0x232f2e0
054f  232d1ef:	48 8d 9e e8 01 00 00 	lea    0x1e8(%rsi),%rbx
0556  232d1f6:	48 89 d8             	mov    %rbx,%rax
0559  232d1f9:	48 c1 e8 03          	shr    $0x3,%rax
055d  232d1fd:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
0561  232d201:	74 17                	je     232d21a <adm1275_probe+0x57a>
0563  232d203:	48 89 df             	mov    %rbx,%rdi
0566  232d206:	e8 00 00 00 00       	call   232d20b <adm1275_probe+0x56b>	232d207: R_X86_64_PLT32	__asan_report_store8_noabort-0x4
056b  232d20b:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
0570  232d210:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
057a  232d21a:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)	232d21d: R_X86_64_32S	.text+0x232f540
0581  232d221:	41 83 fd 06          	cmp    $0x6,%r13d
0585  232d225:	0f 87 0a 0b 00 00    	ja     232dd35 <adm1275_probe+0x1095>
058b  232d22b:	44 89 e8             	mov    %r13d,%eax
058e  232d22e:	4c 89 7c 24 70       	mov    %r15,0x70(%rsp)
0593  232d233:	ff 24 c5 00 00 00 00 	jmp    *0x0(,%rax,8)	232d236: R_X86_64_32S	.rodata+0x856a40
059a  232d23a:	4c 8d 7e 08          	lea    0x8(%rsi),%r15
059e  232d23e:	48 8d 5e 0d          	lea    0xd(%rsi),%rbx
05a2  232d242:	48 89 d8             	mov    %rbx,%rax
05a5  232d245:	48 c1 e8 03          	shr    $0x3,%rax
05a9  232d249:	8a 04 10             	mov    (%rax,%rdx,1),%al
05ac  232d24c:	84 c0                	test   %al,%al
05ae  232d24e:	0f 85 d9 15 00 00    	jne    232e82d <adm1275_probe+0x1b8d>
05b4  232d254:	c6 03 01             	movb   $0x1,(%rbx)
05b7  232d257:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
05bc  232d25c:	41 89 fc             	mov    %edi,%r12d
05bf  232d25f:	44 89 e3             	mov    %r12d,%ebx
05c2  232d262:	83 e3 0c             	and    $0xc,%ebx
05c5  232d265:	4c 89 f8             	mov    %r15,%rax
05c8  232d268:	48 c1 e8 03          	shr    $0x3,%rax
05cc  232d26c:	8a 04 10             	mov    (%rax,%rdx,1),%al
05cf  232d26f:	84 c0                	test   %al,%al
05d1  232d271:	0f 85 df 15 00 00    	jne    232e856 <adm1275_probe+0x1bb6>
05d7  232d277:	41 c7 07 01 01 01 01 	movl   $0x1010101,(%r15)
05de  232d27e:	83 fb 0c             	cmp    $0xc,%ebx
05e1  232d281:	0f 84 a8 02 00 00    	je     232d52f <adm1275_probe+0x88f>
05e7  232d287:	83 fb 08             	cmp    $0x8,%ebx
05ea  232d28a:	0f 84 97 02 00 00    	je     232d527 <adm1275_probe+0x887>
05f0  232d290:	83 fb 04             	cmp    $0x4,%ebx
05f3  232d293:	0f 85 a0 02 00 00    	jne    232d539 <adm1275_probe+0x899>
05f9  232d299:	45 31 ed             	xor    %r13d,%r13d
05fc  232d29c:	e9 94 02 00 00       	jmp    232d535 <adm1275_probe+0x895>
0601  232d2a1:	49 83 c6 20          	add    $0x20,%r14
0605  232d2a5:	4c 89 f7             	mov    %r14,%rdi
0608  232d2a8:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232d2ab: R_X86_64_32S	.rodata+0x857080
060f  232d2af:	eb 10                	jmp    232d2c1 <adm1275_probe+0x621>
0611  232d2b1:	89 c3                	mov    %eax,%ebx
0613  232d2b3:	49 83 c6 20          	add    $0x20,%r14
0617  232d2b7:	4c 89 f7             	mov    %r14,%rdi
061a  232d2ba:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232d2bd: R_X86_64_32S	.rodata+0x857120
0621  232d2c1:	e8 00 00 00 00       	call   232d2c6 <adm1275_probe+0x626>	232d2c2: R_X86_64_PLT32	_dev_err-0x4
0626  232d2c6:	41 89 dc             	mov    %ebx,%r12d
0629  232d2c9:	e9 4c 0a 00 00       	jmp    232dd1a <adm1275_probe+0x107a>
062e  232d2ce:	49 8d 7e 20          	lea    0x20(%r14),%rdi
0632  232d2d2:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232d2d5: R_X86_64_32S	.rodata+0x8571c0
0639  232d2d9:	48 89 da             	mov    %rbx,%rdx
063c  232d2dc:	4c 89 e9             	mov    %r13,%rcx
063f  232d2df:	e8 00 00 00 00       	call   232d2e4 <adm1275_probe+0x644>	232d2e0: R_X86_64_PLT32	_dev_notice-0x4
0644  232d2e4:	e9 13 fc ff ff       	jmp    232cefc <adm1275_probe+0x25c>
0649  232d2e9:	48 8d 7e 06          	lea    0x6(%rsi),%rdi
064d  232d2ed:	48 89 f8             	mov    %rdi,%rax
0650  232d2f0:	48 c1 e8 03          	shr    $0x3,%rax
0654  232d2f4:	8a 04 10             	mov    (%rax,%rdx,1),%al
0657  232d2f7:	84 c0                	test   %al,%al
0659  232d2f9:	0f 85 59 16 00 00    	jne    232e958 <adm1275_probe+0x1cb8>
065f  232d2ff:	c6 46 06 01          	movb   $0x1,0x6(%rsi)
0663  232d303:	48 8d 7e 0b          	lea    0xb(%rsi),%rdi
0667  232d307:	48 89 f8             	mov    %rdi,%rax
066a  232d30a:	48 c1 e8 03          	shr    $0x3,%rax
066e  232d30e:	8a 04 10             	mov    (%rax,%rdx,1),%al
0671  232d311:	84 c0                	test   %al,%al
0673  232d313:	0f 85 65 16 00 00    	jne    232e97e <adm1275_probe+0x1cde>
0679  232d319:	c6 46 0b 01          	movb   $0x1,0xb(%rsi)
067d  232d31d:	48 8d 7e 0c          	lea    0xc(%rsi),%rdi
0681  232d321:	48 89 f8             	mov    %rdi,%rax
0684  232d324:	48 c1 e8 03          	shr    $0x3,%rax
0688  232d328:	8a 04 10             	mov    (%rax,%rdx,1),%al
068b  232d32b:	84 c0                	test   %al,%al
068d  232d32d:	0f 85 71 16 00 00    	jne    232e9a4 <adm1275_probe+0x1d04>
0693  232d333:	c6 46 0c 01          	movb   $0x1,0xc(%rsi)
0697  232d337:	48 8d 5e 0d          	lea    0xd(%rsi),%rbx
069b  232d33b:	48 89 d8             	mov    %rbx,%rax
069e  232d33e:	48 c1 e8 03          	shr    $0x3,%rax
06a2  232d342:	8a 04 10             	mov    (%rax,%rdx,1),%al
06a5  232d345:	84 c0                	test   %al,%al
06a7  232d347:	0f 85 7d 16 00 00    	jne    232e9ca <adm1275_probe+0x1d2a>
06ad  232d34d:	c6 03 01             	movb   $0x1,(%rbx)
06b0  232d350:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
06b5  232d355:	8a 04 10             	mov    (%rax,%rdx,1),%al
06b8  232d358:	84 c0                	test   %al,%al
06ba  232d35a:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
06bf  232d35f:	0f 85 8e 16 00 00    	jne    232e9f3 <adm1275_probe+0x1d53>
06c5  232d365:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
06ca  232d36a:	c7 00 34 f2 40 00    	movl   $0x40f234,(%rax)
06d0  232d370:	89 f8                	mov    %edi,%eax
06d2  232d372:	f7 d0                	not    %eax
06d4  232d374:	a8 0a                	test   $0xa,%al
06d6  232d376:	74 34                	je     232d3ac <adm1275_probe+0x70c>
06d8  232d378:	83 cf 0a             	or     $0xa,%edi
06db  232d37b:	40 0f b6 d7          	movzbl %dil,%edx
06df  232d37f:	48 89 fb             	mov    %rdi,%rbx
06e2  232d382:	4c 89 f7             	mov    %r14,%rdi
06e5  232d385:	be d4 00 00 00       	mov    $0xd4,%esi
06ea  232d38a:	e8 00 00 00 00       	call   232d38f <adm1275_probe+0x6ef>	232d38b: R_X86_64_PLT32	i2c_smbus_write_byte_data-0x4
06ef  232d38f:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
06f4  232d394:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
06fe  232d39e:	89 d9                	mov    %ebx,%ecx
0700  232d3a0:	89 5c 24 08          	mov    %ebx,0x8(%rsp)
0704  232d3a4:	85 c0                	test   %eax,%eax
0706  232d3a6:	0f 88 9c 09 00 00    	js     232dd48 <adm1275_probe+0x10a8>
070c  232d3ac:	f6 44 24 08 04       	testb  $0x4,0x8(%rsp)
0711  232d3b1:	0f 85 dc 03 00 00    	jne    232d793 <adm1275_probe+0xaf3>
0717  232d3b7:	41 b9 03 00 00 00    	mov    $0x3,%r9d
071d  232d3bd:	41 b2 01             	mov    $0x1,%r10b
0720  232d3c0:	41 b8 02 00 00 00    	mov    $0x2,%r8d
0726  232d3c6:	bf 01 00 00 00       	mov    $0x1,%edi
072b  232d3cb:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d3ce: R_X86_64_32S	.rodata+0x857420
0732  232d3d2:	45 31 db             	xor    %r11d,%r11d
0735  232d3d5:	45 31 ed             	xor    %r13d,%r13d
0738  232d3d8:	e9 53 05 00 00       	jmp    232d930 <adm1275_probe+0xc90>
073d  232d3dd:	f6 44 24 0c 10       	testb  $0x10,0xc(%rsp)
0742  232d3e2:	0f 85 c0 01 00 00    	jne    232d5a8 <adm1275_probe+0x908>
0748  232d3e8:	48 8d 5e 05          	lea    0x5(%rsi),%rbx
074c  232d3ec:	48 89 d8             	mov    %rbx,%rax
074f  232d3ef:	48 c1 e8 03          	shr    $0x3,%rax
0753  232d3f3:	8a 04 10             	mov    (%rax,%rdx,1),%al
0756  232d3f6:	84 c0                	test   %al,%al
0758  232d3f8:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
075d  232d3fd:	8b 7c 24 08          	mov    0x8(%rsp),%edi
0761  232d401:	0f 84 c0 01 00 00    	je     232d5c7 <adm1275_probe+0x927>
0767  232d407:	89 d9                	mov    %ebx,%ecx
0769  232d409:	80 e1 07             	and    $0x7,%cl
076c  232d40c:	38 c1                	cmp    %al,%cl
076e  232d40e:	0f 8c b3 01 00 00    	jl     232d5c7 <adm1275_probe+0x927>
0774  232d414:	48 89 df             	mov    %rbx,%rdi
0777  232d417:	e8 00 00 00 00       	call   232d41c <adm1275_probe+0x77c>	232d418: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
077c  232d41c:	e9 5c 18 00 00       	jmp    232ec7d <adm1275_probe+0x1fdd>
0781  232d421:	f6 44 24 0c 10       	testb  $0x10,0xc(%rsp)
0786  232d426:	0f 85 03 02 00 00    	jne    232d62f <adm1275_probe+0x98f>
078c  232d42c:	48 8d 5e 05          	lea    0x5(%rsi),%rbx
0790  232d430:	48 89 d8             	mov    %rbx,%rax
0793  232d433:	48 c1 e8 03          	shr    $0x3,%rax
0797  232d437:	8a 04 10             	mov    (%rax,%rdx,1),%al
079a  232d43a:	84 c0                	test   %al,%al
079c  232d43c:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
07a1  232d441:	0f 84 03 02 00 00    	je     232d64a <adm1275_probe+0x9aa>
07a7  232d447:	89 d9                	mov    %ebx,%ecx
07a9  232d449:	80 e1 07             	and    $0x7,%cl
07ac  232d44c:	38 c1                	cmp    %al,%cl
07ae  232d44e:	0f 8c f6 01 00 00    	jl     232d64a <adm1275_probe+0x9aa>
07b4  232d454:	48 89 df             	mov    %rbx,%rdi
07b7  232d457:	e8 00 00 00 00       	call   232d45c <adm1275_probe+0x7bc>	232d458: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
07bc  232d45c:	e9 49 18 00 00       	jmp    232ecaa <adm1275_probe+0x200a>
07c1  232d461:	f6 44 24 0c 10       	testb  $0x10,0xc(%rsp)
07c6  232d466:	0f 85 af 02 00 00    	jne    232d71b <adm1275_probe+0xa7b>
07cc  232d46c:	48 8d 5e 05          	lea    0x5(%rsi),%rbx
07d0  232d470:	48 89 d8             	mov    %rbx,%rax
07d3  232d473:	48 c1 e8 03          	shr    $0x3,%rax
07d7  232d477:	8a 04 10             	mov    (%rax,%rdx,1),%al
07da  232d47a:	84 c0                	test   %al,%al
07dc  232d47c:	0f 84 af 02 00 00    	je     232d731 <adm1275_probe+0xa91>
07e2  232d482:	89 d9                	mov    %ebx,%ecx
07e4  232d484:	80 e1 07             	and    $0x7,%cl
07e7  232d487:	38 c1                	cmp    %al,%cl
07e9  232d489:	0f 8c a2 02 00 00    	jl     232d731 <adm1275_probe+0xa91>
07ef  232d48f:	48 89 df             	mov    %rbx,%rdi
07f2  232d492:	e8 00 00 00 00       	call   232d497 <adm1275_probe+0x7f7>	232d493: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
07f7  232d497:	e9 37 18 00 00       	jmp    232ecd3 <adm1275_probe+0x2033>
07fc  232d49c:	48 8d 7e 06          	lea    0x6(%rsi),%rdi
0800  232d4a0:	48 89 f8             	mov    %rdi,%rax
0803  232d4a3:	48 c1 e8 03          	shr    $0x3,%rax
0807  232d4a7:	8a 04 10             	mov    (%rax,%rdx,1),%al
080a  232d4aa:	84 c0                	test   %al,%al
080c  232d4ac:	0f 85 77 15 00 00    	jne    232ea29 <adm1275_probe+0x1d89>
0812  232d4b2:	c6 46 06 01          	movb   $0x1,0x6(%rsi)
0816  232d4b6:	48 8d 7e 0b          	lea    0xb(%rsi),%rdi
081a  232d4ba:	48 89 f8             	mov    %rdi,%rax
081d  232d4bd:	48 c1 e8 03          	shr    $0x3,%rax
0821  232d4c1:	8a 04 10             	mov    (%rax,%rdx,1),%al
0824  232d4c4:	84 c0                	test   %al,%al
0826  232d4c6:	0f 85 83 15 00 00    	jne    232ea4f <adm1275_probe+0x1daf>
082c  232d4cc:	c6 46 0b 01          	movb   $0x1,0xb(%rsi)
0830  232d4d0:	48 8d 7e 0c          	lea    0xc(%rsi),%rdi
0834  232d4d4:	48 89 f8             	mov    %rdi,%rax
0837  232d4d7:	48 c1 e8 03          	shr    $0x3,%rax
083b  232d4db:	8a 04 10             	mov    (%rax,%rdx,1),%al
083e  232d4de:	84 c0                	test   %al,%al
0840  232d4e0:	0f 85 8f 15 00 00    	jne    232ea75 <adm1275_probe+0x1dd5>
0846  232d4e6:	c6 46 0c 01          	movb   $0x1,0xc(%rsi)
084a  232d4ea:	48 8d 5e 0d          	lea    0xd(%rsi),%rbx
084e  232d4ee:	48 89 d8             	mov    %rbx,%rax
0851  232d4f1:	48 c1 e8 03          	shr    $0x3,%rax
0855  232d4f5:	8a 04 10             	mov    (%rax,%rdx,1),%al
0858  232d4f8:	84 c0                	test   %al,%al
085a  232d4fa:	0f 85 9b 15 00 00    	jne    232ea9b <adm1275_probe+0x1dfb>
0860  232d500:	c6 03 01             	movb   $0x1,(%rbx)
0863  232d503:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
0868  232d508:	89 fb                	mov    %edi,%ebx
086a  232d50a:	89 d8                	mov    %ebx,%eax
086c  232d50c:	83 e0 21             	and    $0x21,%eax
086f  232d50f:	41 b8 04 00 00 00    	mov    $0x4,%r8d
0875  232d515:	ff 24 c5 00 00 00 00 	jmp    *0x0(,%rax,8)	232d518: R_X86_64_32S	.rodata+0x856a78
087c  232d51c:	41 b8 06 00 00 00    	mov    $0x6,%r8d
0882  232d522:	e9 24 03 00 00       	jmp    232d84b <adm1275_probe+0xbab>
0887  232d527:	41 bd 01 00 00 00    	mov    $0x1,%r13d
088d  232d52d:	eb 06                	jmp    232d535 <adm1275_probe+0x895>
088f  232d52f:	41 bd 02 00 00 00    	mov    $0x2,%r13d
0895  232d535:	b0 01                	mov    $0x1,%al
0897  232d537:	eb 08                	jmp    232d541 <adm1275_probe+0x8a1>
0899  232d539:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
089f  232d53f:	31 c0                	xor    %eax,%eax
08a1  232d541:	c1 ef 06             	shr    $0x6,%edi
08a4  232d544:	83 e7 03             	and    $0x3,%edi
08a7  232d547:	42 8d 0c af          	lea    (%rdi,%r13,4),%ecx
08ab  232d54b:	83 c1 07             	add    $0x7,%ecx
08ae  232d54e:	84 c0                	test   %al,%al
08b0  232d550:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
08b6  232d556:	44 0f 45 c1          	cmovne %ecx,%r8d
08ba  232d55a:	41 f6 c4 02          	test   $0x2,%r12b
08be  232d55e:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
08c3  232d563:	74 18                	je     232d57d <adm1275_probe+0x8dd>
08c5  232d565:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
08ca  232d56a:	8a 04 10             	mov    (%rax,%rdx,1),%al
08cd  232d56d:	84 c0                	test   %al,%al
08cf  232d56f:	0f 85 aa 13 00 00    	jne    232e91f <adm1275_probe+0x1c7f>
08d5  232d575:	41 c7 04 24 14 30 40 00 	movl   $0x403014,(%r12)
08dd  232d57d:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
08e2  232d582:	8a 04 10             	mov    (%rax,%rdx,1),%al
08e5  232d585:	84 c0                	test   %al,%al
08e7  232d587:	0f 85 fb 12 00 00    	jne    232e888 <adm1275_probe+0x1be8>
08ed  232d58d:	83 c7 03             	add    $0x3,%edi
08f0  232d590:	bb 21 40 00 00       	mov    $0x4021,%ebx
08f5  232d595:	41 0b 1c 24          	or     (%r12),%ebx
08f9  232d599:	45 31 db             	xor    %r11d,%r11d
08fc  232d59c:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d59f: R_X86_64_32S	.rodata+0x857460
0903  232d5a3:	e9 47 01 00 00       	jmp    232d6ef <adm1275_probe+0xa4f>
0908  232d5a8:	48 8d 5e 04          	lea    0x4(%rsi),%rbx
090c  232d5ac:	48 89 d8             	mov    %rbx,%rax
090f  232d5af:	48 c1 e8 03          	shr    $0x3,%rax
0913  232d5b3:	8a 04 10             	mov    (%rax,%rdx,1),%al
0916  232d5b6:	84 c0                	test   %al,%al
0918  232d5b8:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
091d  232d5bd:	8b 7c 24 08          	mov    0x8(%rsp),%edi
0921  232d5c1:	0f 85 a1 16 00 00    	jne    232ec68 <adm1275_probe+0x1fc8>
0927  232d5c7:	c6 03 01             	movb   $0x1,(%rbx)
092a  232d5ca:	48 8d 5e 06          	lea    0x6(%rsi),%rbx
092e  232d5ce:	48 89 d8             	mov    %rbx,%rax
0931  232d5d1:	48 c1 e8 03          	shr    $0x3,%rax
0935  232d5d5:	8a 04 10             	mov    (%rax,%rdx,1),%al
0938  232d5d8:	84 c0                	test   %al,%al
093a  232d5da:	0f 85 e4 14 00 00    	jne    232eac4 <adm1275_probe+0x1e24>
0940  232d5e0:	c6 03 01             	movb   $0x1,(%rbx)
0943  232d5e3:	45 31 ed             	xor    %r13d,%r13d
0946  232d5e6:	40 f6 c7 20          	test   $0x20,%dil
094a  232d5ea:	0f 94 c3             	sete   %bl
094d  232d5ed:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0952  232d5f2:	8a 04 10             	mov    (%rax,%rdx,1),%al
0955  232d5f5:	84 c0                	test   %al,%al
0957  232d5f7:	0f 85 f4 14 00 00    	jne    232eaf1 <adm1275_probe+0x1e51>
095d  232d5fd:	41 88 dd             	mov    %bl,%r13b
0960  232d600:	41 8b 1c 24          	mov    (%r12),%ebx
0964  232d604:	40 f6 c7 40          	test   $0x40,%dil
0968  232d608:	75 08                	jne    232d612 <adm1275_probe+0x972>
096a  232d60a:	81 cb 01 40 00 00    	or     $0x4001,%ebx
0970  232d610:	eb 06                	jmp    232d618 <adm1275_probe+0x978>
0972  232d612:	81 cb 04 10 00 00    	or     $0x1004,%ebx
0978  232d618:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d61b: R_X86_64_32S	.rodata+0x8573a0
097f  232d61f:	bf 02 00 00 00       	mov    $0x2,%edi
0984  232d624:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
098a  232d62a:	e9 bd 00 00 00       	jmp    232d6ec <adm1275_probe+0xa4c>
098f  232d62f:	48 8d 5e 04          	lea    0x4(%rsi),%rbx
0993  232d633:	48 89 d8             	mov    %rbx,%rax
0996  232d636:	48 c1 e8 03          	shr    $0x3,%rax
099a  232d63a:	8a 04 10             	mov    (%rax,%rdx,1),%al
099d  232d63d:	84 c0                	test   %al,%al
099f  232d63f:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
09a4  232d644:	0f 85 4b 16 00 00    	jne    232ec95 <adm1275_probe+0x1ff5>
09aa  232d64a:	c6 03 01             	movb   $0x1,(%rbx)
09ad  232d64d:	48 8d 7e 06          	lea    0x6(%rsi),%rdi
09b1  232d651:	48 89 f8             	mov    %rdi,%rax
09b4  232d654:	48 c1 e8 03          	shr    $0x3,%rax
09b8  232d658:	8a 04 10             	mov    (%rax,%rdx,1),%al
09bb  232d65b:	84 c0                	test   %al,%al
09bd  232d65d:	0f 85 bf 14 00 00    	jne    232eb22 <adm1275_probe+0x1e82>
09c3  232d663:	c6 46 06 01          	movb   $0x1,0x6(%rsi)
09c7  232d667:	48 8d 5e 0b          	lea    0xb(%rsi),%rbx
09cb  232d66b:	48 89 d8             	mov    %rbx,%rax
09ce  232d66e:	48 c1 e8 03          	shr    $0x3,%rax
09d2  232d672:	8a 04 10             	mov    (%rax,%rdx,1),%al
09d5  232d675:	84 c0                	test   %al,%al
09d7  232d677:	0f 85 cb 14 00 00    	jne    232eb48 <adm1275_probe+0x1ea8>
09dd  232d67d:	c6 03 01             	movb   $0x1,(%rbx)
09e0  232d680:	44 8b 7c 24 28       	mov    0x28(%rsp),%r15d
09e5  232d685:	44 89 f8             	mov    %r15d,%eax
09e8  232d688:	83 e0 20             	and    $0x20,%eax
09eb  232d68b:	49 89 c5             	mov    %rax,%r13
09ee  232d68e:	49 c1 ed 05          	shr    $0x5,%r13
09f2  232d692:	48 83 f8 01          	cmp    $0x1,%rax
09f6  232d696:	41 b8 03 00 00 00    	mov    $0x3,%r8d
09fc  232d69c:	41 83 d0 00          	adc    $0x0,%r8d
0a00  232d6a0:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0a05  232d6a5:	8a 04 10             	mov    (%rax,%rdx,1),%al
0a08  232d6a8:	84 c0                	test   %al,%al
0a0a  232d6aa:	0f 85 c1 14 00 00    	jne    232eb71 <adm1275_probe+0x1ed1>
0a10  232d6b0:	41 83 f5 01          	xor    $0x1,%r13d
0a14  232d6b4:	41 8b 1c 24          	mov    (%r12),%ebx
0a18  232d6b8:	89 d8                	mov    %ebx,%eax
0a1a  232d6ba:	0d 21 40 00 00       	or     $0x4021,%eax
0a1f  232d6bf:	41 89 04 24          	mov    %eax,(%r12)
0a23  232d6c3:	41 f6 c7 40          	test   $0x40,%r15b
0a27  232d6c7:	75 11                	jne    232d6da <adm1275_probe+0xa3a>
0a29  232d6c9:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d6cc: R_X86_64_32S	.rodata+0x8573e0
0a30  232d6d0:	bf 02 00 00 00       	mov    $0x2,%edi
0a35  232d6d5:	45 89 eb             	mov    %r13d,%r11d
0a38  232d6d8:	eb 29                	jmp    232d703 <adm1275_probe+0xa63>
0a3a  232d6da:	81 cb 25 50 00 00    	or     $0x5025,%ebx
0a40  232d6e0:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d6e3: R_X86_64_32S	.rodata+0x8573e0
0a47  232d6e7:	bf 02 00 00 00       	mov    $0x2,%edi
0a4c  232d6ec:	45 89 eb             	mov    %r13d,%r11d
0a4f  232d6ef:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0a54  232d6f4:	8a 04 10             	mov    (%rax,%rdx,1),%al
0a57  232d6f7:	84 c0                	test   %al,%al
0a59  232d6f9:	0f 85 b5 0f 00 00    	jne    232e6b4 <adm1275_probe+0x1a14>
0a5f  232d6ff:	41 89 1c 24          	mov    %ebx,(%r12)
0a63  232d703:	49 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%r9
0a6a  232d70a:	45 31 d2             	xor    %r10d,%r10d
0a6d  232d70d:	45 85 ed             	test   %r13d,%r13d
0a70  232d710:	0f 89 1a 02 00 00    	jns    232d930 <adm1275_probe+0xc90>
0a76  232d716:	e9 c6 02 00 00       	jmp    232d9e1 <adm1275_probe+0xd41>
0a7b  232d71b:	48 8d 5e 04          	lea    0x4(%rsi),%rbx
0a7f  232d71f:	48 89 d8             	mov    %rbx,%rax
0a82  232d722:	48 c1 e8 03          	shr    $0x3,%rax
0a86  232d726:	8a 04 10             	mov    (%rax,%rdx,1),%al
0a89  232d729:	84 c0                	test   %al,%al
0a8b  232d72b:	0f 85 8d 15 00 00    	jne    232ecbe <adm1275_probe+0x201e>
0a91  232d731:	c6 03 01             	movb   $0x1,(%rbx)
0a94  232d734:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
0a99  232d739:	48 8d 7e 0b          	lea    0xb(%rsi),%rdi
0a9d  232d73d:	48 89 f8             	mov    %rdi,%rax
0aa0  232d740:	48 c1 e8 03          	shr    $0x3,%rax
0aa4  232d744:	8a 04 10             	mov    (%rax,%rdx,1),%al
0aa7  232d747:	84 c0                	test   %al,%al
0aa9  232d749:	0f 85 55 14 00 00    	jne    232eba4 <adm1275_probe+0x1f04>
0aaf  232d74f:	c6 46 0b 01          	movb   $0x1,0xb(%rsi)
0ab3  232d753:	48 8d 5e 07          	lea    0x7(%rsi),%rbx
0ab7  232d757:	48 89 d8             	mov    %rbx,%rax
0aba  232d75a:	48 c1 e8 03          	shr    $0x3,%rax
0abe  232d75e:	8a 04 10             	mov    (%rax,%rdx,1),%al
0ac1  232d761:	84 c0                	test   %al,%al
0ac3  232d763:	0f 85 61 14 00 00    	jne    232ebca <adm1275_probe+0x1f2a>
0ac9  232d769:	c6 03 01             	movb   $0x1,(%rbx)
0acc  232d76c:	44 8b 7c 24 28       	mov    0x28(%rsp),%r15d
0ad1  232d771:	44 89 f8             	mov    %r15d,%eax
0ad4  232d774:	83 e0 18             	and    $0x18,%eax
0ad7  232d777:	48 83 f8 08          	cmp    $0x8,%rax
0adb  232d77b:	74 55                	je     232d7d2 <adm1275_probe+0xb32>
0add  232d77d:	83 f8 10             	cmp    $0x10,%eax
0ae0  232d780:	0f 85 d5 05 00 00    	jne    232dd5b <adm1275_probe+0x10bb>
0ae6  232d786:	41 b8 04 00 00 00    	mov    $0x4,%r8d
0aec  232d78c:	bf 02 00 00 00       	mov    $0x2,%edi
0af1  232d791:	eb 4a                	jmp    232d7dd <adm1275_probe+0xb3d>
0af3  232d793:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0af8  232d798:	8a 04 10             	mov    (%rax,%rdx,1),%al
0afb  232d79b:	84 c0                	test   %al,%al
0afd  232d79d:	0f 85 44 15 00 00    	jne    232ece7 <adm1275_probe+0x2047>
0b03  232d7a3:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
0b08  232d7a8:	41 8b 1c 24          	mov    (%r12),%ebx
0b0c  232d7ac:	83 cb 01             	or     $0x1,%ebx
0b0f  232d7af:	41 b9 03 00 00 00    	mov    $0x3,%r9d
0b15  232d7b5:	41 b2 01             	mov    $0x1,%r10b
0b18  232d7b8:	41 b8 02 00 00 00    	mov    $0x2,%r8d
0b1e  232d7be:	bf 01 00 00 00       	mov    $0x1,%edi
0b23  232d7c3:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d7c6: R_X86_64_32S	.rodata+0x857420
0b2a  232d7ca:	45 31 db             	xor    %r11d,%r11d
0b2d  232d7cd:	e9 47 01 00 00       	jmp    232d919 <adm1275_probe+0xc79>
0b32  232d7d2:	41 b8 03 00 00 00    	mov    $0x3,%r8d
0b38  232d7d8:	bf 01 00 00 00       	mov    $0x1,%edi
0b3d  232d7dd:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0b42  232d7e2:	8a 04 10             	mov    (%rax,%rdx,1),%al
0b45  232d7e5:	84 c0                	test   %al,%al
0b47  232d7e7:	0f 85 06 14 00 00    	jne    232ebf3 <adm1275_probe+0x1f53>
0b4d  232d7ed:	41 8b 1c 24          	mov    (%r12),%ebx
0b51  232d7f1:	89 d8                	mov    %ebx,%eax
0b53  232d7f3:	0d 21 40 00 00       	or     $0x4021,%eax
0b58  232d7f8:	41 89 04 24          	mov    %eax,(%r12)
0b5c  232d7fc:	41 f6 c7 40          	test   $0x40,%r15b
0b60  232d800:	75 1c                	jne    232d81e <adm1275_probe+0xb7e>
0b62  232d802:	49 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%r9
0b69  232d809:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d80c: R_X86_64_32S	.rodata+0x857260
0b70  232d810:	45 31 db             	xor    %r11d,%r11d
0b73  232d813:	45 31 ed             	xor    %r13d,%r13d
0b76  232d816:	45 31 d2             	xor    %r10d,%r10d
0b79  232d819:	e9 12 01 00 00       	jmp    232d930 <adm1275_probe+0xc90>
0b7e  232d81e:	81 cb 25 50 00 00    	or     $0x5025,%ebx
0b84  232d824:	49 c7 c1 ff ff ff ff 	mov    $0xffffffffffffffff,%r9
0b8b  232d82b:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d82e: R_X86_64_32S	.rodata+0x857260
0b92  232d832:	45 31 db             	xor    %r11d,%r11d
0b95  232d835:	45 31 d2             	xor    %r10d,%r10d
0b98  232d838:	e9 dc 00 00 00       	jmp    232d919 <adm1275_probe+0xc79>
0b9d  232d83d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
0ba3  232d843:	eb 06                	jmp    232d84b <adm1275_probe+0xbab>
0ba5  232d845:	41 b8 05 00 00 00    	mov    $0x5,%r8d
0bab  232d84b:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0bb0  232d850:	8a 04 10             	mov    (%rax,%rdx,1),%al
0bb3  232d853:	84 c0                	test   %al,%al
0bb5  232d855:	0f 85 d1 13 00 00    	jne    232ec2c <adm1275_probe+0x1f8c>
0bbb  232d85b:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
0bc0  232d860:	c7 00 34 70 40 00    	movl   $0x407034,(%rax)
0bc6  232d866:	f6 c3 02             	test   $0x2,%bl
0bc9  232d869:	75 3b                	jne    232d8a6 <adm1275_probe+0xc06>
0bcb  232d86b:	89 f8                	mov    %edi,%eax
0bcd  232d86d:	83 c8 02             	or     $0x2,%eax
0bd0  232d870:	89 44 24 08          	mov    %eax,0x8(%rsp)
0bd4  232d874:	0f b6 d0             	movzbl %al,%edx
0bd7  232d877:	4c 89 f7             	mov    %r14,%rdi
0bda  232d87a:	be d4 00 00 00       	mov    $0xd4,%esi
0bdf  232d87f:	44 89 c3             	mov    %r8d,%ebx
0be2  232d882:	e8 00 00 00 00       	call   232d887 <adm1275_probe+0xbe7>	232d883: R_X86_64_PLT32	i2c_smbus_write_byte_data-0x4
0be7  232d887:	41 89 d8             	mov    %ebx,%r8d
0bea  232d88a:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
0bef  232d88f:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
0bf4  232d894:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0bfe  232d89e:	85 c0                	test   %eax,%eax
0c00  232d8a0:	0f 88 a2 04 00 00    	js     232dd48 <adm1275_probe+0x10a8>
0c06  232d8a6:	41 89 fb             	mov    %edi,%r11d
0c09  232d8a9:	41 c1 eb 05          	shr    $0x5,%r11d
0c0d  232d8ad:	83 e7 01             	and    $0x1,%edi
0c10  232d8b0:	8b 5c 24 08          	mov    0x8(%rsp),%ebx
0c14  232d8b4:	f6 c3 08             	test   $0x8,%bl
0c17  232d8b7:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
0c1c  232d8bc:	74 16                	je     232d8d4 <adm1275_probe+0xc34>
0c1e  232d8be:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0c23  232d8c3:	8a 04 10             	mov    (%rax,%rdx,1),%al
0c26  232d8c6:	84 c0                	test   %al,%al
0c28  232d8c8:	0f 85 4a 14 00 00    	jne    232ed18 <adm1275_probe+0x2078>
0c2e  232d8ce:	41 80 4c 24 01 82    	orb    $0x82,0x1(%r12)
0c34  232d8d4:	41 83 e3 01          	and    $0x1,%r11d
0c38  232d8d8:	83 cf 02             	or     $0x2,%edi
0c3b  232d8db:	f6 c3 04             	test   $0x4,%bl
0c3e  232d8de:	75 12                	jne    232d8f2 <adm1275_probe+0xc52>
0c40  232d8e0:	41 b9 08 00 00 00    	mov    $0x8,%r9d
0c46  232d8e6:	41 b2 01             	mov    $0x1,%r10b
0c49  232d8e9:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d8ec: R_X86_64_32S	.rodata+0x8572e0
0c50  232d8f0:	eb 3b                	jmp    232d92d <adm1275_probe+0xc8d>
0c52  232d8f2:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0c57  232d8f7:	8a 04 10             	mov    (%rax,%rdx,1),%al
0c5a  232d8fa:	84 c0                	test   %al,%al
0c5c  232d8fc:	0f 85 60 14 00 00    	jne    232ed62 <adm1275_probe+0x20c2>
0c62  232d902:	41 8b 1c 24          	mov    (%r12),%ebx
0c66  232d906:	83 cb 01             	or     $0x1,%ebx
0c69  232d909:	41 b9 08 00 00 00    	mov    $0x8,%r9d
0c6f  232d90f:	41 b2 01             	mov    $0x1,%r10b
0c72  232d912:	49 c7 c7 00 00 00 00 	mov    $0x0,%r15	232d915: R_X86_64_32S	.rodata+0x8572e0
0c79  232d919:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0c7e  232d91e:	8a 04 10             	mov    (%rax,%rdx,1),%al
0c81  232d921:	84 c0                	test   %al,%al
0c83  232d923:	0f 85 98 0f 00 00    	jne    232e8c1 <adm1275_probe+0x1c21>
0c89  232d929:	41 89 1c 24          	mov    %ebx,(%r12)
0c8d  232d92d:	45 89 dd             	mov    %r11d,%r13d
0c90  232d930:	44 89 e8             	mov    %r13d,%eax
0c93  232d933:	4c 8d 2c 40          	lea    (%rax,%rax,2),%r13
0c97  232d937:	4b 8d 1c 6f          	lea    (%r15,%r13,2),%rbx
0c9b  232d93b:	48 89 d8             	mov    %rbx,%rax
0c9e  232d93e:	48 c1 e8 03          	shr    $0x3,%rax
0ca2  232d942:	8a 04 10             	mov    (%rax,%rdx,1),%al
0ca5  232d945:	84 c0                	test   %al,%al
0ca7  232d947:	0f 85 c1 05 00 00    	jne    232df0e <adm1275_probe+0x126e>
0cad  232d94d:	44 0f bf 23          	movswl (%rbx),%r12d
0cb1  232d951:	48 8d 9e d4 00 00 00 	lea    0xd4(%rsi),%rbx
0cb8  232d958:	48 89 d8             	mov    %rbx,%rax
0cbb  232d95b:	48 c1 e8 03          	shr    $0x3,%rax
0cbf  232d95f:	8a 04 10             	mov    (%rax,%rdx,1),%al
0cc2  232d962:	84 c0                	test   %al,%al
0cc4  232d964:	0f 85 fe 05 00 00    	jne    232df68 <adm1275_probe+0x12c8>
0cca  232d96a:	44 89 23             	mov    %r12d,(%rbx)
0ccd  232d96d:	4b 8d 1c 6f          	lea    (%r15,%r13,2),%rbx
0cd1  232d971:	48 83 c3 02          	add    $0x2,%rbx
0cd5  232d975:	48 89 d8             	mov    %rbx,%rax
0cd8  232d978:	48 c1 e8 03          	shr    $0x3,%rax
0cdc  232d97c:	8a 04 10             	mov    (%rax,%rdx,1),%al
0cdf  232d97f:	84 c0                	test   %al,%al
0ce1  232d981:	0f 85 3f 06 00 00    	jne    232dfc6 <adm1275_probe+0x1326>
0ce7  232d987:	44 0f bf 23          	movswl (%rbx),%r12d
0ceb  232d98b:	48 8d 9e f4 00 00 00 	lea    0xf4(%rsi),%rbx
0cf2  232d992:	48 89 d8             	mov    %rbx,%rax
0cf5  232d995:	48 c1 e8 03          	shr    $0x3,%rax
0cf9  232d999:	8a 04 10             	mov    (%rax,%rdx,1),%al
0cfc  232d99c:	84 c0                	test   %al,%al
0cfe  232d99e:	0f 85 7c 06 00 00    	jne    232e020 <adm1275_probe+0x1380>
0d04  232d9a4:	44 89 23             	mov    %r12d,(%rbx)
0d07  232d9a7:	4b 8d 1c 6f          	lea    (%r15,%r13,2),%rbx
0d0b  232d9ab:	48 83 c3 04          	add    $0x4,%rbx
0d0f  232d9af:	48 89 d8             	mov    %rbx,%rax
0d12  232d9b2:	48 c1 e8 03          	shr    $0x3,%rax
0d16  232d9b6:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d19  232d9b9:	84 c0                	test   %al,%al
0d1b  232d9bb:	0f 85 bd 06 00 00    	jne    232e07e <adm1275_probe+0x13de>
0d21  232d9c1:	44 0f bf 23          	movswl (%rbx),%r12d
0d25  232d9c5:	48 8d 9e 14 01 00 00 	lea    0x114(%rsi),%rbx
0d2c  232d9cc:	48 89 d8             	mov    %rbx,%rax
0d2f  232d9cf:	48 c1 e8 03          	shr    $0x3,%rax
0d33  232d9d3:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d36  232d9d6:	84 c0                	test   %al,%al
0d38  232d9d8:	0f 85 f6 06 00 00    	jne    232e0d4 <adm1275_probe+0x1434>
0d3e  232d9de:	44 89 23             	mov    %r12d,(%rbx)
0d41  232d9e1:	45 85 db             	test   %r11d,%r11d
0d44  232d9e4:	0f 88 b1 00 00 00    	js     232da9b <adm1275_probe+0xdfb>
0d4a  232d9ea:	44 89 d8             	mov    %r11d,%eax
0d4d  232d9ed:	4c 8d 24 40          	lea    (%rax,%rax,2),%r12
0d51  232d9f1:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0d55  232d9f5:	48 89 d8             	mov    %rbx,%rax
0d58  232d9f8:	48 c1 e8 03          	shr    $0x3,%rax
0d5c  232d9fc:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d5f  232d9ff:	84 c0                	test   %al,%al
0d61  232da01:	0f 85 27 07 00 00    	jne    232e12e <adm1275_probe+0x148e>
0d67  232da07:	44 0f bf 2b          	movswl (%rbx),%r13d
0d6b  232da0b:	48 8d 9e d8 00 00 00 	lea    0xd8(%rsi),%rbx
0d72  232da12:	48 89 d8             	mov    %rbx,%rax
0d75  232da15:	48 c1 e8 03          	shr    $0x3,%rax
0d79  232da19:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d7c  232da1c:	84 c0                	test   %al,%al
0d7e  232da1e:	0f 85 5a 07 00 00    	jne    232e17e <adm1275_probe+0x14de>
0d84  232da24:	44 89 2b             	mov    %r13d,(%rbx)
0d87  232da27:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0d8b  232da2b:	48 83 c3 02          	add    $0x2,%rbx
0d8f  232da2f:	48 89 d8             	mov    %rbx,%rax
0d92  232da32:	48 c1 e8 03          	shr    $0x3,%rax
0d96  232da36:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d99  232da39:	84 c0                	test   %al,%al
0d9b  232da3b:	0f 85 91 07 00 00    	jne    232e1d2 <adm1275_probe+0x1532>
0da1  232da41:	44 0f bf 2b          	movswl (%rbx),%r13d
0da5  232da45:	48 8d 9e f8 00 00 00 	lea    0xf8(%rsi),%rbx
0dac  232da4c:	48 89 d8             	mov    %rbx,%rax
0daf  232da4f:	48 c1 e8 03          	shr    $0x3,%rax
0db3  232da53:	8a 04 10             	mov    (%rax,%rdx,1),%al
0db6  232da56:	84 c0                	test   %al,%al
0db8  232da58:	0f 85 c4 07 00 00    	jne    232e222 <adm1275_probe+0x1582>
0dbe  232da5e:	44 89 2b             	mov    %r13d,(%rbx)
0dc1  232da61:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0dc5  232da65:	48 83 c3 04          	add    $0x4,%rbx
0dc9  232da69:	48 89 d8             	mov    %rbx,%rax
0dcc  232da6c:	48 c1 e8 03          	shr    $0x3,%rax
0dd0  232da70:	8a 04 10             	mov    (%rax,%rdx,1),%al
0dd3  232da73:	84 c0                	test   %al,%al
0dd5  232da75:	0f 85 fb 07 00 00    	jne    232e276 <adm1275_probe+0x15d6>
0ddb  232da7b:	44 0f bf 23          	movswl (%rbx),%r12d
0ddf  232da7f:	48 8d 9e 18 01 00 00 	lea    0x118(%rsi),%rbx
0de6  232da86:	48 89 d8             	mov    %rbx,%rax
0de9  232da89:	48 c1 e8 03          	shr    $0x3,%rax
0ded  232da8d:	8a 04 10             	mov    (%rax,%rdx,1),%al
0df0  232da90:	84 c0                	test   %al,%al
0df2  232da92:	0f 85 2a 08 00 00    	jne    232e2c2 <adm1275_probe+0x1622>
0df8  232da98:	44 89 23             	mov    %r12d,(%rbx)
0dfb  232da9b:	85 ff                	test   %edi,%edi
0dfd  232da9d:	0f 88 d4 00 00 00    	js     232db77 <adm1275_probe+0xed7>
0e03  232daa3:	89 f8                	mov    %edi,%eax
0e05  232daa5:	4c 8d 24 40          	lea    (%rax,%rax,2),%r12
0e09  232daa9:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0e0d  232daad:	48 89 d8             	mov    %rbx,%rax
0e10  232dab0:	48 c1 e8 03          	shr    $0x3,%rax
0e14  232dab4:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e17  232dab7:	84 c0                	test   %al,%al
0e19  232dab9:	0f 85 53 08 00 00    	jne    232e312 <adm1275_probe+0x1672>
0e1f  232dabf:	0f bf 1b             	movswl (%rbx),%ebx
0e22  232dac2:	48 8d 44 24 34       	lea    0x34(%rsp),%rax
0e27  232dac7:	48 c1 e8 03          	shr    $0x3,%rax
0e2b  232dacb:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e2e  232dace:	84 c0                	test   %al,%al
0e30  232dad0:	0f 85 82 08 00 00    	jne    232e358 <adm1275_probe+0x16b8>
0e36  232dad6:	0f af 5c 24 34       	imul   0x34(%rsp),%ebx
0e3b  232dadb:	48 69 db d3 4d 62 10 	imul   $0x10624dd3,%rbx,%rbx
0e42  232dae2:	48 c1 eb 26          	shr    $0x26,%rbx
0e46  232dae6:	4c 8d ae e0 00 00 00 	lea    0xe0(%rsi),%r13
0e4d  232daed:	4c 89 e8             	mov    %r13,%rax
0e50  232daf0:	48 c1 e8 03          	shr    $0x3,%rax
0e54  232daf4:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e57  232daf7:	84 c0                	test   %al,%al
0e59  232daf9:	0f 85 a4 08 00 00    	jne    232e3a3 <adm1275_probe+0x1703>
0e5f  232daff:	41 89 5d 00          	mov    %ebx,0x0(%r13)
0e63  232db03:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0e67  232db07:	48 83 c3 02          	add    $0x2,%rbx
0e6b  232db0b:	48 89 d8             	mov    %rbx,%rax
0e6e  232db0e:	48 c1 e8 03          	shr    $0x3,%rax
0e72  232db12:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e75  232db15:	84 c0                	test   %al,%al
0e77  232db17:	0f 85 d1 08 00 00    	jne    232e3ee <adm1275_probe+0x174e>
0e7d  232db1d:	44 0f bf 2b          	movswl (%rbx),%r13d
0e81  232db21:	48 8d 9e 00 01 00 00 	lea    0x100(%rsi),%rbx
0e88  232db28:	48 89 d8             	mov    %rbx,%rax
0e8b  232db2b:	48 c1 e8 03          	shr    $0x3,%rax
0e8f  232db2f:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e92  232db32:	84 c0                	test   %al,%al
0e94  232db34:	0f 85 fa 08 00 00    	jne    232e434 <adm1275_probe+0x1794>
0e9a  232db3a:	44 89 2b             	mov    %r13d,(%rbx)
0e9d  232db3d:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0ea1  232db41:	48 83 c3 04          	add    $0x4,%rbx
0ea5  232db45:	48 89 d8             	mov    %rbx,%rax
0ea8  232db48:	48 c1 e8 03          	shr    $0x3,%rax
0eac  232db4c:	8a 04 10             	mov    (%rax,%rdx,1),%al
0eaf  232db4f:	84 c0                	test   %al,%al
0eb1  232db51:	0f 85 27 09 00 00    	jne    232e47e <adm1275_probe+0x17de>
0eb7  232db57:	44 0f bf 23          	movswl (%rbx),%r12d
0ebb  232db5b:	48 8d 9e 20 01 00 00 	lea    0x120(%rsi),%rbx
0ec2  232db62:	48 89 d8             	mov    %rbx,%rax
0ec5  232db65:	48 c1 e8 03          	shr    $0x3,%rax
0ec9  232db69:	8a 04 10             	mov    (%rax,%rdx,1),%al
0ecc  232db6c:	84 c0                	test   %al,%al
0ece  232db6e:	0f 85 4c 09 00 00    	jne    232e4c0 <adm1275_probe+0x1820>
0ed4  232db74:	44 89 23             	mov    %r12d,(%rbx)
0ed7  232db77:	45 85 c0             	test   %r8d,%r8d
0eda  232db7a:	0f 88 d5 00 00 00    	js     232dc55 <adm1275_probe+0xfb5>
0ee0  232db80:	44 89 c0             	mov    %r8d,%eax
0ee3  232db83:	4c 8d 24 40          	lea    (%rax,%rax,2),%r12
0ee7  232db87:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0eeb  232db8b:	48 89 d8             	mov    %rbx,%rax
0eee  232db8e:	48 c1 e8 03          	shr    $0x3,%rax
0ef2  232db92:	8a 04 10             	mov    (%rax,%rdx,1),%al
0ef5  232db95:	84 c0                	test   %al,%al
0ef7  232db97:	0f 85 69 09 00 00    	jne    232e506 <adm1275_probe+0x1866>
0efd  232db9d:	0f bf 1b             	movswl (%rbx),%ebx
0f00  232dba0:	48 8d 44 24 34       	lea    0x34(%rsp),%rax
0f05  232dba5:	48 c1 e8 03          	shr    $0x3,%rax
0f09  232dba9:	8a 04 10             	mov    (%rax,%rdx,1),%al
0f0c  232dbac:	84 c0                	test   %al,%al
0f0e  232dbae:	0f 85 8e 09 00 00    	jne    232e542 <adm1275_probe+0x18a2>
0f14  232dbb4:	0f af 5c 24 34       	imul   0x34(%rsp),%ebx
0f19  232dbb9:	48 69 db d3 4d 62 10 	imul   $0x10624dd3,%rbx,%rbx
0f20  232dbc0:	48 c1 eb 26          	shr    $0x26,%rbx
0f24  232dbc4:	4c 8d ae e4 00 00 00 	lea    0xe4(%rsi),%r13
0f2b  232dbcb:	4c 89 e8             	mov    %r13,%rax
0f2e  232dbce:	48 c1 e8 03          	shr    $0x3,%rax
0f32  232dbd2:	8a 04 10             	mov    (%rax,%rdx,1),%al
0f35  232dbd5:	84 c0                	test   %al,%al
0f37  232dbd7:	0f 85 a6 09 00 00    	jne    232e583 <adm1275_probe+0x18e3>
0f3d  232dbdd:	41 89 5d 00          	mov    %ebx,0x0(%r13)
0f41  232dbe1:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0f45  232dbe5:	48 83 c3 02          	add    $0x2,%rbx
0f49  232dbe9:	48 89 d8             	mov    %rbx,%rax
0f4c  232dbec:	48 c1 e8 03          	shr    $0x3,%rax
0f50  232dbf0:	8a 04 10             	mov    (%rax,%rdx,1),%al
0f53  232dbf3:	84 c0                	test   %al,%al
0f55  232dbf5:	0f 85 c9 09 00 00    	jne    232e5c4 <adm1275_probe+0x1924>
0f5b  232dbfb:	44 0f bf 2b          	movswl (%rbx),%r13d
0f5f  232dbff:	48 8d 9e 04 01 00 00 	lea    0x104(%rsi),%rbx
0f66  232dc06:	48 89 d8             	mov    %rbx,%rax
0f69  232dc09:	48 c1 e8 03          	shr    $0x3,%rax
0f6d  232dc0d:	8a 04 10             	mov    (%rax,%rdx,1),%al
0f70  232dc10:	84 c0                	test   %al,%al
0f72  232dc12:	0f 85 e8 09 00 00    	jne    232e600 <adm1275_probe+0x1960>
0f78  232dc18:	44 89 2b             	mov    %r13d,(%rbx)
0f7b  232dc1b:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0f7f  232dc1f:	48 83 c3 04          	add    $0x4,%rbx
0f83  232dc23:	48 89 d8             	mov    %rbx,%rax
0f86  232dc26:	48 c1 e8 03          	shr    $0x3,%rax
0f8a  232dc2a:	8a 04 10             	mov    (%rax,%rdx,1),%al
0f8d  232dc2d:	84 c0                	test   %al,%al
0f8f  232dc2f:	0f 85 0b 0a 00 00    	jne    232e640 <adm1275_probe+0x19a0>
0f95  232dc35:	44 0f bf 23          	movswl (%rbx),%r12d
0f99  232dc39:	48 8d 9e 24 01 00 00 	lea    0x124(%rsi),%rbx
0fa0  232dc40:	48 89 d8             	mov    %rbx,%rax
0fa3  232dc43:	48 c1 e8 03          	shr    $0x3,%rax
0fa7  232dc47:	8a 04 10             	mov    (%rax,%rdx,1),%al
0faa  232dc4a:	84 c0                	test   %al,%al
0fac  232dc4c:	0f 85 26 0a 00 00    	jne    232e678 <adm1275_probe+0x19d8>
0fb2  232dc52:	44 89 23             	mov    %r12d,(%rbx)
0fb5  232dc55:	45 84 d2             	test   %r10b,%r10b
0fb8  232dc58:	0f 84 ac 00 00 00    	je     232dd0a <adm1275_probe+0x106a>
0fbe  232dc5e:	4f 8d 24 49          	lea    (%r9,%r9,2),%r12
0fc2  232dc62:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0fc6  232dc66:	48 89 d8             	mov    %rbx,%rax
0fc9  232dc69:	48 c1 e8 03          	shr    $0x3,%rax
0fcd  232dc6d:	8a 04 10             	mov    (%rax,%rdx,1),%al
0fd0  232dc70:	84 c0                	test   %al,%al
0fd2  232dc72:	0f 85 8a 0a 00 00    	jne    232e702 <adm1275_probe+0x1a62>
0fd8  232dc78:	44 0f bf 2b          	movswl (%rbx),%r13d
0fdc  232dc7c:	48 8d 9e e8 00 00 00 	lea    0xe8(%rsi),%rbx
0fe3  232dc83:	48 89 d8             	mov    %rbx,%rax
0fe6  232dc86:	48 c1 e8 03          	shr    $0x3,%rax
0fea  232dc8a:	8a 04 10             	mov    (%rax,%rdx,1),%al
0fed  232dc8d:	84 c0                	test   %al,%al
0fef  232dc8f:	0f 85 99 0a 00 00    	jne    232e72e <adm1275_probe+0x1a8e>
0ff5  232dc95:	44 89 2b             	mov    %r13d,(%rbx)
0ff8  232dc98:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
0ffc  232dc9c:	48 83 c3 02          	add    $0x2,%rbx
1000  232dca0:	48 89 d8             	mov    %rbx,%rax
1003  232dca3:	48 c1 e8 03          	shr    $0x3,%rax
1007  232dca7:	8a 04 10             	mov    (%rax,%rdx,1),%al
100a  232dcaa:	84 c0                	test   %al,%al
100c  232dcac:	0f 85 a8 0a 00 00    	jne    232e75a <adm1275_probe+0x1aba>
1012  232dcb2:	44 0f bf 2b          	movswl (%rbx),%r13d
1016  232dcb6:	48 8d 9e 08 01 00 00 	lea    0x108(%rsi),%rbx
101d  232dcbd:	48 89 d8             	mov    %rbx,%rax
1020  232dcc0:	48 c1 e8 03          	shr    $0x3,%rax
1024  232dcc4:	8a 04 10             	mov    (%rax,%rdx,1),%al
1027  232dcc7:	84 c0                	test   %al,%al
1029  232dcc9:	0f 85 b7 0a 00 00    	jne    232e786 <adm1275_probe+0x1ae6>
102f  232dccf:	44 89 2b             	mov    %r13d,(%rbx)
1032  232dcd2:	4b 8d 1c 67          	lea    (%r15,%r12,2),%rbx
1036  232dcd6:	48 83 c3 04          	add    $0x4,%rbx
103a  232dcda:	48 89 d8             	mov    %rbx,%rax
103d  232dcdd:	48 c1 e8 03          	shr    $0x3,%rax
1041  232dce1:	8a 04 10             	mov    (%rax,%rdx,1),%al
1044  232dce4:	84 c0                	test   %al,%al
1046  232dce6:	0f 85 c6 0a 00 00    	jne    232e7b2 <adm1275_probe+0x1b12>
104c  232dcec:	0f bf 1b             	movswl (%rbx),%ebx
104f  232dcef:	48 81 c6 28 01 00 00 	add    $0x128,%rsi
1056  232dcf6:	48 89 f0             	mov    %rsi,%rax
1059  232dcf9:	48 c1 e8 03          	shr    $0x3,%rax
105d  232dcfd:	8a 04 10             	mov    (%rax,%rdx,1),%al
1060  232dd00:	84 c0                	test   %al,%al
1062  232dd02:	0f 85 d6 0a 00 00    	jne    232e7de <adm1275_probe+0x1b3e>
1068  232dd08:	89 1e                	mov    %ebx,(%rsi)
106a  232dd0a:	4c 89 f7             	mov    %r14,%rdi
106d  232dd0d:	48 8b 74 24 70       	mov    0x70(%rsp),%rsi
1072  232dd12:	e8 00 00 00 00       	call   232dd17 <adm1275_probe+0x1077>	232dd13: R_X86_64_PLT32	pmbus_do_probe-0x4
1077  232dd17:	41 89 c4             	mov    %eax,%r12d
107a  232dd1a:	44 89 e0             	mov    %r12d,%eax
107d  232dd1d:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
1081  232dd21:	5b                   	pop    %rbx
1082  232dd22:	41 5c                	pop    %r12
1084  232dd24:	41 5d                	pop    %r13
1086  232dd26:	41 5e                	pop    %r14
1088  232dd28:	41 5f                	pop    %r15
108a  232dd2a:	5d                   	pop    %rbp
108b  232dd2b:	c3                   	ret
108c  232dd2c:	49 83 c6 20          	add    $0x20,%r14
1090  232dd30:	4c 89 f7             	mov    %r14,%rdi
1093  232dd33:	eb 05                	jmp    232dd3a <adm1275_probe+0x109a>
1095  232dd35:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
109a  232dd3a:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232dd3d: R_X86_64_32S	.rodata+0x857180
10a1  232dd41:	e8 00 00 00 00       	call   232dd46 <adm1275_probe+0x10a6>	232dd42: R_X86_64_PLT32	_dev_err-0x4
10a6  232dd46:	eb d2                	jmp    232dd1a <adm1275_probe+0x107a>
10a8  232dd48:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
10ad  232dd4d:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232dd50: R_X86_64_32S	.rodata+0x857340
10b4  232dd54:	e8 00 00 00 00       	call   232dd59 <adm1275_probe+0x10b9>	232dd55: R_X86_64_PLT32	_dev_err-0x4
10b9  232dd59:	eb bf                	jmp    232dd1a <adm1275_probe+0x107a>
10bb  232dd5b:	48 8b 7c 24 38       	mov    0x38(%rsp),%rdi
10c0  232dd60:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	232dd63: R_X86_64_32S	.rodata+0x8572a0
10c7  232dd67:	e8 00 00 00 00       	call   232dd6c <adm1275_probe+0x10cc>	232dd68: R_X86_64_PLT32	_dev_err-0x4
10cc  232dd6c:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
10d1  232dd71:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
10db  232dd7b:	bf ff ff ff ff       	mov    $0xffffffff,%edi
10e0  232dd80:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
10e6  232dd86:	e9 52 fa ff ff       	jmp    232d7dd <adm1275_probe+0xb3d>
10eb  232dd8b:	89 f1                	mov    %esi,%ecx
10ed  232dd8d:	80 e1 07             	and    $0x7,%cl
10f0  232dd90:	80 c1 03             	add    $0x3,%cl
10f3  232dd93:	38 c1                	cmp    %al,%cl
10f5  232dd95:	0f 8c 10 f3 ff ff    	jl     232d0ab <adm1275_probe+0x40b>
10fb  232dd9b:	48 89 f7             	mov    %rsi,%rdi
10fe  232dd9e:	e8 00 00 00 00       	call   232dda3 <adm1275_probe+0x1103>	232dd9f: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1103  232dda3:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1108  232dda8:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1112  232ddb2:	e9 f4 f2 ff ff       	jmp    232d0ab <adm1275_probe+0x40b>
1117  232ddb7:	44 89 f9             	mov    %r15d,%ecx
111a  232ddba:	80 e1 07             	and    $0x7,%cl
111d  232ddbd:	80 c1 03             	add    $0x3,%cl
1120  232ddc0:	38 c1                	cmp    %al,%cl
1122  232ddc2:	0f 8c fc f2 ff ff    	jl     232d0c4 <adm1275_probe+0x424>
1128  232ddc8:	4c 89 ff             	mov    %r15,%rdi
112b  232ddcb:	e8 00 00 00 00       	call   232ddd0 <adm1275_probe+0x1130>	232ddcc: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1130  232ddd0:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1135  232ddd5:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
113f  232dddf:	e9 e0 f2 ff ff       	jmp    232d0c4 <adm1275_probe+0x424>
1144  232dde4:	89 f9                	mov    %edi,%ecx
1146  232dde6:	80 e1 07             	and    $0x7,%cl
1149  232dde9:	80 c1 03             	add    $0x3,%cl
114c  232ddec:	38 c1                	cmp    %al,%cl
114e  232ddee:	0f 8c ed f2 ff ff    	jl     232d0e1 <adm1275_probe+0x441>
1154  232ddf4:	e8 00 00 00 00       	call   232ddf9 <adm1275_probe+0x1159>	232ddf5: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1159  232ddf9:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
115e  232ddfe:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1168  232de08:	e9 d4 f2 ff ff       	jmp    232d0e1 <adm1275_probe+0x441>
116d  232de0d:	89 f9                	mov    %edi,%ecx
116f  232de0f:	80 e1 07             	and    $0x7,%cl
1172  232de12:	80 c1 03             	add    $0x3,%cl
1175  232de15:	38 c1                	cmp    %al,%cl
1177  232de17:	0f 8c e1 f2 ff ff    	jl     232d0fe <adm1275_probe+0x45e>
117d  232de1d:	e8 00 00 00 00       	call   232de22 <adm1275_probe+0x1182>	232de1e: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1182  232de22:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1187  232de27:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1191  232de31:	e9 c8 f2 ff ff       	jmp    232d0fe <adm1275_probe+0x45e>
1196  232de36:	89 f9                	mov    %edi,%ecx
1198  232de38:	80 e1 07             	and    $0x7,%cl
119b  232de3b:	80 c1 03             	add    $0x3,%cl
119e  232de3e:	38 c1                	cmp    %al,%cl
11a0  232de40:	0f 8c d5 f2 ff ff    	jl     232d11b <adm1275_probe+0x47b>
11a6  232de46:	e8 00 00 00 00       	call   232de4b <adm1275_probe+0x11ab>	232de47: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
11ab  232de4b:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
11b0  232de50:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
11ba  232de5a:	e9 bc f2 ff ff       	jmp    232d11b <adm1275_probe+0x47b>
11bf  232de5f:	89 f9                	mov    %edi,%ecx
11c1  232de61:	80 e1 07             	and    $0x7,%cl
11c4  232de64:	80 c1 03             	add    $0x3,%cl
11c7  232de67:	38 c1                	cmp    %al,%cl
11c9  232de69:	0f 8c c9 f2 ff ff    	jl     232d138 <adm1275_probe+0x498>
11cf  232de6f:	e8 00 00 00 00       	call   232de74 <adm1275_probe+0x11d4>	232de70: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
11d4  232de74:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
11d9  232de79:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
11e3  232de83:	e9 b0 f2 ff ff       	jmp    232d138 <adm1275_probe+0x498>
11e8  232de88:	89 f9                	mov    %edi,%ecx
11ea  232de8a:	80 e1 07             	and    $0x7,%cl
11ed  232de8d:	80 c1 03             	add    $0x3,%cl
11f0  232de90:	38 c1                	cmp    %al,%cl
11f2  232de92:	0f 8c bd f2 ff ff    	jl     232d155 <adm1275_probe+0x4b5>
11f8  232de98:	e8 00 00 00 00       	call   232de9d <adm1275_probe+0x11fd>	232de99: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
11fd  232de9d:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1202  232dea2:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
120c  232deac:	e9 a4 f2 ff ff       	jmp    232d155 <adm1275_probe+0x4b5>
1211  232deb1:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
1216  232deb6:	80 e1 07             	and    $0x7,%cl
1219  232deb9:	80 c1 03             	add    $0x3,%cl
121c  232debc:	38 c1                	cmp    %al,%cl
121e  232debe:	0f 8c bb f2 ff ff    	jl     232d17f <adm1275_probe+0x4df>
1224  232dec4:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
1229  232dec9:	e8 00 00 00 00       	call   232dece <adm1275_probe+0x122e>	232deca: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
122e  232dece:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1233  232ded3:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
123d  232dedd:	e9 9d f2 ff ff       	jmp    232d17f <adm1275_probe+0x4df>
1242  232dee2:	48 8d 4c 24 34       	lea    0x34(%rsp),%rcx
1247  232dee7:	80 e1 04             	and    $0x4,%cl
124a  232deea:	80 c9 03             	or     $0x3,%cl
124d  232deed:	38 c1                	cmp    %al,%cl
124f  232deef:	0f 8c 28 f1 ff ff    	jl     232d01d <adm1275_probe+0x37d>
1255  232def5:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
125a  232defa:	e8 00 00 00 00       	call   232deff <adm1275_probe+0x125f>	232defb: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
125f  232deff:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1269  232df09:	e9 0f f1 ff ff       	jmp    232d01d <adm1275_probe+0x37d>
126e  232df0e:	89 d9                	mov    %ebx,%ecx
1270  232df10:	80 e1 07             	and    $0x7,%cl
1273  232df13:	80 c1 01             	add    $0x1,%cl
1276  232df16:	38 c1                	cmp    %al,%cl
1278  232df18:	0f 8c 2f fa ff ff    	jl     232d94d <adm1275_probe+0xcad>
127e  232df1e:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1283  232df23:	48 89 df             	mov    %rbx,%rdi
1286  232df26:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
128b  232df2b:	4d 89 cc             	mov    %r9,%r12
128e  232df2e:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1293  232df33:	44 89 5c 24 20       	mov    %r11d,0x20(%rsp)
1298  232df38:	e8 00 00 00 00       	call   232df3d <adm1275_probe+0x129d>	232df39: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
129d  232df3d:	44 8b 5c 24 20       	mov    0x20(%rsp),%r11d
12a2  232df42:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
12a7  232df47:	4d 89 e1             	mov    %r12,%r9
12aa  232df4a:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
12af  232df4f:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
12b4  232df54:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
12b9  232df59:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
12c3  232df63:	e9 e5 f9 ff ff       	jmp    232d94d <adm1275_probe+0xcad>
12c8  232df68:	89 d9                	mov    %ebx,%ecx
12ca  232df6a:	80 e1 07             	and    $0x7,%cl
12cd  232df6d:	80 c1 03             	add    $0x3,%cl
12d0  232df70:	38 c1                	cmp    %al,%cl
12d2  232df72:	0f 8c f2 f9 ff ff    	jl     232d96a <adm1275_probe+0xcca>
12d8  232df78:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
12dd  232df7d:	48 89 df             	mov    %rbx,%rdi
12e0  232df80:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
12e5  232df85:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
12ea  232df8a:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
12ef  232df8f:	44 89 5c 24 20       	mov    %r11d,0x20(%rsp)
12f4  232df94:	e8 00 00 00 00       	call   232df99 <adm1275_probe+0x12f9>	232df95: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
12f9  232df99:	44 8b 5c 24 20       	mov    0x20(%rsp),%r11d
12fe  232df9e:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1303  232dfa3:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1308  232dfa8:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
130d  232dfad:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1312  232dfb2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1317  232dfb7:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1321  232dfc1:	e9 a4 f9 ff ff       	jmp    232d96a <adm1275_probe+0xcca>
1326  232dfc6:	89 d9                	mov    %ebx,%ecx
1328  232dfc8:	80 e1 07             	and    $0x7,%cl
132b  232dfcb:	80 c1 01             	add    $0x1,%cl
132e  232dfce:	38 c1                	cmp    %al,%cl
1330  232dfd0:	0f 8c b1 f9 ff ff    	jl     232d987 <adm1275_probe+0xce7>
1336  232dfd6:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
133b  232dfdb:	48 89 df             	mov    %rbx,%rdi
133e  232dfde:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
1343  232dfe3:	4d 89 cc             	mov    %r9,%r12
1346  232dfe6:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
134b  232dfeb:	44 89 5c 24 20       	mov    %r11d,0x20(%rsp)
1350  232dff0:	e8 00 00 00 00       	call   232dff5 <adm1275_probe+0x1355>	232dff1: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1355  232dff5:	44 8b 5c 24 20       	mov    0x20(%rsp),%r11d
135a  232dffa:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
135f  232dfff:	4d 89 e1             	mov    %r12,%r9
1362  232e002:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1367  232e007:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
136c  232e00c:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1371  232e011:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
137b  232e01b:	e9 67 f9 ff ff       	jmp    232d987 <adm1275_probe+0xce7>
1380  232e020:	89 d9                	mov    %ebx,%ecx
1382  232e022:	80 e1 07             	and    $0x7,%cl
1385  232e025:	80 c1 03             	add    $0x3,%cl
1388  232e028:	38 c1                	cmp    %al,%cl
138a  232e02a:	0f 8c 74 f9 ff ff    	jl     232d9a4 <adm1275_probe+0xd04>
1390  232e030:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1395  232e035:	48 89 df             	mov    %rbx,%rdi
1398  232e038:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
139d  232e03d:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
13a2  232e042:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
13a7  232e047:	44 89 5c 24 20       	mov    %r11d,0x20(%rsp)
13ac  232e04c:	e8 00 00 00 00       	call   232e051 <adm1275_probe+0x13b1>	232e04d: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
13b1  232e051:	44 8b 5c 24 20       	mov    0x20(%rsp),%r11d
13b6  232e056:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
13bb  232e05b:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
13c0  232e060:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
13c5  232e065:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
13ca  232e06a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
13cf  232e06f:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
13d9  232e079:	e9 26 f9 ff ff       	jmp    232d9a4 <adm1275_probe+0xd04>
13de  232e07e:	89 d9                	mov    %ebx,%ecx
13e0  232e080:	80 e1 07             	and    $0x7,%cl
13e3  232e083:	80 c1 01             	add    $0x1,%cl
13e6  232e086:	38 c1                	cmp    %al,%cl
13e8  232e088:	0f 8c 33 f9 ff ff    	jl     232d9c1 <adm1275_probe+0xd21>
13ee  232e08e:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
13f3  232e093:	48 89 df             	mov    %rbx,%rdi
13f6  232e096:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
13fb  232e09b:	4d 89 cd             	mov    %r9,%r13
13fe  232e09e:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1403  232e0a3:	45 89 dc             	mov    %r11d,%r12d
1406  232e0a6:	e8 00 00 00 00       	call   232e0ab <adm1275_probe+0x140b>	232e0a7: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
140b  232e0ab:	45 89 e3             	mov    %r12d,%r11d
140e  232e0ae:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1413  232e0b3:	4d 89 e9             	mov    %r13,%r9
1416  232e0b6:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
141b  232e0bb:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1420  232e0c0:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1425  232e0c5:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
142f  232e0cf:	e9 ed f8 ff ff       	jmp    232d9c1 <adm1275_probe+0xd21>
1434  232e0d4:	89 d9                	mov    %ebx,%ecx
1436  232e0d6:	80 e1 07             	and    $0x7,%cl
1439  232e0d9:	80 c1 03             	add    $0x3,%cl
143c  232e0dc:	38 c1                	cmp    %al,%cl
143e  232e0de:	0f 8c fa f8 ff ff    	jl     232d9de <adm1275_probe+0xd3e>
1444  232e0e4:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1449  232e0e9:	48 89 df             	mov    %rbx,%rdi
144c  232e0ec:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
1451  232e0f1:	4d 89 cd             	mov    %r9,%r13
1454  232e0f4:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1459  232e0f9:	44 89 5c 24 20       	mov    %r11d,0x20(%rsp)
145e  232e0fe:	e8 00 00 00 00       	call   232e103 <adm1275_probe+0x1463>	232e0ff: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1463  232e103:	44 8b 5c 24 20       	mov    0x20(%rsp),%r11d
1468  232e108:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
146d  232e10d:	4d 89 e9             	mov    %r13,%r9
1470  232e110:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1475  232e115:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
147a  232e11a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
147f  232e11f:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1489  232e129:	e9 b0 f8 ff ff       	jmp    232d9de <adm1275_probe+0xd3e>
148e  232e12e:	89 d9                	mov    %ebx,%ecx
1490  232e130:	80 e1 07             	and    $0x7,%cl
1493  232e133:	80 c1 01             	add    $0x1,%cl
1496  232e136:	38 c1                	cmp    %al,%cl
1498  232e138:	0f 8c c9 f8 ff ff    	jl     232da07 <adm1275_probe+0xd67>
149e  232e13e:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
14a3  232e143:	48 89 df             	mov    %rbx,%rdi
14a6  232e146:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
14ab  232e14b:	4d 89 cd             	mov    %r9,%r13
14ae  232e14e:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
14b3  232e153:	e8 00 00 00 00       	call   232e158 <adm1275_probe+0x14b8>	232e154: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
14b8  232e158:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
14bd  232e15d:	4d 89 e9             	mov    %r13,%r9
14c0  232e160:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
14c5  232e165:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
14ca  232e16a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
14cf  232e16f:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
14d9  232e179:	e9 89 f8 ff ff       	jmp    232da07 <adm1275_probe+0xd67>
14de  232e17e:	89 d9                	mov    %ebx,%ecx
14e0  232e180:	80 e1 07             	and    $0x7,%cl
14e3  232e183:	80 c1 03             	add    $0x3,%cl
14e6  232e186:	38 c1                	cmp    %al,%cl
14e8  232e188:	0f 8c 96 f8 ff ff    	jl     232da24 <adm1275_probe+0xd84>
14ee  232e18e:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
14f3  232e193:	48 89 df             	mov    %rbx,%rdi
14f6  232e196:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
14fb  232e19b:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
1500  232e1a0:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1505  232e1a5:	e8 00 00 00 00       	call   232e1aa <adm1275_probe+0x150a>	232e1a6: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
150a  232e1aa:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
150f  232e1af:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1514  232e1b4:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1519  232e1b9:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
151e  232e1be:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1523  232e1c3:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
152d  232e1cd:	e9 52 f8 ff ff       	jmp    232da24 <adm1275_probe+0xd84>
1532  232e1d2:	89 d9                	mov    %ebx,%ecx
1534  232e1d4:	80 e1 07             	and    $0x7,%cl
1537  232e1d7:	80 c1 01             	add    $0x1,%cl
153a  232e1da:	38 c1                	cmp    %al,%cl
153c  232e1dc:	0f 8c 5f f8 ff ff    	jl     232da41 <adm1275_probe+0xda1>
1542  232e1e2:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1547  232e1e7:	48 89 df             	mov    %rbx,%rdi
154a  232e1ea:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
154f  232e1ef:	4d 89 cd             	mov    %r9,%r13
1552  232e1f2:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1557  232e1f7:	e8 00 00 00 00       	call   232e1fc <adm1275_probe+0x155c>	232e1f8: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
155c  232e1fc:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1561  232e201:	4d 89 e9             	mov    %r13,%r9
1564  232e204:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1569  232e209:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
156e  232e20e:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1573  232e213:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
157d  232e21d:	e9 1f f8 ff ff       	jmp    232da41 <adm1275_probe+0xda1>
1582  232e222:	89 d9                	mov    %ebx,%ecx
1584  232e224:	80 e1 07             	and    $0x7,%cl
1587  232e227:	80 c1 03             	add    $0x3,%cl
158a  232e22a:	38 c1                	cmp    %al,%cl
158c  232e22c:	0f 8c 2c f8 ff ff    	jl     232da5e <adm1275_probe+0xdbe>
1592  232e232:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1597  232e237:	48 89 df             	mov    %rbx,%rdi
159a  232e23a:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
159f  232e23f:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
15a4  232e244:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
15a9  232e249:	e8 00 00 00 00       	call   232e24e <adm1275_probe+0x15ae>	232e24a: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
15ae  232e24e:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
15b3  232e253:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
15b8  232e258:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
15bd  232e25d:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
15c2  232e262:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
15c7  232e267:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
15d1  232e271:	e9 e8 f7 ff ff       	jmp    232da5e <adm1275_probe+0xdbe>
15d6  232e276:	89 d9                	mov    %ebx,%ecx
15d8  232e278:	80 e1 07             	and    $0x7,%cl
15db  232e27b:	80 c1 01             	add    $0x1,%cl
15de  232e27e:	38 c1                	cmp    %al,%cl
15e0  232e280:	0f 8c f5 f7 ff ff    	jl     232da7b <adm1275_probe+0xddb>
15e6  232e286:	49 89 fc             	mov    %rdi,%r12
15e9  232e289:	48 89 df             	mov    %rbx,%rdi
15ec  232e28c:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
15f1  232e291:	4d 89 cd             	mov    %r9,%r13
15f4  232e294:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
15f9  232e299:	e8 00 00 00 00       	call   232e29e <adm1275_probe+0x15fe>	232e29a: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
15fe  232e29e:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1603  232e2a3:	4d 89 e9             	mov    %r13,%r9
1606  232e2a6:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
160b  232e2ab:	4c 89 e7             	mov    %r12,%rdi
160e  232e2ae:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1613  232e2b3:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
161d  232e2bd:	e9 b9 f7 ff ff       	jmp    232da7b <adm1275_probe+0xddb>
1622  232e2c2:	89 d9                	mov    %ebx,%ecx
1624  232e2c4:	80 e1 07             	and    $0x7,%cl
1627  232e2c7:	80 c1 03             	add    $0x3,%cl
162a  232e2ca:	38 c1                	cmp    %al,%cl
162c  232e2cc:	0f 8c c6 f7 ff ff    	jl     232da98 <adm1275_probe+0xdf8>
1632  232e2d2:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1637  232e2d7:	48 89 df             	mov    %rbx,%rdi
163a  232e2da:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
163f  232e2df:	4d 89 cd             	mov    %r9,%r13
1642  232e2e2:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1647  232e2e7:	e8 00 00 00 00       	call   232e2ec <adm1275_probe+0x164c>	232e2e8: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
164c  232e2ec:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1651  232e2f1:	4d 89 e9             	mov    %r13,%r9
1654  232e2f4:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1659  232e2f9:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
165e  232e2fe:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1663  232e303:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
166d  232e30d:	e9 86 f7 ff ff       	jmp    232da98 <adm1275_probe+0xdf8>
1672  232e312:	89 d9                	mov    %ebx,%ecx
1674  232e314:	80 e1 07             	and    $0x7,%cl
1677  232e317:	80 c1 01             	add    $0x1,%cl
167a  232e31a:	38 c1                	cmp    %al,%cl
167c  232e31c:	0f 8c 9d f7 ff ff    	jl     232dabf <adm1275_probe+0xe1f>
1682  232e322:	48 89 df             	mov    %rbx,%rdi
1685  232e325:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
168a  232e32a:	4d 89 cd             	mov    %r9,%r13
168d  232e32d:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1692  232e332:	e8 00 00 00 00       	call   232e337 <adm1275_probe+0x1697>	232e333: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1697  232e337:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
169c  232e33c:	4d 89 e9             	mov    %r13,%r9
169f  232e33f:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
16a4  232e344:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
16a9  232e349:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
16b3  232e353:	e9 67 f7 ff ff       	jmp    232dabf <adm1275_probe+0xe1f>
16b8  232e358:	48 8d 4c 24 34       	lea    0x34(%rsp),%rcx
16bd  232e35d:	80 e1 04             	and    $0x4,%cl
16c0  232e360:	80 c9 03             	or     $0x3,%cl
16c3  232e363:	38 c1                	cmp    %al,%cl
16c5  232e365:	0f 8c 6b f7 ff ff    	jl     232dad6 <adm1275_probe+0xe36>
16cb  232e36b:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
16d0  232e370:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
16d5  232e375:	4d 89 cd             	mov    %r9,%r13
16d8  232e378:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
16dd  232e37d:	e8 00 00 00 00       	call   232e382 <adm1275_probe+0x16e2>	232e37e: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
16e2  232e382:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
16e7  232e387:	4d 89 e9             	mov    %r13,%r9
16ea  232e38a:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
16ef  232e38f:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
16f4  232e394:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
16fe  232e39e:	e9 33 f7 ff ff       	jmp    232dad6 <adm1275_probe+0xe36>
1703  232e3a3:	44 89 e9             	mov    %r13d,%ecx
1706  232e3a6:	80 e1 07             	and    $0x7,%cl
1709  232e3a9:	80 c1 03             	add    $0x3,%cl
170c  232e3ac:	38 c1                	cmp    %al,%cl
170e  232e3ae:	0f 8c 4b f7 ff ff    	jl     232daff <adm1275_probe+0xe5f>
1714  232e3b4:	4c 89 ef             	mov    %r13,%rdi
1717  232e3b7:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
171c  232e3bc:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
1721  232e3c1:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1726  232e3c6:	e8 00 00 00 00       	call   232e3cb <adm1275_probe+0x172b>	232e3c7: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
172b  232e3cb:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1730  232e3d0:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1735  232e3d5:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
173a  232e3da:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
173f  232e3df:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1749  232e3e9:	e9 11 f7 ff ff       	jmp    232daff <adm1275_probe+0xe5f>
174e  232e3ee:	89 d9                	mov    %ebx,%ecx
1750  232e3f0:	80 e1 07             	and    $0x7,%cl
1753  232e3f3:	80 c1 01             	add    $0x1,%cl
1756  232e3f6:	38 c1                	cmp    %al,%cl
1758  232e3f8:	0f 8c 1f f7 ff ff    	jl     232db1d <adm1275_probe+0xe7d>
175e  232e3fe:	48 89 df             	mov    %rbx,%rdi
1761  232e401:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
1766  232e406:	4d 89 cd             	mov    %r9,%r13
1769  232e409:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
176e  232e40e:	e8 00 00 00 00       	call   232e413 <adm1275_probe+0x1773>	232e40f: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1773  232e413:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1778  232e418:	4d 89 e9             	mov    %r13,%r9
177b  232e41b:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1780  232e420:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1785  232e425:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
178f  232e42f:	e9 e9 f6 ff ff       	jmp    232db1d <adm1275_probe+0xe7d>
1794  232e434:	89 d9                	mov    %ebx,%ecx
1796  232e436:	80 e1 07             	and    $0x7,%cl
1799  232e439:	80 c1 03             	add    $0x3,%cl
179c  232e43c:	38 c1                	cmp    %al,%cl
179e  232e43e:	0f 8c f6 f6 ff ff    	jl     232db3a <adm1275_probe+0xe9a>
17a4  232e444:	48 89 df             	mov    %rbx,%rdi
17a7  232e447:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
17ac  232e44c:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
17b1  232e451:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
17b6  232e456:	e8 00 00 00 00       	call   232e45b <adm1275_probe+0x17bb>	232e457: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
17bb  232e45b:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
17c0  232e460:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
17c5  232e465:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
17ca  232e46a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
17cf  232e46f:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
17d9  232e479:	e9 bc f6 ff ff       	jmp    232db3a <adm1275_probe+0xe9a>
17de  232e47e:	89 d9                	mov    %ebx,%ecx
17e0  232e480:	80 e1 07             	and    $0x7,%cl
17e3  232e483:	80 c1 01             	add    $0x1,%cl
17e6  232e486:	38 c1                	cmp    %al,%cl
17e8  232e488:	0f 8c c9 f6 ff ff    	jl     232db57 <adm1275_probe+0xeb7>
17ee  232e48e:	48 89 df             	mov    %rbx,%rdi
17f1  232e491:	45 89 c4             	mov    %r8d,%r12d
17f4  232e494:	4d 89 cd             	mov    %r9,%r13
17f7  232e497:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
17fc  232e49c:	e8 00 00 00 00       	call   232e4a1 <adm1275_probe+0x1801>	232e49d: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1801  232e4a1:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1806  232e4a6:	4d 89 e9             	mov    %r13,%r9
1809  232e4a9:	45 89 e0             	mov    %r12d,%r8d
180c  232e4ac:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1811  232e4b1:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
181b  232e4bb:	e9 97 f6 ff ff       	jmp    232db57 <adm1275_probe+0xeb7>
1820  232e4c0:	89 d9                	mov    %ebx,%ecx
1822  232e4c2:	80 e1 07             	and    $0x7,%cl
1825  232e4c5:	80 c1 03             	add    $0x3,%cl
1828  232e4c8:	38 c1                	cmp    %al,%cl
182a  232e4ca:	0f 8c a4 f6 ff ff    	jl     232db74 <adm1275_probe+0xed4>
1830  232e4d0:	48 89 df             	mov    %rbx,%rdi
1833  232e4d3:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
1838  232e4d8:	4d 89 cd             	mov    %r9,%r13
183b  232e4db:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1840  232e4e0:	e8 00 00 00 00       	call   232e4e5 <adm1275_probe+0x1845>	232e4e1: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1845  232e4e5:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
184a  232e4ea:	4d 89 e9             	mov    %r13,%r9
184d  232e4ed:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1852  232e4f2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1857  232e4f7:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1861  232e501:	e9 6e f6 ff ff       	jmp    232db74 <adm1275_probe+0xed4>
1866  232e506:	89 d9                	mov    %ebx,%ecx
1868  232e508:	80 e1 07             	and    $0x7,%cl
186b  232e50b:	80 c1 01             	add    $0x1,%cl
186e  232e50e:	38 c1                	cmp    %al,%cl
1870  232e510:	0f 8c 87 f6 ff ff    	jl     232db9d <adm1275_probe+0xefd>
1876  232e516:	48 89 df             	mov    %rbx,%rdi
1879  232e519:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
187e  232e51e:	45 89 d5             	mov    %r10d,%r13d
1881  232e521:	e8 00 00 00 00       	call   232e526 <adm1275_probe+0x1886>	232e522: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1886  232e526:	45 89 ea             	mov    %r13d,%r10d
1889  232e529:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
188e  232e52e:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1893  232e533:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
189d  232e53d:	e9 5b f6 ff ff       	jmp    232db9d <adm1275_probe+0xefd>
18a2  232e542:	48 8d 4c 24 34       	lea    0x34(%rsp),%rcx
18a7  232e547:	80 e1 04             	and    $0x4,%cl
18aa  232e54a:	80 c9 03             	or     $0x3,%cl
18ad  232e54d:	38 c1                	cmp    %al,%cl
18af  232e54f:	0f 8c 5f f6 ff ff    	jl     232dbb4 <adm1275_probe+0xf14>
18b5  232e555:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
18ba  232e55a:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
18bf  232e55f:	45 89 d5             	mov    %r10d,%r13d
18c2  232e562:	e8 00 00 00 00       	call   232e567 <adm1275_probe+0x18c7>	232e563: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
18c7  232e567:	45 89 ea             	mov    %r13d,%r10d
18ca  232e56a:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
18cf  232e56f:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
18d4  232e574:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
18de  232e57e:	e9 31 f6 ff ff       	jmp    232dbb4 <adm1275_probe+0xf14>
18e3  232e583:	44 89 e9             	mov    %r13d,%ecx
18e6  232e586:	80 e1 07             	and    $0x7,%cl
18e9  232e589:	80 c1 03             	add    $0x3,%cl
18ec  232e58c:	38 c1                	cmp    %al,%cl
18ee  232e58e:	0f 8c 49 f6 ff ff    	jl     232dbdd <adm1275_probe+0xf3d>
18f4  232e594:	4c 89 ef             	mov    %r13,%rdi
18f7  232e597:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
18fc  232e59c:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1901  232e5a1:	e8 00 00 00 00       	call   232e5a6 <adm1275_probe+0x1906>	232e5a2: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1906  232e5a6:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
190b  232e5ab:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1910  232e5b0:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1915  232e5b5:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
191f  232e5bf:	e9 19 f6 ff ff       	jmp    232dbdd <adm1275_probe+0xf3d>
1924  232e5c4:	89 d9                	mov    %ebx,%ecx
1926  232e5c6:	80 e1 07             	and    $0x7,%cl
1929  232e5c9:	80 c1 01             	add    $0x1,%cl
192c  232e5cc:	38 c1                	cmp    %al,%cl
192e  232e5ce:	0f 8c 27 f6 ff ff    	jl     232dbfb <adm1275_probe+0xf5b>
1934  232e5d4:	48 89 df             	mov    %rbx,%rdi
1937  232e5d7:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
193c  232e5dc:	45 89 d5             	mov    %r10d,%r13d
193f  232e5df:	e8 00 00 00 00       	call   232e5e4 <adm1275_probe+0x1944>	232e5e0: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1944  232e5e4:	45 89 ea             	mov    %r13d,%r10d
1947  232e5e7:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
194c  232e5ec:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1951  232e5f1:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
195b  232e5fb:	e9 fb f5 ff ff       	jmp    232dbfb <adm1275_probe+0xf5b>
1960  232e600:	89 d9                	mov    %ebx,%ecx
1962  232e602:	80 e1 07             	and    $0x7,%cl
1965  232e605:	80 c1 03             	add    $0x3,%cl
1968  232e608:	38 c1                	cmp    %al,%cl
196a  232e60a:	0f 8c 08 f6 ff ff    	jl     232dc18 <adm1275_probe+0xf78>
1970  232e610:	48 89 df             	mov    %rbx,%rdi
1973  232e613:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
1978  232e618:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
197d  232e61d:	e8 00 00 00 00       	call   232e622 <adm1275_probe+0x1982>	232e61e: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1982  232e622:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1987  232e627:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
198c  232e62c:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1991  232e631:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
199b  232e63b:	e9 d8 f5 ff ff       	jmp    232dc18 <adm1275_probe+0xf78>
19a0  232e640:	89 d9                	mov    %ebx,%ecx
19a2  232e642:	80 e1 07             	and    $0x7,%cl
19a5  232e645:	80 c1 01             	add    $0x1,%cl
19a8  232e648:	38 c1                	cmp    %al,%cl
19aa  232e64a:	0f 8c e5 f5 ff ff    	jl     232dc35 <adm1275_probe+0xf95>
19b0  232e650:	48 89 df             	mov    %rbx,%rdi
19b3  232e653:	4d 89 cc             	mov    %r9,%r12
19b6  232e656:	45 89 d5             	mov    %r10d,%r13d
19b9  232e659:	e8 00 00 00 00       	call   232e65e <adm1275_probe+0x19be>	232e65a: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
19be  232e65e:	45 89 ea             	mov    %r13d,%r10d
19c1  232e661:	4d 89 e1             	mov    %r12,%r9
19c4  232e664:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
19c9  232e669:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
19d3  232e673:	e9 bd f5 ff ff       	jmp    232dc35 <adm1275_probe+0xf95>
19d8  232e678:	89 d9                	mov    %ebx,%ecx
19da  232e67a:	80 e1 07             	and    $0x7,%cl
19dd  232e67d:	80 c1 03             	add    $0x3,%cl
19e0  232e680:	38 c1                	cmp    %al,%cl
19e2  232e682:	0f 8c ca f5 ff ff    	jl     232dc52 <adm1275_probe+0xfb2>
19e8  232e688:	48 89 df             	mov    %rbx,%rdi
19eb  232e68b:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
19f0  232e690:	45 89 d5             	mov    %r10d,%r13d
19f3  232e693:	e8 00 00 00 00       	call   232e698 <adm1275_probe+0x19f8>	232e694: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
19f8  232e698:	45 89 ea             	mov    %r13d,%r10d
19fb  232e69b:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1a00  232e6a0:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1a05  232e6a5:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1a0f  232e6af:	e9 9e f5 ff ff       	jmp    232dc52 <adm1275_probe+0xfb2>
1a14  232e6b4:	44 89 e1             	mov    %r12d,%ecx
1a17  232e6b7:	80 e1 07             	and    $0x7,%cl
1a1a  232e6ba:	80 c1 03             	add    $0x3,%cl
1a1d  232e6bd:	38 c1                	cmp    %al,%cl
1a1f  232e6bf:	0f 8c 3a f0 ff ff    	jl     232d6ff <adm1275_probe+0xa5f>
1a25  232e6c5:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1a2a  232e6ca:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
1a2f  232e6cf:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
1a34  232e6d4:	45 89 dc             	mov    %r11d,%r12d
1a37  232e6d7:	e8 00 00 00 00       	call   232e6dc <adm1275_probe+0x1a3c>	232e6d8: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1a3c  232e6dc:	45 89 e3             	mov    %r12d,%r11d
1a3f  232e6df:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1a44  232e6e4:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1a49  232e6e9:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
1a4e  232e6ee:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1a53  232e6f3:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1a5d  232e6fd:	e9 fd ef ff ff       	jmp    232d6ff <adm1275_probe+0xa5f>
1a62  232e702:	89 d9                	mov    %ebx,%ecx
1a64  232e704:	80 e1 07             	and    $0x7,%cl
1a67  232e707:	80 c1 01             	add    $0x1,%cl
1a6a  232e70a:	38 c1                	cmp    %al,%cl
1a6c  232e70c:	0f 8c 66 f5 ff ff    	jl     232dc78 <adm1275_probe+0xfd8>
1a72  232e712:	48 89 df             	mov    %rbx,%rdi
1a75  232e715:	e8 00 00 00 00       	call   232e71a <adm1275_probe+0x1a7a>	232e716: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1a7a  232e71a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1a7f  232e71f:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1a89  232e729:	e9 4a f5 ff ff       	jmp    232dc78 <adm1275_probe+0xfd8>
1a8e  232e72e:	89 d9                	mov    %ebx,%ecx
1a90  232e730:	80 e1 07             	and    $0x7,%cl
1a93  232e733:	80 c1 03             	add    $0x3,%cl
1a96  232e736:	38 c1                	cmp    %al,%cl
1a98  232e738:	0f 8c 57 f5 ff ff    	jl     232dc95 <adm1275_probe+0xff5>
1a9e  232e73e:	48 89 df             	mov    %rbx,%rdi
1aa1  232e741:	e8 00 00 00 00       	call   232e746 <adm1275_probe+0x1aa6>	232e742: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1aa6  232e746:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1aab  232e74b:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1ab5  232e755:	e9 3b f5 ff ff       	jmp    232dc95 <adm1275_probe+0xff5>
1aba  232e75a:	89 d9                	mov    %ebx,%ecx
1abc  232e75c:	80 e1 07             	and    $0x7,%cl
1abf  232e75f:	80 c1 01             	add    $0x1,%cl
1ac2  232e762:	38 c1                	cmp    %al,%cl
1ac4  232e764:	0f 8c 48 f5 ff ff    	jl     232dcb2 <adm1275_probe+0x1012>
1aca  232e76a:	48 89 df             	mov    %rbx,%rdi
1acd  232e76d:	e8 00 00 00 00       	call   232e772 <adm1275_probe+0x1ad2>	232e76e: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1ad2  232e772:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1ad7  232e777:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1ae1  232e781:	e9 2c f5 ff ff       	jmp    232dcb2 <adm1275_probe+0x1012>
1ae6  232e786:	89 d9                	mov    %ebx,%ecx
1ae8  232e788:	80 e1 07             	and    $0x7,%cl
1aeb  232e78b:	80 c1 03             	add    $0x3,%cl
1aee  232e78e:	38 c1                	cmp    %al,%cl
1af0  232e790:	0f 8c 39 f5 ff ff    	jl     232dccf <adm1275_probe+0x102f>
1af6  232e796:	48 89 df             	mov    %rbx,%rdi
1af9  232e799:	e8 00 00 00 00       	call   232e79e <adm1275_probe+0x1afe>	232e79a: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1afe  232e79e:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1b03  232e7a3:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1b0d  232e7ad:	e9 1d f5 ff ff       	jmp    232dccf <adm1275_probe+0x102f>
1b12  232e7b2:	89 d9                	mov    %ebx,%ecx
1b14  232e7b4:	80 e1 07             	and    $0x7,%cl
1b17  232e7b7:	80 c1 01             	add    $0x1,%cl
1b1a  232e7ba:	38 c1                	cmp    %al,%cl
1b1c  232e7bc:	0f 8c 2a f5 ff ff    	jl     232dcec <adm1275_probe+0x104c>
1b22  232e7c2:	48 89 df             	mov    %rbx,%rdi
1b25  232e7c5:	e8 00 00 00 00       	call   232e7ca <adm1275_probe+0x1b2a>	232e7c6: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1b2a  232e7ca:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1b2f  232e7cf:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1b39  232e7d9:	e9 0e f5 ff ff       	jmp    232dcec <adm1275_probe+0x104c>
1b3e  232e7de:	89 f1                	mov    %esi,%ecx
1b40  232e7e0:	80 e1 07             	and    $0x7,%cl
1b43  232e7e3:	80 c1 03             	add    $0x3,%cl
1b46  232e7e6:	38 c1                	cmp    %al,%cl
1b48  232e7e8:	0f 8c 1a f5 ff ff    	jl     232dd08 <adm1275_probe+0x1068>
1b4e  232e7ee:	48 89 f7             	mov    %rsi,%rdi
1b51  232e7f1:	49 89 f7             	mov    %rsi,%r15
1b54  232e7f4:	e8 00 00 00 00       	call   232e7f9 <adm1275_probe+0x1b59>	232e7f5: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1b59  232e7f9:	4c 89 fe             	mov    %r15,%rsi
1b5c  232e7fc:	e9 07 f5 ff ff       	jmp    232dd08 <adm1275_probe+0x1068>
1b61  232e801:	48 8d 4c 24 34       	lea    0x34(%rsp),%rcx
1b66  232e806:	80 e1 04             	and    $0x4,%cl
1b69  232e809:	80 c9 03             	or     $0x3,%cl
1b6c  232e80c:	38 c1                	cmp    %al,%cl
1b6e  232e80e:	0f 8c 56 e8 ff ff    	jl     232d06a <adm1275_probe+0x3ca>
1b74  232e814:	48 8d 7c 24 34       	lea    0x34(%rsp),%rdi
1b79  232e819:	e8 00 00 00 00       	call   232e81e <adm1275_probe+0x1b7e>	232e81a: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1b7e  232e81e:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1b88  232e828:	e9 3d e8 ff ff       	jmp    232d06a <adm1275_probe+0x3ca>
1b8d  232e82d:	89 d9                	mov    %ebx,%ecx
1b8f  232e82f:	80 e1 07             	and    $0x7,%cl
1b92  232e832:	38 c1                	cmp    %al,%cl
1b94  232e834:	0f 8c 1a ea ff ff    	jl     232d254 <adm1275_probe+0x5b4>
1b9a  232e83a:	48 89 df             	mov    %rbx,%rdi
1b9d  232e83d:	e8 00 00 00 00       	call   232e842 <adm1275_probe+0x1ba2>	232e83e: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1ba2  232e842:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1ba7  232e847:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1bb1  232e851:	e9 fe e9 ff ff       	jmp    232d254 <adm1275_probe+0x5b4>
1bb6  232e856:	44 89 f9             	mov    %r15d,%ecx
1bb9  232e859:	80 e1 07             	and    $0x7,%cl
1bbc  232e85c:	80 c1 03             	add    $0x3,%cl
1bbf  232e85f:	38 c1                	cmp    %al,%cl
1bc1  232e861:	0f 8c 10 ea ff ff    	jl     232d277 <adm1275_probe+0x5d7>
1bc7  232e867:	4c 89 ff             	mov    %r15,%rdi
1bca  232e86a:	e8 00 00 00 00       	call   232e86f <adm1275_probe+0x1bcf>	232e86b: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1bcf  232e86f:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1bd4  232e874:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1bd9  232e879:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1be3  232e883:	e9 ef e9 ff ff       	jmp    232d277 <adm1275_probe+0x5d7>
1be8  232e888:	44 89 e1             	mov    %r12d,%ecx
1beb  232e88b:	80 e1 07             	and    $0x7,%cl
1bee  232e88e:	80 c1 03             	add    $0x3,%cl
1bf1  232e891:	38 c1                	cmp    %al,%cl
1bf3  232e893:	0f 8c f4 ec ff ff    	jl     232d58d <adm1275_probe+0x8ed>
1bf9  232e899:	48 89 fb             	mov    %rdi,%rbx
1bfc  232e89c:	4c 89 e7             	mov    %r12,%rdi
1bff  232e89f:	45 89 c7             	mov    %r8d,%r15d
1c02  232e8a2:	e8 00 00 00 00       	call   232e8a7 <adm1275_probe+0x1c07>	232e8a3: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
1c07  232e8a7:	45 89 f8             	mov    %r15d,%r8d
1c0a  232e8aa:	48 89 df             	mov    %rbx,%rdi
1c0d  232e8ad:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1c12  232e8b2:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1c1c  232e8bc:	e9 cc ec ff ff       	jmp    232d58d <adm1275_probe+0x8ed>
1c21  232e8c1:	44 89 e1             	mov    %r12d,%ecx
1c24  232e8c4:	80 e1 07             	and    $0x7,%cl
1c27  232e8c7:	80 c1 03             	add    $0x3,%cl
1c2a  232e8ca:	38 c1                	cmp    %al,%cl
1c2c  232e8cc:	0f 8c 57 f0 ff ff    	jl     232d929 <adm1275_probe+0xc89>
1c32  232e8d2:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
1c37  232e8d7:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
1c3c  232e8dc:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
1c41  232e8e1:	4d 89 cd             	mov    %r9,%r13
1c44  232e8e4:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
1c49  232e8e9:	45 89 dc             	mov    %r11d,%r12d
1c4c  232e8ec:	e8 00 00 00 00       	call   232e8f1 <adm1275_probe+0x1c51>	232e8ed: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1c51  232e8f1:	45 89 e3             	mov    %r12d,%r11d
1c54  232e8f4:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
1c59  232e8f9:	4d 89 e9             	mov    %r13,%r9
1c5c  232e8fc:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
1c61  232e901:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1c66  232e906:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
1c6b  232e90b:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1c70  232e910:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1c7a  232e91a:	e9 0a f0 ff ff       	jmp    232d929 <adm1275_probe+0xc89>
1c7f  232e91f:	44 89 e1             	mov    %r12d,%ecx
1c82  232e922:	80 e1 07             	and    $0x7,%cl
1c85  232e925:	80 c1 03             	add    $0x3,%cl
1c88  232e928:	38 c1                	cmp    %al,%cl
1c8a  232e92a:	0f 8c 45 ec ff ff    	jl     232d575 <adm1275_probe+0x8d5>
1c90  232e930:	48 89 fb             	mov    %rdi,%rbx
1c93  232e933:	4c 89 e7             	mov    %r12,%rdi
1c96  232e936:	45 89 c7             	mov    %r8d,%r15d
1c99  232e939:	e8 00 00 00 00       	call   232e93e <adm1275_probe+0x1c9e>	232e93a: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1c9e  232e93e:	45 89 f8             	mov    %r15d,%r8d
1ca1  232e941:	48 89 df             	mov    %rbx,%rdi
1ca4  232e944:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1ca9  232e949:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1cb3  232e953:	e9 1d ec ff ff       	jmp    232d575 <adm1275_probe+0x8d5>
1cb8  232e958:	89 f9                	mov    %edi,%ecx
1cba  232e95a:	80 e1 07             	and    $0x7,%cl
1cbd  232e95d:	38 c1                	cmp    %al,%cl
1cbf  232e95f:	0f 8c 9a e9 ff ff    	jl     232d2ff <adm1275_probe+0x65f>
1cc5  232e965:	e8 00 00 00 00       	call   232e96a <adm1275_probe+0x1cca>	232e966: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1cca  232e96a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1ccf  232e96f:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1cd9  232e979:	e9 81 e9 ff ff       	jmp    232d2ff <adm1275_probe+0x65f>
1cde  232e97e:	89 f9                	mov    %edi,%ecx
1ce0  232e980:	80 e1 07             	and    $0x7,%cl
1ce3  232e983:	38 c1                	cmp    %al,%cl
1ce5  232e985:	0f 8c 8e e9 ff ff    	jl     232d319 <adm1275_probe+0x679>
1ceb  232e98b:	e8 00 00 00 00       	call   232e990 <adm1275_probe+0x1cf0>	232e98c: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1cf0  232e990:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1cf5  232e995:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1cff  232e99f:	e9 75 e9 ff ff       	jmp    232d319 <adm1275_probe+0x679>
1d04  232e9a4:	89 f9                	mov    %edi,%ecx
1d06  232e9a6:	80 e1 07             	and    $0x7,%cl
1d09  232e9a9:	38 c1                	cmp    %al,%cl
1d0b  232e9ab:	0f 8c 82 e9 ff ff    	jl     232d333 <adm1275_probe+0x693>
1d11  232e9b1:	e8 00 00 00 00       	call   232e9b6 <adm1275_probe+0x1d16>	232e9b2: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1d16  232e9b6:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1d1b  232e9bb:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1d25  232e9c5:	e9 69 e9 ff ff       	jmp    232d333 <adm1275_probe+0x693>
1d2a  232e9ca:	89 d9                	mov    %ebx,%ecx
1d2c  232e9cc:	80 e1 07             	and    $0x7,%cl
1d2f  232e9cf:	38 c1                	cmp    %al,%cl
1d31  232e9d1:	0f 8c 76 e9 ff ff    	jl     232d34d <adm1275_probe+0x6ad>
1d37  232e9d7:	48 89 df             	mov    %rbx,%rdi
1d3a  232e9da:	e8 00 00 00 00       	call   232e9df <adm1275_probe+0x1d3f>	232e9db: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1d3f  232e9df:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1d44  232e9e4:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1d4e  232e9ee:	e9 5a e9 ff ff       	jmp    232d34d <adm1275_probe+0x6ad>
1d53  232e9f3:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
1d58  232e9f8:	80 e1 07             	and    $0x7,%cl
1d5b  232e9fb:	80 c1 03             	add    $0x3,%cl
1d5e  232e9fe:	38 c1                	cmp    %al,%cl
1d60  232ea00:	0f 8c 5f e9 ff ff    	jl     232d365 <adm1275_probe+0x6c5>
1d66  232ea06:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
1d6b  232ea0b:	e8 00 00 00 00       	call   232ea10 <adm1275_probe+0x1d70>	232ea0c: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1d70  232ea10:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1d75  232ea15:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1d7a  232ea1a:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1d84  232ea24:	e9 3c e9 ff ff       	jmp    232d365 <adm1275_probe+0x6c5>
1d89  232ea29:	89 f9                	mov    %edi,%ecx
1d8b  232ea2b:	80 e1 07             	and    $0x7,%cl
1d8e  232ea2e:	38 c1                	cmp    %al,%cl
1d90  232ea30:	0f 8c 7c ea ff ff    	jl     232d4b2 <adm1275_probe+0x812>
1d96  232ea36:	e8 00 00 00 00       	call   232ea3b <adm1275_probe+0x1d9b>	232ea37: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1d9b  232ea3b:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1da0  232ea40:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1daa  232ea4a:	e9 63 ea ff ff       	jmp    232d4b2 <adm1275_probe+0x812>
1daf  232ea4f:	89 f9                	mov    %edi,%ecx
1db1  232ea51:	80 e1 07             	and    $0x7,%cl
1db4  232ea54:	38 c1                	cmp    %al,%cl
1db6  232ea56:	0f 8c 70 ea ff ff    	jl     232d4cc <adm1275_probe+0x82c>
1dbc  232ea5c:	e8 00 00 00 00       	call   232ea61 <adm1275_probe+0x1dc1>	232ea5d: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1dc1  232ea61:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1dc6  232ea66:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1dd0  232ea70:	e9 57 ea ff ff       	jmp    232d4cc <adm1275_probe+0x82c>
1dd5  232ea75:	89 f9                	mov    %edi,%ecx
1dd7  232ea77:	80 e1 07             	and    $0x7,%cl
1dda  232ea7a:	38 c1                	cmp    %al,%cl
1ddc  232ea7c:	0f 8c 64 ea ff ff    	jl     232d4e6 <adm1275_probe+0x846>
1de2  232ea82:	e8 00 00 00 00       	call   232ea87 <adm1275_probe+0x1de7>	232ea83: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1de7  232ea87:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1dec  232ea8c:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1df6  232ea96:	e9 4b ea ff ff       	jmp    232d4e6 <adm1275_probe+0x846>
1dfb  232ea9b:	89 d9                	mov    %ebx,%ecx
1dfd  232ea9d:	80 e1 07             	and    $0x7,%cl
1e00  232eaa0:	38 c1                	cmp    %al,%cl
1e02  232eaa2:	0f 8c 58 ea ff ff    	jl     232d500 <adm1275_probe+0x860>
1e08  232eaa8:	48 89 df             	mov    %rbx,%rdi
1e0b  232eaab:	e8 00 00 00 00       	call   232eab0 <adm1275_probe+0x1e10>	232eaac: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1e10  232eab0:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1e15  232eab5:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1e1f  232eabf:	e9 3c ea ff ff       	jmp    232d500 <adm1275_probe+0x860>
1e24  232eac4:	89 d9                	mov    %ebx,%ecx
1e26  232eac6:	80 e1 07             	and    $0x7,%cl
1e29  232eac9:	38 c1                	cmp    %al,%cl
1e2b  232eacb:	0f 8c 0f eb ff ff    	jl     232d5e0 <adm1275_probe+0x940>
1e31  232ead1:	48 89 df             	mov    %rbx,%rdi
1e34  232ead4:	e8 00 00 00 00       	call   232ead9 <adm1275_probe+0x1e39>	232ead5: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1e39  232ead9:	8b 7c 24 08          	mov    0x8(%rsp),%edi
1e3d  232eadd:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1e42  232eae2:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1e4c  232eaec:	e9 ef ea ff ff       	jmp    232d5e0 <adm1275_probe+0x940>
1e51  232eaf1:	44 89 e1             	mov    %r12d,%ecx
1e54  232eaf4:	80 e1 07             	and    $0x7,%cl
1e57  232eaf7:	80 c1 03             	add    $0x3,%cl
1e5a  232eafa:	38 c1                	cmp    %al,%cl
1e5c  232eafc:	0f 8c fb ea ff ff    	jl     232d5fd <adm1275_probe+0x95d>
1e62  232eb02:	4c 89 e7             	mov    %r12,%rdi
1e65  232eb05:	e8 00 00 00 00       	call   232eb0a <adm1275_probe+0x1e6a>	232eb06: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
1e6a  232eb0a:	8b 7c 24 08          	mov    0x8(%rsp),%edi
1e6e  232eb0e:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1e73  232eb13:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1e7d  232eb1d:	e9 db ea ff ff       	jmp    232d5fd <adm1275_probe+0x95d>
1e82  232eb22:	89 f9                	mov    %edi,%ecx
1e84  232eb24:	80 e1 07             	and    $0x7,%cl
1e87  232eb27:	38 c1                	cmp    %al,%cl
1e89  232eb29:	0f 8c 34 eb ff ff    	jl     232d663 <adm1275_probe+0x9c3>
1e8f  232eb2f:	e8 00 00 00 00       	call   232eb34 <adm1275_probe+0x1e94>	232eb30: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1e94  232eb34:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1e99  232eb39:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1ea3  232eb43:	e9 1b eb ff ff       	jmp    232d663 <adm1275_probe+0x9c3>
1ea8  232eb48:	89 d9                	mov    %ebx,%ecx
1eaa  232eb4a:	80 e1 07             	and    $0x7,%cl
1ead  232eb4d:	38 c1                	cmp    %al,%cl
1eaf  232eb4f:	0f 8c 28 eb ff ff    	jl     232d67d <adm1275_probe+0x9dd>
1eb5  232eb55:	48 89 df             	mov    %rbx,%rdi
1eb8  232eb58:	e8 00 00 00 00       	call   232eb5d <adm1275_probe+0x1ebd>	232eb59: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1ebd  232eb5d:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1ec2  232eb62:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1ecc  232eb6c:	e9 0c eb ff ff       	jmp    232d67d <adm1275_probe+0x9dd>
1ed1  232eb71:	44 89 e1             	mov    %r12d,%ecx
1ed4  232eb74:	80 e1 07             	and    $0x7,%cl
1ed7  232eb77:	80 c1 03             	add    $0x3,%cl
1eda  232eb7a:	38 c1                	cmp    %al,%cl
1edc  232eb7c:	0f 8c 2e eb ff ff    	jl     232d6b0 <adm1275_probe+0xa10>
1ee2  232eb82:	4c 89 e7             	mov    %r12,%rdi
1ee5  232eb85:	44 89 c3             	mov    %r8d,%ebx
1ee8  232eb88:	e8 00 00 00 00       	call   232eb8d <adm1275_probe+0x1eed>	232eb89: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
1eed  232eb8d:	41 89 d8             	mov    %ebx,%r8d
1ef0  232eb90:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1ef5  232eb95:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1eff  232eb9f:	e9 0c eb ff ff       	jmp    232d6b0 <adm1275_probe+0xa10>
1f04  232eba4:	89 f9                	mov    %edi,%ecx
1f06  232eba6:	80 e1 07             	and    $0x7,%cl
1f09  232eba9:	38 c1                	cmp    %al,%cl
1f0b  232ebab:	0f 8c 9e eb ff ff    	jl     232d74f <adm1275_probe+0xaaf>
1f11  232ebb1:	e8 00 00 00 00       	call   232ebb6 <adm1275_probe+0x1f16>	232ebb2: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1f16  232ebb6:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1f1b  232ebbb:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1f25  232ebc5:	e9 85 eb ff ff       	jmp    232d74f <adm1275_probe+0xaaf>
1f2a  232ebca:	89 d9                	mov    %ebx,%ecx
1f2c  232ebcc:	80 e1 07             	and    $0x7,%cl
1f2f  232ebcf:	38 c1                	cmp    %al,%cl
1f31  232ebd1:	0f 8c 92 eb ff ff    	jl     232d769 <adm1275_probe+0xac9>
1f37  232ebd7:	48 89 df             	mov    %rbx,%rdi
1f3a  232ebda:	e8 00 00 00 00       	call   232ebdf <adm1275_probe+0x1f3f>	232ebdb: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1f3f  232ebdf:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1f44  232ebe4:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1f4e  232ebee:	e9 76 eb ff ff       	jmp    232d769 <adm1275_probe+0xac9>
1f53  232ebf3:	44 89 e1             	mov    %r12d,%ecx
1f56  232ebf6:	80 e1 07             	and    $0x7,%cl
1f59  232ebf9:	80 c1 03             	add    $0x3,%cl
1f5c  232ebfc:	38 c1                	cmp    %al,%cl
1f5e  232ebfe:	0f 8c e9 eb ff ff    	jl     232d7ed <adm1275_probe+0xb4d>
1f64  232ec04:	48 89 fb             	mov    %rdi,%rbx
1f67  232ec07:	4c 89 e7             	mov    %r12,%rdi
1f6a  232ec0a:	45 89 c5             	mov    %r8d,%r13d
1f6d  232ec0d:	e8 00 00 00 00       	call   232ec12 <adm1275_probe+0x1f72>	232ec0e: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
1f72  232ec12:	45 89 e8             	mov    %r13d,%r8d
1f75  232ec15:	48 89 df             	mov    %rbx,%rdi
1f78  232ec18:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1f7d  232ec1d:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1f87  232ec27:	e9 c1 eb ff ff       	jmp    232d7ed <adm1275_probe+0xb4d>
1f8c  232ec2c:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
1f91  232ec31:	80 e1 07             	and    $0x7,%cl
1f94  232ec34:	80 c1 03             	add    $0x3,%cl
1f97  232ec37:	38 c1                	cmp    %al,%cl
1f99  232ec39:	0f 8c 1c ec ff ff    	jl     232d85b <adm1275_probe+0xbbb>
1f9f  232ec3f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
1fa4  232ec44:	45 89 c5             	mov    %r8d,%r13d
1fa7  232ec47:	e8 00 00 00 00       	call   232ec4c <adm1275_probe+0x1fac>	232ec48: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
1fac  232ec4c:	45 89 e8             	mov    %r13d,%r8d
1faf  232ec4f:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1fb4  232ec54:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1fb9  232ec59:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1fc3  232ec63:	e9 f3 eb ff ff       	jmp    232d85b <adm1275_probe+0xbbb>
1fc8  232ec68:	89 d9                	mov    %ebx,%ecx
1fca  232ec6a:	80 e1 07             	and    $0x7,%cl
1fcd  232ec6d:	38 c1                	cmp    %al,%cl
1fcf  232ec6f:	0f 8c 52 e9 ff ff    	jl     232d5c7 <adm1275_probe+0x927>
1fd5  232ec75:	48 89 df             	mov    %rbx,%rdi
1fd8  232ec78:	e8 00 00 00 00       	call   232ec7d <adm1275_probe+0x1fdd>	232ec79: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
1fdd  232ec7d:	8b 7c 24 08          	mov    0x8(%rsp),%edi
1fe1  232ec81:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
1fe6  232ec86:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1ff0  232ec90:	e9 32 e9 ff ff       	jmp    232d5c7 <adm1275_probe+0x927>
1ff5  232ec95:	89 d9                	mov    %ebx,%ecx
1ff7  232ec97:	80 e1 07             	and    $0x7,%cl
1ffa  232ec9a:	38 c1                	cmp    %al,%cl
1ffc  232ec9c:	0f 8c a8 e9 ff ff    	jl     232d64a <adm1275_probe+0x9aa>
2002  232eca2:	48 89 df             	mov    %rbx,%rdi
2005  232eca5:	e8 00 00 00 00       	call   232ecaa <adm1275_probe+0x200a>	232eca6: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
200a  232ecaa:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
200f  232ecaf:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
2019  232ecb9:	e9 8c e9 ff ff       	jmp    232d64a <adm1275_probe+0x9aa>
201e  232ecbe:	89 d9                	mov    %ebx,%ecx
2020  232ecc0:	80 e1 07             	and    $0x7,%cl
2023  232ecc3:	38 c1                	cmp    %al,%cl
2025  232ecc5:	0f 8c 66 ea ff ff    	jl     232d731 <adm1275_probe+0xa91>
202b  232eccb:	48 89 df             	mov    %rbx,%rdi
202e  232ecce:	e8 00 00 00 00       	call   232ecd3 <adm1275_probe+0x2033>	232eccf: R_X86_64_PLT32	__asan_report_store1_noabort-0x4
2033  232ecd3:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
2038  232ecd8:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
2042  232ece2:	e9 4a ea ff ff       	jmp    232d731 <adm1275_probe+0xa91>
2047  232ece7:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
204c  232ecec:	80 e1 07             	and    $0x7,%cl
204f  232ecef:	80 c1 03             	add    $0x3,%cl
2052  232ecf2:	38 c1                	cmp    %al,%cl
2054  232ecf4:	0f 8c a9 ea ff ff    	jl     232d7a3 <adm1275_probe+0xb03>
205a  232ecfa:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
205f  232ecff:	e8 00 00 00 00       	call   232ed04 <adm1275_probe+0x2064>	232ed00: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
2064  232ed04:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
2069  232ed09:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
2073  232ed13:	e9 8b ea ff ff       	jmp    232d7a3 <adm1275_probe+0xb03>
2078  232ed18:	44 89 e1             	mov    %r12d,%ecx
207b  232ed1b:	80 e1 07             	and    $0x7,%cl
207e  232ed1e:	80 c1 03             	add    $0x3,%cl
2081  232ed21:	38 c1                	cmp    %al,%cl
2083  232ed23:	0f 8c a5 eb ff ff    	jl     232d8ce <adm1275_probe+0xc2e>
2089  232ed29:	49 89 fc             	mov    %rdi,%r12
208c  232ed2c:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
2091  232ed31:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
2096  232ed36:	45 89 dd             	mov    %r11d,%r13d
2099  232ed39:	e8 00 00 00 00       	call   232ed3e <adm1275_probe+0x209e>	232ed3a: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
209e  232ed3e:	45 89 eb             	mov    %r13d,%r11d
20a1  232ed41:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
20a6  232ed46:	4c 89 e7             	mov    %r12,%rdi
20a9  232ed49:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
20ae  232ed4e:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
20b3  232ed53:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
20bd  232ed5d:	e9 6c eb ff ff       	jmp    232d8ce <adm1275_probe+0xc2e>
20c2  232ed62:	44 89 e1             	mov    %r12d,%ecx
20c5  232ed65:	80 e1 07             	and    $0x7,%cl
20c8  232ed68:	80 c1 03             	add    $0x3,%cl
20cb  232ed6b:	38 c1                	cmp    %al,%cl
20cd  232ed6d:	0f 8c 8f eb ff ff    	jl     232d902 <adm1275_probe+0xc62>
20d3  232ed73:	49 89 fd             	mov    %rdi,%r13
20d6  232ed76:	4c 89 e7             	mov    %r12,%rdi
20d9  232ed79:	45 89 c7             	mov    %r8d,%r15d
20dc  232ed7c:	44 89 db             	mov    %r11d,%ebx
20df  232ed7f:	e8 00 00 00 00       	call   232ed84 <adm1275_probe+0x20e4>	232ed80: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
20e4  232ed84:	41 89 db             	mov    %ebx,%r11d
20e7  232ed87:	45 89 f8             	mov    %r15d,%r8d
20ea  232ed8a:	4c 89 ef             	mov    %r13,%rdi
20ed  232ed8d:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
20f2  232ed92:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
20fc  232ed9c:	e9 61 eb ff ff       	jmp    232d902 <adm1275_probe+0xc62>
2101  232eda1:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
210c  232edac:	0f 1f 40 00          	nopl   0x0(%rax)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
