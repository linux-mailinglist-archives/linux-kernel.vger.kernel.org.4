Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BCC5BB04B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiIPPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIPPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:36:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0054AE9C6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663342570; x=1694878570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s84ZWxHwXBbBkTccYSwA2ThWyol/8ypRFgq2rYwldGI=;
  b=DbrTKjeuWrbZrmqMP2Xca0sf+/6tYBrQkQbSVdIbqSTE86+GUTPtfTTG
   jL0QLjgc/hU0mtBBiU/fK68/H40rRzlBXSP4Src7sIATAzyORF0u10Lqn
   CHPmltLnobkqk1c45vWeIWFQiWlTjhawFif3X45kD8UT7ErSj2oYxPIsA
   1o7j85ab2ORThTwkoLbWkgkClNPxTO8nqTXAx1mTHu2tqz/Y/yP5f0HXn
   3Vz9X1O/TjeK7njgtARTxT/QQ8NOrANc+VP3PdjvwyNb7HMyPtACHyheS
   MS3qzmK0KgCntmuKOU5ZRI+NDfoRD7gyCYHFalB39tB5rtLYuL6bKu3iZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="282043093"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="282043093"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="946414679"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Sep 2022 08:36:06 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZDNt-0001tQ-2O;
        Fri, 16 Sep 2022 15:36:05 +0000
Date:   Fri, 16 Sep 2022 23:35:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202209162319.P5QRKUyM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
date:   7 months ago
config: arm64-randconfig-s042-20220916 (https://download.01.org/0day-ci/archive/20220916/202209162319.P5QRKUyM-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
>> drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void const *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *cpu_addr @@
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void *
   drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr

vim +437 drivers/remoteproc/ti_k3_r5_remoteproc.c

6dedbd1d544389 Suman Anna 2020-10-02  378  
6dedbd1d544389 Suman Anna 2020-10-02  379  /*
6dedbd1d544389 Suman Anna 2020-10-02  380   * The R5F cores have controls for both a reset and a halt/run. The code
6dedbd1d544389 Suman Anna 2020-10-02  381   * execution from DDR requires the initial boot-strapping code to be run
6dedbd1d544389 Suman Anna 2020-10-02  382   * from the internal TCMs. This function is used to release the resets on
6dedbd1d544389 Suman Anna 2020-10-02  383   * applicable cores to allow loading into the TCMs. The .prepare() ops is
6dedbd1d544389 Suman Anna 2020-10-02  384   * invoked by remoteproc core before any firmware loading, and is followed
6dedbd1d544389 Suman Anna 2020-10-02  385   * by the .start() ops after loading to actually let the R5 cores run.
ee99ee7c929c3e Suman Anna 2021-03-27  386   *
ee99ee7c929c3e Suman Anna 2021-03-27  387   * The Single-CPU mode on applicable SoCs (eg: AM64x) only uses Core0 to
ee99ee7c929c3e Suman Anna 2021-03-27  388   * execute code, but combines the TCMs from both cores. The resets for both
ee99ee7c929c3e Suman Anna 2021-03-27  389   * cores need to be released to make this possible, as the TCMs are in general
ee99ee7c929c3e Suman Anna 2021-03-27  390   * private to each core. Only Core0 needs to be unhalted for running the
ee99ee7c929c3e Suman Anna 2021-03-27  391   * cluster in this mode. The function uses the same reset logic as LockStep
ee99ee7c929c3e Suman Anna 2021-03-27  392   * mode for this (though the behavior is agnostic of the reset release order).
6dedbd1d544389 Suman Anna 2020-10-02  393   */
6dedbd1d544389 Suman Anna 2020-10-02  394  static int k3_r5_rproc_prepare(struct rproc *rproc)
6dedbd1d544389 Suman Anna 2020-10-02  395  {
6dedbd1d544389 Suman Anna 2020-10-02  396  	struct k3_r5_rproc *kproc = rproc->priv;
6dedbd1d544389 Suman Anna 2020-10-02  397  	struct k3_r5_cluster *cluster = kproc->cluster;
6dedbd1d544389 Suman Anna 2020-10-02  398  	struct k3_r5_core *core = kproc->core;
6dedbd1d544389 Suman Anna 2020-10-02  399  	struct device *dev = kproc->dev;
7508ea19b20da8 Suman Anna 2020-11-18  400  	u32 ctrl = 0, cfg = 0, stat = 0;
7508ea19b20da8 Suman Anna 2020-11-18  401  	u64 boot_vec = 0;
7508ea19b20da8 Suman Anna 2020-11-18  402  	bool mem_init_dis;
6dedbd1d544389 Suman Anna 2020-10-02  403  	int ret;
6dedbd1d544389 Suman Anna 2020-10-02  404  
7508ea19b20da8 Suman Anna 2020-11-18  405  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl, &stat);
7508ea19b20da8 Suman Anna 2020-11-18  406  	if (ret < 0)
7508ea19b20da8 Suman Anna 2020-11-18  407  		return ret;
7508ea19b20da8 Suman Anna 2020-11-18  408  	mem_init_dis = !!(cfg & PROC_BOOT_CFG_FLAG_R5_MEM_INIT_DIS);
7508ea19b20da8 Suman Anna 2020-11-18  409  
ee99ee7c929c3e Suman Anna 2021-03-27  410  	/* Re-use LockStep-mode reset logic for Single-CPU mode */
ee99ee7c929c3e Suman Anna 2021-03-27  411  	ret = (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
ee99ee7c929c3e Suman Anna 2021-03-27  412  	       cluster->mode == CLUSTER_MODE_SINGLECPU) ?
6dedbd1d544389 Suman Anna 2020-10-02  413  		k3_r5_lockstep_release(cluster) : k3_r5_split_release(core);
34f2653686fecc Suman Anna 2020-10-02  414  	if (ret) {
6dedbd1d544389 Suman Anna 2020-10-02  415  		dev_err(dev, "unable to enable cores for TCM loading, ret = %d\n",
6dedbd1d544389 Suman Anna 2020-10-02  416  			ret);
6dedbd1d544389 Suman Anna 2020-10-02  417  		return ret;
6dedbd1d544389 Suman Anna 2020-10-02  418  	}
6dedbd1d544389 Suman Anna 2020-10-02  419  
7508ea19b20da8 Suman Anna 2020-11-18  420  	/*
7508ea19b20da8 Suman Anna 2020-11-18  421  	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
7508ea19b20da8 Suman Anna 2020-11-18  422  	 * of TCMs, so there is no need to perform the s/w memzero. This bit is
7508ea19b20da8 Suman Anna 2020-11-18  423  	 * configurable through System Firmware, the default value does perform
7508ea19b20da8 Suman Anna 2020-11-18  424  	 * auto-init, but account for it in case it is disabled
7508ea19b20da8 Suman Anna 2020-11-18  425  	 */
7508ea19b20da8 Suman Anna 2020-11-18  426  	if (cluster->soc_data->tcm_ecc_autoinit && !mem_init_dis) {
7508ea19b20da8 Suman Anna 2020-11-18  427  		dev_dbg(dev, "leveraging h/w init for TCM memories\n");
7508ea19b20da8 Suman Anna 2020-11-18  428  		return 0;
7508ea19b20da8 Suman Anna 2020-11-18  429  	}
7508ea19b20da8 Suman Anna 2020-11-18  430  
34f2653686fecc Suman Anna 2020-10-02  431  	/*
34f2653686fecc Suman Anna 2020-10-02  432  	 * Zero out both TCMs unconditionally (access from v8 Arm core is not
34f2653686fecc Suman Anna 2020-10-02  433  	 * affected by ATCM & BTCM enable configuration values) so that ECC
34f2653686fecc Suman Anna 2020-10-02  434  	 * can be effective on all TCM addresses.
34f2653686fecc Suman Anna 2020-10-02  435  	 */
34f2653686fecc Suman Anna 2020-10-02  436  	dev_dbg(dev, "zeroing out ATCM memory\n");
34f2653686fecc Suman Anna 2020-10-02 @437  	memset(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
34f2653686fecc Suman Anna 2020-10-02  438  
34f2653686fecc Suman Anna 2020-10-02  439  	dev_dbg(dev, "zeroing out BTCM memory\n");
34f2653686fecc Suman Anna 2020-10-02  440  	memset(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
34f2653686fecc Suman Anna 2020-10-02  441  
34f2653686fecc Suman Anna 2020-10-02  442  	return 0;
34f2653686fecc Suman Anna 2020-10-02  443  }
34f2653686fecc Suman Anna 2020-10-02  444  

:::::: The code at line 437 was first introduced by commit
:::::: 34f2653686fecc9bd5a4ee16724768c72953fb57 remoteproc: k3-r5: Initialize TCM memories for ECC

:::::: TO: Suman Anna <s-anna@ti.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
