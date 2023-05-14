Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D17C701B82
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 06:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjENE30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 00:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENE3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 00:29:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48E1BCF
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 21:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684038562; x=1715574562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1jyo1/+VMGYuqKKg0yEqQ7o13C0Q5YZcJ9AZTxxQcIE=;
  b=QJ00QxblYOa2G950iLW3tQNI4jxevtGGTVMrI08LMY3LZHYW4gMn9tc2
   weIglnr+7PsGfRw8Ln/Fh6cswNVIjlUKXVqAykT6WGFNNJYFhgFQ8tmXo
   vrWXl1VkF994LsgkOZRGikagLhs30nu3tGhi4s3hcmDWRRQ2dbojLDQbm
   VHUpTE0Yz6499jc6Yxk633uEOZsS5HUW+gb8JsyCBBE2LJYVJJK5kaq3I
   GlUVY/H3WLPvbWqBHWFTqd8QPcCgIEz3UY0nSNgVd16RY2VxppRhXwOL1
   5XyjRQmHGB8Zl8x5C0dRQcH9ro8wiK0R9JO1Gaegv8xxfkjpJp8eXTCq2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="335537083"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="335537083"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 21:29:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="694656730"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="694656730"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2023 21:29:21 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1py3MG-0005pA-16;
        Sun, 14 May 2023 04:29:20 +0000
Date:   Sun, 14 May 2023 12:28:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true
 condition '(pio >= (0 - 0)) => (0-u32max >= 0)'
Message-ID: <202305141227.mVZGYR0O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bb7c241fae6228e89c0286ffd6f249b3b0dea225
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   10 months ago
config: openrisc-randconfig-m031-20230509 (https://download.01.org/0day-ci/archive/20230514/202305141227.mVZGYR0O-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305141227.mVZGYR0O-lkp@intel.com/

smatch warnings:
drivers/pci/pci.c:4195 pci_pio_to_address() warn: always true condition '(pio >= (0 - 0)) => (0-u32max >= 0)'
drivers/infiniband/hw/mthca/mthca_memfree.c:720 mthca_init_db_tab() warn: other places set '(struct mthca_db_table)->npages' to 'page' instead of 'array_size'

vim +4195 drivers/pci/pci.c

c5076cfe768998 Tomasz Nowicki 2016-05-11  4189  
c5076cfe768998 Tomasz Nowicki 2016-05-11  4190  phys_addr_t pci_pio_to_address(unsigned long pio)
c5076cfe768998 Tomasz Nowicki 2016-05-11  4191  {
c5076cfe768998 Tomasz Nowicki 2016-05-11  4192  	phys_addr_t address = (phys_addr_t)OF_BAD_ADDR;
c5076cfe768998 Tomasz Nowicki 2016-05-11  4193  
c5076cfe768998 Tomasz Nowicki 2016-05-11  4194  #ifdef PCI_IOBASE
5745392e0c2b78 Zhichang Yuan  2018-03-15 @4195  	if (pio >= MMIO_UPPER_LIMIT)
c5076cfe768998 Tomasz Nowicki 2016-05-11  4196  		return address;
c5076cfe768998 Tomasz Nowicki 2016-05-11  4197  
5745392e0c2b78 Zhichang Yuan  2018-03-15  4198  	address = logic_pio_to_hwaddr(pio);
c5076cfe768998 Tomasz Nowicki 2016-05-11  4199  #endif
c5076cfe768998 Tomasz Nowicki 2016-05-11  4200  
c5076cfe768998 Tomasz Nowicki 2016-05-11  4201  	return address;
c5076cfe768998 Tomasz Nowicki 2016-05-11  4202  }
9cc742078c9a90 Jianjun Wang   2021-04-20  4203  EXPORT_SYMBOL_GPL(pci_pio_to_address);
c5076cfe768998 Tomasz Nowicki 2016-05-11  4204  

:::::: The code at line 4195 was first introduced by commit
:::::: 5745392e0c2b78e0d73203281d5c42cbd6993194 PCI: Apply the new generic I/O management on PCI IO hosts

:::::: TO: Zhichang Yuan <yuanzhichang@hisilicon.com>
:::::: CC: Bjorn Helgaas <helgaas@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
