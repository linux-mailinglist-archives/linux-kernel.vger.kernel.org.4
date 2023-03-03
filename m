Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFF6A924D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCCIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCCIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:21:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD54C59427
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677831642; x=1709367642;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RD6eQrDmm8Oxod9+Tm7ijo4RuOcNKHPmnbz622vhHjA=;
  b=TNRwdNpiJCZJtFGyGVFo98x4DWyu4TAH/KdZAaU+7OMhTX5II9WUrbzu
   Kkf79U5RjPRdK8jWrPRWFDR0hZYOHBNua7/goy699Gt6Tn5NOJZaex2K1
   KfTawE0cwFPNrHVPIbYBT0HwAfz8CpUasYvdCt5hPHAVEI/p7BL1TVkae
   CbRQddpdZ0yeonX2gFWoEUSA/gR4cgzzjAqcbPItneRxKc12XgAzDjvtd
   onMqmBfhpvuelT3FQh/r/0RLE3ak8WGOXxfwQvsEpPCetQ/Bd9vqhhML3
   7HocjNxKZDkR1wt8u1iH0ZbJKTtCzIXv4k73mQS8cQUaWecS5dTiRpvSQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333711978"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="333711978"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="675281912"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="675281912"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2023 00:20:04 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pY0e3-0001KI-2e;
        Fri, 03 Mar 2023 08:20:03 +0000
Date:   Fri, 3 Mar 2023 16:19:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/powerpc/kvm/e500mc.c:171:5: error: no previous prototype for
 'kvmppc_e500mc_check_processor_compat'
Message-ID: <202303031630.ntvIuYqo-lkp@intel.com>
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
head:   2eb29d59ddf02e39774abfb60b2030b0b7e27c1f
commit: 7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f KVM: PPC: Fix refactoring goof in kvmppc_e500mc_init()
date:   5 weeks ago
config: powerpc-randconfig-r001-20230302 (https://download.01.org/0day-ci/archive/20230303/202303031630.ntvIuYqo-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202303031630.ntvIuYqo-lkp@intel.com/

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
