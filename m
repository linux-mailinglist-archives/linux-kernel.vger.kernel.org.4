Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189CC68DDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjBGQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjBGQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:14:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A865A3;
        Tue,  7 Feb 2023 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675786459; x=1707322459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=piPvQsT8sg3M6OXkur43AQOlc9r+x7DRJBGS2pa/A0Q=;
  b=TVkHyE0N2gjnTw98QxCrdU/4pvxWg4h9L5yY1QlAQvIJo7YQaWJtFi46
   MdlIxi5YPEyOOEpCv3EX8km0pw7D+UCJ7G+h4mcX617XmOOL5cWN/X2aP
   rG9/pmQa8OegBsM9nS0b6/rBltbxSolJ8OiWi58MOJoMXzY603cYn2OQy
   wM9i9UDXCjeL6hPw/po2ibI6pbSk0CygLAS/yqdoQIDhAm0xYMVJHJ1jW
   kcnxY/zfybEYEf9qTZ5OOkfy4znB7EWUKbAiVgYRMZ5i4kCFULmWpPI9V
   kpCat1lYlQyMZwJFrzBGDMyLYVcvfiaPGoaWlpPT6U8V0QSDn6w5sGhah
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="309885589"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="309885589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 08:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="699301774"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="699301774"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2023 08:14:10 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPQbh-0003gM-3A;
        Tue, 07 Feb 2023 16:14:09 +0000
Date:   Wed, 8 Feb 2023 00:14:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH v13 1/6] thermal: drivers: mediatek: Relocate driver to
 mediatek folder
Message-ID: <202302080018.wNeWiKqz-lkp@intel.com>
References: <20230207130958.608305-2-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207130958.608305-2-bchihi@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on a2c81dc59d41e92362ab7d41d0c15471ea50637d]

url:    https://github.com/intel-lab-lkp/linux/commits/bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230207-211351
base:   a2c81dc59d41e92362ab7d41d0c15471ea50637d
patch link:    https://lore.kernel.org/r/20230207130958.608305-2-bchihi%40baylibre.com
patch subject: [PATCH v13 1/6] thermal: drivers: mediatek: Relocate driver to mediatek folder
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230208/202302080018.wNeWiKqz-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0eb89997925c0d7b47bbeee93016146fc660b259
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230207-211351
        git checkout 0eb89997925c0d7b47bbeee93016146fc660b259
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/thermal/mediatek/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/mediatek/auxadc_thermal.c:562: warning: expecting prototype for raw_to_mcelsius(). Prototype was for raw_to_mcelsius_v1() instead


vim +562 drivers/thermal/mediatek/auxadc_thermal.c

a4ffe6b52d27f4 drivers/thermal/mtk_thermal.c Michael Kao   2019-02-01  551  
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  552  /**
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  553   * raw_to_mcelsius - convert a raw ADC value to mcelsius
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  554   * @mt:	The thermal controller
3772bb422072d4 drivers/thermal/mtk_thermal.c Amit Kucheria 2019-11-20  555   * @sensno:	sensor number
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  556   * @raw:	raw ADC value
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  557   *
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  558   * This converts the raw ADC value to mcelsius using the SoC specific
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  559   * calibration constants
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  560   */
54bf1e5a629dfb drivers/thermal/mtk_thermal.c Henry Yen     2020-04-30  561  static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30 @562  {
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  563  	s32 tmp;
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  564  
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  565  	raw &= 0xfff;
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  566  
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  567  	tmp = 203450520 << 3;
f84514766985d3 drivers/thermal/mtk_thermal.c Michael Kao   2019-02-01  568  	tmp /= mt->conf->cali_val + mt->o_slope;
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  569  	tmp /= 10000 + mt->adc_ge;
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  570  	tmp *= raw - mt->vts[sensno] - 3350;
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  571  	tmp >>= 3;
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  572  
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  573  	return mt->degc_cali * 500 - tmp;
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  574  }
a92db1c8089e82 drivers/thermal/mtk_thermal.c Sascha Hauer  2015-11-30  575  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
