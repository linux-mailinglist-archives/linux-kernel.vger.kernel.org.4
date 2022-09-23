Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6101C5E829F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiIWTpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiIWTpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:45:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538A98A6E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663962305; x=1695498305;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rvMaEnnDfV0eR04REb0kqB7qVMdo6Smwhj5xMuMIRtg=;
  b=GaB32Px9LeU9Myb1EuABEdD/1l0lmfF6EgDfZ1u78tfPsMJSeCfrOdJU
   fJBwj9ikmltZV7pqkXan3x2jVoRUxv/f+KUaOsS7jOuu0gFMynKDmZak0
   CyUTgRA0uY4wXj0U5AHZyYJr7y5OE6TVQ6JAGlX0+nwAXtZ2gaRYiESEb
   5pSHVPsrn8X9TiPhDT56WVXi+cBTs9aYcFXTCb2q2nAWnUXbn4WZEu1yJ
   SNRlWfegEjQ148UEk0GQK8GKYXH9SqtXfSF6vXLhF5wcQI+f9kycZPraY
   8rA2af6sGAQMPWSExv03S93dginv3RFbz2QYm+129s1XMhD2Iq2o7Wwj4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="281044220"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="281044220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 12:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="651073636"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2022 12:45:03 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obobe-0005tM-2I;
        Fri, 23 Sep 2022 19:45:02 +0000
Date:   Sat, 24 Sep 2022 03:44:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.19 22/33]
 drivers/usb/dwc3/dwc3-qcom.c:313:25: warning: variable 'hcd' set but not
 used
Message-ID: <202209240308.kzupccnl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.19
head:   9888f771c3a964ede02767e7e913ede0d1d44f0e
commit: f5bcd98c2411532e84a225f26b235a1cdd2cb9c7 [22/33] usb: dwc3: qcom: fix peripheral and OTG suspend
config: csky-randconfig-r021-20220924 (https://download.01.org/0day-ci/archive/20220924/202209240308.kzupccnl-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=f5bcd98c2411532e84a225f26b235a1cdd2cb9c7
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.19
        git checkout f5bcd98c2411532e84a225f26b235a1cdd2cb9c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/usb/dwc3/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/dwc3/dwc3-qcom.c: In function 'dwc3_qcom_read_usb2_speed':
>> drivers/usb/dwc3/dwc3-qcom.c:313:25: warning: variable 'hcd' set but not used [-Wunused-but-set-variable]
     313 |         struct usb_hcd *hcd;
         |                         ^~~


vim +/hcd +313 drivers/usb/dwc3/dwc3-qcom.c

   308	
   309	static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
   310	{
   311		struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
   312		struct usb_device *udev;
 > 313		struct usb_hcd *hcd;
   314	
   315		/*
   316		 * FIXME: Fix this layering violation.
   317		 */
   318		hcd = platform_get_drvdata(dwc->xhci);
   319	
   320		/*
   321		 * It is possible to query the speed of all children of
   322		 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
   323		 * currently supports only 1 port per controller. So
   324		 * this is sufficient.
   325		 */
   326	#ifdef CONFIG_USB
   327		udev = usb_hub_find_child(hcd->self.root_hub, 1);
   328	#else
   329		udev = NULL;
   330	#endif
   331		if (!udev)
   332			return USB_SPEED_UNKNOWN;
   333	
   334		return udev->speed;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
