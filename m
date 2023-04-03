Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468EF6D527B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjDCUa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjDCUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:30:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A341FD6;
        Mon,  3 Apr 2023 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680553823; x=1712089823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EcOqH8rFyT8HPSn+yeefQShJNsBgbYmHIy+MLCwtPjc=;
  b=Edasw2msBB6hatIBqgYqycYhDX8OLB2dQdyUFEuRCmikt/Bay/2U7mzk
   VDun/+hi43fvtLiHyhGf7EUahHMqQjwue46+6UwWW2daus9Gc38Dh936J
   QyN45d02EHcOPuOIZiSptZFGPm1xIYMYKqnjdLfYhVQQXE4BAQUiPnuaj
   0pTE9p87Ws/JNEZ1vTSG8LP2jVacHIPoLNChqx2hqKPN49t0BoIdKZdDF
   uLxxof02G4C/Qzj+XPLNXpXcIqDe3fmNGAZiUpwI7X7cUAwgaY6uAp4Jr
   s0JjeQp79r1ogx0WJwOs+Yh/3qHL9zVgr5UzkcusZPPMZsKqmQwNqJ4JS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404763450"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="404763450"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 13:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="932177305"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="932177305"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Apr 2023 13:29:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjQo7-000Omq-0G;
        Mon, 03 Apr 2023 20:29:39 +0000
Date:   Tue, 4 Apr 2023 04:29:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/intel/pxa_camera.c:2449:34: warning: unused
 variable 'pxa_camera_of_match'
Message-ID: <202304040458.GiRjp5l2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   148341f0a2f53b5e8808d093333d85170586a15d
commit: 95495f2aa9d8df1a7697bab24118544d3568f41d media: platform: place Intel drivers on a separate dir
date:   1 year, 1 month ago
config: hexagon-randconfig-r045-20230403 (https://download.01.org/0day-ci/archive/20230404/202304040458.GiRjp5l2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95495f2aa9d8df1a7697bab24118544d3568f41d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 95495f2aa9d8df1a7697bab24118544d3568f41d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304040458.GiRjp5l2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/intel/pxa_camera.c:2449:34: warning: unused variable 'pxa_camera_of_match' [-Wunused-const-variable]
   static const struct of_device_id pxa_camera_of_match[] = {
                                    ^
   1 warning generated.


vim +/pxa_camera_of_match +2449 drivers/media/platform/intel/pxa_camera.c

7254026cedd42d drivers/media/video/pxa_camera.c               Guennadi Liakhovetski 2011-06-29  2448  
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29 @2449  static const struct of_device_id pxa_camera_of_match[] = {
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2450  	{ .compatible = "marvell,pxa270-qci", },
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2451  	{},
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2452  };
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2453  MODULE_DEVICE_TABLE(of, pxa_camera_of_match);
e9a1d94fa85542 drivers/media/platform/soc_camera/pxa_camera.c Robert Jarzmik        2014-06-29  2454  

:::::: The code at line 2449 was first introduced by commit
:::::: e9a1d94fa85542d4f3046ac82d234a3c8349c948 [media] media: pxa_camera device-tree support

:::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
:::::: CC: Mauro Carvalho Chehab <m.chehab@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
