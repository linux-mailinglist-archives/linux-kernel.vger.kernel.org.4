Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61072721990
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 21:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjFDTgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 15:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 15:36:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5AB0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685907376; x=1717443376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZSfGAMA7Qaqgsn3g8A5V4P72lAF58TftsFaChYGMk/w=;
  b=NybXHMy9TaXY2ew3Df8hpArlrODAWTOt8+HLmGwFX9GFnP0MLB1TUSsT
   eeAgX5p8JOsgnKdQze3ufTmPUuG7Skd/TMCGKHFFmo7ypoud72zR02qNp
   wH1c17ViCrn8wnyh78UscQvEYmuLGmw1pewRCZKgJOzsjVDrQ51Xg33gU
   HgqlId4dtla+fcrqKR92hTIn98rxyYaOK42ByAGOyMrMD9y8k5QqQ87Zc
   HLb0D6d38jelXLTbEh9zJRY9aYWiO3UuaYTTXSTJ5lBSFIgkNrOaioUw9
   /4/++PnnhtPUMqHM6vmYzTU5vkvC9EEWtAt97tTO+EefKIaCK4FAPKObN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="356234598"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="356234598"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 12:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="658838691"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658838691"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2023 12:36:13 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5tWO-0003Op-2Q;
        Sun, 04 Jun 2023 19:36:12 +0000
Date:   Mon, 5 Jun 2023 03:35:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/pinctrl/pinctrl-cy8c95x0.c:390:21: error: variable
 'cy8c95x0_i2c_regmap' has initializer but incomplete type
Message-ID: <202306050310.RQsoJPTw-lkp@intel.com>
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

Hi Geert,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9561de3a55bed6bdd44a12820ba81ec416e705a7
commit: 70a640c0efa7667453c3911b13335304ce46ad8b regmap: REGMAP_KUNIT should not select REGMAP
date:   4 weeks ago
config: s390-randconfig-r011-20230605 (https://download.01.org/0day-ci/archive/20230605/202306050310.RQsoJPTw-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=70a640c0efa7667453c3911b13335304ce46ad8b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 70a640c0efa7667453c3911b13335304ce46ad8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/extcon/ drivers/gpio/ drivers/i2c/muxes/ drivers/input/misc/ drivers/media/cec/i2c/ drivers/misc/eeprom/ drivers/mux/ drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306050310.RQsoJPTw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-cy8c95x0.c:390:21: error: variable 'cy8c95x0_i2c_regmap' has initializer but incomplete type
     390 | static const struct regmap_config cy8c95x0_i2c_regmap = {
         |                     ^~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-cy8c95x0.c:391:10: error: 'const struct regmap_config' has no member named 'reg_bits'
     391 |         .reg_bits = 8,
         |          ^~~~~~~~
>> drivers/pinctrl/pinctrl-cy8c95x0.c:391:21: warning: excess elements in struct initializer
     391 |         .reg_bits = 8,
         |                     ^
   drivers/pinctrl/pinctrl-cy8c95x0.c:391:21: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:392:10: error: 'const struct regmap_config' has no member named 'val_bits'
     392 |         .val_bits = 8,
         |          ^~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:392:21: warning: excess elements in struct initializer
     392 |         .val_bits = 8,
         |                     ^
   drivers/pinctrl/pinctrl-cy8c95x0.c:392:21: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:394:10: error: 'const struct regmap_config' has no member named 'reg_defaults'
     394 |         .reg_defaults = cy8c95x0_reg_defaults,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:394:25: warning: excess elements in struct initializer
     394 |         .reg_defaults = cy8c95x0_reg_defaults,
         |                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:394:25: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:395:10: error: 'const struct regmap_config' has no member named 'num_reg_defaults'
     395 |         .num_reg_defaults = ARRAY_SIZE(cy8c95x0_reg_defaults),
         |          ^~~~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:15,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/pinctrl/pinctrl-cy8c95x0.c:10:
>> include/linux/kernel.h:56:25: warning: excess elements in struct initializer
      56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/pinctrl/pinctrl-cy8c95x0.c:395:29: note: in expansion of macro 'ARRAY_SIZE'
     395 |         .num_reg_defaults = ARRAY_SIZE(cy8c95x0_reg_defaults),
         |                             ^~~~~~~~~~
   include/linux/kernel.h:56:25: note: (near initialization for 'cy8c95x0_i2c_regmap')
      56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/pinctrl/pinctrl-cy8c95x0.c:395:29: note: in expansion of macro 'ARRAY_SIZE'
     395 |         .num_reg_defaults = ARRAY_SIZE(cy8c95x0_reg_defaults),
         |                             ^~~~~~~~~~
>> drivers/pinctrl/pinctrl-cy8c95x0.c:397:10: error: 'const struct regmap_config' has no member named 'readable_reg'
     397 |         .readable_reg = cy8c95x0_readable_register,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:397:25: warning: excess elements in struct initializer
     397 |         .readable_reg = cy8c95x0_readable_register,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:397:25: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:398:10: error: 'const struct regmap_config' has no member named 'writeable_reg'
     398 |         .writeable_reg = cy8c95x0_writeable_register,
         |          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:398:26: warning: excess elements in struct initializer
     398 |         .writeable_reg = cy8c95x0_writeable_register,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:398:26: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:399:10: error: 'const struct regmap_config' has no member named 'volatile_reg'
     399 |         .volatile_reg = cy8c95x0_volatile_register,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:399:25: warning: excess elements in struct initializer
     399 |         .volatile_reg = cy8c95x0_volatile_register,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:399:25: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:400:10: error: 'const struct regmap_config' has no member named 'precious_reg'
     400 |         .precious_reg = cy8c95x0_precious_register,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:400:25: warning: excess elements in struct initializer
     400 |         .precious_reg = cy8c95x0_precious_register,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:400:25: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:402:10: error: 'const struct regmap_config' has no member named 'cache_type'
     402 |         .cache_type = REGCACHE_FLAT,
         |          ^~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:402:23: warning: excess elements in struct initializer
     402 |         .cache_type = REGCACHE_FLAT,
         |                       ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:402:23: note: (near initialization for 'cy8c95x0_i2c_regmap')
>> drivers/pinctrl/pinctrl-cy8c95x0.c:403:10: error: 'const struct regmap_config' has no member named 'max_register'
     403 |         .max_register = CY8C95X0_COMMAND,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:57:33: warning: excess elements in struct initializer
      57 | #define CY8C95X0_COMMAND        0x30
         |                                 ^~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:403:25: note: in expansion of macro 'CY8C95X0_COMMAND'
     403 |         .max_register = CY8C95X0_COMMAND,
         |                         ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:57:33: note: (near initialization for 'cy8c95x0_i2c_regmap')
      57 | #define CY8C95X0_COMMAND        0x30
         |                                 ^~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c:403:25: note: in expansion of macro 'CY8C95X0_COMMAND'
     403 |         .max_register = CY8C95X0_COMMAND,
         |                         ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-cy8c95x0.c: In function 'cy8c95x0_probe':
>> drivers/pinctrl/pinctrl-cy8c95x0.c:1386:24: error: implicit declaration of function 'devm_regmap_init_i2c' [-Werror=implicit-function-declaration]
    1386 |         chip->regmap = devm_regmap_init_i2c(client, &cy8c95x0_i2c_regmap);
         |                        ^~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-cy8c95x0.c:1386:22: warning: assignment to 'struct regmap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1386 |         chip->regmap = devm_regmap_init_i2c(client, &cy8c95x0_i2c_regmap);
         |                      ^
   drivers/pinctrl/pinctrl-cy8c95x0.c: At top level:
>> drivers/pinctrl/pinctrl-cy8c95x0.c:390:35: error: storage size of 'cy8c95x0_i2c_regmap' isn't known
     390 | static const struct regmap_config cy8c95x0_i2c_regmap = {
         |                                   ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> drivers/pinctrl/pinctrl-mcp23s08.c:58:21: error: variable 'mcp23x08_volatile_range' has initializer but incomplete type
      58 | static const struct regmap_range mcp23x08_volatile_range = {
         |                     ^~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:59:10: error: 'const struct regmap_range' has no member named 'range_min'
      59 |         .range_min = MCP_INTF,
         |          ^~~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:42:25: warning: excess elements in struct initializer
      42 | #define MCP_INTF        0x07
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:59:22: note: in expansion of macro 'MCP_INTF'
      59 |         .range_min = MCP_INTF,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:42:25: note: (near initialization for 'mcp23x08_volatile_range')
      42 | #define MCP_INTF        0x07
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:59:22: note: in expansion of macro 'MCP_INTF'
      59 |         .range_min = MCP_INTF,
         |                      ^~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:60:10: error: 'const struct regmap_range' has no member named 'range_max'
      60 |         .range_max = MCP_GPIO,
         |          ^~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: warning: excess elements in struct initializer
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:60:22: note: in expansion of macro 'MCP_GPIO'
      60 |         .range_max = MCP_GPIO,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: note: (near initialization for 'mcp23x08_volatile_range')
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:60:22: note: in expansion of macro 'MCP_GPIO'
      60 |         .range_max = MCP_GPIO,
         |                      ^~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:63:21: error: variable 'mcp23x08_volatile_table' has initializer but incomplete type
      63 | static const struct regmap_access_table mcp23x08_volatile_table = {
         |                     ^~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:64:10: error: 'const struct regmap_access_table' has no member named 'yes_ranges'
      64 |         .yes_ranges = &mcp23x08_volatile_range,
         |          ^~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:64:23: warning: excess elements in struct initializer
      64 |         .yes_ranges = &mcp23x08_volatile_range,
         |                       ^
   drivers/pinctrl/pinctrl-mcp23s08.c:64:23: note: (near initialization for 'mcp23x08_volatile_table')
>> drivers/pinctrl/pinctrl-mcp23s08.c:65:10: error: 'const struct regmap_access_table' has no member named 'n_yes_ranges'
      65 |         .n_yes_ranges = 1,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:65:25: warning: excess elements in struct initializer
      65 |         .n_yes_ranges = 1,
         |                         ^
   drivers/pinctrl/pinctrl-mcp23s08.c:65:25: note: (near initialization for 'mcp23x08_volatile_table')
>> drivers/pinctrl/pinctrl-mcp23s08.c:68:21: error: variable 'mcp23x08_precious_range' has initializer but incomplete type
      68 | static const struct regmap_range mcp23x08_precious_range = {
         |                     ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:69:10: error: 'const struct regmap_range' has no member named 'range_min'
      69 |         .range_min = MCP_GPIO,
         |          ^~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: warning: excess elements in struct initializer
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:69:22: note: in expansion of macro 'MCP_GPIO'
      69 |         .range_min = MCP_GPIO,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: note: (near initialization for 'mcp23x08_precious_range')
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:69:22: note: in expansion of macro 'MCP_GPIO'
      69 |         .range_min = MCP_GPIO,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:70:10: error: 'const struct regmap_range' has no member named 'range_max'
      70 |         .range_max = MCP_GPIO,
         |          ^~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: warning: excess elements in struct initializer
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:70:22: note: in expansion of macro 'MCP_GPIO'
      70 |         .range_max = MCP_GPIO,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: note: (near initialization for 'mcp23x08_precious_range')
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:70:22: note: in expansion of macro 'MCP_GPIO'
      70 |         .range_max = MCP_GPIO,
         |                      ^~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:73:21: error: variable 'mcp23x08_precious_table' has initializer but incomplete type
      73 | static const struct regmap_access_table mcp23x08_precious_table = {
         |                     ^~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:74:10: error: 'const struct regmap_access_table' has no member named 'yes_ranges'
      74 |         .yes_ranges = &mcp23x08_precious_range,
         |          ^~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:74:23: warning: excess elements in struct initializer
      74 |         .yes_ranges = &mcp23x08_precious_range,
         |                       ^
   drivers/pinctrl/pinctrl-mcp23s08.c:74:23: note: (near initialization for 'mcp23x08_precious_table')
   drivers/pinctrl/pinctrl-mcp23s08.c:75:10: error: 'const struct regmap_access_table' has no member named 'n_yes_ranges'
      75 |         .n_yes_ranges = 1,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:75:25: warning: excess elements in struct initializer
      75 |         .n_yes_ranges = 1,
         |                         ^
   drivers/pinctrl/pinctrl-mcp23s08.c:75:25: note: (near initialization for 'mcp23x08_precious_table')
>> drivers/pinctrl/pinctrl-mcp23s08.c:78:14: error: variable 'mcp23x08_regmap' has initializer but incomplete type
      78 | const struct regmap_config mcp23x08_regmap = {
         |              ^~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:79:10: error: 'const struct regmap_config' has no member named 'reg_bits'
      79 |         .reg_bits = 8,
         |          ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:79:21: warning: excess elements in struct initializer
      79 |         .reg_bits = 8,
         |                     ^
   drivers/pinctrl/pinctrl-mcp23s08.c:79:21: note: (near initialization for 'mcp23x08_regmap')
>> drivers/pinctrl/pinctrl-mcp23s08.c:80:10: error: 'const struct regmap_config' has no member named 'val_bits'
      80 |         .val_bits = 8,
         |          ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:80:21: warning: excess elements in struct initializer
      80 |         .val_bits = 8,
         |                     ^
   drivers/pinctrl/pinctrl-mcp23s08.c:80:21: note: (near initialization for 'mcp23x08_regmap')
>> drivers/pinctrl/pinctrl-mcp23s08.c:82:10: error: 'const struct regmap_config' has no member named 'reg_stride'
      82 |         .reg_stride = 1,
         |          ^~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:82:23: warning: excess elements in struct initializer
      82 |         .reg_stride = 1,
         |                       ^
   drivers/pinctrl/pinctrl-mcp23s08.c:82:23: note: (near initialization for 'mcp23x08_regmap')
>> drivers/pinctrl/pinctrl-mcp23s08.c:83:10: error: 'const struct regmap_config' has no member named 'volatile_table'
      83 |         .volatile_table = &mcp23x08_volatile_table,
         |          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:83:27: warning: excess elements in struct initializer
      83 |         .volatile_table = &mcp23x08_volatile_table,
         |                           ^
   drivers/pinctrl/pinctrl-mcp23s08.c:83:27: note: (near initialization for 'mcp23x08_regmap')
>> drivers/pinctrl/pinctrl-mcp23s08.c:84:10: error: 'const struct regmap_config' has no member named 'precious_table'
      84 |         .precious_table = &mcp23x08_precious_table,
         |          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:84:27: warning: excess elements in struct initializer
      84 |         .precious_table = &mcp23x08_precious_table,
         |                           ^
   drivers/pinctrl/pinctrl-mcp23s08.c:84:27: note: (near initialization for 'mcp23x08_regmap')
>> drivers/pinctrl/pinctrl-mcp23s08.c:85:10: error: 'const struct regmap_config' has no member named 'reg_defaults'
      85 |         .reg_defaults = mcp23x08_defaults,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:85:25: warning: excess elements in struct initializer
      85 |         .reg_defaults = mcp23x08_defaults,
         |                         ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:85:25: note: (near initialization for 'mcp23x08_regmap')
>> drivers/pinctrl/pinctrl-mcp23s08.c:86:10: error: 'const struct regmap_config' has no member named 'num_reg_defaults'
      86 |         .num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
         |          ^~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-mcp23s08.c:5:
>> include/linux/kernel.h:56:25: warning: excess elements in struct initializer
      56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/pinctrl/pinctrl-mcp23s08.c:86:29: note: in expansion of macro 'ARRAY_SIZE'
      86 |         .num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
         |                             ^~~~~~~~~~
   include/linux/kernel.h:56:25: note: (near initialization for 'mcp23x08_regmap')
      56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/pinctrl/pinctrl-mcp23s08.c:86:29: note: in expansion of macro 'ARRAY_SIZE'
      86 |         .num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
         |                             ^~~~~~~~~~
>> drivers/pinctrl/pinctrl-mcp23s08.c:87:10: error: 'const struct regmap_config' has no member named 'cache_type'
      87 |         .cache_type = REGCACHE_FLAT,
         |          ^~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:87:23: warning: excess elements in struct initializer
      87 |         .cache_type = REGCACHE_FLAT,
         |                       ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:87:23: note: (near initialization for 'mcp23x08_regmap')
>> drivers/pinctrl/pinctrl-mcp23s08.c:88:10: error: 'const struct regmap_config' has no member named 'max_register'
      88 |         .max_register = MCP_OLAT,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:45:25: warning: excess elements in struct initializer
      45 | #define MCP_OLAT        0x0a
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:88:25: note: in expansion of macro 'MCP_OLAT'
      88 |         .max_register = MCP_OLAT,
         |                         ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:45:25: note: (near initialization for 'mcp23x08_regmap')
      45 | #define MCP_OLAT        0x0a
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:88:25: note: in expansion of macro 'MCP_OLAT'
      88 |         .max_register = MCP_OLAT,
         |                         ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:103:21: error: variable 'mcp23x17_volatile_range' has initializer but incomplete type
     103 | static const struct regmap_range mcp23x17_volatile_range = {
         |                     ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:104:10: error: 'const struct regmap_range' has no member named 'range_min'
     104 |         .range_min = MCP_INTF << 1,
         |          ^~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:42:25: warning: excess elements in struct initializer
      42 | #define MCP_INTF        0x07
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:104:22: note: in expansion of macro 'MCP_INTF'
     104 |         .range_min = MCP_INTF << 1,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:42:25: note: (near initialization for 'mcp23x17_volatile_range')
      42 | #define MCP_INTF        0x07
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:104:22: note: in expansion of macro 'MCP_INTF'
     104 |         .range_min = MCP_INTF << 1,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:105:10: error: 'const struct regmap_range' has no member named 'range_max'
     105 |         .range_max = MCP_GPIO << 1,
         |          ^~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: warning: excess elements in struct initializer
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:105:22: note: in expansion of macro 'MCP_GPIO'
     105 |         .range_max = MCP_GPIO << 1,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: note: (near initialization for 'mcp23x17_volatile_range')
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:105:22: note: in expansion of macro 'MCP_GPIO'
     105 |         .range_max = MCP_GPIO << 1,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:108:21: error: variable 'mcp23x17_volatile_table' has initializer but incomplete type
     108 | static const struct regmap_access_table mcp23x17_volatile_table = {
         |                     ^~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:109:10: error: 'const struct regmap_access_table' has no member named 'yes_ranges'
     109 |         .yes_ranges = &mcp23x17_volatile_range,
         |          ^~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:109:23: warning: excess elements in struct initializer
     109 |         .yes_ranges = &mcp23x17_volatile_range,
         |                       ^
   drivers/pinctrl/pinctrl-mcp23s08.c:109:23: note: (near initialization for 'mcp23x17_volatile_table')
   drivers/pinctrl/pinctrl-mcp23s08.c:110:10: error: 'const struct regmap_access_table' has no member named 'n_yes_ranges'
     110 |         .n_yes_ranges = 1,
         |          ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:110:25: warning: excess elements in struct initializer
     110 |         .n_yes_ranges = 1,
         |                         ^
   drivers/pinctrl/pinctrl-mcp23s08.c:110:25: note: (near initialization for 'mcp23x17_volatile_table')
   drivers/pinctrl/pinctrl-mcp23s08.c:113:21: error: variable 'mcp23x17_precious_range' has initializer but incomplete type
     113 | static const struct regmap_range mcp23x17_precious_range = {
         |                     ^~~~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:114:10: error: 'const struct regmap_range' has no member named 'range_min'
     114 |         .range_min = MCP_INTCAP << 1,
         |          ^~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:43:25: warning: excess elements in struct initializer
      43 | #define MCP_INTCAP      0x08
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:114:22: note: in expansion of macro 'MCP_INTCAP'
     114 |         .range_min = MCP_INTCAP << 1,
         |                      ^~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:43:25: note: (near initialization for 'mcp23x17_precious_range')
      43 | #define MCP_INTCAP      0x08
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:114:22: note: in expansion of macro 'MCP_INTCAP'
     114 |         .range_min = MCP_INTCAP << 1,
         |                      ^~~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:115:10: error: 'const struct regmap_range' has no member named 'range_max'
     115 |         .range_max = MCP_GPIO << 1,
         |          ^~~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: warning: excess elements in struct initializer
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:115:22: note: in expansion of macro 'MCP_GPIO'
     115 |         .range_max = MCP_GPIO << 1,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:44:25: note: (near initialization for 'mcp23x17_precious_range')
      44 | #define MCP_GPIO        0x09
         |                         ^~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:115:22: note: in expansion of macro 'MCP_GPIO'
     115 |         .range_max = MCP_GPIO << 1,
         |                      ^~~~~~~~
   drivers/pinctrl/pinctrl-mcp23s08.c:118:21: error: variable 'mcp23x17_precious_table' has initializer but incomplete type
     118 | static const struct regmap_access_table mcp23x17_precious_table = {
         |                     ^~~~~~~~~~~~~~~~~~~
..


vim +/cy8c95x0_i2c_regmap +390 drivers/pinctrl/pinctrl-cy8c95x0.c

e6cbbe42944de9 Patrick Rudolph 2022-08-16  389  
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @390  static const struct regmap_config cy8c95x0_i2c_regmap = {
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @391  	.reg_bits = 8,
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @392  	.val_bits = 8,
e6cbbe42944de9 Patrick Rudolph 2022-08-16  393  
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @394  	.reg_defaults = cy8c95x0_reg_defaults,
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @395  	.num_reg_defaults = ARRAY_SIZE(cy8c95x0_reg_defaults),
e6cbbe42944de9 Patrick Rudolph 2022-08-16  396  
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @397  	.readable_reg = cy8c95x0_readable_register,
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @398  	.writeable_reg = cy8c95x0_writeable_register,
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @399  	.volatile_reg = cy8c95x0_volatile_register,
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @400  	.precious_reg = cy8c95x0_precious_register,
e6cbbe42944de9 Patrick Rudolph 2022-08-16  401  
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @402  	.cache_type = REGCACHE_FLAT,
e6cbbe42944de9 Patrick Rudolph 2022-08-16 @403  	.max_register = CY8C95X0_COMMAND,
e6cbbe42944de9 Patrick Rudolph 2022-08-16  404  };
e6cbbe42944de9 Patrick Rudolph 2022-08-16  405  

:::::: The code at line 390 was first introduced by commit
:::::: e6cbbe42944de93ba4e0785b4f90d284b1d7cdf6 pinctrl: Add Cypress cy8c95x0 support

:::::: TO: Patrick Rudolph <patrick.rudolph@9elements.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
