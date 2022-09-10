Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C955B455D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIJJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIJJHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:07:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF348CB7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662800871; x=1694336871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sEs3paHKT14nyBFLtoqNlPdcjso/OW9rIIBrxhbClfY=;
  b=jRoPe9LJr/ZzOW4ULwQ4Fct9EaFLI9oQxpun0qBrYAQSqtDoPnfTRox6
   WLJrBInousIV5CUGla57usn6rpGvyTSbroZYxUrmy6Ju+DmoM2tu/EJ1c
   hTwccMLtS2MgVxw7FQMQ6TZXyQ11iP4CZCyUuDkM1otzjTTqGWI3QIGNk
   nNeI+amDWzOCI6YrWdhsc6BzPnrpiv0cHCfUs7aIdZp8pX6PSgsG/oyoX
   QwrUiQvZU7XJmxWY9wh21atwD2kMfZniWdZ5HZY4iBPeb4JU9SyIna/fV
   7Be2MBGCxBAKhvjqeIDjrdRUgAin4P7HHdtAlHz9ir3JNZLBBjNgiwiAv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296365628"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="296365628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 02:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="592891991"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2022 02:07:50 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWwSr-0002LZ-1w;
        Sat, 10 Sep 2022 09:07:49 +0000
Date:   Sat, 10 Sep 2022 17:06:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mbgg-mediatek:v6.0-dev/svs-dev 20/23] ERROR: modpost:
 "svs_mt8183_efuse_parsing" [drivers/soc/mediatek/mtk-svs.ko] undefined!
Message-ID: <202209101721.qmWllfOJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mbgg/linux-mediatek v6.0-dev/svs-dev
head:   c06b3861a88f2c62af12a478e6126cf5ceadea16
commit: cb7e58fca1d525849ff8105640a544470132192d [20/23] soc: mediatek: mtk-svs: Move SoC specific functions to new files
config: arm64-randconfig-r005-20220907 (https://download.01.org/0day-ci/archive/20220910/202209101721.qmWllfOJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/mbgg/linux-mediatek/commit/cb7e58fca1d525849ff8105640a544470132192d
        git remote add mbgg-mediatek https://github.com/mbgg/linux-mediatek
        git fetch --no-tags mbgg-mediatek v6.0-dev/svs-dev
        git checkout cb7e58fca1d525849ff8105640a544470132192d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/soc/mediatek/mtk-svs-mt8183.o
ERROR: modpost: missing MODULE_LICENSE() in drivers/soc/mediatek/mtk-svs-mt8192.o
>> ERROR: modpost: "svs_mt8183_efuse_parsing" [drivers/soc/mediatek/mtk-svs.ko] undefined!
>> ERROR: modpost: "svs_mt8183_platform_probe" [drivers/soc/mediatek/mtk-svs.ko] undefined!
>> ERROR: modpost: "svs_mt8192_efuse_parsing" [drivers/soc/mediatek/mtk-svs.ko] undefined!
>> ERROR: modpost: "svs_mt8192_platform_probe" [drivers/soc/mediatek/mtk-svs.ko] undefined!
>> ERROR: modpost: "svs_thermal_efuse_get_data" [drivers/soc/mediatek/mtk-svs-mt8183.ko] undefined!
>> ERROR: modpost: "svs_add_device_link" [drivers/soc/mediatek/mtk-svs-mt8183.ko] undefined!
>> ERROR: modpost: "svs_thermal_efuse_get_data" [drivers/soc/mediatek/mtk-svs-mt8192.ko] undefined!
>> ERROR: modpost: "svs_add_device_link" [drivers/soc/mediatek/mtk-svs-mt8192.ko] undefined!
>> ERROR: modpost: "svs_get_subsys_device" [drivers/soc/mediatek/mtk-svs-mt8192.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
