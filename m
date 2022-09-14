Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA955B8688
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiINKnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiINKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:43:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F5378581
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663152179; x=1694688179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vp0eGXwV90GWfbMI665R9Cdn+zG5V4Ss1cf3iuS0xSQ=;
  b=nYC4dhRmmc5ugUeDOwZMbAciHaeFZ4GVpYtrk0+KNmyUCkai4/m2Mt5T
   dVEvQtSrcZ68hJ/GNcqsVVcCCYzDCJ/0B8sX6GmIrNfdl++QcdmV3T/5G
   hDhojtSnWevPa9+EWUzWhC+V+gx0IPgjIEdZ3+sqmoyt9YXUqA+/gJuNu
   GnIJpA42qMfO8KBuPXp3lhAgt+CgJ2cwngr7fmed6mkgz0l3D+0d4UwhM
   rLsmfJALuGhFKdNov6QbiTFFscGG4OIfqHpRo+9yCWNXPIR8+3MFk+odM
   ZZDc1jjNkJ2Nylm8F3s68SFf4jG5Xdy44SXh88idsT07KcK8Iyl476YSc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="299754517"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299754517"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 03:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="647343438"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2022 03:42:57 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYPr7-00006u-0D;
        Wed, 14 Sep 2022 10:42:57 +0000
Date:   Wed, 14 Sep 2022 18:42:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof:20220913-test-sysfs 9/11]
 fs/kernfs/kernfs-internal.h:239:43: warning: statement with no effect
Message-ID: <202209141853.6zXXC9T7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git 20220913-test-sysfs
head:   fd13723170f4a2381aab0b6449920c121f01a10a
commit: 010fe7c173f104fbec6c1d56c3a92e2b88281ec8 [9/11] kernfs: add initial failure injection support
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220914/202209141853.6zXXC9T7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=010fe7c173f104fbec6c1d56c3a92e2b88281ec8
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof 20220913-test-sysfs
        git checkout 010fe7c173f104fbec6c1d56c3a92e2b88281ec8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/kernfs/file.c:19:
   fs/kernfs/file.c: In function 'kernfs_fop_write_iter':
>> fs/kernfs/kernfs-internal.h:239:43: warning: statement with no effect [-Wunused-value]
     239 | #define may_wait_kernfs_debug(func, when) (false)
         |                                           ^
   fs/kernfs/file.c:320:9: note: in expansion of macro 'may_wait_kernfs_debug'
     320 |         may_wait_kernfs_debug(kernfs_fop_write_iter, at_start);
         |         ^~~~~~~~~~~~~~~~~~~~~
>> fs/kernfs/kernfs-internal.h:239:43: warning: statement with no effect [-Wunused-value]
     239 | #define may_wait_kernfs_debug(func, when) (false)
         |                                           ^
   fs/kernfs/file.c:343:9: note: in expansion of macro 'may_wait_kernfs_debug'
     343 |         may_wait_kernfs_debug(kernfs_fop_write_iter, before_mutex);
         |         ^~~~~~~~~~~~~~~~~~~~~
>> fs/kernfs/kernfs-internal.h:239:43: warning: statement with no effect [-Wunused-value]
     239 | #define may_wait_kernfs_debug(func, when) (false)
         |                                           ^
   fs/kernfs/file.c:351:9: note: in expansion of macro 'may_wait_kernfs_debug'
     351 |         may_wait_kernfs_debug(kernfs_fop_write_iter, after_mutex);
         |         ^~~~~~~~~~~~~~~~~~~~~
>> fs/kernfs/kernfs-internal.h:239:43: warning: statement with no effect [-Wunused-value]
     239 | #define may_wait_kernfs_debug(func, when) (false)
         |                                           ^
   fs/kernfs/file.c:359:9: note: in expansion of macro 'may_wait_kernfs_debug'
     359 |         may_wait_kernfs_debug(kernfs_fop_write_iter, after_active);
         |         ^~~~~~~~~~~~~~~~~~~~~


vim +239 fs/kernfs/kernfs-internal.h

   233	
   234	#define may_wait_kernfs_debug(func, when) \
   235		__kernfs_debug_should_wait_func_name(func)(__kernfs_config_wait_var(func, when))
   236	void __kernfs_debug_should_wait_kernfs_fop_write_iter(bool evaluate);
   237	#else
   238	static inline void kernfs_init_failure_injection(void) {}
 > 239	#define may_wait_kernfs_debug(func, when) (false)
   240	#endif
   241	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
