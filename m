Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA271272B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbjEZNEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjEZNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:04:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1FFFB;
        Fri, 26 May 2023 06:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685106274; x=1716642274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PmkexRzoIqalsN8ZFBIq1pFwqpY5HuK3aJObn/BEItM=;
  b=PlAjRF3TKbXFmjL0SN47cDuiD7B8yCGbrXt3cTvBwRVribcMJnBJz3jY
   GMv6MpkJFga5ZBBPTkIGhs5o2FpvtQcWVz70fOzcevtLDeglVwIXKWA/4
   x9BwhdQ0qvhMyiHguS/TrOxKsTURrOIHjbluwDTpINJ+cMQAtOpVMY3dw
   sGQ4+QGnmRkWWxBH/LO9Xgqg0aXWw2y5+ZElYwF2bifcT2o3zlOKPdwsX
   ZySnzOi5FwS/CSGyYsLW2buASBe2Q7Foy/qWDMJ+6TOPbyJfmM9olxIIk
   G6Lb07TcJJpxX1XeqlDiXj0BM8V3IcC8fw6M2LUJ6DEQ2yvGbf1Fyl5J4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="351705646"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="351705646"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 06:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="817530721"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="817530721"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2023 06:04:32 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2X7P-000JLy-1k;
        Fri, 26 May 2023 13:04:31 +0000
Date:   Fri, 26 May 2023 21:03:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Noah Wang <noahwang.wang@outlook.com>, linux@roeck-us.net
Cc:     oe-kbuild-all@lists.linux.dev, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Noah Wang <noahwang.wang@outlook.com>
Subject: Re: [PATCH] hwmon: mp2891: add MP2891 driver
Message-ID: <202305262023.NJufWPK9-lkp@intel.com>
References: <TYZPR03MB7130A7F41D61BFB611DDF0C7FA479@TYZPR03MB7130.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR03MB7130A7F41D61BFB611DDF0C7FA479@TYZPR03MB7130.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noah,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Noah-Wang/hwmon-mp2891-add-MP2891-driver/20230526-174424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/TYZPR03MB7130A7F41D61BFB611DDF0C7FA479%40TYZPR03MB7130.apcprd03.prod.outlook.com
patch subject: [PATCH] hwmon: mp2891: add MP2891 driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230526/202305262023.NJufWPK9-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/be1255480e7afc1fd35bf23c635e7fb98a9c0299
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Noah-Wang/hwmon-mp2891-add-MP2891-driver/20230526-174424
        git checkout be1255480e7afc1fd35bf23c635e7fb98a9c0299
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305262023.NJufWPK9-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/pmbus/mp2891.c:362:18: error: initialization of 'int (*)(struct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_client *, const struct i2c_device_id *)' [-Werror=incompatible-pointer-types]
     362 |         .probe = mp2891_probe,
         |                  ^~~~~~~~~~~~
   drivers/hwmon/pmbus/mp2891.c:362:18: note: (near initialization for 'mp2891_driver.<anonymous>.probe')
   cc1: some warnings being treated as errors


vim +362 drivers/hwmon/pmbus/mp2891.c

   356	
   357	static struct i2c_driver mp2891_driver = {
   358		.driver = {
   359			.name = "mp2891",
   360			.of_match_table = mp2891_of_match,
   361		},
 > 362		.probe = mp2891_probe,
   363		.id_table = mp2891_id,
   364	};
   365	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
