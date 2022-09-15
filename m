Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F285B98AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIOKXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:22:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EDA5A2F7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663237376; x=1694773376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pAOHEC6k0axjGqpCW/rrQaXmYTfNHMHe7M9g/zoOTRw=;
  b=GAjyRGp7TERL2wf+VpYLktPEWFSdvAfNyV8iXHjiwSop/ot4IHQmygJU
   SxTIRvevNTK+uvua1MiLLEsLKUoko8nN4SitSdVrgvlVMxR/M+MJAP6zP
   NW+MP3e1ilr616oOcqjd/BntM7ncVxWzf8ux76DyU+Z7G0vs2Ko9dEBm7
   Tqsa455ufS2APKg3m/UoICeRd+211WjR3E13g7MlKbPfdAlMD5LhrKik3
   lwxIGEUahnaQRS2SAvSY69aLMuHcw44+dXSm9NIHEQj/owD1N4X++YhuS
   psP3H7J9i4dpqtVmXtyLq1MRCny9HaMrFdqcBGOpDRuDucOtr69V7Qj1m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324935695"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="324935695"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 03:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="685671408"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2022 03:22:54 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYm1F-0000ND-1l;
        Thu, 15 Sep 2022 10:22:53 +0000
Date:   Thu, 15 Sep 2022 18:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morimoto:sound2-v6.0-2022-09-15-v2 37/56]
 sound/soc/meson/aiu-fifo.c:210:18: error: 'struct snd_soc_dai' has no member
 named 'playback_dma_data'
Message-ID: <202209151815.tkUMHewi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/morimoto/linux sound2-v6.0-2022-09-15-v2
head:   74b2374e041d80b11b1ddf8d24d6697b91de0f90
commit: c47b5b2b28040232bad1fe5bc43d28061b388a47 [37/56] ASoC: soc-dai.h: cleanup Playback/Capture data for snd_soc_dai
config: csky-randconfig-r021-20220914 (https://download.01.org/0day-ci/archive/20220915/202209151815.tkUMHewi-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/morimoto/linux/commit/c47b5b2b28040232bad1fe5bc43d28061b388a47
        git remote add morimoto https://github.com/morimoto/linux
        git fetch --no-tags morimoto sound2-v6.0-2022-09-15-v2
        git checkout c47b5b2b28040232bad1fe5bc43d28061b388a47
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash sound/soc/meson/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/meson/aiu-fifo.c: In function 'aiu_fifo_dai_remove':
>> sound/soc/meson/aiu-fifo.c:210:18: error: 'struct snd_soc_dai' has no member named 'playback_dma_data'
     210 |         kfree(dai->playback_dma_data);
         |                  ^~


vim +210 sound/soc/meson/aiu-fifo.c

6ae9ca9ce986bf Jerome Brunet 2020-02-13  207  
6ae9ca9ce986bf Jerome Brunet 2020-02-13  208  int aiu_fifo_dai_remove(struct snd_soc_dai *dai)
6ae9ca9ce986bf Jerome Brunet 2020-02-13  209  {
6ae9ca9ce986bf Jerome Brunet 2020-02-13 @210  	kfree(dai->playback_dma_data);
6ae9ca9ce986bf Jerome Brunet 2020-02-13  211  
6ae9ca9ce986bf Jerome Brunet 2020-02-13  212  	return 0;
6ae9ca9ce986bf Jerome Brunet 2020-02-13  213  }
6ae9ca9ce986bf Jerome Brunet 2020-02-13  214  

:::::: The code at line 210 was first introduced by commit
:::::: 6ae9ca9ce986bffe71fd0fbf9595de8500891b52 ASoC: meson: aiu: add i2s and spdif support

:::::: TO: Jerome Brunet <jbrunet@baylibre.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
