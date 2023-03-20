Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA76C21DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCTTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCTTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:46:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043D65A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679341439; x=1710877439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XDIEyv4KoHJwPvYFwsfiFgSXNWZ1EVH9C1BhcDF7Vq0=;
  b=BsM64AdLIIwJkXhS/1aPVvnxXyBS3w/n7I+pFKrxVKW6jXdkgajSWoB/
   psGZxN3qkOPSGQA5rp/hrmv0J/jyuODGjExjRvRBGZlMUTA/yxre5Wtsp
   8j9QeA691wqhIm+a6p7+nw1g510Pt+GwY3mClDpR26EBx6iH9TbMcSmqb
   C2Mr53lWPuiyso3HAsn+ANKiamUCsbgffw+B/tWt2C7KAcy+/V5VmBSd3
   9os8YmsuAmO0k920jaxvymEt/BUuQ/ABe80r3wcsnqT61Vfv1+lXNXW5Q
   lH6y9xoZ3eCxvGQx1aPuGyNIVZYpN4eNBi9kJba8hsLbjXxCE2CBS9ll9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="319160995"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="319160995"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 12:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="1010617554"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="1010617554"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2023 12:43:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peLQB-000BGu-0N;
        Mon, 20 Mar 2023 19:43:55 +0000
Date:   Tue, 21 Mar 2023 03:42:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, Shenghao Ding <13916275206@139.com>
Subject: Re: [PATCH v4] ASoC: tas2781: Add tas2781 driver
Message-ID: <202303210304.0taquh1z-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230321/202303210304.0taquh1z-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9620831afc4c833413c073a5b991d0f9be570754
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230320-231125
        git checkout 9620831afc4c833413c073a5b991d0f9be570754
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210304.0taquh1z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/codecs/tas2781-i2c.c: In function 'tasdevice_tuning_switch':
   sound/soc/codecs/tas2781-i2c.c:1007:13: warning: variable 'is_set_glb_mode' set but not used [-Wunused-but-set-variable]
    1007 |         int is_set_glb_mode = 0;
         |             ^~~~~~~~~~~~~~~
   At top level:
>> sound/soc/codecs/tas2781-i2c.c:42:27: warning: 'dts_dev_addr_tag' defined but not used [-Wunused-const-variable=]
      42 | static const char * const dts_dev_addr_tag[] = {
         |                           ^~~~~~~~~~~~~~~~


vim +/dts_dev_addr_tag +42 sound/soc/codecs/tas2781-i2c.c

    41	
  > 42	static const char * const dts_dev_addr_tag[] = {
    43		"topleft-channel",
    44		"topright-channel",
    45		"bottomleft-channel",
    46		"bottomright-channel"
    47	};
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
