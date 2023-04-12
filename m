Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E716A6DF077
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjDLJcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDLJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:32:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE6109;
        Wed, 12 Apr 2023 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681291943; x=1712827943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6LyGJ7yfM5nnCxnEhnmLVXOixE8B8BrtZ8PeO9Ko7VM=;
  b=JUFfTsO2zkLbKyqQ02OG36alrqdy2BnQE0+WlxkD8Hr3zDu91W0ao6eW
   TA5524D2ofC2wMknVWcFohPXDrAGxLEbzhM+vq91jkdZno5th4rWeFAaD
   xCBKGuhnCqV98gkJEEvKq/YhoOwNDPY04Yxr6yLAxONISGvy9mXRxa1x1
   7miEHHWuXu0V6d3GeEDI2zbIasmDrVGCXgPqtwW3Jzq1J6xXnVW6glPjq
   moNrMLwug0SiCEJ1xU5qARjYdy1G0Z2/Okz/pEnrruHAzWlq6RQt7O/ci
   6n5CTYoD0Cx9rSyVmdDcka4gh6JPpQImYCzT/Dv1BMQ/BTwCRt8o1bDQy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="408987799"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="408987799"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 02:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="863236403"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="863236403"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2023 02:32:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmWpg-000XZn-0l;
        Wed, 12 Apr 2023 09:32:04 +0000
Date:   Wed, 12 Apr 2023 17:31:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, nathanl@linux.ibm.com,
        axboe@kernel.dk, konrad.wilk@oracle.com, joe.jin@oracle.com
Subject: Re: [PATCH] debugfs: allow access relay files in lockdown mode
Message-ID: <202304121714.6mahd9EW-lkp@intel.com>
References: <20230412001030.88441-1-junxiao.bi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412001030.88441-1-junxiao.bi@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junxiao,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.3-rc6 next-20230412]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junxiao-Bi/debugfs-allow-access-relay-files-in-lockdown-mode/20230412-081241
patch link:    https://lore.kernel.org/r/20230412001030.88441-1-junxiao.bi%40oracle.com
patch subject: [PATCH] debugfs: allow access relay files in lockdown mode
config: i386-randconfig-a015-20230410 (https://download.01.org/0day-ci/archive/20230412/202304121714.6mahd9EW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7891278613631bb6076e7b4603c1e907d1304cfa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Junxiao-Bi/debugfs-allow-access-relay-files-in-lockdown-mode/20230412-081241
        git checkout 7891278613631bb6076e7b4603c1e907d1304cfa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304121714.6mahd9EW-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/debugfs/file.o: in function `debugfs_locked_down':
>> fs/debugfs/file.c:163: undefined reference to `relay_file_operations'


vim +163 fs/debugfs/file.c

   141	
   142	/*
   143	 * Only permit access to world-readable files when the kernel is locked down.
   144	 * We also need to exclude any file that has ways to write or alter it as root
   145	 * can bypass the permissions check.
   146	 * Exception:
   147	 * Relay files are used by kernel to transfer information to userspace, these
   148	 * files have permission 0400, but mmap is supported, so they are blocked by
   149	 * lockdown. But since kernel just generates the contents of those files while
   150	 * not reading it, it is saft to access relay files in lockdown mode.
   151	 */
   152	static int debugfs_locked_down(struct inode *inode,
   153				       struct file *filp,
   154				       const struct file_operations *real_fops)
   155	{
   156		if ((inode->i_mode & 07777 & ~0444) == 0 &&
   157		    !(filp->f_mode & FMODE_WRITE) &&
   158		    !real_fops->unlocked_ioctl &&
   159		    !real_fops->compat_ioctl &&
   160		    !real_fops->mmap)
   161			return 0;
   162	
 > 163		if (real_fops == &relay_file_operations)
   164			return 0;
   165	
   166		if (security_locked_down(LOCKDOWN_DEBUGFS))
   167			return -EPERM;
   168	
   169		return 0;
   170	}
   171	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
