Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B86DBDF8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 01:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDHXZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 19:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDHXZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 19:25:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5236EAE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680996320; x=1712532320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24m5rVm+qs7G49gPwB0KlhA4Br9qDAP8yJ7H8Jh0RCE=;
  b=W3kdbduOarm9ctZYs//kZKxbV5bJW2bGkJS/bPjiBwOrShZJZEvsW/E0
   l4zGtE3DU861N0d2U12d7vbYTNN5xgt+LDJaD1ilMWCg2BQzLvtFBwiaI
   fxu0Q6t6Wy9lgPuYIdKLhZrVw0d7q8G66++rH928oEcDOLQoO66YbPkVF
   sEmOV8WD2upCeptp8/q+bTylA8gekE3IHtybMcZX4LX8dDcFfzRjHAJic
   2ggkvcrriC7VP6kkEviMmywtQZkg6XaYGf9tZbb4PNLSOL1j5qYTWbTYf
   QW5GxoxQCqnJwrxIzgL4uZxv9ZgGeZ95CMBEJNpm1H1iozZxj5WGNwkFO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="331836871"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="331836871"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 16:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="687858471"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="687858471"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2023 16:25:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plHvo-000UCT-1q;
        Sat, 08 Apr 2023 23:25:16 +0000
Date:   Sun, 9 Apr 2023 07:24:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] powerpc/fsl_uli1575: Allow to disable FSL_ULI1575
 support
Message-ID: <202304090737.4gZF6L8c-lkp@intel.com>
References: <20230408154814.10400-7-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408154814.10400-7-pali@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pali-Roh-r/powerpc-fsl_uli1575-Misc-cleanup/20230408-235055
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20230408154814.10400-7-pali%40kernel.org
patch subject: [PATCH v2 6/8] powerpc/fsl_uli1575: Allow to disable FSL_ULI1575 support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230409/202304090737.4gZF6L8c-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c6f089a50f49ce965f0f8ee3a2ab0126cb519366
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pali-Roh-r/powerpc-fsl_uli1575-Misc-cleanup/20230408-235055
        git checkout c6f089a50f49ce965f0f8ee3a2ab0126cb519366
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304090737.4gZF6L8c-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: arch/powerpc/platforms/fsl_uli1575.o: in function `uli_exclude_device':
>> fsl_uli1575.c:(.text+0x36): undefined reference to `fsl_pci_primary'
>> powerpc-linux-ld: fsl_uli1575.c:(.text+0x3e): undefined reference to `fsl_pci_primary'
   powerpc-linux-ld: arch/powerpc/platforms/fsl_uli1575.o: in function `uli_init':
>> fsl_uli1575.c:(.init.text+0x1e): undefined reference to `fsl_pci_primary'
>> powerpc-linux-ld: fsl_uli1575.c:(.init.text+0x7e): undefined reference to `fsl_pci_primary'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
