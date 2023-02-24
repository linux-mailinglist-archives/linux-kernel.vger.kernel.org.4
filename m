Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6D6A2421
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBXWRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBXWRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:17:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A350199E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677277032; x=1708813032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1zn5LRVaEjUKXrDtSzrbPheNzGYbFT6PbXB8m5y5GgI=;
  b=XCsAepgjDV3bHAtmVW1Qjdi9hdKDffZD/L2tMqFEaPLMs6xgXCuYSts5
   ND98srkm89mWXMuAwPt9w5sthaL+XtC6j96nTFcG3WSieQpq1WBAup+yM
   g8NKcxf2o2qvcWYIilFUbxcx4p7LrwphFD8n4n56OpuLzbu9mJyfTrRoS
   DGdPQRiWY54dB8u5pWRht86RYopn23eP/HuITM/fWyMjH7Q3w7p0VMa9s
   v0t9vSOzQnhNgJOQFvbw0hXMUcnYbVWAJEe6/XxLtHGpGpv8Juani0BSd
   LM3Vt4Olj2wTKK/ygyLmh0mFq9nR98Kadf4ic3MIjoapJXvCXVWXgbraJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="317350128"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="317350128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 14:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="703325953"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="703325953"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2023 14:17:09 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVgNI-0002lD-2s;
        Fri, 24 Feb 2023 22:17:08 +0000
Date:   Sat, 25 Feb 2023 06:16:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        chenzhongjin@huawei.com, akpm@linux-foudation.org,
        wuchi.zero@gmail.com, ben-linux@fluff.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
Message-ID: <202302250609.vmze90DB-lkp@intel.com>
References: <20230224084945.134038-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224084945.134038-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.2 next-20230224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Zhongjin/x86-profiling-Set-prof_cpu_mask-to-NULL-after-free/20230224-165419
patch link:    https://lore.kernel.org/r/20230224084945.134038-1-chenzhongjin%40huawei.com
patch subject: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
config: arm-randconfig-r004-20230222 (https://download.01.org/0day-ci/archive/20230225/202302250609.vmze90DB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/ed9b4879e816862f4f6210b1c429bcbebac6d317
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chen-Zhongjin/x86-profiling-Set-prof_cpu_mask-to-NULL-after-free/20230224-165419
        git checkout ed9b4879e816862f4f6210b1c429bcbebac6d317
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302250609.vmze90DB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/profile.c:136:16: error: array type 'cpumask_var_t' (aka 'struct cpumask[1]') is not assignable
           prof_cpu_mask = NULL;
           ~~~~~~~~~~~~~ ^
   1 error generated.


vim +136 kernel/profile.c

    98	
    99	
   100	int __ref profile_init(void)
   101	{
   102		int buffer_bytes;
   103		if (!prof_on)
   104			return 0;
   105	
   106		/* only text is profiled */
   107		prof_len = (_etext - _stext) >> prof_shift;
   108	
   109		if (!prof_len) {
   110			pr_warn("profiling shift: %u too large\n", prof_shift);
   111			prof_on = 0;
   112			return -EINVAL;
   113		}
   114	
   115		buffer_bytes = prof_len*sizeof(atomic_t);
   116	
   117		if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
   118			return -ENOMEM;
   119	
   120		cpumask_copy(prof_cpu_mask, cpu_possible_mask);
   121	
   122		prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
   123		if (prof_buffer)
   124			return 0;
   125	
   126		prof_buffer = alloc_pages_exact(buffer_bytes,
   127						GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN);
   128		if (prof_buffer)
   129			return 0;
   130	
   131		prof_buffer = vzalloc(buffer_bytes);
   132		if (prof_buffer)
   133			return 0;
   134	
   135		free_cpumask_var(prof_cpu_mask);
 > 136		prof_cpu_mask = NULL;
   137		return -ENOMEM;
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
