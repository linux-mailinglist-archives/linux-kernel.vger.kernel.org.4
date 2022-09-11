Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6045B51A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIKWwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIKWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:52:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14851F61D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662936734; x=1694472734;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8H5PSGGeWzYiiVz9qclG4t//5x9fERjt6hrGx1xjOW8=;
  b=YyjVdUwCLYqRjh5nU4/skY4cF/WXxl4nl20HavxPABFTwxL+uNAl96J0
   W0SmiPWqW8bqq2IACTSoJDWEQmUANI8JgnRPh/kHO9ElNGOLWsQWJSp/M
   yGfMX0s2ISBDhpwo9Fw3ti8ItMhC5cX3GzngPtnm8BNBM0id6mRgsRjwr
   8sJ/8Risc2/a3Rg9zLpPT+qcdhFsj0L5IfaPkuu3k1fHptUGmSSVbYMgi
   rOaAJzXJ3Rc47y9MnnvNf43op6TaA31bxCAV4Df1T7i1aMO4xWs3HZzd9
   XhVaTRHoiVF8X/BCTgkc/jXiVC77bLpoFgBil7fN1JATpeIYK8W6u2Lqt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="278148992"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="278148992"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 15:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="684232496"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2022 15:52:12 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXVoC-0001vX-0P;
        Sun, 11 Sep 2022 22:52:12 +0000
Date:   Mon, 12 Sep 2022 06:52:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>
Subject: kernel/dma/pool.c:105:44: error: implicit declaration of function
 'pgprot_dmacoherent'
Message-ID: <202209120606.OZwzCcvk-lkp@intel.com>
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

Hi Heiko,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e78fcce86de0288793a0ef0f6acf37656ee4cf
commit: d20ec7529236a2fcdb2d856fc0bd80b409a217fc riscv: implement cache-management errata for T-Head SoCs
date:   6 weeks ago
config: riscv-randconfig-r036-20220912 (https://download.01.org/0day-ci/archive/20220912/202209120606.OZwzCcvk-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d20ec7529236a2fcdb2d856fc0bd80b409a217fc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d20ec7529236a2fcdb2d856fc0bd80b409a217fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/dma/pool.c: In function 'atomic_pool_expand':
>> kernel/dma/pool.c:105:44: error: implicit declaration of function 'pgprot_dmacoherent' [-Werror=implicit-function-declaration]
     105 |                                            pgprot_dmacoherent(PAGE_KERNEL),
         |                                            ^~~~~~~~~~~~~~~~~~
>> kernel/dma/pool.c:105:44: error: incompatible type for argument 3 of 'dma_common_contiguous_remap'
     105 |                                            pgprot_dmacoherent(PAGE_KERNEL),
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            int
   In file included from kernel/dma/pool.c:8:
   include/linux/dma-map-ops.h:235:76: note: expected 'pgprot_t' but argument is of type 'int'
     235 | void *dma_common_contiguous_remap(struct page *page, size_t size, pgprot_t prot,
         |                                                                   ~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/pgprot_dmacoherent +105 kernel/dma/pool.c

d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   78  
54adadf9b08571 David Rientjes         2020-04-20   79  static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
54adadf9b08571 David Rientjes         2020-04-20   80  			      gfp_t gfp)
e860c299ac0d73 David Rientjes         2020-04-14   81  {
54adadf9b08571 David Rientjes         2020-04-20   82  	unsigned int order;
892fc9f6835ecf Dan Carpenter          2020-08-26   83  	struct page *page = NULL;
e860c299ac0d73 David Rientjes         2020-04-14   84  	void *addr;
54adadf9b08571 David Rientjes         2020-04-20   85  	int ret = -ENOMEM;
54adadf9b08571 David Rientjes         2020-04-20   86  
54adadf9b08571 David Rientjes         2020-04-20   87  	/* Cannot allocate larger than MAX_ORDER-1 */
54adadf9b08571 David Rientjes         2020-04-20   88  	order = min(get_order(pool_size), MAX_ORDER-1);
54adadf9b08571 David Rientjes         2020-04-20   89  
54adadf9b08571 David Rientjes         2020-04-20   90  	do {
54adadf9b08571 David Rientjes         2020-04-20   91  		pool_size = 1 << (PAGE_SHIFT + order);
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   92  		if (cma_in_zone(gfp))
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   93  			page = dma_alloc_from_contiguous(NULL, 1 << order,
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   94  							 order, false);
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   95  		if (!page)
c84dc6e68a1d24 David Rientjes         2020-04-14   96  			page = alloc_pages(gfp, order);
54adadf9b08571 David Rientjes         2020-04-20   97  	} while (!page && order-- > 0);
e860c299ac0d73 David Rientjes         2020-04-14   98  	if (!page)
e860c299ac0d73 David Rientjes         2020-04-14   99  		goto out;
e860c299ac0d73 David Rientjes         2020-04-14  100  
c84dc6e68a1d24 David Rientjes         2020-04-14  101  	arch_dma_prep_coherent(page, pool_size);
e860c299ac0d73 David Rientjes         2020-04-14  102  
76a19940bd62a8 David Rientjes         2020-04-14  103  #ifdef CONFIG_DMA_DIRECT_REMAP
c84dc6e68a1d24 David Rientjes         2020-04-14  104  	addr = dma_common_contiguous_remap(page, pool_size,
e860c299ac0d73 David Rientjes         2020-04-14 @105  					   pgprot_dmacoherent(PAGE_KERNEL),
e860c299ac0d73 David Rientjes         2020-04-14  106  					   __builtin_return_address(0));
e860c299ac0d73 David Rientjes         2020-04-14  107  	if (!addr)
54adadf9b08571 David Rientjes         2020-04-20  108  		goto free_page;
76a19940bd62a8 David Rientjes         2020-04-14  109  #else
76a19940bd62a8 David Rientjes         2020-04-14  110  	addr = page_to_virt(page);
76a19940bd62a8 David Rientjes         2020-04-14  111  #endif
76a19940bd62a8 David Rientjes         2020-04-14  112  	/*
76a19940bd62a8 David Rientjes         2020-04-14  113  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
2f5388a29be82a Christoph Hellwig      2020-08-17  114  	 * shrink so no re-encryption occurs in dma_direct_free().
76a19940bd62a8 David Rientjes         2020-04-14  115  	 */
76a19940bd62a8 David Rientjes         2020-04-14  116  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
76a19940bd62a8 David Rientjes         2020-04-14  117  				   1 << order);
76a19940bd62a8 David Rientjes         2020-04-14  118  	if (ret)
76a19940bd62a8 David Rientjes         2020-04-14  119  		goto remove_mapping;
54adadf9b08571 David Rientjes         2020-04-20  120  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
54adadf9b08571 David Rientjes         2020-04-20  121  				pool_size, NUMA_NO_NODE);
e860c299ac0d73 David Rientjes         2020-04-14  122  	if (ret)
76a19940bd62a8 David Rientjes         2020-04-14  123  		goto encrypt_mapping;
e860c299ac0d73 David Rientjes         2020-04-14  124  
2edc5bb3c5cc42 David Rientjes         2020-04-14  125  	dma_atomic_pool_size_add(gfp, pool_size);
e860c299ac0d73 David Rientjes         2020-04-14  126  	return 0;
e860c299ac0d73 David Rientjes         2020-04-14  127  
76a19940bd62a8 David Rientjes         2020-04-14  128  encrypt_mapping:
76a19940bd62a8 David Rientjes         2020-04-14  129  	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
76a19940bd62a8 David Rientjes         2020-04-14  130  				   1 << order);
76a19940bd62a8 David Rientjes         2020-04-14  131  	if (WARN_ON_ONCE(ret)) {
76a19940bd62a8 David Rientjes         2020-04-14  132  		/* Decrypt succeeded but encrypt failed, purposely leak */
76a19940bd62a8 David Rientjes         2020-04-14  133  		goto out;
76a19940bd62a8 David Rientjes         2020-04-14  134  	}
e860c299ac0d73 David Rientjes         2020-04-14  135  remove_mapping:
76a19940bd62a8 David Rientjes         2020-04-14  136  #ifdef CONFIG_DMA_DIRECT_REMAP
c84dc6e68a1d24 David Rientjes         2020-04-14  137  	dma_common_free_remap(addr, pool_size);
76a19940bd62a8 David Rientjes         2020-04-14  138  #endif
76a19940bd62a8 David Rientjes         2020-04-14  139  free_page: __maybe_unused
c84dc6e68a1d24 David Rientjes         2020-04-14  140  	__free_pages(page, order);
e860c299ac0d73 David Rientjes         2020-04-14  141  out:
54adadf9b08571 David Rientjes         2020-04-20  142  	return ret;
54adadf9b08571 David Rientjes         2020-04-20  143  }
54adadf9b08571 David Rientjes         2020-04-20  144  

:::::: The code at line 105 was first introduced by commit
:::::: e860c299ac0d738b44ff91693f11e63080a29698 dma-remap: separate DMA atomic pools from direct remap code

:::::: TO: David Rientjes <rientjes@google.com>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
