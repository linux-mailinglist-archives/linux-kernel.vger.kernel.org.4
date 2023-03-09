Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E16B17D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCIAZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCIAZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:25:09 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B91164B38;
        Wed,  8 Mar 2023 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678321508; x=1709857508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sIwwmAt7KlTF7l6Vrb1Y0LQqzYM6y30mcH8hZqFhyvQ=;
  b=mFixVEcvnLxKectLVfKqmozv1XzQxweHQBPdKTbh9sAGot7RrJSY8b/j
   sz2qpSJTK8ozfEx88ixAJIM39wHvQO4E53LDzC9+z5dW6BTeFf9Ssy3s+
   IFq4FbiDsFprY4aGqsf7TJlaPxdjeUqWiMfByWc7tiIE4r2LfbXubAVS+
   Rq/OD6GVCJcwMyQM9n81oRKA0pUTYzQ//Me7IU4WC6yDLfphPoSYF2qg1
   YkZZkqETDnJJykvtWOnfCHuEqVHXdSUHJpuz4d+rLLcnwPTDmvDQDtkuC
   Plh+icEGeD1E1yjC3N3eHxt52Hx23aWwrvlcZ+igUBcbNgkrz0JHH3ACA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="398895011"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="398895011"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 16:25:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="800967026"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="800967026"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2023 16:25:04 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa45f-0002Vx-2F;
        Thu, 09 Mar 2023 00:25:03 +0000
Date:   Thu, 9 Mar 2023 08:24:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] power: max17040: get thermal data from adc if
 available
Message-ID: <202303090817.SuiCpxvy-lkp@intel.com>
References: <20230308084419.11934-5-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308084419.11934-5-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on krzk-dt/for-next linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230308-164538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20230308084419.11934-5-clamor95%40gmail.com
patch subject: [PATCH v1 4/4] power: max17040: get thermal data from adc if available
config: hexagon-randconfig-r035-20230308 (https://download.01.org/0day-ci/archive/20230309/202303090817.SuiCpxvy-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7b9bbf6f2b910ef4ffab18022223573e9094f007
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Svyatoslav-Ryhel/dt-bindings-power-supply-maxim-max17040-update-properties/20230308-164538
        git checkout 7b9bbf6f2b910ef4ffab18022223573e9094f007
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303090817.SuiCpxvy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: iio_channel_release
   >>> referenced by max17040_battery.c:586 (drivers/power/supply/max17040_battery.c:586)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_remove) in archive vmlinux.a
   >>> referenced by max17040_battery.c:586 (drivers/power/supply/max17040_battery.c:586)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_remove) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: iio_channel_get
   >>> referenced by max17040_battery.c:572 (drivers/power/supply/max17040_battery.c:572)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_probe) in archive vmlinux.a
   >>> referenced by max17040_battery.c:572 (drivers/power/supply/max17040_battery.c:572)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: iio_read_channel_raw
   >>> referenced by max17040_battery.c:422 (drivers/power/supply/max17040_battery.c:422)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_get_property) in archive vmlinux.a
   >>> referenced by max17040_battery.c:422 (drivers/power/supply/max17040_battery.c:422)
   >>>               drivers/power/supply/max17040_battery.o:(max17040_get_property) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
