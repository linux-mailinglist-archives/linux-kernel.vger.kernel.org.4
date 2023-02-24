Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B836A1FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBXQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBXQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:27:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F56B176
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677256038; x=1708792038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vtFjZDmPLPxtTSQVYru6QowiAzLoJNAikJQrTApB+Jc=;
  b=DDf2UuCUF/Zf8k+eB/4cOdb/uh4mlUXyJXBRdEwhxmdXlWJuVkeBVA1e
   ifVXKQrYjsZXlYFNwR+7njUTpmI1SI3NFIMu/R2vq3teXgcjxJmvgdDVo
   wp2eubtOKC29fif0ytoqvSEDZJ4BXSGnznmLwBecfEyQBXCSS9fRLO93Q
   I+ntXuEddrHGWPvX7a5PiTh2Y1R8STadunSPWzhyUAJeS4AY4IDBtPI50
   +P0NvkfEdDpji85kdPjNcqGrOOprMxqBo2y8Q4IkPoJnswkfoUpHmPH5J
   oQ0Y3PyIhEozvK4UYtJC5/M3/B7sfcjeNG1YdnEQTDoitoWu/gO6ygqD0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="317273629"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="317273629"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:27:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="705322966"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="705322966"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Feb 2023 08:26:58 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVauO-0002Xf-3B;
        Fri, 24 Feb 2023 16:26:56 +0000
Date:   Sat, 25 Feb 2023 00:26:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, chenzhongjin@huawei.com,
        akpm@linux-foudation.org, wuchi.zero@gmail.com,
        ben-linux@fluff.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
Message-ID: <202302250053.73MumSNs-lkp@intel.com>
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
[also build test ERROR on next-20230224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Zhongjin/x86-profiling-Set-prof_cpu_mask-to-NULL-after-free/20230224-165419
patch link:    https://lore.kernel.org/r/20230224084945.134038-1-chenzhongjin%40huawei.com
patch subject: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
config: openrisc-randconfig-r012-20230222 (https://download.01.org/0day-ci/archive/20230225/202302250053.73MumSNs-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ed9b4879e816862f4f6210b1c429bcbebac6d317
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chen-Zhongjin/x86-profiling-Set-prof_cpu_mask-to-NULL-after-free/20230224-165419
        git checkout ed9b4879e816862f4f6210b1c429bcbebac6d317
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302250053.73MumSNs-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/profile.c: In function 'profile_init':
>> kernel/profile.c:136:23: error: assignment to expression with array type
     136 |         prof_cpu_mask = NULL;
         |                       ^


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
