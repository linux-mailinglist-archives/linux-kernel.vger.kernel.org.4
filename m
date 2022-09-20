Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21735BE426
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiITLK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiITLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:10:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA001AA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663672237; x=1695208237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=80y+q0JiEdas7X98PzVvtBdWd1gT4rNB5lAGu7PbxlY=;
  b=Z4NeU4UF3GZPK3yeaO7DGaYP+NGCIyvTP4AQHennsf0pUzWgo3ayMhMW
   581Jz9bFzoFNlRi0asHQa3yxS7sPS0TdhHQwo+TUKCcM1DWc+CTsXNwzY
   WFagvuCzfego0qjUUTSv73z2pI0oqRim9xPF3u4AMhIJi7yXykV97ugkd
   POrfRSfgXtKdkCp+qgMy7RrHaF5D7lISYcnn5Xffcg6sFocftEZO+xkrS
   0emz9y+KozsWEqrlpC4cu1/9+Nm8hSyG9OMjy5YNumDk0g4nSAFpcDIp2
   PxtrwfURaX+Ahgn7l3gyqaS88x58FsD0dgHLo58w5iJB1DYeSoKbgIy/u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299654405"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="299654405"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 04:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="687372297"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2022 04:10:35 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oab99-0002i7-0C;
        Tue, 20 Sep 2022 11:10:35 +0000
Date:   Tue, 20 Sep 2022 19:09:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 3/3]
 drivers/char/random.c:164:42: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
Message-ID: <202209201907.0qM7YdXh-lkp@intel.com>
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
config: arm64-buildonly-randconfig-r005-20220919 (https://download.01.org/0day-ci/archive/20220920/202209201907.0qM7YdXh-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/a7b31acb923dbd25e7bf030ca209f131c31f5288
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout a7b31acb923dbd25e7bf030ca209f131c31f5288
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/char/random.c:164:42: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
                                            ^
                                            int
   drivers/char/random.c:164:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
   ^
   int
   2 errors generated.


vim +/int +164 drivers/char/random.c

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
