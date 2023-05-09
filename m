Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4682F6FC416
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjEIKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjEIKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:39:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC310F5;
        Tue,  9 May 2023 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683628754; x=1715164754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X/VcwT3gh20/W0MqnD+XABS3TW1iESZBIie/mj3ztgA=;
  b=lr++nF2wawlMJDrO0PpY6A8wTT5+zUfseKNu0uIKGkv9pVgCfzZCooaL
   E81bYHsuV1PpqHZdGyDF5+qdoMO/BV0K39zebsqWboLmJloQ4hH/CKdpJ
   up2DXXVxo6zRNW+HQIrPlNZNHcNxmeX/eHI+voZdDHKIOHBzPPIZ7T9BW
   /OQ3ExqNzGoMrF3R1J5BNqtLI2PjeHkc58T1oMO4uPIkU9+bo4f1rPt3/
   CP7nk8ER58JZn7pr5JKqs4JjXvGq2y8zqX892NvQfaAs6hydMdkwGdNLw
   2Z6GgEgWAe7kSVBM297lIzalk0rWBWxz9LF1+pfIAIzoUMVQJ+e481rvX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="348724196"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="348724196"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 03:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="810624736"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="810624736"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2023 03:39:03 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwKkI-00025b-1O;
        Tue, 09 May 2023 10:39:02 +0000
Date:   Tue, 9 May 2023 18:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com
Cc:     oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
        talho@nvidia.com, robh@kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com
Subject: Re: [PATCH 5/5] firmware: tegra: bpmp: Add support for DRAM MRQ GSCs
Message-ID: <202305091826.DCKDo0L8-lkp@intel.com>
References: <20230508122048.99953-6-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508122048.99953-6-pdeschrijver@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on robh/for-next linus/master v6.4-rc1 next-20230509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-De-Schrijver/dt-bindings-mailbox-tegra-Document-Tegra264-HSP/20230508-203107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20230508122048.99953-6-pdeschrijver%40nvidia.com
patch subject: [PATCH 5/5] firmware: tegra: bpmp: Add support for DRAM MRQ GSCs
config: arm64-randconfig-s032-20230507 (https://download.01.org/0day-ci/archive/20230509/202305091826.DCKDo0L8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/37f37c8af4622908dd3a8ca43d23c4e2310bdc20
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-De-Schrijver/dt-bindings-mailbox-tegra-Document-Tegra264-HSP/20230508-203107
        git checkout 37f37c8af4622908dd3a8ca43d23c4e2310bdc20
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/firmware/tegra/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091826.DCKDo0L8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/tegra/bpmp-tegra186.c:190:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *virt @@
   drivers/firmware/tegra/bpmp-tegra186.c:190:34: sparse:     expected void *addr
   drivers/firmware/tegra/bpmp-tegra186.c:190:34: sparse:     got void [noderef] __iomem *virt
>> drivers/firmware/tegra/bpmp-tegra186.c:248:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void * @@
   drivers/firmware/tegra/bpmp-tegra186.c:248:23: sparse:     expected void [noderef] __iomem *virt
   drivers/firmware/tegra/bpmp-tegra186.c:248:23: sparse:     got void *
   drivers/firmware/tegra/bpmp-tegra186.c:261:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void * @@
   drivers/firmware/tegra/bpmp-tegra186.c:261:23: sparse:     expected void [noderef] __iomem *virt
   drivers/firmware/tegra/bpmp-tegra186.c:261:23: sparse:     got void *
   drivers/firmware/tegra/bpmp-tegra186.c:303:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void * @@
   drivers/firmware/tegra/bpmp-tegra186.c:303:23: sparse:     expected void [noderef] __iomem *virt
   drivers/firmware/tegra/bpmp-tegra186.c:303:23: sparse:     got void *

vim +190 drivers/firmware/tegra/bpmp-tegra186.c

   170	
   171	static void tegra186_bpmp_channel_deinit(struct tegra_bpmp *bpmp)
   172	{
   173		int i;
   174		struct tegra186_bpmp *priv = bpmp->priv;
   175	
   176		for (i = 0; i < bpmp->threaded.count; i++) {
   177			if (!bpmp->threaded_channels[i].bpmp)
   178				continue;
   179	
   180			tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
   181		}
   182	
   183		tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
   184		tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
   185	
   186		if (priv->type == TEGRA_SRAM) {
   187			gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
   188			gen_pool_free(priv->sram.rx, (unsigned long)priv->rx.virt, 4096);
   189		} else if (priv->type == TEGRA_RMEM) {
 > 190			memunmap(priv->tx.virt);
   191		}
   192	}
   193	
   194	static int tegra186_bpmp_channel_setup(struct tegra_bpmp *bpmp)
   195	{
   196		unsigned int i;
   197		int err;
   198	
   199		err = tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
   200						 bpmp->soc->channels.cpu_tx.offset);
   201		if (err < 0)
   202			return err;
   203	
   204		err = tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
   205						 bpmp->soc->channels.cpu_rx.offset);
   206		if (err < 0) {
   207			tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
   208			return err;
   209		}
   210	
   211		for (i = 0; i < bpmp->threaded.count; i++) {
   212			unsigned int index = bpmp->soc->channels.thread.offset + i;
   213	
   214			err = tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
   215							 bpmp, index);
   216			if (err < 0)
   217				break;
   218		}
   219	
   220		if (err < 0)
   221			tegra186_bpmp_channel_deinit(bpmp);
   222	
   223		return err;
   224	}
   225	
   226	static void tegra186_bpmp_reset_channels(struct tegra_bpmp *bpmp)
   227	{
   228		unsigned int i;
   229	
   230		tegra186_bpmp_channel_reset(bpmp->tx_channel);
   231		tegra186_bpmp_channel_reset(bpmp->rx_channel);
   232	
   233		for (i = 0; i < bpmp->threaded.count; i++)
   234			tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
   235	}
   236	
   237	static int tegra186_bpmp_sram_init(struct tegra_bpmp *bpmp)
   238	{
   239		int err;
   240		struct tegra186_bpmp *priv = bpmp->priv;
   241	
   242		priv->sram.tx = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
   243		if (!priv->sram.tx) {
   244			dev_err(bpmp->dev, "TX shmem pool not found\n");
   245			return -EPROBE_DEFER;
   246		}
   247	
 > 248		priv->tx.virt = gen_pool_dma_alloc(priv->sram.tx, 4096, &priv->tx.phys);
   249		if (!priv->tx.virt) {
   250			dev_err(bpmp->dev, "failed to allocate from TX pool\n");
   251			return -ENOMEM;
   252		}
   253	
   254		priv->sram.rx = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
   255		if (!priv->sram.rx) {
   256			dev_err(bpmp->dev, "RX shmem pool not found\n");
   257			err = -EPROBE_DEFER;
   258			goto free_tx;
   259		}
   260	
   261		priv->rx.virt = gen_pool_dma_alloc(priv->sram.rx, 4096, &priv->rx.phys);
   262		if (!priv->rx.virt) {
   263			dev_err(bpmp->dev, "failed to allocate from RX pool\n");
   264			err = -ENOMEM;
   265			goto free_tx;
   266		}
   267	
   268		priv->type = TEGRA_SRAM;
   269	
   270		return 0;
   271	
   272	free_tx:
   273		gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
   274	
   275		return err;
   276	}
   277	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
