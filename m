Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E86F0108
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbjD0GsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbjD0GsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:48:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3055D420A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682578097; x=1714114097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+x5OGVpOtE0g1KlEEMXNWoueG3GSjsfmnGbwcc6bKi0=;
  b=aDG2BXVaVOQJzM1ZvIXWiiTfihemaue3wsMejjjf69C1sq+76+3fLMcE
   90fRUrFd18M7iulmPoo9BrkbBC6hHVkGy3IJUhxJ/rje4ioSSoqNRw+In
   yb2SbnyQAAUY1eCO0pbAJCiLGD+uTcKuzD8/RiiJP5lXuJNm9EfrQRtTm
   xqbAtoqlcm7KK97sP6mJ5zyqpXTwyE2wABzXKxWYY/V4uoSknz1wjD9DD
   KglavilAo9FXA15hV9l8At1gloP69NUbJmWT7AkPOLlfZ8gtF7XroU+uR
   SvlIcIm6YKJF8qI1nr1/5g4qxv28/vOcn0Aqv856rWgkxUgIsX+JJv/dq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="346106490"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="346106490"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 23:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="783605604"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="783605604"
Received: from lkp-server01.sh.intel.com (HELO 1e0e07564161) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2023 23:48:15 -0700
Received: from kbuild by 1e0e07564161 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prvQM-000041-33;
        Thu, 27 Apr 2023 06:48:14 +0000
Date:   Thu, 27 Apr 2023 14:48:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.04.26a 38/51] arch/x86/kernel/nmi.c:441:6:
 warning: no previous prototype for function 'set_nmi_torture'
Message-ID: <202304271448.5uG6ip4V-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26a
head:   56b38a90a12f76e463a7381d8cff854926fa2b59
commit: e5bf47f3a53ddfad8e0c56b6cbf048de8d82b033 [38/51] x86/nmi: Add a set_nmi_torture() function to control NMI testing
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20230427/202304271448.5uG6ip4V-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=e5bf47f3a53ddfad8e0c56b6cbf048de8d82b033
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.04.26a
        git checkout e5bf47f3a53ddfad8e0c56b6cbf048de8d82b033
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304271448.5uG6ip4V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/nmi.c:441:6: warning: no previous prototype for function 'set_nmi_torture' [-Wmissing-prototypes]
   void set_nmi_torture(int nmi_delay_in, bool nmi_halt1_in, bool nmi_halt2_in, bool nmi_halt3_in)
        ^
   arch/x86/kernel/nmi.c:441:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void set_nmi_torture(int nmi_delay_in, bool nmi_halt1_in, bool nmi_halt2_in, bool nmi_halt3_in)
   ^
   static 
   1 warning generated.


vim +/set_nmi_torture +441 arch/x86/kernel/nmi.c

   439	
   440	/* Set the test values as desired. */
 > 441	void set_nmi_torture(int nmi_delay_in, bool nmi_halt1_in, bool nmi_halt2_in, bool nmi_halt3_in)
   442	{
   443		WRITE_ONCE(nmi_delay, nmi_delay_in);
   444		WRITE_ONCE(nmi_halt1, nmi_halt1_in);
   445		WRITE_ONCE(nmi_halt2, nmi_halt2_in);
   446		WRITE_ONCE(nmi_halt3, nmi_halt3_in);
   447		pr_info("%s: Set NMI test parameters nmi_delay=%d nmi_halt1=%d nmi_halt2=%d nmi_halt3=%d\n",
   448			__func__, nmi_delay, nmi_halt1, nmi_halt2, nmi_halt3);
   449	}
   450	EXPORT_SYMBOL_GPL(set_nmi_torture);
   451	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
