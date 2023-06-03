Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F067720CBD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjFCAyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbjFCAy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:54:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68659E58
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685753651; x=1717289651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QAPddGkl4Y6bFRMNYXsIoz34myr25dASeh5lk8GwMfA=;
  b=OGQZ0oubjkvps+yjxppr0kXKL2zkk6FVhJlKkfw6CqDhqGuFVipeT47q
   xw1L1VbmDQsVDe3QRnO5OjszuMJEZbbEn5Eoj1PbJKD1R7J/2rRsP+uO5
   D/R64KAfRP1GkjD258AWaRKR9wUacFnBoMNVQC9+/E15AWCLDD2Su9yDD
   32o/wZZaO0XtGYF3QBeGGeRSO1x3j/EKh5NdGFm2jAvdysDPhDGu+/jtH
   0YqShF4xszgytqR91GPGLZpfXGgAdhYcMJTA1mJ1puDu1qRbLgQdj17Z+
   HpnGwgBEGHRovElCKAUwmFKR4M6e7AdY8rSH5vnsdtp/xBSEGwvYvguNq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="335628792"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="335628792"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 17:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="711153760"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="711153760"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jun 2023 17:54:08 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5FWy-00016T-01;
        Sat, 03 Jun 2023 00:54:08 +0000
Date:   Sat, 3 Jun 2023 08:54:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230602 7/7]
 arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array
 bounds of 'char[]'
Message-ID: <202306030823.XYmbFKNB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230602
head:   20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
commit: 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8 [7/7] Makefile: Enable -Warray-bounds
config: sparc64-randconfig-r001-20230602 (https://download.01.org/0day-ci/archive/20230603/202306030823.XYmbFKNB-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fam01-next20230602
        git checkout 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030823.XYmbFKNB-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
   arch/sparc/mm/init_64.c:355:24: error: variable 'hv_pgsz_idx' set but not used [-Werror=unused-but-set-variable]
     355 |         unsigned short hv_pgsz_idx;
         |                        ^~~~~~~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3069:2:
>> arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3057 |         code_resource.end   = compute_kern_paddr(_etext - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/sections.h:6,
                    from include/linux/interrupt.h:21,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/hugetlb.h:10,
                    from arch/sparc/mm/init_64.c:16:
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:35:32: note: at offset -1 into object '_etext' of size [0, 9223372036854775807]
      35 | extern char _text[], _stext[], _etext[];
         |                                ^~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3069:2:
   arch/sparc/mm/init_64.c:3059:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3059 |         data_resource.end   = compute_kern_paddr(_edata - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:36:32: note: at offset -1 into object '_edata' of size [0, 9223372036854775807]
      36 | extern char _data[], _sdata[], _edata[];
         |                                ^~~~~~
   In function 'kernel_lds_init',
       inlined from 'report_memory' at arch/sparc/mm/init_64.c:3069:2:
   arch/sparc/mm/init_64.c:3061:31: error: array subscript -1 is outside array bounds of 'char[]' [-Werror=array-bounds]
    3061 |         bss_resource.end    = compute_kern_paddr(_end - 1);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/sections.h: In function 'report_memory':
   include/asm-generic/sections.h:41:13: note: at offset -1 into object '_end' of size [0, 9223372036854775807]
      41 | extern char _end[];
         |             ^~~~
   cc1: all warnings being treated as errors


vim +3057 arch/sparc/mm/init_64.c

f6d4fb5cc0475c bob picco 2014-03-03  3053  
f6d4fb5cc0475c bob picco 2014-03-03  3054  static void __init kernel_lds_init(void)
f6d4fb5cc0475c bob picco 2014-03-03  3055  {
f6d4fb5cc0475c bob picco 2014-03-03  3056  	code_resource.start = compute_kern_paddr(_text);
f6d4fb5cc0475c bob picco 2014-03-03 @3057  	code_resource.end   = compute_kern_paddr(_etext - 1);
f6d4fb5cc0475c bob picco 2014-03-03  3058  	data_resource.start = compute_kern_paddr(_etext);
f6d4fb5cc0475c bob picco 2014-03-03  3059  	data_resource.end   = compute_kern_paddr(_edata - 1);
f6d4fb5cc0475c bob picco 2014-03-03  3060  	bss_resource.start  = compute_kern_paddr(__bss_start);
f6d4fb5cc0475c bob picco 2014-03-03  3061  	bss_resource.end    = compute_kern_paddr(_end - 1);
f6d4fb5cc0475c bob picco 2014-03-03  3062  }
f6d4fb5cc0475c bob picco 2014-03-03  3063  

:::::: The code at line 3057 was first introduced by commit
:::::: f6d4fb5cc0475c36437a618db31cbb7f2bf7c282 sparc64 - add mem to iomem resource

:::::: TO: bob picco <bpicco@meloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
