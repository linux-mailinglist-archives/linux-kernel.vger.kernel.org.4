Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3B6DB9C2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDHJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHJGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:06:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C0D31B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680944805; x=1712480805;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hpnpvx6xos6iUlaCPN6kP4RigNaZ4dPMBCtAmVawsAM=;
  b=Gt5SHoKiQ9r5WHoykxi5GCJizfp0zsHwDJmyegzHIunFtXYTXkaqngMW
   CYysAKK0m4tNf1JBCMmOLCgCVyLSKehqMT9tgTddLdBhNiDzTCA6JmLQT
   z0X4xJfydsZsdW2ugpHtPYPO/YCF9vNyaDCU7bRtFK1GFfkTOjC75qGFU
   RYkeAf7gMuQaJHRCo/IvJC+Xpo2tCyDRySpLtS/nzTRwwDO+QJO9CzgmL
   +ylIPuwC9PgTdI3jovP6tz/2lLv74EyKDfjjVXLed64ihWjH7UURWQwAK
   hLGWfqo2iXdNC7xvFF6UYI8ncfBT4gWuOgBRxptjCNEvLE0BRB5gKDjl8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408263407"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="408263407"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 02:06:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681244371"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="681244371"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2023 02:06:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pl4Wv-000TZt-25;
        Sat, 08 Apr 2023 09:06:41 +0000
Date:   Sat, 8 Apr 2023 17:06:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: call to
 undeclared function 'LOCHNAGAR1_'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202304081740.35UVR4Ai-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aa318c48808c0aa73216bd94c54c4553d3663add
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   1 year, 1 month ago
config: mips-randconfig-r001-20230408 (https://download.01.org/0day-ci/archive/20230408/202304081740.35UVR4Ai-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pinctrl/cirrus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304081740.35UVR4Ai-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: pasting formed 'LOCHNAGAR1_(', an invalid preprocessing token
   LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:63: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                                        ^
>> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: call to undeclared function 'LOCHNAGAR1_'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^
   <scratch space>:139:1: note: expanded from here
   LOCHNAGAR1_
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:200:1: error: initializer element is not a compile-time constant
   LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:139:1: note: expanded from here
   LOCHNAGAR1_
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:201:1: error: pasting formed 'LOCHNAGAR1_(', an invalid preprocessing token
   LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
   ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:63: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                                        ^
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:201:1: error: initializer element is not a compile-time constant
   LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:2: note: expanded from macro 'LN1_PIN_GPIO'
           LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:46: note: expanded from macro 'LN_PIN_GPIO'
           .name = NAME, .type = LN_PTYPE_GPIO, .reg = LOCHNAGAR##REV##_##REG, \
                                                       ^~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:150:1: note: expanded from here
   LOCHNAGAR1_
   ^
   5 errors generated.


vim +/LOCHNAGAR1_ +200 drivers/pinctrl/cirrus/pinctrl-lochnagar.c

0548448b719ac7 Charles Keepax 2019-03-19  199  
0548448b719ac7 Charles Keepax 2019-03-19 @200  LN1_PIN_GPIO(CDC_RESET,    "codec-reset",    RST,      CDC_RESET,    1);
0548448b719ac7 Charles Keepax 2019-03-19  201  LN1_PIN_GPIO(DSP_RESET,    "dsp-reset",      RST,      DSP_RESET,    1);
0548448b719ac7 Charles Keepax 2019-03-19  202  LN1_PIN_GPIO(CDC_CIF1MODE, "codec-cif1mode", I2C_CTRL, CDC_CIF_MODE, 0);
0548448b719ac7 Charles Keepax 2019-03-19  203  LN1_PIN_MUX(GF_GPIO2,      "gf-gpio2");
0548448b719ac7 Charles Keepax 2019-03-19  204  LN1_PIN_MUX(GF_GPIO3,      "gf-gpio3");
0548448b719ac7 Charles Keepax 2019-03-19  205  LN1_PIN_MUX(GF_GPIO7,      "gf-gpio7");
0548448b719ac7 Charles Keepax 2019-03-19  206  LN1_PIN_MUX(LED1,          "led1");
0548448b719ac7 Charles Keepax 2019-03-19  207  LN1_PIN_MUX(LED2,          "led2");
0548448b719ac7 Charles Keepax 2019-03-19  208  LN1_PIN_AIF(CDC_AIF1);
0548448b719ac7 Charles Keepax 2019-03-19  209  LN1_PIN_AIF(CDC_AIF2);
0548448b719ac7 Charles Keepax 2019-03-19  210  LN1_PIN_AIF(CDC_AIF3);
0548448b719ac7 Charles Keepax 2019-03-19  211  LN1_PIN_AIF(DSP_AIF1);
0548448b719ac7 Charles Keepax 2019-03-19  212  LN1_PIN_AIF(DSP_AIF2);
0548448b719ac7 Charles Keepax 2019-03-19  213  LN1_PIN_AIF(PSIA1);
0548448b719ac7 Charles Keepax 2019-03-19  214  LN1_PIN_AIF(PSIA2);
0548448b719ac7 Charles Keepax 2019-03-19  215  LN1_PIN_AIF(SPDIF_AIF);
0548448b719ac7 Charles Keepax 2019-03-19  216  LN1_PIN_AIF(GF_AIF1);
0548448b719ac7 Charles Keepax 2019-03-19  217  LN1_PIN_AIF(GF_AIF2);
0548448b719ac7 Charles Keepax 2019-03-19  218  LN1_PIN_AIF(GF_AIF3);
0548448b719ac7 Charles Keepax 2019-03-19  219  LN1_PIN_AIF(GF_AIF4);
0548448b719ac7 Charles Keepax 2019-03-19  220  

:::::: The code at line 200 was first introduced by commit
:::::: 0548448b719ac78fa18fdbcd03856952ba6cc7dc pinctrl: lochnagar: Add support for the Cirrus Logic Lochnagar

:::::: TO: Charles Keepax <ckeepax@opensource.cirrus.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
