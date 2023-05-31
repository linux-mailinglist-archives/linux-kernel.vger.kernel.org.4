Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A538718876
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjEaR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEaR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:28:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD0BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685554120; x=1717090120;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d3tqpsF2WfYWhWzmsFj6Fad+u5S6e3lsHsXv0FTRTHA=;
  b=EB1ES9JSWG/OFSzyRqaMjRMa0j49uaJ2RnmlQ9/dY7NymISaECcdacju
   sowhvtzh8Gbp+HL1FEa9DDONVRSUxMVWgcPw8ZRAd+h+b0pTj5Jlm7ocI
   geV+qP2gyPWVu1oiP31K6kWrpXlHt6wehfBlQBw14Y2ovF1aDE9cUAvpJ
   EpMYwsiPg4NgiO/XLRM8nd56OXjt3rlt3mtP9rzH0lpFb9QSW1XTGGvgp
   YEcn1PcxG4m6+dpj3UsfDU/ryDDz4J4XX7OQzq8xSqk93Wrhzaep8XsZp
   /vHHt+dhaWKxtHXhKVY9DPC33SZNlF437lgIQ57UGzivJFzMO2n51b7Kg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="352810403"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="352810403"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 10:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="831289896"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="831289896"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2023 10:28:35 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4Pcg-0001Vx-0T;
        Wed, 31 May 2023 17:28:34 +0000
Date:   Thu, 1 Jun 2023 01:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: drivers/scsi/pcmcia/nsp_cs.c:1683:34: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202306010129.QHfIJwq1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   48b1320a674e1ff5de2fad8606bee38f724594dc
commit: c44f15c1c09481d50fd33478ebb5b8284f8f5edb arc: iounmap() arg is volatile
date:   8 months ago
config: arc-randconfig-s052-20230531 (https://download.01.org/0day-ci/archive/20230601/202306010129.QHfIJwq1-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44f15c1c09481d50fd33478ebb5b8284f8f5edb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c44f15c1c09481d50fd33478ebb5b8284f8f5edb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/scsi/pcmcia/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306010129.QHfIJwq1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/pcmcia/nsp_cs.c:1683:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/pcmcia/nsp_cs.c:1683:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/pcmcia/nsp_cs.c:1683:34: sparse:     got void *
   drivers/scsi/pcmcia/nsp_cs.c: note: in included file:
   drivers/scsi/pcmcia/nsp_io.h:231:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned long *ptr @@
   drivers/scsi/pcmcia/nsp_io.h:231:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/pcmcia/nsp_io.h:231:24: sparse:     got unsigned long *ptr
   drivers/scsi/pcmcia/nsp_io.h:257:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned long *ptr @@
   drivers/scsi/pcmcia/nsp_io.h:257:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/pcmcia/nsp_io.h:257:17: sparse:     got unsigned long *ptr

vim +1683 drivers/scsi/pcmcia/nsp_cs.c

^1da177e4c3f415 Linus Torvalds    2005-04-16  1661  
^1da177e4c3f415 Linus Torvalds    2005-04-16  1662  
fba395eee7d3f34 Dominik Brodowski 2006-03-31  1663  static void nsp_cs_release(struct pcmcia_device *link)
^1da177e4c3f415 Linus Torvalds    2005-04-16  1664  {
^1da177e4c3f415 Linus Torvalds    2005-04-16  1665  	scsi_info_t *info = link->priv;
^1da177e4c3f415 Linus Torvalds    2005-04-16  1666  	nsp_hw_data *data = NULL;
^1da177e4c3f415 Linus Torvalds    2005-04-16  1667  
^1da177e4c3f415 Linus Torvalds    2005-04-16  1668  	if (info->host == NULL) {
^1da177e4c3f415 Linus Torvalds    2005-04-16  1669  		nsp_msg(KERN_DEBUG, "unexpected card release call.");
^1da177e4c3f415 Linus Torvalds    2005-04-16  1670  	} else {
^1da177e4c3f415 Linus Torvalds    2005-04-16  1671  		data = (nsp_hw_data *)info->host->hostdata;
^1da177e4c3f415 Linus Torvalds    2005-04-16  1672  	}
^1da177e4c3f415 Linus Torvalds    2005-04-16  1673  
^1da177e4c3f415 Linus Torvalds    2005-04-16  1674  	nsp_dbg(NSP_DEBUG_INIT, "link=0x%p", link);
^1da177e4c3f415 Linus Torvalds    2005-04-16  1675  
^1da177e4c3f415 Linus Torvalds    2005-04-16  1676  	/* Unlink the device chain */
^1da177e4c3f415 Linus Torvalds    2005-04-16  1677  	if (info->host != NULL) {
^1da177e4c3f415 Linus Torvalds    2005-04-16  1678  		scsi_remove_host(info->host);
^1da177e4c3f415 Linus Torvalds    2005-04-16  1679  	}
^1da177e4c3f415 Linus Torvalds    2005-04-16  1680  
cdb138080b78146 Dominik Brodowski 2010-07-28  1681  	if (resource_size(link->resource[2])) {
^1da177e4c3f415 Linus Torvalds    2005-04-16  1682  		if (data != NULL) {
^1da177e4c3f415 Linus Torvalds    2005-04-16 @1683  			iounmap((void *)(data->MmioAddress));
^1da177e4c3f415 Linus Torvalds    2005-04-16  1684  		}
^1da177e4c3f415 Linus Torvalds    2005-04-16  1685  	}
fba395eee7d3f34 Dominik Brodowski 2006-03-31  1686  	pcmcia_disable_device(link);
5f2a71fcb799563 Dominik Brodowski 2006-01-15  1687  
^1da177e4c3f415 Linus Torvalds    2005-04-16  1688  	if (info->host != NULL) {
^1da177e4c3f415 Linus Torvalds    2005-04-16  1689  		scsi_host_put(info->host);
^1da177e4c3f415 Linus Torvalds    2005-04-16  1690  	}
^1da177e4c3f415 Linus Torvalds    2005-04-16  1691  } /* nsp_cs_release */
^1da177e4c3f415 Linus Torvalds    2005-04-16  1692  

:::::: The code at line 1683 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
