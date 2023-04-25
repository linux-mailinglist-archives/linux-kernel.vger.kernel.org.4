Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17C6EE952
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjDYVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDYVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:03:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BEC16F2F;
        Tue, 25 Apr 2023 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682456586; x=1713992586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jw66GbpVDrNQLpIB5E1F9gDZmk+UiU7wloECDprBEi0=;
  b=PT8wfXujAkAeowdCA8BYMXFqcejBycN1eGaNXFjrQYAlumG3N3hieLJ8
   P03dJgbQ63VsKuskjQ6Edpzrp5g+9IZ7MT9RghIvXb2N8nu1+5lRH5k+p
   ULtLhylfVmYrYQ5cspAvIlivX0Y/mZiywD9XAiWAMN49CD5j9GLmjPACQ
   W1MfKlSZagYxXa/S2+aGIUXHjKhsbrBXZwWWFacw4YcORHXfy9VHYc2oD
   Qazx39HTlUC6tGJmiNJSMR7pnCsvQtZHrZlW+F6WOgDzkyNn56rMtdP5J
   DO/R3R3RKFTDaKHOIvwt0Xli1cZX3cNP0pX1iFDmEHAh38gKNJhmebFa4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="346926808"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="346926808"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 14:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="724151023"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="724151023"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2023 14:03:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prPoR-000jm0-2X;
        Tue, 25 Apr 2023 21:02:59 +0000
Date:   Wed, 26 Apr 2023 05:02:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     hildawu@realtek.com, marcel@holtmann.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        mmandlik@google.com, apusaka@chromium.org, yinghsu@chromium.org,
        alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com
Subject: Re: [PATCH v3] Bluetooth: btrtl: Add Realtek devcoredump support
Message-ID: <202304260422.XHBgACOW-lkp@intel.com>
References: <20230420105343.2014-1-hildawu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420105343.2014-1-hildawu@realtek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on next-20230425]
[cannot apply to bluetooth/master linus/master v6.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/hildawu-realtek-com/Bluetooth-btrtl-Add-Realtek-devcoredump-support/20230420-185852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20230420105343.2014-1-hildawu%40realtek.com
patch subject: [PATCH v3] Bluetooth: btrtl: Add Realtek devcoredump support
config: arm-randconfig-r013-20230424 (https://download.01.org/0day-ci/archive/20230426/202304260422.XHBgACOW-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/dd7adb785f34ba9037f5c73dac879071302c636a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review hildawu-realtek-com/Bluetooth-btrtl-Add-Realtek-devcoredump-support/20230420-185852
        git checkout dd7adb785f34ba9037f5c73dac879071302c636a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304260422.XHBgACOW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/btusb.c:27:
>> drivers/bluetooth/btrtl.h:188:2: error: void function 'btrtl_set_driver_name' should not return a value [-Wreturn-type]
           return -EOPNOTSUPP;
           ^      ~~~~~~~~~~~
   1 error generated.


vim +/btrtl_set_driver_name +188 drivers/bluetooth/btrtl.h

   185	
   186	static inline void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name)
   187	{
 > 188		return -EOPNOTSUPP;
   189	}
   190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
