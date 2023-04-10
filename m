Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7847A6DC6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDJMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:30:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02AC4C02;
        Mon, 10 Apr 2023 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681129832; x=1712665832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xTNMqP9V7CQ48ZNNKWu1cdBcoEVxlmaDDLYgIS6kzr0=;
  b=XK6sLNyPDi7RvCOZfsNHrvQkPxe5TYj+mjwq5QEx8XA0FzyDA+Z9XSPV
   Ss84MRv6WOoFiTnvWT86Izewc4QS84Z6sBCsIiZXckE6dvhM1CfZ0M0My
   bQevewSx68fVuNIiUsNreN1gL5MzmD65gbmZEX+BRzesj9mIz0wrdJPCM
   MVWKCMKBlNDgnKQKGD0ZGs0Y4mOZLuuR54IGFqEP0ckhE67EouVKV9of0
   zZcQTBMbgBNj5MT+tWVqlRGG97B2P1daMpiLPPzN414xLY+J6hdvM3ZRW
   t7hnsjDNRbyP6B+sQ3g/Svd4dBUY16ixFZkn3SSkaQw0mdXA+1H2/VVJr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="371180678"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="371180678"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 05:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="862491683"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="862491683"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2023 05:30:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plqf8-000VN9-2j;
        Mon, 10 Apr 2023 12:30:22 +0000
Date:   Mon, 10 Apr 2023 20:30:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mubashshir <ahmubashshir@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Huseyin BIYIK <huseyinbiyik@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] staging: HID: Add ShanWan USB WirelessGamepad driver
Message-ID: <202304102017.yQ3YHaXX-lkp@intel.com>
References: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mubashshir,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Mubashshir/staging-HID-Add-ShanWan-USB-WirelessGamepad-driver/20230410-172120
patch link:    https://lore.kernel.org/r/39b44678dc54b519fa469b69d80757b36ab3cf25.1681118245.git.ahmubashshir%40gmail.com
patch subject: [PATCH] staging: HID: Add ShanWan USB WirelessGamepad driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230410/202304102017.yQ3YHaXX-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bdfd2a839da337ac583bfa8ae2cb19f0388619b8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mubashshir/staging-HID-Add-ShanWan-USB-WirelessGamepad-driver/20230410-172120
        git checkout bdfd2a839da337ac583bfa8ae2cb19f0388619b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304102017.yQ3YHaXX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/module.h:22,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/input.h:19,
                    from drivers/hid/hid-shanwan.c:28:
>> include/linux/moduleparam.h:24:9: error: expected ',' or ';' before 'static'
      24 |         static const char __UNIQUE_ID(name)[]                             \
         |         ^~~~~~
   include/linux/module.h:165:32: note: in expansion of macro '__MODULE_INFO'
     165 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
         |                                ^~~~~~~~~~~~~
   include/linux/module.h:238:42: note: in expansion of macro 'MODULE_INFO'
     238 | #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
         |                                          ^~~~~~~~~~~
   drivers/hid/hid-shanwan.c:255:1: note: in expansion of macro 'MODULE_DESCRIPTION'
     255 | MODULE_DESCRIPTION("Force feedback support for Shanwan USB WirelessGamepad");
         | ^~~~~~~~~~~~~~~~~~


vim +24 include/linux/moduleparam.h

730b69d2252595 Rusty Russell  2008-10-22  22  
^1da177e4c3f41 Linus Torvalds 2005-04-16  23  #define __MODULE_INFO(tag, name, info)					  \
34182eea36fc1d Rusty Russell  2012-11-22 @24  	static const char __UNIQUE_ID(name)[]				  \
2aec389e19150e Johan Hovold   2020-11-23  25  		__used __section(".modinfo") __aligned(1)		  \
898490c010b5d2 Alexey Gladkov 2019-04-29  26  		= __MODULE_INFO_PREFIX __stringify(tag) "=" info
898490c010b5d2 Alexey Gladkov 2019-04-29  27  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
