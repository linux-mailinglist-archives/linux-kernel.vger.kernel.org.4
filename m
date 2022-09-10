Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA30E5B43B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 04:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIJCS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 22:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIJCS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 22:18:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE4EC745
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662776306; x=1694312306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IkAZ4T+4alxZetkjjlyVMEX4y6tUlHl03lQa9CmZle8=;
  b=Wp3AuDZavG6RfaQAELSHylDyY75leUp1GzA+R60gyDZBySXXDOXteg1G
   0CH0ZmmJGeEGhPoEh0fnZoY8bnu1Zi3n8nQp3V2elXSHVxBwe+2sGa2vO
   iu/21W8i3anXRc/fveV3vd94l3DZ+kpw6x7W1jH4AihVSfMRxV/kTSXrr
   PKd6igxFWpDoyJ/9i5qPsV5jdo1fLDs+fyUrNXOxtevmJ7HRNatvxF1uY
   K7IvIRxJDcUtAYGpj9HKWl7CH0K4ByxESsGeQ2+t8o9BbOqPkfJmAZWdF
   gG6V4h0DtWYFWrng+mF2CD/4MJcsN5CGBf84cnR2gBAiRgQ64WXwlemHM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="359330786"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="359330786"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 19:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="645763928"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2022 19:18:23 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWq4d-00020O-0B;
        Sat, 10 Sep 2022 02:18:23 +0000
Date:   Sat, 10 Sep 2022 10:17:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     kbuild-all@lists.01.org,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        kernel@axis.com, Astrid Rost <astrid.rost@axis.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ts3a227e: allow enabling the jack detect in driver
Message-ID: <202209101015.ZocWeV2G-lkp@intel.com>
References: <20220909093001.13110-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909093001.13110-1-astrid.rost@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Astrid,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.0-rc4 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Astrid-Rost/ASoC-ts3a227e-allow-enabling-the-jack-detect-in-driver/20220909-173508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: arm64-randconfig-r035-20220909 (https://download.01.org/0day-ci/archive/20220910/202209101015.ZocWeV2G-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f147a518459c71521cfe5bc786b804ba317091a0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Astrid-Rost/ASoC-ts3a227e-allow-enabling-the-jack-detect-in-driver/20220909-173508
        git checkout f147a518459c71521cfe5bc786b804ba317091a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "input_allocate_device" [sound/core/snd.ko] undefined!
>> ERROR: modpost: "input_unregister_device" [sound/core/snd.ko] undefined!
>> ERROR: modpost: "input_free_device" [sound/core/snd.ko] undefined!
>> ERROR: modpost: "input_register_device" [sound/core/snd.ko] undefined!
>> ERROR: modpost: "input_set_capability" [sound/core/snd.ko] undefined!
>> ERROR: modpost: "input_event" [sound/core/snd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
