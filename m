Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B596C6D71F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjDEB35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjDEB34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:29:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677F30E2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680658195; x=1712194195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NBW2fgUz9anzHPn80OpQJ6ALlq6FUo8B7NGe+OQ3gy8=;
  b=l2iV741Hy6QB2jfHtamcw6/EGvhLGGL94xZ9r78X6QK4OwnG6J56OevK
   ZbYFTd2xLu0aHlhyDul0uYeHlviS+htlvW+6exyWM2LpUGrpRcPt6pWHv
   CzByfBKF3fiUAb2NCZOhSvb28HeT+6Gr6OaO0zL7i8M6zVB4yI7QkX07L
   gIMSAjVyX5bNyQUZJm3D6omFY6uWKfojDg3NAnvQan+5Tb4SsDHaVLkqa
   ES48XOzAfWEXaY6sMl0R5fdWxTopafFUftzXmN3i+LGsO1CQ81aTer7L1
   Xu5bPZjfaf4WXcahusWuIdP+B8/VsqYH03ThOiCgorIB3r6zcACeL0hQI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330945308"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="330945308"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 18:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="719149554"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="719149554"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2023 18:29:53 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjryC-000QBG-15;
        Wed, 05 Apr 2023 01:29:52 +0000
Date:   Wed, 5 Apr 2023 09:29:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/powerpc/kvm/../kernel/head_booke.h:20:6: warning:
 "THREAD_SHIFT" is not defined, evaluates to 0
Message-ID: <202304050954.yskLdczH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76f598ba7d8e2bfb4855b5298caedd5af0c374a8
commit: 80b6093b55e31c2c40ff082fb32523d4e852954f kbuild: add -Wundef to KBUILD_CPPFLAGS for W=1 builds
date:   4 months ago
config: powerpc-buildonly-randconfig-r003-20230405 (https://download.01.org/0day-ci/archive/20230405/202304050954.yskLdczH-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80b6093b55e31c2c40ff082fb32523d4e852954f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 80b6093b55e31c2c40ff082fb32523d4e852954f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/ arch/powerpc/kvm/ virt/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304050954.yskLdczH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kvm/bookehv_interrupts.S:26:
>> arch/powerpc/kvm/../kernel/head_booke.h:20:6: warning: "THREAD_SHIFT" is not defined, evaluates to 0 [-Wundef]
      20 | #if (THREAD_SHIFT < 15)
         |      ^~~~~~~~~~~~


vim +/THREAD_SHIFT +20 arch/powerpc/kvm/../kernel/head_booke.h

1a4b739bbb4f88 Christophe Leroy 2019-04-30  10  
63dafe5728e735 Becky Bruce      2006-01-14  11  /*
63dafe5728e735 Becky Bruce      2006-01-14  12   * Macros used for common Book-e exception handling
63dafe5728e735 Becky Bruce      2006-01-14  13   */
63dafe5728e735 Becky Bruce      2006-01-14  14  
63dafe5728e735 Becky Bruce      2006-01-14  15  #define SET_IVOR(vector_number, vector_label)		\
63dafe5728e735 Becky Bruce      2006-01-14  16  		li	r26,vector_label@l; 		\
63dafe5728e735 Becky Bruce      2006-01-14  17  		mtspr	SPRN_IVOR##vector_number,r26;	\
63dafe5728e735 Becky Bruce      2006-01-14  18  		sync
63dafe5728e735 Becky Bruce      2006-01-14  19  
e12401222f749c Yuri Tikhonov    2009-01-29 @20  #if (THREAD_SHIFT < 15)
e12401222f749c Yuri Tikhonov    2009-01-29  21  #define ALLOC_STACK_FRAME(reg, val)			\
e12401222f749c Yuri Tikhonov    2009-01-29  22  	addi reg,reg,val
e12401222f749c Yuri Tikhonov    2009-01-29  23  #else
e12401222f749c Yuri Tikhonov    2009-01-29  24  #define ALLOC_STACK_FRAME(reg, val)			\
e12401222f749c Yuri Tikhonov    2009-01-29  25  	addis	reg,reg,val@ha;				\
e12401222f749c Yuri Tikhonov    2009-01-29  26  	addi	reg,reg,val@l
e12401222f749c Yuri Tikhonov    2009-01-29  27  #endif
e12401222f749c Yuri Tikhonov    2009-01-29  28  

:::::: The code at line 20 was first introduced by commit
:::::: e12401222f749c37277a313d631dc024bbfd3b00 powerpc/44x: Support for 256KB PAGE_SIZE

:::::: TO: Yuri Tikhonov <yur@emcraft.com>
:::::: CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
