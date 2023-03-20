Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739CF6C231A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCTUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCTUqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:46:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D95B77A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679345164; x=1710881164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nG9z2mIpY0pmClQ/aPb+2zS9ZPtLznn84H1DH17P5sk=;
  b=kdHLp0dq1BRyt7INsNXEFvFHEOOKcav6gj9cqbDFpoPxjz1J4+bdiLub
   ijKFx95cBEuVE4mjbfBRyL73jOwNve8FXgHhAvdueurzIS0Hy8yw6usvg
   TlBkPRC62rHFL1MvhExojf15+KtlGgrKig3n6g+3OuNnZjex8+peFZfjZ
   OeiJVKYMVxik+H7MWzbZGDi3jH+zpwc2aEEvUQbbmjlsVfwK76WqlrKnt
   5xtvG2WIJ1x9ElwFJ/nAui/jEID/mZSEP7ZnCc2GkEq7w77LlIjZr9aMP
   LE1W9IKo1tND+XVHXy/2ydW93XMC+L+eda2fncvtp6RCg4hUklE9ujgzF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340322702"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="340322702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="658505668"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="658505668"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2023 13:46:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peMOC-000BJE-1o;
        Mon, 20 Mar 2023 20:45:56 +0000
Date:   Tue, 21 Mar 2023 04:45:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: arch/x86/xen/enlighten_pvh.c:55:10: warning: comparison of distinct
 pointer types ('typeof (ret * sizeof(char)) *' (aka 'unsigned long *') and
 'typeof (sizeof (op.u.dom0_console)) *' (aka 'unsigned int *'))
Message-ID: <202303210458.T1bzVRT2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d31677bb7b1944ac89e9155110dc1b9acbb3895
commit: 934ef33ee75c3846f605f18b65048acd147e3918 x86/PVH: obtain VGA console info in Dom0
date:   6 days ago
config: i386-buildonly-randconfig-r006-20230320 (https://download.01.org/0day-ci/archive/20230321/202303210458.T1bzVRT2-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=934ef33ee75c3846f605f18b65048acd147e3918
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 934ef33ee75c3846f605f18b65048acd147e3918
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/xen/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210458.T1bzVRT2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/xen/enlighten_pvh.c:55:10: warning: comparison of distinct pointer types ('typeof (ret * sizeof(char)) *' (aka 'unsigned long *') and 'typeof (sizeof (op.u.dom0_console)) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                                        min(ret * sizeof(char),
                                        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +55 arch/x86/xen/enlighten_pvh.c

    27	
    28	void __init xen_pvh_init(struct boot_params *boot_params)
    29	{
    30		u32 msr;
    31		u64 pfn;
    32	
    33		xen_pvh = 1;
    34		xen_domain_type = XEN_HVM_DOMAIN;
    35		xen_start_flags = pvh_start_info.flags;
    36	
    37		msr = cpuid_ebx(xen_cpuid_base() + 2);
    38		pfn = __pa(hypercall_page);
    39		wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
    40	
    41		if (xen_initial_domain())
    42			x86_init.oem.arch_setup = xen_add_preferred_consoles;
    43		x86_init.oem.banner = xen_banner;
    44	
    45		xen_efi_init(boot_params);
    46	
    47		if (xen_initial_domain()) {
    48			struct xen_platform_op op = {
    49				.cmd = XENPF_get_dom0_console,
    50			};
    51			long ret = HYPERVISOR_platform_op(&op);
    52	
    53			if (ret > 0)
    54				xen_init_vga(&op.u.dom0_console,
  > 55					     min(ret * sizeof(char),
    56						 sizeof(op.u.dom0_console)),
    57					     &boot_params->screen_info);
    58		}
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
