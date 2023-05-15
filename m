Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36E3702755
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjEOIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjEOIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:34:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C11995
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684139668; x=1715675668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GPaXAyag5xMJETbvb38oCN58x/6O1HMembVMLAEucZ4=;
  b=K+NLxkZgNLy8vFJPj4h8rl9u0XG7a5QD8ma1MdrqDwz04jXewtyow+XZ
   /xxiiZmELE8jVpIooN/Q5njaAOwBRzHHrVWjtmnoWgSbjzCkAfyIoCdTg
   Vq04xo25uxOuZ/7kxD6R1cf9U+QEdSujU+QgyyBAypgZcfeKpUgNta+sk
   ac+RW1MzJ0j0zlrOKdhqkFxR1wvB03TTUQ7rj5y5dLKdOqcu+8xW5vqsJ
   ghYKoXyHOppc4DFlciTxDIGM4HLuTz8yfToHcp5w0PaHveV7Jos2pkC6+
   6LmBbnwtQhWU4Bbqn0vmh7rfh2IXtwH3bwqT/1hORdQpJehH7lmcPiJyI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="414541365"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="414541365"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 01:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="731556205"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="731556205"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 May 2023 01:34:20 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyTej-0006Ho-2H;
        Mon, 15 May 2023 08:34:09 +0000
Date:   Mon, 15 May 2023 16:33:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>
Subject: drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202305151602.HQFreva1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: e240e53ae0abb0896e0f399bdfef41c69cec3123 mm, slub: add CONFIG_SLUB_TINY
date:   6 months ago
config: x86_64-randconfig-s022-20230515 (https://download.01.org/0day-ci/archive/20230515/202305151602.HQFreva1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e240e53ae0abb0896e0f399bdfef41c69cec3123
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e240e53ae0abb0896e0f399bdfef41c69cec3123
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/apei/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305151602.HQFreva1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/acpi/apei/erst.c:272:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *src @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:272:13: sparse:     expected void *src
   drivers/acpi/apei/erst.c:272:13: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/erst.c:275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *dst @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:275:13: sparse:     expected void *dst
   drivers/acpi/apei/erst.c:275:13: sparse:     got void [noderef] __iomem *
   drivers/acpi/apei/erst.c:277:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *src @@
   drivers/acpi/apei/erst.c:277:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:277:25: sparse:     got void *src
   drivers/acpi/apei/erst.c:283:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *src @@
   drivers/acpi/apei/erst.c:283:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:283:17: sparse:     got void *src
   drivers/acpi/apei/erst.c:284:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *dst @@
   drivers/acpi/apei/erst.c:284:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/apei/erst.c:284:17: sparse:     got void *dst
   drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
>> drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:793:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cper_record_header *rcd_erange @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:793:20: sparse:     expected struct cper_record_header *rcd_erange
   drivers/acpi/apei/erst.c:793:20: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
   drivers/acpi/apei/erst.c:830:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cper_record_header *rcd_tmp @@     got void [noderef] __iomem * @@
   drivers/acpi/apei/erst.c:830:17: sparse:     expected struct cper_record_header *rcd_tmp
   drivers/acpi/apei/erst.c:830:17: sparse:     got void [noderef] __iomem *

vim +792 drivers/acpi/apei/erst.c

a08f82d08053fb Huang Ying 2010-05-18  766  
a08f82d08053fb Huang Ying 2010-05-18  767  int erst_write(const struct cper_record_header *record)
a08f82d08053fb Huang Ying 2010-05-18  768  {
a08f82d08053fb Huang Ying 2010-05-18  769  	int rc;
a08f82d08053fb Huang Ying 2010-05-18  770  	unsigned long flags;
a08f82d08053fb Huang Ying 2010-05-18  771  	struct cper_record_header *rcd_erange;
a08f82d08053fb Huang Ying 2010-05-18  772  
a08f82d08053fb Huang Ying 2010-05-18  773  	if (erst_disable)
a08f82d08053fb Huang Ying 2010-05-18  774  		return -ENODEV;
a08f82d08053fb Huang Ying 2010-05-18  775  
a08f82d08053fb Huang Ying 2010-05-18  776  	if (memcmp(record->signature, CPER_SIG_RECORD, CPER_SIG_SIZE))
a08f82d08053fb Huang Ying 2010-05-18  777  		return -EINVAL;
a08f82d08053fb Huang Ying 2010-05-18  778  
a08f82d08053fb Huang Ying 2010-05-18  779  	if (erst_erange.attr & ERST_RANGE_NVRAM) {
3b38bb5f7f0635 Huang Ying 2010-12-02  780  		if (!raw_spin_trylock_irqsave(&erst_lock, flags))
a08f82d08053fb Huang Ying 2010-05-18  781  			return -EBUSY;
a08f82d08053fb Huang Ying 2010-05-18  782  		rc = __erst_write_to_nvram(record);
3b38bb5f7f0635 Huang Ying 2010-12-02  783  		raw_spin_unlock_irqrestore(&erst_lock, flags);
a08f82d08053fb Huang Ying 2010-05-18  784  		return rc;
a08f82d08053fb Huang Ying 2010-05-18  785  	}
a08f82d08053fb Huang Ying 2010-05-18  786  
a08f82d08053fb Huang Ying 2010-05-18  787  	if (record->record_length > erst_erange.size)
a08f82d08053fb Huang Ying 2010-05-18  788  		return -EINVAL;
a08f82d08053fb Huang Ying 2010-05-18  789  
3b38bb5f7f0635 Huang Ying 2010-12-02  790  	if (!raw_spin_trylock_irqsave(&erst_lock, flags))
a08f82d08053fb Huang Ying 2010-05-18  791  		return -EBUSY;
a08f82d08053fb Huang Ying 2010-05-18 @792  	memcpy(erst_erange.vaddr, record, record->record_length);
a08f82d08053fb Huang Ying 2010-05-18  793  	rcd_erange = erst_erange.vaddr;
a08f82d08053fb Huang Ying 2010-05-18  794  	/* signature for serialization system */
a08f82d08053fb Huang Ying 2010-05-18  795  	memcpy(&rcd_erange->persistence_information, "ER", 2);
a08f82d08053fb Huang Ying 2010-05-18  796  
a08f82d08053fb Huang Ying 2010-05-18  797  	rc = __erst_write_to_storage(0);
3b38bb5f7f0635 Huang Ying 2010-12-02  798  	raw_spin_unlock_irqrestore(&erst_lock, flags);
a08f82d08053fb Huang Ying 2010-05-18  799  
a08f82d08053fb Huang Ying 2010-05-18  800  	return rc;
a08f82d08053fb Huang Ying 2010-05-18  801  }
a08f82d08053fb Huang Ying 2010-05-18  802  EXPORT_SYMBOL_GPL(erst_write);
a08f82d08053fb Huang Ying 2010-05-18  803  

:::::: The code at line 792 was first introduced by commit
:::::: a08f82d08053fb6e3aa3635c2c26456d96337c8b ACPI, APEI, Error Record Serialization Table (ERST) support

:::::: TO: Huang Ying <ying.huang@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
