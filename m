Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7462D6DBBD0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDHPZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHPZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:25:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A4B47A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680967502; x=1712503502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=di7Ds/VR6M8pH9m2c+PMCl3GLjlLGEaWbNcwA8dycJU=;
  b=Tfhnn8uO2GNqBPqWNTWhJtMk9PyKoxkI89PutMWdtYkkI0KjyIPnSsG4
   70hrbnVfd97ph25GD8BJKOXLpPyphN99gjGoTF5kTyYbSbzvyRmEwCqXI
   O5wuwteavk5YCyMjxSTxuj6HBOMYHQcejCjST8xUJ1HwRpir47WkSj5Bd
   /GLP4zWgtM+OIheGD5SgB0eJYq50UDCSPWarcA082+/Awkir4BczmT4Mw
   hchlg39PVBWpm7lq2/NGgThHHUeY+5JTdeL0fJQscCUjV+oILwjre20rs
   T39YSGG9JyXsng2Re17yZIFoJHEGH6aPJo+KGoFskn8SkkUoh6OOVHkOE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="322780705"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="322780705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 08:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="681297497"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="681297497"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2023 08:24:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plAR1-000Tqn-0d;
        Sat, 08 Apr 2023 15:24:59 +0000
Date:   Sat, 8 Apr 2023 23:24:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] powerpc/fsl_uli1575: Misc cleanup
Message-ID: <202304082352.xhNWS4WV-lkp@intel.com>
References: <20230408132151.8902-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408132151.8902-2-pali@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

url:    https://github.com/intel-lab-lkp/linux/commits/Pali-Roh-r/powerpc-fsl_uli1575-Misc-cleanup/20230408-212610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20230408132151.8902-2-pali%40kernel.org
patch subject: [PATCH 1/8] powerpc/fsl_uli1575: Misc cleanup
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230408/202304082352.xhNWS4WV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4d3f86e2ae53d180d2cbbe556355ff5b03d4251b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pali-Roh-r/powerpc-fsl_uli1575-Misc-cleanup/20230408-212610
        git checkout 4d3f86e2ae53d180d2cbbe556355ff5b03d4251b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304082352.xhNWS4WV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/sys_ppc32.c:56:
   arch/powerpc/include/asm/ppc-pci.h:71:45: error: 'struct pci_controller' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      71 | static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
         |                                             ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/ppc-pci.h: In function 'uli_exclude_device':
>> arch/powerpc/include/asm/ppc-pci.h:71:102: error: 'PCIBIOS_SUCCESSFUL' undeclared (first use in this function)
      71 | static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
         |                                                                                                      ^~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/ppc-pci.h:71:102: note: each undeclared identifier is reported only once for each function it appears in
   cc1: all warnings being treated as errors


vim +/PCIBIOS_SUCCESSFUL +71 arch/powerpc/include/asm/ppc-pci.h

    69	
    70	#if !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575)
  > 71	static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
    72	#endif /* !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575) */
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
