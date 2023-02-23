Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088006A0842
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBWMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjBWMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:11:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C310ABD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677154264; x=1708690264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B/K2jnS5V8fqfJELepg+zVEw5GZ71uH66btwEMIteTE=;
  b=U0RWKyHJRoFuUnU2uqKOBmTg1qEN2Njd0TN+sLpLBvOVm928e2fZVjuL
   rFUTjtxpKdr0PWkXQmE0dfLSQln7o0RlVlOq13t9hfPxOztw9LwYTzt4j
   RuFGOgtEuF4rD4uCo4fLQgkh89vGqilaU3A6PiLjgUQpYmL4H9BaY+b17
   kqrhhrkiZuRDk+uroEgEdOckAdo92mtsqYqsHKiZnZ7jKf5sl1uBKY644
   /bg7obeAMkOZwWlTGyl1lhc+qXjKLr6ASrs4x0W70JDOpVH/R9KVL+IVj
   yzVC1B5V3F1aAYTwTiAHDwy5Iur51h2OFrnJduWKw+0k0m+uGvaVv6ru4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="313565447"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="313565447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 04:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="846534783"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="846534783"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2023 04:09:59 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVAQA-0001JZ-1e;
        Thu, 23 Feb 2023 12:09:58 +0000
Date:   Thu, 23 Feb 2023 20:09:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sh4-linux-gcc: error: unrecognized command-line option
 '-Wout-of-line-declaration'; did you mean '-Wold-style-declaration'?
Message-ID: <202302232026.uJMPib2X-lkp@intel.com>
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

Hi Konstantin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a5c95ca18a98d742d0a4a04063c32556b5b66378
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   1 year, 6 months ago
config: sh-randconfig-r033-20230222 (https://download.01.org/0day-ci/archive/20230223/202302232026.uJMPib2X-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302232026.uJMPib2X-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sh4-linux-gcc: error: unrecognized command-line option '-Wout-of-line-declaration'; did you mean '-Wold-style-declaration'?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
