Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7206704387
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjEPCn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjEPCnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:43:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9793A9C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684205034; x=1715741034;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E5/Ev9mcLif2bk8yTWwDXAcyYvUypr3gctYf0LpNjhM=;
  b=SPW5olVjytks7wdBv2vaZpCq+ekepuzQl7nxCbnfBMeH6bSxaFxTR4iq
   VbWl3PmWTsQje+QVd+DeFABHTLVuUGFCJnZ4JQEKSeorlANNKZ/MTwn23
   uFydlRechrTd1d3wga3ibTL9yUl+Jn4ko5FfxbaRuRdLYNWLtBMD/4kzl
   lZiDAnqh0GrTIvswZuxQL5/GIva5h1Zg/CSvmvJu3dVw4gzWgcOiHW7Xz
   fEsvBBNN5p8BYbLRW4DDlh01hRjTfoKpT88WY80RTsi8LFtS/1DwcEGbS
   e/0Wrrl0FYkZUcalNPz1sGVBkIS66dHjjY3CDIBcSm5XIDSloj/wiHYwd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340729561"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="340729561"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 19:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="947665406"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="947665406"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 May 2023 19:43:50 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pykfF-0006ta-2d;
        Tue, 16 May 2023 02:43:49 +0000
Date:   Tue, 16 May 2023 10:43:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/remoteproc/ti_k3_r5_remoteproc.c:711:17: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202305161024.y2bduzKi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: 1168af40b1ad8cb2e78f4a70869fa4a076320e4f remoteproc: k3-r5: Add support for IPC-only mode for all R5Fs
date:   1 year, 2 months ago
config: arm64-randconfig-s031-20230515 (https://download.01.org/0day-ci/archive/20230516/202305161024.y2bduzKi-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1168af40b1ad8cb2e78f4a70869fa4a076320e4f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1168af40b1ad8cb2e78f4a70869fa4a076320e4f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305161024.y2bduzKi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/ti_k3_r5_remoteproc.c:476:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:476:28: sparse:     expected void *p
   drivers/remoteproc/ti_k3_r5_remoteproc.c:476:28: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:479:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:479:28: sparse:     expected void *p
   drivers/remoteproc/ti_k3_r5_remoteproc.c:479:28: sparse:     got void [noderef] __iomem *cpu_addr
>> drivers/remoteproc/ti_k3_r5_remoteproc.c:711:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +711 drivers/remoteproc/ti_k3_r5_remoteproc.c

   681	
   682	/*
   683	 * This function implements the .get_loaded_rsc_table() callback and is used
   684	 * to provide the resource table for the booted R5F in IPC-only mode. The K3 R5F
   685	 * firmwares follow a design-by-contract approach and are expected to have the
   686	 * resource table at the base of the DDR region reserved for firmware usage.
   687	 * This provides flexibility for the remote processor to be booted by different
   688	 * bootloaders that may or may not have the ability to publish the resource table
   689	 * address and size through a DT property. This callback is invoked only in
   690	 * IPC-only mode.
   691	 */
   692	static struct resource_table *k3_r5_get_loaded_rsc_table(struct rproc *rproc,
   693								 size_t *rsc_table_sz)
   694	{
   695		struct k3_r5_rproc *kproc = rproc->priv;
   696		struct device *dev = kproc->dev;
   697	
   698		if (!kproc->rmem[0].cpu_addr) {
   699			dev_err(dev, "memory-region #1 does not exist, loaded rsc table can't be found");
   700			return ERR_PTR(-ENOMEM);
   701		}
   702	
   703		/*
   704		 * NOTE: The resource table size is currently hard-coded to a maximum
   705		 * of 256 bytes. The most common resource table usage for K3 firmwares
   706		 * is to only have the vdev resource entry and an optional trace entry.
   707		 * The exact size could be computed based on resource table address, but
   708		 * the hard-coded value suffices to support the IPC-only mode.
   709		 */
   710		*rsc_table_sz = 256;
 > 711		return (struct resource_table *)kproc->rmem[0].cpu_addr;
   712	}
   713	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
