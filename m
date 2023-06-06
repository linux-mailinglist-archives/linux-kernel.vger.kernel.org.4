Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E04724E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbjFFU6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjFFU63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:58:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33811707
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686085108; x=1717621108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P6rV6zh1DLRXX4p8uNL4qGR98w5JZ4Rkqc41z5Xvt6U=;
  b=Vt7QdEVJ/1fqh6is68hBydbeVPCiLp/01J/2B5hFzMMcWRymp6mdvpB5
   bintbYeY+inYn6IRva2+6KsGfQvkVE/4NWdWUXKrGOW+Y/IF6s8dK7V5a
   3h+UFqvH1WlnFEHurdqpZ688PDofk2hXbWCfAf7PVTJy+wgBlhAmLE++v
   iZcLHdfIEn4+DfeBNe2E7H3sJv6IPx5nqrx/h+OxVJijkISBSESbV2UgI
   zBvaDHs0TpkZbTCh3LUc1S6FVc2MEWj1D5XC13uCDSYTaZrNbD3DCufY3
   vSluxkCiTOY8ixHWtC+ax52bJhu3om1W5WSDB90H5inyjeFgHyXfPYBKx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="360121179"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="360121179"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 13:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799013151"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="799013151"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2023 13:58:14 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6dkr-0005jz-12;
        Tue, 06 Jun 2023 20:58:13 +0000
Date:   Wed, 7 Jun 2023 04:57:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: [tip:objtool/core 8/12] vmlinux.o: warning: objtool:
 rust_begin_unwind+0x5c: rust_helper_BUG() is missing a __noreturn annotation
Message-ID: <202306070408.EFxuDoRs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
head:   ff9a6459bbec06df7da2545020d7383aba13b3fb
commit: fedb724c3db5490234ddde0103811c28c2fedae0 [8/12] objtool: Detect missing __noreturn annotations
config: x86_64-randconfig-a012-20230606 (https://download.01.org/0day-ci/archive/20230607/202306070408.EFxuDoRs-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fedb724c3db5490234ddde0103811c28c2fedae0
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip objtool/core
        git checkout fedb724c3db5490234ddde0103811c28c2fedae0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306070408.EFxuDoRs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: rust_begin_unwind+0x5c: rust_helper_BUG() is missing a __noreturn annotation


objdump-func vmlinux.o rust_begin_unwind:
0000 00000000000b9e69 <rust_begin_unwind>:
0000    b9e69:	48 83 ec 48          	sub    $0x48,%rsp
0004    b9e6d:	48 89 e0             	mov    %rsp,%rax
0007    b9e70:	48 89 38             	mov    %rdi,(%rax)
000a    b9e73:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
000f    b9e78:	48 89 01             	mov    %rax,(%rcx)
0012    b9e7b:	48 c7 41 08 00 00 00 00 	movq   $0x0,0x8(%rcx)	b9e7f: R_X86_64_32S	_RNvXsR_NtCs3yuwAp0waWO_4core3fmtRNtNtNtB7_5panic10panic_info9PanicInfoNtB5_7Display3fmtCsfATHBUcknU9_6kernel
001a    b9e83:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
001f    b9e88:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)	b9e8b: R_X86_64_32S	.rodata+0x137d8
0026    b9e8f:	48 c7 42 08 02 00 00 00 	movq   $0x2,0x8(%rdx)
002e    b9e97:	48 c7 42 10 00 00 00 00 	movq   $0x0,0x10(%rdx)
0036    b9e9f:	48 89 4a 20          	mov    %rcx,0x20(%rdx)
003a    b9ea3:	48 c7 42 28 01 00 00 00 	movq   $0x1,0x28(%rdx)
0042    b9eab:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	b9eae: R_X86_64_32S	_RNvNtNtCsfATHBUcknU9_6kernel5print14format_strings5EMERG
0049    b9eb2:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	b9eb5: R_X86_64_32S	.rodata+0x13568
0050    b9eb9:	31 c0                	xor    %eax,%eax
0052    b9ebb:	e8 00 00 00 00       	call   b9ec0 <rust_begin_unwind+0x57>	b9ebc: R_X86_64_PLT32	_printk-0x4
0057    b9ec0:	e8 00 00 00 00       	call   b9ec5 <rust_begin_unwind+0x5c>	b9ec1: R_X86_64_PLT32	rust_helper_BUG-0x4
005c    b9ec5:	eb fe                	jmp    b9ec5 <rust_begin_unwind+0x5c>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
