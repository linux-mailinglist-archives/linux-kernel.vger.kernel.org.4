Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA85BD5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiISU3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiISU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:29:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4EF1055F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663619354; x=1695155354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T3KlIdR7NNehq66mZ3NQ/gWBX5mTPWIpzWn71363Bsw=;
  b=PaFEZABRlwAFRDau+iZqJl5P9DzZCwuVSr6CZABcPzIhOjoAnFZ/efyq
   4scrz6F94k6gtGDbmvFrRzk5NFMcBa8NKMB1oz+q35HRg/KOrpD09u3Qf
   3bGILg0+AyVk1VjiIJx9TBeMFE2fU76AuKqRoNWBUdkvl0PL9ubXx2dE3
   ju2C+ihT+zG0+eWf+IODg6rsjOFhLXpUcmPmm7PPOKgL7w68+j4D93zGM
   QEuQ5I7/r4Ywhi/YqTrBHkh+qNkBIoC8+5BBWAqCIJXKHeWkMogWoceyt
   JVbfR+i56eCd5dvfLFhrr0yRTTuBpnNC16n9lp57sP7zJ655TMNnAAZHX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298242091"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="298242091"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 13:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="649298686"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2022 13:29:12 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaNOC-0002DF-0K;
        Mon, 19 Sep 2022 20:29:12 +0000
Date:   Tue, 20 Sep 2022 04:28:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:filetF4IoJ 28/33] sound/soc/sunxi/sun50i-dmic.c:62:1:
 warning: 'static' is not at beginning of declaration
Message-ID: <202209200416.3fJxLmUY-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git filetF4IoJ
head:   717a8ff20f32792d6a94f2883e771482c37d844b
commit: 9fc2c8ed923d8ec8a49cf5b5076c84867126ca69 [28/33] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220920/202209200416.3fJxLmUY-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=9fc2c8ed923d8ec8a49cf5b5076c84867126ca69
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci filetF4IoJ
        git checkout 9fc2c8ed923d8ec8a49cf5b5076c84867126ca69
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash sound/soc/sunxi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/sunxi/sun50i-dmic.c:62:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
      62 | const static struct dmic_rate dmic_rate_s[] = {
         | ^~~~~


vim +/static +62 sound/soc/sunxi/sun50i-dmic.c

    61	
  > 62	const static struct dmic_rate dmic_rate_s[] = {
    63		{48000, 0x0},
    64		{44100, 0x0},
    65		{32000, 0x1},
    66		{24000, 0x2},
    67		{22050, 0x2},
    68		{16000, 0x3},
    69		{12000, 0x4},
    70		{11025, 0x4},
    71		{8000,  0x5},
    72	};
    73	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
