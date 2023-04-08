Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F596DB92B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDHGNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 02:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDHGNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 02:13:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD4D301;
        Fri,  7 Apr 2023 23:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680934418; x=1712470418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3pSwex2GTRoIwzE9M/rgXMQbLMvVYq457TO/GzodD5c=;
  b=dQMdUbUfNiQeM9FSn1M5uF4RUwI7Ao1sDincxhmrhUOwY+YVqEInD2aI
   GQXNBY/ms530RiwRobh6ZCRjXsGHl0kA4yOAkhiiI7yybVzwr0nttg+FR
   WhcVW35jyTn7h5QVC65uc1wWbptoKtOJPHFJ8AWp2KCniJsE8Jnd0pLTi
   U96yuVJ2EKDS1rd3Nu5aNc9Sy3CLU1eYgl/wN1c3GpInY5jn+n5huBf2g
   /SuIXQmYZBOef0v9LyoHVn77XNxP9tUKxxea82sc/G6Yamj71geJ+no+l
   zn8l+DC4EiI5+8an5v0GXQC5x6E15Q7tcZ3HX5fJg2/UDMt+x3TqtMONO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="341867454"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="341867454"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 23:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="861970833"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="861970833"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2023 23:13:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pl1pN-000TPJ-2u;
        Sat, 08 Apr 2023 06:13:33 +0000
Date:   Sat, 8 Apr 2023 14:12:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: Re: [PATCH 2/2] watchdog: loongson1_wdt: Add DT support
Message-ID: <202304081301.6Ukja1z0-lkp@intel.com>
References: <20230407110025.516405-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407110025.516405-3-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keguang,

kernel test robot noticed the following build errors:

[auto build test ERROR on cf3be7e82b129ed34f811f116f2b113f6299d449]

url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang/dt-bindings-watchdog-Add-Loongson-1-watchdog/20230407-190222
base:   cf3be7e82b129ed34f811f116f2b113f6299d449
patch link:    https://lore.kernel.org/r/20230407110025.516405-3-keguang.zhang%40gmail.com
patch subject: [PATCH 2/2] watchdog: loongson1_wdt: Add DT support
config: mips-loongson1c_defconfig (https://download.01.org/0day-ci/archive/20230408/202304081301.6Ukja1z0-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/26b8fbfd577b41f39d6af516ef7c49cbffa05117
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Keguang-Zhang/dt-bindings-watchdog-Add-Loongson-1-watchdog/20230407-190222
        git checkout 26b8fbfd577b41f39d6af516ef7c49cbffa05117
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304081301.6Ukja1z0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/watchdog/loongson1_wdt.c:158:21: error: use of undeclared identifier 'ls1x_wdt_dt_ids'
                   .of_match_table = ls1x_wdt_dt_ids,
                                     ^
   1 error generated.


vim +/ls1x_wdt_dt_ids +158 drivers/watchdog/loongson1_wdt.c

   153	
   154	static struct platform_driver ls1x_wdt_driver = {
   155		.probe = ls1x_wdt_probe,
   156		.driver = {
   157			.name = "ls1x-wdt",
 > 158			.of_match_table = ls1x_wdt_dt_ids,
   159		},
   160	};
   161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
