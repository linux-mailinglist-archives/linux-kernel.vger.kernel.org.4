Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B35B42F8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIIXQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIIXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:16:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA790D291E;
        Fri,  9 Sep 2022 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662765378; x=1694301378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0uN71c00HFkAIz5Dwqa2+eWE5a4KA5z0eUIK9Imqs3Q=;
  b=bbA63zMc2cW+rs1BO1hu8T6H+1+4UHQae/ygBAbXNPQJGhM9KikFdcwK
   ufXNr1V810ZmYNNywrhNhqTIS27HWZrbYSeH2FmmMspxHQsSxg+pqnN+m
   /skFQLyTpjPFywbXNVxXxjWF9IElN1U4oleSbADzTYVThYk41T1anFIUC
   +IpuwDWQHoA/SUJrb6d1AK0dA82rmj9V9plHP3eSTJSTBjYk60B9pzZnZ
   uVgImqrfG074YRVoLqug6yN+WJbNiCL5JVbMXd5CUIV8LZsu5y81wH0VG
   OzRIwi38jM3tlo573ASOiX84+rcyzmU/Ih0+Ep+avLpSSAH8pLHgFi5TM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="277980625"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="277980625"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="648613954"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Sep 2022 16:16:13 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWnEL-0001qf-0Y;
        Fri, 09 Sep 2022 23:16:13 +0000
Date:   Sat, 10 Sep 2022 07:15:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     luca.ceresoli@bootlin.com, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add RK3308 internal audio codec driver
Message-ID: <202209100733.bM1xaUdC-lkp@intel.com>
References: <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on rockchip/for-next tiwai-sound/for-next linus/master v6.0-rc4 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/luca-ceresoli-bootlin-com/Add-support-for-the-internal-RK3308-audio-codec/20220907-222555
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: hexagon-randconfig-r033-20220907 (https://download.01.org/0day-ci/archive/20220910/202209100733.bM1xaUdC-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/786c160ad64ae5a6c5266184b12ecf2674db2fbe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review luca-ceresoli-bootlin-com/Add-support-for-the-internal-RK3308-audio-codec/20220907-222555
        git checkout 786c160ad64ae5a6c5266184b12ecf2674db2fbe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   sound/soc/codecs/rk3308_codec.c:2007:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
           int err;
               ^
>> sound/soc/codecs/rk3308_codec.c:2104:34: warning: unused variable 'rk3308codec_of_match' [-Wunused-const-variable]
   static const struct of_device_id rk3308codec_of_match[] = {
                                    ^
   2 warnings generated.


vim +/rk3308codec_of_match +2104 sound/soc/codecs/rk3308_codec.c

  2103	
> 2104	static const struct of_device_id rk3308codec_of_match[] = {
  2105		{ .compatible = "rockchip,rk3308-codec", },
  2106		{},
  2107	};
  2108	MODULE_DEVICE_TABLE(of, rk3308codec_of_match);
  2109	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
