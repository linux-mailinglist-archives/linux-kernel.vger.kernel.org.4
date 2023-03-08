Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF976AFAF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCHASd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCHASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:18:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0291B6E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678234709; x=1709770709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=di/9HUnuj8uzO77E88cy0/RZwwC81iKn3Gh8NS9VTQA=;
  b=ELDF4KBe6tsPdwLI5QFCXYLA0BnG59FneJyg7UacmvRWx4Ery77MMdDA
   C301eR3TsOVZjRHFiXVXgifMC7Zw+J2hBfXs53fKFLIm660MRDcye4QhB
   9DYDTdBSP1YeuLcfXwpy8CMc4Sw3wiPxbff7WPcuAJxfzRXsQauS/mpbG
   gDGbRIxAD11kvjzw4FsMfi9E9UtmpviFG1uq11eOUy/aDN5qCHv1fXPOD
   7iOzi7bWltsxwXAIeoW0Q+C0ybgfBSpn9gedAnsQA4vW/a8pkCd93uvBT
   SZBsXlLsPAq82fFMKRoaVumi7+BcWs4owYuHh6uIx/bdx4odzMVS6ePzh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422283086"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="422283086"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 16:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679141139"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="679141139"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2023 16:18:27 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZhVi-0001hf-2g;
        Wed, 08 Mar 2023 00:18:26 +0000
Date:   Wed, 8 Mar 2023 08:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/clk-asm9260.c:258:17: warning: variable 'hw' set but not
 used
Message-ID: <202303080821.z9JgOLfB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   63355b9884b3d1677de6bd1517cd2b8a9bf53978
commit: f5290d8e4f0caa81a491448a27dd70e726095d07 clk: asm9260: use parent index to link the reference clock
date:   5 months ago
config: arm-randconfig-r046-20230307 (https://download.01.org/0day-ci/archive/20230308/202303080821.z9JgOLfB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202303080821.z9JgOLfB-lkp@intel.com/

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
