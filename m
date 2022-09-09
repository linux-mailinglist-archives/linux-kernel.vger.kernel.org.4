Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC95B3CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIIQWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiIIQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:22:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01268134634
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662740568; x=1694276568;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tNdc7eXTYaFmqQ42C8+BA9SfEmRFLPeZ41Hh9tii0MY=;
  b=jPXWGAPp/DyEjZ8CTgYINueslU7Fwbk8HZFl2kObM1o/oh+quDJJ2/VU
   cc7JX/8TtsayxZDM2ShAhXZMzvYaqpnDNhlp/QaOzceepRLLtaJhsjV86
   8a7mbx9odE0sHJM39xa/BnIL4w+KgzhN+CwPmnJXfd+GMYVfHPJqqAzl+
   oQyLmQgq5eOuRTVoaB4QF7U9IHnI84TidPXoMXTaD68UfnzL2+oHNV/Wd
   Z5ZFkpQTNsjKxbQmzZeCqiYykFFEUtor3wYGhWP2P+0Ke8/WOQoP/K7Oz
   99j2aYa7Qv1Y0IL0WNEVcHIuynU81xEegizUrH3B5hWqfIE8kLwFqTzNO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="297511980"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297511980"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="757654145"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2022 09:22:47 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWgmA-0001Qp-0F;
        Fri, 09 Sep 2022 16:22:42 +0000
Date:   Sat, 10 Sep 2022 00:22:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vfs-idmapping:fs.posix_acl.vfsuid 32/37] arc-elf-ld:
 xattr.c:undefined reference to `posix_acl_from_xattr'
Message-ID: <202209100028.r9LJxUf3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git fs.posix_acl.vfsuid
head:   d37e11d9b40fc35810217121aa3205b7975fd4c6
commit: fcb72ace104f57d790022ca5895c44a9379dc0a7 [32/37] xattr: use POSIX ACL api
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20220910/202209100028.r9LJxUf3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/commit/?id=fcb72ace104f57d790022ca5895c44a9379dc0a7
        git remote add vfs-idmapping https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
        git fetch --no-tags vfs-idmapping fs.posix_acl.vfsuid
        git checkout fcb72ace104f57d790022ca5895c44a9379dc0a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: fs/xattr.o: in function `do_setxattr':
   xattr.c:(.text+0xd1e): undefined reference to `posix_acl_from_xattr'
>> arc-elf-ld: xattr.c:(.text+0xd1e): undefined reference to `posix_acl_from_xattr'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
