Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ADA6CED19
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjC2Pgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC2Pgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:36:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162B468B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680104178; x=1711640178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rr4FqyLD3ITMQvibvOjJcqHNYDt2AOjbEqrTuAlyghI=;
  b=jDRbPT7svfWJP1Ah4NfgAQ+NK3M85X/aRQmTWUj8eRFGVSoYi88wPgpA
   uOMCdox6HhxjSMA6qu1utMRLaCCER6Hiti00+SX2ZI2QXnh7ufmULM8IU
   LBogbBR0WwEfzI2D/oEznZmR29x5UpIoFY0OSP2w3inaDzEOiFCgCd6V/
   QVyanSVGyTdF6L7ZIjaHm6ARobwnCraYZ9b/tWLGJUa1OqqSEtL15otTz
   +2C5yj25VAmTkeNWvDXCx7YhVv2LDX4L8pUqpGb5kuLMUXe6mZnZiUMIg
   Tdm2bpZbUsNr7idly7AsX8y3F74XdcxuUKjtTH+ZRuAxzBteJNty7k8Rw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="340935232"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="340935232"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 08:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="684315956"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="684315956"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2023 08:30:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phXlK-000JfW-0V;
        Wed, 29 Mar 2023 15:30:58 +0000
Date:   Wed, 29 Mar 2023 23:30:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: drivers/remoteproc/xlnx_r5_remoteproc.c:209:20: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202303292303.uvUY24KO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fcd476ea6a888ef6e6627f4c21a2ea8cca3e9312
commit: 6b291e8020a8bd90e94ee13d61f251040425c90d drivers: remoteproc: Add Xilinx r5 remoteproc driver
date:   4 months ago
config: arm64-randconfig-s043-20230329 (https://download.01.org/0day-ci/archive/20230329/202303292303.uvUY24KO-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6b291e8020a8bd90e94ee13d61f251040425c90d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6b291e8020a8bd90e94ee13d61f251040425c90d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303292303.uvUY24KO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/xlnx_r5_remoteproc.c:209:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/remoteproc/xlnx_r5_remoteproc.c:315:20: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +209 drivers/remoteproc/xlnx_r5_remoteproc.c

   190	
   191	/*
   192	 * zynqmp_r5_mem_region_map()
   193	 * @rproc: single R5 core's corresponding rproc instance
   194	 * @mem: mem descriptor to map reserved memory-regions
   195	 *
   196	 * Callback to map va for memory-region's carveout.
   197	 *
   198	 * return 0 on success, otherwise non-zero value on failure
   199	 */
   200	static int zynqmp_r5_mem_region_map(struct rproc *rproc,
   201					    struct rproc_mem_entry *mem)
   202	{
   203		void __iomem *va;
   204	
   205		va = ioremap_wc(mem->dma, mem->len);
   206		if (IS_ERR_OR_NULL(va))
   207			return -ENOMEM;
   208	
 > 209		mem->va = (void *)va;
   210	
   211		return 0;
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
