Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14C6966AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBNOZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjBNOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:25:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1005D2A6ED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676384684; x=1707920684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Aw6aWelfjqv1VQ97a/ltev/gwEL63ZW/QhE2WWi8CXE=;
  b=IxCAG4S1SgEknJR6+yUE+cM0iC/G1VKVtzbNr7Eqaj0untTfKEmCb8Id
   di1PEtEle2L8YJN+1Jo7iB2/0Gug11pu5NHwN5ntlwRngKZosOFXxKQhg
   PhRzECqKZ6V2slLFtRd8PwHHmaS90V5AePy7lkxiT0T/GmPAoJDXLa5Lm
   zFGW1D9JhIKnnD0rnBVZxyFyFGbTE/vrtYCAOexSIQFk0BtO71MsP7JyQ
   GJMrwcVaMLGcXH8BTyC61aCosAbXlGxyKGmsJEZeFcXXhKKRmMxiD/S8K
   6pClJ87wvXKUYd81IF5Cw+XrCBsZz9Ul/sWPTtrVSLUyt9s4930x9/nNt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="314813507"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="314813507"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 06:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="619072091"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="619072091"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2023 06:22:12 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRwCB-0008ZB-2w;
        Tue, 14 Feb 2023 14:22:11 +0000
Date:   Tue, 14 Feb 2023 22:21:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luke Ross <luke@lukeross.name>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/iio/accel/da280.c:181:36: warning: 'da280_acpi_match'
 defined but not used
Message-ID: <202302142222.vVU0E4eu-lkp@intel.com>
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

Hi Luke,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f6feea56f66d34259c4222fa02e8171c4f2673d1
commit: 4c42bef0d3a1dd1a04d1f42c079f461cc1b139bc iio:accel:da280: Linx 820 Windows tablet has a da280 mapped via ACPI
date:   5 years ago
config: i386-buildonly-randconfig-r002-20230213 (https://download.01.org/0day-ci/archive/20230214/202302142222.vVU0E4eu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c42bef0d3a1dd1a04d1f42c079f461cc1b139bc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4c42bef0d3a1dd1a04d1f42c079f461cc1b139bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash M=drivers/iio/accel

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302142222.vVU0E4eu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/da280.c:181:36: warning: 'da280_acpi_match' defined but not used [-Wunused-const-variable=]
     181 | static const struct acpi_device_id da280_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~


vim +/da280_acpi_match +181 drivers/iio/accel/da280.c

   180	
 > 181	static const struct acpi_device_id da280_acpi_match[] = {
   182		{"MIRAACC", da280},
   183		{},
   184	};
   185	MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
   186	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
