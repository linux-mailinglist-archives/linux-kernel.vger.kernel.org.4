Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862635B3CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiIIQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIIQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:08:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110DB12D198
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662739725; x=1694275725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CxuqDsK69r+BdtnK2KOYHnsVv+VzjAn8ftMBvZNzMtM=;
  b=CkQz/9CZWYDc+viAx0LORCsxE4i9+wbaoOvTnETsxv33tSMNQd9+cWfs
   RQna5aS6s53yI+C/TyTzmybg43bUOl7B0SkgO3kxSH0g9LbbjDXKOh+uc
   LK8UQrilo6tjnB4o2XKSBRCtf9EDI6GGF1L38Ul8oB12Bd8mXIidtM0pt
   EfOdmmqqlTQ1SAfFYbbHyugkrBzgpr2+O0Q5MEITJwIsriIRhrwpiO1H0
   BQGsEsoYnaD/yvHHyVW9rnH7/wgSoLoNyIZkLxBRcUPM/sYemS2CeHd0e
   qyST8khfj9sQkAnkl0Z4TAtY8CAqtHqU2T5t0PlN/7oG68w1Gzxa1CgDx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="297508356"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="297508356"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="790857492"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Sep 2022 09:08:43 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWgYX-0001Ph-2x;
        Fri, 09 Sep 2022 16:08:37 +0000
Date:   Sat, 10 Sep 2022 00:07:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:apq8060-dragonboard-graphics 6/7]
 drivers/gpu/drm/panel/panel-auo-h361vl01.c:6:10: fatal error: drm/drmP.h: No
 such file or directory
Message-ID: <202209092309.SIUbFDQJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git apq8060-dragonboard-graphics
head:   61e660dc7aae5759c37e60bcdadaac11186e2115
commit: f71c3d68029aee0d2ef418e8660ba9b28e029786 [6/7] drm/panel: Add driver form AUO H361VL01
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220909/202209092309.SIUbFDQJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=f71c3d68029aee0d2ef418e8660ba9b28e029786
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator apq8060-dragonboard-graphics
        git checkout f71c3d68029aee0d2ef418e8660ba9b28e029786
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/drm/panel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/panel/panel-auo-h361vl01.c:6:10: fatal error: drm/drmP.h: No such file or directory
       6 | #include <drm/drmP.h>
         |          ^~~~~~~~~~~~
   compilation terminated.


vim +6 drivers/gpu/drm/panel/panel-auo-h361vl01.c

     5	
   > 6	#include <drm/drmP.h>
     7	#include <drm/drm_panel.h>
     8	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
