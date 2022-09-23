Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC835E7455
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIWGqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWGqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:46:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A012872E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663915598; x=1695451598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kyzKF1UxOMqD7bXHRGhbn0uk1KyRlos8hcVLWQjc6cw=;
  b=Vj0h2wls2bV0SJvIWfBNe2ttNNUdmX4wyYcuTY4/ERlCIEJZgFiknEf5
   FRUZLAxp6yIBPDZGa7XHW9YZWn+CMJw8hxjg3+R9D7L2iDKy32pG8nmMX
   7+M4i6pp/rXSLz5lZzjg+pZIYgDImq6nqTSXxaOtKmfJQ3yZ8sg6tJYoJ
   La+SkX5XyGRmkrlW9dXB11Ka6Sx1zuTf5Sb5ArQ79EQkfCa7zZSRpntX7
   Vl0x40B6DmSfdZ2YB6yvEsHYEXxsJ85fnJq2/Qyffx32fW1a8Aw1IfR8M
   FO1Xt+6ekCeqotQzTyLn8WepKT1xNUUMIr5e/B1X11eDst/K0khYcHWJH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="299247054"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="299247054"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 23:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="948914692"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2022 23:46:36 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obcSK-0005Oy-12;
        Fri, 23 Sep 2022 06:46:36 +0000
Date:   Fri, 23 Sep 2022 14:46:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:brauner/linux/fs.acl.rework 14/37]
 include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
Message-ID: <202209231457.7v2os2VI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block brauner/linux/fs.acl.rework
head:   6d56d354d97c08df55b4c06e1f45903f000b7c7c
commit: 0e0086267b0b7a344703522106b34069ca5e9aad [14/37] 9p: implement get acl method
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220923/202209231457.7v2os2VI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/0e0086267b0b7a344703522106b34069ca5e9aad
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block brauner/linux/fs.acl.rework
        git checkout 0e0086267b0b7a344703522106b34069ca5e9aad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

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
   fs/9p/acl.h:23:26: note: in expansion of macro 'NULL'
      23 | #define v9fs_iop_get_acl NULL
         |                          ^~~~
   fs/9p/acl.h:29:1: note: in expansion of macro 'v9fs_iop_get_acl'
      29 | v9fs_iop_get_acl(struct user_namespace *mnt_userns,
         | ^~~~~~~~~~~~~~~~
>> include/linux/stddef.h:8:23: error: expected ')' before numeric constant
       8 | #define NULL ((void *)0)
         |                       ^
   fs/9p/acl.h:23:26: note: in expansion of macro 'NULL'
      23 | #define v9fs_iop_get_acl NULL
         |                          ^~~~
   fs/9p/acl.h:29:1: note: in expansion of macro 'v9fs_iop_get_acl'
      29 | v9fs_iop_get_acl(struct user_namespace *mnt_userns,
         | ^~~~~~~~~~~~~~~~


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
