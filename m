Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAF36C2333
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCTU4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCTU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:56:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E62D5D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679345761; x=1710881761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+aMOxJG6JL4EyQlRR5RG4zAKSSqYOvx8XJx7RuQoUkU=;
  b=Gl9spb2Tmc4T7wJvZIiw1K0rDKAOyQyy7CpbzVTy8s9GKXWxOJiiZVqP
   ESSdoWmdpFkYRHd2Pl5hLx5nYDN60yghqMRi7wJNtoU7Sd89qthqszDZH
   JZDtCkZ7ou8eYwNcKe6DVpzKUWLO8f3pgieQfo5EYRYPY4ljma2QjAEZ6
   ZTdocV7XyvQmxVLXCILq2c4GbuuEUS69chlUrmXYVYo8MLPSlEuohOgnm
   L4XrpcM9RlHx3p6N0ae6LLkfOtz4UvKL4Et7I2BSJezOASa/dLAMJ5yHj
   hK7TNHmC9C1/y5hhnqh62eTpXpS3S/A2ncaBd9orwI5uIrRQdEjq/LYSt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="401349428"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="401349428"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="681228572"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="681228572"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2023 13:55:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peMXs-000BJO-27;
        Mon, 20 Mar 2023 20:55:56 +0000
Date:   Tue, 21 Mar 2023 04:55:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, Shenghao Ding <13916275206@139.com>
Subject: Re: [PATCH v4] ASoC: tas2781: Add tas2781 driver
Message-ID: <202303210419.sTqbh3R4-lkp@intel.com>
References: <20230320150726.20573-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320150726.20573-1-13916275206@139.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230320-231125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230320150726.20573-1-13916275206%40139.com
patch subject: [PATCH v4] ASoC: tas2781: Add tas2781 driver
config: riscv-randconfig-s052-20230319 (https://download.01.org/0day-ci/archive/20230321/202303210419.sTqbh3R4-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9620831afc4c833413c073a5b991d0f9be570754
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230320-231125
        git checkout 9620831afc4c833413c073a5b991d0f9be570754
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210419.sTqbh3R4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> sound/soc/codecs/tas2781-i2c.c:388:55: sparse: sparse: Using plain integer as NULL pointer

vim +388 sound/soc/codecs/tas2781-i2c.c

   298	
   299	static struct tasdevice_config_info *tasdevice_add_config(
   300		void *context, unsigned char *config_data,
   301		unsigned int config_size)
   302	{
   303		struct tasdevice_priv *tas_dev =
   304			(struct tasdevice_priv *)context;
   305		struct tasdevice_config_info *cfg_info = NULL;
   306		int config_offset = 0, i = 0;
   307	
   308		cfg_info = kzalloc(
   309				sizeof(struct tasdevice_config_info), GFP_KERNEL);
   310		if (!cfg_info)
   311			goto out;
   312	
   313		if (tas_dev->rcabin.fw_hdr.binary_version_num >= 0x105) {
   314			if (config_offset + 64 > (int)config_size) {
   315				dev_err(tas_dev->dev,
   316					"add config: Out of bounary\n");
   317				goto out;
   318			}
   319			config_offset  += 64;
   320		}
   321	
   322		if (config_offset + 4 > (int)config_size) {
   323			dev_err(tas_dev->dev,
   324				"add config: Out of bounary\n");
   325			goto out;
   326		}
   327		cfg_info->nblocks =
   328			SMS_HTONL(config_data[config_offset],
   329			config_data[config_offset + 1],
   330		config_data[config_offset + 2], config_data[config_offset + 3]);
   331		config_offset  +=  4;
   332	
   333		cfg_info->blk_data = kcalloc(
   334			cfg_info->nblocks, sizeof(struct tasdev_blk_data *),
   335			GFP_KERNEL);
   336		if (!cfg_info->blk_data)
   337			goto out;
   338	
   339		cfg_info->real_nblocks = 0;
   340		for (i = 0; i < (int)cfg_info->nblocks; i++) {
   341			if (config_offset + 12 > config_size) {
   342				dev_err(tas_dev->dev,
   343				"add config: Out of bounary: i = %d nblocks = %u!\n",
   344				i, cfg_info->nblocks);
   345				break;
   346			}
   347			cfg_info->blk_data[i] = kzalloc(
   348				sizeof(struct tasdev_blk_data), GFP_KERNEL);
   349			if (!cfg_info->blk_data[i])
   350				break;
   351	
   352			cfg_info->blk_data[i]->dev_idx = config_data[config_offset];
   353			config_offset++;
   354	
   355			cfg_info->blk_data[i]->block_type = config_data[config_offset];
   356			config_offset++;
   357	
   358			if (cfg_info->blk_data[i]->block_type  ==
   359				TASDEVICE_BIN_BLK_PRE_POWER_UP) {
   360				if (cfg_info->blk_data[i]->dev_idx == 0) {
   361					cfg_info->active_dev = 1;
   362				} else {
   363					cfg_info->active_dev =
   364						1 <<
   365						(cfg_info->blk_data[i]->dev_idx - 1);
   366				}
   367			}
   368			cfg_info->blk_data[i]->yram_checksum =
   369				SMS_HTONS(config_data[config_offset],
   370				config_data[config_offset + 1]);
   371			config_offset  += 2;
   372			cfg_info->blk_data[i]->block_size =
   373				SMS_HTONL(config_data[config_offset],
   374				config_data[config_offset + 1],
   375				config_data[config_offset + 2],
   376			config_data[config_offset + 3]);
   377			config_offset  += 4;
   378	
   379			cfg_info->blk_data[i]->n_subblks =
   380				SMS_HTONL(config_data[config_offset],
   381				config_data[config_offset + 1],
   382				config_data[config_offset + 2],
   383			config_data[config_offset + 3]);
   384	
   385			config_offset  += 4;
   386			cfg_info->blk_data[i]->regdata = kzalloc(
   387				cfg_info->blk_data[i]->block_size, GFP_KERNEL);
 > 388			if (cfg_info->blk_data[i]->regdata == 0)
   389				goto out;
   390	
   391			if (config_offset + cfg_info->blk_data[i]->block_size
   392				> config_size) {
   393				dev_err(tas_dev->dev,
   394				"%s: block_size Out of bounary: i = %d blks = %u!\n",
   395				__func__, i, cfg_info->nblocks);
   396				break;
   397			}
   398			memcpy(cfg_info->blk_data[i]->regdata,
   399				&config_data[config_offset],
   400			cfg_info->blk_data[i]->block_size);
   401			config_offset  += cfg_info->blk_data[i]->block_size;
   402			cfg_info->real_nblocks  += 1;
   403		}
   404	out:
   405		return cfg_info;
   406	}
   407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
