Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784956B7CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCMP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCMP5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:57:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866F96A1DC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678723017; x=1710259017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pk2pcgHvwszarrx8dyU/HQ5+yjNieIPrKsK2/87vmrw=;
  b=WyabtzcIy9c0UYGJeUXlyWVFZqY2KjHkhCgyUtMxwRzawTrk8nkIta+r
   MQbyN9TxezBlOAwrjuud6gx11LXLjo+u7vdIOAduVx0AvLN3As7LiwXvz
   hNy3aGI5D01PpzHdAY8+lBQIn+Dzq09Q2bUTFb990wH2DNIrQRLvQkI8D
   sQkduO2y8Knjm2F1X8cdJReYrHpYiuHHZGNNv4D4cAi0YuybFWXxQtEEW
   Da3CozrhoGGvtef9Yw4F2xuVAJGS0Eirs7jyguFbBDOsPN4PlLYp2/M9K
   6c+tN+mFAvcUbmeQzRGBGOdxR2w/rIcQdrFEAU4QTV4YYZ6gVJ38hmPkc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337207775"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="337207775"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 08:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="767755597"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="767755597"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2023 08:54:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbkVH-0005qY-2b;
        Mon, 13 Mar 2023 15:54:27 +0000
Date:   Mon, 13 Mar 2023 23:54:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/ptp/ptp_ines.c:837:34: warning: unused variable
 'ines_ptp_ctrl_of_match'
Message-ID: <202303132337.r2XEl3lP-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eeac8ede17557680855031c6f305ece2378af326
commit: bad1eaa6ac312ffd7aa46dd5a4d9843b824aa023 ptp: Add a driver for InES time stamping IP core.
date:   3 years, 3 months ago
config: x86_64-randconfig-a013-20230313 (https://download.01.org/0day-ci/archive/20230313/202303132337.r2XEl3lP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bad1eaa6ac312ffd7aa46dd5a4d9843b824aa023
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bad1eaa6ac312ffd7aa46dd5a4d9843b824aa023
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ptp/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303132337.r2XEl3lP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ptp/ptp_ines.c:481:37: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
                             tag_to_msgtype(ts->tag & 0x7), *msgtype & 0xf);
                                                            ^~~~~~~~~~~~~~
   include/linux/device.h:1792:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   drivers/ptp/ptp_ines.c:491:19: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                             ts->portnum, ntohs(*portn));
                                          ^~~~~~~~~~~~~
   include/linux/device.h:1792:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:104:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ptp/ptp_ines.c:496:17: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                             ts->seqid, ntohs(*seqid));
                                        ^~~~~~~~~~~~~
   include/linux/device.h:1792:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/byteorder/generic.h:142:18: note: expanded from macro 'ntohs'
   #define ntohs(x) ___ntohs(x)
                    ^~~~~~~~~~~
   include/linux/byteorder/generic.h:137:21: note: expanded from macro '___ntohs'
   #define ___ntohs(x) __be16_to_cpu(x)
                       ^~~~~~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:42:26: note: expanded from macro '__be16_to_cpu'
   #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/swab.h:104:2: note: expanded from macro '__swab16'
           (__builtin_constant_p((__u16)(x)) ?     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ptp/ptp_ines.c:837:34: warning: unused variable 'ines_ptp_ctrl_of_match' [-Wunused-const-variable]
   static const struct of_device_id ines_ptp_ctrl_of_match[] = {
                                    ^
   4 warnings generated.


vim +/ines_ptp_ctrl_of_match +837 drivers/ptp/ptp_ines.c

   836	
 > 837	static const struct of_device_id ines_ptp_ctrl_of_match[] = {
   838		{ .compatible = "ines,ptp-ctrl" },
   839		{ }
   840	};
   841	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
