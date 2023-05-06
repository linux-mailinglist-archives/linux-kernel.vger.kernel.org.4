Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57816F92AA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjEFPT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjEFPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:19:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E117DC8
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683386363; x=1714922363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pd9AvcGpOfGBeQsoYbXGg/ee8m/Z9PM/T2rV1EugYVM=;
  b=HWS8wrBE98g2VbAQQAxeY8Is54fHmesmGTRhqlFrTtPJP+KFZ+Shu33M
   7cEpzBmIs5p6CDM/gSk39ic6g4+fclhc6Ur9z6aPECiBPKaq6LDMxm9MY
   /mA3f6demNA8s8NKfrU1fnObH+OAF9RFzx8lO0eCWHfoQh9fWPwmqEzER
   eXfdxdjfeU4HZ12pC4PuAjjY2JplLnCq9sZQLTcTPLeHtrFTLYm6s+5Wy
   TjxIXhJTFmCWDP1351RXndhPR1Q9HcmdnknRC5O9nq3y856/nqfZmxkgA
   PSVqivnvA52mypg+WkdhS8TEoHlWPEecIgCIxLI34ukHclPOS5WDbM8Eh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="329015363"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="329015363"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 08:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="730743050"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="730743050"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2023 08:19:18 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvJgr-0000Mp-1p;
        Sat, 06 May 2023 15:19:17 +0000
Date:   Sat, 6 May 2023 23:19:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, Will Deacon <will@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        torvalds@linux-foundation.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Message-ID: <202305062305.U5i9By2z-lkp@intel.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230505]
[also build test ERROR on linus/master]
[cannot apply to joro-iommu/next v6.3 v6.3-rc7 v6.3-rc6 v6.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommu-Add-Kconfig-help-text-for-IOMMU_SVA/20230506-212836
base:   next-20230505
patch link:    https://lore.kernel.org/r/20230506133134.1492395-1-jacob.jun.pan%40linux.intel.com
patch subject: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20230506/202305062305.U5i9By2z-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7a9fdfc3792c64278f1950f3880278b989749944
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jacob-Pan/iommu-Add-Kconfig-help-text-for-IOMMU_SVA/20230506-212836
        git checkout 7a9fdfc3792c64278f1950f3880278b989749944
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305062305.U5i9By2z-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/iommu-sva.c: In function 'iommu_sva_bind_device':
>> drivers/iommu/iommu-sva.c:69:32: error: invalid use of undefined type 'struct dev_iommu'
      69 |         max_pasids = dev->iommu->max_pasids;
         |                                ^~
>> drivers/iommu/iommu-sva.c:78:32: error: invalid application of 'sizeof' to incomplete type 'struct iommu_sva'
      78 |         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
         |                                ^
>> drivers/iommu/iommu-sva.c:109:15: error: invalid use of undefined type 'struct iommu_sva'
     109 |         handle->dev = dev;
         |               ^~
   drivers/iommu/iommu-sva.c:110:15: error: invalid use of undefined type 'struct iommu_sva'
     110 |         handle->domain = domain;
         |               ^~
   drivers/iommu/iommu-sva.c: In function 'iommu_sva_unbind_device':
   drivers/iommu/iommu-sva.c:134:45: error: invalid use of undefined type 'struct iommu_sva'
     134 |         struct iommu_domain *domain = handle->domain;
         |                                             ^~
   drivers/iommu/iommu-sva.c:136:36: error: invalid use of undefined type 'struct iommu_sva'
     136 |         struct device *dev = handle->dev;
         |                                    ^~
   drivers/iommu/iommu-sva.c: In function 'iommu_sva_get_pasid':
   drivers/iommu/iommu-sva.c:150:45: error: invalid use of undefined type 'struct iommu_sva'
     150 |         struct iommu_domain *domain = handle->domain;
         |                                             ^~
--
   In file included from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/scatterlist.h:8,
                    from include/linux/iommu.h:10,
                    from drivers/iommu/io-pgfault.c:8:
   drivers/iommu/io-pgfault.c: In function 'iommu_queue_iopf':
>> drivers/iommu/io-pgfault.c:153:35: error: invalid use of undefined type 'struct dev_iommu'
     153 |         lockdep_assert_held(&param->lock);
         |                                   ^~
   include/linux/lockdep.h:430:61: note: in definition of macro 'lockdep_assert_held'
     430 | #define lockdep_assert_held(l)                  do { (void)(l); } while (0)
         |                                                             ^
   drivers/iommu/io-pgfault.c:163:27: error: invalid use of undefined type 'struct dev_iommu'
     163 |         iopf_param = param->iopf_param;
         |                           ^~
   drivers/iommu/io-pgfault.c: In function 'iopf_queue_flush_dev':
   drivers/iommu/io-pgfault.c:239:26: error: invalid use of undefined type 'struct dev_iommu'
     239 |         mutex_lock(&param->lock);
         |                          ^~
   drivers/iommu/io-pgfault.c:240:27: error: invalid use of undefined type 'struct dev_iommu'
     240 |         iopf_param = param->iopf_param;
         |                           ^~
   drivers/iommu/io-pgfault.c:245:28: error: invalid use of undefined type 'struct dev_iommu'
     245 |         mutex_unlock(&param->lock);
         |                            ^~
   drivers/iommu/io-pgfault.c: In function 'iopf_queue_add_device':
   drivers/iommu/io-pgfault.c:307:26: error: invalid use of undefined type 'struct dev_iommu'
     307 |         mutex_lock(&param->lock);
         |                          ^~
   drivers/iommu/io-pgfault.c:308:19: error: invalid use of undefined type 'struct dev_iommu'
     308 |         if (!param->iopf_param) {
         |                   ^~
   drivers/iommu/io-pgfault.c:310:22: error: invalid use of undefined type 'struct dev_iommu'
     310 |                 param->iopf_param = iopf_param;
         |                      ^~
   drivers/iommu/io-pgfault.c:313:28: error: invalid use of undefined type 'struct dev_iommu'
     313 |         mutex_unlock(&param->lock);
         |                            ^~
   drivers/iommu/io-pgfault.c: In function 'iopf_queue_remove_device':
   drivers/iommu/io-pgfault.c:343:26: error: invalid use of undefined type 'struct dev_iommu'
     343 |         mutex_lock(&param->lock);
         |                          ^~
   drivers/iommu/io-pgfault.c:344:27: error: invalid use of undefined type 'struct dev_iommu'
     344 |         iopf_param = param->iopf_param;
         |                           ^~
   drivers/iommu/io-pgfault.c:347:22: error: invalid use of undefined type 'struct dev_iommu'
     347 |                 param->iopf_param = NULL;
         |                      ^~
   drivers/iommu/io-pgfault.c:350:28: error: invalid use of undefined type 'struct dev_iommu'
     350 |         mutex_unlock(&param->lock);
         |                            ^~


vim +69 drivers/iommu/iommu-sva.c

be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   45  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   46  /**
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   47   * iommu_sva_bind_device() - Bind a process address space to a device
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   48   * @dev: the device
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   49   * @mm: the mm to bind, caller must hold a reference to mm_users
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   50   *
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   51   * Create a bond between device and address space, allowing the device to
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   52   * access the mm using the PASID returned by iommu_sva_get_pasid(). If a
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   53   * bond already exists between @device and @mm, an additional internal
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   54   * reference is taken. Caller must call iommu_sva_unbind_device()
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   55   * to release each reference.
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   56   *
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   57   * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   58   * initialize the required SVA features.
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   59   *
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   60   * On error, returns an ERR_PTR value.
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   61   */
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   62  struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   63  {
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   64  	struct iommu_domain *domain;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   65  	struct iommu_sva *handle;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   66  	ioasid_t max_pasids;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   67  	int ret;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   68  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  @69  	max_pasids = dev->iommu->max_pasids;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   70  	if (!max_pasids)
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   71  		return ERR_PTR(-EOPNOTSUPP);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   72  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   73  	/* Allocate mm->pasid if necessary. */
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   74  	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   75  	if (ret)
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   76  		return ERR_PTR(ret);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   77  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  @78  	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   79  	if (!handle)
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   80  		return ERR_PTR(-ENOMEM);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   81  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   82  	mutex_lock(&iommu_sva_lock);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   83  	/* Search for an existing domain. */
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   84  	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   85  						IOMMU_DOMAIN_SVA);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   86  	if (IS_ERR(domain)) {
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   87  		ret = PTR_ERR(domain);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   88  		goto out_unlock;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   89  	}
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   90  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   91  	if (domain) {
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   92  		domain->users++;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   93  		goto out;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   94  	}
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   95  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   96  	/* Allocate a new domain and set it on device pasid. */
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   97  	domain = iommu_sva_domain_alloc(dev, mm);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   98  	if (!domain) {
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31   99  		ret = -ENOMEM;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  100  		goto out_unlock;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  101  	}
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  102  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  103  	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  104  	if (ret)
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  105  		goto out_free_domain;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  106  	domain->users = 1;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  107  out:
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  108  	mutex_unlock(&iommu_sva_lock);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31 @109  	handle->dev = dev;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  110  	handle->domain = domain;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  111  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  112  	return handle;
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  113  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  114  out_free_domain:
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  115  	iommu_domain_free(domain);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  116  out_unlock:
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  117  	mutex_unlock(&iommu_sva_lock);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  118  	kfree(handle);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  119  
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  120  	return ERR_PTR(ret);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  121  }
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  122  EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
be51b1d6bbff48 drivers/iommu/iommu-sva-lib.c Lu Baolu 2022-10-31  123  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
