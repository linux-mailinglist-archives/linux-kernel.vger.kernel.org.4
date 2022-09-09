Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308B95B4119
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIIUzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIIUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:55:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3896B48E9C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662756909; x=1694292909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nPrP1WSMW91u6+9Zjy6NLE2mHyKc0s4nd4OwNZov9BY=;
  b=amAwGrfXdYUEV8L+L1hOZI1CW4eVtSJSunnTZXfPb1asiJSjd3Eb/ryn
   XXXUUpthhW31jUOkCWF7xsNHIFy9LLfF/CaTDgOwoO764CJ7jwQlv5ZZ1
   G1FaG5yPZ4nFGicc3oyerAMe4wPQ5SDqK0V6I+NtDephMRRGijwmjjQ4U
   kgKA3cgBkvpT3ENEIQAwH2/LyRQtjfpRMmLRPr1ttG2WFH7TgkrX2bT9Z
   hiyIEGzOTJyT+Rjn6O5DPLhCjAQGjMt8VLgUb4oyN4TSNji/SoSaJhpZE
   cLS0MQcNwxVX5ZcXeMdf1TtENvZ7CxUwuFTKv+crzhlh0wEnsz/mKx6fl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="383864409"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="383864409"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="648575833"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Sep 2022 13:55:07 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWl1m-0001iq-2u;
        Fri, 09 Sep 2022 20:55:06 +0000
Date:   Sat, 10 Sep 2022 04:54:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vfs-idmapping:fs.posix_acl.vfsuid 15/37]
 include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
Message-ID: <202209100459.46yB9DOr-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git fs.posix_acl.vfsuid
head:   d37e11d9b40fc35810217121aa3205b7975fd4c6
commit: c45bf675834bb2d099f0a8375cadeb30f4d915e5 [15/37] 9p: add ->get_dentry_acl() method
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220910/202209100459.46yB9DOr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/commit/?id=c45bf675834bb2d099f0a8375cadeb30f4d915e5
        git remote add vfs-idmapping https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
        git fetch --no-tags vfs-idmapping fs.posix_acl.vfsuid
        git checkout c45bf675834bb2d099f0a8375cadeb30f4d915e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/limits.h:6,
                    from include/linux/kernel.h:16,
                    from fs/9p/vfs_super.c:8:
>> include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
       8 | #define NULL ((void *)0)
         |                ^~~~
   fs/9p/acl.h:23:33: note: in expansion of macro 'NULL'
      23 | #define v9fs_iop_get_dentry_acl NULL
         |                                 ^~~~
   fs/9p/acl.h:29:1: note: in expansion of macro 'v9fs_iop_get_dentry_acl'
      29 | v9fs_iop_get_dentry_acl(struct user_namespace *mnt_userns,
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/stddef.h:8:23: error: expected ')' before numeric constant
       8 | #define NULL ((void *)0)
         |                       ^
   fs/9p/acl.h:23:33: note: in expansion of macro 'NULL'
      23 | #define v9fs_iop_get_dentry_acl NULL
         |                                 ^~~~
   fs/9p/acl.h:29:1: note: in expansion of macro 'v9fs_iop_get_dentry_acl'
      29 | v9fs_iop_get_dentry_acl(struct user_namespace *mnt_userns,
         | ^~~~~~~~~~~~~~~~~~~~~~~


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

:::::: The code at line 8 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
