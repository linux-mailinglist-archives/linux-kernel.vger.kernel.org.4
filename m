Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95F5BE0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiITIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiITIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:54:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B7B6B8E5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663664055; x=1695200055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lWATD4E8cke1MAacqKuanLY1ISCYiVkla0w3ukWrszY=;
  b=a2tj/l0pbIY1dpPf79+teL8HHsGb1ttAic9S9GGn/6PehtlTzT6EDG+2
   4inkU3CdHUGXlE2Wa7ey57zrXc5hfNf0GH/9I73tcBo05DiKNEU2QrAOU
   sNUn1j3QZlcL7YxVR1jrMJUd8tObJUyAZtBmuiWMXQapAtix5808064ij
   hqRBiRVTsTw/64wpkgySXGIsLsLTHl5GrxpMEEdnsRk8LpZrjEFyL2Xvk
   VSGcDMmu5La68rs7XfXzGAq74cXJGumr5Twk4hOJC3MMt60A+wo9nVyxz
   vq8KXYxWQVq+QoTox82xYirenjmDf/mBMQjgEMkK+KVFVOuU10B+uAYWM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="297231660"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="297231660"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 01:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="687323018"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2022 01:54:13 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaZ1B-0002d7-11;
        Tue, 20 Sep 2022 08:54:13 +0000
Date:   Tue, 20 Sep 2022 16:53:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 3/3]
 drivers/char/random.c:164:42: error: expected declaration specifiers or
 '...' before '_vdso_rng_data'
Message-ID: <202209201604.aAX4Shb6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   a7b31acb923dbd25e7bf030ca209f131c31f5288
commit: a7b31acb923dbd25e7bf030ca209f131c31f5288 [3/3] random: implement getrandom() in vDSO
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220920/202209201604.aAX4Shb6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a7b31acb923dbd25e7bf030ca209f131c31f5288
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout a7b31acb923dbd25e7bf030ca209f131c31f5288
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/char/random.c:164:42: error: expected declaration specifiers or '...' before '_vdso_rng_data'
     164 | DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
         |                                          ^~~~~~~~~~~~~~


vim +164 drivers/char/random.c

   146	
   147	#define warn_unseeded_randomness() \
   148		if (IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) && !crng_ready()) \
   149			printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n", \
   150					__func__, (void *)_RET_IP_, crng_init)
   151	
   152	
   153	
   154	/********************************************************************
   155	 *
   156	 * VDSO support helpers.
   157	 *
   158	 * The actual vDSO function is defined over in lib/vdso/getrandom.c,
   159	 * but this section contains the kernel-mode helpers to support that.
   160	 *
   161	 ********************************************************************/
   162	
   163	/* The shared data page. */
 > 164	DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
   165	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
