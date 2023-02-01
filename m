Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0510685DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBADKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBADKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:10:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F240619D;
        Tue, 31 Jan 2023 19:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675221008; x=1706757008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hG0Cqd9tAcf9bnbBhEdpsPgvTCJitgXKwvwPCaj9CO8=;
  b=UpUbRuW9Y945dLAHXmWHcSxnooUZDmPsltN7KpJ95OH77KHryL3s8FB5
   mD1N89fvEshXC44+OoDzzwJyQpAYefg3rp8gmk2Fq1QqtikYTJbdzMsHB
   zkvgx6kBQQ+JA114894B/tvULi63LP8mjpkylh4X+0shT/DppYSZnlrIp
   yGh0RhkQJlYexBLp3jaEw6DVTZE/Vd9PahnDp09cIfF7hV+XEdZ5md+Nl
   0cszVJuMYXhxkjb1yX5TFnQ7MpxGQ56SlYHAnmSriotexhWIh6XqOfAcQ
   hPDIxZGSxQAwMXPjEfMXpPtWh9ZdGOqD8VFR2PmlpRpzAtN4NfWwW/QpN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="414233287"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="414233287"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 19:09:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="695185072"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="695185072"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2023 19:09:41 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN3VE-0004ys-1B;
        Wed, 01 Feb 2023 03:09:40 +0000
Date:   Wed, 1 Feb 2023 11:09:28 +0800
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
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
Message-ID: <202302011058.17Vvc1pN-lkp@intel.com>
References: <20230131153816.21709-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131153816.21709-1-bchihi@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balsam,

Thank you for the patch! Yet something to improve:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20230131-234122/bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230124-211910
base:   the 4th patch of https://lore.kernel.org/r/20230124131717.128660-5-bchihi%40baylibre.com
patch link:    https://lore.kernel.org/r/20230131153816.21709-1-bchihi%40baylibre.com
patch subject: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage Thermal Sensor driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302011058.17Vvc1pN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5646ebf6f10ff0fc60c04d8c57523f7c44526b41
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20230131-234122/bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230124-211910
        git checkout 5646ebf6f10ff0fc60c04d8c57523f7c44526b41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/thermal/mediatek/lvts_thermal.c:20:10: fatal error: dt-bindings/thermal/mediatek,lvts-thermal.h: No such file or directory
      20 | #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +20 drivers/thermal/mediatek/lvts_thermal.c

  > 20	#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
