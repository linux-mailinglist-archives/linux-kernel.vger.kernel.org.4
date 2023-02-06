Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6468C453
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBFROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBFROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:14:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862DD5588
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675703648; x=1707239648;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0rhZp1569UE7k/csBOO7yVdmzNOwNR4NncmfCCXbrNA=;
  b=lQh8eag/FwV5uV8WkrCJK4tprAoEeL4qOZRTS4m0qQgdGted4cMcWQou
   RjCdz6vx8aNvxGgp2V+ra+pIS1zXv4vO0GYx2N9LNAGi+45Uy+4+Om9By
   KYEYKXVAykKScaUcbaGvIpxQPj98q2tkPuBy4U0FOeJUX36miRPfraZ3x
   oYss+fHtO/jmRdesLK5wTY23ckRJO+2hqtSnmcJA3pM0E0wyURhaEpfHD
   CHS43eGkhj6eUe5vr1srqL5MxcHcr8XgvykmyPqXjwfBYLbKKgxDaGlVH
   jkvmmekeuq4wDmUB2DfwdsJ1YrirP99PWBZEYq9OtQDDdE86FEsXoZdrk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327893263"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327893263"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 09:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668467473"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="668467473"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 09:14:06 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP54A-0002gm-17;
        Mon, 06 Feb 2023 17:14:06 +0000
Date:   Tue, 7 Feb 2023 01:14:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Subject: lib/fortify_kunit.c:28:9: sparse: sparse: incompatible types for
 operation (==):
Message-ID: <202302070144.x9yAsFJX-lkp@intel.com>
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
head:   d2d11f342b179f1894a901f143ec7c008caba43e
commit: 875bfd5276f31d09e811d31fca638b9f4d1205e8 fortify: Add KUnit test for FORTIFY_SOURCE internals
date:   5 months ago
config: arm64-randconfig-s041-20230206 (https://download.01.org/0day-ci/archive/20230207/202302070144.x9yAsFJX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=875bfd5276f31d09e811d31fca638b9f4d1205e8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 875bfd5276f31d09e811d31fca638b9f4d1205e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   lib/fortify_kunit.c:28:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:28:9: sparse: sparse: undefined identifier '__compiletime_strlen'
>> lib/fortify_kunit.c:28:9: sparse: sparse: incompatible types for operation (==):
>> lib/fortify_kunit.c:28:9: sparse:    bad type const __left
>> lib/fortify_kunit.c:28:9: sparse:    int const __right
   lib/fortify_kunit.c:29:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:29:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:29:9: sparse: sparse: incompatible types for operation (==):
   lib/fortify_kunit.c:29:9: sparse:    bad type const __left
   lib/fortify_kunit.c:29:9: sparse:    int const __right
   lib/fortify_kunit.c:30:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:30:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:30:9: sparse: sparse: incompatible types for operation (==):
   lib/fortify_kunit.c:30:9: sparse:    bad type const __left
   lib/fortify_kunit.c:30:9: sparse:    int const __right
   lib/fortify_kunit.c:32:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:32:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:32:9: sparse: sparse: incompatible types for operation (==):
   lib/fortify_kunit.c:32:9: sparse:    bad type const __left
>> lib/fortify_kunit.c:32:9: sparse:    unsigned long const __right
   lib/fortify_kunit.c:34:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:34:9: sparse: sparse: undefined identifier '__compiletime_strlen'
   lib/fortify_kunit.c:34:9: sparse: sparse: incompatible types for operation (==):
   lib/fortify_kunit.c:34:9: sparse:    bad type const __left
   lib/fortify_kunit.c:34:9: sparse:    unsigned long const __right
   lib/fortify_kunit.c:56:16: sparse: sparse: undefined identifier '__compiletime_strlen'

vim +28 lib/fortify_kunit.c

    25	
    26	static void known_sizes_test(struct kunit *test)
    27	{
  > 28		KUNIT_EXPECT_EQ(test, __compiletime_strlen("88888888"), 8);
    29		KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_of_10), 10);
    30		KUNIT_EXPECT_EQ(test, __compiletime_strlen(ptr_of_11), 11);
    31	
  > 32		KUNIT_EXPECT_EQ(test, __compiletime_strlen(array_unknown), SIZE_MAX);
    33		/* Externally defined and dynamically sized string pointer: */
    34		KUNIT_EXPECT_EQ(test, __compiletime_strlen(saved_command_line), SIZE_MAX);
    35	}
    36	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
