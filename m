Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8B6C29DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCUFcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:32:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6BA10421;
        Mon, 20 Mar 2023 22:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679376738; x=1710912738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HJbS5/CJcCjSbGwXa19T8zRuJqS2j3Q5ALgiLfha7Cg=;
  b=dtsDM5JKv6g24LEkuaPlLcmGfBV7aBOtgZNqr+A8XFk902YdISfjO7kc
   6MDXl7szLXCbQh9BJfag4bVChUiP5FysfayxKvQ3c8ozmh4PXERVZCAvz
   oJgfd1XkVnw+rhE4iL+3eMAEXDZjcl8M+EPiwmk4Ng/+De4N3xLq7rPQ2
   bXKEcl344DtJFHRdTzAodSraJaQhvnxtIITGwCta7on/O3GNQBk17iNc7
   lH9b2zxkDkLFN/ZjvjRdjH05HXi6QX2NRAVbHVESlCXUw53OeeeqvKRTu
   p+AUDmGBIiroMUqk8dB61KiY4bCZz5+FoQ+RlRpGZaDE/yUh+q46Gmv5A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336356592"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="336356592"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="1010790425"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="1010790425"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2023 22:32:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peUbW-000Bda-1Q;
        Tue, 21 Mar 2023 05:32:14 +0000
Date:   Tue, 21 Mar 2023 13:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, robh+dt@kernel.org,
        linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: Re: [PATCH v2 3/5] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power
 supply driver
Message-ID: <202303211303.U8Ip4xDC-lkp@intel.com>
References: <20230320154019.1943770-4-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320154019.1943770-4-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lakshmi-Yadlapati/dt-bindings-vendor-prefixes-Add-prefix-for-acbel/20230320-235222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230320154019.1943770-4-lakshmiy%40us.ibm.com
patch subject: [PATCH v2 3/5] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply driver
config: riscv-randconfig-c006-20230319 (https://download.01.org/0day-ci/archive/20230321/202303211303.U8Ip4xDC-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/d873cbdc9f171b066c3f6f6c2a39736e168ad19f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lakshmi-Yadlapati/dt-bindings-vendor-prefixes-Add-prefix-for-acbel/20230320-235222
        git checkout d873cbdc9f171b066c3f6f6c2a39736e168ad19f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303211303.U8Ip4xDC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/acbel-crps.c:24:37: warning: unused variable 'acbel_crps_fops' [-Wunused-const-variable]
   static const struct file_operations acbel_crps_fops = {
                                       ^
   1 warning generated.


vim +/acbel_crps_fops +24 drivers/hwmon/pmbus/acbel-crps.c

    23	
  > 24	static const struct file_operations acbel_crps_fops = {
    25		.llseek = noop_llseek,
    26		.open = simple_open,
    27	};
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
