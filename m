Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4755E700C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIVXD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIVXDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:03:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F8D10913F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663887829; x=1695423829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qmqIvgwBn+RNPidMwrl0FHQGnTzAYOOVBcBPCut7fP8=;
  b=FbT3/cO71DdDdreQDfLojaHqpCt3upeOuSbx28Fg1to4ZWR48B3DZy/v
   g3QPEb2tVWaqDdDVNRduz27H3Qc8TjhRHvpxWxoEb64dhQxR0rRPRLgX/
   qEXlOjNTuMRM/CJRvgBZekM5gkr4vc+nJMEbRR5AHCnZbnZPrxzACiOHO
   Sk1EPdZSbg8MlfXjb4uGwghBpBBhg8crQeqaRKtus2DGYqGr0sKo77Qbm
   KXOfsDXTLN6xTEa6fDNuteCUX1zkFvaMbA/6SFNCXSx/t24MkuOH1aiyv
   3wnkDsf/2Yc5WEDHWWpLKcIKG83BlREHj0rEqlAGj5odHncuNysgNe6kK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283550891"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283550891"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 16:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571167710"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 16:03:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obVEP-00053q-1M;
        Thu, 22 Sep 2022 23:03:45 +0000
Date:   Fri, 23 Sep 2022 07:03:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] arch/x86/kernel/process.c:279:16: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202209230716.G7nMThtF-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s023-20220919 (https://download.01.org/0day-ci/archive/20220923/202209230716.G7nMThtF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=2600a472582e2968633831d430c2a1366ad3e8b1
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 2600a472582e2968633831d430c2a1366ad3e8b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ arch/x86/kernel/ arch/x86/mm/ drivers/acpi/ drivers/auxdisplay/ drivers/char/ drivers/firewire/ drivers/fpga/ drivers/gpu/drm/ drivers/hid/ drivers/hwmon/ drivers/i2c/ drivers/input/ drivers/media/rc/ drivers/misc/ drivers/mtd/ drivers/platform/x86/ drivers/pps/ drivers/rtc/ drivers/tty/ drivers/usb/class/ drivers/usb/core/ drivers/usb/mon/ drivers/video/fbdev/aty/ drivers/video/fbdev/sis/ drivers/video/fbdev/via/ drivers/watchdog/ fs/ ipc/ kernel/ net/ sound/core/ sound/hda/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:869:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:869:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:869:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:1050:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:1050:31: sparse:     got signed int *
   drivers/mtd/ubi/cdev.c:1061:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     got signed int *
--
>> drivers/misc/genwqe/card_dev.c:1073:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean @@     got unsigned int enum genwqe_card_state * @@
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     got unsigned int enum genwqe_card_state *
>> drivers/misc/genwqe/card_dev.c:1080:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1087:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1100:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1106:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1116:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1123:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1136:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1142:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     got unsigned long long *
--
>> drivers/usb/class/usbtmc.c:568:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:568:22: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:568:22: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:589:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:589:22: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:589:22: sparse:     got unsigned char *
>> drivers/usb/class/usbtmc.c:614:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:614:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:614:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1063:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1063:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1063:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1274:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1274:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1274:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1295:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1295:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1295:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:1989:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:1989:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:1989:16: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:2000:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:2000:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2000:13: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:2136:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/class/usbtmc.c:2136:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2136:26: sparse:     got unsigned int *
   drivers/usb/class/usbtmc.c:2141:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2141:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2141:26: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:2175:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2175:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2175:26: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:2180:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2180:26: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2180:26: sparse:     got unsigned char *
   drivers/usb/class/usbtmc.c:2188:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/class/usbtmc.c:2188:34: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/class/usbtmc.c:2188:34: sparse:     got unsigned char *
--
>> drivers/usb/core/devio.c:950:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:950:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:950:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:951:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:951:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:951:13: sparse:     got unsigned int *
>> drivers/usb/core/devio.c:966:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/usb/core/devio.c:966:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:966:21: sparse:     got unsigned char *
   drivers/usb/core/devio.c:1389:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:1389:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:1389:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:1408:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:1408:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:1408:13: sparse:     got unsigned int *
>> drivers/usb/core/devio.c:1540:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:1540:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:1540:13: sparse:     got int *
   drivers/usb/core/devio.c:2043:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:2043:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2043:13: sparse:     got int *
   drivers/usb/core/devio.c:2045:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:2045:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2045:13: sparse:     got int *
   drivers/usb/core/devio.c:2047:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/usb/core/devio.c:2047:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2047:13: sparse:     got int *
   drivers/usb/core/devio.c:2052:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2052:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2052:29: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2055:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2055:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2055:29: sparse:     got unsigned int *
>> drivers/usb/core/devio.c:2061:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   drivers/usb/core/devio.c:2061:13: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2061:13: sparse:     got void [noderef] __user **
   drivers/usb/core/devio.c:2288:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2288:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2288:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2298:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2298:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2298:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2414:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2414:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2414:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2427:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2427:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2427:13: sparse:     got unsigned int *
   drivers/usb/core/devio.c:2445:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/core/devio.c:2445:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/core/devio.c:2445:13: sparse:     got unsigned int *
--
>> drivers/usb/mon/mon_bin.c:928:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:928:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:928:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1094:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1094:29: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1100:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1100:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1118:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1118:21: sparse:     got unsigned int *
   drivers/usb/mon/mon_bin.c:1120:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/usb/mon/mon_bin.c:1120:21: sparse:     got unsigned int *
--
>> drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse:     got unsigned int *
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse:     got unsigned int *
--
>> drivers/video/fbdev/sis/sis_main.c:1717:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:5425:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/sis/sis_main.c:5428:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/sis/sis_main.c:5457:40: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/sis/sis_main.c:5489:16: sparse: sparse: cast to restricted __le16
--
>> drivers/watchdog/watchdog_dev.c:687:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/watchdog_dev.c:687:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:687:21: sparse:     got char const *
>> drivers/watchdog/watchdog_dev.c:749:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:749:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:752:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:752:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:755:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:755:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:755:21: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:775:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:775:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:775:21: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:795:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:795:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:801:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:801:23: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:804:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:804:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:804:21: sparse:     got int *
   drivers/watchdog/watchdog_dev.c:811:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/watchdog_dev.c:811:23: sparse:     got int *
--
>> drivers/watchdog/pcwd_pci.c:450:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/pcwd_pci.c:450:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:450:37: sparse:     got char const *
>> drivers/watchdog/pcwd_pci.c:486:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:486:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:486:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:490:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:490:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:490:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:499:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:499:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:499:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:506:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:506:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:506:21: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:537:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:537:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:537:21: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:548:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:548:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:548:24: sparse:     got int *
   drivers/watchdog/pcwd_pci.c:557:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_pci.c:557:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_pci.c:557:24: sparse:     got int *
--
>> drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const *
>> drivers/watchdog/pcwd_usb.c:407:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:407:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:407:24: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:416:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:416:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:416:24: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:458:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:458:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:458:24: sparse:     got int *
   drivers/watchdog/pcwd_usb.c:467:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pcwd_usb.c:467:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pcwd_usb.c:467:24: sparse:     got int *
--
>> drivers/watchdog/advantechwdt.c:120:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/advantechwdt.c:120:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:120:37: sparse:     got char const *
>> drivers/watchdog/advantechwdt.c:152:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:152:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:152:24: sparse:     got int *
   drivers/watchdog/advantechwdt.c:158:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:158:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:158:21: sparse:     got int *
   drivers/watchdog/advantechwdt.c:175:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:175:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:175:21: sparse:     got int *
   drivers/watchdog/advantechwdt.c:182:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/advantechwdt.c:182:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/advantechwdt.c:182:24: sparse:     got int *
--
>> drivers/watchdog/alim7101_wdt.c:199:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/alim7101_wdt.c:199:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:199:37: sparse:     got char const *
>> drivers/watchdog/alim7101_wdt.c:250:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:250:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:250:24: sparse:     got int *
   drivers/watchdog/alim7101_wdt.c:255:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:255:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:255:21: sparse:     got int *
   drivers/watchdog/alim7101_wdt.c:274:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:274:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:274:21: sparse:     got int *
   drivers/watchdog/alim7101_wdt.c:284:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim7101_wdt.c:284:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim7101_wdt.c:284:24: sparse:     got int *
--
>> drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:99:21: sparse:     got char const *
>> drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:133:23: sparse:     got int *
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:137:23: sparse:     got int *
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:146:23: sparse:     got int *
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_fitpc2_wdt.c:160:23: sparse:     got int *
--
>> drivers/watchdog/ib700wdt.c:156:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/ib700wdt.c:156:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/ib700wdt.c:156:37: sparse:     got char const *
>> drivers/watchdog/ib700wdt.c:188:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ib700wdt.c:188:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ib700wdt.c:188:24: sparse:     got int *
   drivers/watchdog/ib700wdt.c:194:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ib700wdt.c:194:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ib700wdt.c:194:21: sparse:     got int *
   drivers/watchdog/ib700wdt.c:212:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ib700wdt.c:212:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ib700wdt.c:212:21: sparse:     got int *
   drivers/watchdog/ib700wdt.c:220:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ib700wdt.c:220:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ib700wdt.c:220:24: sparse:     got int *
--
>> drivers/watchdog/ibmasr.c:259:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/ibmasr.c:259:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:259:37: sparse:     got char const *
>> drivers/watchdog/ibmasr.c:286:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:286:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:286:24: sparse:     got int *
   drivers/watchdog/ibmasr.c:290:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:290:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:290:21: sparse:     got int *
   drivers/watchdog/ibmasr.c:312:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/ibmasr.c:312:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/ibmasr.c:312:24: sparse:     got int *
--
>> drivers/watchdog/wafer5823wdt.c:109:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     got char const *
>> drivers/watchdog/wafer5823wdt.c:143:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:149:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:170:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:179:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     got int *
--
>> drivers/watchdog/it8712f_wdt.c:243:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/it8712f_wdt.c:243:29: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:243:29: sparse:     got char const *
>> drivers/watchdog/it8712f_wdt.c:282:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/it8712f_wdt.c:282:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:282:24: sparse:     got int *
   drivers/watchdog/it8712f_wdt.c:284:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/it8712f_wdt.c:284:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:284:24: sparse:     got int *
   drivers/watchdog/it8712f_wdt.c:289:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/it8712f_wdt.c:289:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:289:21: sparse:     got int *
   drivers/watchdog/it8712f_wdt.c:307:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/it8712f_wdt.c:307:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/it8712f_wdt.c:307:21: sparse:     got int *
--
>> drivers/watchdog/sc1200wdt.c:200:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:200:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:200:24: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:203:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:203:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:203:24: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:209:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:209:21: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:229:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:229:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:229:21: sparse:     got int *
   drivers/watchdog/sc1200wdt.c:240:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sc1200wdt.c:240:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:240:24: sparse:     got int *
>> drivers/watchdog/sc1200wdt.c:276:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sc1200wdt.c:276:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sc1200wdt.c:276:37: sparse:     got char const *
--
>> drivers/watchdog/pc87413_wdt.c:354:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/pc87413_wdt.c:354:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:354:37: sparse:     got char const *
>> drivers/watchdog/pc87413_wdt.c:403:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:403:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:403:24: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:405:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:405:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:405:24: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:409:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:409:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:409:21: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:428:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:428:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:428:21: sparse:     got int *
   drivers/watchdog/pc87413_wdt.c:439:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/pc87413_wdt.c:439:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/pc87413_wdt.c:439:24: sparse:     got int *
--
>> drivers/watchdog/sbc60xxwdt.c:180:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sbc60xxwdt.c:180:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:180:37: sparse:     got char const *
>> drivers/watchdog/sbc60xxwdt.c:237:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     got int *
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse:     got int *
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse:     got int *
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     got int *
--
>> drivers/watchdog/nv_tco.c:197:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/nv_tco.c:197:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:197:37: sparse:     got char const *
>> drivers/watchdog/nv_tco.c:230:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:230:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:230:24: sparse:     got int *
   drivers/watchdog/nv_tco.c:232:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:232:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:232:21: sparse:     got int *
   drivers/watchdog/nv_tco.c:248:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:248:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:248:21: sparse:     got int *
   drivers/watchdog/nv_tco.c:255:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/nv_tco.c:255:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/nv_tco.c:255:24: sparse:     got int *
--
>> drivers/watchdog/cpu5wdt.c:157:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     got int *
   drivers/watchdog/cpu5wdt.c:159:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     got int *
   drivers/watchdog/cpu5wdt.c:161:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/cpu5wdt.c:161:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/cpu5wdt.c:161:21: sparse:     got int *
--
>> drivers/watchdog/sch311x_wdt.c:232:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sch311x_wdt.c:232:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:232:37: sparse:     got char const *
>> drivers/watchdog/sch311x_wdt.c:267:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:267:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:267:24: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:270:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:270:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:270:24: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:276:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:276:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:276:21: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:293:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:293:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:293:21: sparse:     got int *
   drivers/watchdog/sch311x_wdt.c:300:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sch311x_wdt.c:300:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sch311x_wdt.c:300:24: sparse:     got int *
--
>> drivers/watchdog/smsc37b787_wdt.c:404:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     got char const *
>> drivers/watchdog/smsc37b787_wdt.c:444:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     got int *
--
>> drivers/watchdog/w83877f_wdt.c:202:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/w83877f_wdt.c:202:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:202:37: sparse:     got char const *
>> drivers/watchdog/w83877f_wdt.c:255:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:255:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:255:24: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:260:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:260:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:260:21: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:282:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:282:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:282:21: sparse:     got int *
   drivers/watchdog/w83877f_wdt.c:294:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83877f_wdt.c:294:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83877f_wdt.c:294:24: sparse:     got int *
--
>> drivers/watchdog/w83977f_wdt.c:343:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/w83977f_wdt.c:343:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:343:37: sparse:     got char const *
>> drivers/watchdog/w83977f_wdt.c:392:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:392:24: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:395:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:395:24: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:398:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:398:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:398:21: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:418:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:418:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:418:21: sparse:     got int *
   drivers/watchdog/w83977f_wdt.c:428:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/w83977f_wdt.c:428:24: sparse:     got int *
--
>> drivers/watchdog/machzwd.c:285:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/machzwd.c:285:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/machzwd.c:285:37: sparse:     got char const *
>> drivers/watchdog/machzwd.c:315:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/machzwd.c:315:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/machzwd.c:315:24: sparse:     got int *
--
>> drivers/watchdog/sbc_epx_c3.c:119:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     got int *
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse:     got int *
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     got int *
--
>> drivers/video/fbdev/via/viafbdev.c:409:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     got unsigned int *
--
>> arch/x86/kernel/process_64.c:810:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/process_64.c:810:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/process_64.c:810:23: sparse:     got unsigned long *
   arch/x86/kernel/process_64.c:816:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/process_64.c:816:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/process_64.c:816:23: sparse:     got unsigned long *
--
>> arch/x86/kernel/traps.c:621:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   arch/x86/kernel/traps.c:621:13: sparse:     expected char const [noderef] __user *__ptr_clean
   arch/x86/kernel/traps.c:621:13: sparse:     got char const *
--
>> arch/x86/kernel/process.c:279:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/process.c:279:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/process.c:279:16: sparse:     got unsigned int *
   arch/x86/kernel/process.c:758:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct cpuinfo_x86 * @@
   arch/x86/kernel/process.c:758:26: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/kernel/process.c:758:26: sparse:     got struct cpuinfo_x86 *
--
>> arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *
--
>> arch/x86/mm/fault.c:152:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   arch/x86/mm/fault.c:152:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   arch/x86/mm/fault.c:152:29: sparse:     got unsigned char *
--
   arch/x86/kernel/fpu/xstate.c:1526:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1526:9: sparse:     expected struct lockdep_map const *lock
   arch/x86/kernel/fpu/xstate.c:1526:9: sparse:     got struct lockdep_map [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1616:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1616:31: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1616:31: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1624:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1624:33: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1624:33: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1642:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1642:31: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1642:31: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1646:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1646:41: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1646:41: sparse:     got struct spinlock [noderef] __rcu *
   arch/x86/kernel/fpu/xstate.c:1661:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   arch/x86/kernel/fpu/xstate.c:1661:33: sparse:     expected struct spinlock [usertype] *lock
   arch/x86/kernel/fpu/xstate.c:1661:33: sparse:     got struct spinlock [noderef] __rcu *
>> arch/x86/kernel/fpu/xstate.c:1718:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kernel/fpu/xstate.c:1718:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1718:24: sparse:     got unsigned long long *
   arch/x86/kernel/fpu/xstate.c:1727:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kernel/fpu/xstate.c:1727:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1727:24: sparse:     got unsigned long long *
   arch/x86/kernel/fpu/xstate.c:1732:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   arch/x86/kernel/fpu/xstate.c:1732:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   arch/x86/kernel/fpu/xstate.c:1732:24: sparse:     got unsigned long long *
--
>> kernel/groups.c:47:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/groups.c:47:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/groups.c:47:21: sparse:     got unsigned int *
   kernel/groups.c:64:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/groups.c:64:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/groups.c:64:21: sparse:     got unsigned int *
--
>> kernel/rseq.c:111:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:111:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:111:13: sparse:     got unsigned int *
   kernel/rseq.c:118:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:118:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:118:13: sparse:     got unsigned int *
>> kernel/rseq.c:132:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/rseq.c:132:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/rseq.c:132:13: sparse:     got unsigned long long *
   kernel/rseq.c:161:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:161:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:161:15: sparse:     got unsigned int *
   kernel/rseq.c:183:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/rseq.c:183:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/rseq.c:183:15: sparse:     got unsigned int *
   kernel/rseq.c:213:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/rseq.c:213:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/rseq.c:213:16: sparse:     got unsigned long long *
--
   kernel/fork.c:1307:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file [noderef] __rcu *__ret @@     got struct file *new_exe_file @@
   kernel/fork.c:1307:24: sparse:     expected struct file [noderef] __rcu *__ret
   kernel/fork.c:1307:24: sparse:     got struct file *new_exe_file
   kernel/fork.c:1307:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   kernel/fork.c:1307:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1307:22: sparse:     got struct file [noderef] __rcu *[assigned] __ret
>> kernel/fork.c:1472:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/fork.c:1472:25: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/fork.c:1472:25: sparse:     got int *
   kernel/fork.c:1638:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1638:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1638:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1647:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1647:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1647:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1648:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1648:9: sparse:     expected void const *
   kernel/fork.c:1648:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1648:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1648:9: sparse:     expected void const *
   kernel/fork.c:1648:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1648:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1648:9: sparse:     expected void const *
   kernel/fork.c:1648:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1649:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1649:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1649:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2077:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2077:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2077:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2081:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2081:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2081:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2301:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/fork.c:2301:26: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/fork.c:2301:26: sparse:     got int *
   kernel/fork.c:2401:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2401:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2401:32: sparse:     got struct task_struct *
   kernel/fork.c:2410:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2410:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2410:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2457:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2457:54: sparse:     expected struct list_head *head
   kernel/fork.c:2457:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2478:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2478:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2478:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2499:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2499:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2499:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2526:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2526:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2526:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2555:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2555:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2555:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2557:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2557:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2557:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2689:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/fork.c:2689:17: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/fork.c:2689:17: sparse:     got int *
   kernel/fork.c:2993:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2993:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2993:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3074:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3074:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3074:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2122:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2455:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2456:59: sparse: sparse: dereference of noderef expression
--
   kernel/exit.c:281:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:281:37: sparse:     expected struct task_struct *tsk
   kernel/exit.c:281:37: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:284:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:284:32: sparse:     expected struct task_struct *task
   kernel/exit.c:284:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:285:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:285:35: sparse:     expected struct task_struct *task
   kernel/exit.c:285:35: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:330:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:330:24: sparse:     expected struct task_struct *parent
   kernel/exit.c:330:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:357:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:357:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:357:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:360:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:360:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:360:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:583:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:583:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:583:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:585:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *reaper @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/exit.c:585:29: sparse:     expected struct task_struct *reaper
   kernel/exit.c:585:29: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/exit.c:909:63: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *const sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/exit.c:909:63: sparse:     expected struct sighand_struct *const sighand
   kernel/exit.c:909:63: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/exit.c:1064:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1064:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1064:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1089:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1089:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1089:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1178:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1178:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1178:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1193:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1193:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1193:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1244:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1244:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1244:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1247:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1247:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1247:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1253:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/exit.c:1253:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/exit.c:1253:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/exit.c:1434:59: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/exit.c:1434:59: sparse:    void *
   kernel/exit.c:1434:59: sparse:    struct task_struct [noderef] __rcu *
   kernel/exit.c:1450:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu * @@
   kernel/exit.c:1450:25: sparse:     expected struct task_struct *parent
   kernel/exit.c:1450:25: sparse:     got struct task_struct [noderef] __rcu *
>> kernel/exit.c:1683:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/exit.c:1683:37: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/exit.c:1683:37: sparse:     got int *
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c: note: in included file (through include/linux/sched/signal.h, include/linux/rcuwait.h, include/linux/percpu-rwsem.h, ...):
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_zombie' - unexpected unlock
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_stopped' - unexpected unlock
   include/linux/sched/task.h:110:21: sparse: sparse: context imbalance in 'wait_task_continued' - unexpected unlock
   kernel/exit.c: note: in included file:
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/exit.c:1542:9: sparse: sparse: context imbalance in 'do_wait' - wrong count at exit
--
>> kernel/capability.c:86:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/capability.c:86:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/capability.c:86:13: sparse:     got unsigned int *
   kernel/capability.c:101:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/capability.c:101:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/capability.c:101:21: sparse:     got unsigned int *
>> kernel/capability.c:159:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/capability.c:159:13: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/capability.c:159:13: sparse:     got int *
   kernel/capability.c:195:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got struct __user_cap_data_struct [noderef] __user * @@
   kernel/capability.c:195:43: sparse:     expected void const *from
   kernel/capability.c:195:43: sparse:     got struct __user_cap_data_struct [noderef] __user *
   kernel/capability.c:171:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:172:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:173:30: sparse: sparse: dereference of noderef expression
   kernel/capability.c:235:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/capability.c:235:13: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/capability.c:235:13: sparse:     got int *
   kernel/capability.c:246:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct __user_cap_data_struct [noderef] __user ( * )[2] @@
   kernel/capability.c:246:29: sparse:     expected void *to
   kernel/capability.c:246:29: sparse:     got struct __user_cap_data_struct [noderef] __user ( * )[2]
   kernel/capability.c:250:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:251:41: sparse: sparse: dereference of noderef expression
   kernel/capability.c:252:43: sparse: sparse: dereference of noderef expression
--
   kernel/ptrace.c:54:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:54:22: sparse:    struct task_struct *
   kernel/ptrace.c:54:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:73:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:73:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:73:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:74:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:74:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:74:29: sparse:     got struct cred const *
   kernel/ptrace.c:128:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:128:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:128:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:132:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:132:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:132:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:170:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:170:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:170:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:202:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:202:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:202:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:208:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:208:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:208:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:261:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:261:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:261:44: sparse:    struct task_struct *
   kernel/ptrace.c:452:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:452:24: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:452:24: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:477:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:477:26: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:477:26: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:513:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:513:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:513:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:521:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:521:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:521:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:569:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:569:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:569:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:571:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:571:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:571:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:762:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:762:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:762:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:770:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:770:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:770:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:881:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:881:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:881:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:885:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:885:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:885:31: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/ptrace.c:1055:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1055:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1055:23: sparse:     got unsigned long *
   kernel/ptrace.c:1115:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1115:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1115:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1117:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1117:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1117:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1315:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/ptrace.c:1315:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/ptrace.c:1315:16: sparse:     got unsigned long *
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:519:38: sparse: sparse: dereference of noderef expression
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:709:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:725:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1266:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
--
>> kernel/sys.c:1977:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:1977:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:1977:24: sparse:     got unsigned int *
>> kernel/sys.c:2244:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *[noderef] __user *__ptr_clean @@     got int [noderef] __user ** @@
   kernel/sys.c:2244:16: sparse:     expected int [noderef] __user *[noderef] __user *__ptr_clean
   kernel/sys.c:2244:16: sparse:     got int [noderef] __user **
   kernel/sys.c:744:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:744:18: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:744:18: sparse:     got unsigned int *
   kernel/sys.c:746:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:746:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:746:26: sparse:     got unsigned int *
   kernel/sys.c:748:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:748:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:748:32: sparse:     got unsigned int *
   kernel/sys.c:827:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:827:18: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:827:18: sparse:     got unsigned int *
   kernel/sys.c:829:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:829:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:829:26: sparse:     got unsigned int *
   kernel/sys.c:831:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:831:34: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:831:34: sparse:     got unsigned int *
   kernel/sys.c:1083:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/sys.c:1083:32: sparse:     expected struct task_struct *p1
   kernel/sys.c:1083:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/sys.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/sys.c:2369:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/sys.c:2369:25: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/sys.c:2369:25: sparse:     got int *
   kernel/sys.c:2505:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/sys.c:2505:25: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/sys.c:2505:25: sparse:     got int *
   kernel/sys.c:2640:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:2640:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:2640:24: sparse:     got unsigned int *
   kernel/sys.c:2642:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sys.c:2642:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sys.c:2642:24: sparse:     got unsigned int *
--
>> arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/entry/vsyscall/vsyscall_64.c:169:13: sparse:     got unsigned long *
--
>> fs/timerfd.c:316:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/timerfd.c:316:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/timerfd.c:316:23: sparse:     got unsigned long long *
--
>> fs/userfaultfd.c:1488:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/userfaultfd.c:1488:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1488:21: sparse:     got unsigned long long *
>> fs/userfaultfd.c:1721:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/userfaultfd.c:1721:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1721:13: sparse:     got signed long long *
   fs/userfaultfd.c:1773:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/userfaultfd.c:1773:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1773:13: sparse:     got signed long long *
   fs/userfaultfd.c:1884:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/userfaultfd.c:1884:13: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/userfaultfd.c:1884:13: sparse:     got signed long long *
--
   fs/aio.c:616:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:616:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:616:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:782:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct kioctx_cpu *cpu @@     got struct kioctx_cpu [noderef] __percpu * @@
   fs/aio.c:782:18: sparse:     expected struct kioctx_cpu *cpu
   fs/aio.c:782:18: sparse:     got struct kioctx_cpu [noderef] __percpu *
   fs/aio.c:829:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct kioctx_cpu *cpu @@
   fs/aio.c:829:24: sparse:     expected void [noderef] __percpu *__pdata
   fs/aio.c:829:24: sparse:     got struct kioctx_cpu *cpu
   fs/aio.c:934:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:934:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:934:16: sparse:     got struct kioctx_cpu *
   fs/aio.c:952:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct kioctx_cpu * @@
   fs/aio.c:952:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/aio.c:952:16: sparse:     got struct kioctx_cpu *
>> fs/aio.c:1081:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1081:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1081:13: sparse:     got unsigned int *
   fs/aio.c:1961:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:1961:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:1961:13: sparse:     got unsigned int *
>> fs/aio.c:1344:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/aio.c:1344:15: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/aio.c:1344:15: sparse:     got unsigned long *
   fs/aio.c:1358:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/aio.c:1358:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/aio.c:1358:23: sparse:     got unsigned long *
   fs/aio.c:1656:13: sparse: sparse: context imbalance in 'poll_iocb_lock_wq' - different lock contexts for basic block
   fs/aio.c:1687:13: sparse: sparse: context imbalance in 'poll_iocb_unlock_wq' - unexpected unlock
>> fs/aio.c:2076:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct iocb [noderef] __user *[noderef] __user *__ptr_clean @@     got struct iocb [noderef] __user ** @@
   fs/aio.c:2076:21: sparse:     expected struct iocb [noderef] __user *[noderef] __user *__ptr_clean
   fs/aio.c:2076:21: sparse:     got struct iocb [noderef] __user **
   fs/aio.c:2154:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/aio.c:2154:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/aio.c:2154:13: sparse:     got unsigned int *
--
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:326:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:326:13: sparse:     got unsigned long long *
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:333:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse:     got unsigned long long *
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:340:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse:     got unsigned long long *
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:348:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse:     got unsigned long long *
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/binfmt_elf.c:355:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse:     got unsigned long long *
--
>> fs/fhandle.c:72:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/fhandle.c:72:13: sparse:     expected int [noderef] __user *__ptr_clean
   fs/fhandle.c:72:13: sparse:     got int *
--
>> fs/read_write.c:1291:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1291:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1291:21: sparse:     got long *
   fs/read_write.c:1295:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1295:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1295:21: sparse:     got long *
>> fs/read_write.c:1312:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   fs/read_write.c:1312:21: sparse:     expected long long [noderef] __user *__ptr_clean
   fs/read_write.c:1312:21: sparse:     got long long *
--
>> fs/pipe.c:626:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/pipe.c:626:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/pipe.c:626:24: sparse:     got int *
--
>> fs/exec.c:421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *const [noderef] __user *__ptr_clean @@     got char const [noderef] __user *const * @@
   fs/exec.c:421:13: sparse:     expected char const [noderef] __user *const [noderef] __user *__ptr_clean
   fs/exec.c:421:13: sparse:     got char const [noderef] __user *const *
   fs/exec.c:422:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:422:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:422:31: sparse:     got void *
   fs/exec.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1051:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1051:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1158:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1158:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1158:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1193:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1193:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1193:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1307:26: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1307:26: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1309:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   fs/exec.c:1309:28: sparse:     expected struct spinlock [usertype] *lock
   fs/exec.c:1309:28: sparse:     got struct spinlock [noderef] __rcu *
   fs/exec.c:1766:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1766:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1766:70: sparse:     got struct task_struct [noderef] __rcu *parent
--
>> fs/fcntl.c:258:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fcntl.c:258:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fcntl.c:258:16: sparse:     got unsigned int *
   fs/fcntl.c:259:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fcntl.c:259:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fcntl.c:259:16: sparse:     got unsigned int *
   fs/fcntl.c:931:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:931:9: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:931:9: sparse:    struct fasync_struct *
   fs/fcntl.c:1006:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:1006:22: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:1006:22: sparse:    struct fasync_struct *
   fs/fcntl.c:1017:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/fcntl.c:1017:33: sparse:    struct fasync_struct [noderef] __rcu *
   fs/fcntl.c:1017:33: sparse:    struct fasync_struct *
--
>> fs/ioctl.c:69:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:69:17: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:69:17: sparse:     got int *
   fs/ioctl.c:91:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:91:13: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:91:13: sparse:     got int *
   fs/ioctl.c:346:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:346:17: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:346:17: sparse:     got int *
   fs/ioctl.c:370:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:370:17: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:370:17: sparse:     got int *
>> fs/ioctl.c:424:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/ioctl.c:424:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/ioctl.c:424:13: sparse:     got unsigned short *
>> fs/ioctl.c:711:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ioctl.c:711:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ioctl.c:711:23: sparse:     got unsigned int *
   fs/ioctl.c:723:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ioctl.c:723:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ioctl.c:723:15: sparse:     got unsigned int *
   fs/ioctl.c:817:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:817:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:817:24: sparse:     got int *
   fs/ioctl.c:832:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ioctl.c:832:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ioctl.c:832:24: sparse:     got int *
--
>> fs/readdir.c:293:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/readdir.c:293:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/readdir.c:293:21: sparse:     got unsigned long *
>> fs/readdir.c:377:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/readdir.c:377:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/readdir.c:377:21: sparse:     got signed long long *
--
   fs/file.c:379:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:379:17: sparse:     expected struct file **old_fds
   fs/file.c:379:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:380:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:380:17: sparse:     expected struct file **new_fds
   fs/file.c:380:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:395:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:395:17: sparse:    struct file [noderef] __rcu *
   fs/file.c:395:17: sparse:    struct file *
   fs/file.c:430:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   fs/file.c:470:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] __rcu *fdt @@     got struct fdtable * @@
   fs/file.c:645:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:838:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:1100:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] __rcu * @@
>> fs/file.c:1173:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
--
>> fs/namespace.c:3261:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/namespace.c:3261:21: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/namespace.c:3261:21: sparse:     got char const *
--
>> fs/utimes.c:273:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:273:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:273:21: sparse:     got signed int *
   fs/utimes.c:274:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:274:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:274:21: sparse:     got signed int *
   fs/utimes.c:275:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:275:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:275:21: sparse:     got signed int *
   fs/utimes.c:276:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:276:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:276:21: sparse:     got signed int *
>> fs/utimes.c:219:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/utimes.c:219:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/utimes.c:219:21: sparse:     got long *
   fs/utimes.c:220:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/utimes.c:220:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/utimes.c:220:21: sparse:     got long *
   fs/utimes.c:241:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:241:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:241:21: sparse:     got signed int *
   fs/utimes.c:242:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/utimes.c:242:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/utimes.c:242:21: sparse:     got signed int *
--
>> fs/nsfs.c:211:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/nsfs.c:211:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/nsfs.c:211:24: sparse:     got unsigned int *
--
   kernel/sched/core.c:1027:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1027:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1027:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2191:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2191:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2191:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2191:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2191:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2191:68: sparse:     got struct task_struct [noderef] __rcu *curr
>> kernel/sched/core.c:5122:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   kernel/sched/core.c:5122:17: sparse:     expected int [noderef] __user *__ptr_clean
   kernel/sched/core.c:5122:17: sparse:     got int *
   kernel/sched/core.c:5440:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5440:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5440:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6386:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6386:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6386:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6912:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6912:17: sparse:    struct task_struct *
   kernel/sched/core.c:6912:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7128:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7128:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7128:22: sparse:    struct task_struct *
>> kernel/sched/core.c:7778:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sched/core.c:7778:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sched/core.c:7778:15: sparse:     got unsigned int *
   kernel/sched/core.c:7808:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/sched/core.c:7808:9: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/sched/core.c:7808:9: sparse:     got unsigned int *
   kernel/sched/core.c:11187:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11187:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11187:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:537:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:570:23: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:586:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:624:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:665:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c:2182:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2183:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2184:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:3712:25: sparse: sparse: context imbalance in 'ttwu_runnable' - wrong count at exit
   kernel/sched/core.c:4265:9: sparse: sparse: context imbalance in 'task_call_func' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   include/trace/events/sched.h:185:1: sparse: sparse: context imbalance in 'wake_up_new_task' - wrong count at exit
   kernel/sched/core.c:5099:9: sparse: sparse: context imbalance in 'finish_task_switch' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2060:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2060:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2217:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2217:9: sparse:    struct task_struct *
--
>> fs/notify/inotify/inotify_user.c:337:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/notify/inotify/inotify_user.c:337:23: sparse:     expected int [noderef] __user *__ptr_clean
   fs/notify/inotify/inotify_user.c:337:23: sparse:     got int *
   fs/notify/inotify/inotify_user.c:577:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *conn @@     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks @@
   fs/notify/inotify/inotify_user.c:577:51: sparse:     expected struct fsnotify_mark_connector *conn
   fs/notify/inotify/inotify_user.c:577:51: sparse:     got struct fsnotify_mark_connector [noderef] __rcu *i_fsnotify_marks
--
>> fs/verity/measure.c:42:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/verity/measure.c:42:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/verity/measure.c:42:13: sparse:     got unsigned short *
--
>> ipc/msg.c:960:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:960:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:960:13: sparse:     got long *
   ipc/msg.c:1025:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   ipc/msg.c:1025:13: sparse:     expected long [noderef] __user *__ptr_clean
   ipc/msg.c:1025:13: sparse:     got long *
   ipc/msg.c:180:26: sparse: sparse: context imbalance in 'newque' - unexpected unlock
--
>> fs/proc/page.c:75:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/proc/page.c:75:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/proc/page.c:75:21: sparse:     got unsigned long long *
   fs/proc/page.c:252:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/proc/page.c:252:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/proc/page.c:252:21: sparse:     got unsigned long long *
--
   sound/core/control.c:391:11: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long h @@     got restricted snd_ctl_elem_iface_t const [usertype] iface @@
   sound/core/control.c:391:11: sparse:     expected unsigned long h
   sound/core/control.c:391:11: sparse:     got restricted snd_ctl_elem_iface_t const [usertype] iface
   sound/core/control.c:927:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:928:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:928:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:947:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:975:41: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1086:34: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1654:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
>> sound/core/control.c:1763:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1763:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1763:13: sparse:     got int *
   sound/core/control.c:1767:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1767:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1767:21: sparse:     got int *
   sound/core/control.c:1904:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1904:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1904:24: sparse:     got int *
   sound/core/control.c:1945:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1945:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1945:24: sparse:     got int *
--
>> sound/core/timer.c:2045:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2045:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2045:13: sparse:     got int *
   sound/core/timer.c:2084:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2084:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2084:24: sparse:     got int *
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:92:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:92:29: sparse:     got int *
   sound/core/pcm.c:97:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:97:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:97:29: sparse:     got int *
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm.c:112:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm.c:112:29: sparse:     got unsigned int *
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:114:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:114:29: sparse:     got int *
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm.c:119:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm.c:119:29: sparse:     got unsigned int *
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:155:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:155:29: sparse:     got int *
--
>> sound/core/pcm_native.c:1082:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1082:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1082:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:1108:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1108:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1108:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3134:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3134:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3135:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3135:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3135:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3136:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3136:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3136:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3171:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3172:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3173:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3174:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3175:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3176:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3177:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3178:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3179:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3191:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3191:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3191:13: sparse:     got int *
>> sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3208:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3216:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3233:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3246:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *
>> sound/core/pcm_native.c:3257:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3257:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3257:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3259:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3262:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3273:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3273:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3273:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3275:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3278:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3302:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3302:24: sparse:     got int *
   sound/core/pcm_native.c:3310:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3310:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3310:21: sparse:     got unsigned int *
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3357:21: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:184:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:201:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1261:44: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1331:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
>> sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int *
--
>> sound/core/compress_offload.c:977:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/compress_offload.c:977:26: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/compress_offload.c:977:26: sparse:     got int *
--
>> sound/core/rawmidi.c:705:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:705:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:705:13: sparse:     got unsigned int *
>> sound/core/rawmidi.c:707:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:707:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:707:13: sparse:     got int *
   sound/core/rawmidi.c:709:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:709:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:709:13: sparse:     got unsigned int *
   sound/core/rawmidi.c:912:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:912:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:912:24: sparse:     got int *
   sound/core/rawmidi.c:918:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:918:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:918:21: sparse:     got int *
   sound/core/rawmidi.c:930:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/rawmidi.c:930:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:930:21: sparse:     got unsigned int *
   sound/core/rawmidi.c:965:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:965:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:965:21: sparse:     got int *
   sound/core/rawmidi.c:980:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:980:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:980:21: sparse:     got int *
   sound/core/rawmidi.c:1014:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:1014:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:1014:21: sparse:     got int *
   sound/core/rawmidi.c:1028:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:1028:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:1028:21: sparse:     got int *
   sound/core/rawmidi.c:1036:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/rawmidi.c:1036:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/rawmidi.c:1036:21: sparse:     got int *
--
>> net/socket.c:1227:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1227:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1227:29: sparse:     got int *
   net/socket.c:1233:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1233:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1233:31: sparse:     got int *
   net/socket.c:278:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:278:15: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:278:15: sparse:     got int *
   net/socket.c:1685:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1685:15: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1685:15: sparse:     got int *
   net/socket.c:1689:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/socket.c:1689:15: sparse:     expected int [noderef] __user *__ptr_clean
   net/socket.c:1689:15: sparse:     got int *
>> net/socket.c:2627:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/socket.c:2627:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/socket.c:2627:31: sparse:     got unsigned int *
   net/socket.c:2843:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/socket.c:2843:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/socket.c:2843:31: sparse:     got unsigned int *
--
>> net/core/sock.c:743:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:743:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:743:13: sparse:     got int *
>> net/core/sock.c:1534:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/core/sock.c:1534:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/core/sock.c:1534:21: sparse:     got unsigned int *
   net/core/sock.c:1560:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:1560:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:1560:13: sparse:     got int *
   net/core/sock.c:1713:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:1713:32: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:1713:32: sparse:     got int *
   net/core/sock.c:1902:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/sock.c:1902:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/sock.c:1902:13: sparse:     got int *
   net/core/sock.c:2286:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2290:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:3892:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:3904:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit
--
>> net/core/scm.c:324:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/scm.c:324:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/scm.c:324:23: sparse:     got int *
   net/core/scm.c:326:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/scm.c:326:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/scm.c:326:31: sparse:     got int *
>> net/core/scm.c:328:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   net/core/scm.c:328:31: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   net/core/scm.c:328:31: sparse:     got unsigned long *
--
>> net/core/dev_ioctl.c:81:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/core/dev_ioctl.c:81:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/core/dev_ioctl.c:81:16: sparse:     got int *
--
>> drivers/auxdisplay/charlcd.c:482:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/auxdisplay/charlcd.c:482:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/auxdisplay/charlcd.c:482:21: sparse:     got char const *
--
>> fs/autofs/root.c:812:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:812:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:812:16: sparse:     got int *
   fs/autofs/root.c:819:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:819:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:819:16: sparse:     got int *
>> fs/autofs/root.c:790:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:790:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:790:14: sparse:     got unsigned long *
   fs/autofs/root.c:794:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:794:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:794:14: sparse:     got unsigned long *
   fs/autofs/root.c:834:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:834:18: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:834:18: sparse:     got int *
--
>> fs/autofs/expire.c:616:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/expire.c:616:20: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/expire.c:616:20: sparse:     got int *
--
>> fs/fuse/dev.c:2260:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fuse/dev.c:2260:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fuse/dev.c:2260:22: sparse:     got unsigned int *
--
>> drivers/char/random.c:1364:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1364:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1364:21: sparse:     got int *
   drivers/char/random.c:1370:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1370:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1370:21: sparse:     got int *
   drivers/char/random.c:1384:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1384:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1384:21: sparse:     got int *
   drivers/char/random.c:1388:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/char/random.c:1388:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/char/random.c:1388:21: sparse:     got int *
--
>> net/netlink/af_netlink.c:1730:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1730:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1730:13: sparse:     got int *
   net/netlink/af_netlink.c:1741:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1741:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1741:21: sparse:     got int *
>> net/netlink/af_netlink.c:1742:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1742:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1742:21: sparse:     got char *
   net/netlink/af_netlink.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1751:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1751:21: sparse:     got int *
   net/netlink/af_netlink.c:1752:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1752:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1752:21: sparse:     got char *
   net/netlink/af_netlink.c:1761:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1761:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1761:21: sparse:     got int *
   net/netlink/af_netlink.c:1762:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1762:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1762:21: sparse:     got char *
>> net/netlink/af_netlink.c:1777:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/netlink/af_netlink.c:1777:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1777:29: sparse:     got unsigned int *
   net/netlink/af_netlink.c:1783:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1783:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1783:21: sparse:     got int *
   net/netlink/af_netlink.c:1793:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1793:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1793:21: sparse:     got int *
   net/netlink/af_netlink.c:1794:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1794:21: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1794:21: sparse:     got char *
   net/netlink/af_netlink.c:1803:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1803:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1803:21: sparse:     got int *
   net/netlink/af_netlink.c:1803:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1803:46: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1803:46: sparse:     got char *
   net/netlink/af_netlink.c:1812:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netlink/af_netlink.c:1812:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1812:21: sparse:     got int *
   net/netlink/af_netlink.c:1812:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   net/netlink/af_netlink.c:1812:46: sparse:     expected char [noderef] __user *__ptr_clean
   net/netlink/af_netlink.c:1812:46: sparse:     got char *
   net/netlink/af_netlink.c:2568:13: sparse: sparse: context imbalance in 'netlink_walk_start' - wrong count at exit
   net/netlink/af_netlink.c:2574:13: sparse: sparse: context imbalance in 'netlink_walk_stop' - unexpected unlock
   net/netlink/af_netlink.c:2624:9: sparse: sparse: context imbalance in 'netlink_seq_start' - wrong count at exit
--
>> net/ethtool/ioctl.c:107:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ethtool/ioctl.c:107:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ethtool/ioctl.c:107:13: sparse:     got unsigned int *
--
>> sound/hda/hdmi_chmap.c:678:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:678:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:678:13: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:710:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:710:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:710:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:711:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:711:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:711:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:732:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:732:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:732:13: sparse:     got unsigned int *
--
>> kernel/time/time.c:67:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:67:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:67:21: sparse:     got long *
   kernel/time/time.c:86:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:86:13: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:86:13: sparse:     got long *
>> kernel/time/time.c:112:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   kernel/time/time.c:112:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   kernel/time/time.c:112:21: sparse:     got signed int *
   kernel/time/time.c:124:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   kernel/time/time.c:124:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   kernel/time/time.c:124:13: sparse:     got signed int *
   kernel/time/time.c:147:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:147:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:147:21: sparse:     got long *
   kernel/time/time.c:148:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:148:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:148:21: sparse:     got long *
   kernel/time/time.c:206:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:206:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:206:21: sparse:     got long *
   kernel/time/time.c:207:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/time/time.c:207:21: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/time/time.c:207:21: sparse:     got long *
--
>> net/ipv4/ip_sockglue.c:1485:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1485:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1485:13: sparse:     got int *
   net/ipv4/ip_sockglue.c:1517:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1517:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1517:13: sparse:     got int *
>> net/ipv4/ip_sockglue.c:1518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/ip_sockglue.c:1518:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1518:13: sparse:     got unsigned int *
   net/ipv4/ip_sockglue.c:1519:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/ip_sockglue.c:1519:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1519:13: sparse:     got unsigned int *
   net/ipv4/ip_sockglue.c:1538:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1538:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1538:13: sparse:     got int *
   net/ipv4/ip_sockglue.c:1564:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1564:32: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1564:32: sparse:     got int *
   net/ipv4/ip_sockglue.c:1569:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1569:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1569:21: sparse:     got int *
   net/ipv4/ip_sockglue.c:1662:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1662:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1662:21: sparse:     got int *
   net/ipv4/ip_sockglue.c:1725:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1725:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1725:24: sparse:     got int *
   net/ipv4/ip_sockglue.c:1745:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1745:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1745:21: sparse:     got int *
   net/ipv4/ip_sockglue.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/ip_sockglue.c:1751:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/ip_sockglue.c:1751:21: sparse:     got int *
--
>> net/ipv4/tcp.c:639:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:639:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:639:16: sparse:     got int *
   net/ipv4/tcp.c:4054:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4054:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4054:13: sparse:     got int *
   net/ipv4/tcp.c:4104:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4104:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4104:21: sparse:     got int *
   net/ipv4/tcp.c:4110:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4110:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4110:21: sparse:     got int *
   net/ipv4/tcp.c:4122:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4122:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4122:21: sparse:     got int *
   net/ipv4/tcp.c:4130:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4130:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4130:21: sparse:     got int *
   net/ipv4/tcp.c:4141:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4141:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4141:21: sparse:     got int *
   net/ipv4/tcp.c:4144:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4144:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4144:21: sparse:     got int *
   net/ipv4/tcp.c:4151:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4151:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4151:21: sparse:     got int *
   net/ipv4/tcp.c:4155:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4155:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4155:29: sparse:     got int *
   net/ipv4/tcp.c:4159:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4159:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4159:21: sparse:     got int *
   net/ipv4/tcp.c:4169:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4169:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4169:21: sparse:     got int *
   net/ipv4/tcp.c:4175:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4175:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4175:21: sparse:     got int *
   net/ipv4/tcp.c:4203:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4203:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4203:21: sparse:     got int *
   net/ipv4/tcp.c:4264:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4264:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4264:21: sparse:     got int *
   net/ipv4/tcp.c:4270:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4270:37: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4270:37: sparse:     got int *
   net/ipv4/tcp.c:4279:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4279:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4279:29: sparse:     got int *
   net/ipv4/tcp.c:4292:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4292:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4292:29: sparse:     got int *
   net/ipv4/tcp.c:4303:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4303:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4303:21: sparse:     got int *
   net/ipv4/tcp.c:4314:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4314:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4314:29: sparse:     got int *
   net/ipv4/tcp.c:4366:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/tcp.c:4366:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/tcp.c:4366:13: sparse:     got int *
--
>> net/ipv4/raw.c:802:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:802:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:802:13: sparse:     got int *
   net/ipv4/raw.c:810:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:810:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:810:13: sparse:     got int *
   net/ipv4/raw.c:863:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:863:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:863:24: sparse:     got int *
   net/ipv4/raw.c:874:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/raw.c:874:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/raw.c:874:24: sparse:     got int *
--
>> net/ipv4/udp.c:1712:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:1712:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:1712:24: sparse:     got int *
   net/ipv4/udp.c:1719:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:1719:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:1719:24: sparse:     got int *
   net/ipv4/udp.c:2807:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:2807:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:2807:13: sparse:     got int *
   net/ipv4/udp.c:2854:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/udp.c:2854:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/udp.c:2854:13: sparse:     got int *
   net/ipv4/udp.c:1478:28: sparse: sparse: context imbalance in 'udp_rmem_release' - unexpected unlock
   net/ipv4/udp.c:1510:19: sparse: sparse: context imbalance in 'busylock_acquire' - wrong count at exit
   net/ipv4/udp.c:1522:28: sparse: sparse: context imbalance in 'busylock_release' - unexpected unlock
   net/ipv4/udp.c:2995:9: sparse: sparse: context imbalance in 'udp_get_first' - wrong count at exit
   net/ipv4/udp.c:3017:39: sparse: sparse: context imbalance in 'udp_get_next' - unexpected unlock
   net/ipv4/udp.c:3067:31: sparse: sparse: context imbalance in 'udp_seq_stop' - unexpected unlock
--
   net/ipv4/igmp.c: note: in included file (through include/linux/igmp.h):
   include/uapi/linux/igmp.h:60:32: sparse: sparse: array of flexible structures
>> net/ipv4/igmp.c:2578:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv4/igmp.c:2578:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv4/igmp.c:2578:13: sparse:     got int *
   net/ipv4/igmp.c:2929:31: sparse: sparse: context imbalance in 'igmp_mcf_get_next' - unexpected unlock
   net/ipv4/igmp.c:2957:9: sparse: sparse: context imbalance in 'igmp_mcf_get_idx' - wrong count at exit
   net/ipv4/igmp.c:2974:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_next' - wrong count at exit
   net/ipv4/igmp.c:2986:9: sparse: sparse: context imbalance in 'igmp_mcf_seq_stop' - unexpected unlock
--
>> kernel/futex/core.c:648:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:648:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:648:13: sparse:     got unsigned int *
>> kernel/futex/core.c:783:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/futex/core.c:783:13: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/futex/core.c:783:13: sparse:     got long *
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
>> kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
--
>> kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/syscalls.c:75:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned long *
>> kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean @@     got struct robust_list_head [noderef] __user ** @@
   kernel/futex/syscalls.c:77:16: sparse:     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **
--
>> kernel/futex/pi.c:1112:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/pi.c:1112:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/pi.c:1112:13: sparse:     got unsigned int *
   kernel/futex/pi.c:675:9: sparse: sparse: context imbalance in 'wake_futex_pi' - unexpected unlock
   kernel/futex/pi.c:803:9: sparse: sparse: context imbalance in '__fixup_pi_state_owner' - unexpected unlock
   kernel/futex/pi.c:1068:9: sparse: sparse: context imbalance in 'futex_lock_pi' - unexpected unlock
   kernel/futex/pi.c:1100:5: sparse: sparse: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
--
>> kernel/futex/requeue.c:458:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/requeue.c:458:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/requeue.c:458:31: sparse:     got unsigned int *
   kernel/futex/requeue.c:455:41: sparse: sparse: context imbalance in 'futex_requeue' - different lock contexts for basic block
--
>> kernel/futex/waitwake.c:473:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/waitwake.c:473:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/waitwake.c:473:29: sparse:     got unsigned int *
   kernel/futex/waitwake.c:614:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/waitwake.c:614:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/waitwake.c:614:23: sparse:     got unsigned int *
   kernel/futex/waitwake.c:262:33: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex/waitwake.c:328:6: sparse: sparse: context imbalance in 'futex_wait_queue' - unexpected unlock
   kernel/futex/waitwake.c:449:36: sparse: sparse: context imbalance in 'futex_wait_multiple_setup' - unexpected unlock
--
>> net/unix/af_unix.c:3091:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/unix/af_unix.c:3091:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/unix/af_unix.c:3091:23: sparse:     got int *
   net/unix/af_unix.c:3098:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/unix/af_unix.c:3098:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/unix/af_unix.c:3098:31: sparse:     got int *
   net/unix/af_unix.c:3112:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/unix/af_unix.c:3112:31: sparse:     expected int [noderef] __user *__ptr_clean
   net/unix/af_unix.c:3112:31: sparse:     got int *
   net/unix/af_unix.c:159:13: sparse: sparse: context imbalance in 'unix_table_double_lock' - wrong count at exit
   net/unix/af_unix.c:178:28: sparse: sparse: context imbalance in 'unix_table_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1290:13: sparse: sparse: context imbalance in 'unix_state_double_lock' - wrong count at exit
   net/unix/af_unix.c:1308:17: sparse: sparse: context imbalance in 'unix_state_double_unlock' - unexpected unlock
   net/unix/af_unix.c:1609:18: sparse: sparse: context imbalance in 'unix_stream_connect' - different lock contexts for basic block
   net/unix/af_unix.c:1972:25: sparse: sparse: context imbalance in 'unix_dgram_sendmsg' - unexpected unlock
   net/unix/af_unix.c:3255:20: sparse: sparse: context imbalance in 'unix_get_first' - wrong count at exit
   net/unix/af_unix.c:3286:34: sparse: sparse: context imbalance in 'unix_get_next' - unexpected unlock
   net/unix/af_unix.c:3316:42: sparse: sparse: context imbalance in 'unix_seq_stop' - unexpected unlock
--
>> net/ipv6/ipv6_sockglue.c:1087:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1087:21: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1105:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1105:13: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1128:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1128:13: sparse:     got int *
>> net/ipv6/ipv6_sockglue.c:1129:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1129:13: sparse:     got unsigned int *
   net/ipv6/ipv6_sockglue.c:1130:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1130:13: sparse:     got unsigned int *
   net/ipv6/ipv6_sockglue.c:1145:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1145:13: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1215:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1215:24: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1275:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1275:24: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1329:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1329:21: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1423:21: sparse:     got int *
   net/ipv6/ipv6_sockglue.c:1477:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/ipv6_sockglue.c:1477:13: sparse:     got int *
--
>> net/ipv6/raw.c:964:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:964:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:964:21: sparse:     got int *
   net/ipv6/raw.c:970:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:970:21: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:970:21: sparse:     got int *
   net/ipv6/raw.c:1062:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1062:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1062:13: sparse:     got int *
   net/ipv6/raw.c:1087:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1087:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1087:13: sparse:     got int *
   net/ipv6/raw.c:1123:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1123:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1123:24: sparse:     got int *
   net/ipv6/raw.c:1134:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ipv6/raw.c:1134:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ipv6/raw.c:1134:24: sparse:     got int *
--
>> net/ipv6/sit.c:359:54: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/sit.c:359:54: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/sit.c:359:54: sparse:     got unsigned int *
--
>> net/packet/af_packet.c:4034:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4034:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4034:13: sparse:     got int *
   net/packet/af_packet.c:4134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4134:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4134:13: sparse:     got int *
   net/packet/af_packet.c:4202:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4202:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4202:24: sparse:     got int *
   net/packet/af_packet.c:4214:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/packet/af_packet.c:4214:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/packet/af_packet.c:4214:24: sparse:     got int *
   net/packet/af_packet.c:1050:13: sparse: sparse: context imbalance in '__packet_lookup_frame_in_block' - different lock contexts for basic block
   net/packet/af_packet.c:2490:17: sparse: sparse: context imbalance in 'tpacket_rcv' - unexpected unlock
--
>> drivers/firewire/core-cdev.c:1108:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/firewire/core-cdev.c:1108:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/firewire/core-cdev.c:1108:21: sparse:     got unsigned int *
--
>> drivers/fpga/dfl.c:1837:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/fpga/dfl.c:1837:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/fpga/dfl.c:1837:16: sparse:     got unsigned int *
--
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int *
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int *
--
>> fs/cifs/cifs_debug.c:779:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   fs/cifs/cifs_debug.c:779:14: sparse:     expected char const [noderef] __user *__ptr_clean
   fs/cifs/cifs_debug.c:779:14: sparse:     got char const *
--
>> fs/cifs/ioctl.c:163:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/cifs/ioctl.c:163:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/cifs/ioctl.c:163:13: sparse:     got unsigned int *
>> fs/cifs/ioctl.c:355:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/cifs/ioctl.c:355:38: sparse:     expected int [noderef] __user *__ptr_clean
   fs/cifs/ioctl.c:355:38: sparse:     got int *
   fs/cifs/ioctl.c:365:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/cifs/ioctl.c:365:29: sparse:     expected int [noderef] __user *__ptr_clean
   fs/cifs/ioctl.c:365:29: sparse:     got int *
--
>> fs/cifs/smb2ops.c:1961:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/cifs/smb2ops.c:1961:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/cifs/smb2ops.c:1961:13: sparse:     got unsigned int *
--
>> net/sunrpc/rpc_pipe.c:380:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sunrpc/rpc_pipe.c:380:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/sunrpc/rpc_pipe.c:380:24: sparse:     got int *
--
>> net/sunrpc/cache.c:1019:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/sunrpc/cache.c:1019:16: sparse:     expected int [noderef] __user *__ptr_clean
   net/sunrpc/cache.c:1019:16: sparse:     got int *
--
   kernel/trace/trace.c:5734:1: sparse: sparse: trying to concatenate 9420-character string (8191 bytes max)
   kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
>> kernel/trace/trace.c:1604:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   kernel/trace/trace.c:1604:15: sparse:     expected char const [noderef] __user *__ptr_clean
   kernel/trace/trace.c:1604:15: sparse:     got char const *
   kernel/trace/trace.c:1618:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   kernel/trace/trace.c:1618:31: sparse:     expected char const [noderef] __user *__ptr_clean
   kernel/trace/trace.c:1618:31: sparse:     got char const *
   kernel/trace/trace.c:1643:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   kernel/trace/trace.c:1643:23: sparse:     expected char const [noderef] __user *__ptr_clean
   kernel/trace/trace.c:1643:23: sparse:     got char const *
   kernel/trace/trace.c:2864:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2864:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2864:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:360:9: sparse:    struct trace_export *
   kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:375:9: sparse:    struct trace_export *
--
   kernel/events/core.c:1402:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1415:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1415:28: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1415:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3402:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3402:18: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3402:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3403:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3403:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3403:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3451:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3451:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3451:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3452:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3452:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3452:25: sparse:    struct perf_event_context *
   kernel/events/core.c:4685:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4685:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:4685:25: sparse:    struct perf_event_context *
   kernel/events/core.c:5956:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5956:9: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5956:9: sparse:    struct perf_buffer *
   kernel/events/core.c:5428:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
>> kernel/events/core.c:11730:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/events/core.c:11842:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/events/core.c:5672:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5672:22: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5672:22: sparse:    struct perf_buffer *
   kernel/events/core.c:5796:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5796:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5796:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5829:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5829:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5829:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5886:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5886:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5886:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5977:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5977:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5977:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5993:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5993:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5993:14: sparse:    struct perf_buffer *
   kernel/events/core.c:7642:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7642:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7642:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7694:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7694:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7694:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7733:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7733:13: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:7733:13: sparse:    struct perf_buffer *
   kernel/events/core.c:7838:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7838:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7838:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:7840:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7840:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7840:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:8541:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8541:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:8541:23: sparse:    struct perf_event_context *
   kernel/events/core.c:9535:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9535:9: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9535:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:9574:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9574:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9574:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9755:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9755:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:9755:23: sparse:    struct perf_event_context *
   kernel/events/core.c:10938:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:12773:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12773:9: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12773:9: sparse:    struct perf_event_context *
   kernel/events/core.c:12883:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12883:17: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12883:17: sparse:    struct perf_event_context *
   kernel/events/core.c:13313:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:13313:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:13313:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:167:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:175:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c: note: in included file (through include/linux/rcupdate.h, include/linux/rculist.h, include/linux/dcache.h, ...):
   include/linux/rcutiny.h:114:44: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1449:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:2775:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:4657:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:209:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *buf @@
   kernel/events/core.c:9384:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9384:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9384:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9404:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9404:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9404:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9524:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9524:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9524:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9524:16: sparse:    struct swevent_hlist *
--
>> drivers/gpu/drm/drm_crtc.c:787:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_crtc.c:787:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_crtc.c:787:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_mode_object.c:404:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:404:29: sparse:     got unsigned int *
>> drivers/gpu/drm/drm_mode_object.c:407:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_object.c:407:29: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/drm_connector.c:2606:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_connector.c:2606:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_connector.c:2606:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_property.c:484:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/drm_property.c:484:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_property.c:484:21: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/drm_plane.c:672:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_plane.c:672:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_mode_config.c:114:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:114:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:114:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_mode_config.c:133:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:133:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:133:29: sparse:     got unsigned int *
   drivers/gpu/drm/drm_mode_config.c:144:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:144:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:144:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_mode_config.c:161:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_mode_config.c:161:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_mode_config.c:161:29: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_lease.c:614:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_lease.c:614:39: sparse:     got unsigned int *
   drivers/gpu/drm/drm_lease.c:669:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_lease.c:669:31: sparse:     got unsigned int *
--
>> drivers/gpu/drm/drm_atomic_uapi.c:345:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:345:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:345:13: sparse:     got signed int *
   drivers/gpu/drm/drm_atomic_uapi.c:447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:447:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:447:21: sparse:     got signed int *
   drivers/gpu/drm/drm_atomic_uapi.c:1098:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1098:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1098:13: sparse:     got signed int *
   drivers/gpu/drm/drm_atomic_uapi.c:1274:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1274:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1274:21: sparse:     got signed int *
>> drivers/gpu/drm/drm_atomic_uapi.c:1352:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1352:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1352:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_atomic_uapi.c:1369:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1369:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1369:21: sparse:     got unsigned int *
   drivers/gpu/drm/drm_atomic_uapi.c:1382:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_atomic_uapi.c:1382:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_atomic_uapi.c:1382:29: sparse:     got unsigned int *
--
>> drivers/hid/hid-roccat.c:393:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hid-roccat.c:393:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hid-roccat.c:393:21: sparse:     got int *
--
>> drivers/hid/hidraw.c:381:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hidraw.c:381:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hidraw.c:381:29: sparse:     got int *
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hidraw.c:389:37: sparse:     got int *
--
>> drivers/hid/usbhid/hiddev.c:573:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:573:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:573:13: sparse:     got int *
   drivers/hid/usbhid/hiddev.c:621:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:621:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:621:21: sparse:     got int *
   drivers/hid/usbhid/hiddev.c:660:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:660:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:660:21: sparse:     got int *
   drivers/hid/usbhid/hiddev.c:668:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/usbhid/hiddev.c:668:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/usbhid/hiddev.c:668:29: sparse:     got int *
--
>> drivers/hwmon/w83793.c:1370:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/hwmon/w83793.c:1370:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1370:37: sparse:     got char const *
>> drivers/hwmon/w83793.c:1406:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1406:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1406:23: sparse:     got int *
   drivers/hwmon/w83793.c:1410:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1410:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1410:23: sparse:     got int *
   drivers/hwmon/w83793.c:1419:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1419:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1419:23: sparse:     got int *
   drivers/hwmon/w83793.c:1423:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1423:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1423:21: sparse:     got int *
   drivers/hwmon/w83793.c:1429:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1429:31: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1429:31: sparse:     got int *
   drivers/hwmon/w83793.c:1433:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hwmon/w83793.c:1433:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hwmon/w83793.c:1433:21: sparse:     got int *
--
>> drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *
--
>> drivers/input/mousedev.c:683:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/input/mousedev.c:683:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/input/mousedev.c:683:21: sparse:     got char const *
--
>> drivers/input/joydev.c:530:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:530:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:530:24: sparse:     got signed int *
   drivers/input/joydev.c:533:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/input/joydev.c:533:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:533:24: sparse:     got signed int *
>> drivers/input/joydev.c:536:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/input/joydev.c:536:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/input/joydev.c:536:24: sparse:     got unsigned int *
>> drivers/input/joydev.c:539:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/joydev.c:539:24: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/joydev.c:539:24: sparse:     got unsigned char *
   drivers/input/joydev.c:542:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/joydev.c:542:24: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/joydev.c:542:24: sparse:     got unsigned char *
>> drivers/input/joydev.c:682:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/input/joydev.c:682:26: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/input/joydev.c:682:26: sparse:     got long *
   drivers/input/joydev.c:687:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/input/joydev.c:687:26: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/input/joydev.c:687:26: sparse:     got long *
--
>> drivers/input/evdev.c:819:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:819:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:819:13: sparse:     got int *
   drivers/input/evdev.c:854:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:854:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:854:13: sparse:     got int *
   drivers/input/evdev.c:928:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:928:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:928:13: sparse:     got int *
   drivers/input/evdev.c:936:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:936:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:936:21: sparse:     got int *
>> drivers/input/evdev.c:1017:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/input/evdev.c:1017:37: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1017:37: sparse:     got unsigned char *
   drivers/input/evdev.c:1047:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1047:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1047:24: sparse:     got int *
   drivers/input/evdev.c:1057:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1057:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1057:21: sparse:     got int *
   drivers/input/evdev.c:1059:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1059:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1059:21: sparse:     got int *
   drivers/input/evdev.c:1066:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1066:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1066:21: sparse:     got int *
   drivers/input/evdev.c:1068:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1068:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1068:21: sparse:     got int *
   drivers/input/evdev.c:1082:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/input/evdev.c:1082:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1082:21: sparse:     got int *
>> drivers/input/evdev.c:1187:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed short [noderef] __user *__ptr_clean @@     got signed short * @@
   drivers/input/evdev.c:1187:21: sparse:     expected signed short [noderef] __user *__ptr_clean
   drivers/input/evdev.c:1187:21: sparse:     got signed short *
--
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:412:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:412:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:412:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:428:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:428:13: sparse:     got unsigned short *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:431:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:431:15: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:431:15: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/gem/i915_gem_context.c:435:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:435:15: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:435:15: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:503:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:503:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:503:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:525:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:525:15: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:525:15: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:530:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:530:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:530:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:553:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:553:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:553:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:591:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:591:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:591:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:594:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:594:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:594:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:597:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:597:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:597:13: sparse:     got unsigned short *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:619:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:619:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:619:13: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:628:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:628:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:628:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/gem/i915_gem_context.c:796:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/gem/i915_gem_context.c:796:14: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/gem/i915_gem_context.c:796:14: sparse:     got unsigned long long *
--
>> drivers/gpu/drm/i915/i915_query.c:258:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_query.c:258:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:258:13: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/i915_query.c:285:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_query.c:285:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:285:21: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/i915_query.c:388:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_query.c:388:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:388:13: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_query.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_query.c:428:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:428:13: sparse:     got unsigned long long *
>> drivers/gpu/drm/i915/i915_query.c:597:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/gpu/drm/i915/i915_query.c:597:43: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_query.c:597:43: sparse:     got signed int *
--
>> drivers/gpu/drm/i915/i915_perf.c:3642:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_perf.c:3642:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3642:23: sparse:     got unsigned long long *
   drivers/gpu/drm/i915/i915_perf.c:3646:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_perf.c:3646:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:3646:23: sparse:     got unsigned long long *
>> drivers/gpu/drm/i915/i915_perf.c:4063:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_perf.c:4063:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4063:23: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_perf.c:4074:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_perf.c:4074:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_perf.c:4074:23: sparse:     got unsigned int *
--
>> drivers/gpu/drm/i915/i915_getparam.c:183:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/gpu/drm/i915/i915_getparam.c:183:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_getparam.c:183:13: sparse:     got int *
--
>> drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:31:23: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:36:31: sparse:     got unsigned int *
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:41:21: sparse:     got unsigned int *
>> drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/gpu/drm/i915/i915_user_extensions.c:53:21: sparse:     got unsigned long long *
--
>> drivers/media/rc/lirc_dev.c:365:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/rc/lirc_dev.c:365:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/rc/lirc_dev.c:365:23: sparse:     got unsigned int *
   drivers/media/rc/lirc_dev.c:569:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/media/rc/lirc_dev.c:569:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/media/rc/lirc_dev.c:569:23: sparse:     got unsigned int *
--
>> drivers/misc/xilinx_sdfec.c:735:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int enum xsdfec_order [noderef] __user *__ptr_clean @@     got unsigned int enum xsdfec_order * @@
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     expected unsigned int enum xsdfec_order [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     got unsigned int enum xsdfec_order *
>> drivers/misc/xilinx_sdfec.c:760:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected bool [noderef] __user *__ptr_clean @@     got bool * @@
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     expected bool [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     got bool *
   drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected bool [noderef] __user *__ptr_clean @@     got bool * @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected bool [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool *
--
>> drivers/mtd/mtdchar.c:409:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:409:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:409:13: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:757:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:757:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:757:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:765:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:765:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:765:21: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:766:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:766:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:766:24: sparse:     got unsigned int *
   drivers/mtd/mtdchar.c:767:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/mtd/mtdchar.c:767:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/mtd/mtdchar.c:767:24: sparse:     got unsigned int *
--
>> drivers/pps/pps.c:170:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/pps/pps.c:170:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/pps/pps.c:170:23: sparse:     got int *
--
>> drivers/rtc/rtc-abx80x.c:527:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-abx80x.c:527:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf2127.c:231:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf2127.c:231:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf8523.c:332:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf8523.c:332:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-pcf8563.c:288:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-pcf8563.c:288:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv8803.c:484:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv8803.c:484:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv8803.c:484:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv3028.c:597:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv3029c2.c:463:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv3029c2.c:463:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rv3032.c:480:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     got unsigned int *
--
>> drivers/rtc/rtc-rx8010.c:350:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/rtc/rtc-rx8010.c:350:24: sparse:     got unsigned int *
--
>> drivers/tty/tty_io.c:2285:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/tty_io.c:2285:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2285:13: sparse:     got char *
>> drivers/tty/tty_io.c:2430:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2430:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2430:13: sparse:     got int *
   drivers/tty/tty_io.c:2456:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2456:15: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2456:15: sparse:     got int *
   drivers/tty/tty_io.c:2517:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2517:34: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2517:34: sparse:     got int *
>> drivers/tty/tty_io.c:2542:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/tty_io.c:2542:18: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2542:18: sparse:     got unsigned int *
   drivers/tty/tty_io.c:2709:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_io.c:2709:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2709:24: sparse:     got int *
   drivers/tty/tty_io.c:2724:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/tty_io.c:2724:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/tty_io.c:2724:24: sparse:     got unsigned int *
--
>> drivers/tty/n_tty.c:2473:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/n_tty.c:2473:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/n_tty.c:2473:24: sparse:     got int *
>> drivers/tty/n_tty.c:2481:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/n_tty.c:2481:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/n_tty.c:2481:24: sparse:     got unsigned int *
--
>> drivers/tty/tty_ioctl.c:803:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_ioctl.c:803:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_ioctl.c:803:23: sparse:     got int *
>> drivers/tty/tty_ioctl.c:807:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/tty_ioctl.c:807:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/tty_ioctl.c:807:21: sparse:     got unsigned int *
   drivers/tty/tty_ioctl.c: note: in included file (through arch/x86/include/generated/uapi/asm/termios.h, include/uapi/linux/termios.h):
>> include/asm-generic/termios.h:25:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:25:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:25:13: sparse:     got unsigned short const *
   include/asm-generic/termios.h:29:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:29:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:29:13: sparse:     got unsigned short const *
   include/asm-generic/termios.h:33:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:33:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:33:13: sparse:     got unsigned short const *
   include/asm-generic/termios.h:37:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short const [noderef] __user *__ptr_clean @@     got unsigned short const * @@
   include/asm-generic/termios.h:37:13: sparse:     expected unsigned short const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:37:13: sparse:     got unsigned short const *
>> include/asm-generic/termios.h:41:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char const [noderef] __user *__ptr_clean @@     got unsigned char const * @@
   include/asm-generic/termios.h:41:13: sparse:     expected unsigned char const [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:41:13: sparse:     got unsigned char const *
>> include/asm-generic/termios.h:59:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:59:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:59:13: sparse:     got unsigned short *
   include/asm-generic/termios.h:60:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:60:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:60:13: sparse:     got unsigned short *
   include/asm-generic/termios.h:61:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:61:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:61:13: sparse:     got unsigned short *
   include/asm-generic/termios.h:62:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   include/asm-generic/termios.h:62:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:62:13: sparse:     got unsigned short *
>> include/asm-generic/termios.h:63:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   include/asm-generic/termios.h:63:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   include/asm-generic/termios.h:63:13: sparse:     got unsigned char *
--
   drivers/tty/tty_jobctrl.c:80:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:80:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:80:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:83:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:83:34: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:83:34: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:124:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:124:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:124:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:126:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:126:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:126:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:135:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:135:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:135:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:156:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:156:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:156:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:165:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:165:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:167:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:167:40: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:167:40: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:205:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:205:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:205:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:215:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:215:51: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:215:51: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:227:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:227:43: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:227:43: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:291:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:291:39: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:291:39: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:294:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:294:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:294:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:303:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:303:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:303:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:307:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:307:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:307:33: sparse:     got struct spinlock [noderef] __rcu *
>> drivers/tty/tty_jobctrl.c:472:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_jobctrl.c:472:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_jobctrl.c:472:16: sparse:     got int *
   drivers/tty/tty_jobctrl.c:499:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_jobctrl.c:499:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_jobctrl.c:499:13: sparse:     got int *
   drivers/tty/tty_jobctrl.c:556:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/tty_jobctrl.c:556:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/tty_jobctrl.c:556:16: sparse:     got int *
   drivers/tty/tty_jobctrl.c:19:41: sparse: sparse: dereference of noderef expression
--
>> drivers/tty/pty.c:141:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:141:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:141:13: sparse:     got int *
   drivers/tty/pty.c:154:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:154:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:154:16: sparse:     got int *
   drivers/tty/pty.c:162:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:162:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:162:13: sparse:     got int *
   drivers/tty/pty.c:184:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/pty.c:184:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:184:16: sparse:     got int *
>> drivers/tty/pty.c:655:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/pty.c:655:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/pty.c:655:24: sparse:     got unsigned int *
--
>> drivers/tty/sysrq.c:1161:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/tty/sysrq.c:1161:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/tty/sysrq.c:1161:21: sparse:     got char const *
   drivers/tty/sysrq.c:150:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
>> drivers/tty/serial/serial_core.c:1061:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/serial/serial_core.c:1061:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/serial/serial_core.c:1061:16: sparse:     got unsigned int *
   drivers/tty/serial/serial_core.c:152:9: sparse: sparse: context imbalance in 'uart_start' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:224:17: sparse: sparse: context imbalance in 'uart_port_startup' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:333:9: sparse: sparse: context imbalance in 'uart_shutdown' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:560:9: sparse: sparse: context imbalance in 'uart_put_char' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:608:9: sparse: sparse: context imbalance in 'uart_write' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:621:9: sparse: sparse: context imbalance in 'uart_write_room' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:634:9: sparse: sparse: context imbalance in 'uart_chars_in_buffer' - different lock contexts for basic block
   drivers/tty/serial/serial_core.c:661:9: sparse: sparse: context imbalance in 'uart_flush_buffer' - different lock contexts for basic block

vim +279 arch/x86/kernel/process.c

389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  269  
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  270  int get_tsc_mode(unsigned long adr)
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  271  {
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  272  	unsigned int val;
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  273  
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  274  	if (test_thread_flag(TIF_NOTSC))
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  275  		val = PR_TSC_SIGSEGV;
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  276  	else
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  277  		val = PR_TSC_ENABLE;
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  278  
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27 @279  	return put_user(val, (unsigned int __user *)adr);
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  280  }
389d1fb11e5f2a1 Jeremy Fitzhardinge 2009-02-27  281  

:::::: The code at line 279 was first introduced by commit
:::::: 389d1fb11e5f2a16b5e34c547756f0c4dec641f7 x86: unify chunks of kernel/process*.c

:::::: TO: Jeremy Fitzhardinge <jeremy@goop.org>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
