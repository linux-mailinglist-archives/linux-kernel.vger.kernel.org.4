Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497806EB6B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 03:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjDVBoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 21:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDVBof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 21:44:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7CB35BB;
        Fri, 21 Apr 2023 18:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682127874; x=1713663874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vkWe51df/2dvVNBuhbu+qHD3Go/+n5R5vhvb2COquW8=;
  b=COrpqp1j31pncDe/jx6HQQRKJROGUQvI9uIBJ5hf2TJI2Z+cJjr5tCGt
   F3OUSTY1wWkDjZeEmAdDD7rgBpXF69MJOSGtlpuy/Irkd3g4ghoD2osYs
   zy/D+BcvLk9huQUrTHty/cssLQkBZjW4HiEgjBdoWFrKC5gnxz8jsd6pB
   x90IXhY6X5Riwk/GrJUoir7unakEz9Nm8uZLjek4mfoLWuN1oLp2Y7OzI
   cLmWgi+KuOg+84B6Wjoy/2Uy/44dcgV/pKuWFo2nZ/VsdvFCcPDXPwFEf
   3fPuJDfHeHjaU+UdTZJ1JqMJOK+GeeiEdzRX+ZKF/iY7a+W3fvdjGg485
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343601258"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343601258"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 18:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="692444597"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="692444597"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2023 18:44:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq2If-000gzY-1u;
        Sat, 22 Apr 2023 01:44:29 +0000
Date:   Sat, 22 Apr 2023 09:44:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
Message-ID: <202304220932.cK8RhITJ-lkp@intel.com>
References: <20230421154308.527128-4-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421154308.527128-4-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.3-rc7 next-20230421]
[cannot apply to drm-misc/drm-misc-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dario-Binacchi/dt-bindings-display-panel-Add-synaptics-r63353-panel-controller/20230421-234627
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230421154308.527128-4-dario.binacchi%40amarulasolutions.com
patch subject: [PATCH 3/7] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
config: arm64-buildonly-randconfig-r004-20230421 (https://download.01.org/0day-ci/archive/20230422/202304220932.cK8RhITJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/eb3fd6ddb6525c2084455d38de459aaaf0213471
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dario-Binacchi/dt-bindings-display-panel-Add-synaptics-r63353-panel-controller/20230421-234627
        git checkout eb3fd6ddb6525c2084455d38de459aaaf0213471
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220932.cK8RhITJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi:47.1-5 Label or path dsi not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
