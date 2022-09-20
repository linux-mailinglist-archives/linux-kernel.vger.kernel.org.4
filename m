Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5F5BF056
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiITWl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiITWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:41:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1959E5F7D4;
        Tue, 20 Sep 2022 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663713714; x=1695249714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9oRYIY/0P4/wRclJhpAT7JXzjpH5eB6xLUCqXF0c+o=;
  b=e0N6oZtS17zIft38T/7oJ5bDMCsUqczd7NeRoPaFtoETbZDu2fEqDMY9
   9j2JTOSyGHwN9gZk9rIEsb4W7SRdK1Ara91/ZdZbbDIgcwtkmUdKHj/gN
   kgj//OyjpP1gk36Wi3ZGBtC7NMpMMKnRmEgtMgp8aS+N1kjhpVfKXAqtk
   rZMALKW4d7EBVsxhlarfTvEktSQCtl7RtZrPe2ulqoXL0fiUyYqCoCB4h
   xrUWX2VucwijfIYEjbePPl1i5jiyWTNFXsKtLu/x0au89vQJFbDJUVKA9
   WK52Hvvj1dg51okFnXoYlWUe7buvsrpaM7lBHaKvRDtRB8dS2xRw90rXM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="361592913"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="361592913"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="761493313"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2022 15:41:50 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oalw6-000312-03;
        Tue, 20 Sep 2022 22:41:50 +0000
Date:   Wed, 21 Sep 2022 06:41:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v1 2/2] media: uvcvideo: Use standard names for menus
Message-ID: <202209210624.LFgi79pj-lkp@intel.com>
References: <20220920-standard-menues-v1-2-839799192e9d@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-standard-menues-v1-2-839799192e9d@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220921/202209210624.LFgi79pj-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/usb/uvc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/usb/uvc/uvc_driver.c:2664:35: warning: unused variable 'power_line_frequency_controls_limited' [-Wunused-const-variable]
   static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
                                     ^
   1 warning generated.


vim +/power_line_frequency_controls_limited +2664 drivers/media/usb/uvc/uvc_driver.c

310fe52461e624 drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2009-12-09  2659  
c0efd232929c2c drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2660  /* ------------------------------------------------------------------------
c0efd232929c2c drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2661   * Driver initialization and cleanup
c0efd232929c2c drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2662   */
c0efd232929c2c drivers/media/video/uvc/uvc_driver.c Laurent Pinchart 2008-06-30  2663  
382075604a688b drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07 @2664  static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
382075604a688b drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2665  	{ 1, "50 Hz" },
382075604a688b drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2666  	{ 2, "60 Hz" },
382075604a688b drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2667  };
382075604a688b drivers/media/usb/uvc/uvc_driver.c   Ricardo Ribalda  2022-06-07  2668  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
