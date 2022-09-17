Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E15BB890
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIQNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIQNtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:49:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C078F28700
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663422540; x=1694958540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UQEmgGFwCoDXb01xQxoEcXfEgVOV+wiQZrTXROGVeyg=;
  b=HOSqcbLesa3UFNDqzfOqTmTxWVL2zTfp62O2TSCPFRnLN8h7JpwilBZL
   2bQnCNUFtdeR7erjNpTZBApGSMFfZbU17/dvrn9IO1K24Oi8dnZDHIGom
   r33l2o++ldsvNAWiqy2MUDeUDNVAgPvxPEWPmboFsjYsZU6rrIaX0GZ/n
   Q9jjmlRhK882saN8c5RFlS7fxyMbkG0EguaV8OFyJkvP1R3vfFaCwiHQZ
   upbRLI6WDSJ+pITuD87+FHclyGyIrnHQnOwxTCTajeRH8i4YN+5ExTvPR
   wsozNCQjxxlR0rMgKS2JNBUrRCF9dvHp0CURovLijzOBkbEvG965qWYr5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="363115261"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="363115261"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 06:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="595562658"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Sep 2022 06:48:58 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZYBm-0000N9-0r;
        Sat, 17 Sep 2022 13:48:58 +0000
Date:   Sat, 17 Sep 2022 21:48:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: ld.lld: error: assignment to symbol __init_end does not converge
Message-ID: <202209172159.AjlIRYQP-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a335366bad1364a07f49df9da1fdfa6d411a5f39
commit: f70b3a23324a2d31efb83cc01302acb343e4ec1b arm64: head: create a temporary FDT mapping in the initial ID map
date:   3 months ago
config: arm64-randconfig-r006-20220917 (https://download.01.org/0day-ci/archive/20220917/202209172159.AjlIRYQP-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f70b3a23324a2d31efb83cc01302acb343e4ec1b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f70b3a23324a2d31efb83cc01302acb343e4ec1b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: assignment to symbol __init_end does not converge

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
