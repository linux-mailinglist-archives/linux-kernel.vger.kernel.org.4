Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30BC6ABA7F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCFJ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCFJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:57:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877123862
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678096619; x=1709632619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+NM2BD74xBBPV/J+Yymsh+jtxeVrSe3LBZNp5rHQZZ8=;
  b=h1OYfA2R+nX42ihvO58f2safBTXwHNxDm3lhcw8+JF5NmWVYPuvoSQ3A
   UL3tEy0wdvdNDbe74TsMlrbHFkaBljQU7JcqC85EdbMYuzfVapL1J1Jct
   s6v6WOFyOZLK5c1lMlLV0Tjn9q7DH95huMQqxT+ZrIf2/pZPRR5PSujiU
   7YmMOByQyB418rKpj0U4o9BSwGFYRBN1O61Mpl34mx8khyvOYruXibVTq
   3SfEcwuMTI9Z2+0CuYGA+PNd54tHkat5QhIgi7CgMeXJnF9T1eKRwUghe
   5b+m5zdq3AdX98qZquaTcm3Nf87ei6rjQKervGCnM9dpy8sMWi2OnE99g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="315175700"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="315175700"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 01:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="786158388"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="786158388"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Mar 2023 01:56:57 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZ7aT-0000E1-03;
        Mon, 06 Mar 2023 09:56:57 +0000
Date:   Mon, 6 Mar 2023 17:56:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202303061720.BJQPtAIi-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe15c26ee26efa11741a7b632e9f23b01aca4cc6
commit: 4ec4190be4cf9cc3e0ccaf5f155a5f9066d18950 kasan, x86: don't rename memintrinsics in uninstrumented files
date:   3 days ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20230306/202303061720.BJQPtAIi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ec4190be4cf9cc3e0ccaf5f155a5f9066d18950
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4ec4190be4cf9cc3e0ccaf5f155a5f9066d18950
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/apei/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303061720.BJQPtAIi-lkp@intel.com/

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
>> drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
>> drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void const *
   drivers/acpi/apei/erst.c:792:9: sparse:     got void [noderef] __iomem *static [toplevel] vaddr
>> drivers/acpi/apei/erst.c:792:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *static [toplevel] vaddr @@
   drivers/acpi/apei/erst.c:792:9: sparse:     expected void *p
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
