Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E973E6E9DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjDTVe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDTVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:34:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001630D2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682026496; x=1713562496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gxVLo03rQJYTrAXt611bWrhvxkoEHkkz2K8KQ/s2Pos=;
  b=YQvk+HB3CJLnAbQwDrDvZ3oGel0HT25fsMQEbkkKWBIPYkac7vcao5SI
   7CUNaQyJO/SP8YB2E1j1fVTKwTIW9vqv9tWWpqfqfoWLgWX/baP0t+26p
   eImYpoJL+jCBh1plgGYPk9uMiZ8RomhNEffIHsmQUPCdH7SL419gakULv
   UcZNiUFTvbLhtD4ynETbOdIYJiqVKcc6Zn0wUvcguctTNSpj3pl4L/Ueo
   fEvA4Vt3fKcElR9JAd77fd3yhwOjknwUGLWUBD8CruczISFwwI9WxhCu1
   vDuEZ3WDYuD7MLP8ZRiWijKbZuXAlhoPiq1WrJGLyMqDb3aDTqnN9hneP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="326183095"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="326183095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 14:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="835928095"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="835928095"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2023 14:34:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppbva-000g7o-31;
        Thu, 20 Apr 2023 21:34:54 +0000
Date:   Fri, 21 Apr 2023 05:33:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-sa1100/jornada720_ssp.c:24: warning: expecting
 prototype for arch/arm/mac(). Prototype was for DEFINE_SPINLOCK() instead
Message-ID: <202304210535.tWby3jWF-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb0856346a60fe3eb837ba5e73588a41f81ac05f
commit: 8faf91c48ca20c714e0dd8cc5f510e3819852912 ARM: sa1100: un-deprecate jornada720
date:   3 months ago
config: arm-jornada720_defconfig (https://download.01.org/0day-ci/archive/20230421/202304210535.tWby3jWF-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8faf91c48ca20c714e0dd8cc5f510e3819852912
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8faf91c48ca20c714e0dd8cc5f510e3819852912
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304210535.tWby3jWF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/mach-sa1100/jornada720_ssp.c:24: warning: Function parameter or member 'jornada_ssp_lock' not described in 'DEFINE_SPINLOCK'
>> arch/arm/mach-sa1100/jornada720_ssp.c:24: warning: expecting prototype for arch/arm/mac(). Prototype was for DEFINE_SPINLOCK() instead
   arch/arm/mach-sa1100/jornada720_ssp.c:34: warning: Function parameter or member 'byte' not described in 'jornada_ssp_reverse'
   arch/arm/mach-sa1100/jornada720_ssp.c:57: warning: Function parameter or member 'byte' not described in 'jornada_ssp_byte'
   arch/arm/mach-sa1100/jornada720_ssp.c:85: warning: Function parameter or member 'byte' not described in 'jornada_ssp_inout'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SA1100_SSP
   Depends on [n]: ARCH_SA1100 [=y] && UNUSED_BOARD_FILES [=n]
   Selected by [y]:
   - SA1100_JORNADA720_SSP [=y] && ARCH_SA1100 [=y] && SA1100_JORNADA720 [=y]


vim +24 arch/arm/mach-sa1100/jornada720_ssp.c

69ebb22277a53f Kristoffer Ericson 2007-07-20  23  
69ebb22277a53f Kristoffer Ericson 2007-07-20 @24  static DEFINE_SPINLOCK(jornada_ssp_lock);
69ebb22277a53f Kristoffer Ericson 2007-07-20  25  static unsigned long jornada_ssp_flags;
69ebb22277a53f Kristoffer Ericson 2007-07-20  26  

:::::: The code at line 24 was first introduced by commit
:::::: 69ebb22277a53f612ccd632ceb73ed87c9093412 [ARM] 4506/1: HP Jornada 7XX: Addition of SSP Platform Driver

:::::: TO: Kristoffer Ericson <Kristoffer_e1@hotmail.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
