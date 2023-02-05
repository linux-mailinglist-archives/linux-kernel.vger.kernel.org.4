Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4468AD83
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjBDXtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDXtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:49:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321B2310E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675554542; x=1707090542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fomCakFZr6XEh5AD/gqLP1smjawOXfxdfBV5VtnaH+0=;
  b=dzek5ze6JX6c6TF/YK+HtH4Yu22fPqg3er8MKQ36qYvvr6H8/ihVs1f8
   AukCqR7vfhrDNuPEXuHKb/1HSUwAyvzAQg4n3mPt9nfu2JMWLEhGvGBGf
   2dgWoI7ntetgyqezgYjOEQRVXIeE4KVrEH0BB1D/p6DKLQflmVsYcPC10
   PHsydFJMheoAXfYE1UT29RkZjhJcMak5xdMKivGdwNhJrt5D9jIiNZKcF
   j+mN5pmHkwk7NU3ugg/P7UdsCwx/vavbzQvZhaYBaGPsMKF9PUEjKe4vp
   moeurhnXA7Zw98MuDQNF9MsyBc1OdYNJc8veZTI5sCvueptG2NC7F31v4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="415218464"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="415218464"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 15:49:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="911541082"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="911541082"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Feb 2023 15:49:00 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOSHD-0001a4-28;
        Sat, 04 Feb 2023 23:48:59 +0000
Date:   Sun, 5 Feb 2023 07:48:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/remoteproc/ti_k3_r5_remoteproc.c:711:17: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202302050722.HpR9D03W-lkp@intel.com>
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
head:   95078069c1e70d1b3b141132d18d0c563acedd0c
commit: 1168af40b1ad8cb2e78f4a70869fa4a076320e4f remoteproc: k3-r5: Add support for IPC-only mode for all R5Fs
date:   11 months ago
config: arm64-randconfig-s053-20230205 (https://download.01.org/0day-ci/archive/20230205/202302050722.HpR9D03W-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpio/ drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

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
