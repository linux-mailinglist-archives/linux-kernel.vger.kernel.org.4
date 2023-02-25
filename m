Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165666A27FE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBYJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYJAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:00:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01576FF34
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 01:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677315638; x=1708851638;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N9jhrY5gIQpfxiSF+T+nOZL7yNeI8a74CZhPjBSicyk=;
  b=cbL9Q8kBTtMu5KAqxfU3SNMJbFKPL2hdBOsCid0aw2WJ8+4oO7O+dwLS
   kEFQ7gRHIEEVcP5RKZbAsBVpjOa6QRsoMRzCTPPZ+Bf6EpKXK2KyQfjVi
   wjTrTIYK5Xh6NLSSTo+qK0ShjIe6PSCVd04Lq+w4w9DAoM3GU+4xh2KiR
   FDjHi69V7zju1VU1njvlmWXtn5Aqr2Bwo6hMIsYLcUsmDqBcb7eDG8xhK
   C5rZgXJSctiVmX+t0Gjbfh0f6Qf/gG04bRY2Kpe54AFVJeM6zKZUcbKIq
   EXh5eGr4pSHaTPzAsK+lP3/eMT7dVX6G6li8pT7GqeFZth7kUI+mEGsx/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="313282910"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="313282910"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 01:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="650618590"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="650618590"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2023 01:00:25 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVqPo-00034l-15;
        Sat, 25 Feb 2023 09:00:24 +0000
Date:   Sat, 25 Feb 2023 16:59:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: s390-linux-ld: arc-rimi.c:undefined reference to `iounmap'
Message-ID: <202302251622.fFIHvPR0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   489fa31ea873282b41046d412ec741f93946fc2d
commit: 71ba41c9b1d91042960e9d92a5c8f52dc8531eda s390/pci: provide support for MIO instructions
date:   3 years, 10 months ago
config: s390-randconfig-r015-20230225 (https://download.01.org/0day-ci/archive/20230225/202302251622.fFIHvPR0-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71ba41c9b1d91042960e9d92a5c8f52dc8531eda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302251622.fFIHvPR0-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0x8a): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xce): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0x25e): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x29c): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe.part.0':
   main.c:(.text+0x528): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x5e4): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x61a): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x664): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_exit':
   com90xx.c:(.exit.text+0x5a): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `check_mirror':
   com90xx.c:(.init.text+0x4c): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x6e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_found':
   com90xx.c:(.init.text+0xe6): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x1ba): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x2d4): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x3a2): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_probe':
   com90xx.c:(.init.text+0x64c): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x6a8): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x8d6): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x2e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
   arc-rimi.c:(.init.text+0xb6): undefined reference to `ioremap'
>> s390-linux-ld: arc-rimi.c:(.init.text+0x132): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x29a): undefined reference to `iounmap'
>> s390-linux-ld: arc-rimi.c:(.init.text+0x322): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x3e0): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
>> arc-rimi.c:(.text.unlikely+0x4c): undefined reference to `ioremap'
>> s390-linux-ld: arc-rimi.c:(.text.unlikely+0x6e): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x210): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x222): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x278): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x28e): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xd34): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
