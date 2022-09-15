Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3796D5B9360
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiIODoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIODoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:44:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F4633E;
        Wed, 14 Sep 2022 20:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663213456; x=1694749456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=td82Oi7e6RaQUxvklJ/6txDHDjNMgCxLv4QVzl1DZjo=;
  b=jKCO067tsW5G//aJ28TEpJzhRfrq5iAU6VhDNsakR2SKAFwkdgU+Z5cw
   Fts+hWo1aLhH95Z8tEx82SSf6A0kg9rQrBQ2Lzmr3ujFLvdSUnvJ6FTxm
   afZqKQjx0B9zhsARNqU/jyV6STIqpqGN/xQM7P/6ouxsnMMYmm08seDDh
   1YANP8wgHqnWATntf6xKgEqf0Tu6Qk1cPb0hCie54dLNKST9/CH4h9/Gv
   a9rAOKSGjV3nIOo9b4iypQ4FHu1Iqhusq8VTEFd1MKJccIuOCf5Jqur3E
   FFDIC5umjL96zbih0ZcWl+v8108M22ptukJhROkSqq87MU/XxGzDgLzce
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="360342401"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="360342401"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 20:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="650316127"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2022 20:44:12 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYfnP-0000q2-2Z;
        Thu, 15 Sep 2022 03:44:11 +0000
Date:   Thu, 15 Sep 2022 11:43:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [s390:features 12/14] arch/s390/mm/maccess.c:85:13: warning: no
 previous prototype for 'memcpy_real_init'
Message-ID: <202209151106.vetUM3Xc-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   fba07cd4dd8fb4833015801a83f945b2d65a5c4b
commit: 2f0e8aae26a27fe73d033788f8e92188e7584f41 [12/14] s390/mm: rework memcpy_real() to avoid DAT-off mode
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220915/202209151106.vetUM3Xc-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?id=2f0e8aae26a27fe73d033788f8e92188e7584f41
        git remote add s390 https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
        git fetch --no-tags s390 features
        git checkout 2f0e8aae26a27fe73d033788f8e92188e7584f41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/s390/mm/maccess.c:85:13: warning: no previous prototype for 'memcpy_real_init' [-Wmissing-prototypes]
      85 | void __init memcpy_real_init(void)
         |             ^~~~~~~~~~~~~~~~
>> arch/s390/mm/maccess.c:92:8: warning: no previous prototype for 'memcpy_real_iter' [-Wmissing-prototypes]
      92 | size_t memcpy_real_iter(struct iov_iter *iter, unsigned long src, size_t count)
         |        ^~~~~~~~~~~~~~~~
>> arch/s390/mm/maccess.c:123:5: warning: no previous prototype for 'memcpy_real' [-Wmissing-prototypes]
     123 | int memcpy_real(void *dest, unsigned long src, size_t count)
         |     ^~~~~~~~~~~


vim +/memcpy_real_init +85 arch/s390/mm/maccess.c

    84	
  > 85	void __init memcpy_real_init(void)
    86	{
    87		memcpy_real_ptep = vmem_get_alloc_pte(__memcpy_real_area, true);
    88		if (!memcpy_real_ptep)
    89			panic("Couldn't setup memcpy real area");
    90	}
    91	
  > 92	size_t memcpy_real_iter(struct iov_iter *iter, unsigned long src, size_t count)
    93	{
    94		size_t len, copied, res = 0;
    95		unsigned long phys, offset;
    96		void *chunk;
    97		pte_t pte;
    98	
    99		while (count) {
   100			phys = src & PAGE_MASK;
   101			offset = src & ~PAGE_MASK;
   102			chunk = (void *)(__memcpy_real_area + offset);
   103			len = min(count, PAGE_SIZE - offset);
   104			pte = mk_pte_phys(phys, PAGE_KERNEL_RO);
   105	
   106			mutex_lock(&memcpy_real_mutex);
   107			if (pte_val(pte) != pte_val(*memcpy_real_ptep)) {
   108				__ptep_ipte(__memcpy_real_area, memcpy_real_ptep, 0, 0, IPTE_GLOBAL);
   109				set_pte(memcpy_real_ptep, pte);
   110			}
   111			copied = copy_to_iter(chunk, len, iter);
   112			mutex_unlock(&memcpy_real_mutex);
   113	
   114			count -= copied;
   115			src += copied;
   116			res += copied;
   117			if (copied < len)
   118				break;
   119		}
   120		return res;
   121	}
   122	
 > 123	int memcpy_real(void *dest, unsigned long src, size_t count)
   124	{
   125		struct iov_iter iter;
   126		struct kvec kvec;
   127	
   128		kvec.iov_base = dest;
   129		kvec.iov_len = count;
   130		iov_iter_kvec(&iter, WRITE, &kvec, 1, count);
   131		if (memcpy_real_iter(&iter, src, count) < count)
   132			return -EFAULT;
   133		return 0;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
