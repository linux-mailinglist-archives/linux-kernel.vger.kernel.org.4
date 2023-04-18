Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3816E582F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDREs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDREsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:48:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322A1BDC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681793303; x=1713329303;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iikn2fHq/VA1/UjIXV1sXkApoZpQm+NLROyuPf7mgmg=;
  b=QTxPNjaS45TGOjNFl3L/sv573u7yTIn04+M7mEZMIsC/zx99guwT1e+o
   wbAkto4JG4E61DfYiCerCIZ6eX7SQOxBDXBcOPjnAaeKDC6I08xvuXGE+
   3n+lyW8UVNgU0fR3dVUyuzjUpA3oMIFghpnRj26+TLDxln/egGab8UCun
   b8N5jz47yX0iXmbSL9FHwHfI/3HM9nPUvUU9/8uPdQ3T8T3PZ2nGaybeq
   lJDLkNxqXynkGQvjg8+wU3lLUzmjDxTKPEvAv2U+dwUmNluNOwX5L0i2I
   Iq1dbdBQ6c6dpFs3zudtZbrUNHoCO8CBLlBzkiUDhXE4284M/Hj6v1+eW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="342567802"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="342567802"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 21:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="865238122"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="865238122"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2023 21:48:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1podGO-000d03-2M;
        Tue, 18 Apr 2023 04:48:20 +0000
Date:   Tue, 18 Apr 2023 12:47:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
Message-ID: <202304181254.PNdQfsf9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
commit: 5750121ae7382ebac8d47ce6d68012d6cd1d7926 kbuild: list sub-directories in ./Kbuild
date:   7 months ago
config: nios2-randconfig-r014-20230417 (https://download.01.org/0day-ci/archive/20230418/202304181254.PNdQfsf9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5750121ae7382ebac8d47ce6d68012d6cd1d7926
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5750121ae7382ebac8d47ce6d68012d6cd1d7926
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304181254.PNdQfsf9-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__mulsi3" [kernel/locking/locktorture.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/rcu/rcuscale.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/time/test_udelay.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/scftorture.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/fuse/virtiofs.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/fscache/fscache.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/autofs/autofs4.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/math/prime_numbers.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/lz4/lz4_compress.ko] undefined!
>> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
WARNING: modpost: suppressed 415 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
