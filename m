Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD135B4151
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIIVPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIIVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:15:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F03A170
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662758111; x=1694294111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6IKYcdh+OBDJQ4GMcMHjzTrOqHL8Y2mHmcX2xzTbbyA=;
  b=n1gkmO2MCpgVhNZISCL7hFmJuZXIPUGBge2GvK6fKn43MTV0Y5dUrcwG
   AFzdSO3/s9XlzUjL+rDdC8tsp5I3E1Ba9zrzyy5EtiGvk912q5Lj82BVJ
   s4P1LEHMLSExckFDiR+IREwCUPAEcCVtCfFLL/FdvAby/CzOPV/DQi0mI
   JCx2V5NRmUdfr8uQr4tlkl3vMjb3Ac4TOMDWBlcjKwd2AIIOFDmAnj8wA
   uxU8Ti0sS220XJf493XJuID/p+v4vXW3QIuEnUPXyGj6lj8MXZjjGe84+
   VBf75c8qr83dPnED7DCF1oRyjnLpL16dReJAHzcrP13Py10YI4dgl9uO3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="383868034"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="383868034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="592750671"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2022 14:15:08 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWlL9-0001kF-1U;
        Fri, 09 Sep 2022 21:15:07 +0000
Date:   Sat, 10 Sep 2022 05:14:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 22/42]
 drivers/soc/sifive/sifive_l2_cache.c:285:17: error: implicit declaration of
 function 'riscv_noncoherent_supported'
Message-ID: <202209100507.S5XBgELa-lkp@intel.com>
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

tree:   https://github.com/esmil/linux visionfive
head:   044c1f5e968de7d30940431fbb90da599074ea1c
commit: 481ec6aefdf9cbaae1dd26f65aea0ace44b4a335 [22/42] soc: sifive: l2 cache: Add non-coherent DMA handling
config: riscv-randconfig-r002-20220907 (https://download.01.org/0day-ci/archive/20220910/202209100507.S5XBgELa-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/481ec6aefdf9cbaae1dd26f65aea0ace44b4a335
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 481ec6aefdf9cbaae1dd26f65aea0ace44b4a335
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c: In function 'sifive_l2_init':
>> drivers/soc/sifive/sifive_l2_cache.c:285:17: error: implicit declaration of function 'riscv_noncoherent_supported' [-Werror=implicit-function-declaration]
     285 |                 riscv_noncoherent_supported();
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/riscv_noncoherent_supported +285 drivers/soc/sifive/sifive_l2_cache.c

   240	
   241	static int __init sifive_l2_init(void)
   242	{
   243		struct device_node *np;
   244		struct resource res;
   245		int i, rc, intr_num;
   246		const struct of_device_id *match;
   247		unsigned long broken_irqs;
   248		u64 offset;
   249	
   250		np = of_find_matching_node_and_match(NULL, sifive_l2_ids, &match);
   251		if (!np)
   252			return -ENODEV;
   253	
   254		broken_irqs = (uintptr_t)match->data;
   255	
   256		if (of_address_to_resource(np, 0, &res))
   257			return -ENODEV;
   258	
   259		l2_base = ioremap(res.start, resource_size(&res));
   260		if (!l2_base)
   261			return -ENOMEM;
   262	
   263		intr_num = of_property_count_u32_elems(np, "interrupts");
   264		if (!intr_num) {
   265			pr_err("L2CACHE: no interrupts property\n");
   266			return -ENODEV;
   267		}
   268	
   269		for (i = 0; i < intr_num; i++) {
   270			g_irq[i] = irq_of_parse_and_map(np, i);
   271	
   272			if (broken_irqs & BIT(i))
   273				continue;
   274	
   275			rc = request_irq(g_irq[i], l2_int_handler, 0, "l2_ecc", NULL);
   276			if (rc) {
   277				pr_err("L2CACHE: Could not request IRQ %d\n", g_irq[i]);
   278				return rc;
   279			}
   280		}
   281	
   282		if (!of_property_read_u64(np, "uncached-offset", &offset)) {
   283			uncached_offset = offset;
   284			static_branch_enable(&sifive_l2_handle_noncoherent_key);
 > 285			riscv_noncoherent_supported();
   286		}
   287	
   288		l2_config_read();
   289	
   290		l2_cache_ops.get_priv_group = l2_get_priv_group;
   291		riscv_set_cacheinfo_ops(&l2_cache_ops);
   292	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
