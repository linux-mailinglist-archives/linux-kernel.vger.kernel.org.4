Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D784A6D7524
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjDEHTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjDEHTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:19:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D74236
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680679144; x=1712215144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=829QezRVhy1NQcNbUENzdQ1yIK4H7cKGwsXDe7ZwJbk=;
  b=Esl1c0X1bdmFxGiyeEqRqf7rz6/ykzQHtPrRTfqz0o0XTZNDH2IF+/pw
   KEr2cY61pZI85W13vVYs1h0lb7tQvijCVKzvfCocVp2ABncMqr7G7vkPB
   Hfum2IIEYnK6Kp9Iqj9V2X7S1lmKj8rQqYc/4f+9YzzeE98o7uSQ3bDen
   j20GXuq99OFBfpTPuICi7ERehUOmmLQPFDgjOpMmnTnDa7PoRI7NLt+wk
   ayMQ10TQ3NSY3duBUDXK9yl0qoPpy8vd2kqTpY+p1tjj3d/utjxexk+rt
   YMbpHz4wyG6quo3JykRnfgC7Uux69uP5/GT+yE62HVMe4/PuFfvCLKkSy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344966488"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="344966488"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 00:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="663932497"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="663932497"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2023 00:19:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjxQ5-000QNy-26;
        Wed, 05 Apr 2023 07:19:01 +0000
Date:   Wed, 5 Apr 2023 15:18:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/powerpc/kvm/e500mc.c:171:5: error: no previous prototype for
 'kvmppc_e500mc_check_processor_compat'
Message-ID: <202304051534.jWWiT0cj-lkp@intel.com>
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

Hi Sean,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76f598ba7d8e2bfb4855b5298caedd5af0c374a8
commit: 7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f KVM: PPC: Fix refactoring goof in kvmppc_e500mc_init()
date:   2 months ago
config: powerpc-buildonly-randconfig-r003-20230405 (https://download.01.org/0day-ci/archive/20230405/202304051534.jWWiT0cj-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304051534.jWWiT0cj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kvm/e500mc.c:171:5: error: no previous prototype for 'kvmppc_e500mc_check_processor_compat' [-Werror=missing-prototypes]
     171 | int kvmppc_e500mc_check_processor_compat(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/kvmppc_e500mc_check_processor_compat +171 arch/powerpc/kvm/e500mc.c

   170	
 > 171	int kvmppc_e500mc_check_processor_compat(void)
   172	{
   173		int r;
   174	
   175		if (strcmp(cur_cpu_spec->cpu_name, "e500mc") == 0)
   176			r = 0;
   177		else if (strcmp(cur_cpu_spec->cpu_name, "e5500") == 0)
   178			r = 0;
   179	#ifdef CONFIG_ALTIVEC
   180		/*
   181		 * Since guests have the privilege to enable AltiVec, we need AltiVec
   182		 * support in the host to save/restore their context.
   183		 * Don't use CPU_FTR_ALTIVEC to identify cores with AltiVec unit
   184		 * because it's cleared in the absence of CONFIG_ALTIVEC!
   185		 */
   186		else if (strcmp(cur_cpu_spec->cpu_name, "e6500") == 0)
   187			r = 0;
   188	#endif
   189		else
   190			r = -ENOTSUPP;
   191	
   192		return r;
   193	}
   194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
