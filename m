Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626C46AC8A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCFQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCFQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:47:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2263BDBC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121193; x=1709657193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6qIIcCpDG4ZVZPI2n6xnI1keRHoTZIsqP3OE8s5NenM=;
  b=bR/Yi9hHJYnNVrASq+zQmttVCoy9LkCkZqMmp6CuNRgAtyKC9q4S0Cbf
   eax4I2Uv4ufcrd1fWV4PVPwX5weAWIMAcvyJ9JRt9sqlUiiFYvSfunB3d
   OoREcH4Y+VPYqlpH1XBjyNlie/1+1Ap4Ii2cXFEJ2yJPzcrnYZy/6Al9o
   eMU5cjC5zUQtiVgMB0/GJR50xMlL2orgFUa8l8UBR+XT9wzdh6+uaP1ze
   fkQgtTvGcxVvS6I62aFMw04s764OlOmptLMTxhZrvBKuVZ4yugQoRCM2K
   j3JEgWopG3ooqloqV+QyOVK0S4PSvTR+P3vt1tUqhf+9f7c73vnEnj+1A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="421877721"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="421877721"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653674436"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="653674436"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2023 08:45:27 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZDxm-0000Th-2v;
        Mon, 06 Mar 2023 16:45:26 +0000
Date:   Tue, 7 Mar 2023 00:45:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: fmvj18x_cs.c:undefined reference to `ioremap'
Message-ID: <202303070034.im9tDu6N-lkp@intel.com>
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

Hi Sebastian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe15c26ee26efa11741a7b632e9f23b01aca4cc6
commit: 71ba41c9b1d91042960e9d92a5c8f52dc8531eda s390/pci: provide support for MIO instructions
date:   3 years, 10 months ago
config: s390-buildonly-randconfig-r004-20230306 (https://download.01.org/0day-ci/archive/20230307/202303070034.im9tDu6N-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202303070034.im9tDu6N-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x1fec): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x5c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0x92): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xd6): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0x268): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x376): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe.part.0':
   main.c:(.text+0x534): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x5e0): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x62c): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x660): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x190): undefined reference to `devm_ioremap_nocache'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_release':
   fmvj18x_cs.c:(.text+0x492): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_get_hwinfo':
>> fmvj18x_cs.c:(.text+0xd1e): undefined reference to `ioremap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0xd88): undefined reference to `iounmap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0xe18): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_config':
   fmvj18x_cs.c:(.text+0x1196): undefined reference to `ioremap'
   s390-linux-ld: fmvj18x_cs.c:(.text+0x11ea): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_release':
   smc91c92_cs.c:(.text+0x750): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_config':
   smc91c92_cs.c:(.text+0x23c2): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x466): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x49c): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x50e): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x520): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xd38): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
