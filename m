Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B795BE923
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiITOfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiITOfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:35:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDC418E0A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663684506; x=1695220506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MF/8ZX8mOeo9BWL0NrGzVeCvWmunmVFVnQ9tO8sJfuc=;
  b=EC5IS2RCYKgBTe1ad2NaPVMMScMmh579FV84FNEboxh4pZpGW3qrAQkU
   uzpHi8kg8fYEITU9W3WzOHbhMKNBxJRvzgLf8YKJEcZ/zFEsPt1xvFTAD
   5paEoF3opD8vBl/m1c0GxiGbCGoDNQA3wEHgtHooH0XSW0Gi4MyUL0zi2
   uEsnbKp0YR8eoZlk/T/D9dADlX0m8Bq+xdh58SmE0u3cMoyWF9Qzu+Oon
   7ybK6o6VQ+EZrq5ckoUDvuHxoajeH/J2DqSCq0K79N0MxLKDPLpvtzKk4
   r6JtGvVNKGaAuT6qrEWVriNVeGxJ41us32IOAecQ6uHsjfQYUWBBAc8H3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279435722"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="279435722"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 07:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="652116346"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 07:35:03 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaeL0-0002oJ-2g;
        Tue, 20 Sep 2022 14:35:02 +0000
Date:   Tue, 20 Sep 2022 22:34:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] drivers/atm/nicstar.c:2484:21: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202209202244.hC5VeDij-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8836fbd6cd3120383a0bc63cd54c7dd55639ed49
commit: 2600a472582e2968633831d430c2a1366ad3e8b1 [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s021-20220919 (https://download.01.org/0day-ci/archive/20220920/202209202244.hC5VeDij-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/atm/nicstar.c:553:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_2 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:553:17: sparse:     expected unsigned int [usertype] word_2
   drivers/atm/nicstar.c:553:17: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:572:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_4 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:572:17: sparse:     expected unsigned int [usertype] word_4
   drivers/atm/nicstar.c:572:17: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1147:29: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1152:56: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1482:30: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1488:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_1 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1488:44: sparse:     expected unsigned int [usertype] word_1
   drivers/atm/nicstar.c:1488:44: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1491:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_2 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1491:44: sparse:     expected unsigned int [usertype] word_2
   drivers/atm/nicstar.c:1491:44: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1803:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_1 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1803:36: sparse:     expected unsigned int [usertype] word_1
   drivers/atm/nicstar.c:1803:36: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1809:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_2 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1809:36: sparse:     expected unsigned int [usertype] word_2
   drivers/atm/nicstar.c:1809:36: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1858:17: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1858:52: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1859:17: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1865:24: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1872:22: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1873:32: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1881:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_2 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1881:41: sparse:     expected unsigned int [usertype] word_2
   drivers/atm/nicstar.c:1881:41: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1886:46: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1891:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_2 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1891:17: sparse:     expected unsigned int [usertype] word_2
   drivers/atm/nicstar.c:1891:17: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1960:14: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1970:18: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:1964:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_4 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1964:17: sparse:     expected unsigned int [usertype] word_4
   drivers/atm/nicstar.c:1964:17: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1991:14: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2008:15: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2009:15: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2033:26: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2051:47: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2052:30: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2053:39: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2111:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *iov_base @@     got void * @@
   drivers/atm/nicstar.c:2111:23: sparse:     expected void [noderef] __user *iov_base
   drivers/atm/nicstar.c:2111:23: sparse:     got void *
   drivers/atm/nicstar.c:2112:24: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2145:13: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2151:21: sparse: sparse: cast to restricted __le32
   drivers/atm/nicstar.c:2184:31: sparse: sparse: cast removes address space '__user' of expression
   drivers/atm/nicstar.c:2291:39: sparse: sparse: cast removes address space '__user' of expression
   drivers/atm/nicstar.c:2302:47: sparse: sparse: cast removes address space '__user' of expression
   drivers/atm/nicstar.c:2345:39: sparse: sparse: cast removes address space '__user' of expression
>> drivers/atm/nicstar.c:2484:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/nicstar.c:2484:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/nicstar.c:2484:21: sparse:     got int *
   drivers/atm/nicstar.c:2579:26: sparse: sparse: cast removes address space '__user' of expression
   drivers/atm/nicstar.c:1671:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_2 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1671:29: sparse:     expected unsigned int [usertype] word_2
   drivers/atm/nicstar.c:1671:29: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1672:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_3 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1672:29: sparse:     expected unsigned int [usertype] word_3
   drivers/atm/nicstar.c:1672:29: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1673:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_4 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1673:29: sparse:     expected unsigned int [usertype] word_4
   drivers/atm/nicstar.c:1673:29: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1682:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_2 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1682:29: sparse:     expected unsigned int [usertype] word_2
   drivers/atm/nicstar.c:1682:29: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1683:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_3 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1683:29: sparse:     expected unsigned int [usertype] word_3
   drivers/atm/nicstar.c:1683:29: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1686:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_4 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1686:29: sparse:     expected unsigned int [usertype] word_4
   drivers/atm/nicstar.c:1686:29: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1689:29: sparse: sparse: invalid assignment: |=
   drivers/atm/nicstar.c:1689:29: sparse:    left side has type unsigned int
   drivers/atm/nicstar.c:1689:29: sparse:    right side has type restricted __le32
   drivers/atm/nicstar.c:1697:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_1 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1697:29: sparse:     expected unsigned int [usertype] word_1
   drivers/atm/nicstar.c:1697:29: sparse:     got restricted __le32 [usertype]
   drivers/atm/nicstar.c:1700:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] word_1 @@     got restricted __le32 [usertype] @@
   drivers/atm/nicstar.c:1700:29: sparse:     expected unsigned int [usertype] word_1
   drivers/atm/nicstar.c:1700:29: sparse:     got restricted __le32 [usertype]
--
   drivers/atm/fore200e.c:437:12: sparse: sparse: cast to restricted __le32
   drivers/atm/fore200e.c:445:12: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@
   drivers/atm/fore200e.c:445:12: sparse:     expected unsigned int val
   drivers/atm/fore200e.c:445:12: sparse:     got restricted __le32 [usertype]
>> drivers/atm/fore200e.c:1866:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/fore200e.c:1866:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/fore200e.c:1866:16: sparse:     got int *
   drivers/atm/fore200e.c:1872:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/fore200e.c:1872:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/fore200e.c:1872:16: sparse:     got int *
   drivers/atm/fore200e.c:1875:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/fore200e.c:1875:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/fore200e.c:1875:16: sparse:     got int *
--
>> drivers/atm/suni.c:119:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/suni.c:119:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/suni.c:119:13: sparse:     got int *
   drivers/atm/suni.c:128:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/suni.c:128:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/suni.c:128:16: sparse:     got int *
   drivers/atm/suni.c:148:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/suni.c:148:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/suni.c:148:16: sparse:     got int *
   drivers/atm/suni.c:236:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/suni.c:236:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/suni.c:236:16: sparse:     got int *
   drivers/atm/suni.c:243:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/suni.c:243:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/suni.c:243:13: sparse:     got int *
   drivers/atm/suni.c:280:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/suni.c:280:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/suni.c:280:32: sparse:     got int *
   drivers/atm/suni.c:283:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/suni.c:283:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/suni.c:283:32: sparse:     got int *
--
>> drivers/atm/idt77105.c:201:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/idt77105.c:201:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/idt77105.c:201:32: sparse:     got int *
   drivers/atm/idt77105.c:204:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/atm/idt77105.c:204:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/atm/idt77105.c:204:32: sparse:     got int *
   drivers/atm/idt77105.c:303:35: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     got int *
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     got int *
>> drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     got signed int *
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     got int *
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     got int *
>> drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     got unsigned int *
--
>> drivers/cdrom/cdrom.c:3284:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/cdrom/cdrom.c:3284:24: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/cdrom/cdrom.c:3284:24: sparse:     got signed int *
>> drivers/cdrom/cdrom.c:3286:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   drivers/cdrom/cdrom.c:3286:16: sparse:     expected long [noderef] __user *__ptr_clean
   drivers/cdrom/cdrom.c:3286:16: sparse:     got long *
--
>> net/ipv4/af_inet.c:990:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/af_inet.c:990:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:990:13: sparse:     got unsigned short *
>> net/ipv4/af_inet.c:991:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected short [noderef] __user *__ptr_clean @@     got short * @@
   net/ipv4/af_inet.c:991:13: sparse:     expected short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:991:13: sparse:     got short *
>> net/ipv4/af_inet.c:992:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:992:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:992:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:993:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:993:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:993:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:994:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv4/af_inet.c:994:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:994:13: sparse:     got unsigned short *
   net/ipv4/af_inet.c:995:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv4/af_inet.c:995:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv4/af_inet.c:995:13: sparse:     got unsigned int *
   net/ipv4/af_inet.c:1501:59: sparse: sparse: restricted __be16 degrades to integer
--
   fs/ext4/ioctl.c:803:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:803:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:803:13: sparse:     got unsigned int *
   fs/ext4/ioctl.c:1226:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext4/ioctl.c:1226:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1226:24: sparse:     got int *
   fs/ext4/ioctl.c:1246:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/ext4/ioctl.c:1246:21: sparse:     expected int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1246:21: sparse:     got int *
   fs/ext4/ioctl.c:1279:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1279:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1279:21: sparse:     got unsigned int *
   fs/ext4/ioctl.c:1560:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1560:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1560:24: sparse:     got unsigned int *
   fs/ext4/ioctl.c:1641:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1641:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1641:23: sparse:     got unsigned int *
>> fs/ext4/ioctl.c:1642:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/ext4/ioctl.c:1642:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1642:24: sparse:     got unsigned long long *
   fs/ext4/ioctl.c:1643:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/ext4/ioctl.c:1643:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1643:24: sparse:     got unsigned long long *
   fs/ext4/ioctl.c:1644:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   fs/ext4/ioctl.c:1644:24: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1644:24: sparse:     got unsigned long long *
   fs/ext4/ioctl.c:1645:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/ext4/ioctl.c:1645:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1645:24: sparse:     got unsigned int *
>> fs/ext4/ioctl.c:1646:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/ext4/ioctl.c:1646:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/ext4/ioctl.c:1646:24: sparse:     got unsigned short *
--
>> net/ipv6/af_inet6.c:612:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:612:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:612:13: sparse:     got unsigned int *
>> net/ipv6/af_inet6.c:613:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/af_inet6.c:613:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:613:13: sparse:     got unsigned short *
   net/ipv6/af_inet6.c:614:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/ipv6/af_inet6.c:614:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:614:13: sparse:     got unsigned short *
   net/ipv6/af_inet6.c:615:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:615:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:615:13: sparse:     got unsigned int *
   net/ipv6/af_inet6.c:616:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:616:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:616:13: sparse:     got unsigned int *
   net/ipv6/af_inet6.c:617:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/ipv6/af_inet6.c:617:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:617:13: sparse:     got unsigned int *
>> net/ipv6/af_inet6.c:618:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/ipv6/af_inet6.c:618:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/ipv6/af_inet6.c:618:13: sparse:     got signed int *
--
>> drivers/video/fbdev/core/fbmem.c:1269:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1269:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1269:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1271:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1272:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1272:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1272:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1273:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1273:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1273:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1274:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1274:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1274:16: sparse:     got unsigned int *
>> drivers/video/fbdev/core/fbmem.c:1275:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1275:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1275:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1276:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1276:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1276:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1277:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/video/fbdev/core/fbmem.c:1277:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1277:16: sparse:     got unsigned short *
   drivers/video/fbdev/core/fbmem.c:1278:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1278:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1278:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1281:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1281:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1281:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1283:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1283:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1283:16: sparse:     got unsigned int *
   drivers/video/fbdev/core/fbmem.c:1284:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/core/fbmem.c:1284:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/core/fbmem.c:1284:16: sparse:     got unsigned int *
--
>> drivers/fsi/fsi-sbefifo.c:942:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/fsi/fsi-sbefifo.c:942:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/fsi/fsi-sbefifo.c:942:13: sparse:     got unsigned int *
--
>> drivers/tee/tee_core.c:447:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:447:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:447:29: sparse:     got unsigned long long *
   drivers/tee/tee_core.c:448:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:448:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:448:29: sparse:     got unsigned long long *
   drivers/tee/tee_core.c:449:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:449:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:449:29: sparse:     got unsigned long long *
   drivers/tee/tee_core.c:454:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:454:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:454:29: sparse:     got unsigned long long *
>> drivers/tee/tee_core.c:516:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:516:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:516:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:517:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:517:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:517:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:518:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:518:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:586:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:586:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:586:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:587:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:587:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:587:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:699:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:699:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:699:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:717:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:717:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:717:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:718:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:718:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:718:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:797:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:797:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:797:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:798:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:798:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:798:13: sparse:     got unsigned int *
--
>> drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse:     got unsigned int *
--
   net/appletalk/ddp.c:100:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:113:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:409:47: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:1810:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/appletalk/ddp.c:1810:22: sparse:     expected int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1810:22: sparse:     got int *
   net/appletalk/ddp.c:1823:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/appletalk/ddp.c:1823:22: sparse:     expected int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1823:22: sparse:     got int *
>> net/appletalk/ddp.c:1860:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/appletalk/ddp.c:1860:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1860:13: sparse:     got unsigned short *
>> net/appletalk/ddp.c:1861:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected short [noderef] __user *__ptr_clean @@     got short * @@
   net/appletalk/ddp.c:1861:13: sparse:     expected short [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1861:13: sparse:     got short *
>> net/appletalk/ddp.c:1862:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/appletalk/ddp.c:1862:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1862:13: sparse:     got unsigned int *
   net/appletalk/ddp.c:1863:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/appletalk/ddp.c:1863:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1863:13: sparse:     got unsigned int *
   net/appletalk/ddp.c:1864:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/appletalk/ddp.c:1864:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1864:13: sparse:     got unsigned short *
   net/appletalk/ddp.c:1865:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/appletalk/ddp.c:1865:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1865:13: sparse:     got unsigned int *
--
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/fat/dir.c:759:1: sparse:     expected long [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:759:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char *
   fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short *
   fs/fat/dir.c:812:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:812:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:812:13: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
>> fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned int *
>> fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/fat/dir.c:823:1: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got signed int *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   fs/fat/dir.c:823:1: sparse:     expected char [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got char *
   fs/fat/dir.c:823:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:823:1: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:823:1: sparse:     got unsigned short *
   fs/fat/dir.c:850:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   fs/fat/dir.c:850:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   fs/fat/dir.c:850:13: sparse:     got unsigned short *
--
>> drivers/net/ppp/ppp_generic.c:1041:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1041:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1041:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:1048:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1048:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1048:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:1055:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1055:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1055:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:1070:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1070:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1070:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:742:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:742:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:742:29: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:752:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:752:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:752:29: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:797:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:797:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:797:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:804:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:804:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:804:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:821:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:821:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:821:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:836:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:836:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:836:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:842:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:842:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:842:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:849:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:849:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:849:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:871:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:871:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:871:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int *
--
>> drivers/net/ppp/ppp_synctty.c:407:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_synctty.c:407:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:407:21: sparse:     got int *
   drivers/net/ppp/ppp_synctty.c:412:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_synctty.c:412:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:412:21: sparse:     got int *
>> drivers/net/ppp/ppp_synctty.c:422:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_synctty.c:422:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:422:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_synctty.c:427:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_synctty.c:427:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:427:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_synctty.c:433:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_synctty.c:433:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:433:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_synctty.c:438:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_synctty.c:438:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:438:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_synctty.c:458:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_synctty.c:458:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:458:21: sparse:     got int *
   drivers/net/ppp/ppp_synctty.c:463:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_synctty.c:463:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:463:21: sparse:     got int *
   drivers/net/ppp/ppp_synctty.c:289:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_synctty.c:289:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:289:21: sparse:     got int *
   drivers/net/ppp/ppp_synctty.c:296:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_synctty.c:296:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:296:21: sparse:     got int *
   drivers/net/ppp/ppp_synctty.c:310:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_synctty.c:310:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_synctty.c:310:21: sparse:     got int *
   drivers/net/ppp/ppp_synctty.c:587:1: sparse: sparse: context imbalance in 'ppp_sync_push' - wrong count at exit
--
>> drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse:     got unsigned int *
--
>> net/compat.c:153:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/compat.c:153:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/compat.c:153:21: sparse:     got unsigned int *
>> net/compat.c:305:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/compat.c:305:23: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/compat.c:305:23: sparse:     got signed int *
   net/compat.c:307:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   net/compat.c:307:31: sparse:     expected signed int [noderef] __user *__ptr_clean
   net/compat.c:307:31: sparse:     got signed int *
   net/compat.c:309:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/compat.c:309:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/compat.c:309:31: sparse:     got unsigned int *
--
>> drivers/scsi/ch.c:552:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/ch.c:552:17: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/ch.c:552:17: sparse:     got unsigned char *
--
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:415:21: sparse:     got int *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:419:32: sparse:     got int *
   drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:425:32: sparse:     got signed int *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:431:32: sparse:     got int *
   drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/scsi/sg.c:638:13: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:638:13: sparse:     got char const *
>> drivers/scsi/sg.c:907:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/sg.c:907:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:907:21: sparse:     got unsigned int *
   drivers/scsi/sg.c:908:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/sg.c:908:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:908:21: sparse:     got unsigned int *
   drivers/scsi/sg.c:909:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:909:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:909:21: sparse:     got int *
   drivers/scsi/sg.c:952:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:952:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:952:26: sparse:     got int *
   drivers/scsi/sg.c:975:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:975:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:975:24: sparse:     got int *
   drivers/scsi/sg.c:995:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:995:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:995:26: sparse:     got int *
   drivers/scsi/sg.c:1006:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1006:40: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1006:40: sparse:     got int *
   drivers/scsi/sg.c:1010:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1010:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1010:24: sparse:     got int *
   drivers/scsi/sg.c:1019:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1019:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1019:24: sparse:     got int *
   drivers/scsi/sg.c:1021:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1021:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1021:24: sparse:     got int *
   drivers/scsi/sg.c:1023:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1023:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1023:26: sparse:     got int *
   drivers/scsi/sg.c:1046:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1046:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1046:24: sparse:     got int *
   drivers/scsi/sg.c:1048:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1048:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1048:26: sparse:     got int *
   drivers/scsi/sg.c:1054:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1054:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1054:24: sparse:     got int *
   drivers/scsi/sg.c:1056:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1056:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1056:26: sparse:     got int *
   drivers/scsi/sg.c:1062:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1062:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1062:24: sparse:     got int *
   drivers/scsi/sg.c:1064:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1064:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1064:26: sparse:     got int *
   drivers/scsi/sg.c:1072:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1072:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1072:24: sparse:     got int *
   drivers/scsi/sg.c:1076:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1076:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1076:24: sparse:     got int *
   drivers/scsi/sg.c:1102:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1102:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1102:24: sparse:     got int *
   drivers/scsi/sg.c:1108:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1108:26: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1108:26: sparse:     got int *
   drivers/scsi/sg.c:1114:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/scsi/sg.c:1114:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/scsi/sg.c:1114:24: sparse:     got int *
--
>> drivers/scsi/megaraid.c:3003:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/megaraid.c:3003:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3003:21: sparse:     got unsigned int *
   drivers/scsi/megaraid.c:3009:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/scsi/megaraid.c:3009:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3009:21: sparse:     got unsigned int *
>> drivers/scsi/megaraid.c:3519:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3519:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3519:21: sparse:     got unsigned char *
>> drivers/scsi/megaraid.c:3526:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean @@     got struct mega_passthru [noderef] [usertype] __user ** @@
   drivers/scsi/megaraid.c:3526:29: sparse:     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3526:29: sparse:     got struct mega_passthru [noderef] [usertype] __user **
   drivers/scsi/megaraid.c:3529:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3529:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3529:29: sparse:     got unsigned char *
   drivers/scsi/megaraid.c:3536:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3536:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3536:21: sparse:     got unsigned char *
   drivers/scsi/megaraid.c:3543:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean @@     got struct mega_passthru [noderef] [usertype] __user ** @@
   drivers/scsi/megaraid.c:3543:29: sparse:     expected struct mega_passthru [noderef] [usertype] __user *[noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3543:29: sparse:     got struct mega_passthru [noderef] [usertype] __user **
   drivers/scsi/megaraid.c:3546:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/scsi/megaraid.c:3546:29: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/scsi/megaraid.c:3546:29: sparse:     got unsigned char *
   drivers/scsi/megaraid.c:4470:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4470:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4470:26: sparse:     got void *
   drivers/scsi/megaraid.c:4529:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4529:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4529:26: sparse:     got void *
--
>> net/atm/svc.c:509:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/svc.c:509:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/svc.c:509:13: sparse:     got int *
--
>> net/atm/ioctl.c:70:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:70:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:70:25: sparse:     got int *
   net/atm/ioctl.c:82:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:82:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:82:25: sparse:     got int *
>> net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/atm/ioctl.c:125:25: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/atm/ioctl.c:125:25: sparse:     got unsigned short *
>> net/atm/ioctl.c:173:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:173:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:173:29: sparse:     got unsigned int *
>> net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   net/atm/ioctl.c:180:29: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user **
   net/atm/ioctl.c:193:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:193:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:193:29: sparse:     got unsigned int *
   net/atm/ioctl.c:196:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:196:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:196:29: sparse:     got int *
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   net/atm/ioctl.c:203:29: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user **
   net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:205:29: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:205:29: sparse:     got int *
   net/atm/ioctl.c:280:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:280:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:280:13: sparse:     got unsigned int *
   net/atm/ioctl.c:293:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/atm/ioctl.c:293:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:293:13: sparse:     got unsigned int *
   net/atm/ioctl.c:293:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/ioctl.c:293:45: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/ioctl.c:293:45: sparse:     got int *
--
>> net/atm/common.c:795:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/common.c:795:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/common.c:795:13: sparse:     got int *
>> net/atm/common.c:808:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   net/atm/common.c:808:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   net/atm/common.c:808:24: sparse:     got unsigned long *
--
>> net/atm/resources.c:201:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:201:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:201:13: sparse:     got int *
   net/atm/resources.c:221:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:221:18: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:221:18: sparse:     got int *
   net/atm/resources.c:233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:233:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:233:13: sparse:     got int *
   net/atm/resources.c:352:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:352:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:352:25: sparse:     got int *
   net/atm/resources.c:395:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/resources.c:395:25: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/resources.c:395:25: sparse:     got int *
--
   drivers/i2c/i2c-dev.c:432:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/i2c/i2c-dev.c:432:24: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/i2c/i2c-dev.c:432:24: sparse:     got unsigned long *
>> drivers/i2c/i2c-dev.c:526:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/i2c/i2c-dev.c:526:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/i2c/i2c-dev.c:526:24: sparse:     got unsigned int *
--
>> net/ieee802154/socket.c:533:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:533:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:533:24: sparse:     got int *
   net/ieee802154/socket.c:552:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:552:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:552:24: sparse:     got int *
   net/ieee802154/socket.c:836:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:836:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:836:13: sparse:     got int *
   net/ieee802154/socket.c:866:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ieee802154/socket.c:866:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ieee802154/socket.c:866:13: sparse:     got int *
--
   fs/autofs/root.c:812:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:812:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:812:16: sparse:     got int *
   fs/autofs/root.c:819:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:819:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:819:16: sparse:     got int *
   fs/autofs/root.c:790:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:790:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:790:14: sparse:     got unsigned long *
   fs/autofs/root.c:794:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/autofs/root.c:794:14: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/autofs/root.c:794:14: sparse:     got unsigned long *
>> fs/autofs/root.c:765:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/autofs/root.c:765:14: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/autofs/root.c:765:14: sparse:     got unsigned int *
   fs/autofs/root.c:769:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/autofs/root.c:769:14: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/autofs/root.c:769:14: sparse:     got unsigned int *
   fs/autofs/root.c:834:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/autofs/root.c:834:18: sparse:     expected int [noderef] __user *__ptr_clean
   fs/autofs/root.c:834:18: sparse:     got int *
--
>> net/nfc/llcp_sock.c:319:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/nfc/llcp_sock.c:319:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:319:13: sparse:     got int *
>> net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int *
   net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/nfc/llcp_sock.c:375:13: sparse:     got int *
--
>> drivers/tty/vt/vt_ioctl.c:328:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt_ioctl.c:328:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:328:24: sparse:     got char *
>> drivers/tty/vt/vt_ioctl.c:386:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:386:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:386:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:406:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:406:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:406:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:415:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:415:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:415:24: sparse:     got int *
>> drivers/tty/vt/vt_ioctl.c:811:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:811:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:811:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:821:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:821:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:821:24: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:834:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/tty/vt/vt_ioctl.c:834:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:834:24: sparse:     got int *
   drivers/tty/vt/vt_ioctl.c:917:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:917:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:917:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:918:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:918:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:918:21: sparse:     got unsigned short *
   drivers/tty/vt/vt_ioctl.c:952:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/vt_ioctl.c:952:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/vt_ioctl.c:952:24: sparse:     got unsigned short *
--
>> drivers/tty/vt/consolemap.c:359:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/tty/vt/consolemap.c:359:21: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/tty/vt/consolemap.c:359:21: sparse:     got unsigned char *
>> drivers/tty/vt/consolemap.c:830:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/consolemap.c:830:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/consolemap.c:830:13: sparse:     got unsigned short *
--
>> drivers/tty/vt/keyboard.c:1724:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1724:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1724:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1751:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1751:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1769:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1769:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1769:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1807:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1807:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1807:21: sparse:     got unsigned int *
   drivers/tty/vt/keyboard.c:1913:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tty/vt/keyboard.c:1913:30: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:1913:30: sparse:     got unsigned int *
>> drivers/tty/vt/keyboard.c:2033:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/tty/vt/keyboard.c:2033:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2033:24: sparse:     got unsigned short *
>> drivers/tty/vt/keyboard.c:2067:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __user *__ptr_clean @@     got unsigned char * @@
   drivers/tty/vt/keyboard.c:2067:13: sparse:     expected unsigned char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2067:13: sparse:     got unsigned char *
>> drivers/tty/vt/keyboard.c:2125:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/keyboard.c:2125:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2125:24: sparse:     got char *
   drivers/tty/vt/keyboard.c:2143:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/keyboard.c:2143:24: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/keyboard.c:2143:24: sparse:     got char *
--
>> drivers/tty/vt/vt.c:4338:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:4338:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:4338:13: sparse:     got char *
   drivers/tty/vt/vt.c:3193:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3193:13: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3193:13: sparse:     got char *
   drivers/tty/vt/vt.c:3225:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3225:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3225:31: sparse:     got char *
   drivers/tty/vt/vt.c:3231:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3231:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3231:31: sparse:     got char *
   drivers/tty/vt/vt.c:3240:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3240:31: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3240:31: sparse:     got char *
   drivers/tty/vt/vt.c:3246:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   drivers/tty/vt/vt.c:3246:37: sparse:     expected char [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3246:37: sparse:     got char *
>> drivers/tty/vt/vt.c:3259:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   drivers/tty/vt/vt.c:3259:29: sparse:     expected signed int [noderef] __user *__ptr_clean
   drivers/tty/vt/vt.c:3259:29: sparse:     got signed int *
--
>> fs/udf/file.c:208:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/udf/file.c:208:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/udf/file.c:208:21: sparse:     got long *
   fs/udf/file.c:213:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/udf/file.c:213:34: sparse:     expected long [noderef] __user *__ptr_clean
   fs/udf/file.c:213:34: sparse:     got long *
>> fs/udf/file.c:216:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/udf/file.c:216:24: sparse:     expected int [noderef] __user *__ptr_clean
   fs/udf/file.c:216:24: sparse:     got int *
--
>> fs/nilfs2/ioctl.c:165:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/nilfs2/ioctl.c:165:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/nilfs2/ioctl.c:165:16: sparse:     got int *
--
>> drivers/watchdog/alim1535_wdt.c:153:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/alim1535_wdt.c:153:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:153:37: sparse:     got char const *
>> drivers/watchdog/alim1535_wdt.c:194:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:194:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:194:24: sparse:     got int *
   drivers/watchdog/alim1535_wdt.c:199:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:199:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:199:21: sparse:     got int *
   drivers/watchdog/alim1535_wdt.c:217:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:217:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:217:21: sparse:     got int *
   drivers/watchdog/alim1535_wdt.c:225:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/alim1535_wdt.c:225:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/alim1535_wdt.c:225:24: sparse:     got int *
--
>> arch/x86/entry/common.c:161:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/entry/common.c:161:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/entry/common.c:161:23: sparse:     got unsigned int *
--
   arch/x86/kernel/ptrace.c:741:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   arch/x86/kernel/ptrace.c:741:23: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:741:23: sparse:     got unsigned long *
>> arch/x86/kernel/ptrace.c:1057:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/ptrace.c:1057:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/ptrace.c:1057:31: sparse:     got unsigned int *
--
>> arch/x86/kernel/tls.c:138:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/tls.c:138:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/tls.c:138:21: sparse:     got unsigned int *
   arch/x86/kernel/tls.c:220:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/tls.c:220:26: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/tls.c:220:26: sparse:     got unsigned int *
--
>> arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:265:24: sparse:     got int *
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:267:24: sparse:     got int *
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     expected int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mce/dev-mcelog.c:275:24: sparse:     got int *
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
   kernel/ptrace.c:1055:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
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
>> kernel/ptrace.c:1346:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/ptrace.c:1346:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/ptrace.c:1346:31: sparse:     got unsigned int *
   kernel/ptrace.c:1357:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/ptrace.c:1357:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/ptrace.c:1357:23: sparse:     got unsigned int *
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
   kernel/signal.c:3197:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3197:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3200:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3200:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3200:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3589:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3589:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3589:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3601:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3601:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3601:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3606:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3606:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3606:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3611:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3611:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3611:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4065:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4065:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4065:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4077:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4077:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4077:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4095:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *k @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:4095:11: sparse:     expected struct k_sigaction *k
   kernel/signal.c:4095:11: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:4097:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4097:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4097:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4099:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4099:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4099:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4147:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4147:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4147:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:69:34: sparse: sparse: dereference of noderef expression
   kernel/signal.c:529:35: sparse: sparse: dereference of noderef expression
   kernel/signal.c:557:52: sparse: sparse: dereference of noderef expression
   kernel/signal.c:1038:13: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1299:9: sparse: sparse: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:735:9: sparse: sparse: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file:
   include/linux/signalfd.h:21:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:21:13: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:21:13: sparse:     got struct wait_queue_head [noderef] __rcu *
   include/linux/signalfd.h:22:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct wait_queue_head *wq_head @@     got struct wait_queue_head [noderef] __rcu * @@
   include/linux/signalfd.h:22:17: sparse:     expected struct wait_queue_head *wq_head
   include/linux/signalfd.h:22:17: sparse:     got struct wait_queue_head [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/sched/cputime.h):
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in 'send_sigqueue' - wrong count at exit
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2068:40: sparse: sparse: dereference of noderef expression
   kernel/signal.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/x86/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2383:13: sparse: sparse: context imbalance in 'do_signal_stop' - different lock contexts for basic block
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   kernel/signal.c:2590:49: sparse: sparse: dereference of noderef expression
   include/linux/ptrace.h:92:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   include/linux/ptrace.h:92:40: sparse:     expected struct task_struct *p1
   include/linux/ptrace.h:92:40: sparse:     got struct task_struct [noderef] __rcu *real_parent
   include/linux/ptrace.h:92:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p2 @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:92:60: sparse:     expected struct task_struct *p2
   include/linux/ptrace.h:92:60: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2710:33: sparse: sparse: context imbalance in 'get_signal' - unexpected unlock
   kernel/signal.c:4066:33: sparse: sparse: dereference of noderef expression
   kernel/signal.c:4155:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4155:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4155:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4161:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4161:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4161:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:4344:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4344:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4344:16: sparse:     got unsigned int *
>> kernel/signal.c:4451:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4451:23: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4451:23: sparse:     got unsigned int const *
   kernel/signal.c:4454:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4454:24: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4454:24: sparse:     got unsigned int const *
   kernel/signal.c:4458:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   kernel/signal.c:4458:24: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   kernel/signal.c:4458:24: sparse:     got unsigned int const *
   kernel/signal.c:4465:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4465:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4465:23: sparse:     got unsigned int *
   kernel/signal.c:4469:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4469:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4469:24: sparse:     got unsigned int *
   kernel/signal.c:4471:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/signal.c:4471:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/signal.c:4471:24: sparse:     got unsigned int *
--
>> kernel/profile.c:416:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   kernel/profile.c:416:21: sparse:     expected char [noderef] __user *__ptr_clean
   kernel/profile.c:416:21: sparse:     got char *
--
>> kernel/uid16.c:125:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:125:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:125:21: sparse:     got unsigned short *
   kernel/uid16.c:141:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:141:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:141:21: sparse:     got unsigned short *
   kernel/uid16.c:74:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:74:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:74:26: sparse:     got unsigned short *
   kernel/uid16.c:75:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:75:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:75:26: sparse:     got unsigned short *
   kernel/uid16.c:76:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:76:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:76:26: sparse:     got unsigned short *
   kernel/uid16.c:97:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:97:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:97:26: sparse:     got unsigned short *
   kernel/uid16.c:98:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:98:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:98:26: sparse:     got unsigned short *
   kernel/uid16.c:99:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   kernel/uid16.c:99:26: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   kernel/uid16.c:99:26: sparse:     got unsigned short *
--
>> kernel/compat.c:50:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/compat.c:50:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/compat.c:50:21: sparse:     got unsigned int *
   kernel/compat.c:74:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/compat.c:74:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/compat.c:74:21: sparse:     got unsigned int *
--
>> arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:196:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:197:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:198:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:208:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:209:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:210:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:211:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:327:23: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:328:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:329:24: sparse:     got unsigned int *
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   arch/x86/kernel/cpu/mtrr/if.c:330:24: sparse:     got unsigned int *
--
>> mm/mempolicy.c:1692:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   mm/mempolicy.c:1692:23: sparse:     expected int [noderef] __user *__ptr_clean
   mm/mempolicy.c:1692:23: sparse:     got int *
--
>> mm/migrate.c:1621:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   mm/migrate.c:1621:21: sparse:     expected int [noderef] __user *__ptr_clean
   mm/migrate.c:1621:21: sparse:     got int *
>> mm/migrate.c:1767:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void const [noderef] __user *[noderef] __user *__ptr_clean @@     got void const [noderef] __user ** @@
   mm/migrate.c:1767:21: sparse:     expected void const [noderef] __user *[noderef] __user *__ptr_clean
   mm/migrate.c:1767:21: sparse:     got void const [noderef] __user **
>> mm/migrate.c:1769:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int const [noderef] __user *__ptr_clean @@     got int const * @@
   mm/migrate.c:1769:21: sparse:     expected int const [noderef] __user *__ptr_clean
   mm/migrate.c:1769:21: sparse:     got int const *
>> mm/migrate.c:1891:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   mm/migrate.c:1891:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   mm/migrate.c:1891:21: sparse:     got unsigned int *
   mm/migrate.c:288:6: sparse: sparse: context imbalance in '__migration_entry_wait' - different lock contexts for basic block
   mm/migrate.c:750:9: sparse: sparse: context imbalance in '__buffer_migrate_folio' - different lock contexts for basic block
--
   fs/readdir.c:293:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   fs/readdir.c:293:21: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   fs/readdir.c:293:21: sparse:     got unsigned long *
   fs/readdir.c:377:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/readdir.c:377:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/readdir.c:377:21: sparse:     got signed long long *
>> fs/readdir.c:544:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/readdir.c:544:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/readdir.c:544:21: sparse:     got unsigned int *
--
   fs/compat_binfmt_elf.c: note: in included file:
>> fs/binfmt_elf.c:326:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:326:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:326:13: sparse:     got unsigned int *
   fs/binfmt_elf.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:333:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:333:21: sparse:     got unsigned int *
   fs/binfmt_elf.c:340:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:340:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:340:13: sparse:     got unsigned int *
   fs/binfmt_elf.c:348:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:348:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:348:21: sparse:     got unsigned int *
   fs/binfmt_elf.c:355:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   fs/binfmt_elf.c:355:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   fs/binfmt_elf.c:355:13: sparse:     got unsigned int *
--
   fs/read_write.c:1291:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1291:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1291:21: sparse:     got long *
   fs/read_write.c:1295:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   fs/read_write.c:1295:21: sparse:     expected long [noderef] __user *__ptr_clean
   fs/read_write.c:1295:21: sparse:     got long *
   fs/read_write.c:1312:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long long [noderef] __user *__ptr_clean @@     got long long * @@
   fs/read_write.c:1312:21: sparse:     expected long long [noderef] __user *__ptr_clean
   fs/read_write.c:1312:21: sparse:     got long long *
>> fs/read_write.c:1329:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/read_write.c:1329:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/read_write.c:1329:21: sparse:     got signed int *
   fs/read_write.c:1333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/read_write.c:1333:21: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/read_write.c:1333:21: sparse:     got signed int *
>> fs/read_write.c:1351:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long long [noderef] __user *__ptr_clean @@     got signed long long * @@
   fs/read_write.c:1351:21: sparse:     expected signed long long [noderef] __user *__ptr_clean
   fs/read_write.c:1351:21: sparse:     got signed long long *
--
>> fs/exec.c:414:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int const [noderef] __user *__ptr_clean @@     got unsigned int const * @@
   fs/exec.c:414:21: sparse:     expected unsigned int const [noderef] __user *__ptr_clean
   fs/exec.c:414:21: sparse:     got unsigned int const *
   fs/exec.c:415:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:415:39: sparse:     expected char const [noderef] __user *
   fs/exec.c:415:39: sparse:     got void *
   fs/exec.c:421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *const [noderef] __user *__ptr_clean @@     got char const [noderef] __user *const * @@
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
>> fs/btrfs/ioctl.c:464:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   fs/btrfs/ioctl.c:464:16: sparse:     expected int [noderef] __user *__ptr_clean
   fs/btrfs/ioctl.c:464:16: sparse:     got int *
   fs/btrfs/ioctl.c:413:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_try_lock' - wrong count at exit
   fs/btrfs/ioctl.c:426:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_unlock' - unexpected unlock
--
>> drivers/char/mwave/3780i.c:499:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:499:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:499:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:541:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:541:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:541:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:580:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:580:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:580:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:629:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:629:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:629:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:631:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:631:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:631:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:674:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:674:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:674:20: sparse:     got unsigned short *
   drivers/char/mwave/3780i.c:676:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   drivers/char/mwave/3780i.c:676:20: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   drivers/char/mwave/3780i.c:676:20: sparse:     got unsigned short *
--
   block/ioctl.c:58:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:58:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:58:13: sparse:     got int *
   block/ioctl.c:58:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *[noderef] __user *__ptr_clean @@     got void [noderef] __user ** @@
   block/ioctl.c:58:39: sparse:     expected void [noderef] __user *[noderef] __user *__ptr_clean
   block/ioctl.c:58:39: sparse:     got void [noderef] __user **
>> block/ioctl.c:78:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   block/ioctl.c:78:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   block/ioctl.c:78:13: sparse:     got signed int *
   block/ioctl.c:78:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:78:39: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:78:39: sparse:     got unsigned int *
   block/ioctl.c:197:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   block/ioctl.c:197:16: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   block/ioctl.c:197:16: sparse:     got unsigned short *
   block/ioctl.c:202:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:202:16: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:202:16: sparse:     got int *
   block/ioctl.c:207:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:207:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:207:16: sparse:     got unsigned int *
   block/ioctl.c:212:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   block/ioctl.c:212:16: sparse:     expected long [noderef] __user *__ptr_clean
   block/ioctl.c:212:16: sparse:     got long *
   block/ioctl.c:217:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   block/ioctl.c:217:16: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   block/ioctl.c:217:16: sparse:     got unsigned long *
   block/ioctl.c:222:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   block/ioctl.c:222:16: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   block/ioctl.c:222:16: sparse:     got unsigned long long *
   block/ioctl.c:228:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   block/ioctl.c:228:16: sparse:     expected signed int [noderef] __user *__ptr_clean
   block/ioctl.c:228:16: sparse:     got signed int *
   block/ioctl.c:233:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:233:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:233:16: sparse:     got unsigned int *
   block/ioctl.c:365:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:365:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:365:13: sparse:     got int *
   block/ioctl.c:433:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   block/ioctl.c:433:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   block/ioctl.c:433:16: sparse:     got unsigned int *
   block/ioctl.c:451:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   block/ioctl.c:451:13: sparse:     expected int [noderef] __user *__ptr_clean
   block/ioctl.c:451:13: sparse:     got int *
--
   drivers/gpu/drm/drm_ioc32.c:228:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/drm_ioc32.c:228:24: sparse:    void *
   drivers/gpu/drm/drm_ioc32.c:228:24: sparse:    void [noderef] __user *
>> drivers/gpu/drm/drm_ioc32.c:245:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:245:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:245:13: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:247:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __user * @@
   drivers/gpu/drm/drm_ioc32.c:247:20: sparse:     expected void *handle
   drivers/gpu/drm/drm_ioc32.c:247:20: sparse:     got void [noderef] __user *
>> drivers/gpu/drm/drm_ioc32.c:414:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/gpu/drm/drm_ioc32.c:414:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:414:13: sparse:     got int *
   drivers/gpu/drm/drm_ioc32.c:477:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/gpu/drm/drm_ioc32.c:477:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:477:13: sparse:     got int *
   drivers/gpu/drm/drm_ioc32.c:478:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:478:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:478:16: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:520:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] handle @@     got void [noderef] __user * @@
   drivers/gpu/drm/drm_ioc32.c:520:24: sparse:     expected void *[assigned] handle
   drivers/gpu/drm/drm_ioc32.c:520:24: sparse:     got void [noderef] __user *
   drivers/gpu/drm/drm_ioc32.c:613:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/gpu/drm/drm_ioc32.c:613:13: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:613:13: sparse:     got int *
   drivers/gpu/drm/drm_ioc32.c:614:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/gpu/drm/drm_ioc32.c:614:16: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:614:16: sparse:     got int *
   drivers/gpu/drm/drm_ioc32.c:633:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:633:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:633:13: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:723:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:723:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:723:13: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:757:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:757:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:757:13: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:777:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:777:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:777:13: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:786:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:786:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:786:13: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:799:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:799:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:799:13: sparse:     got unsigned int *
   drivers/gpu/drm/drm_ioc32.c:903:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/gpu/drm/drm_ioc32.c:903:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/gpu/drm/drm_ioc32.c:903:13: sparse:     got unsigned int *
--
>> drivers/block/mtip32xx/mtip32xx.c:3115:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3115:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3115:21: sparse:     got unsigned int *
   drivers/block/mtip32xx/mtip32xx.c:3118:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3118:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3118:21: sparse:     got unsigned int *
   drivers/block/mtip32xx/mtip32xx.c:3131:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3131:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3131:21: sparse:     got unsigned int *
   drivers/block/mtip32xx/mtip32xx.c:3134:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3134:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3134:21: sparse:     got unsigned int *
--
   kernel/futex/core.c:648:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:648:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:648:13: sparse:     got unsigned int *
   kernel/futex/core.c:783:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   kernel/futex/core.c:783:13: sparse:     expected long [noderef] __user *__ptr_clean
   kernel/futex/core.c:783:13: sparse:     got long *
>> kernel/futex/core.c:878:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   kernel/futex/core.c:878:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   kernel/futex/core.c:878:13: sparse:     got signed int *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:750:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/core.c:750:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/core.c:750:13: sparse:     got unsigned long *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
   kernel/futex/core.c:844:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/core.c:844:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/core.c:844:13: sparse:     got unsigned int *
--
   kernel/futex/syscalls.c:75:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   kernel/futex/syscalls.c:75:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:75:13: sparse:     got unsigned long *
   kernel/futex/syscalls.c:77:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean @@     got struct robust_list_head [noderef] __user ** @@
   kernel/futex/syscalls.c:77:16: sparse:     expected struct robust_list_head [noderef] __user *[noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:77:16: sparse:     got struct robust_list_head [noderef] __user **
>> kernel/futex/syscalls.c:344:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/syscalls.c:344:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:344:13: sparse:     got unsigned int *
   kernel/futex/syscalls.c:346:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/futex/syscalls.c:346:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/futex/syscalls.c:346:16: sparse:     got unsigned int *
--
>> drivers/platform/x86/wmi.c:903:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/platform/x86/wmi.c:903:13: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/platform/x86/wmi.c:903:13: sparse:     got unsigned long long *

vim +2484 drivers/atm/nicstar.c

^1da177e4c3f41 Linus Torvalds             2005-04-16  2473  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2474  static int ns_ioctl(struct atm_dev *dev, unsigned int cmd, void __user * arg)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2475  {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2476  	ns_dev *card;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2477  	pool_levels pl;
69c3014763966b Alan Cox                   2006-10-20  2478  	long btype;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2479  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2480  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2481  	card = dev->dev_data;
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2482  	switch (cmd) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2483  	case NS_GETPSTAT:
098fde114bf665 chas williams - CONTRACTOR 2010-05-29 @2484  		if (get_user
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2485  		    (pl.buftype, &((pool_levels __user *) arg)->buftype))
^1da177e4c3f41 Linus Torvalds             2005-04-16  2486  			return -EFAULT;
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2487  		switch (pl.buftype) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2488  		case NS_BUFTYPE_SMALL:
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2489  			pl.count =
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2490  			    ns_stat_sfbqc_get(readl(card->membase + STAT));
^1da177e4c3f41 Linus Torvalds             2005-04-16  2491  			pl.level.min = card->sbnr.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2492  			pl.level.init = card->sbnr.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2493  			pl.level.max = card->sbnr.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2494  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2495  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2496  		case NS_BUFTYPE_LARGE:
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2497  			pl.count =
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2498  			    ns_stat_lfbqc_get(readl(card->membase + STAT));
^1da177e4c3f41 Linus Torvalds             2005-04-16  2499  			pl.level.min = card->lbnr.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2500  			pl.level.init = card->lbnr.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2501  			pl.level.max = card->lbnr.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2502  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2503  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2504  		case NS_BUFTYPE_HUGE:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2505  			pl.count = card->hbpool.count;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2506  			pl.level.min = card->hbnr.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2507  			pl.level.init = card->hbnr.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2508  			pl.level.max = card->hbnr.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2509  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2510  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2511  		case NS_BUFTYPE_IOVEC:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2512  			pl.count = card->iovpool.count;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2513  			pl.level.min = card->iovnr.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2514  			pl.level.init = card->iovnr.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2515  			pl.level.max = card->iovnr.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2516  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2517  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2518  		default:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2519  			return -ENOIOCTLCMD;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2520  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2521  		}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2522  		if (!copy_to_user((pool_levels __user *) arg, &pl, sizeof(pl)))
^1da177e4c3f41 Linus Torvalds             2005-04-16  2523  			return (sizeof(pl));
^1da177e4c3f41 Linus Torvalds             2005-04-16  2524  		else
^1da177e4c3f41 Linus Torvalds             2005-04-16  2525  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2526  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2527  	case NS_SETBUFLEV:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2528  		if (!capable(CAP_NET_ADMIN))
^1da177e4c3f41 Linus Torvalds             2005-04-16  2529  			return -EPERM;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2530  		if (copy_from_user(&pl, (pool_levels __user *) arg, sizeof(pl)))
^1da177e4c3f41 Linus Torvalds             2005-04-16  2531  			return -EFAULT;
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2532  		if (pl.level.min >= pl.level.init
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2533  		    || pl.level.init >= pl.level.max)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2534  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2535  		if (pl.level.min == 0)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2536  			return -EINVAL;
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2537  		switch (pl.buftype) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2538  		case NS_BUFTYPE_SMALL:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2539  			if (pl.level.max > TOP_SB)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2540  				return -EINVAL;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2541  			card->sbnr.min = pl.level.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2542  			card->sbnr.init = pl.level.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2543  			card->sbnr.max = pl.level.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2544  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2545  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2546  		case NS_BUFTYPE_LARGE:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2547  			if (pl.level.max > TOP_LB)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2548  				return -EINVAL;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2549  			card->lbnr.min = pl.level.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2550  			card->lbnr.init = pl.level.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2551  			card->lbnr.max = pl.level.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2552  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2553  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2554  		case NS_BUFTYPE_HUGE:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2555  			if (pl.level.max > TOP_HB)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2556  				return -EINVAL;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2557  			card->hbnr.min = pl.level.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2558  			card->hbnr.init = pl.level.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2559  			card->hbnr.max = pl.level.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2560  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2561  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2562  		case NS_BUFTYPE_IOVEC:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2563  			if (pl.level.max > TOP_IOVB)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2564  				return -EINVAL;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2565  			card->iovnr.min = pl.level.min;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2566  			card->iovnr.init = pl.level.init;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2567  			card->iovnr.max = pl.level.max;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2568  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2569  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2570  		default:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2571  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2572  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2573  		}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2574  		return 0;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2575  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2576  	case NS_ADJBUFLEV:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2577  		if (!capable(CAP_NET_ADMIN))
^1da177e4c3f41 Linus Torvalds             2005-04-16  2578  			return -EPERM;
69c3014763966b Alan Cox                   2006-10-20  2579  		btype = (long)arg;	/* a long is the same size as a pointer or bigger */
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2580  		switch (btype) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2581  		case NS_BUFTYPE_SMALL:
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2582  			while (card->sbfqc < card->sbnr.init) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2583  				struct sk_buff *sb;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2584  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2585  				sb = __dev_alloc_skb(NS_SMSKBSIZE, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2586  				if (sb == NULL)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2587  					return -ENOMEM;
864a3ff635fa73 chas williams - CONTRACTOR 2010-05-29  2588  				NS_PRV_BUFTYPE(sb) = BUF_SM;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2589  				skb_queue_tail(&card->sbpool.queue, sb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2590  				skb_reserve(sb, NS_AAL0_HEADER);
8728b834b226ff David S. Miller            2005-08-09  2591  				push_rxbufs(card, sb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2592  			}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2593  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2594  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2595  		case NS_BUFTYPE_LARGE:
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2596  			while (card->lbfqc < card->lbnr.init) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2597  				struct sk_buff *lb;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2598  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2599  				lb = __dev_alloc_skb(NS_LGSKBSIZE, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2600  				if (lb == NULL)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2601  					return -ENOMEM;
864a3ff635fa73 chas williams - CONTRACTOR 2010-05-29  2602  				NS_PRV_BUFTYPE(lb) = BUF_LG;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2603  				skb_queue_tail(&card->lbpool.queue, lb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2604  				skb_reserve(lb, NS_SMBUFSIZE);
8728b834b226ff David S. Miller            2005-08-09  2605  				push_rxbufs(card, lb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2606  			}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2607  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2608  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2609  		case NS_BUFTYPE_HUGE:
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2610  			while (card->hbpool.count > card->hbnr.init) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2611  				struct sk_buff *hb;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2612  
36ef408061da9e Mark Asselstine            2008-04-19  2613  				spin_lock_irqsave(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2614  				hb = skb_dequeue(&card->hbpool.queue);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2615  				card->hbpool.count--;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2616  				spin_unlock_irqrestore(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2617  				if (hb == NULL)
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2618  					printk
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2619  					    ("nicstar%d: huge buffer count inconsistent.\n",
^1da177e4c3f41 Linus Torvalds             2005-04-16  2620  					     card->index);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2621  				else
^1da177e4c3f41 Linus Torvalds             2005-04-16  2622  					dev_kfree_skb_any(hb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2623  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2624  			}
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2625  			while (card->hbpool.count < card->hbnr.init) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2626  				struct sk_buff *hb;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2627  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2628  				hb = __dev_alloc_skb(NS_HBUFSIZE, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2629  				if (hb == NULL)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2630  					return -ENOMEM;
864a3ff635fa73 chas williams - CONTRACTOR 2010-05-29  2631  				NS_PRV_BUFTYPE(hb) = BUF_NONE;
36ef408061da9e Mark Asselstine            2008-04-19  2632  				spin_lock_irqsave(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2633  				skb_queue_tail(&card->hbpool.queue, hb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2634  				card->hbpool.count++;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2635  				spin_unlock_irqrestore(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2636  			}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2637  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2638  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2639  		case NS_BUFTYPE_IOVEC:
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2640  			while (card->iovpool.count > card->iovnr.init) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2641  				struct sk_buff *iovb;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2642  
36ef408061da9e Mark Asselstine            2008-04-19  2643  				spin_lock_irqsave(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2644  				iovb = skb_dequeue(&card->iovpool.queue);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2645  				card->iovpool.count--;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2646  				spin_unlock_irqrestore(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2647  				if (iovb == NULL)
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2648  					printk
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2649  					    ("nicstar%d: iovec buffer count inconsistent.\n",
^1da177e4c3f41 Linus Torvalds             2005-04-16  2650  					     card->index);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2651  				else
^1da177e4c3f41 Linus Torvalds             2005-04-16  2652  					dev_kfree_skb_any(iovb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2653  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2654  			}
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2655  			while (card->iovpool.count < card->iovnr.init) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2656  				struct sk_buff *iovb;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2657  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2658  				iovb = alloc_skb(NS_IOVBUFSIZE, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2659  				if (iovb == NULL)
^1da177e4c3f41 Linus Torvalds             2005-04-16  2660  					return -ENOMEM;
864a3ff635fa73 chas williams - CONTRACTOR 2010-05-29  2661  				NS_PRV_BUFTYPE(iovb) = BUF_NONE;
36ef408061da9e Mark Asselstine            2008-04-19  2662  				spin_lock_irqsave(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2663  				skb_queue_tail(&card->iovpool.queue, iovb);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2664  				card->iovpool.count++;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2665  				spin_unlock_irqrestore(&card->int_lock, flags);
^1da177e4c3f41 Linus Torvalds             2005-04-16  2666  			}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2667  			break;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2668  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2669  		default:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2670  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2671  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2672  		}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2673  		return 0;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2674  
^1da177e4c3f41 Linus Torvalds             2005-04-16  2675  	default:
^1da177e4c3f41 Linus Torvalds             2005-04-16  2676  		if (dev->phy && dev->phy->ioctl) {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2677  			return dev->phy->ioctl(dev, cmd, arg);
098fde114bf665 chas williams - CONTRACTOR 2010-05-29  2678  		} else {
^1da177e4c3f41 Linus Torvalds             2005-04-16  2679  			printk("nicstar%d: %s == NULL \n", card->index,
^1da177e4c3f41 Linus Torvalds             2005-04-16  2680  			       dev->phy ? "dev->phy->ioctl" : "dev->phy");
^1da177e4c3f41 Linus Torvalds             2005-04-16  2681  			return -ENOIOCTLCMD;
^1da177e4c3f41 Linus Torvalds             2005-04-16  2682  		}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2683  	}
^1da177e4c3f41 Linus Torvalds             2005-04-16  2684  }
^1da177e4c3f41 Linus Torvalds             2005-04-16  2685  

:::::: The code at line 2484 was first introduced by commit
:::::: 098fde114bf6655f4b75d71dbea208d039fc1de3 atm: [nicstar] reformatted with Lindent

:::::: TO: chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
