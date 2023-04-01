Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7A6D34DD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 00:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDAWep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDAWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 18:34:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3CF27813
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680388483; x=1711924483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eiky+500i74r/cBfNNpHB89b7wDGe1Es5wmhXznND6w=;
  b=PyNxoiLoGs3XnkB2xQekhxJgMqQt2jLicic7RogZdtmPJZlpWJTJge/g
   ys6CxRvPIqzPQJ0grxsAS/h6oeUqkGPjECkM3YF2gOPQqT5io9/OrSQPf
   8OapRyJ67eDvnJGvWNAyJTtci0xXNS9ZiOY32em1AcH8zU/azPr62N+lt
   N/Y1WcVmziLapWMpVe3NfthKB7SreJo8Wu+qhrIwyfruXW+xoeyqhBL2U
   8uQteTC/2s66cQDjxFYzS6nOMwLA6CzYWSTr9NukVszh7YNUlfPR4QXhR
   O3q6rtuJDVe3gFax86DgGlbbSQ9qk1Wh0bp/tr6lZTJNpLWIMCsR8Ka7d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="339180027"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="339180027"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 15:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="859746408"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="859746408"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2023 15:34:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pijo0-000N5L-1m;
        Sat, 01 Apr 2023 22:34:40 +0000
Date:   Sun, 2 Apr 2023 06:34:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against
 symbol 'init_thread_union'; recompile with -fPIC
Message-ID: <202304020631.WHiXIj5y-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
commit: ffe74a6dc9bc47c7c1bb8e9a3d017f6bd5496d76 m68knommu: fix ucsimm sparse warnings
date:   1 year, 1 month ago
config: powerpc-randconfig-r016-20230402 (https://download.01.org/0day-ci/archive/20230402/202304020631.WHiXIj5y-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffe74a6dc9bc47c7c1bb8e9a3d017f6bd5496d76
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ffe74a6dc9bc47c7c1bb8e9a3d017f6bd5496d76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020631.WHiXIj5y-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
   >>> referenced by arch/powerpc/kernel/head_44x.o:(.head.text+0x4E)
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_thread_union'; recompile with -fPIC
   >>> referenced by arch/powerpc/kernel/head_44x.o:(.head.text+0x52)
--
>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against local symbol; recompile with -fPIC
   >>> defined in arch/powerpc/kernel/head_44x.o
   >>> referenced by arch/powerpc/kernel/head_44x.o:(.head.text+0x1676)
--
>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against local symbol; recompile with -fPIC
   >>> defined in arch/powerpc/kernel/head_44x.o
   >>> referenced by arch/powerpc/kernel/head_44x.o:(.head.text+0x1686)
--
>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against local symbol; recompile with -fPIC
   >>> defined in arch/powerpc/kernel/head_44x.o
   >>> referenced by arch/powerpc/kernel/head_44x.o:(.head.text+0x17DA)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
