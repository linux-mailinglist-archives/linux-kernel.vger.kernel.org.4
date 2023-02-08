Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F30A68E651
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBHCv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjBHCvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:51:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC1B8684
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675824713; x=1707360713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mwr3qNzGCEl1ilH3eggGBCQcHoceTEn3i6eC1KZclvU=;
  b=K+U5qdUqqMVaGYb63CrKF7cQ3o4JwzoaebDGaYYv99B8dEq+/hhhhwyP
   P3hxz4p2sWa+EzM6/A+YXgTXqtM5+VJ4b5MPbr+uXclI7+jB9DeJYSwxt
   w++fuYgsHCfca8qEIsCfk6rwCm86n7CR2IgovEshWJuObGlq6tZS19mKZ
   O9N8IsK0jF3D2n9CAWJu35aQPxTfU3+tvaJ1iP1fw0qsS1U9QfNJ0pgVF
   jrFrNPG9gXiktOORdYlwG0z159oNvNFjL12NYcHZ3SoXPGtKNQvBdDxAF
   X7GSJO+S9FrH6yS4yQxlJdFjjl1w/RIaTadywa950yJAlPDe22SYBticO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="330984866"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="330984866"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 18:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="809777118"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="809777118"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2023 18:51:51 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPaYj-00046e-2I;
        Wed, 08 Feb 2023 02:51:45 +0000
Date:   Wed, 8 Feb 2023 10:51:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/powerpc/kvm/../kernel/head_booke.h:20:6: warning:
 "THREAD_SHIFT" is not defined, evaluates to 0
Message-ID: <202302081034.IDWxXcwG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0983f6bf2bfc0789b51ddf7315f644ff4da50acb
commit: 80b6093b55e31c2c40ff082fb32523d4e852954f kbuild: add -Wundef to KBUILD_CPPFLAGS for W=1 builds
date:   8 weeks ago
config: powerpc-randconfig-r015-20230208 (https://download.01.org/0day-ci/archive/20230208/202302081034.IDWxXcwG-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/ arch/powerpc/kvm/ arch/powerpc/platforms/85xx/ arch/powerpc/sysdev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/kvm/bookehv_interrupts.S:26:
>> arch/powerpc/kvm/../kernel/head_booke.h:20:6: warning: "THREAD_SHIFT" is not defined, evaluates to 0 [-Wundef]
      20 | #if (THREAD_SHIFT < 15)
         |      ^~~~~~~~~~~~


vim +/THREAD_SHIFT +20 arch/powerpc/kvm/../kernel/head_booke.h

1a4b739bbb4f885 Christophe Leroy 2019-04-30  10  
63dafe5728e7354 Becky Bruce      2006-01-14  11  /*
63dafe5728e7354 Becky Bruce      2006-01-14  12   * Macros used for common Book-e exception handling
63dafe5728e7354 Becky Bruce      2006-01-14  13   */
63dafe5728e7354 Becky Bruce      2006-01-14  14  
63dafe5728e7354 Becky Bruce      2006-01-14  15  #define SET_IVOR(vector_number, vector_label)		\
63dafe5728e7354 Becky Bruce      2006-01-14  16  		li	r26,vector_label@l; 		\
63dafe5728e7354 Becky Bruce      2006-01-14  17  		mtspr	SPRN_IVOR##vector_number,r26;	\
63dafe5728e7354 Becky Bruce      2006-01-14  18  		sync
63dafe5728e7354 Becky Bruce      2006-01-14  19  
e12401222f749c3 Yuri Tikhonov    2009-01-29 @20  #if (THREAD_SHIFT < 15)
e12401222f749c3 Yuri Tikhonov    2009-01-29  21  #define ALLOC_STACK_FRAME(reg, val)			\
e12401222f749c3 Yuri Tikhonov    2009-01-29  22  	addi reg,reg,val
e12401222f749c3 Yuri Tikhonov    2009-01-29  23  #else
e12401222f749c3 Yuri Tikhonov    2009-01-29  24  #define ALLOC_STACK_FRAME(reg, val)			\
e12401222f749c3 Yuri Tikhonov    2009-01-29  25  	addis	reg,reg,val@ha;				\
e12401222f749c3 Yuri Tikhonov    2009-01-29  26  	addi	reg,reg,val@l
e12401222f749c3 Yuri Tikhonov    2009-01-29  27  #endif
e12401222f749c3 Yuri Tikhonov    2009-01-29  28  

:::::: The code at line 20 was first introduced by commit
:::::: e12401222f749c37277a313d631dc024bbfd3b00 powerpc/44x: Support for 256KB PAGE_SIZE

:::::: TO: Yuri Tikhonov <yur@emcraft.com>
:::::: CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
