Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5677A6C22DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCTUgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjCTUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:36:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4476E1ADDE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679344565; x=1710880565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2WHkKbj/gorEAJvCbAOYCbTNV4/YP8lsrrEl2fs4ko=;
  b=He8MTf+m5cZiZPMb2vBZyo5o6sHZWXVqRRSHKZZ6/aadaADWibdk3eaB
   IwVPApr1pBzGygwtvjVL5+azu4n7plsf+A6LiB1VenkYfha00sL5LlgA6
   WDUUTPKJpfZgodMmbUInmtLj1HVjphJMDgivAXb754nlf+Aqbflp9Hown
   TNMLzqufZbVWxkHItv+ruCX23FovmmtipiHn20qXzTNqLoKMbKb3vi9ce
   Mw3zSQDFi3PSLjSwUdJjGEP7Se4GRuf7KSARP+6/YaHzKQgSgMRPEE4j3
   PmcYfQlYpR7z73t/pKSin527tOzzRnKYXOOduCl5bv2uFv/L5w/suyjtN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318424167"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="318424167"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 13:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="681223528"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="681223528"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2023 13:36:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peMEW-000BIc-0p;
        Mon, 20 Mar 2023 20:35:56 +0000
Date:   Tue, 21 Mar 2023 04:34:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, Shenghao Ding <13916275206@139.com>
Subject: Re: [PATCH v4] ASoC: tas2781: Add tas2781 driver
Message-ID: <202303210435.ij3d6YHB-lkp@intel.com>
References: <20230320150726.20573-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320150726.20573-1-13916275206@139.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230321/202303210435.ij3d6YHB-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9620831afc4c833413c073a5b991d0f9be570754
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230320-231125
        git checkout 9620831afc4c833413c073a5b991d0f9be570754
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210435.ij3d6YHB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/codecs/tas2781-i2c.c: In function 'tasdevice_tuning_switch':
>> sound/soc/codecs/tas2781-i2c.c:1007:13: warning: variable 'is_set_glb_mode' set but not used [-Wunused-but-set-variable]
    1007 |         int is_set_glb_mode = 0;
         |             ^~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-i2c.c: At top level:
   sound/soc/codecs/tas2781-i2c.c:42:27: warning: 'dts_dev_addr_tag' defined but not used [-Wunused-const-variable=]
      42 | static const char * const dts_dev_addr_tag[] = {
         |                           ^~~~~~~~~~~~~~~~


vim +/is_set_glb_mode +1007 sound/soc/codecs/tas2781-i2c.c

  1001	
  1002	static void tasdevice_tuning_switch(
  1003		struct tasdevice_priv *tas_dev, int state)
  1004	{
  1005		struct tasdevice_fw *tas_fmw = tas_dev->fmw;
  1006		int profile_cfg_id = 0;
> 1007		int is_set_glb_mode = 0;
  1008	
  1009		if (state == 0) {
  1010			if (tas_fmw) {
  1011				if (tas_dev->cur_prog >= tas_fmw->nr_programs)
  1012					/*bypass all in rca is profile id 0*/
  1013					profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
  1014				else {
  1015					/*dsp mode or tuning mode*/
  1016					profile_cfg_id =
  1017						tas_dev->rcabin.profile_cfg_id;
  1018	
  1019					is_set_glb_mode =
  1020						tasdevice_select_tuningprm_cfg(tas_dev,
  1021							tas_dev->cur_prog,
  1022							tas_dev->cur_conf,
  1023							profile_cfg_id);
  1024					if (tas_dev->set_global_mode != NULL)
  1025						tas_dev->set_global_mode(tas_dev);
  1026				}
  1027			}  else
  1028				profile_cfg_id = RCA_CONFIGID_BYPASS_ALL;
  1029	
  1030			tasdevice_select_cfg_blk(tas_dev, profile_cfg_id,
  1031				TASDEVICE_BIN_BLK_PRE_POWER_UP);
  1032		} else
  1033			tasdevice_select_cfg_blk(tas_dev,
  1034				tas_dev->rcabin.profile_cfg_id,
  1035				TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
  1036	}
  1037	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
