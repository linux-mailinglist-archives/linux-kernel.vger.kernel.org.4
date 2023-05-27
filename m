Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3071350A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjE0NiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjE0NiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:38:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA0EC7;
        Sat, 27 May 2023 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685194687; x=1716730687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6k/YZ2YJ72o+lkzLjuoJ2wjO+1FkZhPb7+ckalpGaM=;
  b=g8zZVyu9NGhRvp21bE5DjA6S+Z+jxTGa/Lx1FS8EqPibMEm8lag31hqM
   Hpd2S1/j3kEqoK9vCNRKcnVmdJUOoTYUy8g9b8bbcq0AfZo+ZU2NdE41L
   gwI5laWaCSEx+O8f80J+P+QNDuTnG1ZMF66K04m1NZXg73v6XNOaGb5ce
   TsizrrDz5EpIocDMJfIKf5ZyMe7g+4otj8iZ0Bmv5eUSq3U+Rri5MVdD4
   sklyp/UiXjTLI4lk/To0vR1jQQB3jC9Pf8naJzC9CNXiuG7NesG1TgAUf
   myt17m2PRtiohix2CagDcxZsEzDfkcnUEuMNpj3Vvq4yft8PZn5P1YFzt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="343895985"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="343895985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 06:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="770597342"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="770597342"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2023 06:38:03 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2u7P-000Jz0-01;
        Sat, 27 May 2023 13:38:03 +0000
Date:   Sat, 27 May 2023 21:37:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ARM: dts: bcm28155-ap: use node labels
Message-ID: <202305272120.d14t9kNu-lkp@intel.com>
References: <cb52d36db90fa24e40fccc69724a685344f2c2f3.1685127525.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb52d36db90fa24e40fccc69724a685344f2c2f3.1685127525.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230525]
[cannot apply to robh/for-next krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next v6.4-rc3 v6.4-rc2 v6.4-rc1 linus/master v6.4-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Jakubek/ARM-dts-bcm-mobile-change-includes-to-where-applicable/20230527-033251
base:   next-20230525
patch link:    https://lore.kernel.org/r/cb52d36db90fa24e40fccc69724a685344f2c2f3.1685127525.git.stano.jakubek%40gmail.com
patch subject: [PATCH 6/6] ARM: dts: bcm28155-ap: use node labels
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230527/202305272120.d14t9kNu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/42bbea48865bd029be4bb3c33c8d455645e3ff58
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stanislav-Jakubek/ARM-dts-bcm-mobile-change-includes-to-where-applicable/20230527-033251
        git checkout 42bbea48865bd029be4bb3c33c8d455645e3ff58
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305272120.d14t9kNu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/bcm59056.dtsi:7.1-5 Label or path pmu not found
>> Error: arch/arm/boot/dts/bcm28155-ap.dts:37.1-5 Label or path pmu not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
