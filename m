Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9B6C87C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjCXVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjCXVxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:53:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68C26A7C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679694827; x=1711230827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YSefkMhBTcwg9nG5RmcjquWPkto72IS4rieZnW77+ls=;
  b=F0uDzTyvuZUh+H8Og4pKg/N/D6kZDuBm6J1G8gcHhut5Bnta/CbrXhdS
   JolhYZhmocX7Dj7FPfdah5B1VMdwWTDwY5TAqfsL579+OKhyeG2Q5AHXY
   MbwL/HdQ7YQSS5UfbFidgEuoDi0lu3uDaNnAJxiOQ8g3Ky5rg22fOaL9E
   ltNz/VH24zoi+5adq4GdCjS3asFaUk1iU4EzQeMJ76zMxymavfFOR42nY
   Gy5BBvvqIuFdSP1kCyT2NXJiBQvzPK8RyhdxO/68gLct1ssdpOLSVcs/F
   +G278Z77AorIrcm4ceCk9GdvEKMFj3fjoHTzWOkAnd0XQiZxhcT3hDDCh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341462743"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="341462743"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 14:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="685330624"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="685330624"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2023 14:53:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfpLq-000Fgi-2P;
        Fri, 24 Mar 2023 21:53:34 +0000
Date:   Sat, 25 Mar 2023 05:53:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Fitzgerald via Alsa-devel <alsa-devel@alsa-project.org>,
        broonie@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Add a debugfs entry containing control
 details
Message-ID: <202303250526.oZMat3JD-lkp@intel.com>
References: <167967423036.26.11080959777905296733@mailman-core.alsa-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167967423036.26.11080959777905296733@mailman-core.alsa-project.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Fitzgerald-via-Alsa-devel/firmware-cs_dsp-Add-a-debugfs-entry-containing-control-details/20230325-001558
patch link:    https://lore.kernel.org/r/167967423036.26.11080959777905296733%40mailman-core.alsa-project.org
patch subject: [PATCH] firmware: cs_dsp: Add a debugfs entry containing control details
config: powerpc-randconfig-r001-20230322 (https://download.01.org/0day-ci/archive/20230325/202303250526.oZMat3JD-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/2e31e4948e1f907f41ef4946c6f59426c2206b95
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Fitzgerald-via-Alsa-devel/firmware-cs_dsp-Add-a-debugfs-entry-containing-control-details/20230325-001558
        git checkout 2e31e4948e1f907f41ef4946c6f59426c2206b95
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/firmware/cirrus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250526.oZMat3JD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:77:1: note: expanded from here
   __do_insb
   ^
   arch/powerpc/include/asm/io.h:577:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/firmware/cirrus/cs_dsp.c:21:
   In file included from include/linux/firmware/cirrus/cs_dsp.h:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:79:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:578:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/firmware/cirrus/cs_dsp.c:21:
   In file included from include/linux/firmware/cirrus/cs_dsp.h:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:81:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/firmware/cirrus/cs_dsp.c:21:
   In file included from include/linux/firmware/cirrus/cs_dsp.h:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:83:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/firmware/cirrus/cs_dsp.c:21:
   In file included from include/linux/firmware/cirrus/cs_dsp.h:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:85:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/firmware/cirrus/cs_dsp.c:21:
   In file included from include/linux/firmware/cirrus/cs_dsp.h:18:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:87:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/firmware/cirrus/cs_dsp.c:472:39: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                              ctl->subname_len, ctl->subname, ctl->len,
                                                              ^~~~~~~~
   7 warnings generated.


vim +472 drivers/firmware/cirrus/cs_dsp.c

   459	
   460	static int cs_dsp_coeff_base_reg(struct cs_dsp_coeff_ctl *ctl, unsigned int *reg,
   461					 unsigned int off);
   462	
   463	static int cs_dsp_debugfs_read_controls_show(struct seq_file *s, void *ignored)
   464	{
   465		struct cs_dsp *dsp = s->private;
   466		struct cs_dsp_coeff_ctl *ctl;
   467		unsigned int reg;
   468	
   469		list_for_each_entry(ctl, &dsp->ctl_list, list) {
   470			cs_dsp_coeff_base_reg(ctl, &reg, 0);
   471			seq_printf(s, "%22.*s: %#8lx %s:%08x %#8x %s %#8x %#4x %c%c%c%c %s %s\n",
 > 472				   ctl->subname_len, ctl->subname, ctl->len,
   473				   cs_dsp_mem_region_name(ctl->alg_region.type),
   474				   ctl->offset, reg, ctl->fw_name, ctl->alg_region.alg, ctl->type,
   475				   ctl->flags & WMFW_CTL_FLAG_VOLATILE ? 'V' : '-',
   476				   ctl->flags & WMFW_CTL_FLAG_SYS ? 'S' : '-',
   477				   ctl->flags & WMFW_CTL_FLAG_READABLE ? 'R' : '-',
   478				   ctl->flags & WMFW_CTL_FLAG_WRITEABLE ? 'W' : '-',
   479				   ctl->enabled ? "enabled" : "disabled",
   480				   ctl->set ? "dirty" : "clean");
   481		}
   482	
   483		return 0;
   484	}
   485	DEFINE_SHOW_ATTRIBUTE(cs_dsp_debugfs_read_controls);
   486	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
