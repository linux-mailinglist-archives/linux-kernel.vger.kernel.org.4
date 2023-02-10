Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4042869175D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBJDxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjBJDxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:53:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353236F21D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676001200; x=1707537200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OjjWca3hBfMIKs2O7Em3173GsK0Aik9dyEOYfYQVkQs=;
  b=USbXr1rRwub1G9bRedTn4RMiVVVhWOJRWG+gf05iCXoJ61Zvb5fc/EB/
   mmqJyisv7v4JWIWGQLiak5fTv5x5f1grY5fa2wfm/xKiveW0QsKzvPjCW
   MZVNDR37uC3gPy8YADJoGNN4luucnyugnY5PxXkGH7uvuVkN19CLtknZ3
   2T90fue+tr55xyNn/SEXQrQqrKU/fM6JI8pAgkbv2CyWdOo/AL8hn4k+G
   ZV5VmL734/6Dv0e2XUHPH2w6IGUZFLVGZ+Ks0hzn8g3c/l0CK6rnsNEOD
   8PLWdgTluBz0ST1Gqdzp3njrPmo4mJt4PZQ41yKpBQ73znNCZh7U15b8F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310694176"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="310694176"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 19:53:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913391268"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="913391268"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2023 19:53:18 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQKTN-0005WK-2X;
        Fri, 10 Feb 2023 03:53:17 +0000
Date:   Fri, 10 Feb 2023 11:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/soc/samsung/aries_wm8994.c:100:22: error: implicit declaration
 of function 'gpiod_get_value'; did you mean 'gpio_get_value'?
Message-ID: <202302101134.JyRppXYu-lkp@intel.com>
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

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   38c1e0c65865426676123cc9a127526fa02bcac6
commit: 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f ASoC: simple-amplifier: Remove spurious gpiolib select
date:   1 year ago
config: nios2-randconfig-r026-20230210 (https://download.01.org/0day-ci/archive/20230210/202302101134.JyRppXYu-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash sound/soc/samsung/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302101134.JyRppXYu-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/samsung/aries_wm8994.c: In function 'headset_det_irq_thread':
>> sound/soc/samsung/aries_wm8994.c:100:22: error: implicit declaration of function 'gpiod_get_value'; did you mean 'gpio_get_value'? [-Werror=implicit-function-declaration]
     100 |                 if (!gpiod_get_value(priv->gpio_headset_detect)) {
         |                      ^~~~~~~~~~~~~~~
         |                      gpio_get_value
>> sound/soc/samsung/aries_wm8994.c:103:25: error: implicit declaration of function 'gpiod_set_value'; did you mean 'gpio_set_value'? [-Werror=implicit-function-declaration]
     103 |                         gpiod_set_value(priv->gpio_earpath_sel, 0);
         |                         ^~~~~~~~~~~~~~~
         |                         gpio_set_value
   sound/soc/samsung/aries_wm8994.c: In function 'headset_button_check':
>> sound/soc/samsung/aries_wm8994.c:145:13: error: implicit declaration of function 'gpiod_get_value_cansleep'; did you mean 'gpio_get_value_cansleep'? [-Werror=implicit-function-declaration]
     145 |         if (gpiod_get_value_cansleep(priv->gpio_headset_key) &&
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
         |             gpio_get_value_cansleep
   sound/soc/samsung/aries_wm8994.c: In function 'aries_late_probe':
>> sound/soc/samsung/aries_wm8994.c:376:15: error: implicit declaration of function 'gpiod_to_irq'; did you mean 'gpio_to_irq'? [-Werror=implicit-function-declaration]
     376 |         irq = gpiod_to_irq(priv->gpio_headset_detect);
         |               ^~~~~~~~~~~~
         |               gpio_to_irq
   sound/soc/samsung/aries_wm8994.c: In function 'aries_audio_probe':
>> sound/soc/samsung/aries_wm8994.c:579:34: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
     579 |         priv->gpio_earpath_sel = devm_gpiod_get(dev, "earpath-sel",
         |                                  ^~~~~~~~~~~~~~
         |                                  devm_gpio_free
>> sound/soc/samsung/aries_wm8994.c:580:25: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
     580 |                         GPIOD_OUT_LOW);
         |                         ^~~~~~~~~~~~~
         |                         GPIOF_INIT_LOW
   sound/soc/samsung/aries_wm8994.c:580:25: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/samsung/aries_wm8994.c:602:25: error: 'GPIOD_IN' undeclared (first use in this function); did you mean 'GPIOF_IN'?
     602 |                         GPIOD_IN);
         |                         ^~~~~~~~
         |                         GPIOF_IN
   cc1: some warnings being treated as errors


vim +100 sound/soc/samsung/aries_wm8994.c

7a3a7671fa6c7e Jonathan Bakker 2020-06-14   91  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   92  static irqreturn_t headset_det_irq_thread(int irq, void *data)
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   93  {
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   94  	struct aries_wm8994_data *priv = (struct aries_wm8994_data *) data;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   95  	int ret = 0;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   96  	int time_left_ms = 300;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   97  	int adc;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   98  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14   99  	while (time_left_ms > 0) {
7a3a7671fa6c7e Jonathan Bakker 2020-06-14 @100  		if (!gpiod_get_value(priv->gpio_headset_detect)) {
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  101  			snd_soc_jack_report(&aries_headset, 0,
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  102  					SND_JACK_HEADSET);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14 @103  			gpiod_set_value(priv->gpio_earpath_sel, 0);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  104  			return IRQ_HANDLED;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  105  		}
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  106  		msleep(20);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  107  		time_left_ms -= 20;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  108  	}
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  109  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  110  	/* Temporarily enable micbias and earpath selector */
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  111  	ret = regulator_enable(priv->reg_headset_micbias);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  112  	if (ret)
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  113  		pr_err("%s failed to enable micbias: %d", __func__, ret);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  114  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  115  	gpiod_set_value(priv->gpio_earpath_sel, 1);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  116  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  117  	ret = iio_read_channel_processed(priv->adc, &adc);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  118  	if (ret < 0) {
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  119  		/* failed to read ADC, so assume headphone */
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  120  		pr_err("%s failed to read ADC, assuming headphones", __func__);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  121  		snd_soc_jack_report(&aries_headset, SND_JACK_HEADPHONE,
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  122  				SND_JACK_HEADSET);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  123  	} else {
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  124  		snd_soc_jack_report(&aries_headset,
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  125  				snd_soc_jack_get_type(&aries_headset, adc),
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  126  				SND_JACK_HEADSET);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  127  	}
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  128  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  129  	ret = regulator_disable(priv->reg_headset_micbias);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  130  	if (ret)
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  131  		pr_err("%s failed disable micbias: %d", __func__, ret);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  132  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  133  	/* Disable earpath selector when no mic connected */
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  134  	if (!(aries_headset.status & SND_JACK_MICROPHONE))
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  135  		gpiod_set_value(priv->gpio_earpath_sel, 0);
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  136  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  137  	return IRQ_HANDLED;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  138  }
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  139  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  140  static int headset_button_check(void *data)
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  141  {
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  142  	struct aries_wm8994_data *priv = (struct aries_wm8994_data *) data;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  143  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  144  	/* Filter out keypresses when 4 pole jack not detected */
7a3a7671fa6c7e Jonathan Bakker 2020-06-14 @145  	if (gpiod_get_value_cansleep(priv->gpio_headset_key) &&
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  146  			aries_headset.status & SND_JACK_MICROPHONE)
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  147  		return SND_JACK_BTN_0;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  148  
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  149  	return 0;
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  150  }
7a3a7671fa6c7e Jonathan Bakker 2020-06-14  151  

:::::: The code at line 100 was first introduced by commit
:::::: 7a3a7671fa6c7e90aff5f4242add2a40587b85ef ASoC: samsung: Add driver for Aries boards

:::::: TO: Jonathan Bakker <xc-racer2@live.ca>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
