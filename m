Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7869D5BF9A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiIUIq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiIUIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:46:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9DE8A1FE;
        Wed, 21 Sep 2022 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663749977; x=1695285977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WBh2EVZ4QSU9Dq3/ASp3Wt8vZVQtrj4URFPR++R12AM=;
  b=C5z+id/WnD40LUksP0avuExMuGnjDk23BQ40N22KfuXK/dnnK7yg5715
   xdKm3IwcxLzfTkWR+vdQfAMeLHj1hH3wg1qSQSmaftT+V5ZtKf109FMBi
   8dlx5hCKqUxwc4uSel0ggjLFprifeC5t04aq0q+cQNLuhvr6XBH46zeVP
   NRyj3K0jsnfVef3igm6WjvYY/PWf/Znic/Xjxo6+PftdXmHWehwYmXkin
   HA12Byv+4DvGjI+qJ/r0mbf+s+xwBMcYtaB0otCrF1jlIDKmswOU272TB
   8CHtwShp4WUZ2CKHJ7S8RWWcs9k24fSB06/lo6mRiukNBRvuDR914V1+H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363918096"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="363918096"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 01:46:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="570447933"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Sep 2022 01:46:13 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oavMy-0003Qb-0t;
        Wed, 21 Sep 2022 08:46:12 +0000
Date:   Wed, 21 Sep 2022 16:45:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zhanghongchen <zhanghongchen@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: Re: [PATCH v2 3/3] thermal: loongson2: add thermal management support
Message-ID: <202209211644.16Ox1qeg-lkp@intel.com>
References: <20220921015605.17078-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921015605.17078-3-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yinbo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.0-rc6 next-20220920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yinbo-Zhu/MAINTAINERS-add-maintainer-for-thermal-driver-for-loongson2-SoCs/20220921-095737
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220921/202209211644.16Ox1qeg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c21dcaa77e2e7514efdb4c97c805b14c9a05ec35
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yinbo-Zhu/MAINTAINERS-add-maintainer-for-thermal-driver-for-loongson2-SoCs/20220921-095737
        git checkout c21dcaa77e2e7514efdb4c97c805b14c9a05ec35
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/loongson2_thermal.c:183:5: warning: no previous prototype for 'loongson2_thermal_remove' [-Wmissing-prototypes]
     183 | int loongson2_thermal_remove(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/loongson2_thermal_remove +183 drivers/thermal/loongson2_thermal.c

   182	
 > 183	int loongson2_thermal_remove(struct platform_device *pdev)
   184	{
   185		struct loongson2_thermal_data *data = platform_get_drvdata(pdev);
   186		int reg_off = data->id * 2;
   187	
   188		/* disable interrupt */
   189		writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
   190		writew(0, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
   191	
   192		return 0;
   193	}
   194	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
