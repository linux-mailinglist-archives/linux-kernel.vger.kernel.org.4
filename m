Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971F36B5989
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCKIqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCKIqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:46:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E02013130B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678524408; x=1710060408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uass+DmbjRTLtwtWq/w/qufHcQI5VcjAmDou88YLpI4=;
  b=KlWEiN2AP6N2cjwJ+lq1Y0LJAQp+AkQRVgjYQMef8QlIjYP1VUTfymIl
   vvRJt6UEgeRtnIubJEV9JpBt8/I/9jdm27r63SwgkH13eFrtX6yXQr4lj
   eANReEPOAv2jlemqyO4KB1r9xElqLFe0V+S+/OPq7ryssjFkX0deJB05V
   NBHC4j7EYQX1pPYxZeK5J1rBUXuhIt6Cd9zQdmRchvT0Fgvnf5hvT7IMN
   QXeQXtJnc4t2/5X5Cb3gdEHrCMaIvg1Sq302v+TZLzw9PySXBqp+A52Da
   dGihDI+qN/gj6WxHQVB+WgRhaXIhNMmiaxSLSs4zGBLCLMtU9QTJO2jRX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339251210"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="339251210"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 00:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="767126804"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="767126804"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2023 00:46:46 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pausH-0004Sz-2S;
        Sat, 11 Mar 2023 08:46:45 +0000
Date:   Sat, 11 Mar 2023 16:46:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: undefined reference to `ftrace_likely_update'
Message-ID: <202303111625.5L2nwDp2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef5f68cc1f829b492b19cd4df5af4454aa816b93
commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 fortify: Add run-time WARN for cross-field memcpy()
date:   6 months ago
config: s390-randconfig-r031-20230311 (https://download.01.org/0day-ci/archive/20230311/202303111625.5L2nwDp2-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54d9469bc515dc5fcbc20eecbe19cea868b70d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303111625.5L2nwDp2-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: arch/s390/purgatory/purgatory: in function `sha256_update':
>> (.text+0x248c): undefined reference to `ftrace_likely_update'
>> s390-linux-ld: (.text+0x24a4): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x24bc): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x29b4): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x29cc): undefined reference to `ftrace_likely_update'
   s390-linux-ld: arch/s390/purgatory/purgatory:(.text+0x29e4): more undefined references to `ftrace_likely_update' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
