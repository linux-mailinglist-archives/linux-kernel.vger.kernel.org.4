Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A786BFF33
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 04:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCSDJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 23:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCSDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 23:09:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C4166E0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 20:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679195342; x=1710731342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HNjvJl06yhlFaoNEfHQUZd+1diw2aZquboGeYkpulTY=;
  b=FwlGpWlKWNBF0yF/jlg4kxvlyEdJVjqKchm4dwfX0avYrPskmCxW+/3h
   vGPPifSiNI0/0H7XGK6Qt2SuwbEK3YAAaDRO6VHZCDak2qAcQBkXNIOLx
   7KIDiRVGHlRC+XR9y0sin2lLg6i/B3Y95GDAtvSYHaiKQsSbhILGoGtD7
   emOIsBJHY0v7U1y3Iaz9qQP3JFWx1p3TvDWr88zcvCpKo2XVb0//rlVwK
   LqOFkCeNK9HVQGQZ05qyvoQ2R3Em1PEiSUinKdnx7IO5Nt1JzXR7q6mOP
   TcBsudPGIr5ZeIdJEv4vu5V2ugTNFhsda301NsfxquUIYCFMw3Fmx/axf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="335973216"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="335973216"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 20:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="1010088182"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="1010088182"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2023 20:09:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdjPn-000AMk-0f;
        Sun, 19 Mar 2023 03:08:59 +0000
Date:   Sun, 19 Mar 2023 11:08:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: drivers/remoteproc/xlnx_r5_remoteproc.c:209:20: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202303191110.k1cqaaz4-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3671bd86a9770e34969522d29bb30a1b66fd88a
commit: 6b291e8020a8bd90e94ee13d61f251040425c90d drivers: remoteproc: Add Xilinx r5 remoteproc driver
date:   4 months ago
config: arm64-randconfig-s052-20230319 (https://download.01.org/0day-ci/archive/20230319/202303191110.k1cqaaz4-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bluetooth/ drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303191110.k1cqaaz4-lkp@intel.com/

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
