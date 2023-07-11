Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2074E30C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGKBLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKBLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:11:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAAF12A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689037883; x=1720573883;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8yFX+AsV8aldEHCukS66PL3czvDBnWH5sTSwaobkDIg=;
  b=KjY+hwFZsP5gVKWlJRwkBb4CimFSvwRFES835qVQjXNqakZgqXgtvEK5
   76o2Af4YG/6hVKMssfkrFh6NbEU8KL/N8s1gQfFBv8PBc3p0gPA5Pn1S9
   Dv8l4An/qqNIcAvnvRPQF6iUcNNaIjbE12i5sU8AW1ZujMWubN6uEkGbq
   aOUZRSukDe0SZ9GM4UBAxOg2ALvBLr2YNhSxU319A1GTv4KsHyg6pCnYP
   AuUZH2WfiL+pLw9ONsu/mzIOCo0AYaDfnp1CRf8BLUHLIiMh/pMUsku+o
   IQ3Zfrg/6LZyRUojWUP0hhlf0t3li8GWzRijewNucocxYKQMaH1dYsBrE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="450858564"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="450858564"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="786413007"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="786413007"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2023 18:09:34 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJ1sj-00049j-2f;
        Tue, 11 Jul 2023 01:09:33 +0000
Date:   Tue, 11 Jul 2023 09:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230710 2/5]
 arch/sparc/mm/init_64.c:3057:31: error: array subscript -1 is outside array
 bounds of 'char[]'
Message-ID: <202307110949.RG8TpHLo-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230710
head:   58f872f0089daa911786fdbd13d48a0c9147e5b1
commit: b30a1743f607192532d6ad43a08cdbd80051ca5a [2/5] Makefile: Enable -Warray-bounds
config: sparc64-randconfig-r002-20230710 (https://download.01.org/0day-ci/archive/20230711/202307110949.RG8TpHLo-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230711/202307110949.RG8TpHLo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307110949.RG8TpHLo-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/mm/init_64.c: In function 'sun4v_linear_pte_xor_finalize':
   arch/sparc/mm/init_64.c:2206:23: error: variable 'pagecv_flag' set but not used [-Werror=unused-but-set-variable]
    2206 |         unsigned long pagecv_flag;
         |                       ^~~~~~~~~~~
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
