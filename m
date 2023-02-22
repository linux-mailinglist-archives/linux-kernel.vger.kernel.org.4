Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4E169EDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjBVEeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjBVEeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:34:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F91F4A7;
        Tue, 21 Feb 2023 20:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677040445; x=1708576445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l6eOsNz/yXzKCDr46auBkAcDilH/phLT1LbE7xDWqZo=;
  b=QAqoEdAIfvoAjsYQBBQLmf8laUOnPa6Y3totBJpR2gH3xalgj2k39y9m
   lSejF5xvjsrD8UZkC9kn7tlFDJEkGV+sMKQH35YDJFSPuYQU6y/aezbp3
   HzoCSENOmP6bNMOTGpevuw+1Wvv6goZ/ti8i/VrUH0+KSp/1l3/jjNzii
   gciEKGh1auGowLfUUJNFNUjC/TH1c56Mr9pbzASto7n/7ySMIoNGSspKM
   IYHeFKQEigQhczmokPVp58pnV3V8T+3fnExclPTWDHNc3F/Uw5UUv6pwv
   wqK5JAPvVZRu1v9AzKi1S4wPEkXx5+HOqZHe8tdSksqJuOBh43wZMfXdV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="316559332"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="316559332"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 20:34:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="795762568"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="795762568"
Received: from lkp-server01.sh.intel.com (HELO eac18b5d7d93) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2023 20:34:02 -0800
Received: from kbuild by eac18b5d7d93 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUgpN-0000c5-2r;
        Wed, 22 Feb 2023 04:34:01 +0000
Date:   Wed, 22 Feb 2023 12:33:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34:
 warning: unused variable 'c8sectpfe_match'
Message-ID: <202302221244.snmk4mKq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5b7c4cabbb65f5c469464da6c5f614cbd7f730f2
commit: e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2 media: platform: place stm32/ and sti/ under st/ dir
date:   11 months ago
config: hexagon-randconfig-r023-20230222 (https://download.01.org/0day-ci/archive/20230222/202302221244.snmk4mKq-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/st/sti/c8sectpfe/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302221244.snmk4mKq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34: warning: unused variable 'c8sectpfe_match' [-Wunused-const-variable]
   static const struct of_device_id c8sectpfe_match[] = {
                                    ^
   1 warning generated.


vim +/c8sectpfe_match +1175 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c

c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1174  
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30 @1175  static const struct of_device_id c8sectpfe_match[] = {
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1176  	{ .compatible = "st,stih407-c8sectpfe" },
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1177  	{ /* sentinel */ },
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1178  };
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1179  MODULE_DEVICE_TABLE(of, c8sectpfe_match);
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1180  

:::::: The code at line 1175 was first introduced by commit
:::::: c5f5d0f99794cfb675ecacfe37a1b33b352b9752 [media] c8sectpfe: STiH407/10 Linux DVB demux support

:::::: TO: Peter Griffin <peter.griffin@linaro.org>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
