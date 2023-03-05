Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C86AADBF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 02:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCEBSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 20:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEBSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 20:18:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BAA83E0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 17:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677979093; x=1709515093;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YsC+XBR8QTjWabeQMUUp1s5JALvga55oDrHytWfzYes=;
  b=O4DlVVWAYqnF0ODyhnQD6aG1qSFdiVqBH+x8bcWVvB545oJKwKhqWmqI
   ajHt2a5yebpF8W93k5yAJEwj7zJewK6TVh0X9tu7w+fn+JXjEp/lGWaiN
   zSvYaLnwMpZnBs8nQmDWHe8M5Gbo3mjxiQwpdVNyW+MsHh5gGwzHzOob6
   xCCFfvqS+WHySmz1T+bj3fQ1/PZe8mvJG6O2ttK0XjQaG+Em57zLe9Zvc
   tTp8gzZrNX+PExBqnWl4OjYa/nvKqvWEbavxdPoDcoNYo/4Ov9NdDCACC
   Tw3nY1wxGJlehIu869FZinov44rwkxggvQTUMhswq+VkjC+1bdihqqtWZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="397914873"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="397914873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 17:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="921502194"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="921502194"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Mar 2023 17:18:11 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYd0s-0002Sw-13;
        Sun, 05 Mar 2023 01:18:10 +0000
Date:   Sun, 5 Mar 2023 09:18:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202303050909.k3a83A1q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b01fe98d34f3bed944a93bd8119fed80c856fad8
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   7 months ago
config: loongarch-randconfig-s053-20230305 (https://download.01.org/0day-ci/archive/20230305/202303050909.k3a83A1q-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303050909.k3a83A1q-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
--
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2598:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2598:19: sparse:     expected void *ptr
   mm/slub.c:2598:19: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2619:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2619:9: sparse:     expected void *ptr
   mm/slub.c:2619:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2562:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2562:24: sparse:     expected void *ptr
   mm/slub.c:2562:24: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
   mm/slub.c:2563:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct slab *[noderef] __percpu * @@
   mm/slub.c:2563:9: sparse:     expected void *ptr
   mm/slub.c:2563:9: sparse:     got struct slab *[noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:2475:9: sparse: sparse: context imbalance in 'deactivate_slab' - different lock contexts for basic block
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:2509:55: sparse: sparse: context imbalance in '__unfreeze_partials' - unexpected unlock
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:3350:47: sparse: sparse: context imbalance in '__slab_free' - unexpected unlock
--
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
   kernel/time/posix-cpu-timers.c: note: in included file:
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/time/posix-cpu-timers.c:42:5: sparse: sparse: context imbalance in 'update_rlimit_cpu' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *

vim +441 drivers/soc/qcom/rpmh.c

600513dfeef33c Lina Iyer        2018-06-20  426  
600513dfeef33c Lina Iyer        2018-06-20  427  /**
985427f997b6a3 Maulik Shah      2020-04-12  428   * rpmh_flush() - Flushes the buffered sleep and wake sets to TCSes
600513dfeef33c Lina Iyer        2018-06-20  429   *
985427f997b6a3 Maulik Shah      2020-04-12  430   * @ctrlr: Controller making request to flush cached data
600513dfeef33c Lina Iyer        2018-06-20  431   *
985427f997b6a3 Maulik Shah      2020-04-12  432   * Return:
985427f997b6a3 Maulik Shah      2020-04-12  433   * * 0          - Success
985427f997b6a3 Maulik Shah      2020-04-12  434   * * Error code - Otherwise
600513dfeef33c Lina Iyer        2018-06-20  435   */
d5e205079c34aa Maulik Shah      2020-02-03  436  int rpmh_flush(struct rpmh_ctrlr *ctrlr)
600513dfeef33c Lina Iyer        2018-06-20  437  {
600513dfeef33c Lina Iyer        2018-06-20  438  	struct cache_req *p;
d2a8cfc6f32026 Douglas Anderson 2020-05-04  439  	int ret = 0;
600513dfeef33c Lina Iyer        2018-06-20  440  
985427f997b6a3 Maulik Shah      2020-04-12 @441  	lockdep_assert_irqs_disabled();
985427f997b6a3 Maulik Shah      2020-04-12  442  
d2a8cfc6f32026 Douglas Anderson 2020-05-04  443  	/*
d2a8cfc6f32026 Douglas Anderson 2020-05-04  444  	 * Currently rpmh_flush() is only called when we think we're running
d2a8cfc6f32026 Douglas Anderson 2020-05-04  445  	 * on the last processor.  If the lock is busy it means another
d2a8cfc6f32026 Douglas Anderson 2020-05-04  446  	 * processor is up and it's better to abort than spin.
d2a8cfc6f32026 Douglas Anderson 2020-05-04  447  	 */
d2a8cfc6f32026 Douglas Anderson 2020-05-04  448  	if (!spin_trylock(&ctrlr->cache_lock))
d2a8cfc6f32026 Douglas Anderson 2020-05-04  449  		return -EBUSY;
d2a8cfc6f32026 Douglas Anderson 2020-05-04  450  
600513dfeef33c Lina Iyer        2018-06-20  451  	if (!ctrlr->dirty) {
600513dfeef33c Lina Iyer        2018-06-20  452  		pr_debug("Skipping flush, TCS has latest data.\n");
d2a8cfc6f32026 Douglas Anderson 2020-05-04  453  		goto exit;
600513dfeef33c Lina Iyer        2018-06-20  454  	}
600513dfeef33c Lina Iyer        2018-06-20  455  
f5ac95f9ca2f43 Maulik Shah      2020-04-12  456  	/* Invalidate the TCSes first to avoid stale data */
881808d0bbf336 Douglas Anderson 2020-04-13  457  	rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
f5ac95f9ca2f43 Maulik Shah      2020-04-12  458  
c8790cb6da58d3 Lina Iyer        2018-06-20  459  	/* First flush the cached batch requests */
c8790cb6da58d3 Lina Iyer        2018-06-20  460  	ret = flush_batch(ctrlr);
c8790cb6da58d3 Lina Iyer        2018-06-20  461  	if (ret)
d2a8cfc6f32026 Douglas Anderson 2020-05-04  462  		goto exit;
c8790cb6da58d3 Lina Iyer        2018-06-20  463  
600513dfeef33c Lina Iyer        2018-06-20  464  	list_for_each_entry(p, &ctrlr->cache, list) {
600513dfeef33c Lina Iyer        2018-06-20  465  		if (!is_req_valid(p)) {
600513dfeef33c Lina Iyer        2018-06-20  466  			pr_debug("%s: skipping RPMH req: a:%#x s:%#x w:%#x",
600513dfeef33c Lina Iyer        2018-06-20  467  				 __func__, p->addr, p->sleep_val, p->wake_val);
600513dfeef33c Lina Iyer        2018-06-20  468  			continue;
600513dfeef33c Lina Iyer        2018-06-20  469  		}
d5e205079c34aa Maulik Shah      2020-02-03  470  		ret = send_single(ctrlr, RPMH_SLEEP_STATE, p->addr,
d5e205079c34aa Maulik Shah      2020-02-03  471  				  p->sleep_val);
600513dfeef33c Lina Iyer        2018-06-20  472  		if (ret)
d2a8cfc6f32026 Douglas Anderson 2020-05-04  473  			goto exit;
d5e205079c34aa Maulik Shah      2020-02-03  474  		ret = send_single(ctrlr, RPMH_WAKE_ONLY_STATE, p->addr,
d5e205079c34aa Maulik Shah      2020-02-03  475  				  p->wake_val);
600513dfeef33c Lina Iyer        2018-06-20  476  		if (ret)
d2a8cfc6f32026 Douglas Anderson 2020-05-04  477  			goto exit;
600513dfeef33c Lina Iyer        2018-06-20  478  	}
600513dfeef33c Lina Iyer        2018-06-20  479  
600513dfeef33c Lina Iyer        2018-06-20  480  	ctrlr->dirty = false;
600513dfeef33c Lina Iyer        2018-06-20  481  
d2a8cfc6f32026 Douglas Anderson 2020-05-04  482  exit:
d2a8cfc6f32026 Douglas Anderson 2020-05-04  483  	spin_unlock(&ctrlr->cache_lock);
d2a8cfc6f32026 Douglas Anderson 2020-05-04  484  	return ret;
600513dfeef33c Lina Iyer        2018-06-20  485  }
600513dfeef33c Lina Iyer        2018-06-20  486  

:::::: The code at line 441 was first introduced by commit
:::::: 985427f997b6a31155cce841eb395d43c64771c5 soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches

:::::: TO: Maulik Shah <mkshah@codeaurora.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
