Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C56726BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjARSYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjARSYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:24:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66B33A846
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674066250; x=1705602250;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UXswtDu2OcXvYHZMg5iH7n14j4fWUNjLJ3qzG6kTgos=;
  b=UY+q3pKR/Ue3TX9WoWt/dVIJGIcjOet05fHkiHfW9ooBQaLRQuFdM3oR
   geBg24HJArt2PygzBbPgV1JmQFQ10FhTIENx0OYo+v6f2m/4Gt8Na2yym
   r8jT/vlow9qsW9yHfxQQomhlLcRn3LKR7HHbZ22c5Tlfl5I2cFc5dnA2e
   l2p6Vqy9kc4wdCwIToiXttJO7rO/z3UBH+NBdWzZDLHTshooArqYhLFnI
   vNm/QmTj1gXD/XD5cNtPTek8CBcedEuQ4fjq5hqZiEqlN0lnya2e6EDU8
   OURR1vMcxObMQCbMJK5D8QLFXaHgGFn71UFqK2oXxhrdQ0I+rTisssJWm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="312939094"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="312939094"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="690322884"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="690322884"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2023 10:24:09 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pID6W-0000cG-0C;
        Wed, 18 Jan 2023 18:24:08 +0000
Date:   Thu, 19 Jan 2023 02:23:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Fuad Tabba <tabba@google.com>
Subject: arch/arm64/kvm/hyp/nvhe/stacktrace.c:15:1: sparse: sparse: symbol
 '__pcpu_scope_kvm_stacktrace_info' was not declared. Should it be static?
Message-ID: <202301190239.a0WaMbq8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1649ec55708ae42091a2f1bca1ab49ecd722d55
commit: 879e5ac7b2e4db05799a905b5a07fc9e5dedf651 KVM: arm64: Prepare non-protected nVHE hypervisor stacktrace
date:   6 months ago
config: arm64-randconfig-s053-20230118 (https://download.01.org/0day-ci/archive/20230119/202301190239.a0WaMbq8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 879e5ac7b2e4db05799a905b5a07fc9e5dedf651
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kvm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/arm64/kvm/hyp/nvhe/stacktrace.c:12:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?
>> arch/arm64/kvm/hyp/nvhe/stacktrace.c:15:1: sparse: sparse: symbol '__pcpu_scope_kvm_stacktrace_info' was not declared. Should it be static?

vim +/__pcpu_scope_kvm_stacktrace_info +15 arch/arm64/kvm/hyp/nvhe/stacktrace.c

    11	
    12	DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
    13		__aligned(16);
    14	
  > 15	DEFINE_PER_CPU(struct kvm_nvhe_stacktrace_info, kvm_stacktrace_info);
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
