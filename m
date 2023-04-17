Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BEF6E3EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDQFGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDQFGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:06:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A12F171D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681708002; x=1713244002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UDDopr66OsEgnSYquxK5eIR0C0VPS0YpkRdk3HoVf/Q=;
  b=I1ddWaUDKiLTtAMI746PcRLxTV7mBqL1pY24tcAbZ6ozxEZcg/RPpGNE
   9CcHYASV8qs8nwgxLNsq5hNE72DRU3MGztp/vn1EJJVGnY5sIGM54C7LZ
   TK+sA9inMmHr4ftOoKjQjXXgyYFas8U9GuEyK4v+Az7vHzQUmObu4+C+L
   E8BjZhjeS4HQeZjZBCcz/2NF5mS25gUO+jnXeUYYil7arNjkRB5eBatfM
   ILU7r6Yur20AWLfjIF/bqv8Ep1VlTxOdFgiXpsyb7bU6yqZi1tdvW5Aw6
   kiXIBfm5q/U9eU2oI52MHWjGJayrz9XRJUsWvg5kzZ0EQCEqcAvfKosLI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="410019525"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="410019525"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 22:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="690515686"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="690515686"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2023 22:06:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poH4U-000c8X-1F;
        Mon, 17 Apr 2023 05:06:34 +0000
Date:   Mon, 17 Apr 2023 13:05:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/clk-asm9260.c:258:17: warning: variable 'hw' set but not
 used
Message-ID: <202304171233.h0vn6dH5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
commit: f5290d8e4f0caa81a491448a27dd70e726095d07 clk: asm9260: use parent index to link the reference clock
date:   7 months ago
config: arm-randconfig-r025-20230416 (https://download.01.org/0day-ci/archive/20230417/202304171233.h0vn6dH5-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f5290d8e4f0caa81a491448a27dd70e726095d07
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f5290d8e4f0caa81a491448a27dd70e726095d07
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304171233.h0vn6dH5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-asm9260.c:258:17: warning: variable 'hw' set but not used [-Wunused-but-set-variable]
           struct clk_hw *hw, *pll_hw;
                          ^
   1 warning generated.


vim +/hw +258 drivers/clk/clk-asm9260.c

   255	
   256	static void __init asm9260_acc_init(struct device_node *np)
   257	{
 > 258		struct clk_hw *hw, *pll_hw;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
