Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58B72B36F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 20:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjFKSnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 14:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjFKSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 14:43:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3A186;
        Sun, 11 Jun 2023 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686508996; x=1718044996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YdwCCgbADbXT01unvU1wjmv/vlQFvLbEBBGUBiYSR0I=;
  b=f24/6+qjaGUS8DIxclGhYNskSVJraRGrJWLCG8RmDnpEEYEtjH94DFSB
   ywhJ1pOdVmN/r5oh/DDQ98Y5qr7xCn1LfwTtzjsqv4OqNMqyc85vHAg/Z
   4A6u2LqiA3m2zpYc3g89lfkHFR2fIVglCEK+Ho5ldA6vG4WynGNm6TrL6
   VvcoAA8UTrrgD1WG673L2rIMpfAB81HKPYith2dge04j8+OMZdaTzbe+C
   RnaARXqQ3dZKUF0cB7HUzozoPWdzbVDzdaNZJE/cqx/oDTwDrdEs5MH5L
   Hr2XHL39MoTVUz4gcNizdah60iRKDfT+ylsvvhUAuS9DdMohkzxdDLqIY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="338255284"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="338255284"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 11:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="710955278"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="710955278"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2023 11:43:13 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8Q1w-000B3T-2N;
        Sun, 11 Jun 2023 18:43:12 +0000
Date:   Mon, 12 Jun 2023 02:43:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Roith <johannes@gnu-linux.rocks>, jikos@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Roith <johannes@gnu-linux.rocks>
Subject: Re: [PATCH 1/2] hid-mcp2200 added driver for MCP2200 GPIOs
Message-ID: <202306120239.maB0RzPe-lkp@intel.com>
References: <20230611164811.1388-1-johannes@gnu-linux.rocks>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611164811.1388-1-johannes@gnu-linux.rocks>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Roith/hid-mcp2200-updated-hid-id-h/20230612-005025
base:   v6.4-rc5
patch link:    https://lore.kernel.org/r/20230611164811.1388-1-johannes%40gnu-linux.rocks
patch subject: [PATCH 1/2] hid-mcp2200 added driver for MCP2200 GPIOs
config: x86_64-buildonly-randconfig-r003-20230612 (https://download.01.org/0day-ci/archive/20230612/202306120239.maB0RzPe-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout v6.4-rc5
        b4 shazam https://lore.kernel.org/r/20230611164811.1388-1-johannes@gnu-linux.rocks
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306120239.maB0RzPe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/hid-mcp2200.c:403:44: error: use of undeclared identifier 'USB_DEVICE_ID_MCP2200'
           { HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_MCP2200) },
                                                     ^
   1 error generated.


vim +/USB_DEVICE_ID_MCP2200 +403 drivers/hid/hid-mcp2200.c

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
