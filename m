Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6206D30A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDAMGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 08:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 08:06:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A193F7;
        Sat,  1 Apr 2023 05:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680350793; x=1711886793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GhN/zLgZPhjtxMWToJxXXsvcAbSsvRGheQVMGCpow7w=;
  b=bHnXxtjecow8+mruu2cNG0S9yw7pyfRp5OwFbNv8i+HteKW6dSgl8i3x
   LzgBURD+01a9ktr6zzmyb7tNofDniL9vT5g2BpKoWZ1ZvlE703Z1BmsoJ
   tK5eymx0Va3op25/a9QECcnAzCTsSuMg1jz4oOEYRKLlYM48U5rbIgGHM
   wHJFfeCQCnd09EmTIiqiFYbeC8k4N2ylnhqQufOkczXAfk+Y3yyVUbsyA
   9c8pGJcwamC1RFdHkuU1oZrYD4UHkgKIlr9+doPTEu7jmlIxmuJAX+vdz
   EARE338GZMbZoFq0E7HPmYbhUq9FPpPCxmA7sVxGiP0VXoi/4ZuRyfUJT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="427927556"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="427927556"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 05:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="859651603"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="859651603"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2023 05:06:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pia01-000MkP-1w;
        Sat, 01 Apr 2023 12:06:25 +0000
Date:   Sat, 1 Apr 2023 20:05:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
Message-ID: <202304011957.pKSWQHyS-lkp@intel.com>
References: <ZCf085W4XL2PtQf6@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCf085W4XL2PtQf6@arbad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

I love your patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mpr-sensors/20230401-171226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/ZCf085W4XL2PtQf6%40arbad
patch subject: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
config: m68k-randconfig-r023-20230401 (https://download.01.org/0day-ci/archive/20230401/202304011957.pKSWQHyS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6a49dae45811d8a644c56dc18b6cdbc6ea67df98
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mpr-sensors/20230401-171226
        git checkout 6a49dae45811d8a644c56dc18b6cdbc6ea67df98
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304011957.pKSWQHyS-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__divdi3" [drivers/iio/pressure/mpr.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
