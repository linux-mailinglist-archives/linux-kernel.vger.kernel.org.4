Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6ED5BF05C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiITWl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiITWlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:41:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391045FF76;
        Tue, 20 Sep 2022 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663713712; x=1695249712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ML1kL+DwyaMLsiNuwTUsvnxVCHL1YwT35T1Ppm26GCs=;
  b=nqLInOtB+Oh+ZH0/N9DYnLz/m+fAqo6PSsE1jAt1374DUSBlkYJGAC+Z
   LE9vR1SeQDNDX6Fkp0cicqZfGWa2Qfbn++8mhxTer7GAVHp8CVMxan0F8
   kFq01uvwG9+M6ROf+yz2508u0OEMqCcwUupkTCp5DCT2RlC3esbkAIQ4t
   6mn5O5XVdTk3H1eI+eGZxZ7ZcVLqmIKQydZtR1CLYaOV3kyA5M7V7+awV
   lGVDucUSNG3OK5UBYFJFA55vOv7YGk5vc32SgrPaeaTDLu/g2DitojiJ8
   0OFnS5mnbIMfJnLsFmcyJRfEpO7MOR7a2fPqNhqkyiXWX57wsLw8xBqbc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="326147170"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="326147170"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="687608812"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2022 15:41:50 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oalw5-00030z-1h;
        Tue, 20 Sep 2022 22:41:49 +0000
Date:   Wed, 21 Sep 2022 06:41:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v1 2/2] media: uvcvideo: Use standard names for menus
Message-ID: <202209210616.5XZvYu7j-lkp@intel.com>
References: <20220920-standard-menues-v1-2-839799192e9d@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-standard-menues-v1-2-839799192e9d@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 521a547ced6477c54b4b0cc206000406c221b4d6]

url:    https://github.com/intel-lab-lkp/linux/commits/Ricardo-Ribalda/media-uvc-Get-menu-names-from-framework/20220920-221725
base:   521a547ced6477c54b4b0cc206000406c221b4d6
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220921/202209210616.5XZvYu7j-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6f853c5bf3837302050a20e9142196ccb12a2918
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ricardo-Ribalda/media-uvc-Get-menu-names-from-framework/20220920-221725
        git checkout 6f853c5bf3837302050a20e9142196ccb12a2918
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/usb/uvc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/usb/uvc/uvc_driver.c:2664:35: warning: unused variable 'power_line_frequency_controls_limited' [-Wunused-const-variable]
   static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
                                     ^
   1 warning generated.


vim +/power_line_frequency_controls_limited +2664 drivers/media/usb/uvc/uvc_driver.c

310fe52461e6244 drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2009-12-09  2659  
c0efd232929c2cd drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2660  /* ------------------------------------------------------------------------
c0efd232929c2cd drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2661   * Driver initialization and cleanup
c0efd232929c2cd drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2662   */
c0efd232929c2cd drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2663  
382075604a688b9 drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07 @2664  static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
382075604a688b9 drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2665  	{ 1, "50 Hz" },
382075604a688b9 drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2666  	{ 2, "60 Hz" },
382075604a688b9 drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2667  };
382075604a688b9 drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2668  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
