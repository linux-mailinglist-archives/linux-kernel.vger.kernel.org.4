Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBA727FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjFHMWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjFHMWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:22:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF21E43;
        Thu,  8 Jun 2023 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686226931; x=1717762931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XCENFFGMz+AlPXP+TAjP/jMokRT6oH/Ogdvfh1yAGao=;
  b=WtyBqmEQeGYTNClnVxgnnD4jMvnjOyYwHjFT0hFjr5UdtFrqFv6jNCER
   GHmdcbxUKQRU3Ooi2Ko3JgMfPTY54GeaMale3r6XsRQ99e1Oe+tSYxgLs
   l48TR12VnoAI2U7ffWa3RrkRqLNLAQqBA3tFZcZkKI3B/KvyZ7Goo0kUz
   tHFqovSKE2qG8fnZM7UpiF1GEr1A4eAK3xoVIByJ0pz2sCZWrlCkmTG3O
   y4MY0ulptsFttvD/n6g95Yvd0WVf0VNWb4Fk3AmeDs1RVrWTQQwrwbClz
   x3h0iyyj1/F/xgqN/eQlMfDs6kgK4bL+SmL/PvqD4H7IIqpyyG4uod6Gc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="354777362"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="354777362"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 05:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="822601301"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="822601301"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2023 05:22:05 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7EeS-0007kh-2m;
        Thu, 08 Jun 2023 12:22:04 +0000
Date:   Thu, 8 Jun 2023 20:21:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, ryans.lee@analog.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, ajye_huang@compal.corp-partner.google.com,
        kiseok.jo@irondevice.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, venkataprasad.potturu@amd.com
Subject: Re: [PATCH 2/2] ASoC: max98388: add amplifier driver
Message-ID: <202306082054.jIU9oENf-lkp@intel.com>
References: <20230608054230.344014-2-ryan.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230608054230.344014-2-ryan.lee.analog@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi “Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.4-rc5 next-20230608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan/ASoC-max98388-add-amplifier-driver/20230608-134526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230608054230.344014-2-ryan.lee.analog%40gmail.com
patch subject: [PATCH 2/2] ASoC: max98388: add amplifier driver
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230608/202306082054.jIU9oENf-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add broonie-sound https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
        git fetch broonie-sound for-next
        git checkout broonie-sound/for-next
        b4 shazam https://lore.kernel.org/r/20230608054230.344014-2-ryan.lee.analog@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash sound/soc/codecs/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082054.jIU9oENf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/max98388.c:390:6: warning: no previous prototype for 'max98388_reset' [-Wmissing-prototypes]
     390 | void max98388_reset(struct max98388_priv *max98388, struct device *dev)
         |      ^~~~~~~~~~~~~~
>> sound/soc/codecs/max98388.c:904:6: warning: no previous prototype for 'max98388_read_deveice_property' [-Wmissing-prototypes]
     904 | void max98388_read_deveice_property(struct device *dev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/max98388_reset +390 sound/soc/codecs/max98388.c

   389	
 > 390	void max98388_reset(struct max98388_priv *max98388, struct device *dev)
   391	{
   392		int ret, reg, count;
   393	
   394		/* Software Reset */
   395		ret = regmap_update_bits(max98388->regmap,
   396					 MAX98388_R2000_SW_RESET,
   397					 MAX98388_SOFT_RESET,
   398					 MAX98388_SOFT_RESET);
   399		if (ret)
   400			dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
   401	
   402		count = 0;
   403		while (count < 3) {
   404			usleep_range(10000, 11000);
   405			/* Software Reset Verification */
   406			ret = regmap_read(max98388->regmap,
   407					  MAX98388_R22FF_REV_ID, &reg);
   408			if (!ret) {
   409				dev_info(dev, "Reset completed (retry:%d)\n", count);
   410				return;
   411			}
   412			count++;
   413		}
   414		dev_err(dev, "Reset failed. (ret:%d)\n", ret);
   415	}
   416	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
