Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7F96D76BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjDEIVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbjDEIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:21:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084004224
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680682867; x=1712218867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V92pNr3Kx0TvyE1KK/dNKvtNO9YsicCIPZ9uU89MXRE=;
  b=LyW0VxaZ8te9Fd6EGUsKA341ho4VdsR2XQVcG5foTFSR13vLqqLFBlQ1
   llT4ec6XbwnwLvwCg1ej7NczXuEQPUl58M0O/PH/jS9zMwQXXNDep4Q7s
   LnyI8G/pxnPnYbEMX2OgdpoztikkKq75tzGtyDudDyAmS9Hy4/TQTdFFD
   Na/rxzp8YkFQwVfaT/yM6NUqd1Ilbkmeg741V5tLatBXc7LKqiaAR3aMu
   yeHFxlPw3vT7SOA7SZb7CdIOPyXKNDPZ3NmVzNT4bd6ss+0syeHbBtuTl
   c+ZWfIbt8KDy7pPoFopgVB9gtEWQRN8S5bSJWHdt+sF8PZ/yf0OjkHQQ5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428682971"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428682971"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="830280170"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="830280170"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2023 01:21:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjyO8-000QPm-1i;
        Wed, 05 Apr 2023 08:21:04 +0000
Date:   Wed, 5 Apr 2023 16:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3 22/22]
 ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field
 'target' with variable sized type 'struct ebt_entry_target' not at the end
 of a struct or class is a GNU extension
Message-ID: <202304051623.Cvewnzo2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
head:   91ba9bf02e0d11bbe0b6fe49f40fb90818f2a06d
commit: 91ba9bf02e0d11bbe0b6fe49f40fb90818f2a06d [22/22] uapi: netfilter: ebtables: Replace zero-length array with flexible-array  member
config: x86_64-randconfig-a001-20230403 (https://download.01.org/0day-ci/archive/20230405/202304051623.Cvewnzo2-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=91ba9bf02e0d11bbe0b6fe49f40fb90818f2a06d
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fsfa3
        git checkout 91ba9bf02e0d11bbe0b6fe49f40fb90818f2a06d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304051623.Cvewnzo2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field 'target' with variable sized type 'struct ebt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
           struct ebt_entry_target target;
                                   ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
