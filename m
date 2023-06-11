Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C20272B366
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjFKSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 14:22:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA314E0;
        Sun, 11 Jun 2023 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686507734; x=1718043734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JosYZ1w32FavBPJhjuWEPL3E+KwkzHnBY2mI/c/Kob4=;
  b=gSRfZ3UPoXy8gOZO9JGHGqY6F8+5HpBzNQljFsf5kHWfobxQ22vnmR06
   aNXHVIDIUWlRn16vTMrR7A/jFZpRShhKlpc8/czbhcPPLyQIKrhzY1cXt
   BHGVtT4dseSzlp5DWJ8piTxFQJqUC5lw0mjDxxy/BJ9XoGT9HeOLctmTM
   Kp3fKlpYmut/QTPOE48FqjAGlhGfNDFWI1GxrKJ90PVrb6rQ/pK3VyhE6
   eZ091vxnlVgIc645gpm0+0HvhikWR8hMJrH4c+Yp3NFqbcvsgjgd+NSta
   j+XW0hE7xCBp987xhu31LxKO1FrAViw2aoHZCDMlxBmUfJiN8DLWN4hk+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="360377240"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="360377240"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 11:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="1041082658"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="1041082658"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2023 11:22:12 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8Phc-000B2h-0Y;
        Sun, 11 Jun 2023 18:22:12 +0000
Date:   Mon, 12 Jun 2023 02:22:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Roith <johannes@gnu-linux.rocks>, jikos@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Johannes Roith <johannes@gnu-linux.rocks>
Subject: Re: [PATCH] hid-mcp2200 added driver for MCP2200 GPIOs
Message-ID: <202306120229.FSzdnoEl-lkp@intel.com>
References: <20230611144831.41238-1-johannes@gnu-linux.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611144831.41238-1-johannes@gnu-linux.rocks>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.4-rc5]
[also build test ERROR on linus/master next-20230609]
[cannot apply to hid/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Roith/hid-mcp2200-added-driver-for-MCP2200-GPIOs/20230611-225658
base:   v6.4-rc5
patch link:    https://lore.kernel.org/r/20230611144831.41238-1-johannes%40gnu-linux.rocks
patch subject: [PATCH] hid-mcp2200 added driver for MCP2200 GPIOs
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230612/202306120229.FSzdnoEl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git checkout v6.4-rc5
        b4 shazam https://lore.kernel.org/r/20230611144831.41238-1-johannes@gnu-linux.rocks
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306120229.FSzdnoEl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hid/hid-mcp2200.c:16:
>> drivers/hid/hid-mcp2200.c:403:51: error: 'USB_DEVICE_ID_MCP2200' undeclared here (not in a function); did you mean 'USB_DEVICE_ID_MCP2221'?
     403 |         { HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_MCP2200) },
         |                                                   ^~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:715:54: note: in definition of macro 'HID_USB_DEVICE'
     715 |         .bus = BUS_USB, .vendor = (ven), .product = (prod)
         |                                                      ^~~~


vim +403 drivers/hid/hid-mcp2200.c

   401	
   402	static const struct hid_device_id mcp2200_devices[] = {
 > 403		{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_MCP2200) },
   404		{ }
   405	};
   406	MODULE_DEVICE_TABLE(hid, mcp2200_devices);
   407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
