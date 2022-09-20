Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8402D5BE326
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiITK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiITK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:26:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6347198B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663669587; x=1695205587;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VoOytQWTXbQIFKidNNHAdMHfPT7haYxdnyvgQE2uRtQ=;
  b=kV5sPZL4iXJ9pCWzDqs9gGuZyBBhyUpkBsGI9A0bmWBYBUIIlFCTK448
   +1Vgripx/9uWhCGmar12wYXDI2B5299kYXLVNochFCHezxdjXKY3AbmSY
   ZMVPLTMFMa6Mveq4uOAWo1xiHPT3Mcuv3sobkr56Z/LhO5lJrxTsUT0Oi
   KlJ3uKPpiWIxz7igcWfTYdoJ/KU2WN2bX4EoDiZPK7UtLKigk9rTF9eXJ
   w0SDNwfA9lkBPCZ/G3xuwZ3L60HGtUyTsEcgrp+s/R+MOrogsjgNiXrR1
   LQAhUZerx1Pdb4HKUpczHl2ZITJI6J0TVIl/PD5wAsbgEMAQ2epkoCvom
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363615894"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="363615894"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 03:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="947615795"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2022 03:26:25 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaaSO-0002fx-2Z;
        Tue, 20 Sep 2022 10:26:24 +0000
Date:   Tue, 20 Sep 2022 18:25:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] drivers/input/serio/serport.c:216:21: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202209201829.bNE1v4V7-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s023-20220919 (https://download.01.org/0day-ci/archive/20220920/202209201829.bNE1v4V7-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/ drivers/input/serio/ drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/input/serio/serport.c:216:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/input/serio/serport.c:216:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/input/serio/serport.c:216:21: sparse:     got unsigned long *
--
>> drivers/input/serio/serio_raw.c:178:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/input/serio/serio_raw.c:178:29: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:178:29: sparse:     got char *
>> drivers/input/serio/serio_raw.c:219:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/input/serio/serio_raw.c:219:21: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/input/serio/serio_raw.c:219:21: sparse:     got char const *

vim +216 drivers/input/serio/serport.c

a80d8b02751060 John Sung      2014-09-09  205  
^1da177e4c3f41 Linus Torvalds 2005-04-16  206  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  207   * serport_ldisc_ioctl() allows to set the port protocol, and device ID
^1da177e4c3f41 Linus Torvalds 2005-04-16  208   */
^1da177e4c3f41 Linus Torvalds 2005-04-16  209  
d78328bcc4d0e6 Jiri Slaby     2021-11-22  210  static int serport_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
d78328bcc4d0e6 Jiri Slaby     2021-11-22  211  			       unsigned long arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  212  {
a80d8b02751060 John Sung      2014-09-09  213  	if (cmd == SPIOCSTYPE) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  214  		unsigned long type;
^1da177e4c3f41 Linus Torvalds 2005-04-16  215  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @216  		if (get_user(type, (unsigned long __user *) arg))
^1da177e4c3f41 Linus Torvalds 2005-04-16  217  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  218  
a80d8b02751060 John Sung      2014-09-09  219  		serport_set_type(tty, type);
a80d8b02751060 John Sung      2014-09-09  220  		return 0;
a80d8b02751060 John Sung      2014-09-09  221  	}
a80d8b02751060 John Sung      2014-09-09  222  
a80d8b02751060 John Sung      2014-09-09  223  	return -EINVAL;
a80d8b02751060 John Sung      2014-09-09  224  }
a80d8b02751060 John Sung      2014-09-09  225  

:::::: The code at line 216 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
